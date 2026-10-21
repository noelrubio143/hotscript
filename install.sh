#!/bin/bash
set -e

# Must be root
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root."
   exit 1
fi

echo "Installing Hotscript Manager..."

# ---------------------------------------------------------------
# Ensure dependencies (bc jq curl wget) BEFORE running the menu
# Shows real errors and auto-recovers from common apt problems
# ---------------------------------------------------------------

# Fix grub-pc stuck/half-configured (BIOS boot): point it at the root disk
fix_grub_pc() {
    dpkg -s grub-pc >/dev/null 2>&1 || return 0
    [ -d /sys/firmware/efi ] && return 0

    local cur dev bad=0 src pk disk
    cur=$(debconf-show grub-pc 2>/dev/null | awk -F': ' '/grub-pc\/install_devices:/{print $2}')
    if [ -z "${cur// /}" ]; then
        bad=1
    else
        IFS=',' read -ra _devs <<< "$cur"
        for dev in "${_devs[@]}"; do
            dev="${dev// /}"
            [ -e "$dev" ] || bad=1
        done
    fi
    (( bad == 1 )) || return 0

    src=$(findmnt -n -o SOURCE / 2>/dev/null)
    pk=$(lsblk -no PKNAME "$src" 2>/dev/null | head -n1)
    [ -n "$pk" ] && disk="/dev/$pk" || disk="$src"
    if [ ! -b "$disk" ]; then
        echo "Warning: could not detect boot disk for GRUB; skipping grub fix."
        return 0
    fi

    echo "Fixing grub-pc install device -> $disk"
    echo "grub-pc grub-pc/install_devices multiselect $disk" | debconf-set-selections
    echo "grub-pc grub-pc/install_devices_empty boolean false" | debconf-set-selections
}


# Detect a stuck apt/dpkg (waiting on a prompt with no progress) and clear it
APT_PAT='apt|apt-get|dpkg|aptitude'

kill_stuck_apt() {
    local pids pid ppid pcmd killlist=() anc=() p
    pids=$(pgrep -x "$APT_PAT" 2>/dev/null)
    [ -z "$pids" ] && return 0

    # our own ancestors must never be killed
    p=$$; while [ "${p:-0}" -gt 1 ]; do anc+=("$p"); p=$(ps -o ppid= -p "$p" 2>/dev/null | tr -d ' '); done

    for pid in $pids; do
        killlist+=("$pid")
        ppid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
        [ -z "$ppid" ] || [ "$ppid" -le 1 ] && continue
        [[ " ${anc[*]} " == *" $ppid "* ]] && continue
        pcmd=$(tr '\0' ' ' < "/proc/$ppid/cmdline" 2>/dev/null)
        # parent is a plain shell script (e.g. a provider/first-boot script) -> stop it too
        if [[ "$pcmd" =~ ^(/bin/|/usr/bin/)?bash\ / ]]; then
            killlist+=("$ppid")
        fi
    done

    echo "Stuck apt/dpkg detected. Stopping: ${killlist[*]}"
    kill "${killlist[@]}" 2>/dev/null
    sleep 3
    for pid in "${killlist[@]}"; do kill -0 "$pid" 2>/dev/null && kill -9 "$pid" 2>/dev/null; done
    sleep 1
}

wait_for_apt() {
    pgrep -x "$APT_PAT" >/dev/null 2>&1 || return 0
    echo "Another apt/dpkg process is running. Waiting (it will be cleared if stuck)..."

    local last="" cur same=0 total=0 prompt
    while pgrep -x "$APT_PAT" >/dev/null 2>&1; do
        cur="$(stat -c '%Y:%s' /var/log/apt/term.log 2>/dev/null)|$(stat -c '%Y' /var/lib/dpkg/status 2>/dev/null)"
        if [ "$cur" = "$last" ]; then same=$((same + 5)); else same=0; last="$cur"; fi

        prompt=0
        tail -n 20 /var/log/apt/term.log 2>/dev/null | grep -qE '\[yes/no\]|GRUB install devices|Configuration file|What do you want to do|Y/I/N/O/D/Z' && prompt=1

        if { (( prompt == 1 )) && (( same >= 30 )); } || (( same >= 300 )); then
            kill_stuck_apt
            return 0
        fi
        (( total += 5 ))
        (( total >= 1800 )) && { echo "Error: apt/dpkg busy for 30 min."; return 1; }
        sleep 5
    done
}

