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
ensure_dependencies() {
    local missing=() cmd
    for cmd in bc jq curl wget; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done
    (( ${#missing[@]} == 0 )) && return 0

    echo "Installing missing dependencies: ${missing[*]}"

    if command -v apt-get >/dev/null 2>&1; then
        export DEBIAN_FRONTEND=noninteractive

        # Wait for other apt/dpkg processes (works even without fuser/lsof)
        local i=0
        while [ -n "$(pgrep -x 'apt|apt-get|dpkg|unattended-upgr|aptitude' 2>/dev/null)" ]; do
            (( i++ >= 36 )) && {
                echo "Error: apt/dpkg still busy after 3 min. Check: ps aux | grep -E 'apt|dpkg'"
                return 1
            }
            echo "Waiting for other apt/dpkg process to finish..."; sleep 5
        done
        local APT_OPTS=(-o DPkg::Lock::Timeout=300)

        # Disable dead CD-ROM repo lines
        sed -i 's/^deb cdrom:/# deb cdrom:/' /etc/apt/sources.list 2>/dev/null || true

        # Repair interrupted installs
        dpkg --configure -a || true
        apt-get "${APT_OPTS[@]}" -f install -y || true

        # Update (retry with IPv4 only if it fails)
        if ! apt-get "${APT_OPTS[@]}" update; then
            echo "apt-get "${APT_OPTS[@]}" update failed, retrying with IPv4 only..."
            echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4
            apt-get "${APT_OPTS[@]}" update || echo "Warning: apt-get "${APT_OPTS[@]}" update still failing (check your repos)."
        fi

        apt-get "${APT_OPTS[@]}" install -y "${missing[@]}" || {
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

# Install menu
download_file /usr/local/bin/menu "$MENU_URL"
chmod +x /usr/local/bin/menu

echo "Applying Hotscript SSH configuration..."

SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP="/etc/ssh/sshd_config.backup.$(date +%F-%H%M%S)"

# Backup current SSH config
cp "$SSHD_CONFIG" "$BACKUP"

# Download Hotscript SSH config
download_file "$SSHD_CONFIG" "$SSHD_URL"
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