ensure_dependencies() {
    local missing=() cmd
    for cmd in bc jq curl wget iptables; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done
    (( ${#missing[@]} == 0 )) && return 0

    echo "Installing missing dependencies: ${missing[*]}"

    if command -v apt-get >/dev/null 2>&1; then
        export DEBIAN_FRONTEND=noninteractive

        wait_for_apt || return 1
        local APT_OPTS=(-o DPkg::Lock::Timeout=300)

        # Disable dead CD-ROM repo lines
        sed -i 's/^deb cdrom:/# deb cdrom:/' /etc/apt/sources.list 2>/dev/null || true

        # Repair interrupted installs (fix grub-pc device first so it doesn't prompt/fail)
        fix_grub_pc
        local DPKG_OPTS=(-o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-confdef)
        dpkg --configure -a --force-confold || true
        apt-get "${APT_OPTS[@]}" "${DPKG_OPTS[@]}" -f install -y || true

        # Update (retry with IPv4 only if it fails)
        if ! apt-get "${APT_OPTS[@]}" update; then
            echo "apt-get "${APT_OPTS[@]}" update failed, retrying with IPv4 only..."
            echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4
            apt-get "${APT_OPTS[@]}" update || echo "Warning: apt-get "${APT_OPTS[@]}" update still failing (check your repos)."
        fi

        apt-get "${APT_OPTS[@]}" "${DPKG_OPTS[@]}" install -y "${missing[@]}" || {
            echo "Error: could not install: ${missing[*]}"
            echo "Check the apt error above (repos / DNS / dpkg)."
            return 1
        }
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y "${missing[@]}" || return 1
    elif command -v yum >/dev/null 2>&1; then
        yum install -y "${missing[@]}" || return 1
    elif command -v zypper >/dev/null 2>&1; then
        zypper install -y "${missing[@]}" || return 1
    elif command -v pacman >/dev/null 2>&1; then
        pacman -S --noconfirm --needed "${missing[@]}" || return 1
    else
        echo "Error: unsupported package manager. Install manually: ${missing[*]}"
        return 1
    fi

    for cmd in "${missing[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || { echo "Error: $cmd still missing."; return 1; }
    done
}

ensure_dependencies || exit 1

# Persist iptables rules across reboots (needed by slipstream DNS redirect)
ensure_persistence() {
    command -v apt-get >/dev/null 2>&1 || return 0
    dpkg -s iptables-persistent >/dev/null 2>&1 && return 0
    echo "iptables-persistent iptables-persistent/autosave_v4 boolean false" | debconf-set-selections
    echo "iptables-persistent iptables-persistent/autosave_v6 boolean false" | debconf-set-selections
    DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::Lock::Timeout=300 install -y iptables-persistent \
        || echo "Warning: could not install iptables-persistent (rules may not survive reboot)."
}
ensure_persistence


# URLs (IPv4 forced to avoid GitHub IPv6 issues)
MENU_URL="https://raw.githubusercontent.com/noelrubio143/hotscript/main/menu.sh"
SSHD_URL="https://raw.githubusercontent.com/noelrubio143/hotscript/main/ssh"

# Helper to download files (supports both curl and wget)
download_file() {
    local dest=$1
    local url=$2
    if command -v curl &> /dev/null; then
        curl -sL -o "$dest" "$url"
    elif command -v wget &> /dev/null; then
        wget -q -O "$dest" "$url"
    else
        echo "Error: Neither curl nor wget is installed."
        exit 1
    fi
}

# Use local files if install.sh is run from the unzipped folder, else download
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
fetch_or_copy() {
    local dest=$1 url=$2 name=$3
    if [ -f "$SCRIPT_DIR/$name" ]; then
        cp "$SCRIPT_DIR/$name" "$dest"
    else
        download_file "$dest" "$url"
    fi
}

# Install menu
fetch_or_copy /usr/local/bin/menu "$MENU_URL" menu.sh
[ -s /usr/local/bin/menu ] || { echo "Error: failed to get menu.sh"; exit 1; }
chmod +x /usr/local/bin/menu

echo "Applying Hotscript SSH configuration..."

SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP="/etc/ssh/sshd_config.backup.$(date +%F-%H%M%S)"

# Backup current SSH config
cp "$SSHD_CONFIG" "$BACKUP"

# Download Hotscript SSH config
fetch_or_copy "$SSHD_CONFIG" "$SSHD_URL" ssh
chmod 600 "$SSHD_CONFIG"

# Validate SSH config (silent)
if ! sshd -t 2>/dev/null; then
    echo "ERROR: SSH configuration is invalid!"
    echo "Restoring previous configuration..."
    cp "$BACKUP" "$SSHD_CONFIG"
    exit 1
fi

echo "SSH configuration validated."

# Restart SSH quietly and safely
restart_ssh() {
    if command -v systemctl >/dev/null 2>&1; then
        systemctl restart sshd 2>/dev/null \
        || systemctl restart ssh 2>/dev/null \
        || return 1
    elif command -v service >/dev/null 2>&1; then
        service sshd restart 2>/dev/null \
        || service ssh restart 2>/dev/null \
        || return 1
    elif command -v rc-service >/dev/null 2>&1; then
        rc-service sshd restart 2>/dev/null \
        || rc-service ssh restart 2>/dev/null \
        || return 1
    elif [ -x /etc/init.d/sshd ]; then
        /etc/init.d/sshd restart >/dev/null 2>&1
    elif [ -x /etc/init.d/ssh ]; then
        /etc/init.d/ssh restart >/dev/null 2>&1
    else
        return 1
    fi
}

if restart_ssh; then
    echo "SSH service restarted."
else
    echo "WARNING: SSH restart not supported on this system."
    echo "SSH config applied but service was not restarted automatically."
fi

# Run Hotscript setup
bash /usr/local/bin/menu --install-setup

echo "Installation complete!"
echo "Type 'menu' to start."
