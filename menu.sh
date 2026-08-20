#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

C_RESET=$'\033[0m'
C_BOLD=$'\033[1m'
C_DIM=$'\033[2m'
C_UL=$'\033[4m'

# Premium Color Palette
C_RED=$'\033[38;5;196m'      # Bright Red
C_GREEN=$'\033[38;5;46m'     # Neon Green
C_YELLOW=$'\033[38;5;226m'   # Bright Yellow
C_BLUE=$'\033[38;5;39m'      # Deep Sky Blue
C_PURPLE=$'\033[38;5;135m'   # Light Purple
C_CYAN=$'\033[38;5;51m'      # Cyan
C_WHITE=$'\033[38;5;255m'    # Bright White
C_GRAY=$'\033[38;5;245m'     # Gray
C_ORANGE=$'\033[38;5;208m'   # Orange

# Semantic Aliases
C_TITLE=$C_PURPLE
C_CHOICE=$C_CYAN
C_PROMPT=$C_BLUE
C_WARN=$C_YELLOW
C_DANGER=$C_RED
C_STATUS_A=$C_GREEN
C_STATUS_I=$C_GRAY
C_ACCENT=$C_ORANGE

DB_DIR="/etc/firewallfalcon"
DB_FILE="$DB_DIR/users.db"
INSTALL_FLAG_FILE="$DB_DIR/.install"
BADVPN_SERVICE_FILE="/etc/systemd/system/badvpn.service"
BADVPN_BUILD_DIR="/root/badvpn-build"
HAPROXY_CONFIG="/etc/haproxy/haproxy.cfg"
NGINX_CONFIG_FILE="/etc/nginx/sites-available/default"
SSL_CERT_DIR="/etc/firewallfalcon/ssl"
SSL_CERT_FILE="$SSL_CERT_DIR/firewallfalcon.pem"
SSL_CERT_CHAIN_FILE="$SSL_CERT_DIR/firewallfalcon.crt"
SSL_CERT_KEY_FILE="$SSL_CERT_DIR/firewallfalcon.key"
HAPROXY_LOCAL_CERT_FILE="/etc/haproxy/firewallfalcon.pem"
EDGE_CERT_INFO_FILE="$DB_DIR/edge_cert.conf"
NGINX_PORTS_FILE="$DB_DIR/nginx_ports.conf"
EDGE_PUBLIC_HTTP_PORT="80"
EDGE_PUBLIC_TLS_PORT="443"
NGINX_INTERNAL_HTTP_PORT="8880"
NGINX_INTERNAL_TLS_PORT="8443"
HAPROXY_INTERNAL_DECRYPT_PORT="10443"
DNSTT_SERVICE_FILE="/etc/systemd/system/dnstt.service"
DNSTT_BINARY="/usr/local/bin/dnstt-server"
DNSTT_KEYS_DIR="/etc/firewallfalcon/dnstt"
DNSTT_CONFIG_FILE="$DB_DIR/dnstt_info.conf"
# --- dnstt-deploy (bugfloyd/dnstt-deploy) replacement for the built-in DNSTT installer ---
DNSTT_V2_SCRIPT="/usr/local/bin/dnstt-deploy"
DNSTT_V2_SERVICE_FILE="/etc/systemd/system/dnstt-server.service"
DNSTT_V2_CONFIG_DIR="/etc/dnstt"
DNSTT_V2_CONFIG_FILE="/etc/dnstt/dnstt-server.conf"
DNSTT_V2_USER="dnstt"
# --- slipstream-rust-deploy (DNS tunnel, redirected from public port 53 to internal port 5301 to avoid clashing with dnstt-deploy's 5300) ---
SLIPSTREAM_V2_SCRIPT="/usr/local/bin/slipstream-rust-deploy"
SLIPSTREAM_V2_SERVICE_FILE="/etc/systemd/system/slipstream-rust-server.service"
SLIPSTREAM_V2_CONFIG_DIR="/etc/slipstream-rust"
SLIPSTREAM_V2_BUILD_DIR="/opt/slipstream-rust"
SLIPSTREAM_V2_USER="slipstream"
SLIPSTREAM_BINARY="/usr/local/bin/slipstream-server"
DNS_INFO_FILE="$DB_DIR/dns_info.conf"
UDP_CUSTOM_DIR="/root/udp"
UDP_CUSTOM_SERVICE_FILE="/etc/systemd/system/udp-custom.service"
UDPGW_BINARY="/usr/local/bin/udpgw"
UDPGW_SERVICE_FILE="/etc/systemd/system/udpgw.service"
SSH_BANNER_FILE="/etc/bannerssh"
FALCONPROXY_SERVICE_FILE="/etc/systemd/system/falconproxy.service"
FALCONPROXY_BINARY="/usr/local/bin/falconproxy"
FALCONPROXY_CONFIG_FILE="$DB_DIR/falconproxy_config.conf"
LIMITER_SCRIPT="/usr/local/bin/firewallfalcon-limiter.sh"
LIMITER_SERVICE="/etc/systemd/system/firewallfalcon-limiter.service"
BANDWIDTH_DIR="$DB_DIR/bandwidth"
BANDWIDTH_SCRIPT="/usr/local/bin/firewallfalcon-bandwidth.sh"
BANDWIDTH_SERVICE="/etc/systemd/system/firewallfalcon-bandwidth.service"
LEGACY_BANDWIDTH_DIR="/usr/local/bin/firewallfalcon-bandwidth"
TRIAL_CLEANUP_SCRIPT="/usr/local/bin/firewallfalcon-trial-cleanup.sh"
LOGIN_INFO_SCRIPT="/usr/local/bin/firewallfalcon-login-info.sh"
SSHD_FF_CONFIG="/etc/ssh/sshd_config.d/firewallfalcon.conf"

# --- Web Panel Variables ---
PANEL_SCRIPT="/usr/local/bin/firewallfalcon-panel.py"
PANEL_HTML_DIR="$DB_DIR/panel"
PANEL_HTML_FILE="$DB_DIR/panel/index.html"
PANEL_CONF="$DB_DIR/panel.conf"
PANEL_SERVICE_FILE="/etc/systemd/system/firewallfalcon-panel.service"
PANEL_PORT=44380
PANEL_REPO_BASE="https://raw.githubusercontent.com/noelrubio143/hotscript/main/panel"

# --- ZiVPN Variables ---
ZIVPN_DIR="/etc/zivpn"
ZIVPN_BIN="/usr/local/bin/zivpn"
ZIVPN_SERVICE_FILE="/etc/systemd/system/zivpn.service"
ZIVPN_CONFIG_FILE="$ZIVPN_DIR/config.json"
ZIVPN_CERT_FILE="$ZIVPN_DIR/zivpn.crt"
ZIVPN_KEY_FILE="$ZIVPN_DIR/zivpn.key"

# --- WS-Dropbear (WebSocket -> SSH/Dropbear) Variables ---
WS_DROPBEAR_SCRIPT="/usr/local/bin/ws-dropbear.py"
WS_DROPBEAR_SERVICE_FILE="/etc/systemd/system/ws-dropbear.service"
WS_DROPBEAR_CONFIG_FILE="$DB_DIR/ws_dropbear.conf"

DESEC_TOKEN="V55cFY8zTictLCPfviiuX5DHjs15"
DESEC_DOMAIN="manager.firewallfalcon.qzz.io"

SELECTED_USER=""
UNINSTALL_MODE="interactive"
BANNER_CACHE_TTL=15
BANNER_CACHE_TS=0
BANNER_CACHE_OS_NAME=""
BANNER_CACHE_UP_TIME=""
BANNER_CACHE_RAM_USAGE=""
BANNER_CACHE_CPU_LOAD=""
BANNER_CACHE_ONLINE_USERS=0
BANNER_CACHE_TOTAL_USERS=0
SSH_SESSION_CACHE_TTL=10
SSH_SESSION_CACHE_TS=0
SSH_SESSION_CACHE_DB_MTIME=0
SSH_SESSION_TOTAL=0
APT_CACHE_READY=0
FF_USERS_GROUP="ffusers"
declare -A SSH_SESSION_COUNTS=()
declare -A SSH_SESSION_PIDS=()

# --- Package Manager Abstraction ---
FF_PKG_MGR=""
_detect_pkg_manager() {
    if command -v apt-get &>/dev/null; then
        FF_PKG_MGR="apt"
    elif command -v dnf &>/dev/null; then
        FF_PKG_MGR="dnf"
    elif command -v yum &>/dev/null; then
        FF_PKG_MGR="yum"
    elif command -v zypper &>/dev/null; then
        FF_PKG_MGR="zypper"
    elif command -v pacman &>/dev/null; then
        FF_PKG_MGR="pacman"
    else
        echo -e "${C_RED}❌ No supported package manager found (apt/dnf/yum/zypper/pacman).${C_RESET}"
        exit 1
    fi
}
_detect_pkg_manager

_map_pkg_names() {
    local -a result=()
    local pkg
    for pkg in "$@"; do
        case "$FF_PKG_MGR" in
            dnf|yum)
                case "$pkg" in
                    build-essential) result+=(gcc gcc-c++ make) ;;
                    libssl-dev) result+=(openssl-devel) ;;
                    libnspr4-dev) result+=(nspr-devel) ;;
                    libnss3-dev) result+=(nss-devel) ;;
                    nginx-common) result+=(nginx) ;;
                    pkg-config) result+=(pkgconf) ;;
                    *) result+=("$pkg") ;;
                esac ;;
            zypper)
                case "$pkg" in
                    build-essential) result+=(gcc gcc-c++ make) ;;
                    libssl-dev) result+=(libopenssl-devel) ;;
                    libnspr4-dev) result+=(mozilla-nspr-devel) ;;
                    libnss3-dev) result+=(mozilla-nss-devel) ;;
                    nginx-common) result+=(nginx) ;;
                    *) result+=("$pkg") ;;
                esac ;;
            pacman)
                case "$pkg" in
                    build-essential) result+=(base-devel) ;;
                    libssl-dev) result+=(openssl) ;;
                    libnspr4-dev) result+=(nspr) ;;
                    libnss3-dev) result+=(nss) ;;
                    nginx-common) result+=(nginx) ;;
                    bc) result+=(bc) ;;
                    *) result+=("$pkg") ;;
                esac ;;
            *) result+=("$pkg") ;;
        esac
    done
    printf '%s\n' "${result[@]}"
}

if [[ $EUID -ne 0 ]]; then
   echo -e "${C_RED}❌ Error: This script requires root privileges to run.${C_RESET}"
   exit 1
fi

get_ubuntu_codename() {
    local codename=""

    if [[ -r /etc/os-release ]]; then
        codename=$(awk -F= '/^(VERSION_CODENAME|UBUNTU_CODENAME)=/{gsub(/"/, "", $2); if ($2 != "") { print $2; exit }}' /etc/os-release 2>/dev/null)
    fi

    if [[ -z "$codename" ]] && command -v lsb_release &>/dev/null; then
        codename=$(lsb_release -sc 2>/dev/null)
    fi

    echo "$codename"
}

is_known_eol_ubuntu_codename() {
    case "$1" in
        yakkety|zesty|artful|cosmic|disco|eoan|groovy|hirsute|impish|kinetic|lunar|mantic|oracular|plucky)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

rewrite_ubuntu_apt_sources() {
    local mode="$1"
    local os_id=""
    local changed=false
    local file backup_file
    local from_archive to_archive from_security to_security from_ports to_ports
    local -a source_files=("/etc/apt/sources.list" /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources)

    if [[ -r /etc/os-release ]]; then
        os_id=$(awk -F= '/^ID=/{gsub(/"/, "", $2); print $2; exit}' /etc/os-release 2>/dev/null)
    fi
    [[ "$os_id" == "ubuntu" ]] || return 1

    case "$mode" in
        primary)
            from_archive='https?://([A-Za-z0-9-]+\.)?archive\.ubuntu\.com/ubuntu'
            to_archive='http://archive.ubuntu.com/ubuntu'
            from_security='https?://security\.ubuntu\.com/ubuntu'
            to_security='http://security.ubuntu.com/ubuntu'
            from_ports='https?://ports\.ubuntu\.com/ubuntu-ports'
            to_ports='http://ports.ubuntu.com/ubuntu-ports'
            ;;
        old-releases)
            from_archive='https?://([A-Za-z0-9-]+\.)?archive\.ubuntu\.com/ubuntu'
            to_archive='http://old-releases.ubuntu.com/ubuntu'
            from_security='https?://security\.ubuntu\.com/ubuntu'
            to_security='http://old-releases.ubuntu.com/ubuntu'
            from_ports='https?://ports\.ubuntu\.com/ubuntu-ports'
            to_ports='http://old-releases.ubuntu.com/ubuntu'
            ;;
        *)
            return 1
            ;;
    esac

    for file in "${source_files[@]}"; do
        [[ -f "$file" ]] || continue
        if grep -Eq "$from_archive|$from_security|$from_ports" "$file" 2>/dev/null; then
            backup_file="${file}.bak.firewallfalcon"
            [[ -f "$backup_file" ]] || cp "$file" "$backup_file" 2>/dev/null || true
            sed -i -E \
                -e "s|$from_archive|$to_archive|g" \
                -e "s|$from_security|$to_security|g" \
                -e "s|$from_ports|$to_ports|g" \
                "$file" 2>/dev/null
            changed=true
        fi
    done

    $changed
}

repair_ubuntu_apt_mirrors() {
    rewrite_ubuntu_apt_sources "primary"
}

switch_ubuntu_to_old_releases() {
    local codename
    codename=$(get_ubuntu_codename)
    [[ -n "$codename" ]] || return 1
    is_known_eol_ubuntu_codename "$codename" || return 1
    rewrite_ubuntu_apt_sources "old-releases"
}

ff_apt_update() {
    local -a apt_opts=(
        -o Acquire::Retries=3
        -o Acquire::ForceIPv4=true
        -o Acquire::http::Timeout=20
        -o Acquire::https::Timeout=20
        -o Acquire::http::Pipeline-Depth=0
    )

    if (( APT_CACHE_READY == 1 )); then
        return 0
    fi

    if DEBIAN_FRONTEND=noninteractive apt-get "${apt_opts[@]}" update; then
        APT_CACHE_READY=1
        return 0
    fi

    if repair_ubuntu_apt_mirrors; then
        echo -e "${C_YELLOW}⚠️ APT mirror timed out. Switching Ubuntu sources to archive.ubuntu.com and retrying...${C_RESET}"
        apt-get clean >/dev/null 2>&1 || true
        if DEBIAN_FRONTEND=noninteractive apt-get "${apt_opts[@]}" update; then
            APT_CACHE_READY=1
            return 0
        fi
    fi

    if switch_ubuntu_to_old_releases; then
        echo -e "${C_YELLOW}⚠️ Detected an end-of-life Ubuntu release. Switching APT sources to old-releases.ubuntu.com and retrying...${C_RESET}"
        apt-get clean >/dev/null 2>&1 || true
        if DEBIAN_FRONTEND=noninteractive apt-get "${apt_opts[@]}" update; then
            APT_CACHE_READY=1
            return 0
        fi
    fi

    echo -e "${C_RED}❌ Failed to refresh package lists. Please check VPS network, DNS, or blocked Ubuntu mirrors.${C_RESET}"
    return 1
}

ff_apt_install() {
    local -a packages=("$@")
    (( ${#packages[@]} > 0 )) || return 0

    ff_apt_update || return 1
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Use-Pty=0 install "${packages[@]}"
}

ff_apt_purge() {
    local -a packages=("$@")
    (( ${#packages[@]} > 0 )) || return 0
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Use-Pty=0 purge "${packages[@]}"
}

ff_pkg_install() {
    local -a packages=("$@")
    (( ${#packages[@]} > 0 )) || return 0
    local -a mapped=()
    mapfile -t mapped < <(_map_pkg_names "${packages[@]}")
    case "$FF_PKG_MGR" in
        apt) ff_apt_install "${mapped[@]}" ;;
        dnf) dnf install -y -q "${mapped[@]}" ;;
        yum) yum install -y -q "${mapped[@]}" ;;
        zypper) zypper install -y -q "${mapped[@]}" ;;
        pacman) pacman -S --noconfirm --needed "${mapped[@]}" ;;
        *) echo -e "${C_RED}❌ Unsupported package manager.${C_RESET}"; return 1 ;;
    esac
}

ff_pkg_purge() {
    local -a packages=("$@")
    (( ${#packages[@]} > 0 )) || return 0
    local -a mapped=()
    mapfile -t mapped < <(_map_pkg_names "${packages[@]}")
    case "$FF_PKG_MGR" in
        apt) ff_apt_purge "${mapped[@]}" ;;
        dnf) dnf remove -y -q "${mapped[@]}" ;;
        yum) yum remove -y -q "${mapped[@]}" ;;
        zypper) zypper remove -y "${mapped[@]}" ;;
        pacman) pacman -Rns --noconfirm "${mapped[@]}" 2>/dev/null ;;
        *) echo -e "${C_RED}❌ Unsupported package manager.${C_RESET}"; return 1 ;;
    esac
}

ff_pkg_autoremove() {
    case "$FF_PKG_MGR" in
        apt) apt-get autoremove -y >/dev/null 2>&1 ;;
        dnf) dnf autoremove -y -q >/dev/null 2>&1 ;;
        yum) yum autoremove -y -q >/dev/null 2>&1 ;;
        zypper) zypper packages --unneeded 2>/dev/null | awk -F'|' 'NR>3{print $3}' | xargs -r zypper remove -y >/dev/null 2>&1 ;;
        pacman) pacman -Qdtq 2>/dev/null | xargs -r pacman -Rns --noconfirm >/dev/null 2>&1 ;;
    esac
    return 0
}

ff_pkg_is_installed() {
    local pkg="$1"
    case "$FF_PKG_MGR" in
        apt) dpkg -s "$pkg" &>/dev/null ;;
        dnf|yum) rpm -q "$pkg" &>/dev/null ;;
        zypper) rpm -q "$pkg" &>/dev/null ;;
        pacman) pacman -Q "$pkg" &>/dev/null ;;
    esac
}

# Mandatory Dependency Check (Added jq and curl)
check_environment() {
    local missing_packages=()
    local cmd

    for cmd in bc jq curl wget; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_packages+=("$cmd")
        fi
    done

    if (( ${#missing_packages[@]} > 0 )); then
        echo -e "${C_YELLOW}⚠️ Installing missing dependencies: ${missing_packages[*]}${C_RESET}"
        ff_pkg_install "${missing_packages[@]}" >/dev/null 2>&1 || {
            echo -e "${C_RED}❌ Error: Failed to install required dependencies: ${missing_packages[*]}.${C_RESET}"
            exit 1
        }
    fi
}

ensure_firewallfalcon_dirs() {
    mkdir -p "$DB_DIR" "$SSL_CERT_DIR" "$BANDWIDTH_DIR" /etc/ssh/sshd_config.d
    touch "$DB_FILE"
}

ensure_firewallfalcon_system_group() {
    getent group "$FF_USERS_GROUP" >/dev/null 2>&1 || groupadd "$FF_USERS_GROUP" >/dev/null 2>&1 || true
}

db_has_user() {
    [[ -f "$DB_FILE" ]] || return 1
    awk -F: -v target="$1" '$1 == target { found=1; exit } END { exit(found ? 0 : 1) }' "$DB_FILE"
}

is_firewallfalcon_orphan_user() {
    local username="$1"
    local passwd_line system_user _ uid _ home shell

    passwd_line=$(getent passwd "$username" 2>/dev/null) || return 1
    IFS=: read -r system_user _ uid _ _ home shell <<< "$passwd_line"
    [[ "$uid" =~ ^[0-9]+$ ]] || return 1
    db_has_user "$username" && return 1

    if id -nG "$username" 2>/dev/null | tr ' ' '\n' | grep -Fxq "$FF_USERS_GROUP"; then
        return 0
    fi

    (( uid >= 1000 )) || return 1
    [[ "$home" == "/home/$username" || "$home" == /home/* ]] || return 1

    case "$shell" in
        /usr/sbin/nologin|/usr/bin/false|/bin/false) return 0 ;;
    esac

    return 1
}

get_firewallfalcon_orphan_users() {
    local username
    while IFS=: read -r username _rest; do
        [[ -n "$username" ]] || continue
        if is_firewallfalcon_orphan_user "$username"; then
            echo "$username"
        fi
    done < /etc/passwd
}

get_firewallfalcon_known_users() {
    local username
    local -A seen_users=()

    if [[ -f "$DB_FILE" ]]; then
        while IFS=: read -r username _rest; do
            [[ -n "$username" && "$username" != \#* ]] || continue
            seen_users["$username"]=1
        done < "$DB_FILE"
    fi

    while IFS= read -r username; do
        [[ -n "$username" ]] && seen_users["$username"]=1
    done < <(get_firewallfalcon_orphan_users)

    (( ${#seen_users[@]} > 0 )) || return 0
    printf "%s\n" "${!seen_users[@]}" | sort
}

delete_firewallfalcon_user_accounts() {
    local -a users_to_delete=("$@")
    local username

    [[ ${#users_to_delete[@]} -gt 0 ]] || return 0

    for username in "${users_to_delete[@]}"; do
        [[ -n "$username" ]] || continue
        killall -u "$username" -9 &>/dev/null
        pkill -9 -u "$username" &>/dev/null
        sleep 0.5
        if id "$username" &>/dev/null; then
            if userdel -rf "$username" &>/dev/null; then
                echo -e " ✅ System user '${C_YELLOW}$username${C_RESET}' deleted."
            else
                # Retry after harder kill
                pkill -9 -u "$username" &>/dev/null
                sleep 1
                if userdel -rf "$username" &>/dev/null; then
                    echo -e " ✅ System user '${C_YELLOW}$username${C_RESET}' deleted (retry)."
                else
                    echo -e " ❌ Failed to delete system user '${C_YELLOW}$username${C_RESET}'."
                fi
            fi
        else
            echo -e " ℹ️ System user '${C_YELLOW}$username${C_RESET}' was already missing. Removing manager data only."
        fi
        rm -f "$BANDWIDTH_DIR/${username}.usage"
        rm -f "$BANDWIDTH_DIR/${username}.daily_usage"
        rm -f "$BANDWIDTH_DIR/${username}.conn_locked"
        rm -f "$BANDWIDTH_DIR/${username}.daily_locked"
        rm -rf "$BANDWIDTH_DIR/pidtrack/${username}"
    done

    if [[ -f "$DB_FILE" ]]; then
        local db_tmp
        db_tmp=$(mktemp)
        awk -F: 'NR==FNR { drop[$1]=1; next } !($1 in drop)' <(printf "%s\n" "${users_to_delete[@]}") "$DB_FILE" > "$db_tmp" && mv "$db_tmp" "$DB_FILE"
        rm -f "$db_tmp" 2>/dev/null
    fi

    invalidate_banner_cache
    refresh_dynamic_banner_routing_if_enabled
}

require_interactive_terminal() {
    if [[ ! -t 0 || ! -t 1 ]]; then
        echo -e "${C_RED}❌ Error: The Hotscript menu must be run from an interactive terminal.${C_RESET}"
        exit 1
    fi
}

initial_setup() {
    echo -e "${C_BLUE}⚙️ Initializing Hotscript Manager setup...${C_RESET}"
    check_environment
    
    ensure_firewallfalcon_dirs
    ensure_firewallfalcon_system_group
    
    echo -e "${C_BLUE}🔹 Configuring user limiter service...${C_RESET}"
    setup_limiter_service
    
    echo -e "${C_BLUE}🔹 Configuring bandwidth monitoring service...${C_RESET}"
    setup_bandwidth_service
    
    echo -e "${C_BLUE}🔹 Installing trial account cleanup script...${C_RESET}"
    setup_trial_cleanup_script
    
    echo -e "${C_BLUE}🔹 Cleaning legacy dynamic SSH banner hooks...${C_RESET}"
    disable_dynamic_ssh_banner_system
    systemctl reload sshd 2>/dev/null || systemctl reload ssh 2>/dev/null || true
    
    if [ ! -f "$INSTALL_FLAG_FILE" ]; then
        touch "$INSTALL_FLAG_FILE"
    fi
    echo -e "${C_GREEN}✅ Setup finished.${C_RESET}"
}

_is_valid_ipv4() {
    local ip=$1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 0
    else
        return 1
    fi
}

check_and_open_firewall_port() {
    local port="$1"
    local protocol="${2:-tcp}"
    local firewall_detected=false

    if command -v ufw &> /dev/null && ufw status | grep -q "Status: active"; then
        firewall_detected=true
        if ! ufw status | grep -qw "$port/$protocol"; then
            echo -e "${C_YELLOW}🔥 UFW firewall is active and port ${port}/${protocol} is closed.${C_RESET}"
            read -p "👉 Do you want to open this port now? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                ufw allow "$port/$protocol"
                echo -e "${C_GREEN}✅ Port ${port}/${protocol} has been opened in UFW.${C_RESET}"
            else
                echo -e "${C_RED}❌ Warning: Port ${port}/${protocol} was not opened. The service may not work correctly.${C_RESET}"
                return 1
            fi
        else
             echo -e "${C_GREEN}✅ Port ${port}/${protocol} is already open in UFW.${C_RESET}"
        fi
    fi

    if command -v firewall-cmd &> /dev/null && systemctl is-active --quiet firewalld; then
        firewall_detected=true
        if ! firewall-cmd --list-ports --permanent | grep -qw "$port/$protocol"; then
            echo -e "${C_YELLOW}🔥 firewalld is active and port ${port}/${protocol} is not open.${C_RESET}"
            read -p "👉 Do you want to open this port now? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                firewall-cmd --add-port="$port/$protocol" --permanent
                firewall-cmd --reload
                echo -e "${C_GREEN}✅ Port ${port}/${protocol} has been opened in firewalld.${C_RESET}"
            else
                echo -e "${C_RED}❌ Warning: Port ${port}/${protocol} was not opened. The service may not work correctly.${C_RESET}"
                return 1
            fi
        else
            echo -e "${C_GREEN}✅ Port ${port}/${protocol} is already open in firewalld.${C_RESET}"
        fi
    fi

    if ! $firewall_detected; then
        echo -e "${C_BLUE}ℹ️ No active firewall (UFW or firewalld) detected. Assuming ports are open.${C_RESET}"
    fi
    return 0
}

check_and_open_firewall_port_range() {
    local port_range="$1"
    local protocol="${2:-tcp}"
    local firewall_detected=false

    if command -v ufw &> /dev/null && ufw status | grep -q "Status: active"; then
        firewall_detected=true
        if ! ufw status | grep -Fq "$port_range/$protocol"; then
            echo -e "${C_YELLOW}🔥 UFW firewall is active and range ${port_range}/${protocol} is closed.${C_RESET}"
            read -p "👉 Do you want to open this port range now? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                ufw allow "$port_range/$protocol"
                echo -e "${C_GREEN}✅ Range ${port_range}/${protocol} has been opened in UFW.${C_RESET}"
            else
                echo -e "${C_RED}❌ Warning: Range ${port_range}/${protocol} was not opened. The service may not work correctly.${C_RESET}"
                return 1
            fi
        else
            echo -e "${C_GREEN}✅ Range ${port_range}/${protocol} is already open in UFW.${C_RESET}"
        fi
    fi

    if command -v firewall-cmd &> /dev/null && systemctl is-active --quiet firewalld; then
        firewall_detected=true
        if ! firewall-cmd --quiet --query-port="$port_range/$protocol"; then
            echo -e "${C_YELLOW}🔥 firewalld is active and range ${port_range}/${protocol} is not open.${C_RESET}"
            read -p "👉 Do you want to open this port range now? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                firewall-cmd --add-port="$port_range/$protocol" --permanent
                firewall-cmd --reload
                echo -e "${C_GREEN}✅ Range ${port_range}/${protocol} has been opened in firewalld.${C_RESET}"
            else
                echo -e "${C_RED}❌ Warning: Range ${port_range}/${protocol} was not opened. The service may not work correctly.${C_RESET}"
                return 1
            fi
        else
            echo -e "${C_GREEN}✅ Range ${port_range}/${protocol} is already open in firewalld.${C_RESET}"
        fi
    fi

    if ! $firewall_detected; then
        echo -e "${C_BLUE}ℹ️ No active firewall (UFW or firewalld) detected. Assuming range ${port_range}/${protocol} is open.${C_RESET}"
    fi
    return 0
}

check_and_free_ports() {
    local ports_to_check=("$@")
    for port in "${ports_to_check[@]}"; do
        echo -e "\n${C_BLUE}🔎 Checking if port $port is available...${C_RESET}"
        local conflicting_process_info
        conflicting_process_info=$(
            ss -H -lntp "( sport = :$port )" 2>/dev/null
            ss -H -lunp "( sport = :$port )" 2>/dev/null
        )
        
        if [[ -n "$conflicting_process_info" ]]; then
            local conflicting_pid
            conflicting_pid=$(echo "$conflicting_process_info" | grep -oP 'pid=\K[0-9]+' | head -n 1)
            local conflicting_name
            conflicting_name=$(echo "$conflicting_process_info" | grep -oP 'users:\(\("(\K[^"]+)' | head -n 1)
            
            echo -e "${C_YELLOW}⚠️ Warning: Port $port is in use by process '${conflicting_name:-unknown}' (PID: ${conflicting_pid:-N/A}).${C_RESET}"
            read -p "👉 Do you want to attempt to stop this process? (y/n): " kill_confirm
            if [[ "$kill_confirm" == "y" || "$kill_confirm" == "Y" ]]; then
                if [[ -z "$conflicting_pid" ]]; then
                    echo -e "${C_RED}❌ Could not determine which PID owns port $port. Please free it manually.${C_RESET}"
                    return 1
                fi
                echo -e "${C_GREEN}🛑 Stopping process PID $conflicting_pid...${C_RESET}"
                systemctl stop "$(ps -p "$conflicting_pid" -o comm=)" &>/dev/null || kill -9 "$conflicting_pid"
                sleep 2
                
                if ss -H -lntp "( sport = :$port )" 2>/dev/null | grep -q . || ss -H -lunp "( sport = :$port )" 2>/dev/null | grep -q .; then
                     echo -e "${C_RED}❌ Failed to free port $port. Please handle it manually. Aborting.${C_RESET}"
                     return 1
                else
                     echo -e "${C_GREEN}✅ Port $port has been successfully freed.${C_RESET}"
                fi
            else
                echo -e "${C_RED}❌ Cannot proceed without freeing port $port. Aborting.${C_RESET}"
                return 1
            fi
        else
            echo -e "${C_GREEN}✅ Port $port is free to use.${C_RESET}"
        fi
    done
    return 0
}

setup_limiter_service() {
    # Combined limiter + bandwidth monitoring
    cat > "$LIMITER_SCRIPT" << 'EOF'
#!/bin/bash
# Hotscript limiter version 2026-07-23.4
DB_FILE="/etc/firewallfalcon/users.db"
BW_DIR="/etc/firewallfalcon/bandwidth"
PID_DIR="$BW_DIR/pidtrack"
BANNER_DIR="/etc/firewallfalcon/banners"
SCAN_INTERVAL=10
CONN_LOCK_DURATION=60

mkdir -p "$BW_DIR" "$PID_DIR"
shopt -s nullglob

write_banner_if_changed() {
    local user="$1"
    local content="$2"
    local banner_file="$BANNER_DIR/${user}.txt"
    local tmp_file="${banner_file}.tmp"

    printf "%s" "$content" > "$tmp_file"
    if ! cmp -s "$tmp_file" "$banner_file" 2>/dev/null; then
        mv "$tmp_file" "$banner_file"
    else
        rm -f "$tmp_file"
    fi
}

# Excess sessions are killed immediately every scan cycle. No account locking.

while true; do
    if [[ ! -s "$DB_FILE" ]]; then
        sleep "$SCAN_INTERVAL"
        continue
    fi
    
    # Daily reset logic
    today=$(date +%Y-%m-%d)
    if [[ ! -f "$BW_DIR/current_date" ]]; then
        echo "$today" > "$BW_DIR/current_date"
    fi
    saved_date=$(cat "$BW_DIR/current_date" 2>/dev/null || echo "$today")
    if [[ "$today" != "$saved_date" ]]; then
        # New day! Reset daily usage and unlock users locked due to daily limit
        rm -f "$BW_DIR/"*.daily_usage 2>/dev/null
        for locked_file in "$BW_DIR/"*.daily_locked; do
            [[ -f "$locked_file" ]] || continue
            locked_user=$(basename "$locked_file" .daily_locked)
            usermod -U "$locked_user" &>/dev/null
            rm -f "$locked_file"
        done
        echo "$today" > "$BW_DIR/current_date"
    fi

    # Connection limit auto-unlock: check marker files and unlock after CONN_LOCK_DURATION seconds
    for conn_lock_file in "$BW_DIR/"*.conn_locked; do
        [[ -f "$conn_lock_file" ]] || continue
        lock_ts=0
        read -r lock_ts < "$conn_lock_file" 2>/dev/null || lock_ts=0
        [[ "$lock_ts" =~ ^[0-9]+$ ]] || lock_ts=0
        printf -v now_ts '%(%s)T' -1
        if (( now_ts - lock_ts >= CONN_LOCK_DURATION )); then
            conn_locked_user=$(basename "$conn_lock_file" .conn_locked)
            usermod -U "$conn_locked_user" &>/dev/null
            rm -f "$conn_lock_file"
        fi
    done

    printf -v current_ts '%(%s)T' -1
    dynamic_banners_enabled=false

    # Reset associative arrays each cycle (unset first to avoid stale data)
    unset session_pids locked_users uid_to_user loginuid_pids
    declare -A session_pids=()
    declare -A locked_users=()
    declare -A uid_to_user=()
    declare -A loginuid_pids=()

    while IFS=: read -r username _ uid _rest; do
        [[ -n "$username" && "$uid" =~ ^[0-9]+$ ]] && uid_to_user["$uid"]="$username"
    done < /etc/passwd

    # Method 1: process owner from ps (primary source for connection counting)
    # sshd-session is the user-owned process on Ubuntu 24.04+ (OpenSSH 9.8+)
    # On Ubuntu 22, the per-session sshd is user-owned instead.
    # Either way, exactly 1 user-owned process exists per SSH session.
    while read -r ssh_pid ssh_owner; do
        [[ "$ssh_pid" =~ ^[0-9]+$ ]] || continue
        if [[ -n "$ssh_owner" && "$ssh_owner" != "root" && "$ssh_owner" != "sshd" ]]; then
            session_pids["$ssh_owner"]+="$ssh_pid "
        fi
    done < <(ps -C sshd,sshd-session -o pid=,user= 2>/dev/null)

    # Method 2: kernel loginuid (reliable even when sshd runs as root)
    for p in /proc/[0-9]*/loginuid; do
        [[ -f "$p" ]] || continue
        login_uid=""
        read -r login_uid < "$p" || login_uid=""
        [[ "$login_uid" =~ ^[0-9]+$ && "$login_uid" != "4294967295" ]] || continue

        session_user="${uid_to_user[$login_uid]}"
        [[ -n "$session_user" ]] || continue

        pid_dir=$(dirname "$p")
        pid_num=$(basename "$pid_dir")
        comm=""
        read -r comm < "$pid_dir/comm" || comm=""
        [[ "$comm" == "sshd" ]] || continue

        ppid_val=""
        while read -r key value; do
            if [[ "$key" == "PPid:" ]]; then
                ppid_val="${value:-}"
                break
            fi
        done < "$pid_dir/status"
        [[ "$ppid_val" == "1" ]] && continue

        loginuid_pids["$session_user"]+="$pid_num "
    done

    # Detect locked users via /etc/shadow (cheaper than passwd -Sa)
    if [[ -r /etc/shadow ]]; then
        while IFS=: read -r shadow_user shadow_hash _rest; do
            [[ -n "$shadow_user" && "${shadow_hash:0:1}" == "!" ]] && locked_users["$shadow_user"]=1
        done < /etc/shadow
    else
        while read -r passwd_user _ passwd_status _rest; do
            [[ "$passwd_status" == "L" ]] && locked_users["$passwd_user"]=1
        done < <(passwd -Sa 2>/dev/null)
    fi

    if [[ -f "/etc/firewallfalcon/banners_enabled" ]]; then
        mkdir -p "$BANNER_DIR"
        dynamic_banners_enabled=true
    fi

    while IFS=: read -r user pass expiry limit bandwidth_gb daily_bandwidth_gb _extra; do
        [[ -z "$user" || "$user" == \#* ]] && continue
        
        [[ ! "$daily_bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]] && daily_bandwidth_gb=0

        # CRITICAL: unset before declare to reset per-user (bash declare is function-scoped)
        unset unique_pids
        declare -A unique_pids=()

        # Use ONLY ps-based session_pids for connection counting.
        # loginuid_pids can double-count (root-owned sshd has user's loginuid on Ubuntu 24)
        for pid in ${session_pids[$user]}; do
            [[ "$pid" =~ ^[0-9]+$ ]] && unique_pids["$pid"]=1
        done

        online_count=${#unique_pids[@]}
        user_locked=false
        if [[ -n "${locked_users[$user]+x}" ]]; then
            user_locked=true
        fi

        expiry_ts=0
        if [[ "$expiry" != "Never" && -n "$expiry" && "$expiry" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            expiry_ts=$(date -d "$expiry" +%s 2>/dev/null || echo 0)
            if [[ "$expiry_ts" =~ ^[0-9]+$ ]] && (( expiry_ts > 0 && expiry_ts < current_ts )); then
                if ! $user_locked; then
                    usermod -L "$user" &>/dev/null
                    killall -u "$user" -9 &>/dev/null
                    locked_users["$user"]=1
                fi
                continue
            fi
        fi

        [[ "$limit" =~ ^[0-9]+$ ]] || limit=1
        if (( online_count > limit )); then
            # Kill only the EXCESS sessions, keep the oldest ones alive
            sorted_pids=()
            for pid in "${!unique_pids[@]}"; do
                sorted_pids+=("$pid")
            done
            IFS=$'\n' sorted_pids=($(sort -n <<<"${sorted_pids[*]}")); unset IFS

            for (( i=limit; i<${#sorted_pids[@]}; i++ )); do
                kill -9 "${sorted_pids[$i]}" &>/dev/null
            done

            # Remove killed PIDs from unique_pids so bandwidth tracking is correct
            for (( i=limit; i<${#sorted_pids[@]}; i++ )); do
                unset unique_pids["${sorted_pids[$i]}"]
            done
            online_count=${#unique_pids[@]}
        fi

        if $dynamic_banners_enabled; then
            days_left="N/A"
            if [[ "$expiry" != "Never" && -n "$expiry" && "$expiry_ts" =~ ^[0-9]+$ && $expiry_ts -gt 0 ]]; then
                diff_secs=$((expiry_ts - current_ts))
                if (( diff_secs <= 0 )); then
                    days_left="EXPIRED"
                else
                    d_l=$(( diff_secs / 86400 ))
                    h_l=$(( (diff_secs % 86400) / 3600 ))
                    if (( d_l == 0 )); then
                        days_left="${h_l}h left"
                    else
                        days_left="${d_l}d ${h_l}h"
                    fi
                fi
            fi

            bw_info="Unlimited"
            if [[ "$bandwidth_gb" != "0" && -n "$bandwidth_gb" ]]; then
                usagefile="$BW_DIR/${user}.usage"
                accum_disp=0
                if [[ -f "$usagefile" ]]; then
                    read -r accum_disp < "$usagefile"
                    [[ "$accum_disp" =~ ^[0-9]+$ ]] || accum_disp=0
                fi
                used_gb_int=$((accum_disp / 1073741824))
                used_gb_frac=$(( (accum_disp % 1073741824) * 100 / 1073741824 ))
                printf -v used_gb "%d.%02d" "$used_gb_int" "$used_gb_frac"
                quota_b=$(( ${bandwidth_gb%%.*} * 1073741824 ))
                remain_b=$(( quota_b - accum_disp ))
                (( remain_b < 0 )) && remain_b=0
                remain_gb_int=$((remain_b / 1073741824))
                remain_gb_frac=$(( (remain_b % 1073741824) * 100 / 1073741824 ))
                printf -v remain_gb "%d.%02d" "$remain_gb_int" "$remain_gb_frac"
                bw_info="${used_gb}/${bandwidth_gb} GB used | ${remain_gb} GB left"
            fi

            banner_content="<br><font color=\"yellow\"><b>      ✨ ACCOUNT STATUS ✨      </b></font><br><br>"
            banner_content+="<font color=\"white\">👤 <b>Username   :</b> $user</font><br>"
            banner_content+="<font color=\"white\">📅 <b>Expiration :</b> $expiry ($days_left)</font><br>"
            
            if [[ "$bandwidth_gb" != "0" ]]; then
                banner_content+="<font color=\"white\">📊 <b>Total BW   :</b> $bw_info</font><br>"
            fi
            
            if [[ "$daily_bandwidth_gb" != "0" ]]; then
                daily_usagefile="$BW_DIR/${user}.daily_usage"
                accum_disp=0
                if [[ -f "$daily_usagefile" ]]; then
                    read -r accum_disp < "$daily_usagefile"
                    [[ "$accum_disp" =~ ^[0-9]+$ ]] || accum_disp=0
                fi
                used_gb_int=$((accum_disp / 1073741824))
                used_gb_frac=$(( (accum_disp % 1073741824) * 100 / 1073741824 ))
                printf -v used_gb "%d.%02d" "$used_gb_int" "$used_gb_frac"
                quota_b=$(( ${daily_bandwidth_gb%%.*} * 1073741824 ))
                remain_b=$(( quota_b - accum_disp ))
                (( remain_b < 0 )) && remain_b=0
                remain_gb_int=$((remain_b / 1073741824))
                remain_gb_frac=$(( (remain_b % 1073741824) * 100 / 1073741824 ))
                printf -v remain_gb "%d.%02d" "$remain_gb_int" "$remain_gb_frac"
                daily_bw_info="${used_gb}/${daily_bandwidth_gb} GB used | ${remain_gb} GB left"
                banner_content+="<font color=\"white\">📊 <b>Daily BW   :</b> $daily_bw_info</font><br>"
            fi
            
            banner_content+="<font color=\"white\">🔌 <b>Sessions   :</b> $online_count/$limit</font><br><br>"
            write_banner_if_changed "$user" "$banner_content"
        fi

        [[ ( -z "$bandwidth_gb" || "$bandwidth_gb" == "0" ) && ( -z "$daily_bandwidth_gb" || "$daily_bandwidth_gb" == "0" ) ]] && continue

        usagefile="$BW_DIR/${user}.usage"
        accumulated=0
        if [[ -f "$usagefile" ]]; then
            read -r accumulated < "$usagefile"
            [[ "$accumulated" =~ ^[0-9]+$ ]] || accumulated=0
        fi

        if (( ${#unique_pids[@]} == 0 )); then
            rm -f "$PID_DIR/${user}__"*.last 2>/dev/null
            continue
        fi

        delta_total=0
        for pid in "${!unique_pids[@]}"; do
            io_file="/proc/$pid/io"
            cur=0
            if [[ -r "$io_file" ]]; then
                rchar=0
                wchar=0
                while read -r key value; do
                    case "$key" in
                        rchar:) rchar=${value:-0} ;;
                        wchar:) wchar=${value:-0} ;;
                    esac
                done < "$io_file"
                cur=$((rchar + wchar))
            fi

            pidfile="$PID_DIR/${user}__${pid}.last"
            if [[ -f "$pidfile" ]]; then
                read -r prev < "$pidfile"
                [[ "$prev" =~ ^[0-9]+$ ]] || prev=0
                if (( cur >= prev )); then
                    d=$((cur - prev))
                else
                    d=$cur
                fi
                delta_total=$((delta_total + d))
            fi
            printf "%s\n" "$cur" > "$pidfile"
        done

        for f in "$PID_DIR/${user}__"*.last; do
            [[ -f "$f" ]] || continue
            fpid=${f##*__}
            fpid=${fpid%.last}
            [[ -d "/proc/$fpid" ]] || rm -f "$f"
        done

        new_total=$((accumulated + delta_total))
        printf "%s\n" "$new_total" > "$usagefile"

        if awk "BEGIN{exit(!($bandwidth_gb > 0))}" 2>/dev/null; then
            quota_bytes=$(awk "BEGIN{printf \"%.0f\", $bandwidth_gb * 1073741824}")
            if [[ "$quota_bytes" =~ ^[0-9]+$ ]] && (( quota_bytes > 0 && new_total >= quota_bytes )); then
                if ! $user_locked; then
                    usermod -L "$user" &>/dev/null
                    locked_users["$user"]=1
                    user_locked=true
                fi
            fi
        fi
        
        daily_usagefile="$BW_DIR/${user}.daily_usage"
        daily_accumulated=0
        if [[ -f "$daily_usagefile" ]]; then
            read -r daily_accumulated < "$daily_usagefile"
            [[ "$daily_accumulated" =~ ^[0-9]+$ ]] || daily_accumulated=0
        fi
        new_daily_total=$((daily_accumulated + delta_total))
        printf "%s\n" "$new_daily_total" > "$daily_usagefile"
        
        if awk "BEGIN{exit(!($daily_bandwidth_gb > 0))}" 2>/dev/null; then
            d_quota_bytes=$(awk "BEGIN{printf \"%.0f\", $daily_bandwidth_gb * 1073741824}")
            if [[ "$d_quota_bytes" =~ ^[0-9]+$ ]] && (( d_quota_bytes > 0 && new_daily_total >= d_quota_bytes )); then
                if ! $user_locked; then
                    usermod -L "$user" &>/dev/null
                    locked_users["$user"]=1
                    user_locked=true
                    touch "$BW_DIR/${user}.daily_locked"
                fi
            fi
        fi
    done < "$DB_FILE"

    sleep "$SCAN_INTERVAL"
done
EOF
    chmod +x "$LIMITER_SCRIPT"
    # Strip DOS line endings in case menu.sh was uploaded from Windows
    sed -i 's/\r$//' "$LIMITER_SCRIPT" 2>/dev/null

    cat > "$LIMITER_SERVICE" << EOF
[Unit]
Description=Hotscript Active User Limiter
After=network.target

[Service]
Type=simple
ExecStart=$LIMITER_SCRIPT
Restart=always
RestartSec=10
Nice=10
IOSchedulingClass=best-effort
IOSchedulingPriority=7
MemoryHigh=48M
MemoryMax=64M

[Install]
WantedBy=multi-user.target
EOF
    sed -i 's/\r$//' "$LIMITER_SERVICE" 2>/dev/null

    pkill -f "firewallfalcon-limiter" 2>/dev/null

    if ! systemctl is-active --quiet firewallfalcon-limiter; then
        systemctl daemon-reload
        systemctl enable firewallfalcon-limiter &>/dev/null
        systemctl start firewallfalcon-limiter --no-block &>/dev/null
        
    else
        systemctl restart firewallfalcon-limiter --no-block &>/dev/null
        
    fi
}

sync_runtime_components_if_needed() {
    local limiter_marker="# Hotscript limiter version 2026-07-23.8"
    cleanup_legacy_bandwidth_runtime
    setup_trial_cleanup_script >/dev/null 2>&1
    if [[ ! -f "$LIMITER_SCRIPT" ]] || ! grep -Fqx "$limiter_marker" "$LIMITER_SCRIPT" 2>/dev/null; then
        setup_limiter_service >/dev/null 2>&1
    fi
    if [[ -f "$BADVPN_SERVICE_FILE" ]]; then
        ensure_badvpn_service_is_quiet
    fi
    if [[ -f "/etc/firewallfalcon/banners_enabled" ]]; then
        update_ssh_banners_config
    elif [[ -f "$SSHD_FF_CONFIG" ]]; then
        disable_dynamic_ssh_banner_system
        systemctl reload sshd 2>/dev/null || systemctl reload ssh 2>/dev/null || true
    fi
}

setup_bandwidth_service() {
    mkdir -p "$BANDWIDTH_DIR"
    # Bandwidth monitoring is now integrated into the limiter service above.
    cleanup_legacy_bandwidth_runtime
}

cleanup_legacy_bandwidth_runtime() {
    local needs_reload=false

    systemctl stop firewallfalcon-bandwidth &>/dev/null || true
    systemctl disable firewallfalcon-bandwidth &>/dev/null || true
    pkill -f "firewallfalcon-bandwidth" &>/dev/null || true

    if [[ -e "$BANDWIDTH_SERVICE" || -e "$BANDWIDTH_SCRIPT" || -e "$LEGACY_BANDWIDTH_DIR" ]]; then
        rm -f "$BANDWIDTH_SERVICE" "$BANDWIDTH_SCRIPT" 2>/dev/null
        rm -rf "$LEGACY_BANDWIDTH_DIR" 2>/dev/null
        needs_reload=true
    fi

    if $needs_reload; then
        systemctl daemon-reload &>/dev/null || true
    fi
}

setup_trial_cleanup_script() {
    cat > "$TRIAL_CLEANUP_SCRIPT" << 'TREOF'
#!/bin/bash
# Hotscript Trial Account Auto-Cleanup
# Usage: firewallfalcon-trial-cleanup.sh <username>
DB_FILE="/etc/firewallfalcon/users.db"
BW_DIR="/etc/firewallfalcon/bandwidth"

username="$1"
if [[ -z "$username" ]]; then exit 1; fi

db_line=$(grep "^${username}:" "$DB_FILE" 2>/dev/null | head -n 1)
if [[ -z "$db_line" ]]; then exit 0; fi

IFS=: read -r _ _ _ _ _ trial_marker _rest <<< "$db_line"
if [[ "$trial_marker" != "trial" ]]; then
    exit 0
fi

# Kill active sessions
killall -u "$username" -9 &>/dev/null
pkill -9 -u "$username" &>/dev/null
sleep 1

# Delete system user
userdel -rf "$username" &>/dev/null

# Remove from DB
sed -i "/^${username}:/d" "$DB_FILE"

# Remove bandwidth tracking
rm -f "$BW_DIR/${username}.usage"
rm -rf "$BW_DIR/pidtrack/${username}"
TREOF
    chmod +x "$TRIAL_CLEANUP_SCRIPT"
}

disable_dynamic_ssh_banner_system() {
    rm -f "/etc/firewallfalcon/banners_enabled" "$SSHD_FF_CONFIG" /usr/local/bin/firewallfalcon-login-info.sh 2>/dev/null
    rm -rf "/etc/firewallfalcon/banners" 2>/dev/null
    invalidate_banner_cache
}

disable_static_ssh_banner_in_sshd_config() {
    sed -i.bak -E "s|^[[:space:]]*Banner[[:space:]]+$SSH_BANNER_FILE[[:space:]]*$|# Banner $SSH_BANNER_FILE|" /etc/ssh/sshd_config 2>/dev/null
}

is_static_ssh_banner_enabled() {
    grep -q -E "^[[:space:]]*Banner[[:space:]]+$SSH_BANNER_FILE[[:space:]]*$" /etc/ssh/sshd_config 2>/dev/null && [ -f "$SSH_BANNER_FILE" ]
}

is_dynamic_ssh_banner_enabled() {
    [[ -f "/etc/firewallfalcon/banners_enabled" && -f "$SSHD_FF_CONFIG" ]]
}

get_ssh_banner_mode() {
    if is_dynamic_ssh_banner_enabled; then
        echo "dynamic"
    elif is_static_ssh_banner_enabled; then
        echo "static"
    else
        echo "disabled"
    fi
}

refresh_dynamic_banner_routing_if_enabled() {
    if is_dynamic_ssh_banner_enabled; then
        update_ssh_banners_config
    fi
}

update_ssh_banners_config() {
    local tmp_conf

    if [[ ! -f "/etc/firewallfalcon/banners_enabled" ]]; then
        if [[ -f "$SSHD_FF_CONFIG" ]]; then
            rm -f "$SSHD_FF_CONFIG" 2>/dev/null
            systemctl reload sshd 2>/dev/null || systemctl reload ssh 2>/dev/null
        fi
        return
    fi

    ensure_firewallfalcon_dirs
    tmp_conf="/tmp/ff_banners_new.conf"
    echo "# Hotscript - Dynamic per-user SSH banners" > "$tmp_conf"

    if [[ -f "$DB_FILE" ]]; then
        while IFS=: read -r u _rest; do
            [[ -z "$u" || "$u" == \#* ]] && continue
            echo "Match User $u" >> "$tmp_conf"
            echo "    Banner /etc/firewallfalcon/banners/${u}.txt" >> "$tmp_conf"
        done < "$DB_FILE"
    fi

    if ! cmp -s "$tmp_conf" "$SSHD_FF_CONFIG" 2>/dev/null; then
        mv "$tmp_conf" "$SSHD_FF_CONFIG"
        if ! grep -q "^Include /etc/ssh/sshd_config.d/" /etc/ssh/sshd_config 2>/dev/null; then
            echo "Include /etc/ssh/sshd_config.d/*.conf" >> /etc/ssh/sshd_config
        fi
        systemctl reload sshd 2>/dev/null || systemctl reload ssh 2>/dev/null
    else
        rm -f "$tmp_conf"
    fi
}

setup_ssh_login_info() {
    ensure_firewallfalcon_dirs || return 1
    if ! touch "/etc/firewallfalcon/banners_enabled"; then
        echo -e "${C_RED}❌ Failed to enable dynamic SSH banners.${C_RESET}"
        return 1
    fi
    disable_static_ssh_banner_in_sshd_config
    update_ssh_banners_config
    return 0
}


generate_dns_record() {
    echo -e "\n${C_BLUE}⚙️ Generating a random domain...${C_RESET}"
    if ! command -v jq &> /dev/null; then
        echo -e "${C_YELLOW}⚠️ jq not found, attempting to install...${C_RESET}"
        ff_pkg_install jq >/dev/null 2>&1 || {
            echo -e "${C_RED}❌ Failed to install jq. Cannot manage DNS records.${C_RESET}"
            return 1
        }
    fi
    local SERVER_IPV4
    SERVER_IPV4=$(curl -s -4 icanhazip.com)
    if ! _is_valid_ipv4 "$SERVER_IPV4"; then
        echo -e "\n${C_RED}❌ Error: Could not retrieve a valid public IPv4 address from icanhazip.com.${C_RESET}"
        echo -e "${C_YELLOW}ℹ️ Please check your server's network connection and DNS resolver settings.${C_RESET}"
        echo -e "   Output received: '$SERVER_IPV4'"
        return 1
    fi

    local SERVER_IPV6
    SERVER_IPV6=$(curl -s -6 icanhazip.com --max-time 5)

    local RANDOM_SUBDOMAIN="vps-$(tr -dc a-z0-9 < /dev/urandom | head -c 8)"
    local FULL_DOMAIN="$RANDOM_SUBDOMAIN.$DESEC_DOMAIN"
    local HAS_IPV6="false"

    local API_DATA
    API_DATA=$(printf '[{"subname": "%s", "type": "A", "ttl": 3600, "records": ["%s"]}]' "$RANDOM_SUBDOMAIN" "$SERVER_IPV4")

    if [[ -n "$SERVER_IPV6" ]]; then
        local aaaa_record
        aaaa_record=$(printf ',{"subname": "%s", "type": "AAAA", "ttl": 3600, "records": ["%s"]}' "$RANDOM_SUBDOMAIN" "$SERVER_IPV6")
        API_DATA="${API_DATA%?}${aaaa_record}]"
        HAS_IPV6="true"
    fi

    local CREATE_RESPONSE
    CREATE_RESPONSE=$(curl -s -w "%{http_code}" -X POST "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/" \
        -H "Authorization: Token $DESEC_TOKEN" -H "Content-Type: application/json" \
        --data "$API_DATA")
    
    local HTTP_CODE=${CREATE_RESPONSE: -3}
    local RESPONSE_BODY=${CREATE_RESPONSE:0:${#CREATE_RESPONSE}-3}

    if [[ "$HTTP_CODE" -ne 201 ]]; then
        echo -e "${C_RED}❌ Failed to create DNS records. API returned HTTP $HTTP_CODE.${C_RESET}"
        if ! echo "$RESPONSE_BODY" | jq . > /dev/null 2>&1; then
            echo "Raw Response: $RESPONSE_BODY"
        else
            echo "Response: $RESPONSE_BODY" | jq
        fi
        return 1
    fi
    
    cat > "$DNS_INFO_FILE" <<-EOF
SUBDOMAIN="$RANDOM_SUBDOMAIN"
FULL_DOMAIN="$FULL_DOMAIN"
HAS_IPV6="$HAS_IPV6"
EOF
    echo -e "\n${C_GREEN}✅ Successfully created domain: ${C_YELLOW}$FULL_DOMAIN${C_RESET}"
}

delete_dns_record() {
    if [ ! -f "$DNS_INFO_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ No domain to delete.${C_RESET}"
        return
    fi
    echo -e "\n${C_BLUE}🗑️ Deleting DNS records...${C_RESET}"
    source "$DNS_INFO_FILE"
    if [[ -z "$SUBDOMAIN" ]]; then
        echo -e "${C_RED}❌ Could not read record details from config file. Skipping deletion.${C_RESET}"
        return
    fi

    curl -s -X DELETE "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/$SUBDOMAIN/A/" \
         -H "Authorization: Token $DESEC_TOKEN" > /dev/null

    if [[ "$HAS_IPV6" == "true" ]]; then
        curl -s -X DELETE "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/$SUBDOMAIN/AAAA/" \
             -H "Authorization: Token $DESEC_TOKEN" > /dev/null
    fi

    echo -e "\n${C_GREEN}✅ Deleted domain: ${C_YELLOW}$FULL_DOMAIN${C_RESET}"
    rm -f "$DNS_INFO_FILE"
}

dns_menu() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🌐 DNS Domain Management ---${C_RESET}"
    if [ -f "$DNS_INFO_FILE" ]; then
        source "$DNS_INFO_FILE"
        echo -e "\nℹ️ A domain already exists for this server:"
        echo -e "  - ${C_CYAN}Domain:${C_RESET} ${C_YELLOW}$FULL_DOMAIN${C_RESET}"
        echo
        read -p "👉 Do you want to DELETE this domain? (y/n): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            delete_dns_record
        else
            echo -e "\n${C_YELLOW}❌ Action cancelled.${C_RESET}"
        fi
    else
        echo -e "\nℹ️ No domain has been generated for this server yet."
        echo
        read -p "👉 Do you want to generate a new random domain now? (y/n): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            generate_dns_record
        else
            echo -e "\n${C_YELLOW}❌ Action cancelled.${C_RESET}"
        fi
    fi
}

_select_user_interface() {
    local title="$1"
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}${title}${C_RESET}\n"
    if [[ ! -s $DB_FILE ]]; then
        echo -e "${C_YELLOW}ℹ️ No users found in the database.${C_RESET}"
        SELECTED_USER="NO_USERS"; return
    fi
    
    mapfile -t all_users < <(cut -d: -f1 "$DB_FILE" | sort)
    local -A all_user_lookup=()
    local username
    for username in "${all_users[@]}"; do
        all_user_lookup["$username"]=1
    done
    
    if [ ${#all_users[@]} -ge 15 ]; then
        read -p "👉 Enter a search term (or press Enter to list all): " search_term
        if [[ -n "$search_term" ]]; then
            mapfile -t users < <(printf "%s\n" "${all_users[@]}" | grep -i "$search_term")
        else
            users=("${all_users[@]}")
        fi
    else
        users=("${all_users[@]}")
    fi

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "\n${C_YELLOW}ℹ️ No users found matching your criteria.${C_RESET}"
        SELECTED_USER="NO_USERS"; return
    fi
    echo -e "\nPlease select a user:\n"
    for i in "${!users[@]}"; do
        printf "  ${C_GREEN}[%2d]${C_RESET} %s\n" "$((i+1))" "${users[$i]}"
    done
    echo -e "\n  ${C_RED} [ 0]${C_RESET} ↩️ Cancel"
    echo -e "${C_CYAN}💡 Tip: you can also type the exact username directly.${C_RESET}"
    echo
    local choice
    while true; do
        if ! read -r -p "👉 Enter the number or exact username: " choice; then
            echo
            SELECTED_USER=""
            return
        fi
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -le "${#users[@]}" ]; then
            if [ "$choice" -eq 0 ]; then
                SELECTED_USER=""; return
            else
                SELECTED_USER="${users[$((choice-1))]}"; return
            fi
        elif [[ -n "${all_user_lookup[$choice]+x}" ]]; then
            SELECTED_USER="$choice"; return
        else
            echo -e "${C_RED}❌ Invalid selection. Please try again.${C_RESET}"
        fi
    done
}

_select_multi_user_interface() {
    local title="$1"
    local include_orphan_users="${2:-false}"
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}${title}${C_RESET}\n"
    SELECTED_USERS=()
    local -a all_users=()
    local -a orphan_users=()
    local -A all_user_lookup=()
    local -A orphan_user_lookup=()
    local username

    if [[ -s $DB_FILE ]]; then
        mapfile -t all_users < <(cut -d: -f1 "$DB_FILE" | sort)
    fi

    if [[ "$include_orphan_users" == "true" ]]; then
        mapfile -t orphan_users < <(get_firewallfalcon_orphan_users)
        for username in "${orphan_users[@]}"; do
            orphan_user_lookup["$username"]=1
            if ! printf "%s\n" "${all_users[@]}" | grep -Fxq "$username"; then
                all_users+=("$username")
            fi
        done
        if [[ ${#all_users[@]} -gt 0 ]]; then
            mapfile -t all_users < <(printf "%s\n" "${all_users[@]}" | sort)
        fi
    fi

    if [[ ${#all_users[@]} -eq 0 ]]; then
        echo -e "${C_YELLOW}ℹ️ No users found in the manager database.${C_RESET}"
        if [[ "$include_orphan_users" == "true" ]]; then
            echo -e "${C_DIM}No orphan Hotscript system users were found either.${C_RESET}"
        fi
        SELECTED_USERS=("NO_USERS"); return
    fi

    for username in "${all_users[@]}"; do
        all_user_lookup["$username"]=1
    done
    
    if [ ${#all_users[@]} -ge 15 ]; then
        read -p "👉 Enter a search term (or press Enter to list all): " search_term
        if [[ -n "$search_term" ]]; then
            mapfile -t users < <(printf "%s\n" "${all_users[@]}" | grep -i "$search_term")
        else
            users=("${all_users[@]}")
        fi
    else
        users=("${all_users[@]}")
    fi

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "\n${C_YELLOW}ℹ️ No users found matching your criteria.${C_RESET}"
        SELECTED_USERS=("NO_USERS"); return
    fi
    echo -e "\nPlease select users:\n"
    for i in "${!users[@]}"; do
        local display_user="${users[$i]}"
        if [[ "$include_orphan_users" == "true" && -n "${orphan_user_lookup[${users[$i]}]+x}" ]]; then
            display_user="${display_user} ${C_DIM}(system-only)${C_RESET}"
        fi
        printf "  ${C_GREEN}[%2d]${C_RESET} %s\n" "$((i+1))" "$display_user"
    done
    echo -e "\n  ${C_GREEN}[all]${C_RESET} Select ALL listed users"
    echo -e "  ${C_RED}  [0]${C_RESET} ↩️ Cancel and return to main menu"
    echo -e "\n${C_CYAN}💡 You can select multiple by number, range, or exact username.${C_RESET}"
    echo -e "${C_CYAN}   Examples: '1 3 5' or '1,3' or '1-4' or 'alice bob'${C_RESET}"
    if [[ "$include_orphan_users" == "true" ]]; then
        echo -e "${C_CYAN}   Users marked '(system-only)' are old accounts still on the VPS but missing from users.db${C_RESET}"
    fi
    echo
    local choice
    while true; do
        if ! read -r -p "👉 Enter user numbers or usernames: " choice; then
            echo
            SELECTED_USERS=()
            return
        fi
        choice=${choice//,/ } # Replace commas with spaces
        
        if [[ -z "$choice" ]]; then
            echo -e "${C_RED}❌ Invalid selection. Please try again.${C_RESET}"
            continue
        fi

        if [[ "$choice" == "0" ]]; then
            SELECTED_USERS=(); return
        fi
        
        if [[ "${choice,,}" == "all" ]]; then
            SELECTED_USERS=("${users[@]}")
            return
        fi
        
        local valid=true
        local selected_indices=()
        local selected_names=()
        for token in $choice; do
            if [[ "$token" =~ ^[0-9]+-[0-9]+$ ]]; then
                local start=${token%-*}
                local end=${token#*-}
                if [ "$start" -le "$end" ]; then
                    for (( idx=start; idx<=end; idx++ )); do
                        if [ "$idx" -ge 1 ] && [ "$idx" -le "${#users[@]}" ]; then
                            selected_indices+=($idx)
                        else
                            valid=false; break
                        fi
                    done
                else
                    valid=false; break
                fi
            elif [[ "$token" =~ ^[0-9]+$ ]]; then
                if [ "$token" -ge 1 ] && [ "$token" -le "${#users[@]}" ]; then
                    selected_indices+=($token)
                elif [[ -n "${all_user_lookup[$token]+x}" ]]; then
                    selected_names+=("$token")
                else
                    valid=false; break
                fi
            elif [[ -n "${all_user_lookup[$token]+x}" ]]; then
                selected_names+=("$token")
            else
                valid=false; break
            fi
        done
        
        if [[ "$valid" == true && ( ${#selected_indices[@]} -gt 0 || ${#selected_names[@]} -gt 0 ) ]]; then
            mapfile -t unique_indices < <(printf "%s\n" "${selected_indices[@]}" | sort -u -n)
            for idx in "${unique_indices[@]}"; do
                SELECTED_USERS+=("${users[$((idx-1))]}")
            done
            if (( ${#selected_names[@]} > 0 )); then
                mapfile -t unique_names < <(printf "%s\n" "${selected_names[@]}" | sort -u)
                for username in "${unique_names[@]}"; do
                    if [[ -n "$username" ]] && ! printf "%s\n" "${SELECTED_USERS[@]}" | grep -Fxq "$username"; then
                        SELECTED_USERS+=("$username")
                    fi
                done
            fi
            return
        else
            echo -e "${C_RED}❌ Invalid selection. Please check your numbers or usernames.${C_RESET}"
            SELECTED_USERS=()
            selected_indices=()
            selected_names=()
        fi
    done
}

get_user_status() {
    local username="$1"
    if ! id "$username" &>/dev/null; then echo -e "${C_RED}Not Found${C_RESET}"; return; fi
    local expiry_date=$(grep "^$username:" "$DB_FILE" | cut -d: -f3)
    if passwd -S "$username" 2>/dev/null | grep -q " L "; then echo -e "${C_YELLOW}🔒 Locked${C_RESET}"; return; fi
    local expiry_ts=$(date -d "$expiry_date" +%s 2>/dev/null || echo 0)
    local current_ts=$(date +%s)
    if [[ $expiry_ts -lt $current_ts ]]; then echo -e "${C_RED}🗓️ Expired${C_RESET}"; return; fi
    echo -e "${C_GREEN}🟢 Active${C_RESET}"
}

create_user() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- ✨ Create New SSH User ---${C_RESET}"
    read -p "👉 Enter username (or '0' to cancel): " username
    local adopt_existing=false
    if [[ "$username" == "0" ]]; then
        echo -e "\n${C_YELLOW}❌ User creation cancelled.${C_RESET}"
        return
    fi
    if [[ -z "$username" ]]; then
        echo -e "\n${C_RED}❌ Error: Username cannot be empty.${C_RESET}"
        return
    fi
    if db_has_user "$username"; then
        echo -e "\n${C_RED}❌ Error: User '$username' already exists in Hotscript.${C_RESET}"
        return
    fi
    if id "$username" &>/dev/null; then
        if is_firewallfalcon_orphan_user "$username"; then
            echo -e "\n${C_YELLOW}⚠️ User '$username' already exists on the system but is missing from users.db.${C_RESET}"
            echo -e "${C_DIM}This usually happens after uninstalling the script without deleting the SSH users.${C_RESET}"
            read -p "👉 Do you want to take control of this existing user and manage it with Hotscript? (y/n): " adopt_confirm
            if [[ "$adopt_confirm" == "y" || "$adopt_confirm" == "Y" ]]; then
                adopt_existing=true
            else
                echo -e "\n${C_YELLOW}❌ User creation cancelled.${C_RESET}"
                return
            fi
        else
            echo -e "\n${C_RED}❌ Error: System user '$username' already exists and does not look like a Hotscript SSH account.${C_RESET}"
            return
        fi
    fi
    local password=""
    while true; do
        read -p "🔑 Enter password (or press Enter for auto-generated): " password
        if [[ -z "$password" ]]; then
            password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
            echo -e "${C_GREEN}🔑 Auto-generated password: ${C_YELLOW}$password${C_RESET}"
            break
        else
            break
        fi
    done
    read -p "🗓️ Enter account duration (in days) [30]: " days
    days=${days:-30}
    if ! [[ "$days" =~ ^[0-9]+$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    read -p "📶 Enter simultaneous connection limit [1]: " limit
    limit=${limit:-1}
    if ! [[ "$limit" =~ ^[0-9]+$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    read -p "📦 Enter bandwidth limit in GB (0 = unlimited) [0]: " bandwidth_gb
    bandwidth_gb=${bandwidth_gb:-0}
    if ! [[ "$bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    read -p "📦 Enter DAILY bandwidth limit in GB (0 = unlimited) [0]: " daily_bandwidth_gb
    daily_bandwidth_gb=${daily_bandwidth_gb:-0}
    if ! [[ "$daily_bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    local expire_date
    expire_date=$(date -d "+$days days" +%Y-%m-%d)
    ensure_firewallfalcon_system_group
    if [[ "$adopt_existing" == "true" ]]; then
        usermod -s /usr/sbin/nologin "$username" &>/dev/null
    else
        useradd -m -s /usr/sbin/nologin "$username"
    fi
    usermod -aG "$FF_USERS_GROUP" "$username" 2>/dev/null
    echo "$username:$password" | chpasswd; chage -E "$expire_date" "$username"
    echo "$username:$password:$expire_date:$limit:$bandwidth_gb:$daily_bandwidth_gb:trial" >> "$DB_FILE"
    
    local bw_display="Unlimited"
    if [[ "$bandwidth_gb" != "0" ]]; then bw_display="${bandwidth_gb} GB"; fi
    local daily_bw_display="Unlimited"
    if [[ "$daily_bandwidth_gb" != "0" ]]; then daily_bw_display="${daily_bandwidth_gb} GB/day"; fi
    
    clear; show_banner
    if [[ "$adopt_existing" == "true" ]]; then
        echo -e "${C_GREEN}✅ Existing system user '$username' has been imported into Hotscript!${C_RESET}\n"
    else
        echo -e "${C_GREEN}✅ User '$username' created successfully!${C_RESET}\n"
    fi
    echo -e "  - 👤 Username:          ${C_YELLOW}$username${C_RESET}"
    echo -e "  - 🔑 Password:          ${C_YELLOW}$password${C_RESET}"
    echo -e "  - 🗓️ Expires on:        ${C_YELLOW}$expire_date${C_RESET}"
    echo -e "  - 📶 Connection Limit:  ${C_YELLOW}$limit${C_RESET}"
    echo -e "  - 📦 Total Bandwidth:   ${C_YELLOW}$bw_display${C_RESET}"
    echo -e "  - 📦 Daily Bandwidth:   ${C_YELLOW}$daily_bw_display${C_RESET}"
    echo -e "    ${C_DIM}(Active monitoring service will enforce these limits)${C_RESET}"

    # Auto-ask for config generation
    echo
    read -p "👉 Do you want to generate a client connection config for this user? (y/n): " gen_conf
    if [[ "$gen_conf" == "y" || "$gen_conf" == "Y" ]]; then
        generate_client_config "$username" "$password"
    fi
    
    invalidate_banner_cache
    refresh_dynamic_banner_routing_if_enabled
}

delete_user() {
    _select_multi_user_interface "--- 🗑️ Delete Hotscript Users ---" "true"
    if [[ ${#SELECTED_USERS[@]} -eq 0 || "${SELECTED_USERS[0]}" == "NO_USERS" ]]; then return; fi
    
    echo -e "\n${C_RED}⚠️ You selected ${#SELECTED_USERS[@]} user(s) to delete: ${C_YELLOW}${SELECTED_USERS[*]}${C_RESET}"
    read -p "👉 Are you sure you want to PERMANENTLY delete them? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then echo -e "\n${C_YELLOW}❌ Deletion cancelled.${C_RESET}"; return; fi
    
    echo -e "\n${C_BLUE}🗑️ Deleting selected users...${C_RESET}"
    delete_firewallfalcon_user_accounts "${SELECTED_USERS[@]}"
}

edit_user() {
    _select_user_interface "--- ✏️ Edit a User ---"
    local username=$SELECTED_USER
    if [[ "$username" == "NO_USERS" ]] || [[ -z "$username" ]]; then return; fi
    while true; do
        clear; show_banner; echo -e "${C_BOLD}${C_PURPLE}--- Editing User: ${C_YELLOW}$username${C_PURPLE} ---${C_RESET}"
        
        # Show current user details
        local current_line; current_line=$(grep "^$username:" "$DB_FILE")
        local cur_pass cur_expiry cur_limit cur_bw cur_daily_bw
        IFS=: read -r _ cur_pass cur_expiry cur_limit cur_bw cur_daily_bw _ <<< "$current_line"
        [[ -z "$cur_bw" ]] && cur_bw="0"
        [[ ! "$cur_daily_bw" =~ ^[0-9]+\.?[0-9]*$ ]] && cur_daily_bw="0"
        
        local cur_bw_display="Unlimited"; [[ "$cur_bw" != "0" ]] && cur_bw_display="${cur_bw} GB"
        local cur_daily_bw_display="Unlimited"; [[ "$cur_daily_bw" != "0" ]] && cur_daily_bw_display="${cur_daily_bw} GB/day"
        
        # Show bandwidth usage
        local bw_used_display="N/A"
        if [[ -f "$BANDWIDTH_DIR/${username}.usage" ]]; then
            local used_bytes=0; read -r used_bytes < "$BANDWIDTH_DIR/${username}.usage" 2>/dev/null || used_bytes=0
            if [[ -n "$used_bytes" && "$used_bytes" != "0" ]]; then
                bw_used_display=$(awk "BEGIN {printf \"%.2f GB\", $used_bytes / 1073741824}")
            else
                bw_used_display="0.00 GB"
            fi
        fi
        
        local daily_bw_used_display="N/A"
        if [[ -f "$BANDWIDTH_DIR/${username}.daily_usage" ]]; then
            local d_used_bytes=0; read -r d_used_bytes < "$BANDWIDTH_DIR/${username}.daily_usage" 2>/dev/null || d_used_bytes=0
            if [[ -n "$d_used_bytes" && "$d_used_bytes" != "0" ]]; then
                daily_bw_used_display=$(awk "BEGIN {printf \"%.2f GB\", $d_used_bytes / 1073741824}")
            else
                daily_bw_used_display="0.00 GB"
            fi
        fi
        
        echo -e "\n  ${C_DIM}Current: Pass=${C_YELLOW}$cur_pass${C_RESET}${C_DIM} Exp=${C_YELLOW}$cur_expiry${C_RESET}${C_DIM} Conn=${C_YELLOW}$cur_limit${C_RESET}${C_DIM} BW=${C_YELLOW}$cur_bw_display${C_RESET}${C_DIM} Used=${C_CYAN}$bw_used_display${C_RESET}${C_DIM} Daily BW=${C_YELLOW}$cur_daily_bw_display${C_RESET}${C_DIM} Daily Used=${C_CYAN}$daily_bw_used_display${C_RESET}"
        echo -e "\nSelect a detail to edit:\n"
        printf "  ${C_GREEN}[ 1]${C_RESET} %-35s\n" "🔑 Change Password"
        printf "  ${C_GREEN}[ 2]${C_RESET} %-35s\n" "🗓️ Change Expiration Date"
        printf "  ${C_GREEN}[ 3]${C_RESET} %-35s\n" "📶 Change Connection Limit"
        printf "  ${C_GREEN}[ 4]${C_RESET} %-35s\n" "📦 Change Total Bandwidth Limit"
        printf "  ${C_GREEN}[ 5]${C_RESET} %-35s\n" "📦 Change Daily Bandwidth Limit"
        printf "  ${C_GREEN}[ 6]${C_RESET} %-35s\n" "🔄 Reset Bandwidth Counters"
        echo -e "\n  ${C_RED}[ 0]${C_RESET} ✅ Finish Editing"
        echo
        if ! read -r -p "👉 Enter your choice: " edit_choice; then
            echo
            return
        fi
        case $edit_choice in
            1)
               local new_pass=""
               read -p "Enter new password (or press Enter for auto-generated): " new_pass
               if [[ -z "$new_pass" ]]; then
                   new_pass=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
                   echo -e "${C_GREEN}🔑 Auto-generated: ${C_YELLOW}$new_pass${C_RESET}"
               fi
               echo "$username:$new_pass" | chpasswd
               sed -i "s/^$username:.*/$username:$new_pass:$cur_expiry:$cur_limit:$cur_bw:$cur_daily_bw/" "$DB_FILE"
               echo -e "\n${C_GREEN}✅ Password for '$username' changed to: ${C_YELLOW}$new_pass${C_RESET}"
               ;;
            2) read -p "Enter new duration (in days from today): " days
               if [[ "$days" =~ ^[0-9]+$ ]]; then
                   local new_expire_date; new_expire_date=$(date -d "+$days days" +%Y-%m-%d); chage -E "$new_expire_date" "$username"
                   sed -i "s/^$username:.*/$username:$cur_pass:$new_expire_date:$cur_limit:$cur_bw:$cur_daily_bw/" "$DB_FILE"
                   echo -e "\n${C_GREEN}✅ Expiration for '$username' set to ${C_YELLOW}$new_expire_date${C_RESET}."
               else echo -e "\n${C_RED}❌ Invalid number of days.${C_RESET}"; fi ;;
            3) read -p "Enter new simultaneous connection limit: " new_limit
               if [[ "$new_limit" =~ ^[0-9]+$ ]]; then
                   sed -i "s/^$username:.*/$username:$cur_pass:$cur_expiry:$new_limit:$cur_bw:$cur_daily_bw/" "$DB_FILE"
                   echo -e "\n${C_GREEN}✅ Connection limit for '$username' set to ${C_YELLOW}$new_limit${C_RESET}."
               else echo -e "\n${C_RED}❌ Invalid limit.${C_RESET}"; fi ;;
            4) read -p "Enter new TOTAL bandwidth limit in GB (0 = unlimited): " new_bw
               if [[ "$new_bw" =~ ^[0-9]+\.?[0-9]*$ ]]; then
                   sed -i "s/^$username:.*/$username:$cur_pass:$cur_expiry:$cur_limit:$new_bw:$cur_daily_bw/" "$DB_FILE"
                   local bw_msg="Unlimited"; [[ "$new_bw" != "0" ]] && bw_msg="${new_bw} GB"
                   echo -e "\n${C_GREEN}✅ Total bandwidth limit for '$username' set to ${C_YELLOW}$bw_msg${C_RESET}."
                   # Unlock user if they were locked due to bandwidth
                   if [[ "$new_bw" == "0" ]] || [[ -f "$BANDWIDTH_DIR/${username}.usage" ]]; then
                       local used_bytes; used_bytes=$(cat "$BANDWIDTH_DIR/${username}.usage" 2>/dev/null || echo 0)
                       local new_quota_bytes; new_quota_bytes=$(awk "BEGIN {printf \"%.0f\", $new_bw * 1073741824}")
                       if [[ "$new_bw" == "0" ]] || [[ "$used_bytes" -lt "$new_quota_bytes" ]]; then
                           usermod -U "$username" &>/dev/null
                       fi
                   fi
               else echo -e "\n${C_RED}❌ Invalid bandwidth value.${C_RESET}"; fi ;;
            5) read -p "Enter new DAILY bandwidth limit in GB (0 = unlimited): " new_daily_bw
               if [[ "$new_daily_bw" =~ ^[0-9]+\.?[0-9]*$ ]]; then
                   sed -i "s/^$username:.*/$username:$cur_pass:$cur_expiry:$cur_limit:$cur_bw:$new_daily_bw/" "$DB_FILE"
                   local daily_bw_msg="Unlimited"; [[ "$new_daily_bw" != "0" ]] && daily_bw_msg="${new_daily_bw} GB/day"
                   echo -e "\n${C_GREEN}✅ Daily bandwidth limit for '$username' set to ${C_YELLOW}$daily_bw_msg${C_RESET}."
                   # Unlock user if they were locked due to daily bandwidth
                   if [[ "$new_daily_bw" == "0" ]] || [[ -f "$BANDWIDTH_DIR/${username}.daily_usage" ]]; then
                       local d_used_bytes; d_used_bytes=$(cat "$BANDWIDTH_DIR/${username}.daily_usage" 2>/dev/null || echo 0)
                       local new_d_quota_bytes; new_d_quota_bytes=$(awk "BEGIN {printf \"%.0f\", $new_daily_bw * 1073741824}")
                       if [[ "$new_daily_bw" == "0" ]] || [[ "$d_used_bytes" -lt "$new_d_quota_bytes" ]]; then
                           usermod -U "$username" &>/dev/null
                           rm -f "$BANDWIDTH_DIR/${username}.daily_locked"
                       fi
                   fi
               else echo -e "\n${C_RED}❌ Invalid bandwidth value.${C_RESET}"; fi ;;
            6)
               echo "0" > "$BANDWIDTH_DIR/${username}.usage"
               echo "0" > "$BANDWIDTH_DIR/${username}.daily_usage"
               rm -f "$BANDWIDTH_DIR/${username}.daily_locked"
               # Unlock user if they were locked due to bandwidth
               usermod -U "$username" &>/dev/null
               echo -e "\n${C_GREEN}✅ All bandwidth counters for '$username' have been reset to 0.${C_RESET}"
               ;;
            0) return ;;
            *) echo -e "\n${C_RED}❌ Invalid option.${C_RESET}" ;;
        esac
        echo -e "\nPress ${C_YELLOW}[Enter]${C_RESET} to continue editing..." && read -r || return
    done
}

lock_user() {
    _select_multi_user_interface "--- 🔒 Lock Users (from DB) ---"
    if [[ ${#SELECTED_USERS[@]} -eq 0 || "${SELECTED_USERS[0]}" == "NO_USERS" ]]; then return; fi
    
    echo -e "\n${C_BLUE}🔒 Locking selected users...${C_RESET}"
    for u in "${SELECTED_USERS[@]}"; do
        if ! id "$u" &>/dev/null; then
             echo -e " ❌ User '${C_YELLOW}$u${C_RESET}' does not exist on this system."
             continue
        fi
        
        usermod -L "$u"
        if [ $? -eq 0 ]; then
            killall -u "$u" -9 &>/dev/null
            echo -e " ✅ ${C_YELLOW}$u${C_RESET} locked and active sessions killed."
        else
            echo -e " ❌ Failed to lock ${C_YELLOW}$u${C_RESET}."
        fi
    done
}

unlock_user() {
    _select_multi_user_interface "--- 🔓 Unlock Users (from DB) ---"
    if [[ ${#SELECTED_USERS[@]} -eq 0 || "${SELECTED_USERS[0]}" == "NO_USERS" ]]; then return; fi
    
    echo -e "\n${C_BLUE}🔓 Unlocking selected users...${C_RESET}"
    for u in "${SELECTED_USERS[@]}"; do
        if ! id "$u" &>/dev/null; then
             echo -e " ❌ User '${C_YELLOW}$u${C_RESET}' does not exist on this system."
             continue
        fi
        
        usermod -U "$u"
        if [ $? -eq 0 ]; then
            echo -e " ✅ ${C_YELLOW}$u${C_RESET} unlocked."
        else
            echo -e " ❌ Failed to unlock ${C_YELLOW}$u${C_RESET}."
        fi
    done
}

list_users() {
    clear; show_banner
    if [[ ! -s "$DB_FILE" ]]; then
        echo -e "\n${C_YELLOW}ℹ️ No users are currently being managed.${C_RESET}"
        return
    fi
    echo -e "${C_BOLD}${C_PURPLE}--- 📋 Managed Users ---${C_RESET}"
    echo -e "${C_YELLOW}---------------------------------------------------------------------------------------------------${C_RESET}"
    printf "${C_BOLD}${C_WHITE}%-18s | %-12s | %-10s | %-25s | %-20s${C_RESET}\n" "USERNAME" "EXPIRATION" "SESSIONS" "BANDWIDTH" "STATUS"
    echo -e "${C_YELLOW}---------------------------------------------------------------------------------------------------${C_RESET}"

    local current_ts
    printf -v current_ts '%(%s)T' -1
    local -A system_user_lookup=()
    local -A locked_user_lookup=()

    while IFS=: read -r system_user _rest; do
        [[ -n "$system_user" ]] && system_user_lookup["$system_user"]=1
    done < /etc/passwd

    if [[ -r /etc/shadow ]]; then
        while IFS=: read -r shadow_user shadow_hash _rest; do
            [[ -n "$shadow_user" && "${shadow_hash:0:1}" == "!" ]] && locked_user_lookup["$shadow_user"]=1
        done < /etc/shadow
    else
        while read -r passwd_user _ passwd_status _rest; do
            [[ -z "$passwd_user" ]] && continue
            [[ "$passwd_status" == "L" ]] && locked_user_lookup["$passwd_user"]=1
        done < <(passwd -Sa 2>/dev/null)
    fi
    refresh_ssh_session_cache

    while IFS=: read -r user pass expiry limit bandwidth_gb daily_bandwidth_gb _extra; do
        local online_count="${SSH_SESSION_COUNTS[$user]:-0}"
        local connection_string="$online_count / $limit"
        local plain_status="Active"
        local status="${C_GREEN}🟢 Active${C_RESET}"
        local quota_exceeded=false

        [[ -z "$bandwidth_gb" ]] && bandwidth_gb="0"
        [[ ! "$daily_bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]] && daily_bandwidth_gb="0"
        
        local bw_string="Unlimited"
        local total_str=""
        local daily_str=""
        
        if [[ "$bandwidth_gb" != "0" ]]; then
            local used_bytes=0
            if [[ -f "$BANDWIDTH_DIR/${user}.usage" ]]; then
                read -r used_bytes < "$BANDWIDTH_DIR/${user}.usage" 2>/dev/null || used_bytes=0
                [[ "$used_bytes" =~ ^[0-9]+$ ]] || used_bytes=0
            fi
            local used_gb
            used_gb=$(awk "BEGIN {printf \"%.1f\", $used_bytes / 1073741824}")
            total_str="${used_gb}/${bandwidth_gb}G"
            local quota_bytes
            quota_bytes=$(awk "BEGIN {printf \"%.0f\", $bandwidth_gb * 1073741824}")
            if [[ "$quota_bytes" =~ ^[0-9]+$ ]] && (( used_bytes >= quota_bytes )); then
                quota_exceeded=true
            fi
        fi
        
        if [[ "$daily_bandwidth_gb" != "0" ]]; then
            local d_used_bytes=0
            if [[ -f "$BANDWIDTH_DIR/${user}.daily_usage" ]]; then
                read -r d_used_bytes < "$BANDWIDTH_DIR/${user}.daily_usage" 2>/dev/null || d_used_bytes=0
                [[ "$d_used_bytes" =~ ^[0-9]+$ ]] || d_used_bytes=0
            fi
            local d_used_gb
            d_used_gb=$(awk "BEGIN {printf \"%.1f\", $d_used_bytes / 1073741824}")
            daily_str="${d_used_gb}/${daily_bandwidth_gb}G/d"
            local d_quota_bytes
            d_quota_bytes=$(awk "BEGIN {printf \"%.0f\", $daily_bandwidth_gb * 1073741824}")
            if [[ "$d_quota_bytes" =~ ^[0-9]+$ ]] && (( d_used_bytes >= d_quota_bytes )); then
                quota_exceeded=true
            fi
        fi
        
        if [[ -n "$total_str" && -n "$daily_str" ]]; then
            bw_string="$total_str | $daily_str"
        elif [[ -n "$total_str" ]]; then
            bw_string="$total_str"
        elif [[ -n "$daily_str" ]]; then
            bw_string="$daily_str"
        fi

        if [[ -z "${system_user_lookup[$user]+x}" ]]; then
            plain_status="Not Found"
            status="${C_RED}Not Found${C_RESET}"
        elif [[ -n "$expiry" && "$expiry" != "Never" ]]; then
            local expiry_ts
            expiry_ts=$(date -d "$expiry" +%s 2>/dev/null || echo 0)
            if [[ "$expiry_ts" =~ ^[0-9]+$ ]] && (( expiry_ts > 0 && expiry_ts < current_ts )); then
                plain_status="Expired"
                status="${C_RED}🗓️ Expired${C_RESET}"
            fi
        fi

        if [[ "$plain_status" == "Active" && "$quota_exceeded" == true ]]; then
            if [[ -n "${locked_user_lookup[$user]+x}" ]]; then
                plain_status="BW Locked"
                status="${C_RED}🔒 BW Locked${C_RESET}"
            else
                plain_status="Quota Exceeded"
                status="${C_RED}📦 Quota Exceeded${C_RESET}"
            fi
        elif [[ "$plain_status" == "Active" && -n "${locked_user_lookup[$user]+x}" ]]; then
            plain_status="Locked"
            status="${C_YELLOW}🔒 Locked${C_RESET}"
        fi

        local line_color="$C_WHITE"
        case "$plain_status" in
            "Active") line_color="$C_GREEN" ;;
            "Locked") line_color="$C_YELLOW" ;;
            "Expired") line_color="$C_RED" ;;
            "BW Locked") line_color="$C_RED" ;;
            "Quota Exceeded") line_color="$C_RED" ;;
            "Not Found") line_color="$C_DIM" ;;
        esac

        printf "${line_color}%-18s ${C_RESET}| ${C_YELLOW}%-12s ${C_RESET}| ${C_CYAN}%-10s ${C_RESET}| ${C_ORANGE}%-25s ${C_RESET}| %-20s\n" "$user" "$expiry" "$connection_string" "$bw_string" "$status"
    done < <(sort "$DB_FILE")
    echo -e "${C_CYAN}=========================================================================================${C_RESET}\n"
}

renew_user() {
    _select_multi_user_interface "--- 🔄 Renew Users ---"
    if [[ ${#SELECTED_USERS[@]} -eq 0 || "${SELECTED_USERS[0]}" == "NO_USERS" ]]; then return; fi
    read -p "👉 Enter number of days to extend the account(s): " days; if ! [[ "$days" =~ ^[0-9]+$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    local new_expire_date; new_expire_date=$(date -d "+$days days" +%Y-%m-%d)
    
    echo -e "\n${C_BLUE}🔄 Renewing selected users for $days days...${C_RESET}"
    for u in "${SELECTED_USERS[@]}"; do
        chage -E "$new_expire_date" "$u"
        local line pass _expiry limit bw
        line=$(grep "^$u:" "$DB_FILE")
        IFS=: read -r _ pass _expiry limit bw _ <<< "$line"
        [[ -z "$bw" ]] && bw="0"
        sed -i "s/^$u:.*/$u:$pass:$new_expire_date:$limit:$bw/" "$DB_FILE"
        echo -e " ✅ ${C_YELLOW}$u${C_RESET} renewed until ${C_GREEN}${new_expire_date}${C_RESET}."
    done
}

cleanup_expired() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🧹 Cleanup Expired Users ---${C_RESET}"
    
    local expired_users=()
    local current_ts
    current_ts=$(date +%s)

    if [[ ! -s "$DB_FILE" ]]; then
        echo -e "\n${C_GREEN}✅ User database is empty. No expired users found.${C_RESET}"
        return
    fi
    
    while IFS=: read -r user pass expiry limit bandwidth_gb _extra; do
        local expiry_ts
        expiry_ts=$(date -d "$expiry" +%s 2>/dev/null || echo 0)
        
        if [[ $expiry_ts -lt $current_ts && $expiry_ts -ne 0 ]]; then
            expired_users+=("$user")
        fi
    done < "$DB_FILE"

    if [ ${#expired_users[@]} -eq 0 ]; then
        echo -e "\n${C_GREEN}✅ No expired users found.${C_RESET}"
        return
    fi

    echo -e "\nThe following users have expired: ${C_RED}${expired_users[*]}${C_RESET}"
    read -p "👉 Do you want to delete all of them? (y/n): " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo -e "\n${C_BLUE}🗑️ Deleting expired users...${C_RESET}"
        delete_firewallfalcon_user_accounts "${expired_users[@]}"
        echo -e "\n${C_GREEN}✅ Expired users have been cleaned up.${C_RESET}"
    else
        echo -e "\n${C_YELLOW}❌ Cleanup cancelled.${C_RESET}"
    fi
}


backup_user_data() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 💾 Backup User Data ---${C_RESET}"
    read -p "👉 Enter path for backup file [/root/firewallfalcon_users.tar.gz]: " backup_path
    backup_path=${backup_path:-/root/firewallfalcon_users.tar.gz}
    if [ ! -d "$DB_DIR" ] || [ ! -s "$DB_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ No user data found to back up.${C_RESET}"
        return
    fi
    echo -e "\n${C_BLUE}⚙️ Backing up user database and settings to ${C_YELLOW}$backup_path${C_RESET}..."
    tar -czf "$backup_path" -C "$(dirname "$DB_DIR")" "$(basename "$DB_DIR")"
    if [ $? -eq 0 ]; then
        echo -e "\n${C_GREEN}✅ SUCCESS: User data backup created at ${C_YELLOW}$backup_path${C_RESET}"
    else
        echo -e "\n${C_RED}❌ ERROR: Backup failed.${C_RESET}"
    fi
}

restore_user_data() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📥 Restore User Data ---${C_RESET}"
    read -p "👉 Enter the full path to the user data backup file [/root/firewallfalcon_users.tar.gz]: " backup_path
    backup_path=${backup_path:-/root/firewallfalcon_users.tar.gz}
    if [ ! -f "$backup_path" ]; then
        echo -e "\n${C_RED}❌ ERROR: Backup file not found at '$backup_path'.${C_RESET}"
        return
    fi
    echo -e "\n${C_RED}${C_BOLD}⚠️ WARNING:${C_RESET} This will overwrite all current users and settings."
    echo -e "It will restore user accounts, passwords, limits, and expiration dates from the backup file."
    read -p "👉 Are you absolutely sure you want to proceed? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then echo -e "\n${C_YELLOW}❌ Restore cancelled.${C_RESET}"; return; fi
    local temp_dir
    temp_dir=$(mktemp -d)
    echo -e "\n${C_BLUE}⚙️ Extracting backup file to a temporary location...${C_RESET}"
    tar -xzf "$backup_path" -C "$temp_dir"
    if [ $? -ne 0 ]; then
        echo -e "\n${C_RED}❌ ERROR: Failed to extract backup file. Aborting.${C_RESET}"
        rm -rf "$temp_dir"
        return
    fi
    local restored_db_file="$temp_dir/firewallfalcon/users.db"
    if [ ! -f "$restored_db_file" ]; then
        echo -e "\n${C_RED}❌ ERROR: users.db not found in the backup. Cannot restore user accounts.${C_RESET}"
        rm -rf "$temp_dir"
        return
    fi
    echo -e "${C_BLUE}⚙️ Overwriting current user database...${C_RESET}"
    mkdir -p "$DB_DIR"
    cp "$restored_db_file" "$DB_FILE"
    if [ -d "$temp_dir/firewallfalcon/ssl" ]; then
        cp -r "$temp_dir/firewallfalcon/ssl" "$DB_DIR/"
    fi
    if [ -d "$temp_dir/firewallfalcon/dnstt" ]; then
        cp -r "$temp_dir/firewallfalcon/dnstt" "$DB_DIR/"
    fi
    if [ -f "$temp_dir/firewallfalcon/dns_info.conf" ]; then
        cp "$temp_dir/firewallfalcon/dns_info.conf" "$DB_DIR/"
    fi
    if [ -f "$temp_dir/firewallfalcon/dnstt_info.conf" ]; then
        cp "$temp_dir/firewallfalcon/dnstt_info.conf" "$DB_DIR/"
    fi
    if [ -f "$temp_dir/firewallfalcon/falconproxy_config.conf" ]; then
        cp "$temp_dir/firewallfalcon/falconproxy_config.conf" "$DB_DIR/"
    fi
    
    echo -e "${C_BLUE}⚙️ Re-synchronizing system accounts with the restored database...${C_RESET}"
    ensure_firewallfalcon_system_group
    
    while IFS=: read -r user pass expiry limit; do
        echo "Processing user: ${C_YELLOW}$user${C_RESET}"
        if ! id "$user" &>/dev/null; then
            echo " - User does not exist in system. Creating..."
            useradd -m -s /usr/sbin/nologin "$user"
        fi
        usermod -aG "$FF_USERS_GROUP" "$user" 2>/dev/null
        echo " - Setting password..."
        echo "$user:$pass" | chpasswd
        echo " - Setting expiration to $expiry..."
        chage -E "$expiry" "$user"
        echo " - Connection limit is $limit (enforced by PAM)"
    done < "$DB_FILE"
    rm -rf "$temp_dir"
    echo -e "\n${C_GREEN}✅ SUCCESS: User data restore completed.${C_RESET}"
    
    invalidate_banner_cache
    refresh_dynamic_banner_routing_if_enabled
}

_enable_banner_in_sshd_config() {
    echo -e "\n${C_BLUE}⚙️ Configuring sshd_config...${C_RESET}"
    disable_dynamic_ssh_banner_system
    sed -i.bak -E 's/^( *Banner *).*/#\1/' /etc/ssh/sshd_config
    if ! grep -q -E "^Banner $SSH_BANNER_FILE" /etc/ssh/sshd_config; then
        echo -e "\n# Hotscript SSH Banner\nBanner $SSH_BANNER_FILE" >> /etc/ssh/sshd_config
    fi
    echo -e "${C_GREEN}✅ sshd_config updated.${C_RESET}"
}

_restart_ssh() {
    echo -e "\n${C_BLUE}🔄 Restarting SSH service to apply changes...${C_RESET}"
    local ssh_service_name=""
    if [ -f /lib/systemd/system/sshd.service ]; then
        ssh_service_name="sshd.service"
    elif [ -f /lib/systemd/system/ssh.service ]; then
        ssh_service_name="ssh.service"
    else
        echo -e "${C_RED}❌ Could not find sshd.service or ssh.service. Cannot restart SSH.${C_RESET}"
        return 1
    fi

    systemctl restart "${ssh_service_name}"
    if [ $? -eq 0 ]; then
        echo -e "${C_GREEN}✅ SSH service ('${ssh_service_name}') restarted successfully.${C_RESET}"
    else
        echo -e "${C_RED}❌ Failed to restart SSH service ('${ssh_service_name}'). Please check 'journalctl -u ${ssh_service_name}' for errors.${C_RESET}"
    fi
}

set_ssh_banner_paste() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📋 Paste Static SSH Banner ---${C_RESET}"
    echo -e "Paste your custom banner below. Press ${C_YELLOW}[Ctrl+D]${C_RESET} when you are finished."
    echo -e "${C_DIM}This will be shown to all SSH users through 'Banner $SSH_BANNER_FILE'.${C_RESET}"
    echo -e "${C_DIM}The current banner (if any) will be overwritten.${C_RESET}"
    echo -e "--------------------------------------------------"
    cat > "$SSH_BANNER_FILE"
    chmod 644 "$SSH_BANNER_FILE"
    echo -e "\n--------------------------------------------------"
    echo -e "\n${C_GREEN}✅ Static banner content saved.${C_RESET}"
    _enable_banner_in_sshd_config
    _restart_ssh
    echo -e "\nPress ${C_YELLOW}[Enter]${C_RESET} to return..." && read -r
}

view_ssh_banner() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 👁️ Current SSH Banner ---${C_RESET}"
    if [ -f "$SSH_BANNER_FILE" ]; then
        echo -e "\n${C_CYAN}--- BEGIN BANNER ---${C_RESET}"
        cat "$SSH_BANNER_FILE"
        echo -e "${C_CYAN}---- END BANNER ----${C_RESET}"
    else
        echo -e "\n${C_YELLOW}ℹ️ No banner file found at $SSH_BANNER_FILE.${C_RESET}"
    fi
    echo -e "\nPress ${C_YELLOW}[Enter]${C_RESET} to return..." && read -r
}

remove_ssh_banner() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🗑️ Disable SSH Banners ---${C_RESET}"
    read -p "👉 Are you sure you want to disable all SSH banners? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo -e "\n${C_YELLOW}❌ Action cancelled.${C_RESET}"
        echo -e "\nPress ${C_YELLOW}[Enter]${C_RESET} to return..." && read -r
        return
    fi
    if [ -f "$SSH_BANNER_FILE" ]; then
        rm -f "$SSH_BANNER_FILE"
        echo -e "\n${C_GREEN}✅ Removed banner file: $SSH_BANNER_FILE${C_RESET}"
    else
        echo -e "\n${C_YELLOW}ℹ️ No banner file to remove.${C_RESET}"
    fi
    disable_dynamic_ssh_banner_system
    echo -e "\n${C_BLUE}⚙️ Disabling banner in sshd_config...${C_RESET}"
    disable_static_ssh_banner_in_sshd_config
    echo -e "${C_GREEN}✅ Banner disabled in configuration.${C_RESET}"
    _restart_ssh
    echo -e "\nPress ${C_YELLOW}[Enter]${C_RESET} to return..." && read -r
}

preview_dynamic_ssh_banner() {
    if ! is_dynamic_ssh_banner_enabled; then
        echo -e "\n${C_RED}❌ Dynamic banners are not enabled right now.${C_RESET}"
        press_enter
        return
    fi

    echo -e "${C_DIM}Refreshing dynamic banner worker...${C_RESET}"
    setup_limiter_service >/dev/null 2>&1
    _select_user_interface "--- 📝 Preview Dynamic Banner ---"
    local u=$SELECTED_USER
    if [[ -z "$u" || "$u" == "NO_USERS" ]]; then
        return
    fi

    echo -e "\n${C_CYAN}--- Dynamic Banner Preview for user '$u' ---${C_RESET}\n"
    if [[ -f "/etc/firewallfalcon/banners/${u}.txt" ]]; then
        cat "/etc/firewallfalcon/banners/${u}.txt"
    else
        echo -e "${C_RED}Banner file not generated yet. Waiting up to 10s for the worker...${C_RESET}"
        sleep 5
        if ! cat "/etc/firewallfalcon/banners/${u}.txt" 2>/dev/null; then
            echo -e "\n${C_RED}Still not generated. Here are the last limiter logs:${C_RESET}"
            echo -e "----------------------------------------------------------------------"
            journalctl -u firewallfalcon-limiter -n 15 --no-pager
            echo -e "----------------------------------------------------------------------"
        fi
    fi
    press_enter
}

# NOTE: The full ssh_banner_menu() with dynamic/static support is defined later in the file.

install_udp_custom() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Installing udp-custom ---${C_RESET}"
    if [ -f "$UDP_CUSTOM_SERVICE_FILE" ] || [ -f "$UDPGW_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ udp-custom is already installed.${C_RESET}"
        return
    fi

    check_and_free_ports 36712 7800 || return
    check_and_open_firewall_port 36712 udp || return

    echo -e "\n${C_GREEN}⚙️ Creating directory for udp-custom...${C_RESET}"
    rm -rf "$UDP_CUSTOM_DIR"
    mkdir -p "$UDP_CUSTOM_DIR"

    echo -e "\n${C_GREEN}⚙️ Detecting system architecture...${C_RESET}"
    local arch
    arch=$(uname -m)
    local binary_url=""
    if [[ "$arch" == "x86_64" ]]; then
        binary_url="https://raw.githubusercontent.com/noelrubio143/hotscript/main/udp/udp-custom-linux-amd64"
        echo -e "${C_BLUE}ℹ️ Detected x86_64 (amd64) architecture.${C_RESET}"
    elif [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
        binary_url="https://raw.githubusercontent.com/noelrubio143/hotscript/main/udp/udp-custom-linux-arm"
        echo -e "${C_BLUE}ℹ️ Detected ARM64 architecture.${C_RESET}"
    else
        echo -e "\n${C_RED}❌ Unsupported architecture: $arch. Cannot install udp-custom.${C_RESET}"
        rm -rf "$UDP_CUSTOM_DIR"
        return
    fi

    echo -e "\n${C_GREEN}📥 Downloading udp-custom binary...${C_RESET}"
    wget -q --show-progress -O "$UDP_CUSTOM_DIR/udp-custom" "$binary_url"
    if [ $? -ne 0 ]; then
        echo -e "\n${C_RED}❌ Failed to download the udp-custom binary.${C_RESET}"
        rm -rf "$UDP_CUSTOM_DIR"
        return
    fi
    chmod +x "$UDP_CUSTOM_DIR/udp-custom"

    echo -e "\n${C_GREEN}📦 Setting up udpgw helper...${C_RESET}"
    if [[ "$arch" == "x86_64" ]]; then
        wget -q --show-progress -O "$UDPGW_BINARY" "https://raw.githubusercontent.com/http-custom/udp-custom/main/module/udpgw"
        if [ $? -ne 0 ]; then
            echo -e "\n${C_RED}❌ Failed to download the udpgw helper binary.${C_RESET}"
            rm -rf "$UDP_CUSTOM_DIR"
            return
        fi
        chmod +x "$UDPGW_BINARY"
    else
        echo -e "${C_YELLOW}ℹ️ Architecture is $arch. Compiling udpgw from source (this may take a minute)...${C_RESET}"
        ff_pkg_install cmake g++ make git >/dev/null 2>&1
        local temp_build="/tmp/badvpn_build"
        rm -rf "$temp_build"
        git clone -q https://github.com/ambrop72/badvpn.git "$temp_build"
        (cd "$temp_build" && cmake . >/dev/null 2>&1 && make >/dev/null 2>&1)
        local compiled_bin=$(find "$temp_build" -name "badvpn-udpgw" -type f | head -n 1)
        if [[ -n "$compiled_bin" && -f "$compiled_bin" ]]; then
            cp "$compiled_bin" "$UDPGW_BINARY"
            chmod +x "$UDPGW_BINARY"
        else
            echo -e "\n${C_RED}❌ Failed to compile udpgw helper for $arch.${C_RESET}"
            rm -rf "$UDP_CUSTOM_DIR" "$temp_build"
            return
        fi
        rm -rf "$temp_build"
    fi

    echo -e "\n${C_GREEN}📝 Creating default config.json...${C_RESET}"
    cat > "$UDP_CUSTOM_DIR/config.json" <<EOF
{
  "listen": ":36712",
  "stream_buffer": 33554432,
  "receive_buffer": 83886080,
  "auth": {
    "mode": "passwords"
  }
}
EOF
    chmod 644 "$UDP_CUSTOM_DIR/config.json"

    echo -e "\n${C_GREEN}📝 Creating udpgw systemd service file...${C_RESET}"
    cat > "$UDPGW_SERVICE_FILE" <<EOF
[Unit]
Description=Hotscript UDPGW Backend
After=network.target

[Service]
User=root
Type=simple
ExecStart=$UDPGW_BINARY --listen-addr 127.0.0.1:7800 --max-clients 1000 --max-connections-for-client 100
Restart=always
RestartSec=2s

[Install]
WantedBy=multi-user.target
EOF

    echo -e "\n${C_GREEN}📝 Creating systemd service file...${C_RESET}"
    cat > "$UDP_CUSTOM_SERVICE_FILE" <<EOF
[Unit]
Description=UDP Custom by Hotscript
After=network.target

[Service]
User=root
Type=simple
ExecStart=$UDP_CUSTOM_DIR/udp-custom server
WorkingDirectory=$UDP_CUSTOM_DIR/
Restart=always
RestartSec=2s

[Install]
WantedBy=multi-user.target
EOF

    echo -e "\n${C_GREEN}▶️ Enabling and starting udp-custom service...${C_RESET}"
    systemctl daemon-reload
    systemctl enable udpgw.service
    systemctl start udpgw.service
    systemctl enable udp-custom.service
    systemctl start udp-custom.service
    sleep 2
    if systemctl is-active --quiet udpgw && systemctl is-active --quiet udp-custom; then
        echo -e "\n${C_GREEN}✅ SUCCESS: udp-custom is installed and active.${C_RESET}"
    else
        echo -e "\n${C_RED}❌ ERROR: udp-custom service failed to start.${C_RESET}"
        echo -e "${C_YELLOW}ℹ️ Displaying last 15 lines of the udp-custom and udpgw logs for diagnostics:${C_RESET}"
        journalctl -u udp-custom.service -n 15 --no-pager
        journalctl -u udpgw.service -n 15 --no-pager
    fi
}

uninstall_udp_custom() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling udp-custom ---${C_RESET}"
    if [ ! -f "$UDP_CUSTOM_SERVICE_FILE" ] && [ ! -f "$UDPGW_SERVICE_FILE" ]; then
        echo -e "${C_YELLOW}ℹ️ udp-custom is not installed, skipping.${C_RESET}"
        return
    fi
    echo -e "${C_GREEN}🛑 Stopping and disabling udpgw service...${C_RESET}"
    systemctl stop udpgw.service >/dev/null 2>&1
    systemctl disable udpgw.service >/dev/null 2>&1
    echo -e "${C_GREEN}🛑 Stopping and disabling udp-custom service...${C_RESET}"
    systemctl stop udp-custom.service >/dev/null 2>&1
    systemctl disable udp-custom.service >/dev/null 2>&1
    echo -e "${C_GREEN}🗑️ Removing systemd service file...${C_RESET}"
    rm -f "$UDP_CUSTOM_SERVICE_FILE"
    rm -f "$UDPGW_SERVICE_FILE"
    systemctl daemon-reload
    echo -e "${C_GREEN}🗑️ Removing udp-custom directory and files...${C_RESET}"
    rm -rf "$UDP_CUSTOM_DIR"
    rm -f "$UDPGW_BINARY"
    echo -e "${C_GREEN}✅ udp-custom has been uninstalled successfully.${C_RESET}"
}


ensure_badvpn_service_is_quiet() {
    if [[ ! -f "$BADVPN_SERVICE_FILE" ]] || grep -q "^StandardOutput=null$" "$BADVPN_SERVICE_FILE" 2>/dev/null; then
        return
    fi

    local tmp_service
    tmp_service=$(mktemp)
    awk '
        /^\[Service\]$/ {
            print
            print "StandardOutput=null"
            print "StandardError=null"
            next
        }
        { print }
    ' "$BADVPN_SERVICE_FILE" > "$tmp_service" && mv "$tmp_service" "$BADVPN_SERVICE_FILE"
    rm -f "$tmp_service" 2>/dev/null
    systemctl daemon-reload
    systemctl restart badvpn.service >/dev/null 2>&1 || true
}

install_badvpn() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Installing badvpn (udpgw) ---${C_RESET}"
    if [ -f "$BADVPN_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ badvpn is already installed.${C_RESET}"
        return
    fi
    check_and_open_firewall_port 7300 udp || return
    echo -e "\n${C_GREEN}🔄 Updating package lists...${C_RESET}"
    ff_apt_update || return
    echo -e "\n${C_GREEN}📦 Installing all required packages...${C_RESET}"
    ff_pkg_install cmake g++ make screen git build-essential libssl-dev libnspr4-dev libnss3-dev pkg-config || {
        echo -e "${C_RED}❌ Failed to install badvpn build dependencies.${C_RESET}"
        return
    }
    echo -e "\n${C_GREEN}📥 Cloning badvpn from github...${C_RESET}"
    git clone https://github.com/ambrop72/badvpn.git "$BADVPN_BUILD_DIR"
    cd "$BADVPN_BUILD_DIR" || { echo -e "${C_RED}❌ Failed to change directory to build folder.${C_RESET}"; return; }
    echo -e "\n${C_GREEN}⚙️ Running CMake...${C_RESET}"
    cmake . || { echo -e "${C_RED}❌ CMake configuration failed.${C_RESET}"; rm -rf "$BADVPN_BUILD_DIR"; return; }
    echo -e "\n${C_GREEN}🛠️ Compiling source...${C_RESET}"
    make || { echo -e "${C_RED}❌ Compilation (make) failed.${C_RESET}"; rm -rf "$BADVPN_BUILD_DIR"; return; }
    local badvpn_binary
    badvpn_binary=$(find "$BADVPN_BUILD_DIR" -name "badvpn-udpgw" -type f | head -n 1)
    if [[ -z "$badvpn_binary" || ! -f "$badvpn_binary" ]]; then
        echo -e "${C_RED}❌ ERROR: Could not find the compiled 'badvpn-udpgw' binary after compilation.${C_RESET}"
        rm -rf "$BADVPN_BUILD_DIR"
        return
    fi
    echo -e "${C_GREEN}ℹ️ Found binary at: $badvpn_binary${C_RESET}"
    chmod +x "$badvpn_binary"
    echo -e "\n${C_GREEN}📝 Creating systemd service file...${C_RESET}"
    cat > "$BADVPN_SERVICE_FILE" <<-EOF
[Unit]
Description=BadVPN UDP Gateway
After=network.target
[Service]
ExecStart=$badvpn_binary --listen-addr 0.0.0.0:7300 --max-clients 1000 --max-connections-for-client 8
User=root
Restart=always
RestartSec=3
StandardOutput=null
StandardError=null
[Install]
WantedBy=multi-user.target
EOF
    echo -e "\n${C_GREEN}▶️ Enabling and starting badvpn service...${C_RESET}"
    systemctl daemon-reload
    systemctl enable badvpn.service
    systemctl start badvpn.service
    sleep 2
    if systemctl is-active --quiet badvpn; then
        echo -e "\n${C_GREEN}✅ SUCCESS: badvpn (udpgw) is installed and active on port 7300.${C_RESET}"
    else
        echo -e "\n${C_RED}❌ ERROR: badvpn service failed to start.${C_RESET}"
        echo -e "${C_YELLOW}ℹ️ Displaying last 15 lines of the service log for diagnostics:${C_RESET}"
        journalctl -u badvpn.service -n 15 --no-pager
    fi
}

uninstall_badvpn() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling badvpn (udpgw) ---${C_RESET}"
    if [ ! -f "$BADVPN_SERVICE_FILE" ]; then
        echo -e "${C_YELLOW}ℹ️ badvpn is not installed, skipping.${C_RESET}"
        return
    fi
    echo -e "${C_GREEN}🛑 Stopping and disabling badvpn service...${C_RESET}"
    systemctl stop badvpn.service >/dev/null 2>&1
    systemctl disable badvpn.service >/dev/null 2>&1
    echo -e "${C_GREEN}🗑️ Removing systemd service file...${C_RESET}"
    rm -f "$BADVPN_SERVICE_FILE"
    systemctl daemon-reload
    echo -e "${C_GREEN}🗑️ Removing badvpn build directory...${C_RESET}"
    rm -rf "$BADVPN_BUILD_DIR"
    echo -e "${C_GREEN}✅ badvpn has been uninstalled successfully.${C_RESET}"
}

load_edge_cert_info() {
    EDGE_CERT_MODE=""
    EDGE_DOMAIN=""
    EDGE_EMAIL=""
    if [ -f "$EDGE_CERT_INFO_FILE" ]; then
        source "$EDGE_CERT_INFO_FILE"
    fi
}

save_edge_cert_info() {
    local cert_mode="$1"
    local cert_domain="$2"
    local cert_email="$3"
    mkdir -p "$DB_DIR"
    cat > "$EDGE_CERT_INFO_FILE" <<EOF
EDGE_CERT_MODE="$cert_mode"
EDGE_DOMAIN="$cert_domain"
EDGE_EMAIL="$cert_email"
EOF
}

detect_preferred_host() {
    local host_domain=""
    load_edge_cert_info
    if [[ -n "$EDGE_DOMAIN" ]]; then
        host_domain="$EDGE_DOMAIN"
    fi
    if [[ -z "$host_domain" && -f "$DNS_INFO_FILE" ]]; then
        host_domain=$(grep 'FULL_DOMAIN' "$DNS_INFO_FILE" | cut -d'"' -f2)
    fi
    if [[ -z "$host_domain" && -f "$NGINX_CONFIG_FILE" ]]; then
        local nginx_domain
        nginx_domain=$(grep -oP 'server_name \K[^\s;]+' "$NGINX_CONFIG_FILE" 2>/dev/null | head -n 1)
        if [[ "$nginx_domain" != "_" && -n "$nginx_domain" ]]; then
            host_domain="$nginx_domain"
        fi
    fi
    if [[ -z "$host_domain" ]]; then
        host_domain=$(curl -s -4 icanhazip.com)
    fi
    echo "$host_domain"
}

backup_edge_configs() {
    if [ -f "$NGINX_CONFIG_FILE" ] && [ ! -f "${NGINX_CONFIG_FILE}.bak.firewallfalcon" ]; then
        cp "$NGINX_CONFIG_FILE" "${NGINX_CONFIG_FILE}.bak.firewallfalcon" 2>/dev/null
    fi
    if [ -f "$HAPROXY_CONFIG" ] && [ ! -f "${HAPROXY_CONFIG}.bak.firewallfalcon" ]; then
        cp "$HAPROXY_CONFIG" "${HAPROXY_CONFIG}.bak.firewallfalcon" 2>/dev/null
    fi
}

ensure_edge_stack_packages() {
    local missing_packages=()
    if ! command -v haproxy &> /dev/null || [ ! -f "/etc/haproxy/haproxy.cfg" ]; then
        missing_packages+=("haproxy")
    fi
    if ! command -v nginx &> /dev/null || [ ! -f "/etc/nginx/nginx.conf" ]; then
        missing_packages+=("nginx")
    fi
    command -v openssl &> /dev/null || missing_packages+=("openssl")

    if (( ${#missing_packages[@]} > 0 )); then
        echo -e "\n${C_BLUE}📦 Installing required packages: ${missing_packages[*]}${C_RESET}"
        if ! ff_pkg_install "${missing_packages[@]}"; then
            echo -e "${C_YELLOW}⚠️ Package installation failed. Attempting to fix broken configurations...${C_RESET}"
            if command -v apt-get &>/dev/null; then
                apt-get purge -y nginx nginx-common haproxy >/dev/null 2>&1
            fi
            if ! ff_pkg_install "${missing_packages[@]}"; then
                echo -e "${C_RED}❌ Failed to install the required packages.${C_RESET}"
                return 1
            fi
        fi
    fi
    return 0
}

build_shared_tls_bundle() {
    if [ ! -s "$SSL_CERT_CHAIN_FILE" ] || [ ! -s "$SSL_CERT_KEY_FILE" ]; then
        echo -e "${C_RED}❌ Certificate chain or key is missing.${C_RESET}"
        return 1
    fi
    cat "$SSL_CERT_CHAIN_FILE" "$SSL_CERT_KEY_FILE" > "$SSL_CERT_FILE" || return 1
    chmod 644 "$SSL_CERT_CHAIN_FILE"
    chmod 600 "$SSL_CERT_KEY_FILE" "$SSL_CERT_FILE"
    sync_haproxy_cert
    return 0
}

# HAProxy's stock systemd unit is often sandboxed (ProtectSystem/ReadOnlyPaths) so it
# can only read files under /etc/haproxy. Our cert lives under /etc/firewallfalcon/ssl,
# which that sandbox silently blocks -- config check ("haproxy -c") still passes because
# it runs as your root shell, but the real service fails at restart. Mirroring the cert
# into /etc/haproxy/ sidesteps that instead of guessing at the unit's hardening rules.
sync_haproxy_cert() {
    if [ ! -s "$SSL_CERT_FILE" ]; then
        return 1
    fi
    mkdir -p /etc/haproxy
    cp "$SSL_CERT_FILE" "$HAPROXY_LOCAL_CERT_FILE" || return 1
    chown root:root "$HAPROXY_LOCAL_CERT_FILE"
    chmod 600 "$HAPROXY_LOCAL_CERT_FILE"
    return 0
}

# Belt-and-suspenders: if the installed haproxy.service unit (or a distro drop-in)
# restricts filesystem access via ProtectSystem/ReadOnlyPaths/ReadWritePaths, this
# override explicitly whitelists our cert directory so it's readable no matter what
# the base unit does. Safe no-op if the base unit has no such restrictions.
ensure_haproxy_systemd_access() {
    local override_dir="/etc/systemd/system/haproxy.service.d"
    local override_file="$override_dir/firewallfalcon-access.conf"
    mkdir -p "$override_dir"
    cat > "$override_file" <<EOF
[Service]
ReadOnlyPaths=/etc/firewallfalcon /etc/haproxy
EOF
    systemctl daemon-reload
}

generate_self_signed_edge_cert() {
    local common_name="$1"
    mkdir -p "$SSL_CERT_DIR"
    echo -e "\n${C_GREEN}🔐 Generating a shared self-signed certificate...${C_RESET}"
    openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
        -keyout "$SSL_CERT_KEY_FILE" \
        -out "$SSL_CERT_CHAIN_FILE" \
        -subj "/CN=$common_name" \
        >/dev/null 2>&1 || {
            echo -e "${C_RED}❌ Failed to generate the self-signed certificate.${C_RESET}"
            return 1
        }
    build_shared_tls_bundle || return 1
    save_edge_cert_info "self-signed" "$common_name" ""
    echo -e "${C_GREEN}✅ Shared certificate created for ${C_YELLOW}$common_name${C_RESET}"
    return 0
}

_install_certbot() {
    if command -v certbot &> /dev/null; then
        echo -e "${C_GREEN}✅ Certbot is already installed.${C_RESET}"
        return 0
    fi
    echo -e "${C_BLUE}📦 Installing Certbot...${C_RESET}"
    ff_pkg_install certbot || {
        echo -e "${C_RED}❌ Failed to install Certbot.${C_RESET}"
        return 1
    }
    echo -e "${C_GREEN}✅ Certbot installed successfully.${C_RESET}"
    return 0
}

obtain_certbot_edge_cert() {
    local domain_name="$1"
    local email="$2"
    local restart_haproxy=0
    local restart_nginx=0

    mkdir -p "$SSL_CERT_DIR"
    _install_certbot || return 1

    if systemctl is-active --quiet haproxy; then restart_haproxy=1; fi
    if systemctl is-active --quiet nginx; then restart_nginx=1; fi

    echo -e "\n${C_BLUE}🛑 Stopping HAProxy and Nginx for Certbot validation...${C_RESET}"
    systemctl stop haproxy >/dev/null 2>&1
    systemctl stop nginx >/dev/null 2>&1
    sleep 2

    check_and_free_ports "$EDGE_PUBLIC_HTTP_PORT" "$EDGE_PUBLIC_TLS_PORT" || {
        [[ "$restart_nginx" -eq 1 ]] && systemctl start nginx >/dev/null 2>&1
        [[ "$restart_haproxy" -eq 1 ]] && systemctl start haproxy >/dev/null 2>&1
        return 1
    }

    echo -e "\n${C_BLUE}🚀 Requesting a Certbot certificate for ${C_YELLOW}$domain_name${C_RESET}"
    certbot certonly --standalone -d "$domain_name" --non-interactive --agree-tos -m "$email"
    if [ $? -ne 0 ]; then
        echo -e "\n${C_RED}❌ Certbot failed to obtain a certificate.${C_RESET}"
        echo -e "${C_YELLOW}ℹ️ Make sure the domain points to this server and port 80 is reachable.${C_RESET}"
        [[ "$restart_nginx" -eq 1 ]] && systemctl start nginx >/dev/null 2>&1
        [[ "$restart_haproxy" -eq 1 ]] && systemctl start haproxy >/dev/null 2>&1
        return 1
    fi

    local certbot_chain="/etc/letsencrypt/live/$domain_name/fullchain.pem"
    local certbot_key="/etc/letsencrypt/live/$domain_name/privkey.pem"
    if [ ! -f "$certbot_chain" ] || [ ! -f "$certbot_key" ]; then
        echo -e "\n${C_RED}❌ Certbot completed, but the certificate files were not found.${C_RESET}"
        [[ "$restart_nginx" -eq 1 ]] && systemctl start nginx >/dev/null 2>&1
        [[ "$restart_haproxy" -eq 1 ]] && systemctl start haproxy >/dev/null 2>&1
        return 1
    fi

    cp "$certbot_chain" "$SSL_CERT_CHAIN_FILE"
    cp "$certbot_key" "$SSL_CERT_KEY_FILE"
    build_shared_tls_bundle || {
        [[ "$restart_nginx" -eq 1 ]] && systemctl start nginx >/dev/null 2>&1
        [[ "$restart_haproxy" -eq 1 ]] && systemctl start haproxy >/dev/null 2>&1
        return 1
    }
    save_edge_cert_info "certbot" "$domain_name" "$email"
    echo -e "${C_GREEN}✅ Certbot certificate copied into ${C_YELLOW}$SSL_CERT_DIR${C_RESET}"
    return 0
}

select_edge_certificate() {
    local preferred_host
    local cert_choice
    local has_existing_cert=false

    preferred_host=$(detect_preferred_host)
    if [[ -z "$preferred_host" ]]; then
        preferred_host="firewallfalcon.local"
    fi

    if [ -s "$SSL_CERT_FILE" ] && [ -s "$SSL_CERT_CHAIN_FILE" ] && [ -s "$SSL_CERT_KEY_FILE" ]; then
        has_existing_cert=true
    fi

    load_edge_cert_info

    echo -e "\n${C_BOLD}${C_PURPLE}--- 🔐 Shared TLS Certificate ---${C_RESET}"
    echo -e "${C_DIM}The same certificate will be used by HAProxy and the internal Nginx proxy.${C_RESET}"

    if $has_existing_cert; then
        local existing_label="${EDGE_CERT_MODE:-existing}"
        if [[ -n "$EDGE_DOMAIN" ]]; then
            existing_label="$existing_label - $EDGE_DOMAIN"
        fi
        printf "  ${C_CHOICE}[ 1]${C_RESET} %-52s\n" "Reuse existing certificate (${existing_label})"
        printf "  ${C_CHOICE}[ 2]${C_RESET} %-52s\n" "Replace with a new self-signed certificate"
        printf "  ${C_CHOICE}[ 3]${C_RESET} %-52s\n" "Replace with a Certbot certificate"
        echo
        read -p "👉 Enter choice [1]: " cert_choice
        cert_choice=${cert_choice:-1}
    else
        printf "  ${C_CHOICE}[ 1]${C_RESET} %-52s\n" "Generate a self-signed certificate"
        printf "  ${C_CHOICE}[ 2]${C_RESET} %-52s\n" "Use a Certbot certificate"
        echo
        read -p "👉 Enter choice [1]: " cert_choice
        cert_choice=${cert_choice:-1}
    fi

    case "$cert_choice" in
        1)
            if $has_existing_cert; then
                echo -e "${C_GREEN}✅ Reusing the existing shared certificate.${C_RESET}"
                return 0
            fi
            local common_name
            read -p "👉 Enter the certificate Common Name / SNI label [$preferred_host]: " common_name
            common_name=${common_name:-$preferred_host}
            generate_self_signed_edge_cert "$common_name"
            ;;
        2)
            if $has_existing_cert; then
                local common_name
                read -p "👉 Enter the certificate Common Name / SNI label [$preferred_host]: " common_name
                common_name=${common_name:-$preferred_host}
                generate_self_signed_edge_cert "$common_name"
            else
                local default_domain=""
                local domain_name
                local email
                if ! _is_valid_ipv4 "$preferred_host"; then
                    default_domain="$preferred_host"
                fi
                if [[ -n "$default_domain" ]]; then
                    read -p "👉 Enter your domain name [$default_domain]: " domain_name
                    domain_name=${domain_name:-$default_domain}
                else
                    read -p "👉 Enter your domain name (e.g. vpn.example.com): " domain_name
                fi
                if [[ -z "$domain_name" ]]; then
                    echo -e "${C_RED}❌ Domain name cannot be empty.${C_RESET}"
                    return 1
                fi
                if _is_valid_ipv4 "$domain_name"; then
                    echo -e "${C_RED}❌ Certbot requires a real domain name, not a raw IP address.${C_RESET}"
                    return 1
                fi
                read -p "👉 Enter your email for Let's Encrypt: " email
                if [[ -z "$email" ]]; then
                    echo -e "${C_RED}❌ Email cannot be empty.${C_RESET}"
                    return 1
                fi
                obtain_certbot_edge_cert "$domain_name" "$email"
            fi
            ;;
        3)
            if ! $has_existing_cert; then
                echo -e "${C_RED}❌ Invalid option.${C_RESET}"
                return 1
            fi
            local default_domain=""
            local domain_name
            local email
            if [[ -n "$EDGE_DOMAIN" ]] && ! _is_valid_ipv4 "$EDGE_DOMAIN"; then
                default_domain="$EDGE_DOMAIN"
            fi
            if [[ -z "$default_domain" ]] && ! _is_valid_ipv4 "$preferred_host"; then
                default_domain="$preferred_host"
            fi
            if [[ -n "$default_domain" ]]; then
                read -p "👉 Enter your domain name [$default_domain]: " domain_name
                domain_name=${domain_name:-$default_domain}
            else
                read -p "👉 Enter your domain name (e.g. vpn.example.com): " domain_name
            fi
            if [[ -z "$domain_name" ]]; then
                echo -e "${C_RED}❌ Domain name cannot be empty.${C_RESET}"
                return 1
            fi
            if _is_valid_ipv4 "$domain_name"; then
                echo -e "${C_RED}❌ Certbot requires a real domain name, not a raw IP address.${C_RESET}"
                return 1
            fi
            read -p "👉 Enter your email for Let's Encrypt [${EDGE_EMAIL}]: " email
            email=${email:-$EDGE_EMAIL}
            if [[ -z "$email" ]]; then
                echo -e "${C_RED}❌ Email cannot be empty.${C_RESET}"
                return 1
            fi
            obtain_certbot_edge_cert "$domain_name" "$email"
            ;;
        *)
            echo -e "${C_RED}❌ Invalid option.${C_RESET}"
            return 1
            ;;
    esac
}

write_internal_nginx_config() {
    local server_name="$1"
    [[ -z "$server_name" ]] && server_name="_"
    mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled
    cat > "$NGINX_CONFIG_FILE" <<EOF
server {
    listen 127.0.0.1:${NGINX_INTERNAL_HTTP_PORT} default_server;
    listen 127.0.0.1:${NGINX_INTERNAL_TLS_PORT} ssl http2 default_server;
    server_tokens off;
    server_name ${server_name};

    ssl_certificate ${SSL_CERT_CHAIN_FILE};
    ssl_certificate_key ${SSL_CERT_KEY_FILE};
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!eNULL:!MD5:!DES:!RC4:!ADH:!SSLv3:!EXP:!PSK:!DSS;
    resolver 1.1.1.1 8.8.8.8 ipv6=off valid=300s;

    location ~ ^/(?<fwdport>\d+)/(?<fwdpath>.*)$ {
        client_max_body_size 0;
        client_body_timeout 1d;
        grpc_read_timeout 1d;
        grpc_socket_keepalive on;
        proxy_read_timeout 1d;
        proxy_http_version 1.1;
        proxy_buffering off;
        proxy_request_buffering off;
        proxy_socket_keepalive on;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        if (\$content_type ~* "GRPC") { grpc_pass grpc://127.0.0.1:\$fwdport\$is_args\$args; break; }
        proxy_pass http://127.0.0.1:\$fwdport\$is_args\$args;
        break;
    }

    location / {
        proxy_read_timeout 3600s;
        proxy_buffering off;
        proxy_request_buffering off;
        proxy_http_version 1.1;
        proxy_socket_keepalive on;
        tcp_nodelay on;
        tcp_nopush off;
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF
    ln -sf "$NGINX_CONFIG_FILE" /etc/nginx/sites-enabled/default
}

write_haproxy_edge_config() {
    mkdir -p /etc/haproxy
    cat > "$HAPROXY_CONFIG" <<EOF
global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    mode    tcp
    option  tcplog
    option  dontlognull
    timeout connect 5s
    timeout client  24h
    timeout server  24h

# ====================================================================
# TIER 1: PORT ${EDGE_PUBLIC_HTTP_PORT} (Cleartext Payloads & Raw SSH)
# ====================================================================
frontend port_80_edge
    bind *:${EDGE_PUBLIC_HTTP_PORT}
    mode tcp
    tcp-request inspect-delay 2s

    acl is_ssh payload(0,7) -m bin 5353482d322e30

    tcp-request content accept if is_ssh
    tcp-request content accept if HTTP

    use_backend direct_ssh if is_ssh
    default_backend nginx_cleartext

# ====================================================================
# TIER 1: PORT ${EDGE_PUBLIC_TLS_PORT} (TLS v2ray, SSL Payloads, Raw SSH)
# ====================================================================
frontend port_443_edge
    bind *:${EDGE_PUBLIC_TLS_PORT}
    mode tcp
    tcp-request inspect-delay 2s

    acl is_ssh payload(0,7) -m bin 5353482d322e30
    acl is_tls req.ssl_hello_type 1
    acl has_web_alpn req.ssl_alpn -m sub h2 http/1.1

    tcp-request content accept if is_ssh
    tcp-request content accept if HTTP
    tcp-request content accept if is_tls

    use_backend direct_ssh if is_ssh
    use_backend nginx_cleartext if HTTP
    use_backend nginx_tls if is_tls has_web_alpn
    default_backend loopback_ssl_terminator

# ====================================================================
# TIER 2: INTERNAL DECRYPTOR (Only for Any-SNI SSH-TLS)
# ====================================================================
frontend internal_decryptor
    bind 127.0.0.1:${HAPROXY_INTERNAL_DECRYPT_PORT} ssl crt ${HAPROXY_LOCAL_CERT_FILE}
    mode tcp
    tcp-request inspect-delay 2s

    acl is_ssh payload(0,7) -m bin 5353482d322e30
    tcp-request content accept if is_ssh
    tcp-request content accept if HTTP

    use_backend direct_ssh if is_ssh
    default_backend nginx_cleartext

# ====================================================================
# DESTINATION BACKENDS (Clean handoffs, no proxy headers)
# ====================================================================
backend direct_ssh
    mode tcp
    server ssh_server 127.0.0.1:22

backend nginx_cleartext
    mode tcp
    server nginx_8880 127.0.0.1:${NGINX_INTERNAL_HTTP_PORT}

backend nginx_tls
    mode tcp
    server nginx_8443 127.0.0.1:${NGINX_INTERNAL_TLS_PORT}

backend loopback_ssl_terminator
    mode tcp
    server haproxy_ssl 127.0.0.1:${HAPROXY_INTERNAL_DECRYPT_PORT}
EOF
}

save_edge_ports_info() {
    cat > "$NGINX_PORTS_FILE" <<EOF
EDGE_HTTP_PORT="${EDGE_PUBLIC_HTTP_PORT}"
EDGE_TLS_PORT="${EDGE_PUBLIC_TLS_PORT}"
HTTP_PORTS="${NGINX_INTERNAL_HTTP_PORT}"
TLS_PORTS="${NGINX_INTERNAL_TLS_PORT}"
EOF
}

configure_edge_stack() {
    local server_name="$1"
    [[ -z "$server_name" ]] && server_name="_"

    backup_edge_configs

    echo -e "\n${C_BLUE}📝 Writing internal Nginx config (127.0.0.1:${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT})...${C_RESET}"
    write_internal_nginx_config "$server_name"

    sync_haproxy_cert
    ensure_haproxy_systemd_access

    echo -e "${C_BLUE}📝 Writing HAProxy edge config (${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT})...${C_RESET}"
    write_haproxy_edge_config

    echo -e "\n${C_BLUE}🧪 Validating Nginx configuration...${C_RESET}"
    if ! nginx -t >/dev/null 2>&1; then
        echo -e "${C_RED}❌ Nginx configuration validation failed.${C_RESET}"
        nginx -t
        return 1
    fi

    echo -e "${C_BLUE}🧪 Validating HAProxy configuration...${C_RESET}"
    if ! haproxy -c -f "$HAPROXY_CONFIG" >/dev/null 2>&1; then
        echo -e "${C_RED}❌ HAProxy configuration validation failed.${C_RESET}"
        haproxy -c -f "$HAPROXY_CONFIG"
        return 1
    fi

    systemctl daemon-reload
    systemctl enable nginx >/dev/null 2>&1
    systemctl enable haproxy >/dev/null 2>&1

    echo -e "\n${C_BLUE}▶️ Restarting internal Nginx...${C_RESET}"
    systemctl restart nginx || {
        echo -e "${C_RED}❌ Nginx failed to restart.${C_RESET}"
        systemctl status nginx --no-pager
        return 1
    }

    echo -e "${C_BLUE}▶️ Restarting HAProxy edge...${C_RESET}"
    systemctl restart haproxy || {
        echo -e "${C_RED}❌ HAProxy failed to restart.${C_RESET}"
        echo -e "${C_DIM}--- journalctl -xeu haproxy (last 40 lines) ---${C_RESET}"
        journalctl -xeu haproxy --no-pager -n 40
        return 1
    }

    sleep 2
    if ! systemctl is-active --quiet nginx; then
        echo -e "${C_RED}❌ Nginx is not active after restart.${C_RESET}"
        systemctl status nginx --no-pager
        return 1
    fi
    if ! systemctl is-active --quiet haproxy; then
        echo -e "${C_RED}❌ HAProxy is not active after restart.${C_RESET}"
        systemctl status haproxy --no-pager
        return 1
    fi

    save_edge_ports_info
    return 0
}

install_ssl_tunnel() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Installing HAProxy Edge Stack (80/443 -> 8880/8443) ---${C_RESET}"
    echo -e "\n${C_CYAN}This installer will configure:${C_RESET}"
    echo -e "   • HAProxy on ${C_WHITE}${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT}${C_RESET}"
    echo -e "   • Internal Nginx on ${C_WHITE}${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}${C_RESET}"
    echo -e "   • Loopback SSL decryptor on ${C_WHITE}${HAPROXY_INTERNAL_DECRYPT_PORT}${C_RESET}"

    if [ -f "$HAPROXY_CONFIG" ] || [ -f "$NGINX_CONFIG_FILE" ]; then
        echo -e "\n${C_YELLOW}⚠️ Existing HAProxy/Nginx configs will be replaced with the Hotscript edge layout.${C_RESET}"
        read -p "👉 Continue with the replacement? (y/n): " confirm_replace
        if [[ "$confirm_replace" != "y" && "$confirm_replace" != "Y" ]]; then
            echo -e "${C_RED}❌ Installation cancelled.${C_RESET}"
            return
        fi
    fi

    mkdir -p "$DB_DIR" "$SSL_CERT_DIR"

    ensure_edge_stack_packages || return

    systemctl stop haproxy >/dev/null 2>&1
    systemctl stop nginx >/dev/null 2>&1
    sleep 1

    check_and_free_ports \
        "$EDGE_PUBLIC_HTTP_PORT" \
        "$EDGE_PUBLIC_TLS_PORT" \
        "$NGINX_INTERNAL_HTTP_PORT" \
        "$NGINX_INTERNAL_TLS_PORT" \
        "$HAPROXY_INTERNAL_DECRYPT_PORT" || return

    check_and_open_firewall_port "$EDGE_PUBLIC_HTTP_PORT" tcp || return
    check_and_open_firewall_port "$EDGE_PUBLIC_TLS_PORT" tcp || return

    select_edge_certificate || return

    load_edge_cert_info
    local server_name="${EDGE_DOMAIN:-$(detect_preferred_host)}"
    [[ -z "$server_name" ]] && server_name="_"

    configure_edge_stack "$server_name" || return

    echo -e "\n${C_GREEN}✅ SUCCESS: HAProxy edge stack is active.${C_RESET}"
    echo -e "   • Public edge ports: ${C_YELLOW}${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT}${C_RESET}"
    echo -e "   • Internal Nginx ports: ${C_YELLOW}${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}${C_RESET}"
    echo -e "   • Shared certificate: ${C_YELLOW}${EDGE_CERT_MODE:-unknown}${C_RESET}"
}

uninstall_ssl_tunnel() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling HAProxy Edge Stack ---${C_RESET}"
    if ! command -v haproxy &> /dev/null; then
        echo -e "${C_YELLOW}ℹ️ HAProxy is not installed, skipping service removal.${C_RESET}"
    else
        echo -e "${C_GREEN}🛑 Stopping and disabling HAProxy...${C_RESET}"
        systemctl stop haproxy >/dev/null 2>&1
        systemctl disable haproxy >/dev/null 2>&1
    fi

    if [ -f "$HAPROXY_CONFIG" ]; then
        cat > "$HAPROXY_CONFIG" <<EOF
global
    log /dev/log local0
    log /dev/log local1 notice

defaults
    log     global
EOF
    fi

    local delete_cert="n"
    if [[ "$UNINSTALL_MODE" == "silent" ]]; then
        delete_cert="y"
    elif [ -f "$SSL_CERT_FILE" ] || [ -f "$SSL_CERT_CHAIN_FILE" ] || [ -f "$SSL_CERT_KEY_FILE" ]; then
        if systemctl is-active --quiet nginx; then
            echo -e "${C_YELLOW}⚠️ The shared certificate is also used by the internal Nginx proxy.${C_RESET}"
        fi
        read -p "👉 Delete the shared TLS certificate too? (y/n): " delete_cert
    fi

    if [[ "$delete_cert" == "y" || "$delete_cert" == "Y" ]]; then
        if systemctl is-active --quiet nginx; then
            echo -e "${C_GREEN}🛑 Stopping Nginx because the shared certificate is being removed...${C_RESET}"
            systemctl stop nginx >/dev/null 2>&1
        fi
        rm -f "$SSL_CERT_FILE" "$SSL_CERT_CHAIN_FILE" "$SSL_CERT_KEY_FILE" "$EDGE_CERT_INFO_FILE"
        rm -f "$HAPROXY_LOCAL_CERT_FILE"
        rm -f "$NGINX_PORTS_FILE"
        echo -e "${C_GREEN}🗑️ Shared certificate files removed.${C_RESET}"
    fi

    echo -e "${C_GREEN}✅ HAProxy edge stack has been removed.${C_RESET}"
    if systemctl is-active --quiet nginx; then
        echo -e "${C_DIM}The internal Nginx proxy is still installed on ${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}.${C_RESET}"
    fi
}

show_dnstt_details() {
    if [ -f "$DNSTT_CONFIG_FILE" ]; then
        source "$DNSTT_CONFIG_FILE"
        echo -e "\n${C_GREEN}=====================================================${C_RESET}"
        echo -e "${C_GREEN}            📡 DNSTT Connection Details             ${C_RESET}"
        echo -e "${C_GREEN}=====================================================${C_RESET}"
        echo -e "\n${C_WHITE}Your connection details:${C_RESET}"
        echo -e "  - ${C_CYAN}Tunnel Domain:${C_RESET} ${C_YELLOW}$TUNNEL_DOMAIN${C_RESET}"
        echo -e "  - ${C_CYAN}Public Key:${C_RESET}    ${C_YELLOW}$PUBLIC_KEY${C_RESET}"
        if [[ -n "$FORWARD_DESC" ]]; then
            echo -e "  - ${C_CYAN}Forwarding To:${C_RESET} ${C_YELLOW}$FORWARD_DESC${C_RESET}"
        else
            echo -e "  - ${C_CYAN}Forwarding To:${C_RESET} ${C_YELLOW}Unknown (config_missing)${C_RESET}"
        fi
        if [[ -n "$MTU_VALUE" ]]; then
            echo -e "  - ${C_CYAN}MTU Value:${C_RESET}     ${C_YELLOW}$MTU_VALUE${C_RESET}"
        fi
        if [[ "$DNSTT_RECORDS_MANAGED" == "false" && -n "$NS_DOMAIN" ]]; then
             echo -e "  - ${C_CYAN}NS Record:${C_RESET}     ${C_YELLOW}$NS_DOMAIN${C_RESET}"
        fi
        
        if [[ "$FORWARD_DESC" == *"V2Ray"* ]]; then
             echo -e "  - ${C_CYAN}Action Required:${C_RESET} ${C_YELLOW}Ensure a V2Ray service (vless/vmess/trojan) listens on port 8787 (no TLS)${C_RESET}"
        elif [[ "$FORWARD_DESC" == *"SSH"* ]]; then
             echo -e "  - ${C_CYAN}Action Required:${C_RESET} ${C_YELLOW}Ensure your SSH client is configured to use the DNS tunnel.${C_RESET}"
        fi
        
        echo -e "\n${C_DIM}Use these details in your client configuration.${C_RESET}"
    else
        echo -e "\n${C_YELLOW}ℹ️ DNSTT configuration file not found. Details are unavailable.${C_RESET}"
    fi
}

install_dnstt() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📡 DNSTT (DNS Tunnel) Management ---${C_RESET}"
    if [ -f "$DNSTT_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ DNSTT is already installed.${C_RESET}"
        show_dnstt_details
        return
    fi
    
    # --- FIX: Force release of Port 53 / Disable systemd-resolved ---
    echo -e "${C_GREEN}⚙️ Forcing release of Port 53 (stopping systemd-resolved)...${C_RESET}"
    systemctl stop systemd-resolved >/dev/null 2>&1
    systemctl disable systemd-resolved >/dev/null 2>&1
    # Mask it so it never starts again on reboot
    systemctl mask systemd-resolved >/dev/null 2>&1
    chattr -i /etc/resolv.conf &>/dev/null
    rm -f /etc/resolv.conf
    printf 'nameserver 8.8.8.8\nnameserver 8.8.4.4\n' > /etc/resolv.conf
    chattr +i /etc/resolv.conf
    # ----------------------------------------------------------------
    
    echo -e "\n${C_BLUE}🔎 Checking if port 53 (UDP) is available...${C_RESET}"
    if ss -lunp | grep -q ':53\s'; then
        if [[ $(ps -p $(ss -lunp | grep ':53\s' | grep -oP 'pid=\K[0-9]+') -o comm=) == "systemd-resolve" ]]; then
            echo -e "${C_YELLOW}⚠️ Warning: Port 53 is in use by 'systemd-resolved'.${C_RESET}"
            echo -e "${C_YELLOW}This is the system's DNS stub resolver. It must be disabled to run DNSTT.${C_RESET}"
            read -p "👉 Allow the script to automatically disable it and reconfigure DNS? (y/n): " resolve_confirm
            if [[ "$resolve_confirm" == "y" || "$resolve_confirm" == "Y" ]]; then
                echo -e "${C_GREEN}⚙️ Stopping and disabling systemd-resolved to free port 53...${C_RESET}"
                systemctl stop systemd-resolved
                systemctl disable systemd-resolved
                chattr -i /etc/resolv.conf &>/dev/null
                rm -f /etc/resolv.conf
                echo "nameserver 8.8.8.8" > /etc/resolv.conf
                chattr +i /etc/resolv.conf
                echo -e "${C_GREEN}✅ Port 53 has been freed and DNS set to 8.8.8.8.${C_RESET}"
            else
                echo -e "${C_RED}❌ Cannot proceed without freeing port 53. Aborting.${C_RESET}"
                return
            fi
        else
            check_and_free_ports "53" || return
        fi
    else
        echo -e "${C_GREEN}✅ Port 53 (UDP) is free to use.${C_RESET}"
    fi

    check_and_open_firewall_port 53 udp || return



    local forward_port=""
    local forward_desc=""
    echo -e "\n${C_BLUE}Please choose where DNSTT should forward traffic:${C_RESET}"
    echo -e "  ${C_GREEN}[ 1]${C_RESET} ➡️ Forward to local SSH service (port 22)"
    echo -e "  ${C_GREEN}[ 2]${C_RESET} ➡️ Forward to local V2Ray backend (port 8787)"
    read -p "👉 Enter your choice [2]: " fwd_choice
    fwd_choice=${fwd_choice:-2}
    if [[ "$fwd_choice" == "1" ]]; then
        forward_port="22"
        forward_desc="SSH (port 22)"
        echo -e "${C_GREEN}ℹ️ DNSTT will forward to SSH on 127.0.0.1:22.${C_RESET}"
        

        
    elif [[ "$fwd_choice" == "2" ]]; then
        forward_port="8787"
        forward_desc="V2Ray (port 8787)"
        echo -e "${C_GREEN}ℹ️ DNSTT will forward to V2Ray on 127.0.0.1:8787.${C_RESET}"
    else
        echo -e "${C_RED}❌ Invalid choice. Aborting.${C_RESET}"
        return
    fi
    local FORWARD_TARGET="127.0.0.1:$forward_port"
    
    local NS_DOMAIN=""
    local TUNNEL_DOMAIN=""
    local DNSTT_RECORDS_MANAGED="true"
    local NS_SUBDOMAIN=""
    local TUNNEL_SUBDOMAIN=""
    local HAS_IPV6="false"

    read -p "👉 Auto-generate DNS records or use custom ones? (auto/custom) [auto]: " dns_choice
    dns_choice=${dns_choice:-auto}

    if [[ "$dns_choice" == "custom" ]]; then
        DNSTT_RECORDS_MANAGED="false"
        read -p "👉 Enter your full nameserver domain (e.g., ns1.yourdomain.com): " NS_DOMAIN
        if [[ -z "$NS_DOMAIN" ]]; then echo -e "\n${C_RED}❌ Nameserver domain cannot be empty. Aborting.${C_RESET}"; return; fi
        read -p "👉 Enter your full tunnel domain (e.g., tun.yourdomain.com): " TUNNEL_DOMAIN
        if [[ -z "$TUNNEL_DOMAIN" ]]; then echo -e "\n${C_RED}❌ Tunnel domain cannot be empty. Aborting.${C_RESET}"; return; fi
    else
        echo -e "\n${C_BLUE}⚙️ Configuring DNS records for DNSTT...${C_RESET}"
        local SERVER_IPV4
        SERVER_IPV4=$(curl -s -4 icanhazip.com)
        if ! _is_valid_ipv4 "$SERVER_IPV4"; then
            echo -e "\n${C_RED}❌ Error: Could not retrieve a valid public IPv4 address from icanhazip.com.${C_RESET}"
            echo -e "${C_YELLOW}ℹ️ Please check your server's network connection and DNS resolver settings.${C_RESET}"
            echo -e "   Output received: '$SERVER_IPV4'"
            return 1
        fi
        
        local SERVER_IPV6
        SERVER_IPV6=$(curl -s -6 icanhazip.com --max-time 5)
        
        local RANDOM_STR
        RANDOM_STR=$(tr -dc a-z0-9 < /dev/urandom | head -c 6)
        NS_SUBDOMAIN="ns-$RANDOM_STR"
        TUNNEL_SUBDOMAIN="tun-$RANDOM_STR"
        NS_DOMAIN="$NS_SUBDOMAIN.$DESEC_DOMAIN"
        TUNNEL_DOMAIN="$TUNNEL_SUBDOMAIN.$DESEC_DOMAIN"

        local API_DATA
        API_DATA=$(printf '[{"subname": "%s", "type": "A", "ttl": 3600, "records": ["%s"]}, {"subname": "%s", "type": "NS", "ttl": 3600, "records": ["%s."]}]' \
            "$NS_SUBDOMAIN" "$SERVER_IPV4" "$TUNNEL_SUBDOMAIN" "$NS_DOMAIN")

        if [[ -n "$SERVER_IPV6" ]]; then
            local aaaa_record
            aaaa_record=$(printf ',{"subname": "%s", "type": "AAAA", "ttl": 3600, "records": ["%s"]}' "$NS_SUBDOMAIN" "$SERVER_IPV6")
            API_DATA="${API_DATA%?}${aaaa_record}]"
            HAS_IPV6="true"
        fi

        local CREATE_RESPONSE
        CREATE_RESPONSE=$(curl -s -w "%{http_code}" -X POST "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/" \
            -H "Authorization: Token $DESEC_TOKEN" -H "Content-Type: application/json" \
            --data "$API_DATA")
        
        local HTTP_CODE=${CREATE_RESPONSE: -3}
        local RESPONSE_BODY=${CREATE_RESPONSE:0:${#CREATE_RESPONSE}-3}

        if [[ "$HTTP_CODE" -ne 201 ]]; then
            echo -e "${C_RED}❌ Failed to create DNSTT records. API returned HTTP $HTTP_CODE.${C_RESET}"
            echo "Response: $RESPONSE_BODY" | jq
            return 1
        fi
    fi
    
    read -p "👉 Enter MTU value (e.g., 512, 1200) or press [Enter] for default: " mtu_value
    local mtu_string=""
    if [[ "$mtu_value" =~ ^[0-9]+$ ]]; then
        mtu_string=" -mtu $mtu_value"
        echo -e "${C_GREEN}ℹ️ Using MTU: $mtu_value${C_RESET}"
    else
        mtu_value=""
        echo -e "${C_YELLOW}ℹ️ Using default MTU.${C_RESET}"
    fi

    echo -e "\n${C_BLUE}📥 Downloading pre-compiled DNSTT server binary...${C_RESET}"
    local arch
    arch=$(uname -m)
    local binary_url=""
    if [[ "$arch" == "x86_64" ]]; then
        binary_url="https://dnstt.network/dnstt-server-linux-amd64"
        echo -e "${C_BLUE}ℹ️ Detected x86_64 (amd64) architecture.${C_RESET}"
    elif [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
        binary_url="https://dnstt.network/dnstt-server-linux-arm64"
        echo -e "${C_BLUE}ℹ️ Detected ARM64 architecture.${C_RESET}"
    else
        echo -e "\n${C_RED}❌ Unsupported architecture: $arch. Cannot install DNSTT.${C_RESET}"
        return
    fi
    
    curl -sL "$binary_url" -o "$DNSTT_BINARY"
    if [ $? -ne 0 ]; then
        echo -e "\n${C_RED}❌ Failed to download the DNSTT binary.${C_RESET}"
        return
    fi
    chmod +x "$DNSTT_BINARY"

    echo -e "${C_BLUE}🔐 Generating cryptographic keys...${C_RESET}"
    mkdir -p "$DNSTT_KEYS_DIR"
    "$DNSTT_BINARY" -gen-key -privkey-file "$DNSTT_KEYS_DIR/server.key" -pubkey-file "$DNSTT_KEYS_DIR/server.pub"
    if [[ ! -f "$DNSTT_KEYS_DIR/server.key" ]]; then echo -e "${C_RED}❌ Failed to generate DNSTT keys.${C_RESET}"; return; fi
    
    local PUBLIC_KEY
    PUBLIC_KEY=$(cat "$DNSTT_KEYS_DIR/server.pub")
    
    echo -e "\n${C_BLUE}📝 Creating systemd service...${C_RESET}"
    cat > "$DNSTT_SERVICE_FILE" <<-EOF
[Unit]
Description=DNSTT (DNS Tunnel) Server for $forward_desc
After=network-online.target
Wants=network-online.target
Conflicts=systemd-resolved.service
[Service]
Type=simple
User=root
ExecStartPre=/bin/bash -c 'systemctl stop systemd-resolved 2>/dev/null; systemctl mask systemd-resolved 2>/dev/null; chattr -i /etc/resolv.conf 2>/dev/null; printf "nameserver 8.8.8.8\\nnameserver 8.8.4.4\\n" > /etc/resolv.conf; chattr +i /etc/resolv.conf; sleep 1'
ExecStart=$DNSTT_BINARY -udp :53$mtu_string -privkey-file $DNSTT_KEYS_DIR/server.key $TUNNEL_DOMAIN $FORWARD_TARGET
Restart=always
RestartSec=5
[Install]
WantedBy=multi-user.target
EOF
    echo -e "\n${C_BLUE}💾 Saving configuration and starting service...${C_RESET}"
    cat > "$DNSTT_CONFIG_FILE" <<-EOF
NS_SUBDOMAIN="$NS_SUBDOMAIN"
TUNNEL_SUBDOMAIN="$TUNNEL_SUBDOMAIN"
NS_DOMAIN="$NS_DOMAIN"
TUNNEL_DOMAIN="$TUNNEL_DOMAIN"
PUBLIC_KEY="$PUBLIC_KEY"
FORWARD_DESC="$forward_desc"
DNSTT_RECORDS_MANAGED="$DNSTT_RECORDS_MANAGED"
HAS_IPV6="$HAS_IPV6"
MTU_VALUE="$mtu_value"
EOF
    systemctl daemon-reload
    systemctl enable dnstt.service
    systemctl start dnstt.service
    sleep 2
    if systemctl is-active --quiet dnstt.service; then
        echo -e "\n${C_GREEN}✅ SUCCESS: DNSTT has been installed and started!${C_RESET}"
        show_dnstt_details
    else
        echo -e "\n${C_RED}❌ ERROR: DNSTT service failed to start.${C_RESET}"
        journalctl -u dnstt.service -n 15 --no-pager
    fi
}

uninstall_dnstt() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling DNSTT ---${C_RESET}"
    if [ ! -f "$DNSTT_SERVICE_FILE" ]; then
        echo -e "${C_YELLOW}ℹ️ DNSTT does not appear to be installed, skipping.${C_RESET}"
        return
    fi
    local confirm="y"
    if [[ "$UNINSTALL_MODE" != "silent" ]]; then
        read -p "👉 Are you sure you want to uninstall DNSTT? This will delete DNS records if they were auto-generated. (y/n): " confirm
    fi
    if [[ "$confirm" != "y" ]]; then
        echo -e "\n${C_YELLOW}❌ Uninstallation cancelled.${C_RESET}"
        return
    fi
    echo -e "${C_BLUE}🛑 Stopping and disabling DNSTT service...${C_RESET}"
    systemctl stop dnstt.service > /dev/null 2>&1
    systemctl disable dnstt.service > /dev/null 2>&1
    if [ -f "$DNSTT_CONFIG_FILE" ]; then
        source "$DNSTT_CONFIG_FILE"
        if [[ "$DNSTT_RECORDS_MANAGED" == "true" ]]; then
            echo -e "${C_BLUE}🗑️ Removing auto-generated DNS records...${C_RESET}"
            curl -s -X DELETE "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/$TUNNEL_SUBDOMAIN/NS/" \
                 -H "Authorization: Token $DESEC_TOKEN" > /dev/null
            curl -s -X DELETE "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/$NS_SUBDOMAIN/A/" \
                 -H "Authorization: Token $DESEC_TOKEN" > /dev/null
            if [[ "$HAS_IPV6" == "true" ]]; then
                curl -s -X DELETE "https://desec.io/api/v1/domains/$DESEC_DOMAIN/rrsets/$NS_SUBDOMAIN/AAAA/" \
                     -H "Authorization: Token $DESEC_TOKEN" > /dev/null
            fi
            echo -e "${C_GREEN}✅ DNS records have been removed.${C_RESET}"
        else
            echo -e "${C_YELLOW}⚠️ DNS records were manually configured. Please delete them from your DNS provider.${C_RESET}"
        fi
    fi
    echo -e "${C_BLUE}🗑️ Removing service files and binaries...${C_RESET}"
    rm -f "$DNSTT_SERVICE_FILE"
    rm -f "$DNSTT_BINARY"
    rm -rf "$DNSTT_KEYS_DIR"
    rm -f "$DNSTT_CONFIG_FILE"
    systemctl daemon-reload
    
    echo -e "${C_YELLOW}ℹ️ Restoring system DNS resolver...${C_RESET}"
    chattr -i /etc/resolv.conf &>/dev/null
    systemctl unmask systemd-resolved &>/dev/null
    systemctl enable systemd-resolved &>/dev/null
    systemctl start systemd-resolved &>/dev/null

    echo -e "\n${C_GREEN}✅ DNSTT has been successfully uninstalled.${C_RESET}"
}


# --- dnstt-deploy (replacement DNSTT installer, supplied by user) ---
deploy_dnstt_v2_script() {
    cat > "$DNSTT_V2_SCRIPT" <<'DNSTT_DEPLOY_EOF'
#!/bin/bash

# dnstt Server Setup Script
# Supports Fedora, Rocky, CentOS, Debian, Ubuntu

set -e

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\033[0;31m[ERROR]\033[0m This script must be run as root"
    exit 1
fi

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
DNSTT_BASE_URL="https://dnstt.network"
SCRIPT_URL="https://raw.githubusercontent.com/bugfloyd/dnstt-deploy/main/dnstt-deploy.sh"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/dnstt"
SYSTEMD_DIR="/etc/systemd/system"
DNSTT_PORT="5300"
DNSTT_USER="dnstt"
CONFIG_FILE="${CONFIG_DIR}/dnstt-server.conf"
SCRIPT_INSTALL_PATH="/usr/local/bin/dnstt-deploy"

# Global variable to track if update is available
UPDATE_AVAILABLE=false

# Function to install/update the script itself
install_script() {
    print_status "Installing/updating dnstt-deploy script..."

    # Download the latest version
    local temp_script="/tmp/dnstt-deploy-new.sh"
    curl -Ls "$SCRIPT_URL" -o "$temp_script"

    # Make it executable
    chmod +x "$temp_script"

    # Check if we're updating an existing installation
    if [ -f "$SCRIPT_INSTALL_PATH" ]; then
        # Compare checksums to see if update is needed
        local current_checksum
        local new_checksum
        current_checksum=$(sha256sum "$SCRIPT_INSTALL_PATH" | cut -d' ' -f1)
        new_checksum=$(sha256sum "$temp_script" | cut -d' ' -f1)

        if [ "$current_checksum" = "$new_checksum" ]; then
            print_status "Script is already up to date"
            rm "$temp_script"
            return 0
        else
            print_status "Updating existing script installation..."
        fi
    else
        print_status "Installing script for the first time..."
    fi

    # Copy to installation directory
    cp "$temp_script" "$SCRIPT_INSTALL_PATH"
    rm "$temp_script"

    print_status "Script installed to $SCRIPT_INSTALL_PATH"
    print_status "You can now run 'dnstt-deploy' from anywhere"
}

# Function to handle manual update
update_script() {
    print_status "Checking for script updates..."

    local temp_script="/tmp/dnstt-deploy-latest.sh"
    if ! curl -Ls "$SCRIPT_URL" -o "$temp_script"; then
        print_error "Failed to download latest version"
        return 1
    fi

    local current_checksum
    local latest_checksum
    current_checksum=$(sha256sum "$SCRIPT_INSTALL_PATH" | cut -d' ' -f1)
    latest_checksum=$(sha256sum "$temp_script" | cut -d' ' -f1)

    if [ "$current_checksum" = "$latest_checksum" ]; then
        print_status "You are already running the latest version"
        rm "$temp_script"
        return 0
    fi

    print_status "New version available! Updating..."
    chmod +x "$temp_script"
    cp "$temp_script" "$SCRIPT_INSTALL_PATH"
    rm "$temp_script"
    print_status "Script updated successfully!"
    print_status "Restarting with new version..."

    # Restart the script with the new version immediately
    exec "$SCRIPT_INSTALL_PATH"
}

# Function to show main menu
show_menu() {
    echo ""
    print_status "dnstt Server Management"
    print_status "======================="

    # Show update notification if available
    if [ "$UPDATE_AVAILABLE" = true ]; then
        echo -e "${YELLOW}[UPDATE AVAILABLE]${NC} A new version of this script is available!"
        echo -e "${YELLOW}                  ${NC} Use option 2 to update to the latest version."
        echo ""
    fi

    echo "1) Install/Reconfigure dnstt server"
    echo "2) Update dnstt-deploy script"
    echo "3) Check service status"
    echo "4) View service logs"
    echo "5) Show configuration info"
    echo "0) Exit"
    echo ""
    print_question "Please select an option (0-5): "
}

# Function to handle menu selection
handle_menu() {
    while true; do
        show_menu
        read -r choice

        case $choice in
            1)
                print_status "Starting dnstt server installation/reconfiguration..."
                return 0  # Continue with main installation
                ;;
            2)
                update_script
                ;;
            3)
                if systemctl is-active --quiet dnstt-server; then
                    print_status "dnstt-server service is running"
                    systemctl status dnstt-server --no-pager -l
                else
                    print_warning "dnstt-server service is not running"
                    systemctl status dnstt-server --no-pager -l
                fi
                ;;
            4)
                print_status "Showing dnstt-server logs (Press Ctrl+C to exit)..."
                journalctl -u dnstt-server -f
                ;;
            5)
                show_configuration_info
                ;;
            0)
                print_status "Goodbye!"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please enter 0-5."
                ;;
        esac

        if [ "$choice" != "4" ]; then
            echo ""
            print_question "Press Enter to continue..."
            read -r
        fi
    done
}

# Function to show configuration information
show_configuration_info() {
    print_status "Current Configuration Information"
    print_status "================================"

    # Check if configuration file exists
    if [ ! -f "$CONFIG_FILE" ]; then
        print_warning "No configuration found. Please install/configure dnstt server first."
        return 1
    fi

    # Load existing configuration
    if ! load_existing_config; then
        print_error "Failed to load configuration from $CONFIG_FILE"
        return 1
    fi

    # Check if service is running
    local service_status
    if systemctl is-active --quiet dnstt-server; then
        service_status="${GREEN}Running${NC}"
    else
        service_status="${RED}Stopped${NC}"
    fi

    echo ""
    echo -e "${BLUE}Configuration Details:${NC}"
    echo -e "  Nameserver subdomain: ${YELLOW}$NS_SUBDOMAIN${NC}"
    echo -e "  MTU: ${YELLOW}$MTU_VALUE${NC}"
    echo -e "  Tunnel mode: ${YELLOW}$TUNNEL_MODE${NC}"
    echo -e "  Service user: ${YELLOW}$DNSTT_USER${NC}"
    echo -e "  Listen port: ${YELLOW}$DNSTT_PORT${NC} (DNS traffic redirected from port 53)"
    echo -e "  Service status: $service_status"
    echo ""

    # Show public key if it exists
    if [ -f "$PUBLIC_KEY_FILE" ]; then
        echo -e "${BLUE}Public Key Content:${NC}"
        echo -e "${YELLOW}$(cat "$PUBLIC_KEY_FILE")${NC}"
        echo ""
    else
        print_warning "Public key file not found: $PUBLIC_KEY_FILE"
    fi

    echo -e "${BLUE}Management Commands:${NC}"
    echo -e "  Run menu:           ${YELLOW}dnstt-deploy${NC}"
    echo -e "  Start service:      ${YELLOW}systemctl start dnstt-server${NC}"
    echo -e "  Stop service:       ${YELLOW}systemctl stop dnstt-server${NC}"
    echo -e "  Service status:     ${YELLOW}systemctl status dnstt-server${NC}"
    echo -e "  View logs:          ${YELLOW}journalctl -u dnstt-server -f${NC}"

    # Show SOCKS info if applicable
    if [ "$TUNNEL_MODE" = "socks" ]; then
        echo ""
        echo -e "${BLUE}SOCKS Proxy Information:${NC}"
        echo -e "SOCKS proxy is running on ${YELLOW}127.0.0.1:1080${NC}"
        echo -e "${BLUE}Dante service commands:${NC}"
        echo -e "  Status:  ${YELLOW}systemctl status danted${NC}"
        echo -e "  Stop:    ${YELLOW}systemctl stop danted${NC}"
        echo -e "  Start:   ${YELLOW}systemctl start danted${NC}"
        echo -e "  Logs:    ${YELLOW}journalctl -u danted -f${NC}"
    fi

    echo ""
}
check_for_updates() {
    # Only check for updates if we're running from the installed location
    if [ "$0" = "$SCRIPT_INSTALL_PATH" ]; then
        print_status "Checking for script updates..."

        local temp_script="/tmp/dnstt-deploy-latest.sh"
        if curl -Ls "$SCRIPT_URL" -o "$temp_script" 2>/dev/null; then
            local current_checksum
            local latest_checksum
            current_checksum=$(sha256sum "$SCRIPT_INSTALL_PATH" | cut -d' ' -f1)
            latest_checksum=$(sha256sum "$temp_script" | cut -d' ' -f1)

            if [ "$current_checksum" != "$latest_checksum" ]; then
                UPDATE_AVAILABLE=true
                print_warning "New version available! Use menu option 2 to update."
            else
                print_status "Script is up to date"
            fi
            rm "$temp_script"
        else
            print_warning "Could not check for updates (network issue)"
        fi
    fi
}

# Function to load existing configuration
load_existing_config() {
    if [ -f "$CONFIG_FILE" ]; then
        print_status "Loading existing configuration..."
        # Source the config file to load variables
        # shellcheck source=/dev/null
        . "$CONFIG_FILE"
        return 0
    fi
    return 1
}

# Function to save configuration
save_config() {
    print_status "Saving configuration..."

    cat > "$CONFIG_FILE" << EOF
# dnstt Server Configuration
# Generated on $(date)

NS_SUBDOMAIN="$NS_SUBDOMAIN"
MTU_VALUE="$MTU_VALUE"
TUNNEL_MODE="$TUNNEL_MODE"
PRIVATE_KEY_FILE="$PRIVATE_KEY_FILE"
PUBLIC_KEY_FILE="$PUBLIC_KEY_FILE"
EOF

    chmod 640 "$CONFIG_FILE"
    chown root:"$DNSTT_USER" "$CONFIG_FILE"
    print_status "Configuration saved to $CONFIG_FILE"
}

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_question() {
    echo -ne "${BLUE}[QUESTION]${NC} $1"
}

# Function to print success box without [INFO] prefix
print_success_box() {
    local border_color='\033[1;32m'  # Bright green
    local text_color='\033[1;37m'    # Bright white text
    local key_color='\033[1;33m'     # Yellow for key
    local header_color='\033[1;36m'  # Cyan for headers
    local reset='\033[0m'

    echo ""
    # Top border
    echo -e "${border_color}+================================================================================${reset}"
    echo -e "${border_color}|                          SETUP COMPLETED SUCCESSFULLY!                       |${reset}"
    echo -e "${border_color}+================================================================================${reset}"
    echo ""

    # Configuration Details
    echo -e "${header_color}Configuration Details:${reset}"
    echo -e "  ${text_color}Nameserver subdomain: $NS_SUBDOMAIN${reset}"
    echo -e "  ${text_color}MTU: $MTU_VALUE${reset}"
    echo -e "  ${text_color}Tunnel mode: $TUNNEL_MODE${reset}"
    echo -e "  ${text_color}Service user: $DNSTT_USER${reset}"
    echo -e "  ${text_color}Listen port: $DNSTT_PORT (DNS traffic redirected from port 53)${reset}"
    echo ""

    # Public Key
    echo -e "${header_color}Public Key Content:${reset}"
    local pub_key_content
    pub_key_content=$(cat "$PUBLIC_KEY_FILE")
    echo -e "${key_color}$pub_key_content${reset}"
    echo ""

    # Script Location
    echo -e "${text_color}Script installed at: $SCRIPT_INSTALL_PATH${reset}"
    echo ""

    # Management Commands
    echo -e "${header_color}Management Commands:${reset}"
    echo -e "  ${text_color}Run menu:           dnstt-deploy${reset}"
    echo -e "  ${text_color}Start service:      systemctl start dnstt-server${reset}"
    echo -e "  ${text_color}Stop service:       systemctl stop dnstt-server${reset}"
    echo -e "  ${text_color}Service status:     systemctl status dnstt-server${reset}"
    echo -e "  ${text_color}View logs:          journalctl -u dnstt-server -f${reset}"

    # SOCKS info if applicable
    if [ "$TUNNEL_MODE" = "socks" ]; then
        echo ""
        echo -e "${header_color}SOCKS Proxy Information:${reset}"
        echo -e "${text_color}SOCKS proxy is running on 127.0.0.1:1080${reset}"
        echo -e "${text_color}Dante service commands:${reset}"
        echo -e "  ${text_color}Status:  systemctl status danted${reset}"
        echo -e "  ${text_color}Stop:    systemctl stop danted${reset}"
        echo -e "  ${text_color}Start:   systemctl start danted${reset}"
        echo -e "  ${text_color}Logs:    journalctl -u danted -f${reset}"
    fi

    # Bottom border
    echo ""
    echo -e "${border_color}+================================================================================${reset}"
    echo ""
}

# Function to print info lines without [INFO] prefix for final display
print_info_line() {
    local text_color='\033[1;37m'    # Bright white
    local reset='\033[0m'
    echo -e "${text_color}$1${reset}"
}

# Function to print section headers in final display
print_section_header() {
    local header_color='\033[1;36m'  # Bright cyan
    local reset='\033[0m'
    echo -e "${header_color}$1${reset}"
}

# Function to detect OS and package manager
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    else
        print_error "Cannot detect OS"
        exit 1
    fi

    # Determine package manager
    if command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
    elif command -v yum &> /dev/null; then
        PKG_MANAGER="yum"
    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
    else
        print_error "Unsupported package manager"
        exit 1
    fi

    print_status "Detected OS: $OS"
    print_status "Package manager: $PKG_MANAGER"
}

# Function to detect architecture
detect_arch() {
    local arch
    arch=$(uname -m)
    case $arch in
        x86_64)
            ARCH="amd64"
            ;;
        aarch64|arm64)
            ARCH="arm64"
            ;;
        armv7l|armv6l)
            ARCH="arm"
            ;;
        i386|i686)
            ARCH="386"
            ;;
        *)
            print_error "Unsupported architecture: $arch"
            exit 1
            ;;
    esac
    print_status "Detected architecture: $ARCH"
}

# Function to check and install required tools
check_required_tools() {
    print_status "Checking required tools..."

    local required_tools=("curl")
    local missing_tools=()

    # Check which tools are missing
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done

    # Check for iptables separately since it might need special handling
    if ! command -v "iptables" &> /dev/null; then
        missing_tools+=("iptables")
    fi

    if [ ${#missing_tools[@]} -gt 0 ]; then
        print_status "Installing missing tools: ${missing_tools[*]}"
        install_dependencies "${missing_tools[@]}"
    else
        print_status "All required tools are available"
    fi

    # Verify iptables installation after potential installation
    verify_iptables_installation
}

# Function to verify iptables installation and capabilities
verify_iptables_installation() {
    print_status "Verifying iptables installation..."

    if ! command -v iptables &> /dev/null; then
        print_error "iptables is not available after installation attempt"
        exit 1
    fi

    # Check if ip6tables is available (should be part of iptables package)
    if command -v ip6tables &> /dev/null; then
        print_status "Both iptables and ip6tables are available"
    else
        print_warning "ip6tables not found, IPv6 rules will be skipped"
    fi

    # Check if IPv6 is supported on the system
    if [ -f /proc/net/if_inet6 ]; then
        print_status "IPv6 support detected"
    else
        print_warning "IPv6 not supported on this system"
    fi
}

# Function to install dependencies
install_dependencies() {
    local tools=("$@")
    print_status "Installing dependencies: ${tools[*]}"

    # Safety check for PKG_MANAGER
    if [[ -z "$PKG_MANAGER" ]]; then
        print_error "Package manager not detected. Make sure detect_os() is called first."
        exit 1
    fi

    case $PKG_MANAGER in
        dnf|yum)
            # For RHEL-based systems
            local packages_to_install=()

            for tool in "${tools[@]}"; do
                case $tool in
                    "iptables")
                        packages_to_install+=("iptables" "iptables-services")
                        ;;
                    *)
                        packages_to_install+=("$tool")
                        ;;
                esac
            done

            if ! $PKG_MANAGER install -y "${packages_to_install[@]}"; then
                print_error "Failed to install packages: ${packages_to_install[*]}"
                exit 1
            fi
            ;;
        apt)
            # For Debian-based systems
            if ! apt update; then
                print_error "Failed to update package lists"
                exit 1
            fi

            local packages_to_install=()

            for tool in "${tools[@]}"; do
                case $tool in
                    "iptables")
                        # iptables package includes both iptables and ip6tables
                        packages_to_install+=("iptables" "iptables-persistent")
                        ;;
                    *)
                        packages_to_install+=("$tool")
                        ;;
                esac
            done

            if ! apt install -y "${packages_to_install[@]}"; then
                print_error "Failed to install packages: ${packages_to_install[*]}"
                exit 1
            fi
            ;;
        *)
            print_error "Unsupported package manager: $PKG_MANAGER"
            exit 1
            ;;
    esac

    print_status "Dependencies installed successfully"
}

# Function to get user input
get_user_input() {
    # Load existing configuration if available
    local existing_domain=""
    local existing_mtu=""
    local existing_mode=""

    if load_existing_config; then
        existing_domain="$NS_SUBDOMAIN"
        existing_mtu="$MTU_VALUE"
        existing_mode="$TUNNEL_MODE"
        print_status "Found existing configuration for domain: $existing_domain"
    fi

    # Get nameserver subdomain
    while true; do
        if [[ -n "$existing_domain" ]]; then
            print_question "Enter the nameserver subdomain (current: $existing_domain): "
        else
            print_question "Enter the nameserver subdomain (e.g., t.example.com): "
        fi
        read -r NS_SUBDOMAIN

        # Use existing domain if user just presses enter
        if [[ -z "$NS_SUBDOMAIN" && -n "$existing_domain" ]]; then
            NS_SUBDOMAIN="$existing_domain"
        fi

        if [[ -n "$NS_SUBDOMAIN" ]]; then
            break
        else
            print_error "Please enter a valid subdomain"
        fi
    done

    # Get MTU value
    if [[ -n "$existing_mtu" ]]; then
        print_question "Enter MTU value (current: $existing_mtu): "
    else
        print_question "Enter MTU value (default: 1232): "
    fi
    read -r MTU_VALUE

    # Use existing MTU if user just presses enter, otherwise use default
    if [[ -z "$MTU_VALUE" ]]; then
        if [[ -n "$existing_mtu" ]]; then
            MTU_VALUE="$existing_mtu"
        else
            MTU_VALUE="1232"
        fi
    fi

    # Get tunnel mode
    while true; do
        echo "Select tunnel mode:"
        echo "1) SOCKS proxy"
        echo "2) SSH mode"
        if [[ -n "$existing_mode" ]]; then
            local mode_number
            if [[ "$existing_mode" == "socks" ]]; then
                mode_number="1"
            else
                mode_number="2"
            fi
            print_question "Enter choice (current: $mode_number - $existing_mode): "
        else
            print_question "Enter choice (1 or 2): "
        fi
        read -r TUNNEL_MODE

        # Use existing mode if user just presses enter
        if [[ -z "$TUNNEL_MODE" && -n "$existing_mode" ]]; then
            TUNNEL_MODE="$existing_mode"
            break
        fi

        case $TUNNEL_MODE in
            1)
                TUNNEL_MODE="socks"
                break
                ;;
            2)
                TUNNEL_MODE="ssh"
                break
                ;;
            *)
                print_error "Invalid choice. Please enter 1 or 2"
                ;;
        esac
    done

    print_status "Configuration:"
    print_status "  Nameserver subdomain: $NS_SUBDOMAIN"
    print_status "  MTU: $MTU_VALUE"
    print_status "  Tunnel mode: $TUNNEL_MODE"
}

# Function to download and verify dnstt-server
download_dnstt_server() {
    local filename="dnstt-server-linux-${ARCH}"
    local filepath="${INSTALL_DIR}/dnstt-server"

    # Check if file already exists
    if [ -f "$filepath" ]; then
        print_status "dnstt-server already exists at $filepath"
        return 0
    fi

    print_status "Downloading dnstt-server..."

    # Download the binary
    curl -L -o "/tmp/$filename" "${DNSTT_BASE_URL}/$filename"

    # Download checksums
    curl -L -o "/tmp/MD5SUMS" "${DNSTT_BASE_URL}/MD5SUMS"
    curl -L -o "/tmp/SHA1SUMS" "${DNSTT_BASE_URL}/SHA1SUMS"
    curl -L -o "/tmp/SHA256SUMS" "${DNSTT_BASE_URL}/SHA256SUMS"

    # Verify checksums
    print_status "Verifying file integrity..."

    cd /tmp

    # Verify MD5
    if md5sum -c <(grep "$filename" MD5SUMS) 2>/dev/null; then
        print_status "MD5 checksum verified"
    else
        print_error "MD5 checksum verification failed"
        exit 1
    fi

    # Verify SHA1
    if sha1sum -c <(grep "$filename" SHA1SUMS) 2>/dev/null; then
        print_status "SHA1 checksum verified"
    else
        print_error "SHA1 checksum verification failed"
        exit 1
    fi

    # Verify SHA256
    if sha256sum -c <(grep "$filename" SHA256SUMS) 2>/dev/null; then
        print_status "SHA256 checksum verified"
    else
        print_error "SHA256 checksum verification failed"
        exit 1
    fi

    # Move to install directory and make executable
    chmod +x "/tmp/$filename"
    mv "/tmp/$filename" "$filepath"

    print_status "dnstt-server installed successfully"
}

# Function to create dnstt user
create_dnstt_user() {
    print_status "Creating dnstt user..."

    if ! id "$DNSTT_USER" &>/dev/null; then
        useradd -r -s /bin/false -d /nonexistent -c "dnstt service user" "$DNSTT_USER"
        print_status "Created user: $DNSTT_USER"
    else
        print_status "User $DNSTT_USER already exists"
    fi

    # Create config directory first
    mkdir -p "$CONFIG_DIR"

    # Set ownership of config directory
    chown -R "$DNSTT_USER":"$DNSTT_USER" "$CONFIG_DIR"
    chmod 750 "$CONFIG_DIR"
}

# Function to generate keys
generate_keys() {
    # Generate key file names based on subdomain
    local key_prefix
    # shellcheck disable=SC2001
    key_prefix=$(echo "$NS_SUBDOMAIN" | sed 's/\./_/g')
    PRIVATE_KEY_FILE="${CONFIG_DIR}/${key_prefix}_server.key"
    PUBLIC_KEY_FILE="${CONFIG_DIR}/${key_prefix}_server.pub"

    # Check if keys already exist for this domain
    if [[ -f "$PRIVATE_KEY_FILE" && -f "$PUBLIC_KEY_FILE" ]]; then
        print_status "Found existing keys for domain: $NS_SUBDOMAIN"
        print_status "  Private key: $PRIVATE_KEY_FILE"
        print_status "  Public key: $PUBLIC_KEY_FILE"

        # Verify key ownership and permissions
        chown "$DNSTT_USER":"$DNSTT_USER" "$PRIVATE_KEY_FILE" "$PUBLIC_KEY_FILE"
        chmod 600 "$PRIVATE_KEY_FILE"
        chmod 644 "$PUBLIC_KEY_FILE"

        print_status "Using existing keys (verified ownership and permissions)"
    else
        print_status "Generating new keys for domain: $NS_SUBDOMAIN"

        # Generate keys (run as root, then change ownership)
        dnstt-server -gen-key -privkey-file "$PRIVATE_KEY_FILE" -pubkey-file "$PUBLIC_KEY_FILE"

        # Set proper ownership and permissions
        chown "$DNSTT_USER":"$DNSTT_USER" "$PRIVATE_KEY_FILE" "$PUBLIC_KEY_FILE"
        chmod 600 "$PRIVATE_KEY_FILE"
        chmod 644 "$PUBLIC_KEY_FILE"

        print_status "New keys generated:"
        print_status "  Private key: $PRIVATE_KEY_FILE"
        print_status "  Public key: $PUBLIC_KEY_FILE"
    fi

    # Always display public key content
    print_status "Public key content:"
    cat "$PUBLIC_KEY_FILE"
}

# Function to configure iptables rules
configure_iptables() {
    print_status "Configuring iptables rules for DNS redirection..."

    # Verify iptables is available
    if ! command -v iptables &> /dev/null; then
        print_error "iptables command not found. Cannot configure firewall rules."
        exit 1
    fi

    # Get the primary network interface
    local interface
    interface=$(ip route | grep default | awk '{print $5}' | head -1)
    if [[ -z "$interface" ]]; then
        # Try alternative method to get interface
        interface=$(ip link show | grep -E "^[0-9]+: (eth|ens|enp)" | head -1 | cut -d':' -f2 | awk '{print $1}')
        if [[ -z "$interface" ]]; then
            interface="eth0"  # fallback
            print_warning "Could not detect network interface, using eth0 as fallback"
        else
            print_status "Detected network interface: $interface"
        fi
    else
        print_status "Using network interface: $interface"
    fi

    # IPv4 rules
    print_status "Setting up IPv4 iptables rules..."

    if ! iptables -I INPUT -p udp --dport "$DNSTT_PORT" -j ACCEPT; then
        print_error "Failed to add IPv4 INPUT rule"
        exit 1
    fi

    if ! iptables -t nat -I PREROUTING -i "$interface" -p udp --dport 53 -j REDIRECT --to-ports "$DNSTT_PORT"; then
        print_error "Failed to add IPv4 NAT rule"
        exit 1
    fi

    print_status "IPv4 iptables rules configured successfully"

    # IPv6 rules (if IPv6 and ip6tables are available)
    if command -v ip6tables &> /dev/null && [ -f /proc/net/if_inet6 ]; then
        print_status "Setting up IPv6 iptables rules..."

        if ip6tables -I INPUT -p udp --dport "$DNSTT_PORT" -j ACCEPT 2>/dev/null; then
            print_status "IPv6 INPUT rule added successfully"
        else
            print_warning "Failed to add IPv6 INPUT rule (IPv6 might not be fully configured)"
        fi

        if ip6tables -t nat -I PREROUTING -i "$interface" -p udp --dport 53 -j REDIRECT --to-ports "$DNSTT_PORT" 2>/dev/null; then
            print_status "IPv6 NAT rule added successfully"
        else
            print_warning "Failed to add IPv6 NAT rule (IPv6 NAT might not be supported)"
        fi
    else
        if ! command -v ip6tables &> /dev/null; then
            print_warning "ip6tables not available, skipping IPv6 rules"
        elif [ ! -f /proc/net/if_inet6 ]; then
            print_warning "IPv6 not enabled on system, skipping IPv6 rules"
        fi
    fi

    # Save iptables rules based on distribution
    save_iptables_rules
}

# Function to save iptables rules with better error handling
save_iptables_rules() {
    print_status "Saving iptables rules..."

    case $PKG_MANAGER in
        dnf|yum)
            # For RHEL-based systems
            if command -v iptables-save &> /dev/null; then
                # Create directory if it doesn't exist
                mkdir -p /etc/sysconfig

                if iptables-save > /etc/sysconfig/iptables; then
                    print_status "IPv4 iptables rules saved to /etc/sysconfig/iptables"
                else
                    print_warning "Failed to save IPv4 iptables rules"
                fi

                if command -v ip6tables-save &> /dev/null && [ -f /proc/net/if_inet6 ]; then
                    if ip6tables-save > /etc/sysconfig/ip6tables; then
                        print_status "IPv6 iptables rules saved to /etc/sysconfig/ip6tables"
                    else
                        print_warning "Failed to save IPv6 iptables rules"
                    fi
                fi

                # Enable and start iptables service if available
                if systemctl list-unit-files | grep -q iptables.service; then
                    systemctl enable iptables 2>/dev/null || print_warning "Could not enable iptables service"
                    if command -v ip6tables &> /dev/null && [ -f /proc/net/if_inet6 ]; then
                        systemctl enable ip6tables 2>/dev/null || print_warning "Could not enable ip6tables service"
                    fi
                fi
            else
                print_warning "iptables-save not available, rules will not persist after reboot"
            fi
            ;;
        apt)
            # For Debian-based systems
            if command -v iptables-save &> /dev/null; then
                # Create directory if it doesn't exist
                mkdir -p /etc/iptables

                if iptables-save > /etc/iptables/rules.v4; then
                    print_status "IPv4 iptables rules saved to /etc/iptables/rules.v4"
                else
                    print_warning "Failed to save IPv4 iptables rules"
                fi

                if command -v ip6tables-save &> /dev/null && [ -f /proc/net/if_inet6 ]; then
                    if ip6tables-save > /etc/iptables/rules.v6; then
                        print_status "IPv6 iptables rules saved to /etc/iptables/rules.v6"
                    else
                        print_warning "Failed to save IPv6 iptables rules"
                    fi
                fi

                # Try to enable netfilter-persistent if available
                if systemctl list-unit-files | grep -q netfilter-persistent.service; then
                    systemctl enable netfilter-persistent 2>/dev/null || print_warning "Could not enable netfilter-persistent service"
                fi
            else
                print_warning "iptables-save not available, rules will not persist after reboot"
            fi
            ;;
    esac
}

# Function to configure firewall
configure_firewall() {
    print_status "Configuring firewall..."

    # Check if firewalld is available and active
    if command -v firewall-cmd &> /dev/null && systemctl is-active --quiet firewalld; then
        print_status "Configuring active firewalld..."
        firewall-cmd --permanent --add-port="$DNSTT_PORT"/udp
        firewall-cmd --permanent --add-port=53/udp
        firewall-cmd --reload
        print_status "Firewalld configured successfully"

    # Check if ufw is available and active
    elif command -v ufw &> /dev/null && ufw status | grep -q "Status: active"; then
        print_status "Configuring active ufw..."
        ufw allow "$DNSTT_PORT"/udp
        ufw allow 53/udp
        print_status "UFW configured successfully"

    else
        print_status "No active firewall service detected"
        print_status "Available firewall tools:"

        # List available but inactive firewall tools
        if command -v firewall-cmd &> /dev/null; then
            print_status "  - firewalld (inactive)"
        fi
        if command -v ufw &> /dev/null; then
            print_status "  - ufw (inactive)"
        fi

        print_status "Relying on iptables rules only"
        print_status "If you have a firewall active, manually allow ports $DNSTT_PORT/udp and 53/udp"
    fi

    # Configure iptables rules regardless of firewall service
    configure_iptables
}

# Function to detect SSH port
detect_ssh_port() {
    local ssh_port
    ssh_port=$(ss -tlnp | grep sshd | awk '{print $4}' | cut -d':' -f2 | head -1)
    if [[ -z "$ssh_port" ]]; then
        # Fallback to default SSH port
        ssh_port="22"
    fi
    echo "$ssh_port"
}

# Function to install and configure Dante SOCKS proxy
setup_dante() {
    print_status "Setting up Dante SOCKS proxy..."

    # Install Dante
    case $PKG_MANAGER in
        dnf|yum)
            $PKG_MANAGER install -y dante-server
            ;;
        apt)
            apt install -y dante-server
            ;;
    esac

    # Get the primary network interface for external interface
    local external_interface
    external_interface=$(ip route | grep default | awk '{print $5}' | head -1)
    if [[ -z "$external_interface" ]]; then
        external_interface="eth0"  # fallback
    fi

    # Configure Dante
    cat > /etc/danted.conf << EOF
# Dante SOCKS server configuration
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# Internal interface (where clients connect)
internal: 127.0.0.1 port = 1080

# External interface (where connections go out)
external: $external_interface

# Authentication method
socksmethod: none

# Compatibility settings
compatibility: sameport
extension: bind

# Client rules - allow connections from localhost
client pass {
    from: 127.0.0.0/8 to: 0.0.0.0/0
    log: error
}

# SOCKS rules - allow SOCKS requests to anywhere
socks pass {
    from: 127.0.0.0/8 to: 0.0.0.0/0
    command: bind connect udpassociate
    log: error
}

# Block IPv6 if not properly configured
socks block {
    from: 0.0.0.0/0 to: ::/0
    log: error
}

client block {
    from: 0.0.0.0/0 to: ::/0
    log: error
}
EOF

    # Enable and start Dante service
    systemctl enable danted
    systemctl restart danted

    print_status "Dante SOCKS proxy configured and started on port 1080"
    print_status "External interface: $external_interface"
}

# Function to create systemd service
create_systemd_service() {
    print_status "Creating systemd service..."

    local service_name="dnstt-server"
    local service_file="${SYSTEMD_DIR}/${service_name}.service"
    local target_port

    if [ "$TUNNEL_MODE" = "ssh" ]; then
        target_port=$(detect_ssh_port)
        print_status "Detected SSH port: $target_port"
    else
        target_port="1080"  # Dante SOCKS port
    fi

    # Stop service if it's running to allow reconfiguration
    if systemctl is-active --quiet "$service_name"; then
        print_status "Stopping existing dnstt-server service for reconfiguration..."
        systemctl stop "$service_name"
    fi

    # Create systemd service file
    cat > "$service_file" << EOF
[Unit]
Description=dnstt DNS Tunnel Server
After=network.target
Wants=network.target

[Service]
Type=simple
User=$DNSTT_USER
Group=$DNSTT_USER
ExecStart=${INSTALL_DIR}/dnstt-server -udp :${DNSTT_PORT} -privkey-file ${PRIVATE_KEY_FILE} -mtu ${MTU_VALUE} ${NS_SUBDOMAIN} 127.0.0.1:${target_port}
Restart=always
RestartSec=5
KillMode=mixed
TimeoutStopSec=5

# Security settings
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true
ReadOnlyPaths=/
ReadWritePaths=${CONFIG_DIR}
PrivateTmp=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd and enable service
    systemctl daemon-reload
    systemctl enable "$service_name"

    print_status "Systemd service created: $service_name"
    print_status "Service will run as user: $DNSTT_USER"
    print_status "Service will listen on port: $DNSTT_PORT (redirected from port 53)"
    print_status "Service will tunnel to 127.0.0.1:$target_port"
    print_status "Mode: $TUNNEL_MODE"
}

# Function to start services
start_services() {
    print_status "Starting services..."

    # Start dnstt-server service
    systemctl start dnstt-server

    print_status "dnstt-server service started"

    # Show service status
    systemctl status dnstt-server --no-pager -l
}

# Function to display final information
display_final_info() {
    print_success_box
}

# Main function
main() {
    # If not running from installed location (curl/GitHub), install the script first
    if [ "$0" != "$SCRIPT_INSTALL_PATH" ]; then
        print_status "Installing dnstt-deploy script..."
        install_script
        print_status "Starting dnstt server setup..."
    else
        # Running from installed location - check for updates and show menu
        check_for_updates
        handle_menu
        # If we reach here, user chose option 1 (Install/Reconfigure), so continue
        print_status "Starting dnstt server installation/reconfiguration..."
    fi

    # Detect OS and architecture
    detect_os
    detect_arch

    # Check and install required tools
    check_required_tools

    # Get user input
    get_user_input

    # Download and verify dnstt-server
    download_dnstt_server

    # Create dnstt user
    create_dnstt_user

    # Generate keys
    generate_keys

    # Save configuration after keys are generated
    save_config

    # Configure firewall and iptables
    configure_firewall

    # Setup tunnel mode specific configurations
    if [ "$TUNNEL_MODE" = "socks" ]; then
        setup_dante
    else
        # If switching from SOCKS to SSH, stop and disable Dante
        if systemctl is-active --quiet danted; then
            print_status "Switching from SOCKS to SSH mode - stopping Dante service..."
            systemctl stop danted
            systemctl disable danted
        fi
    fi

    # Create systemd service
    create_systemd_service

    # Start services
    start_services

    # Display final information
    display_final_info
}

# Run main function
main "$@"
DNSTT_DEPLOY_EOF
    chmod +x "$DNSTT_V2_SCRIPT"
}

run_dnstt_v2() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📡 DNSTT (dnstt-deploy) ---${C_RESET}"
    if [ ! -x "$DNSTT_V2_SCRIPT" ]; then
        echo -e "\n${C_BLUE}📥 Deploying dnstt-deploy...${C_RESET}"
        deploy_dnstt_v2_script
    fi
    echo -e "${C_DIM}Handing off to dnstt-deploy's own menu. It will return here when you exit it.${C_RESET}"
    bash "$DNSTT_V2_SCRIPT"
}

uninstall_dnstt_v2() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling DNSTT (dnstt-deploy) ---${C_RESET}"
    if [ ! -f "$DNSTT_V2_SERVICE_FILE" ] && [ ! -f "$DNSTT_V2_SCRIPT" ] && [ ! -d "$DNSTT_V2_CONFIG_DIR" ]; then
        echo -e "${C_YELLOW}ℹ️ dnstt-deploy does not appear to be installed, skipping.${C_RESET}"
        return
    fi
    local confirm="y"
    if [[ "$UNINSTALL_MODE" != "silent" ]]; then
        read -p "👉 Are you sure you want to uninstall DNSTT (dnstt-deploy)? (y/n): " confirm
    fi
    if [[ "$confirm" != "y" ]]; then
        echo -e "\n${C_YELLOW}❌ Uninstallation cancelled.${C_RESET}"
        return
    fi
    echo -e "${C_BLUE}🛑 Stopping and disabling dnstt-server / danted...${C_RESET}"
    systemctl stop dnstt-server.service >/dev/null 2>&1
    systemctl disable dnstt-server.service >/dev/null 2>&1
    systemctl stop danted >/dev/null 2>&1
    systemctl disable danted >/dev/null 2>&1
    echo -e "${C_BLUE}🗑️ Removing service file, binary, config, and user...${C_RESET}"
    rm -f "$DNSTT_V2_SERVICE_FILE"
    rm -f "$DNSTT_BINARY"
    rm -f "$DNSTT_V2_SCRIPT"
    rm -rf "$DNSTT_V2_CONFIG_DIR"
    rm -f /etc/danted.conf
    if id "$DNSTT_V2_USER" &>/dev/null; then userdel "$DNSTT_V2_USER" &>/dev/null; fi
    systemctl daemon-reload
    echo -e "\n${C_YELLOW}ℹ️ Note: iptables DNAT rules for port 53->5300 were added by dnstt-deploy and are not auto-removed here.${C_RESET}"
    echo -e "${C_DIM}Check with: iptables -t nat -L PREROUTING -n --line-numbers${C_RESET}"
    echo -e "\n${C_GREEN}✅ DNSTT (dnstt-deploy) has been successfully uninstalled.${C_RESET}"
}

# --- slipstream-rust-deploy (DNS tunnel, replacement/alternative to dnstt-deploy - user supplied) ---
deploy_slipstream_v2_script() {
    cat > "$SLIPSTREAM_V2_SCRIPT" <<'SLIPSTREAM_DEPLOY_EOF'
#!/bin/bash

# slipstream-rust Server Setup Script
# Supports Fedora, Rocky, CentOS, Debian, Ubuntu

set -e

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\033[0;31m[ERROR]\033[0m This script must be run as root"
    exit 1
fi

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
SCRIPT_URL="https://raw.githubusercontent.com/noelrubio143/sliptream/refs/heads/main/slipstream-rust-deploy.sh"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/slipstream-rust"
SYSTEMD_DIR="/etc/systemd/system"
SLIPSTREAM_USER="slipstream"
CONFIG_FILE="${CONFIG_DIR}/slipstream-rust-server.conf"
SCRIPT_INSTALL_PATH="/usr/local/bin/slipstream-rust-deploy"
BUILD_DIR="/opt/slipstream-rust"
REPO_URL="https://github.com/Mygod/slipstream-rust.git"
SLIPSTREAM_PORT="5301"
RELEASE_URL="https://github.com/noelrubio143/sliptream/tree/main"

# Global variable to track if update is available
UPDATE_AVAILABLE=false

# Print functions
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_question() {
    echo -ne "${BLUE}[QUESTION]${NC} $1"
}

# Function to install/update the script itself
install_script() {
    print_status "Installing/updating slipstream-rust-deploy script..."

    # Download the latest version
    local temp_script="/tmp/slipstream-rust-deploy-new.sh"
    curl -Ls "$SCRIPT_URL" -o "$temp_script"

    # Make it executable
    chmod +x "$temp_script"

    # Check if we're updating an existing installation
    if [ -f "$SCRIPT_INSTALL_PATH" ]; then
        # Compare checksums to see if update is needed
        local current_checksum
        local new_checksum
        current_checksum=$(sha256sum "$SCRIPT_INSTALL_PATH" | cut -d' ' -f1)
        new_checksum=$(sha256sum "$temp_script" | cut -d' ' -f1)

        if [ "$current_checksum" = "$new_checksum" ]; then
            print_status "Script is already up to date"
            rm "$temp_script"
            return 0
        else
            print_status "Updating existing script installation..."
        fi
    else
        print_status "Installing script for the first time..."
    fi

    # Copy to installation directory
    cp "$temp_script" "$SCRIPT_INSTALL_PATH"
    rm "$temp_script"

    print_status "Script installed to $SCRIPT_INSTALL_PATH"
    print_status "You can now run 'slipstream-rust-deploy' from anywhere"
}

# Function to handle manual update
update_script() {
    print_status "Checking for script updates..."

    local temp_script="/tmp/slipstream-rust-deploy-latest.sh"
    if ! curl -Ls "$SCRIPT_URL" -o "$temp_script"; then
        print_error "Failed to download latest version"
        return 1
    fi

    local current_checksum
    local latest_checksum
    current_checksum=$(sha256sum "$SCRIPT_INSTALL_PATH" | cut -d' ' -f1)
    latest_checksum=$(sha256sum "$temp_script" | cut -d' ' -f1)

    if [ "$current_checksum" = "$latest_checksum" ]; then
        print_status "You are already running the latest version"
        rm "$temp_script"
        return 0
    fi

    print_status "New version available! Updating..."
    chmod +x "$temp_script"
    cp "$temp_script" "$SCRIPT_INSTALL_PATH"
    rm "$temp_script"
    print_status "Script updated successfully!"
    print_status "Restarting with new version..."

    # Restart the script with the new version immediately
    exec "$SCRIPT_INSTALL_PATH"
}

# Function to check for updates
check_for_updates() {
    # Only check for updates if we're running from the installed location
    if [ "$0" = "$SCRIPT_INSTALL_PATH" ]; then
        print_status "Checking for script updates..."

        local temp_script="/tmp/slipstream-rust-deploy-latest.sh"
        if curl -Ls "$SCRIPT_URL" -o "$temp_script" 2>/dev/null; then
            local current_checksum
            local latest_checksum
            current_checksum=$(sha256sum "$SCRIPT_INSTALL_PATH" | cut -d' ' -f1)
            latest_checksum=$(sha256sum "$temp_script" | cut -d' ' -f1)

            if [ "$current_checksum" != "$latest_checksum" ]; then
                UPDATE_AVAILABLE=true
                print_warning "New version available! Use menu option 2 to update."
            else
                print_status "Script is up to date"
            fi
            rm "$temp_script"
        else
            print_warning "Could not check for updates (network issue)"
        fi
    fi
}

# Function to uninstall slipstream-rust
uninstall_slipstream() {
    print_warning "This will completely remove slipstream-rust from your system."
    print_question "Are you sure you want to uninstall? (y/N): "
    read -r confirm

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        print_status "Uninstall cancelled."
        return 1
    fi

    print_status "Uninstalling slipstream-rust..."

    # Stop and disable slipstream-rust-server service
    if systemctl is-active --quiet slipstream-rust-server 2>/dev/null; then
        print_status "Stopping slipstream-rust-server service..."
        systemctl stop slipstream-rust-server
    fi
    if systemctl is-enabled --quiet slipstream-rust-server 2>/dev/null; then
        print_status "Disabling slipstream-rust-server service..."
        systemctl disable slipstream-rust-server
    fi

    # Remove systemd service file
    if [ -f "${SYSTEMD_DIR}/slipstream-rust-server.service" ]; then
        print_status "Removing systemd service file..."
        rm -f "${SYSTEMD_DIR}/slipstream-rust-server.service"
        systemctl daemon-reload
    fi

    # Stop and disable Dante if running
    if systemctl is-active --quiet danted 2>/dev/null; then
        print_status "Stopping Dante SOCKS service..."
        systemctl stop danted
    fi
    if systemctl is-enabled --quiet danted 2>/dev/null; then
        print_status "Disabling Dante SOCKS service..."
        systemctl disable danted
    fi

    # Stop and disable Shadowsocks if running
    if systemctl is-active --quiet shadowsocks-libev-server@config 2>/dev/null; then
        print_status "Stopping Shadowsocks service..."
        systemctl stop shadowsocks-libev-server@config
    fi
    if systemctl is-enabled --quiet shadowsocks-libev-server@config 2>/dev/null; then
        print_status "Disabling Shadowsocks service..."
        systemctl disable shadowsocks-libev-server@config
    fi
    # Remove Shadowsocks config if exists (both system and snap paths)
    if [ -f /etc/shadowsocks-libev/config.json ]; then
        print_status "Removing Shadowsocks configuration..."
        rm -f /etc/shadowsocks-libev/config.json
    fi
    if [ -f /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json ]; then
        print_status "Removing Shadowsocks snap configuration..."
        rm -f /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json
    fi

    # Remove slipstream-server binary
    if [ -f "${INSTALL_DIR}/slipstream-server" ]; then
        print_status "Removing slipstream-server binary..."
        rm -f "${INSTALL_DIR}/slipstream-server"
    fi

    # Remove configuration directory
    if [ -d "$CONFIG_DIR" ]; then
        print_status "Removing configuration directory..."
        rm -rf "$CONFIG_DIR"
    fi

    # Remove build directory
    if [ -d "$BUILD_DIR" ]; then
        print_status "Removing build directory..."
        rm -rf "$BUILD_DIR"
    fi

    # Remove slipstream user
    if id "$SLIPSTREAM_USER" &>/dev/null; then
        print_status "Removing slipstream user..."
        userdel "$SLIPSTREAM_USER" 2>/dev/null || true
    fi

    # Stop and disable iptables restore service
    if systemctl is-active --quiet slipstream-restore-iptables 2>/dev/null; then
        print_status "Stopping slipstream-restore-iptables service..."
        systemctl stop slipstream-restore-iptables
    fi
    if systemctl is-enabled --quiet slipstream-restore-iptables 2>/dev/null; then
        print_status "Disabling slipstream-restore-iptables service..."
        systemctl disable slipstream-restore-iptables
    fi
    if [ -f "${SYSTEMD_DIR}/slipstream-restore-iptables.service" ]; then
        print_status "Removing iptables restore service..."
        rm -f "${SYSTEMD_DIR}/slipstream-restore-iptables.service"
        systemctl daemon-reload
    fi
    if [ -f "/usr/local/bin/slipstream-restore-iptables.sh" ]; then
        print_status "Removing iptables restore script..."
        rm -f "/usr/local/bin/slipstream-restore-iptables.sh"
    fi

    # Remove iptables rules (best effort)
    print_status "Removing iptables rules..."
    iptables -D INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT 2>/dev/null || true
    local interface
    interface=$(ip route | grep default | awk '{print $5}' | head -1)
    if [[ -n "$interface" ]]; then
        iptables -t nat -D PREROUTING -i "$interface" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT" 2>/dev/null || true
        if command -v ip6tables &> /dev/null; then
            ip6tables -D INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT 2>/dev/null || true
            ip6tables -t nat -D PREROUTING -i "$interface" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT" 2>/dev/null || true
        fi
    fi

    # Ask about removing the deploy script itself
    print_question "Do you also want to remove the slipstream-rust-deploy script? (y/N): "
    read -r remove_script

    if [[ "$remove_script" =~ ^[Yy]$ ]]; then
        print_status "Removing slipstream-rust-deploy script..."
        rm -f "$SCRIPT_INSTALL_PATH"
        print_status "Uninstall complete! The deploy script has been removed."
    else
        print_status "Uninstall complete! The deploy script remains at $SCRIPT_INSTALL_PATH"
    fi

    return 0
}

# Function to show main menu
show_menu() {
    echo ""
    print_status "slipstream-rust Server Management"
    print_status "=================================="

    # Show update notification if available
    if [ "$UPDATE_AVAILABLE" = true ]; then
        echo -e "${YELLOW}[UPDATE AVAILABLE]${NC} A new version of this script is available!"
        echo -e "${YELLOW}                  ${NC} Use option 2 to update to the latest version."
        echo ""
    fi

    echo "1) Install/Reconfigure slipstream-rust server"
    echo "2) Update slipstream-rust-deploy script"
    echo "3) Check service status"
    echo "4) View service logs"
    echo "5) Show configuration info"
    echo "6) Uninstall slipstream-rust"
    echo "0) Exit"
    echo ""
    print_question "Please select an option (0-6): "
}

# Function to handle menu selection
handle_menu() {
    while true; do
        show_menu
        read -r choice

        case $choice in
            1)
                print_status "Starting slipstream-rust server installation/reconfiguration..."
                return 0  # Continue with main installation
                ;;
            2)
                update_script
                ;;
            3)
                if systemctl is-active --quiet slipstream-rust-server; then
                    print_status "slipstream-rust-server service is running"
                    systemctl status slipstream-rust-server --no-pager -l
                else
                    print_warning "slipstream-rust-server service is not running"
                    systemctl status slipstream-rust-server --no-pager -l
                fi
                ;;
            4)
                print_status "Showing slipstream-rust-server logs (Press Ctrl+C to exit)..."
                journalctl -u slipstream-rust-server -f
                ;;
            5)
                show_configuration_info
                ;;
            6)
                if uninstall_slipstream; then
                    exit 0
                fi
                ;;
            0)
                print_status "Goodbye!"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please enter 0-6."
                ;;
        esac

        if [ "$choice" != "4" ]; then
            echo ""
            print_question "Press Enter to continue..."
            read -r
        fi
    done
}

detect_active_mode() {
    if systemctl is-active --quiet shadowsocks-libev-server@config 2>/dev/null || \
       systemctl is-active --quiet shadowsocks-libev 2>/dev/null; then
        echo "shadowsocks"
        return 0
    fi
    
    if systemctl is-active --quiet danted 2>/dev/null; then
        echo "socks"
        return 0
    fi
    
    echo ""
    return 0
}

# Function to load existing configuration
load_existing_config() {
    if [ -f "$CONFIG_FILE" ]; then
        print_status "Loading existing configuration..."
        # Source the config file to load variables
        # shellcheck source=/dev/null
        . "$CONFIG_FILE"
        return 0
    fi
    return 1
}

# Function to save configuration
save_config() {
    print_status "Saving configuration..."

    cat > "$CONFIG_FILE" << EOF
# slipstream-rust Server Configuration
# Generated on $(date)

DOMAIN="$DOMAIN"
TUNNEL_MODE="$TUNNEL_MODE"
CERT_FILE="$CERT_FILE"
KEY_FILE="$KEY_FILE"
EOF

    if [ "$TUNNEL_MODE" = "socks" ]; then
        cat >> "$CONFIG_FILE" << EOF
SOCKS_AUTH_ENABLED="${SOCKS_AUTH_ENABLED:-no}"
SOCKS_USERNAME="${SOCKS_USERNAME:-}"
SOCKS_PASSWORD="${SOCKS_PASSWORD:-}"
EOF
    fi

    if [ "$TUNNEL_MODE" = "shadowsocks" ]; then
        cat >> "$CONFIG_FILE" << EOF
SHADOWSOCKS_PORT="${SHADOWSOCKS_PORT:-8388}"
SHADOWSOCKS_PASSWORD="${SHADOWSOCKS_PASSWORD:-}"
SHADOWSOCKS_METHOD="${SHADOWSOCKS_METHOD:-aes-256-gcm}"
EOF
    fi

    chmod 640 "$CONFIG_FILE"
    chown root:"$SLIPSTREAM_USER" "$CONFIG_FILE"
    print_status "Configuration saved to $CONFIG_FILE"
}

# Function to show configuration information
show_configuration_info() {
    print_status "Current Configuration Information"
    print_status "================================"

    # Check if configuration file exists
    if [ ! -f "$CONFIG_FILE" ]; then
        print_warning "No configuration found. Please install/configure slipstream-rust server first."
        return 1
    fi

    # Load existing configuration
    if ! load_existing_config; then
        print_error "Failed to load configuration from $CONFIG_FILE"
        return 1
    fi

    # Check if service is running
    local service_status
    if systemctl is-active --quiet slipstream-rust-server; then
        service_status="${GREEN}Running${NC}"
    else
        service_status="${RED}Stopped${NC}"
    fi

    echo ""
    echo -e "${BLUE}Configuration Details:${NC}"
    echo -e "  Domain: ${YELLOW}$DOMAIN${NC}"
    echo -e "  Tunnel mode: ${YELLOW}$TUNNEL_MODE${NC}"
    echo -e "  Service user: ${YELLOW}$SLIPSTREAM_USER${NC}"
    echo -e "  Listen port: ${YELLOW}$SLIPSTREAM_PORT${NC} (DNS traffic redirected from port 53)"
    echo -e "  Service status: $service_status"
    echo ""

    echo -e "${BLUE}Management Commands:${NC}"
    echo -e "  Run menu:           ${YELLOW}slipstream-rust-deploy${NC}"
    echo -e "  Start service:      ${YELLOW}systemctl start slipstream-rust-server${NC}"
    echo -e "  Stop service:       ${YELLOW}systemctl stop slipstream-rust-server${NC}"
    echo -e "  Service status:     ${YELLOW}systemctl status slipstream-rust-server${NC}"
    echo -e "  View logs:          ${YELLOW}journalctl -u slipstream-rust-server -f${NC}"

    # Show SOCKS info if applicable
    if [ "$TUNNEL_MODE" = "socks" ]; then
        echo ""
        echo -e "${BLUE}SOCKS Proxy Information:${NC}"
        echo -e "SOCKS proxy is running on ${YELLOW}127.0.0.1:1080${NC}"
        if [[ "${SOCKS_AUTH_ENABLED:-no}" == "yes" && -n "${SOCKS_USERNAME:-}" ]]; then
            echo -e "Authentication: ${GREEN}Enabled${NC} (username: ${YELLOW}$SOCKS_USERNAME${NC})"
        else
            echo -e "Authentication: ${YELLOW}Disabled${NC}"
        fi
        echo -e "${BLUE}Dante service commands:${NC}"
        echo -e "  Status:  ${YELLOW}systemctl status danted${NC}"
        echo -e "  Stop:    ${YELLOW}systemctl stop danted${NC}"
        echo -e "  Start:   ${YELLOW}systemctl start danted${NC}"
        echo -e "  Logs:    ${YELLOW}journalctl -u danted -f${NC}"
    fi

    # Show Shadowsocks info if applicable
    if [ "$TUNNEL_MODE" = "shadowsocks" ]; then
        echo ""
        echo -e "${BLUE}Shadowsocks Information:${NC}"
        echo -e "Shadowsocks server is running on ${YELLOW}127.0.0.1:${SHADOWSOCKS_PORT:-8388}${NC}"
        echo -e "Encryption method: ${YELLOW}${SHADOWSOCKS_METHOD:-aes-256-gcm}${NC}"
        echo -e "${BLUE}Shadowsocks service commands:${NC}"
        echo -e "  Status:  ${YELLOW}systemctl status shadowsocks-libev-server@config${NC}"
        echo -e "  Stop:    ${YELLOW}systemctl stop shadowsocks-libev-server@config${NC}"
        echo -e "  Start:   ${YELLOW}systemctl start shadowsocks-libev-server@config${NC}"
        echo -e "  Logs:    ${YELLOW}journalctl -u shadowsocks-libev-server@config -f${NC}"
    fi

    echo ""
}

# Function to detect OS and package manager
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    else
        print_error "Cannot detect OS"
        exit 1
    fi

    # Determine package manager
    if command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
    elif command -v yum &> /dev/null; then
        PKG_MANAGER="yum"
    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
    else
        print_error "Unsupported package manager"
        exit 1
    fi

    print_status "Detected OS: $OS"
    print_status "Package manager: $PKG_MANAGER"
}

# Function to check and install required tools
check_required_tools() {
    print_status "Checking required tools..."

    local required_tools=("curl" "git" "rustc" "cargo" "cmake" "pkg-config")
    local missing_tools=()

    # Check which tools are missing
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done

    # Check for iptables separately since it might need special handling
    if ! command -v "iptables" &> /dev/null; then
        missing_tools+=("iptables")
    fi

    # Check for OpenSSL development headers
    if ! pkg-config --exists openssl 2>/dev/null; then
        missing_tools+=("openssl-dev")
    fi

    if [ ${#missing_tools[@]} -gt 0 ]; then
        print_status "Installing missing tools: ${missing_tools[*]}"
        install_dependencies "${missing_tools[@]}"
    else
        print_status "All required tools are available"
    fi

    # Verify iptables installation after potential installation
    verify_iptables_installation
}

# Function to verify iptables installation and capabilities
verify_iptables_installation() {
    print_status "Verifying iptables installation..."

    if ! command -v iptables &> /dev/null; then
        print_error "iptables is not available after installation attempt"
        exit 1
    fi

    # Check if ip6tables is available (should be part of iptables package)
    if command -v ip6tables &> /dev/null; then
        print_status "Both iptables and ip6tables are available"
    else
        print_warning "ip6tables not found, IPv6 rules will be skipped"
    fi

    # Check if IPv6 is supported and configured on the system
    if [ -f /proc/net/if_inet6 ]; then
        print_status "IPv6 kernel support detected (/proc/net/if_inet6 exists)"
        # Check if IPv6 addresses are actually configured (with timeout to prevent hanging)
        local ipv6_addrs
        if command -v timeout &> /dev/null; then
            ipv6_addrs=$(timeout 2 ip -6 addr show 2>/dev/null | grep -E "inet6 [0-9a-fA-F:]+" | grep -v "::1" | grep -v "fe80:" | head -3 || true)
        else
            ipv6_addrs=$(ip -6 addr show 2>/dev/null | grep -E "inet6 [0-9a-fA-F:]+" | grep -v "::1" | grep -v "fe80:" | head -3 || true)
        fi
        if [ -n "$ipv6_addrs" ]; then
            local addr_count
            addr_count=$(echo "$ipv6_addrs" | wc -l)
            print_status "IPv6 addresses configured: $addr_count (excluding loopback and link-local)"
        else
            print_warning "IPv6 kernel support available but no IPv6 addresses configured"
        fi
    else
        print_warning "IPv6 not supported on this system (/proc/net/if_inet6 not found)"
    fi
}

# Function to install dependencies
install_dependencies() {
    local tools=("$@")
    print_status "Installing dependencies: ${tools[*]}"

    # Safety check for PKG_MANAGER
    if [[ -z "$PKG_MANAGER" ]]; then
        print_error "Package manager not detected. Make sure detect_os() is called first."
        exit 1
    fi

    case $PKG_MANAGER in
        dnf|yum)
            # For RHEL-based systems
            local packages_to_install=()

            # Always install gcc-c++ for building picoquic (CMake requires C++ compiler)
            if ! command -v g++ &> /dev/null; then
                packages_to_install+=("gcc-c++")
            fi

            for tool in "${tools[@]}"; do
                case $tool in
                    "rustc"|"cargo")
                        # Rust toolchain - install via rustup if not available
                        if ! command -v rustc &> /dev/null; then
                            print_status "Installing Rust toolchain via rustup..."
                            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
                            source "$HOME/.cargo/env" || source /root/.cargo/env
                        fi
                        ;;
                    "iptables")
                        packages_to_install+=("iptables" "iptables-services")
                        ;;
                    "openssl-dev")
                        packages_to_install+=("openssl-devel")
                        ;;
                    "cmake")
                        packages_to_install+=("cmake")
                        ;;
                    "pkg-config")
                        packages_to_install+=("pkgconfig")
                        ;;
                    *)
                        packages_to_install+=("$tool")
                        ;;
                esac
            done

            if [ ${#packages_to_install[@]} -gt 0 ]; then
                if ! $PKG_MANAGER install -y "${packages_to_install[@]}"; then
                    print_error "Failed to install packages: ${packages_to_install[*]}"
                    exit 1
                fi
            fi
            ;;
        apt)
            # For Debian-based systems
            if ! apt update; then
                print_error "Failed to update package lists"
                exit 1
            fi

            local packages_to_install=()

            # Always install g++ for building picoquic (CMake requires C++ compiler)
            if ! command -v g++ &> /dev/null; then
                packages_to_install+=("g++")
            fi

            for tool in "${tools[@]}"; do
                case $tool in
                    "rustc"|"cargo")
                        # Rust toolchain - install via rustup if not available
                        if ! command -v rustc &> /dev/null; then
                            print_status "Installing Rust toolchain via rustup..."
                            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
                            source "$HOME/.cargo/env" || source /root/.cargo/env
                        fi
                        ;;
                    "iptables")
                        packages_to_install+=("iptables" "iptables-persistent")
                        ;;
                    "openssl-dev")
                        packages_to_install+=("libssl-dev")
                        ;;
                    "cmake")
                        packages_to_install+=("cmake")
                        ;;
                    "pkg-config")
                        packages_to_install+=("pkg-config")
                        ;;
                    *)
                        packages_to_install+=("$tool")
                        ;;
                esac
            done

            if [ ${#packages_to_install[@]} -gt 0 ]; then
                if ! apt install -y "${packages_to_install[@]}"; then
                    print_error "Failed to install packages: ${packages_to_install[*]}"
                    exit 1
                fi
            fi
            ;;
        *)
            print_error "Unsupported package manager: $PKG_MANAGER"
            exit 1
            ;;
    esac

    print_status "Dependencies installed successfully"
}

# Function to get user input
get_user_input() {
    local existing_domain=""
    local existing_mode=""
    local existing_ss_port=""
    local existing_ss_method=""
    local existing_ss_password=""
    local existing_auth=""
    local existing_username=""

    if load_existing_config; then
        existing_domain="$DOMAIN"
        existing_mode="$TUNNEL_MODE"
        # Save Shadowsocks config if it exists
        existing_ss_port="${SHADOWSOCKS_PORT:-}"
        existing_ss_method="${SHADOWSOCKS_METHOD:-}"
        existing_ss_password="${SHADOWSOCKS_PASSWORD:-}"
        # Save SOCKS config if it exists
        existing_auth="${SOCKS_AUTH_ENABLED:-}"
        existing_username="${SOCKS_USERNAME:-}"
        print_status "Found existing configuration for domain: $existing_domain"
        # Clear TUNNEL_MODE so user's selection isn't overwritten
        unset TUNNEL_MODE
    fi
    
    local active_mode
    active_mode=$(detect_active_mode)
    if [[ -n "$active_mode" ]]; then
        existing_mode="$active_mode"
        print_status "Detected active tunnel mode: $active_mode"
    fi

    # Get domain
    while true; do
        if [[ -n "$existing_domain" ]]; then
            print_question "Enter the domain (current: $existing_domain): "
        else
            print_question "Enter the domain (e.g., example.com): "
        fi
        read -r DOMAIN

        # Use existing domain if user just presses enter
        if [[ -z "$DOMAIN" && -n "$existing_domain" ]]; then
            DOMAIN="$existing_domain"
        fi

        if [[ -n "$DOMAIN" ]]; then
            break
        else
            print_error "Please enter a valid domain"
        fi
    done

    # Get tunnel mode
    while true; do
        echo "Select tunnel mode:"
        echo "1) SOCKS proxy (Dante)"
        echo "2) SSH mode"
        echo "3) Shadowsocks"
        if [[ -n "$existing_mode" ]]; then
            local mode_number
            case "$existing_mode" in
                socks) mode_number="1" ;;
                ssh) mode_number="2" ;;
                shadowsocks) mode_number="3" ;;
                *) mode_number="?" ;;
            esac
            print_question "Enter choice (current: $mode_number - $existing_mode): "
        else
            print_question "Enter choice (1, 2, or 3): "
        fi
        read -r TUNNEL_MODE

        # Use existing mode if user just presses enter
        if [[ -z "$TUNNEL_MODE" && -n "$existing_mode" ]]; then
            TUNNEL_MODE="$existing_mode"
            break
        fi

        case $TUNNEL_MODE in
            1)
                TUNNEL_MODE="socks"
                break
                ;;
            2)
                TUNNEL_MODE="ssh"
                break
                ;;
            3)
                TUNNEL_MODE="shadowsocks"
                break
                ;;
            *)
                print_error "Invalid choice. Please enter 1, 2, or 3"
                ;;
        esac
    done

    # Capture selected mode so it is not overwritten by any config reload; use this for all mode-specific prompts
    local selected_tunnel_mode="$TUNNEL_MODE"

    SOCKS_AUTH_ENABLED="no"
    SOCKS_USERNAME=""
    SOCKS_PASSWORD=""
    
    if [ "$selected_tunnel_mode" = "socks" ]; then
        # Use saved SOCKS config from initial load (no need to reload)
        
        while true; do
            if [[ -n "${existing_auth:-}" ]]; then
                local auth_status="disabled"
                if [[ "$existing_auth" == "yes" ]]; then
                    auth_status="enabled"
                fi
                print_question "Enable username/password authentication for SOCKS proxy? (current: $auth_status) [y/N]: "
            else
                print_question "Enable username/password authentication for SOCKS proxy? [y/N]: "
            fi
            read -r enable_auth
            
            if [[ -z "$enable_auth" && -n "${existing_auth:-}" ]]; then
                SOCKS_AUTH_ENABLED="$existing_auth"
                if [[ "$existing_auth" == "yes" ]]; then
                    SOCKS_USERNAME="$existing_username"
                fi
                break
            fi
            
            case $enable_auth in
                [Yy]|[Yy][Ee][Ss])
                    SOCKS_AUTH_ENABLED="yes"
                    
                    while true; do
                        if [[ -n "${existing_username:-}" && "$SOCKS_AUTH_ENABLED" == "yes" ]]; then
                            print_question "Enter SOCKS username (current: $existing_username): "
                        else
                            print_question "Enter SOCKS username: "
                        fi
                        read -r SOCKS_USERNAME
                        
                        if [[ -z "$SOCKS_USERNAME" && -n "${existing_username:-}" ]]; then
                            SOCKS_USERNAME="$existing_username"
                        fi
                        
                        if [[ -n "$SOCKS_USERNAME" ]]; then
                            break
                        else
                            print_error "Please enter a valid username"
                        fi
                    done
                    
                    while true; do
                        print_question "Enter SOCKS password: "
                        read -rs SOCKS_PASSWORD
                        echo ""  # New line after hidden password input
                        
                        if [[ -z "$SOCKS_PASSWORD" ]]; then
                            print_error "Please enter a valid password"
                        else
                            print_question "Confirm SOCKS password: "
                            read -rs SOCKS_PASSWORD_CONFIRM
                            echo ""  # New line after hidden password input
                            
                            if [[ "$SOCKS_PASSWORD" != "$SOCKS_PASSWORD_CONFIRM" ]]; then
                                print_error "Passwords do not match. Please try again."
                                SOCKS_PASSWORD=""
                            else
                                break
                            fi
                        fi
                    done
                    break
                    ;;
                [Nn]|[Nn][Oo]|"")
                    SOCKS_AUTH_ENABLED="no"
                    break
                    ;;
                *)
                    print_error "Invalid choice. Please enter y or n"
                    ;;
            esac
        done
    fi

    # Shadowsocks configuration
    SHADOWSOCKS_PORT="8388"
    SHADOWSOCKS_PASSWORD=""
    SHADOWSOCKS_METHOD="aes-256-gcm"

    if [ "$selected_tunnel_mode" = "shadowsocks" ]; then
        # Use saved Shadowsocks config from initial load (no need to reload)
        # Variables are already saved as existing_ss_port, existing_ss_method, existing_ss_password

        # Get Shadowsocks port
        while true; do
            if [[ -n "${existing_ss_port:-}" ]]; then
                print_question "Enter Shadowsocks local port (current: $existing_ss_port): "
            else
                print_question "Enter Shadowsocks local port (default: 8388): "
            fi
            read -r input_port

            if [[ -z "$input_port" ]]; then
                if [[ -n "${existing_ss_port:-}" ]]; then
                    SHADOWSOCKS_PORT="$existing_ss_port"
                else
                    SHADOWSOCKS_PORT="8388"
                fi
                break
            elif [[ "$input_port" =~ ^[0-9]+$ ]] && [ "$input_port" -ge 1 ] && [ "$input_port" -le 65535 ]; then
                SHADOWSOCKS_PORT="$input_port"
                break
            else
                print_error "Please enter a valid port number (1-65535)"
            fi
        done

        # Get Shadowsocks password
        while true; do
            print_question "Enter Shadowsocks password: "
            read -rs SHADOWSOCKS_PASSWORD
            echo ""

            if [[ -z "$SHADOWSOCKS_PASSWORD" ]]; then
                print_error "Please enter a valid password"
            else
                print_question "Confirm Shadowsocks password: "
                read -rs SHADOWSOCKS_PASSWORD_CONFIRM
                echo ""

                if [[ "$SHADOWSOCKS_PASSWORD" != "$SHADOWSOCKS_PASSWORD_CONFIRM" ]]; then
                    print_error "Passwords do not match. Please try again."
                    SHADOWSOCKS_PASSWORD=""
                else
                    break
                fi
            fi
        done

        # Get encryption method
        echo "Select encryption method:"
        echo "1) aes-256-gcm (recommended)"
        echo "2) aes-128-gcm"
        echo "3) chacha20-ietf-poly1305"
        echo "4) aes-256-cfb"
        echo "5) aes-128-cfb"
        while true; do
            if [[ -n "${existing_ss_method:-}" ]]; then
                print_question "Enter choice (current: $existing_ss_method): "
            else
                print_question "Enter choice (default: 1): "
            fi
            read -r method_choice

            if [[ -z "$method_choice" ]]; then
                if [[ -n "${existing_ss_method:-}" ]]; then
                    SHADOWSOCKS_METHOD="$existing_ss_method"
                else
                    SHADOWSOCKS_METHOD="aes-256-gcm"
                fi
                break
            fi

            case $method_choice in
                1) SHADOWSOCKS_METHOD="aes-256-gcm"; break ;;
                2) SHADOWSOCKS_METHOD="aes-128-gcm"; break ;;
                3) SHADOWSOCKS_METHOD="chacha20-ietf-poly1305"; break ;;
                4) SHADOWSOCKS_METHOD="aes-256-cfb"; break ;;
                5) SHADOWSOCKS_METHOD="aes-128-cfb"; break ;;
                *) print_error "Invalid choice. Please enter 1-5" ;;
            esac
        done
    fi

    # Ensure TUNNEL_MODE is set from user's selection for save_config and rest of script
    TUNNEL_MODE="$selected_tunnel_mode"

    print_status "Configuration:"
    print_status "  Domain: $DOMAIN"
    print_status "  Tunnel mode: $TUNNEL_MODE"
    if [ "$TUNNEL_MODE" = "socks" ]; then
        if [ "$SOCKS_AUTH_ENABLED" = "yes" ]; then
            print_status "  SOCKS authentication: enabled (username: $SOCKS_USERNAME)"
        else
            print_status "  SOCKS authentication: disabled"
        fi
    fi
    if [ "$TUNNEL_MODE" = "shadowsocks" ]; then
        print_status "  Shadowsocks port: $SHADOWSOCKS_PORT"
        print_status "  Shadowsocks method: $SHADOWSOCKS_METHOD"
    fi
}

# Function to detect architecture and get asset name
get_asset_name() {
    local arch
    arch=$(uname -m)
    local os
    os=$(uname -s | tr '[:upper:]' '[:lower:]')

    case "$os" in
        linux)
            case "$arch" in
                x86_64|amd64)
                    echo "linux-amd64"
                    return 0
                    ;;
                arm64|aarch64)
                    echo "linux-arm64"
                    return 0
                    ;;
                armv7l|armhf)
                    echo "linux-armv7"
                    return 0
                    ;;
                riscv64)
                    echo "linux-riscv64"
                    return 0
                    ;;
                mips64)
                    echo "linux-mips64"
                    return 0
                    ;;
                mips64el)
                    echo "linux-mips64le"
                    return 0
                    ;;
                mips)
                    echo "linux-mips"
                    return 0
                    ;;
                mipsel)
                    echo "linux-mipsle"
                    return 0
                    ;;
                *)
                    return 1
                    ;;
            esac
            ;;
        darwin)
            case "$arch" in
                arm64|aarch64)
                    echo "darwin-arm64"
                    return 0
                    ;;
                *)
                    return 1
                    ;;
            esac
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to download prebuilt binary
download_prebuilt_binary() {
    # Check if 'file' utility is available, install if missing
	if ! command -v file >/dev/null 2>&1; then
	    print_status "'file' utility not found. Installing..."
	
	    case "$PKG_MANAGER" in
	        apt)
	            sudo apt update && sudo apt install -y file
	            ;;
	        dnf|yum)
	            sudo "$PKG_MANAGER" install -y file
	            ;;
	        *)
	            print_error "Unsupported package manager. Please install 'file' manually."
	            exit 1
	            ;;
	    esac
	fi
    
    local asset_name
    if ! asset_name=$(get_asset_name); then
        print_warning "No prebuilt binary available for this architecture"
        return 1
    fi

    print_status "Attempting to download prebuilt binary for $asset_name..."

    local binary_name="slipstream-server-${asset_name}"
    local temp_binary="/tmp/${binary_name}"
    local download_url=""
    local latest_tag=""

    print_status "Fetching latest release information..."
    local api_response
    api_response=$(curl -fsSL "https://api.github.com/repos/AliRezaBeigy/slipstream-rust-deploy/releases/latest" 2>/dev/null)
    
    if [ -n "$api_response" ]; then
        latest_tag=$(echo "$api_response" | grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4)
        if [ -n "$latest_tag" ]; then
            print_status "Found latest release tag: $latest_tag"
            download_url="https://github.com/AliRezaBeigy/slipstream-rust-deploy/releases/download/${latest_tag}/${binary_name}"
        fi
    fi

    if [ -z "$download_url" ]; then
        print_warning "Could not fetch release tag from API, trying /latest/download endpoint..."
        download_url="${RELEASE_URL}/${binary_name}"
    fi
    print_status "Downloading prebuilt slipstream-server binary from: $download_url"

    # Download the binary
    if curl -fsSL "$download_url" -o "$temp_binary" 2>/dev/null; then
        # Verify the download is a valid binary (not HTML error page)
        if file "$temp_binary" | grep -qE "(executable|ELF|Mach-O)"; then
            chmod +x "$temp_binary"
            cp "$temp_binary" "$INSTALL_DIR/slipstream-server"
            rm "$temp_binary"
            print_status "Successfully downloaded prebuilt slipstream-server binary"
            return 0
        else
            print_warning "Downloaded file is not a valid binary"
            rm -f "$temp_binary"
            return 1
        fi
    else
        print_warning "Failed to download prebuilt binary from release"
        return 1
    fi
}

# Function to build slipstream-rust from source
build_slipstream_rust() {
    print_status "Building slipstream-rust from source..."

    # Ensure cargo is in PATH
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    elif [ -f "/root/.cargo/env" ]; then
        source "/root/.cargo/env"
    fi

    # Check if cargo is available
    if ! command -v cargo &> /dev/null; then
        print_error "cargo is not available. Please install Rust toolchain first."
        exit 1
    fi

    # Create build directory
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR"

    # Clone or update repository
    if [ -d "$BUILD_DIR/.git" ]; then
        print_status "Repository already exists, updating..."
        cd "$BUILD_DIR"
        git pull || print_warning "Failed to update repository, continuing with existing code..."
    else
        print_status "Cloning slipstream-rust repository..."
        if ! git clone "$REPO_URL" "$BUILD_DIR"; then
            print_error "Failed to clone repository"
            exit 1
        fi
    fi

    # Initialize and update submodules
    print_status "Initializing submodules..."
    cd "$BUILD_DIR"
    git submodule update --init --recursive

    # Build picoquic if needed
    print_status "Building picoquic dependencies..."
    if [ -f "$BUILD_DIR/scripts/build_picoquic.sh" ]; then
        bash "$BUILD_DIR/scripts/build_picoquic.sh"
    fi

    # Build slipstream-server
    print_status "Building slipstream-server (this may take several minutes)..."
    if ! cargo build --release -p slipstream-server; then
        print_error "Failed to build slipstream-server"
        exit 1
    fi

    # Copy binary to install directory
    if [ -f "$BUILD_DIR/target/release/slipstream-server" ]; then
        cp "$BUILD_DIR/target/release/slipstream-server" "$INSTALL_DIR/slipstream-server"
        chmod +x "$INSTALL_DIR/slipstream-server"
        print_status "slipstream-server built and installed successfully"
    else
        print_error "Built binary not found at expected location"
        exit 1
    fi
}

# Function to install slipstream-server (prebuilt or from source)
install_slipstream_server() {
    print_status "Installing slipstream-server..."

    # Stop the service if it's running to avoid "Text file busy" error when copying
    if systemctl is-active --quiet slipstream-rust-server 2>/dev/null; then
        print_status "Stopping existing slipstream-rust-server service for update..."
        systemctl stop slipstream-rust-server
    fi

    # First, try to download prebuilt binary
    if download_prebuilt_binary; then
        print_status "Using prebuilt binary - skipping build dependencies"
        return 0
    fi

    # Fall back to building from source
    print_status "Prebuilt binary not available, will build from source..."

    # Check and install required tools for building
    check_required_tools

    # Build from source
    build_slipstream_rust
}

# Function to create slipstream user
create_slipstream_user() {
    print_status "Creating slipstream user..."

    if ! id "$SLIPSTREAM_USER" &>/dev/null; then
        useradd -r -s /bin/false -d /nonexistent -c "slipstream service user" "$SLIPSTREAM_USER"
        print_status "Created user: $SLIPSTREAM_USER"
    else
        print_status "User $SLIPSTREAM_USER already exists"
    fi

    # Create config directory first
    mkdir -p "$CONFIG_DIR"

    # Set ownership of config directory
    chown -R "$SLIPSTREAM_USER":"$SLIPSTREAM_USER" "$CONFIG_DIR"
    chmod 750 "$CONFIG_DIR"
}

# Function to generate TLS certificates
generate_certificates() {
    # Generate certificate file names based on domain
    local cert_prefix
    # shellcheck disable=SC2001
    cert_prefix=$(echo "$DOMAIN" | sed 's/\./_/g')
    CERT_FILE="${CONFIG_DIR}/${cert_prefix}_cert.pem"
    KEY_FILE="${CONFIG_DIR}/${cert_prefix}_key.pem"

    # Check if certificates already exist for this domain
    if [[ -f "$CERT_FILE" && -f "$KEY_FILE" ]]; then
        print_status "Found existing certificates for domain: $DOMAIN"
        print_status "  Certificate: $CERT_FILE"
        print_status "  Key: $KEY_FILE"

        # Verify certificate ownership and permissions
        chown "$SLIPSTREAM_USER":"$SLIPSTREAM_USER" "$CERT_FILE" "$KEY_FILE"
        chmod 644 "$CERT_FILE"
        chmod 600 "$KEY_FILE"

        print_status "Using existing certificates (verified ownership and permissions)"
    else
        print_status "Generating new TLS certificates for domain: $DOMAIN"

        # Generate certificates (run as root, then change ownership)
        openssl req -x509 -newkey rsa:2048 -nodes \
            -keyout "$KEY_FILE" \
            -out "$CERT_FILE" \
            -days 365 \
            -subj "/CN=slipstream"

        # Set proper ownership and permissions
        chown "$SLIPSTREAM_USER":"$SLIPSTREAM_USER" "$CERT_FILE" "$KEY_FILE"
        chmod 644 "$CERT_FILE"
        chmod 600 "$KEY_FILE"

        print_status "New certificates generated:"
        print_status "  Certificate: $CERT_FILE"
        print_status "  Key: $KEY_FILE"
    fi
}

# Function to configure iptables rules
configure_iptables() {
    print_status "Configuring iptables rules for DNS redirection..."

    # Verify iptables is available
    if ! command -v iptables &> /dev/null; then
        print_error "iptables command not found. Cannot configure firewall rules."
        exit 1
    fi

    # Get the primary network interface
    local interface
    interface=$(ip route | grep default | awk '{print $5}' | head -1)
    if [[ -z "$interface" ]]; then
        # Try alternative method to get interface
        interface=$(ip link show | grep -E "^[0-9]+: (eth|ens|enp)" | head -1 | cut -d':' -f2 | awk '{print $1}')
        if [[ -z "$interface" ]]; then
            interface="eth0"  # fallback
            print_warning "Could not detect network interface, using eth0 as fallback"
        else
            print_status "Detected network interface: $interface"
        fi
    else
        print_status "Using network interface: $interface"
    fi

    # IPv4 rules
    print_status "Setting up IPv4 iptables rules..."

    if ! iptables -I INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT; then
        print_error "Failed to add IPv4 INPUT rule"
        exit 1
    fi

    if ! iptables -t nat -I PREROUTING -i "$interface" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT"; then
        print_error "Failed to add IPv4 NAT rule"
        exit 1
    fi

    print_status "IPv4 iptables rules configured successfully"

    # IPv6 rules (if IPv6 and ip6tables are available)
    if command -v ip6tables &> /dev/null && [ -f /proc/net/if_inet6 ]; then
        # Check if IPv6 addresses are actually configured (with timeout to prevent hanging)
        local ipv6_addrs
        if command -v timeout &> /dev/null; then
            ipv6_addrs=$(timeout 2 ip -6 addr show 2>/dev/null | grep -E "inet6 [0-9a-fA-F:]+" | grep -v "::1" | grep -v "fe80:" || true)
        else
            ipv6_addrs=$(ip -6 addr show 2>/dev/null | grep -E "inet6 [0-9a-fA-F:]+" | grep -v "::1" | grep -v "fe80:" || true)
        fi
        
        if [ -n "$ipv6_addrs" ]; then
            local addr_count
            addr_count=$(echo "$ipv6_addrs" | wc -l)
            print_status "Setting up IPv6 iptables rules (IPv6 addresses configured: $addr_count)..."

            if ip6tables -I INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT 2>/dev/null; then
                print_status "IPv6 INPUT rule added successfully"
            else
                print_warning "Failed to add IPv6 INPUT rule (IPv6 might not be fully configured)"
            fi

            if ip6tables -t nat -I PREROUTING -i "$interface" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT" 2>/dev/null; then
                print_status "IPv6 NAT rule added successfully"
            else
                print_warning "Failed to add IPv6 NAT rule (IPv6 NAT might not be supported)"
            fi
        else
            print_warning "IPv6 kernel support available but no IPv6 addresses configured, skipping IPv6 iptables rules"
        fi
    else
        if ! command -v ip6tables &> /dev/null; then
            print_warning "ip6tables not available, skipping IPv6 rules"
        elif [ ! -f /proc/net/if_inet6 ]; then
            print_warning "IPv6 not enabled on system, skipping IPv6 rules"
        fi
    fi

    # Save iptables rules based on distribution
    save_iptables_rules
}

# Function to ensure iptables persistence packages are installed
ensure_iptables_persistence() {
    print_status "Ensuring iptables persistence packages are installed..."

    case $PKG_MANAGER in
        dnf|yum)
            # For RHEL-based systems, install iptables-services if not already installed
            if ! rpm -q iptables-services &>/dev/null; then
                print_status "Installing iptables-services package..."
                if $PKG_MANAGER install -y iptables-services 2>/dev/null; then
                    print_status "iptables-services installed successfully"
                else
                    print_warning "Failed to install iptables-services, will use fallback method"
                fi
            fi
            ;;
        apt)
            # For Debian-based systems, install iptables-persistent if not already installed
            if ! dpkg -l | grep -q "^ii.*iptables-persistent"; then
                print_status "Installing iptables-persistent package..."
                # Use debconf-set-selections to avoid interactive prompts
                echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections 2>/dev/null || true
                echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections 2>/dev/null || true
                if apt install -y iptables-persistent 2>/dev/null; then
                    print_status "iptables-persistent installed successfully"
                else
                    print_warning "Failed to install iptables-persistent, will use fallback method"
                fi
            fi
            ;;
    esac
}

# Function to create a systemd service to restore iptables rules at boot
create_iptables_restore_service() {
    print_status "Creating iptables restore service as fallback..."

    local restore_script="/usr/local/bin/slipstream-restore-iptables.sh"
    local interface
    interface=$(ip route | grep default | awk '{print $5}' | head -1)
    if [[ -z "$interface" ]]; then
        interface=$(ip link show | grep -E "^[0-9]+: (eth|ens|enp)" | head -1 | cut -d':' -f2 | awk '{print $1}')
        if [[ -z "$interface" ]]; then
            interface="eth0"
        fi
    fi

    # Create restore script
    cat > "$restore_script" << 'RESTORE_SCRIPT_EOF'
#!/bin/bash
# slipstream-rust iptables rules restore script
# This script restores iptables rules after reboot

SLIPSTREAM_PORT="5301"
INTERFACE="__INTERFACE_PLACEHOLDER__"

# Wait for network to be ready
sleep 2

# Restore IPv4 rules
if command -v iptables &> /dev/null; then
    # Check if rules already exist to avoid duplicates
    if ! iptables -C INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT 2>/dev/null; then
        iptables -I INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT
    fi
    
    if ! iptables -t nat -C PREROUTING -i "$INTERFACE" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT" 2>/dev/null; then
        iptables -t nat -I PREROUTING -i "$INTERFACE" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT"
    fi
fi

# Restore IPv6 rules if available
if command -v ip6tables &> /dev/null && [ -f /proc/net/if_inet6 ]; then
    if ! ip6tables -C INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT 2>/dev/null; then
        ip6tables -I INPUT -p udp --dport "$SLIPSTREAM_PORT" -j ACCEPT 2>/dev/null || true
    fi
    
    if ! ip6tables -t nat -C PREROUTING -i "$INTERFACE" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT" 2>/dev/null; then
        ip6tables -t nat -I PREROUTING -i "$INTERFACE" -p udp --dport 53 -j REDIRECT --to-ports "$SLIPSTREAM_PORT" 2>/dev/null || true
    fi
fi
RESTORE_SCRIPT_EOF

    # Replace placeholder with actual interface
    sed -i "s/__INTERFACE_PLACEHOLDER__/$interface/g" "$restore_script"
    chmod +x "$restore_script"

    # Create systemd service
    cat > "${SYSTEMD_DIR}/slipstream-restore-iptables.service" << EOF
[Unit]
Description=Restore slipstream-rust iptables rules
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=$restore_script
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable slipstream-restore-iptables.service 2>/dev/null || print_warning "Could not enable iptables restore service"
    print_status "Created iptables restore service as fallback"
}

# Function to save iptables rules with better error handling
save_iptables_rules() {
    print_status "Saving iptables rules..."

    # Ensure persistence packages are installed
    ensure_iptables_persistence

    case $PKG_MANAGER in
        dnf|yum)
            # For RHEL-based systems
            if command -v iptables-save &> /dev/null; then
                # Create directory if it doesn't exist
                mkdir -p /etc/sysconfig

                if iptables-save > /etc/sysconfig/iptables; then
                    print_status "IPv4 iptables rules saved to /etc/sysconfig/iptables"
                else
                    print_warning "Failed to save IPv4 iptables rules"
                fi

                if command -v ip6tables-save &> /dev/null && [ -f /proc/net/if_inet6 ]; then
                    if ip6tables-save > /etc/sysconfig/ip6tables; then
                        print_status "IPv6 iptables rules saved to /etc/sysconfig/ip6tables"
                    else
                        print_warning "Failed to save IPv6 iptables rules"
                    fi
                fi

                # Enable and start iptables service if available
                if systemctl list-unit-files | grep -q iptables.service; then
                    systemctl enable iptables 2>/dev/null || print_warning "Could not enable iptables service"
                    systemctl start iptables 2>/dev/null || print_warning "Could not start iptables service"
                    if command -v ip6tables &> /dev/null && [ -f /proc/net/if_inet6 ]; then
                        systemctl enable ip6tables 2>/dev/null || print_warning "Could not enable ip6tables service"
                        systemctl start ip6tables 2>/dev/null || print_warning "Could not start ip6tables service"
                    fi
                fi
            else
                print_warning "iptables-save not available, rules will not persist after reboot"
            fi
            ;;
        apt)
            # For Debian-based systems
            if command -v iptables-save &> /dev/null; then
                # Create directory if it doesn't exist
                mkdir -p /etc/iptables

                if iptables-save > /etc/iptables/rules.v4; then
                    print_status "IPv4 iptables rules saved to /etc/iptables/rules.v4"
                else
                    print_warning "Failed to save IPv4 iptables rules"
                fi

                if command -v ip6tables-save &> /dev/null && [ -f /proc/net/if_inet6 ]; then
                    if ip6tables-save > /etc/iptables/rules.v6; then
                        print_status "IPv6 iptables rules saved to /etc/iptables/rules.v6"
                    else
                        print_warning "Failed to save IPv6 iptables rules"
                    fi
                fi

                # Try to enable netfilter-persistent if available
                if systemctl list-unit-files | grep -q netfilter-persistent.service; then
                    systemctl enable netfilter-persistent 2>/dev/null || print_warning "Could not enable netfilter-persistent service"
                    systemctl start netfilter-persistent 2>/dev/null || print_warning "Could not start netfilter-persistent service"
                fi
            else
                print_warning "iptables-save not available, rules will not persist after reboot"
            fi
            ;;
    esac

    # Create fallback restore service
    create_iptables_restore_service
}

# Function to configure firewall
configure_firewall() {
    print_status "Configuring firewall..."

    # Check if firewalld is available and active
    if command -v firewall-cmd &> /dev/null && systemctl is-active --quiet firewalld; then
        print_status "Configuring active firewalld..."
        firewall-cmd --permanent --add-port="$SLIPSTREAM_PORT"/udp
        firewall-cmd --permanent --add-port=53/udp
        firewall-cmd --reload
        print_status "Firewalld configured successfully"

    # Check if ufw is available and active
    elif command -v ufw &> /dev/null && ufw status | grep -q "Status: active"; then
        print_status "Configuring active ufw..."
        ufw allow "$SLIPSTREAM_PORT"/udp
        ufw allow 53/udp
        print_status "UFW configured successfully"

    else
        print_status "No active firewall service detected"
        print_status "Available firewall tools:"

        # List available but inactive firewall tools
        if command -v firewall-cmd &> /dev/null; then
            print_status "  - firewalld (inactive)"
        fi
        if command -v ufw &> /dev/null; then
            print_status "  - ufw (inactive)"
        fi

        print_status "Relying on iptables rules only"
        print_status "If you have a firewall active, manually allow ports $SLIPSTREAM_PORT/udp and 53/udp"
    fi

    # Configure iptables rules regardless of firewall service
    configure_iptables
}

# Function to detect SSH port
detect_ssh_port() {
    local ssh_port
    ssh_port=$(ss -tlnp | grep sshd | awk '{print $4}' | cut -d':' -f2 | head -1)
    if [[ -z "$ssh_port" ]]; then
        # Fallback to default SSH port
        ssh_port="22"
    fi
    echo "$ssh_port"
}

# Function to install and configure Dante SOCKS proxy
setup_dante() {
    print_status "Setting up Dante SOCKS proxy..."

    # Install Dante
    case $PKG_MANAGER in
        dnf|yum)
            $PKG_MANAGER install -y dante-server
            ;;
        apt)
            apt install -y dante-server
            ;;
    esac

    # Get the primary network interface for external interface
    local external_interface
    external_interface=$(ip route | grep default | awk '{print $5}' | head -1)
    if [[ -z "$external_interface" ]]; then
        external_interface="eth0"  # fallback
    fi

    local socks_method="none"
    
    if [[ "${SOCKS_AUTH_ENABLED:-no}" == "yes" && -n "${SOCKS_USERNAME:-}" && -n "${SOCKS_PASSWORD:-}" ]]; then
        socks_method="username"
        
        if ! id "$SOCKS_USERNAME" &>/dev/null; then
            print_status "Creating system user for SOCKS authentication: $SOCKS_USERNAME"
            useradd -r -s /bin/false -M "$SOCKS_USERNAME" 2>/dev/null || {
                print_error "Failed to create system user: $SOCKS_USERNAME"
                return 1
            }
            print_status "System user created: $SOCKS_USERNAME"
        else
            print_status "System user already exists: $SOCKS_USERNAME"
        fi
        
        print_status "Setting password for SOCKS user: $SOCKS_USERNAME"
        echo "$SOCKS_USERNAME:$SOCKS_PASSWORD" | chpasswd 2>/dev/null || {
            print_error "Failed to set password for user: $SOCKS_USERNAME"
            return 1
        }
        print_status "Password set successfully for SOCKS user"
    fi

    # Configure Dante
    cat > /etc/danted.conf << EOF
# Dante SOCKS server configuration
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# Internal interface (where clients connect)
internal: 127.0.0.1 port = 1080

# External interface (where connections go out)
external: $external_interface

# Authentication method
socksmethod: $socks_method
EOF

    cat >> /etc/danted.conf << EOF

# Compatibility settings
compatibility: sameport
extension: bind

# Client rules - allow connections from localhost
client pass {
    from: 127.0.0.0/8 to: 0.0.0.0/0
    log: error
}

# SOCKS rules - allow SOCKS requests to anywhere
socks pass {
    from: 127.0.0.0/8 to: 0.0.0.0/0
    command: bind connect udpassociate
EOF

    if [[ -n "$passwd_file" ]]; then
        cat >> /etc/danted.conf << EOF
    method: username
EOF
    fi

    cat >> /etc/danted.conf << EOF
    log: error
}

# Block IPv6 if not properly configured
socks block {
    from: 0.0.0.0/0 to: ::/0
    log: error
}

client block {
    from: 0.0.0.0/0 to: ::/0
    log: error
}
EOF

    # Enable and start Dante service
    systemctl enable danted
    systemctl restart danted

    print_status "Dante SOCKS proxy configured and started on port 1080"
    print_status "External interface: $external_interface"
    if [[ "$socks_method" == "username" ]]; then
        print_status "SOCKS authentication: enabled (username: $SOCKS_USERNAME)"
    else
        print_status "SOCKS authentication: disabled"
    fi
}

# Function to install and configure Shadowsocks
setup_shadowsocks() {
    print_status "Setting up Shadowsocks..."

    local shadowsocks_installed=false

    # First, try snap (recommended method)
    if command -v snap &> /dev/null; then
        print_status "Attempting to install shadowsocks-libev via snap..."
        if snap install shadowsocks-libev 2>/dev/null; then
            shadowsocks_installed=true
            print_status "Successfully installed shadowsocks-libev via snap"
        else
            print_warning "Failed to install shadowsocks-libev via snap, trying package manager..."
        fi
    else
        print_status "snap not available, trying package manager..."
    fi

    # If snap failed or not available, try package manager
    if [ "$shadowsocks_installed" = false ]; then
        case $PKG_MANAGER in
            dnf|yum)
                print_status "Attempting to install shadowsocks-libev via $PKG_MANAGER..."
                # Enable EPEL repository for shadowsocks-libev
                $PKG_MANAGER install -y epel-release 2>/dev/null || true
                if $PKG_MANAGER install -y shadowsocks-libev; then
                    shadowsocks_installed=true
                    print_status "Successfully installed shadowsocks-libev via $PKG_MANAGER"
                else
                    print_error "Failed to install shadowsocks-libev via $PKG_MANAGER"
                fi
                ;;
            apt)
                print_status "Attempting to install shadowsocks-libev via apt..."
                if apt update && apt install -y shadowsocks-libev; then
                    shadowsocks_installed=true
                    print_status "Successfully installed shadowsocks-libev via apt"
                else
                    print_error "Failed to install shadowsocks-libev via apt"
                fi
                ;;
            *)
                print_error "Unsupported package manager: $PKG_MANAGER"
                ;;
        esac
    fi

    # If installation failed, exit with error
    if [ "$shadowsocks_installed" = false ]; then
        print_error "Failed to install shadowsocks-libev via snap or package manager"
        print_error "Please install shadowsocks-libev manually and try again"
        exit 1
    fi

    # Determine config path: snap is confined and can only read from its common directory
    local shadowsocks_config_dir
    local shadowsocks_config_file
    if command -v snap &> /dev/null && snap list shadowsocks-libev &>/dev/null; then
        shadowsocks_config_dir="/var/snap/shadowsocks-libev/common/etc/shadowsocks-libev"
    else
        shadowsocks_config_dir="/etc/shadowsocks-libev"
    fi
    shadowsocks_config_file="${shadowsocks_config_dir}/config.json"

    # Create Shadowsocks configuration directory
    mkdir -p "$shadowsocks_config_dir"

    # Create Shadowsocks configuration file
    cat > "$shadowsocks_config_file" << EOF
{
    "server": "127.0.0.1",
    "server_port": ${SHADOWSOCKS_PORT},
    "password": "${SHADOWSOCKS_PASSWORD}",
    "timeout": 300,
    "method": "${SHADOWSOCKS_METHOD}",
    "fast_open": false,
    "mode": "tcp_only"
}
EOF

    # Set permissions to 644 so the DynamicUser in systemd can read it
    chmod 644 "$shadowsocks_config_file"
    chown root:root "$shadowsocks_config_file"

    # Create systemd service override if needed (for snap installations)
    local service_created=false
    if command -v snap &> /dev/null && snap list shadowsocks-libev &>/dev/null; then
        local snap_bin
        snap_bin=$(command -v snap)
        if [ -z "$snap_bin" ]; then
            snap_bin="/usr/bin/snap"
        fi
        
        # For snap installation: use config path inside snap's common dir (snap confinement)
        cat > /etc/systemd/system/shadowsocks-libev-server@config.service << EOF
[Unit]
Description=Shadowsocks-libev Server Service for %i
After=network.target

[Service]
Type=simple
ExecStart=${snap_bin} run shadowsocks-libev.ss-server -c ${shadowsocks_config_dir}/%i.json
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
        systemctl daemon-reload
        service_created=true
    fi

    # Enable and start Shadowsocks service
    if [ "$service_created" = true ] || [ -f /etc/systemd/system/shadowsocks-libev-server@config.service ]; then
        systemctl enable shadowsocks-libev-server@config
        systemctl restart shadowsocks-libev-server@config
        if ! systemctl is-active --quiet shadowsocks-libev-server@config; then
            print_error "Shadowsocks service failed to start"
            print_status "Check logs with: journalctl -u shadowsocks-libev-server@config -n 50"
            exit 1
        fi
    elif systemctl list-unit-files | grep -q "shadowsocks-libev-server@.service"; then
        systemctl enable shadowsocks-libev-server@config
        systemctl restart shadowsocks-libev-server@config
        if ! systemctl is-active --quiet shadowsocks-libev-server@config; then
            print_error "Shadowsocks service failed to start"
            print_status "Check logs with: journalctl -u shadowsocks-libev-server@config -n 50"
            exit 1
        fi
    elif systemctl list-unit-files | grep -q "shadowsocks-libev.service"; then
        # Some distros use a different service name
        systemctl enable shadowsocks-libev
        systemctl restart shadowsocks-libev
        if ! systemctl is-active --quiet shadowsocks-libev; then
            print_error "Shadowsocks service failed to start"
            print_status "Check logs with: journalctl -u shadowsocks-libev -n 50"
            exit 1
        fi
    else
        print_error "Could not find Shadowsocks systemd service"
        exit 1
    fi

    print_status "Shadowsocks configured and started on port $SHADOWSOCKS_PORT"
    print_status "Encryption method: $SHADOWSOCKS_METHOD"
}

# Function to create systemd service
create_systemd_service() {
    print_status "Creating systemd service..."

    local service_name="slipstream-rust-server"
    local service_file="${SYSTEMD_DIR}/${service_name}.service"
    local target_port

    case "$TUNNEL_MODE" in
        ssh)
            target_port=$(detect_ssh_port)
            print_status "Detected SSH port: $target_port"
            ;;
        shadowsocks)
            target_port="${SHADOWSOCKS_PORT:-8388}"
            print_status "Using Shadowsocks port: $target_port"
            ;;
        socks|*)
            target_port="1080"  # Dante SOCKS port
            ;;
    esac

    # Stop service if it's running to allow reconfiguration
    if systemctl is-active --quiet "$service_name"; then
        print_status "Stopping existing slipstream-rust-server service for reconfiguration..."
        systemctl stop "$service_name"
    fi

    local dns_listen_host="0.0.0.0"
    local ipv6_support=false
    local ipv6_configured=false
    local ipv6_info=""
    
    # Check IPv6 support
    if command -v ip6tables &> /dev/null; then
        ipv6_support=true
        ipv6_info="ip6tables: available"
    else
        ipv6_info="ip6tables: not available"
    fi
    
    if [ -f /proc/net/if_inet6 ]; then
        if [ "$ipv6_support" = true ]; then
            ipv6_info="$ipv6_info, /proc/net/if_inet6: exists"
        else
            ipv6_info="$ipv6_info, /proc/net/if_inet6: exists"
        fi
    else
        ipv6_info="$ipv6_info, /proc/net/if_inet6: not found"
    fi
    
    # Check if IPv6 addresses are actually configured (with timeout to prevent hanging)
    if [ "$ipv6_support" = true ] && [ -f /proc/net/if_inet6 ]; then
        local ipv6_addrs
        if command -v timeout &> /dev/null; then
            ipv6_addrs=$(timeout 2 ip -6 addr show 2>/dev/null | grep -E "inet6 [0-9a-fA-F:]+" | grep -v "::1" | grep -v "fe80:" | head -3 || true)
        else
            ipv6_addrs=$(ip -6 addr show 2>/dev/null | grep -E "inet6 [0-9a-fA-F:]+" | grep -v "::1" | grep -v "fe80:" | head -3 || true)
        fi
        if [ -n "$ipv6_addrs" ]; then
            ipv6_configured=true
            local addr_count
            addr_count=$(echo "$ipv6_addrs" | wc -l)
            ipv6_info="$ipv6_info, IPv6 addresses: $addr_count configured"
            print_status "IPv6 detection details:"
            print_status "  $ipv6_info"
            echo "$ipv6_addrs" | while read -r line; do
                print_status "    - $line"
            done
            dns_listen_host="::"
            print_status "IPv6 detected and configured, using :: for dual-stack support"
        else
            ipv6_info="$ipv6_info, IPv6 addresses: none configured"
            print_status "IPv6 detection details:"
            print_status "  $ipv6_info"
            print_status "IPv6 support available but no addresses configured, using 0.0.0.0 for IPv4 only"
        fi
    else
        print_status "IPv6 detection details:"
        print_status "  $ipv6_info"
        print_status "IPv6 not available, using 0.0.0.0 for IPv4 only"
    fi

    # Create systemd service file
    cat > "$service_file" << EOF
[Unit]
Description=slipstream-rust DNS Tunnel Server
After=network.target
Wants=network.target

[Service]
Type=simple
User=$SLIPSTREAM_USER
Group=$SLIPSTREAM_USER
ExecStart=${INSTALL_DIR}/slipstream-server --dns-listen-host ${dns_listen_host} --dns-listen-port ${SLIPSTREAM_PORT} --target-address 127.0.0.1:${target_port} --domain ${DOMAIN} --cert ${CERT_FILE} --key ${KEY_FILE}
Restart=always
RestartSec=5
KillMode=mixed
TimeoutStopSec=5
# Restart service every 60 minutes to work around server memory/state bugs
RuntimeMaxSec=3600

# Security settings
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true
ReadOnlyPaths=/
ReadWritePaths=${CONFIG_DIR}
PrivateTmp=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd and enable service
    systemctl daemon-reload
    systemctl enable "$service_name"

    print_status "Systemd service created: $service_name"
    print_status "Service will run as user: $SLIPSTREAM_USER"
    print_status "Service will listen on port: $SLIPSTREAM_PORT (redirected from port 53)"
    print_status "Service will tunnel to 127.0.0.1:$target_port"
    print_status "Mode: $TUNNEL_MODE"
}

# Function to start services
start_services() {
    print_status "Starting services..."

    # Start slipstream-rust-server service
    systemctl start slipstream-rust-server

    print_status "slipstream-rust-server service started"

    # Show service status
    systemctl status slipstream-rust-server --no-pager -l
}

# Function to print success box without [INFO] prefix
print_success_box() {
    local border_color='\033[1;32m'  # Bright green
    local text_color='\033[1;37m'    # Bright white text
    local key_color='\033[1;33m'     # Yellow for key
    local header_color='\033[1;36m'  # Cyan for headers
    local reset='\033[0m'

    echo ""
    # Top border
    echo -e "${border_color}+================================================================================${reset}"
    echo -e "${border_color}|                          SETUP COMPLETED SUCCESSFULLY!                       |${reset}"
    echo -e "${border_color}+================================================================================${reset}"
    echo ""

    # Configuration Details
    echo -e "${header_color}Configuration Details:${reset}"
    echo -e "  ${text_color}Domain: $DOMAIN${reset}"
    echo -e "  ${text_color}Tunnel mode: $TUNNEL_MODE${reset}"
    echo -e "  ${text_color}Service user: $SLIPSTREAM_USER${reset}"
    echo -e "  ${text_color}Listen port: $SLIPSTREAM_PORT (DNS traffic redirected from port 53)${reset}"
    echo ""

    # Script Location
    echo -e "${text_color}Script installed at: $SCRIPT_INSTALL_PATH${reset}"
    echo ""

    # Management Commands
    echo -e "${header_color}Management Commands:${reset}"
    echo -e "  ${text_color}Run menu:           slipstream-rust-deploy${reset}"
    echo -e "  ${text_color}Start service:      systemctl start slipstream-rust-server${reset}"
    echo -e "  ${text_color}Stop service:       systemctl stop slipstream-rust-server${reset}"
    echo -e "  ${text_color}Service status:     systemctl status slipstream-rust-server${reset}"
    echo -e "  ${text_color}View logs:          journalctl -u slipstream-rust-server -f${reset}"

    # SOCKS info if applicable
    if [ "$TUNNEL_MODE" = "socks" ]; then
        echo ""
        echo -e "${header_color}SOCKS Proxy Information:${reset}"
        echo -e "${text_color}SOCKS proxy is running on 127.0.0.1:1080${reset}"
        if [[ "${SOCKS_AUTH_ENABLED:-no}" == "yes" && -n "${SOCKS_USERNAME:-}" ]]; then
            echo -e "${text_color}Authentication: ${key_color}Enabled${reset} (username: ${key_color}$SOCKS_USERNAME${reset})"
        else
            echo -e "${text_color}Authentication: ${key_color}Disabled${reset}"
        fi
        echo -e "${text_color}Dante service commands:${reset}"
        echo -e "  ${text_color}Status:  systemctl status danted${reset}"
        echo -e "  ${text_color}Stop:    systemctl stop danted${reset}"
        echo -e "  ${text_color}Start:   systemctl start danted${reset}"
        echo -e "  ${text_color}Logs:    journalctl -u danted -f${reset}"
    fi

    # Shadowsocks info if applicable
    if [ "$TUNNEL_MODE" = "shadowsocks" ]; then
        echo ""
        echo -e "${header_color}Shadowsocks Information:${reset}"
        echo -e "${text_color}Shadowsocks server is running on 127.0.0.1:${SHADOWSOCKS_PORT:-8388}${reset}"
        echo -e "${text_color}Encryption method: ${key_color}${SHADOWSOCKS_METHOD:-aes-256-gcm}${reset}"
        echo -e "${text_color}Shadowsocks service commands:${reset}"
        echo -e "  ${text_color}Status:  systemctl status shadowsocks-libev-server@config${reset}"
        echo -e "  ${text_color}Stop:    systemctl stop shadowsocks-libev-server@config${reset}"
        echo -e "  ${text_color}Start:   systemctl start shadowsocks-libev-server@config${reset}"
        echo -e "  ${text_color}Logs:    journalctl -u shadowsocks-libev-server@config -f${reset}"
    fi

    # Bottom border
    echo ""
    echo -e "${border_color}+================================================================================${reset}"
    echo ""
}

# Function to display final information
display_final_info() {
    print_success_box
}

# Function to detect dnstt installation
detect_dnstt() {
    local dnstt_detected=false
    local detection_reasons=()

    # Check for dnstt-server binary
    if [ -f "/usr/local/bin/dnstt-server" ]; then
        dnstt_detected=true
        detection_reasons+=("dnstt-server binary found at /usr/local/bin/dnstt-server")
    fi

    # Check for dnstt-server systemd service
    if systemctl list-unit-files | grep -q "^dnstt-server.service"; then
        dnstt_detected=true
        detection_reasons+=("dnstt-server systemd service found")
    fi

    # Check for dnstt user
    if id "dnstt" &>/dev/null; then
        dnstt_detected=true
        detection_reasons+=("dnstt user found")
    fi

    # Check for dnstt config directory
    if [ -d "/etc/dnstt" ]; then
        dnstt_detected=true
        detection_reasons+=("dnstt config directory found at /etc/dnstt")
    fi

    # Check for dnstt-deploy script
    if [ -f "/usr/local/bin/dnstt-deploy" ]; then
        dnstt_detected=true
        detection_reasons+=("dnstt-deploy script found")
    fi

    if [ "$dnstt_detected" = true ]; then
        echo ""
        print_error "dnstt installation detected on this system!"
        echo ""
        print_warning "The following dnstt components were found:"
        for reason in "${detection_reasons[@]}"; do
            echo -e "  ${YELLOW}- $reason${NC}"
        done
        echo ""
        print_warning "dnstt must be uninstalled before installing slipstream-rust."
        print_warning "slipstream-rust now uses internal port 5301 (dnstt uses 5300), so this conflict no longer applies."
        echo ""
        print_status "To uninstall dnstt, run the following command:"
        echo -e "${GREEN}  bash <(curl -Ls https://raw.githubusercontent.com/AliRezaBeigy/dnstt-deploy/main/dnstt-deploy.sh) uninstall${NC}"
        echo ""
        print_question "Press Enter after uninstalling dnstt to continue, or Ctrl+C to exit: "
        read -r
        echo ""
        
        # Verify dnstt is actually uninstalled
        local still_installed=false
        if [ -f "/usr/local/bin/dnstt-server" ] || \
           systemctl list-unit-files | grep -q "^dnstt-server.service" || \
           id "dnstt" &>/dev/null || \
           [ -d "/etc/dnstt" ]; then
            still_installed=true
        fi
        
        if [ "$still_installed" = true ]; then
            print_error "dnstt is still detected on the system. Please uninstall it completely before proceeding."
            exit 1
        else
            print_status "dnstt has been successfully removed. Continuing with slipstream-rust installation..."
        fi
    fi
}

# Main function
main() {
    # Handle command-line arguments
    if [ "$1" = "uninstall" ]; then
        uninstall_slipstream
        exit $?
    fi

    # If not running from installed location (curl/GitHub), install the script first
    if [ "$0" != "$SCRIPT_INSTALL_PATH" ]; then
        print_status "Installing slipstream-rust-deploy script..."
        install_script
        print_status "Starting slipstream-rust server setup..."
    else
        # Running from installed location - check for updates and show menu
        check_for_updates
        handle_menu
        # If we reach here, user chose option 1 (Install/Reconfigure), so continue
        print_status "Starting slipstream-rust server installation/reconfiguration..."
    fi

    # Detect OS and architecture
    detect_os

    # NOTE: dnstt check removed - slipstream-rust (port 5301) and dnstt (port 5300)
    # now use different internal ports and can be installed/run side by side.

    # Get user input
    get_user_input

    # Install slipstream-server (prebuilt or from source)
    install_slipstream_server

    # Create slipstream user
    create_slipstream_user

    # Generate certificates
    generate_certificates

    # Save configuration after certificates are generated
    save_config

    # Configure firewall and iptables
    configure_firewall

    # Setup tunnel mode specific configurations
    case "$TUNNEL_MODE" in
        socks)
            setup_dante
            # Stop Shadowsocks if it was running
            if systemctl is-active --quiet shadowsocks-libev-server@config 2>/dev/null; then
                print_status "Switching to SOCKS mode - stopping Shadowsocks service..."
                systemctl stop shadowsocks-libev-server@config
                systemctl disable shadowsocks-libev-server@config
            fi
            ;;
        shadowsocks)
            setup_shadowsocks
            # Stop Dante if it was running
            if systemctl is-active --quiet danted 2>/dev/null; then
                print_status "Switching to Shadowsocks mode - stopping Dante service..."
                systemctl stop danted
                systemctl disable danted
            fi
            ;;
        ssh|*)
            # If switching from SOCKS or Shadowsocks to SSH, stop those services
            if systemctl is-active --quiet danted 2>/dev/null; then
                print_status "Switching to SSH mode - stopping Dante service..."
                systemctl stop danted
                systemctl disable danted
            fi
            if systemctl is-active --quiet shadowsocks-libev-server@config 2>/dev/null; then
                print_status "Switching to SSH mode - stopping Shadowsocks service..."
                systemctl stop shadowsocks-libev-server@config
                systemctl disable shadowsocks-libev-server@config
            fi
            ;;
    esac

    # Create systemd service
    create_systemd_service

    # Start services
    start_services

    # Display final information
    display_final_info
}

# Run main function
main "$@"
SLIPSTREAM_DEPLOY_EOF
    chmod +x "$SLIPSTREAM_V2_SCRIPT"
}

run_slipstream_v2() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📡 slipstream-rust (DNS Tunnel) ---${C_RESET}"
    if [ ! -x "$SLIPSTREAM_V2_SCRIPT" ]; then
        echo -e "\n${C_BLUE}📥 Deploying slipstream-rust-deploy...${C_RESET}"
        deploy_slipstream_v2_script
    fi
    echo -e "${C_DIM}Handing off to slipstream-rust-deploy's own menu. It will return here when you exit it.${C_RESET}"
    bash "$SLIPSTREAM_V2_SCRIPT"
}

uninstall_slipstream_v2() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling slipstream-rust ---${C_RESET}"
    if [ ! -f "$SLIPSTREAM_V2_SERVICE_FILE" ] && [ ! -f "$SLIPSTREAM_V2_SCRIPT" ] && [ ! -d "$SLIPSTREAM_V2_CONFIG_DIR" ]; then
        echo -e "${C_YELLOW}ℹ️ slipstream-rust does not appear to be installed, skipping.${C_RESET}"
        return
    fi
    if [ -x "$SLIPSTREAM_V2_SCRIPT" ]; then
        if [[ "$UNINSTALL_MODE" == "silent" ]]; then
            yes | bash "$SLIPSTREAM_V2_SCRIPT" uninstall >/dev/null 2>&1 || true
        else
            bash "$SLIPSTREAM_V2_SCRIPT" uninstall
        fi
    fi
    echo -e "${C_BLUE}🗑️ Removing any leftover files...${C_RESET}"
    systemctl stop slipstream-rust-server >/dev/null 2>&1
    systemctl disable slipstream-rust-server >/dev/null 2>&1
    rm -f "$SLIPSTREAM_V2_SERVICE_FILE"
    rm -f "$SLIPSTREAM_BINARY"
    rm -f "$SLIPSTREAM_V2_SCRIPT"
    rm -rf "$SLIPSTREAM_V2_CONFIG_DIR"
    rm -rf "$SLIPSTREAM_V2_BUILD_DIR"
    if id "$SLIPSTREAM_V2_USER" &>/dev/null; then userdel "$SLIPSTREAM_V2_USER" &>/dev/null; fi
    systemctl daemon-reload
    echo -e "\n${C_GREEN}✅ slipstream-rust has been successfully uninstalled.${C_RESET}"
}
install_falcon_proxy() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🔥 Installing Gost Proxy (SOCKS5/HTTP/Websocket) ---${C_RESET}"

    if [ -f "$FALCONPROXY_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ Gost Proxy is already installed.${C_RESET}"
        if [ -f "$FALCONPROXY_CONFIG_FILE" ]; then
            source "$FALCONPROXY_CONFIG_FILE"
            echo -e "   It is configured to run on port(s): ${C_YELLOW}$PORTS${C_RESET}"
            echo -e "   Installed Version: ${C_YELLOW}${INSTALLED_VERSION:-Unknown}${C_RESET}"
        fi
        read -p "👉 Do you want to reinstall/update? (y/n): " confirm_reinstall
        if [[ "$confirm_reinstall" != "y" ]]; then return; fi
    fi

    if ! command -v jq &>/dev/null; then
        echo -e "\n${C_YELLOW}📦 Installing 'jq' (required)...${C_RESET}"
        apt-get update -qq && apt-get install -y jq -qq
    fi

    echo -e "\n${C_BLUE}🌐 Fetching the latest Gost release from GitHub...${C_RESET}"
    local releases_json=$(curl -s "https://api.github.com/repos/go-gost/gost/releases/latest")
    if [[ -z "$releases_json" ]]; then
        echo -e "${C_RED}❌ Error: Could not fetch release info. Check internet or GitHub API limits.${C_RESET}"
        return
    fi

    SELECTED_VERSION=$(echo "$releases_json" | jq -r '.tag_name')
    if [[ -z "$SELECTED_VERSION" || "$SELECTED_VERSION" == "null" ]]; then
        echo -e "${C_RED}❌ No release found for go-gost/gost.${C_RESET}"
        return
    fi
    echo -e "${C_GREEN}✔ Latest version: $SELECTED_VERSION${C_RESET}"

    local ports
    read -p "👉 Enter port(s) for Gost Proxy (e.g., 8080 or 8080 8888) [8080]: " ports
    ports=${ports:-8080}

    local port_array=($ports)
    for port in "${port_array[@]}"; do
        if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
            echo -e "\n${C_RED}❌ Invalid port number: $port. Aborting.${C_RESET}"
            return
        fi
        check_and_free_ports "$port" || return
        check_and_open_firewall_port "$port" tcp || return
    done

    echo -e "\n${C_GREEN}⚙️ Detecting system architecture...${C_RESET}"
    local arch=$(uname -m)
    local arch_tag=""
    if [[ "$arch" == "x86_64" ]]; then
        arch_tag="amd64"
        echo -e "${C_BLUE}ℹ️ Detected x86_64 (amd64) architecture.${C_RESET}"
    elif [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
        arch_tag="arm64"
        echo -e "${C_BLUE}ℹ️ Detected ARM64 architecture.${C_RESET}"
    else
        echo -e "\n${C_RED}❌ Unsupported architecture: $arch. Cannot install Gost Proxy.${C_RESET}"
        return
    fi

    # Find the matching linux tar.gz asset for this architecture
    local download_url=$(echo "$releases_json" | jq -r --arg a "linux_${arch_tag}" \
        '.assets[] | select(.name | test($a)) | select(.name | endswith(".tar.gz")) | .browser_download_url' | head -n1)

    if [[ -z "$download_url" || "$download_url" == "null" ]]; then
        echo -e "\n${C_RED}❌ Could not find a matching Gost binary for linux_${arch_tag} in release $SELECTED_VERSION.${C_RESET}"
        return
    fi

    echo -e "\n${C_GREEN}📥 Downloading Gost Proxy $SELECTED_VERSION (linux_${arch_tag})...${C_RESET}"
    local tmp_archive="/tmp/gost_download.tar.gz"
    local tmp_extract="/tmp/gost_extract"
    rm -rf "$tmp_extract"; mkdir -p "$tmp_extract"
    wget -q --show-progress -O "$tmp_archive" "$download_url"
    if [ $? -ne 0 ]; then
        echo -e "\n${C_RED}❌ Failed to download the Gost archive.${C_RESET}"
        return
    fi

    tar -xzf "$tmp_archive" -C "$tmp_extract"
    local extracted_bin=$(find "$tmp_extract" -maxdepth 2 -type f -name "gost")
    if [[ -z "$extracted_bin" ]]; then
        echo -e "\n${C_RED}❌ Could not find 'gost' binary inside the downloaded archive.${C_RESET}"
        return
    fi

    mv "$extracted_bin" "$FALCONPROXY_BINARY"
    chmod +x "$FALCONPROXY_BINARY"
    rm -rf "$tmp_archive" "$tmp_extract"

    echo -e "\n${C_GREEN}📝 Creating systemd service file...${C_RESET}"
    # Build a -L socks5+ws://:port flag for each requested port
    # (socks5+ws instead of plain socks5 so the listener accepts an HTTP
    #  Upgrade: websocket handshake -- required for nginx's proxy_pass
    #  with Upgrade/Connection headers to reach this backend correctly)
    local listen_flags=""
    for port in "${port_array[@]}"; do
        listen_flags="$listen_flags -L socks5+ws://:$port"
    done

    cat > "$FALCONPROXY_SERVICE_FILE" <<EOF
[Unit]
Description=Gost Proxy ($SELECTED_VERSION)
After=network.target

[Service]
User=root
Type=simple
ExecStart=$FALCONPROXY_BINARY$listen_flags
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF

    echo -e "\n${C_GREEN}💾 Saving configuration...${C_RESET}"
    cat > "$FALCONPROXY_CONFIG_FILE" <<EOF
PORTS="$ports"
INSTALLED_VERSION="$SELECTED_VERSION"
EOF

    echo -e "\n${C_GREEN}▶️ Enabling and starting Gost Proxy service...${C_RESET}"
    systemctl daemon-reload
    systemctl enable falconproxy.service
    systemctl restart falconproxy.service
    sleep 2

    if systemctl is-active --quiet falconproxy; then
        echo -e "\n${C_GREEN}✅ SUCCESS: Gost Proxy $SELECTED_VERSION is installed and active.${C_RESET}"
        echo -e "   SOCKS5-over-WebSocket listening on port(s): ${C_YELLOW}$ports${C_RESET} (path: /ws)"
    else
        echo -e "\n${C_RED}❌ ERROR: Gost Proxy service failed to start.${C_RESET}"
        echo -e "${C_YELLOW}ℹ️ Displaying last 15 lines of the service log for diagnostics:${C_RESET}"
        journalctl -u falconproxy.service -n 15 --no-pager
    fi
}

uninstall_falcon_proxy() {
    echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling Gost Proxy ---${C_RESET}"
    if [ ! -f "$FALCONPROXY_SERVICE_FILE" ]; then
        echo -e "${C_YELLOW}ℹ️ Gost Proxy is not installed, skipping.${C_RESET}"
        return
    fi
    echo -e "${C_GREEN}🛑 Stopping and disabling Gost Proxy service...${C_RESET}"
    systemctl stop falconproxy.service >/dev/null 2>&1
    systemctl disable falconproxy.service >/dev/null 2>&1
    echo -e "${C_GREEN}🗑️ Removing service file...${C_RESET}"
    rm -f "$FALCONPROXY_SERVICE_FILE"
    systemctl daemon-reload
    echo -e "${C_GREEN}🗑️ Removing binary and config files...${C_RESET}"
    rm -f "$FALCONPROXY_BINARY"
    rm -f "$FALCONPROXY_CONFIG_FILE"
    echo -e "${C_GREEN}✅ Gost Proxy has been uninstalled successfully.${C_RESET}"
}

# --- ZiVPN Installation Logic ---
install_zivpn() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Installing ZiVPN (UDP/VPN) ---${C_RESET}"
    
    if [ -f "$ZIVPN_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ ZiVPN is already installed.${C_RESET}"
        return
    fi

    if [ ! -f "$BADVPN_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}⚠️ ZiVPN requires the badvpn (udpgw) backend to provide internet access.${C_RESET}"
        echo -e "${C_GREEN}📦 Automatically installing badvpn backend...${C_RESET}"
        sleep 2
        install_badvpn
        clear; show_banner
        echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Resuming ZiVPN Installation ---${C_RESET}"
    fi

    check_and_free_ports 5667 || return
    check_and_open_firewall_port 5667 udp || return
    check_and_open_firewall_port_range "6000:19999" udp || return

    echo -e "\n${C_GREEN}⚙️ Checking system architecture...${C_RESET}"
    local arch=$(uname -m)
    local zivpn_url=""
    
    if [[ "$arch" == "x86_64" ]]; then
        zivpn_url="https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-amd64"
        echo -e "${C_BLUE}ℹ️ Detected AMD64/x86_64 architecture.${C_RESET}"
    elif [[ "$arch" == "aarch64" ]]; then
        zivpn_url="https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-arm64"
        echo -e "${C_BLUE}ℹ️ Detected ARM64 architecture.${C_RESET}"
    elif [[ "$arch" == "armv7l" || "$arch" == "arm" ]]; then
         zivpn_url="https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-arm"
         echo -e "${C_BLUE}ℹ️ Detected ARM architecture.${C_RESET}"
    else
        echo -e "${C_RED}❌ Unsupported architecture: $arch${C_RESET}"
        return
    fi

    echo -e "\n${C_GREEN}📦 Downloading ZiVPN binary...${C_RESET}"
    if ! wget -q --show-progress -O "$ZIVPN_BIN" "$zivpn_url"; then
        echo -e "${C_RED}❌ Download failed. Check internet connection.${C_RESET}"
        return
    fi
    chmod +x "$ZIVPN_BIN"

    echo -e "\n${C_GREEN}⚙️ Configuring ZIVPN...${C_RESET}"
    mkdir -p "$ZIVPN_DIR"
    
    # Generate Certificates
    echo -e "${C_BLUE}🔐 Generating self-signed certificates...${C_RESET}"
    if ! command -v openssl &>/dev/null; then
        ff_pkg_install openssl >/dev/null 2>&1 || {
            echo -e "${C_RED}❌ Failed to install openssl for ZiVPN certificate generation.${C_RESET}"
            return
        }
    fi
    
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
        -subj "/C=US/ST=California/L=Los Angeles/O=Example Corp/OU=IT Department/CN=zivpn" \
        -keyout "$ZIVPN_KEY_FILE" -out "$ZIVPN_CERT_FILE" 2>/dev/null

    if [ ! -f "$ZIVPN_CERT_FILE" ]; then
        echo -e "${C_RED}❌ Failed to generate certificates.${C_RESET}"
        return
    fi

    # System Tuning
    echo -e "${C_BLUE}🔧 Tuning system network parameters...${C_RESET}"
    sysctl -w net.core.rmem_max=16777216 >/dev/null
    sysctl -w net.core.wmem_max=16777216 >/dev/null

    # Create Service
    echo -e "${C_BLUE}📝 Creating systemd service file...${C_RESET}"
    cat <<EOF > "$ZIVPN_SERVICE_FILE"
[Unit]
Description=zivpn VPN Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=$ZIVPN_DIR
ExecStart=$ZIVPN_BIN server -c $ZIVPN_CONFIG_FILE
Restart=always
RestartSec=3
Environment=ZIVPN_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF

    # Configure Passwords
    echo -e "\n${C_YELLOW}🔑 ZiVPN Password Setup${C_RESET}"
    read -p "👉 Enter passwords separated by commas (e.g., user1,user2) [Default: 'zi']: " input_config
    
    if [ -n "$input_config" ]; then
        IFS=',' read -r -a config_array <<< "$input_config"
        # Ensure array format for JSON
        json_passwords=$(printf '"%s",' "${config_array[@]}")
        json_passwords="[${json_passwords%,}]"
    else
        json_passwords='["zi"]'
    fi

    # Create Config File
    cat <<EOF > "$ZIVPN_CONFIG_FILE"
{
  "listen": ":5667",
   "cert": "$ZIVPN_CERT_FILE",
   "key": "$ZIVPN_KEY_FILE",
   "obfs":"zivpn",
   "auth": {
    "mode": "passwords", 
    "config": $json_passwords
  }
}
EOF

    echo -e "\n${C_GREEN}🚀 Starting ZiVPN Service...${C_RESET}"
    systemctl daemon-reload
    systemctl enable zivpn.service
    systemctl start zivpn.service

    # Port Forwarding / Firewall
    echo -e "${C_BLUE}🔥 Configuring Firewall Rules (Redirecting 6000-19999 -> 5667)...${C_RESET}"
    
    # Determine primary interface
    local iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
    
    if [ -n "$iface" ]; then
        iptables -t nat -C PREROUTING -i "$iface" -p udp --dport 6000:19999 -j DNAT --to-destination :5667 2>/dev/null || \
            iptables -t nat -A PREROUTING -i "$iface" -p udp --dport 6000:19999 -j DNAT --to-destination :5667
        # Note: IPTables rules are not persistent by default without iptables-persistent package
    else
        echo -e "${C_YELLOW}⚠️ Could not detect default interface for IPTables redirection.${C_RESET}"
    fi

    # Cleanup
    rm -f zi.sh zi2.sh 2>/dev/null

    if systemctl is-active --quiet zivpn.service; then
        echo -e "\n${C_GREEN}✅ ZiVPN Installed Successfully!${C_RESET}"
        echo -e "   - UDP Port: 5667 (Direct)"
        echo -e "   - UDP Ports: 6000-19999 (Forwarded)"
    else
        echo -e "\n${C_RED}❌ ZiVPN Service failed to start. Check logs: journalctl -u zivpn.service${C_RESET}"
    fi
}

uninstall_zivpn() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🗑️ Uninstall ZiVPN ---${C_RESET}"
    
    if [ ! -f "$ZIVPN_SERVICE_FILE" ] && [ ! -f "$ZIVPN_BIN" ]; then
        echo -e "\n${C_YELLOW}ℹ️ ZiVPN does not appear to be installed.${C_RESET}"
        return
    fi

    read -p "👉 Are you sure you want to uninstall ZiVPN? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then echo -e "${C_YELLOW}Cancelled.${C_RESET}"; return; fi

    echo -e "\n${C_BLUE}🛑 Stopping services...${C_RESET}"
    systemctl stop zivpn.service 2>/dev/null
    systemctl disable zivpn.service 2>/dev/null

    local iface
    iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
    if [ -n "$iface" ]; then
        iptables -t nat -D PREROUTING -i "$iface" -p udp --dport 6000:19999 -j DNAT --to-destination :5667 2>/dev/null || true
    fi
    
    echo -e "${C_BLUE}🗑️ Removing files...${C_RESET}"
    rm -f "$ZIVPN_SERVICE_FILE"
    rm -rf "$ZIVPN_DIR"
    rm -f "$ZIVPN_BIN"
    
    systemctl daemon-reload
    
    # Clean cache (from original uninstall script logic)
    echo -e "${C_BLUE}🧹 Cleaning memory cache...${C_RESET}"
    sync; echo 3 > /proc/sys/vm/drop_caches

    echo -e "\n${C_GREEN}✅ ZiVPN Uninstalled Successfully.${C_RESET}"
}

purge_nginx() {
    local mode="$1"
    if [[ "$mode" != "silent" ]]; then
        clear; show_banner
        echo -e "${C_BOLD}${C_PURPLE}--- 🔥 Purge Internal Nginx Proxy ---${C_RESET}"
        if ! command -v nginx &> /dev/null; then
            rm -f "$NGINX_PORTS_FILE"
            echo -e "\n${C_YELLOW}ℹ️ Nginx is not installed. Nothing to do.${C_RESET}"
            return
        fi
        echo -e "\n${C_YELLOW}⚠️ This removes the internal Nginx proxy on ${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}.${C_RESET}"
        if systemctl is-active --quiet haproxy; then
            echo -e "${C_YELLOW}⚠️ HAProxy will stay installed, but web payload routing from ${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT} will stop until you reinstall the stack.${C_RESET}"
        fi
        read -p "👉 Continue and purge Nginx? (y/n): " confirm
        if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
            echo -e "\n${C_YELLOW}❌ Uninstallation cancelled.${C_RESET}"
            return
        fi
    fi
    echo -e "\n${C_BLUE}🛑 Stopping Nginx service...${C_RESET}"
    systemctl stop nginx >/dev/null 2>&1
    systemctl disable nginx >/dev/null 2>&1
    echo -e "\n${C_BLUE}🗑️ Purging Nginx packages...${C_RESET}"
    ff_pkg_purge nginx nginx-common >/dev/null 2>&1
    ff_pkg_autoremove
    echo -e "\n${C_BLUE}🗑️ Removing leftover files...${C_RESET}"
    rm -f /etc/ssl/certs/nginx-selfsigned.pem
    rm -f /etc/ssl/private/nginx-selfsigned.key
    rm -rf /etc/nginx
    rm -f "${NGINX_CONFIG_FILE}.bak"
    rm -f "${NGINX_CONFIG_FILE}.bak.certbot"
    rm -f "${NGINX_CONFIG_FILE}.bak.selfsigned"
    rm -f "${NGINX_CONFIG_FILE}.bak.firewallfalcon"
    rm -f "$NGINX_PORTS_FILE"
    if [[ "$mode" != "silent" ]]; then
        echo -e "\n${C_GREEN}✅ Internal Nginx proxy purged. Shared Hotscript certificates were kept.${C_RESET}"
    fi
}

install_nginx_proxy() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Reconfiguring Internal Nginx Proxy (8880/8443) ---${C_RESET}"
    echo -e "\n${C_CYAN}This keeps HAProxy on ${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT} and rewrites the internal Nginx proxy on ${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}.${C_RESET}"

    if [ ! -s "$SSL_CERT_FILE" ] || [ ! -s "$SSL_CERT_CHAIN_FILE" ] || [ ! -s "$SSL_CERT_KEY_FILE" ]; then
        echo -e "\n${C_YELLOW}⚠️ No shared Hotscript certificate was found.${C_RESET}"
        echo -e "${C_DIM}Running the full HAProxy edge installer so the certificate and both services stay aligned.${C_RESET}"
        install_ssl_tunnel
        return
    fi

    mkdir -p "$DB_DIR" "$SSL_CERT_DIR"
    ensure_edge_stack_packages || return

    systemctl stop haproxy >/dev/null 2>&1
    systemctl stop nginx >/dev/null 2>&1
    sleep 1

    check_and_free_ports \
        "$EDGE_PUBLIC_HTTP_PORT" \
        "$EDGE_PUBLIC_TLS_PORT" \
        "$NGINX_INTERNAL_HTTP_PORT" \
        "$NGINX_INTERNAL_TLS_PORT" \
        "$HAPROXY_INTERNAL_DECRYPT_PORT" || return

    check_and_open_firewall_port "$EDGE_PUBLIC_HTTP_PORT" tcp || return
    check_and_open_firewall_port "$EDGE_PUBLIC_TLS_PORT" tcp || return

    load_edge_cert_info
    local server_name="${EDGE_DOMAIN:-$(detect_preferred_host)}"
    [[ -z "$server_name" ]] && server_name="_"

    configure_edge_stack "$server_name" || return

    echo -e "\n${C_GREEN}✅ Internal Nginx proxy reconfigured successfully.${C_RESET}"
    echo -e "   • Public HAProxy edge: ${C_YELLOW}${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT}${C_RESET}"
    echo -e "   • Internal Nginx: ${C_YELLOW}${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}${C_RESET}"
}

request_certbot_ssl() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🔒 Shared Certbot Certificate (HAProxy + Nginx) ---${C_RESET}"
    echo -e "\n${C_DIM}This will replace the shared certificate used by HAProxy on ${EDGE_PUBLIC_TLS_PORT} and internal Nginx on ${NGINX_INTERNAL_TLS_PORT}.${C_RESET}"

    mkdir -p "$DB_DIR" "$SSL_CERT_DIR"
    ensure_edge_stack_packages || return
    load_edge_cert_info

    local preferred_host
    local default_domain=""
    local domain_name
    local email

    preferred_host=$(detect_preferred_host)
    if [[ -n "$EDGE_DOMAIN" ]] && ! _is_valid_ipv4 "$EDGE_DOMAIN"; then
        default_domain="$EDGE_DOMAIN"
    elif [[ -n "$preferred_host" ]] && ! _is_valid_ipv4 "$preferred_host"; then
        default_domain="$preferred_host"
    fi

    if [[ -n "$default_domain" ]]; then
        read -p "👉 Enter your domain name [$default_domain]: " domain_name
        domain_name=${domain_name:-$default_domain}
    else
        read -p "👉 Enter your domain name (e.g. vpn.example.com): " domain_name
    fi
    if [[ -z "$domain_name" ]]; then
        echo -e "\n${C_RED}❌ Domain name cannot be empty.${C_RESET}"
        return
    fi
    if _is_valid_ipv4 "$domain_name"; then
        echo -e "\n${C_RED}❌ Certbot requires a real domain name, not a raw IP address.${C_RESET}"
        return
    fi

    read -p "👉 Enter your email for Let's Encrypt [${EDGE_EMAIL}]: " email
    email=${email:-$EDGE_EMAIL}
    if [[ -z "$email" ]]; then
        echo -e "\n${C_RED}❌ Email address cannot be empty.${C_RESET}"
        return
    fi

    check_and_open_firewall_port "$EDGE_PUBLIC_HTTP_PORT" tcp || return
    check_and_open_firewall_port "$EDGE_PUBLIC_TLS_PORT" tcp || return

    obtain_certbot_edge_cert "$domain_name" "$email" || return
    configure_edge_stack "$domain_name" || return

    echo -e "\n${C_GREEN}✅ Shared Certbot certificate applied successfully.${C_RESET}"
    echo -e "   • Domain: ${C_YELLOW}${domain_name}${C_RESET}"
    echo -e "   • Public edge: ${C_YELLOW}${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT}${C_RESET}"
}

nginx_proxy_menu() {
    while true; do
    show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🌐 Internal Nginx Proxy Management ---${C_RESET}"

    local nginx_status="${C_STATUS_I}Inactive${C_RESET}"
    local haproxy_status="${C_STATUS_I}Inactive${C_RESET}"
    if systemctl is-active --quiet nginx; then
        nginx_status="${C_STATUS_A}Active${C_RESET}"
    fi
    if systemctl is-active --quiet haproxy; then
        haproxy_status="${C_STATUS_A}Active${C_RESET}"
    fi

    load_edge_cert_info
    local cert_info="${EDGE_CERT_MODE:-Not configured}"
    if [[ -n "$EDGE_DOMAIN" ]]; then
        cert_info="${cert_info} - ${EDGE_DOMAIN}"
    fi

    echo -e "\n${C_WHITE}Nginx:${C_RESET} ${nginx_status}"
    echo -e "${C_WHITE}HAProxy:${C_RESET} ${haproxy_status}"
    echo -e "${C_DIM}Public Edge: ${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT} | Internal Nginx: ${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}${C_RESET}"
    echo -e "${C_DIM}Shared Certificate: ${cert_info}${C_RESET}"

    echo -e "\n${C_BOLD}Select an action:${C_RESET}\n"
    
    if systemctl is-active --quiet nginx; then
         printf "  ${C_CHOICE}[ 1]${C_RESET} %-40s\n" "🛑 Stop Nginx Service"
         printf "  ${C_CHOICE}[ 2]${C_RESET} %-40s\n" "🔄 Restart HAProxy + Nginx Stack"
         printf "  ${C_CHOICE}[ 3]${C_RESET} %-40s\n" "⚙️ Re-install/Re-configure Edge Stack"
         printf "  ${C_CHOICE}[ 4]${C_RESET} %-40s\n" "🔒 Switch/Renew Shared SSL (Certbot)"
         printf "  ${C_CHOICE}[ 5]${C_RESET} %-40s\n" "🔥 Uninstall/Purge Nginx"
    else
         printf "  ${C_CHOICE}[ 1]${C_RESET} %-40s\n" "▶️ Start Nginx Service"
         printf "  ${C_CHOICE}[ 3]${C_RESET} %-40s\n" "⚙️ Install/Configure Edge Stack"
         printf "  ${C_CHOICE}[ 4]${C_RESET} %-40s\n" "🔒 Switch/Renew Shared SSL (Certbot)"
         printf "  ${C_CHOICE}[ 5]${C_RESET} %-40s\n" "🔥 Uninstall/Purge Nginx"
    fi

    echo -e "\n  ${C_WARN}[ 0]${C_RESET} ↩️ Return"
    echo
    if ! read -r -p "$(echo -e ${C_PROMPT}"👉 Select an option: "${C_RESET})" choice; then
        echo
        return
    fi
    
    case $choice in
        1) 
            if systemctl is-active --quiet nginx; then
                echo -e "\n${C_BLUE}🛑 Stopping Nginx...${C_RESET}"
                systemctl stop nginx
                echo -e "${C_GREEN}✅ Nginx stopped.${C_RESET}"
                if systemctl is-active --quiet haproxy; then
                    echo -e "${C_YELLOW}⚠️ HAProxy is still running, but web traffic that depends on internal Nginx will not work until Nginx starts again.${C_RESET}"
                fi
            else
                echo -e "\n${C_BLUE}▶️ Starting Nginx...${C_RESET}"
                systemctl start nginx
                if systemctl is-active --quiet nginx; then
                    echo -e "${C_GREEN}✅ Nginx started.${C_RESET}"
                else
                    echo -e "${C_RED}❌ Failed to start Nginx.${C_RESET}"
                fi
            fi
            press_enter
            ;;
        2)
            echo -e "\n${C_BLUE}🔄 Restarting Nginx and HAProxy...${C_RESET}"
            local restart_ok=true
            systemctl restart nginx || restart_ok=false
            if command -v haproxy &> /dev/null; then
                systemctl restart haproxy || restart_ok=false
            else
                restart_ok=false
            fi
            if $restart_ok && systemctl is-active --quiet nginx && systemctl is-active --quiet haproxy; then
                echo -e "${C_GREEN}✅ HAProxy + Nginx stack restarted.${C_RESET}"
            else
                echo -e "${C_RED}❌ One or more services failed to restart.${C_RESET}"
            fi
            press_enter
            ;;
        3) 
             install_nginx_proxy; press_enter
             ;;
        4)
             request_certbot_ssl; press_enter
             ;;
        5)
             purge_nginx; press_enter
             ;;
        0) return ;;
        *) invalid_option ;;
    esac
    done
}

install_panel_menu() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 💻 Install X-UI / 3X-UI Panel ---${C_RESET}"
    echo -e "\n${C_CYAN}Select which panel to install:${C_RESET}\n"
    printf "  ${C_CHOICE}[ 1]${C_RESET} %-45s %s\n" "🚀 3X-UI Panel (MHSanaei)" "${C_STATUS_A}⭐ Default${C_RESET}"
    printf "  ${C_CHOICE}[ 2]${C_RESET} %-45s %s\n" "📦 X-UI Panel (alireza0)" ""
    echo -e "\n  ${C_RED}[ 0]${C_RESET} ❌ Cancel"
    echo
    read -p "👉 Select panel [1]: " panel_choice
    panel_choice=${panel_choice:-1}
    case $panel_choice in
        1) install_3xui_panel ;;
        2) install_xui_panel ;;
        0) echo -e "\n${C_YELLOW}❌ Installation cancelled.${C_RESET}" ;;
        *) echo -e "\n${C_RED}❌ Invalid option.${C_RESET}" ;;
    esac
}

install_3xui_panel() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Install 3X-UI Panel ---${C_RESET}"
    echo -e "\nThis will download and run the official installation script for 3X-UI (MHSanaei)."
    echo -e "Choose an installation option:\n"
    printf "  ${C_GREEN}[ 1]${C_RESET} %-40s\n" "Install the latest version of 3X-UI"
    printf "  ${C_GREEN}[ 2]${C_RESET} %-40s\n" "Install a specific version of 3X-UI"
    echo -e "\n  ${C_RED}[ 0]${C_RESET} ❌ Cancel Installation"
    echo
    read -p "👉 Select an option: " choice
    case $choice in
        1)
            echo -e "\n${C_BLUE}⚙️ Installing the latest version...${C_RESET}"
            bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
            ;;
        2)
            read -p "👉 Enter the version to install (e.g., 2.4.5): " version
            if [[ -z "$version" ]]; then
                echo -e "\n${C_RED}❌ Version number cannot be empty.${C_RESET}"
                return
            fi
            echo -e "\n${C_BLUE}⚙️ Installing version ${C_YELLOW}$version...${C_RESET}"
            bash <(curl -Ls "https://raw.githubusercontent.com/mhsanaei/3x-ui/v$version/install.sh") "v$version"
            ;;
        0)
            echo -e "\n${C_YELLOW}❌ Installation cancelled.${C_RESET}"
            ;;
        *)
            echo -e "\n${C_RED}❌ Invalid option.${C_RESET}"
            ;;
    esac
}

install_xui_panel() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📦 Install X-UI Panel (Legacy) ---${C_RESET}"
    echo -e "\nThis will download and run the installation script for X-UI (alireza0)."
    echo -e "Choose an installation option:\n"
    printf "  ${C_GREEN}[ 1]${C_RESET} %-40s\n" "Install the latest version of X-UI"
    printf "  ${C_GREEN}[ 2]${C_RESET} %-40s\n" "Install a specific version of X-UI"
    echo -e "\n  ${C_RED}[ 0]${C_RESET} ❌ Cancel Installation"
    echo
    read -p "👉 Select an option: " choice
    case $choice in
        1)
            echo -e "\n${C_BLUE}⚙️ Installing the latest version...${C_RESET}"
            bash <(curl -Ls https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh)
            ;;
        2)
            read -p "👉 Enter the version to install (e.g., 1.8.0): " version
            if [[ -z "$version" ]]; then
                echo -e "\n${C_RED}❌ Version number cannot be empty.${C_RESET}"
                return
            fi
            echo -e "\n${C_BLUE}⚙️ Installing version ${C_YELLOW}$version...${C_RESET}"
            VERSION=$version bash <(curl -Ls "https://raw.githubusercontent.com/alireza0/x-ui/$version/install.sh") "$version"
            ;;
        0)
            echo -e "\n${C_YELLOW}❌ Installation cancelled.${C_RESET}"
            ;;
        *)
            echo -e "\n${C_RED}❌ Invalid option.${C_RESET}"
            ;;
    esac
}

uninstall_xui_panel() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🗑️ Uninstall X-UI / 3X-UI Panel ---${C_RESET}"
    if ! command -v x-ui &> /dev/null; then
        echo -e "\n${C_YELLOW}ℹ️ No X-UI/3X-UI panel appears to be installed.${C_RESET}"
        return
    fi
    read -p "👉 Are you sure you want to thoroughly uninstall X-UI/3X-UI? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        echo -e "\n${C_BLUE}⚙️ Running the default uninstaller first...${C_RESET}"
        x-ui uninstall >/dev/null 2>&1
        echo -e "\n${C_BLUE}🧹 Performing a full cleanup to ensure complete removal...${C_RESET}"
        echo " - Stopping and disabling x-ui service..."
        systemctl stop x-ui >/dev/null 2>&1
        systemctl disable x-ui >/dev/null 2>&1
        echo " - Removing x-ui files and directories..."
        rm -f /etc/systemd/system/x-ui.service
        rm -f /usr/local/bin/x-ui
        rm -rf /usr/local/x-ui/
        rm -rf /etc/x-ui/
        echo " - Reloading systemd daemon..."
        systemctl daemon-reload
        echo -e "\n${C_GREEN}✅ X-UI/3X-UI has been thoroughly uninstalled.${C_RESET}"
    else
        echo -e "\n${C_YELLOW}❌ Uninstallation cancelled.${C_RESET}"
    fi
}

refresh_ssh_session_cache() {
    local now db_mtime
    printf -v now '%(%s)T' -1
    db_mtime=$(stat -c %Y "$DB_FILE" 2>/dev/null || echo 0)

    if (( SSH_SESSION_CACHE_TS > 0 && now - SSH_SESSION_CACHE_TS < SSH_SESSION_CACHE_TTL && db_mtime == SSH_SESSION_CACHE_DB_MTIME )); then
        return
    fi

    SSH_SESSION_COUNTS=()
    SSH_SESSION_PIDS=()
    SSH_SESSION_TOTAL=0
    SSH_SESSION_CACHE_DB_MTIME=$db_mtime

    if [[ ! -s "$DB_FILE" ]]; then
        SSH_SESSION_CACHE_TS=$now
        return
    fi

    local -A managed_user_lookup=()
    local -A uid_user_lookup=()
    local -A session_pids=()
    local -A loginuid_pids=()
    local managed_user system_user system_uid ssh_pid ssh_owner candidate_user login_uid

    while IFS=: read -r managed_user _rest; do
        [[ -n "$managed_user" && "$managed_user" != \#* ]] && managed_user_lookup["$managed_user"]=1
    done < "$DB_FILE"

    while IFS=: read -r system_user _ system_uid _rest; do
        [[ -n "$system_user" && "$system_uid" =~ ^[0-9]+$ ]] && uid_user_lookup["$system_uid"]="$system_user"
    done < /etc/passwd

    while read -r ssh_pid ssh_owner; do
        [[ "$ssh_pid" =~ ^[0-9]+$ ]] || continue

        # Method 1: process owner matches a managed user directly
        if [[ -n "$ssh_owner" && "$ssh_owner" != "root" && "$ssh_owner" != "sshd" && -n "${managed_user_lookup[$ssh_owner]+x}" ]]; then
            session_pids["$ssh_owner"]+="$ssh_pid "
        fi
    done < <(ps -C sshd,sshd-session -o pid=,user= 2>/dev/null)

    # Method 2: kernel loginuid with comm/PPid validation (more robust — matches limiter logic)
    local p pid_dir pid_num comm ppid_val session_user
    for p in /proc/[0-9]*/loginuid; do
        [[ -f "$p" ]] || continue
        login_uid=""
        read -r login_uid < "$p" || login_uid=""
        [[ "$login_uid" =~ ^[0-9]+$ && "$login_uid" != "4294967295" ]] || continue

        candidate_user="${uid_user_lookup[$login_uid]}"
        [[ -n "$candidate_user" && -n "${managed_user_lookup[$candidate_user]+x}" ]] || continue

        pid_dir=$(dirname "$p")
        pid_num=$(basename "$pid_dir")
        comm=""
        read -r comm < "$pid_dir/comm" 2>/dev/null || comm=""
        [[ "$comm" == "sshd" || "$comm" == "sshd-session" ]] || continue

        # Filter out the master sshd process (PPid=1)
        ppid_val=""
        while read -r key value; do
            [[ "$key" == "PPid:" ]] && { ppid_val="$value"; break; }
        done < "$pid_dir/status" 2>/dev/null
        [[ "$ppid_val" == "1" ]] && continue

        loginuid_pids["$candidate_user"]+="$pid_num "
    done

    local user pid
    for user in "${!managed_user_lookup[@]}"; do
        # CRITICAL: unset before declare to reset per-user (bash declare is function-scoped)
        unset unique_pids
        local -A unique_pids=()

        # Use ONLY ps-based session_pids for accurate counting.
        # loginuid_pids can double-count (root-owned sshd has user's loginuid on Ubuntu 24)
        for pid in ${session_pids[$user]}; do
            [[ "$pid" =~ ^[0-9]+$ ]] && unique_pids["$pid"]=1
        done

        SSH_SESSION_COUNTS["$user"]=${#unique_pids[@]}
        if (( ${#unique_pids[@]} > 0 )); then
            for pid in "${!unique_pids[@]}"; do
                SSH_SESSION_PIDS["$user"]+="$pid "
            done
            SSH_SESSION_TOTAL=$((SSH_SESSION_TOTAL + ${#unique_pids[@]}))
        fi
    done

    SSH_SESSION_CACHE_TS=$now
}

count_managed_online_sessions() {
    refresh_ssh_session_cache
    echo "$SSH_SESSION_TOTAL"
}

invalidate_banner_cache() {
    BANNER_CACHE_TS=0
    SSH_SESSION_CACHE_TS=0
}

refresh_banner_cache() {
    local now
    printf -v now '%(%s)T' -1
    if (( BANNER_CACHE_TS > 0 && now - BANNER_CACHE_TS < BANNER_CACHE_TTL )); then
        return
    fi

    if [[ -z "$BANNER_CACHE_OS_NAME" ]]; then
        BANNER_CACHE_OS_NAME=$(grep -oP 'PRETTY_NAME="\K[^"]+' /etc/os-release 2>/dev/null || echo "Linux")
    fi
    BANNER_CACHE_UP_TIME=$(uptime -p 2>/dev/null | sed 's/up //' || echo "unknown")
    BANNER_CACHE_RAM_USAGE=$(free -m | awk '/^Mem:/{if($2>0){printf "%.2f", $3*100/$2}else{print "0.00"}}')
    BANNER_CACHE_CPU_LOAD=$(awk '{print $1}' /proc/loadavg 2>/dev/null)
    if [[ -s "$DB_FILE" ]]; then
        BANNER_CACHE_TOTAL_USERS=0
        while IFS=: read -r _u _rest; do
            [[ -n "$_u" && "$_u" != \#* ]] && (( BANNER_CACHE_TOTAL_USERS++ ))
        done < "$DB_FILE"
    else
        BANNER_CACHE_TOTAL_USERS=0
    fi
    BANNER_CACHE_ONLINE_USERS=$(count_managed_online_sessions)
    BANNER_CACHE_TS=$now
}

show_banner() {
    refresh_banner_cache
    [[ -t 1 ]] && clear
    echo
    echo -e "${C_TITLE}   Hotscript Manager ${C_RESET}${C_DIM}| v4.0.0 Premium Edition${C_RESET}"
    echo -e "${C_BLUE}   ─────────────────────────────────────────────────────────${C_RESET}"
    printf "   ${C_GRAY}%-10s${C_RESET} %-20s ${C_GRAY}|${C_RESET} %s\n" "OS" "$BANNER_CACHE_OS_NAME" "Uptime: $BANNER_CACHE_UP_TIME"
    printf "   ${C_GRAY}%-10s${C_RESET} %-20s ${C_GRAY}|${C_RESET} %s\n" "Memory" "${BANNER_CACHE_RAM_USAGE}% Used" "Online Sessions: ${C_WHITE}${BANNER_CACHE_ONLINE_USERS}${C_RESET}"
    printf "   ${C_GRAY}%-10s${C_RESET} %-20s ${C_GRAY}|${C_RESET} %s\n" "Users" "${BANNER_CACHE_TOTAL_USERS} Managed Accounts" "Sys Load (1m): ${C_GREEN}${BANNER_CACHE_CPU_LOAD}${C_RESET}"
    echo -e "${C_BLUE}   ─────────────────────────────────────────────────────────${C_RESET}"
}

# ====================================================================
# --- WS-Dropbear (WebSocket -> SSH) Functions ---
# ====================================================================

install_ws_dropbear() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚀 Installing WS-Dropbear (WebSocket Tunnel) ---${C_RESET}"

    if [ -f "$WS_DROPBEAR_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ WS-Dropbear is already installed.${C_RESET}"
        if [ -f "$WS_DROPBEAR_CONFIG_FILE" ]; then
            source "$WS_DROPBEAR_CONFIG_FILE"
            echo -e "${C_DIM}   Listening Port: ${WS_PORT:-unknown}${C_RESET}"
        fi
        return
    fi

    if ! command -v python3 &>/dev/null; then
        echo -e "${C_YELLOW}Installing python3...${C_RESET}"
        ff_pkg_install python3 || { echo -e "${C_RED}❌ Failed to install python3.${C_RESET}"; return; }
    fi

    echo -e "${C_DIM}WS-Dropbear will bind to 127.0.0.1 only (not exposed publicly).${C_RESET}"
    echo -e "${C_DIM}This avoids conflicts with HAProxy edge (80/443), internal Nginx (${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}) and HAProxy's loopback decryptor (${HAPROXY_INTERNAL_DECRYPT_PORT}).${C_RESET}"
    read -p "👉 Enter the internal WebSocket port [Default: 700]: " ws_port
    ws_port=${ws_port:-700}
    if ! [[ "$ws_port" =~ ^[0-9]+$ ]] || [ "$ws_port" -lt 1 ] || [ "$ws_port" -gt 65535 ]; then
        echo -e "${C_RED}❌ Invalid port.${C_RESET}"
        return
    fi

    # Refuse ports already reserved by the edge stack / other services in this menu,
    # so WS-Dropbear can never steal a port from HAProxy, Nginx, the panel, etc.
    local -a reserved_ports=("$EDGE_PUBLIC_HTTP_PORT" "$EDGE_PUBLIC_TLS_PORT" "$NGINX_INTERNAL_HTTP_PORT" "$NGINX_INTERNAL_TLS_PORT" "$HAPROXY_INTERNAL_DECRYPT_PORT" "$PANEL_PORT" 22 53)
    for rp in "${reserved_ports[@]}"; do
        if [[ "$ws_port" == "$rp" ]]; then
            echo -e "${C_RED}❌ Port $ws_port is reserved by the edge/proxy stack. Choose a different port.${C_RESET}"
            return
        fi
    done

    check_and_free_ports "$ws_port" || return
    # No public firewall port is opened: WS-Dropbear listens on loopback only and is
    # reached through the existing edge (HAProxy 80/443 -> Nginx) via Nginx's dynamic
    # port-forward path, e.g. wss://yourdomain/${ws_port}/ — same mechanism Nginx
    # already uses for other local backends. This is what keeps dropbear, nginx, and
    # the edge proxy from ever fighting over the same public port again.

    echo -e "\n${C_BLUE}📝 Deploying WS-Dropbear proxy script...${C_RESET}"
    cat > "$WS_DROPBEAR_SCRIPT" <<'PYEOF'
#!/usr/bin/env python3
import socket
import threading
import select
import sys
import time
import getopt

LISTENING_ADDR = '0.0.0.0'
LISTENING_PORT = 80
DEFAULT_HOST = '127.0.0.1:22'
PASS = ''

BUFLEN = 4096 * 4
TIMEOUT = 60
RESPONSE = b'HTTP/1.1 101 Switching Protocols\r\nContent-Length: 104857600000\r\n\r\n'


class Server(threading.Thread):
    def __init__(self, host, port):
        threading.Thread.__init__(self)
        self.running = False
        self.host = host
        self.port = port
        self.threads = []
        self.threads_lock = threading.Lock()
        self.log_lock = threading.Lock()

    def run(self):
        self.soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.soc.settimeout(2)
        self.soc.bind((self.host, int(self.port)))
        self.soc.listen(5)
        self.running = True
        try:
            while self.running:
                try:
                    c, addr = self.soc.accept()
                    c.setblocking(True)
                except socket.timeout:
                    continue
                conn = ConnectionHandler(c, self, addr)
                conn.start()
                self.add_conn(conn)
        finally:
            self.running = False
            self.soc.close()

    def print_log(self, log):
        with self.log_lock:
            print(log)

    def add_conn(self, conn):
        with self.threads_lock:
            if self.running:
                self.threads.append(conn)

    def remove_conn(self, conn):
        with self.threads_lock:
            if conn in self.threads:
                self.threads.remove(conn)

    def close(self):
        self.running = False
        with self.threads_lock:
            for c in list(self.threads):
                c.close()


class ConnectionHandler(threading.Thread):
    def __init__(self, soc_client, server, addr):
        threading.Thread.__init__(self)
        self.client_closed = False
        self.target_closed = True
        self.client = soc_client
        self.client_buffer = b''
        self.server = server
        self.target = None
        self.log = 'Connection: ' + str(addr)

    def close(self):
        try:
            if not self.client_closed:
                self.client.shutdown(socket.SHUT_RDWR)
                self.client.close()
        except Exception:
            pass
        finally:
            self.client_closed = True
        try:
            if not self.target_closed:
                self.target.shutdown(socket.SHUT_RDWR)
                self.target.close()
        except Exception:
            pass
        finally:
            self.target_closed = True

    def run(self):
        try:
            self.client_buffer = self.client.recv(BUFLEN)
            host_port = self.find_header(self.client_buffer, b'X-Real-Host')
            if not host_port:
                host_port = DEFAULT_HOST

            split = self.find_header(self.client_buffer, b'X-Split')
            if split:
                self.client.recv(BUFLEN)

            if host_port:
                passwd = self.find_header(self.client_buffer, b'X-Pass')
                if len(PASS) != 0 and passwd == PASS:
                    self.method_connect(host_port)
                elif len(PASS) != 0 and passwd != PASS:
                    self.client.send(b'HTTP/1.1 400 WrongPass!\r\n\r\n')
                elif host_port.startswith('127.0.0.1') or host_port.startswith('localhost'):
                    self.method_connect(host_port)
                else:
                    self.client.send(b'HTTP/1.1 403 Forbidden!\r\n\r\n')
            else:
                self.client.send(b'HTTP/1.1 400 NoXRealHost!\r\n\r\n')
        except Exception as e:
            self.log += ' - error: ' + str(e)
            self.server.print_log(self.log)
        finally:
            self.close()
            self.server.remove_conn(self)

    def find_header(self, head, header):
        aux = head.find(header + b': ')
        if aux == -1:
            return ''
        aux = head.find(b':', aux)
        head = head[aux + 2:]
        aux = head.find(b'\r\n')
        if aux == -1:
            return ''
        return head[:aux].decode(errors='ignore')

    def connect_target(self, host):
        i = host.find(':')
        if i != -1:
            port = int(host[i + 1:])
            host = host[:i]
        else:
            port = 22
        (soc_family, soc_type, proto, _, address) = socket.getaddrinfo(host, port)[0]
        self.target = socket.socket(soc_family, soc_type, proto)
        self.target_closed = False
        self.target.connect(address)

    def method_connect(self, path):
        self.log += ' - CONNECT ' + path
        self.connect_target(path)
        self.client.sendall(RESPONSE)
        self.client_buffer = b''
        self.server.print_log(self.log)
        self.do_connect()

    def do_connect(self):
        socs = [self.client, self.target]
        count = 0
        error = False
        while True:
            count += 1
            recv, _, err = select.select(socs, [], socs, 3)
            if err:
                error = True
            if recv:
                for in_ in recv:
                    try:
                        data = in_.recv(BUFLEN)
                        if data:
                            if in_ is self.target:
                                self.client.send(data)
                            else:
                                while data:
                                    sent = self.target.send(data)
                                    data = data[sent:]
                            count = 0
                        else:
                            error = True
                            break
                    except Exception:
                        error = True
                        break
            if count == TIMEOUT:
                error = True
            if error:
                break


def print_usage():
    print('Usage: ws-dropbear.py -p <port>')
    print('       ws-dropbear.py -b <bindAddr> -p <port>')


def parse_args(argv):
    global LISTENING_ADDR, LISTENING_PORT
    try:
        opts, _ = getopt.getopt(argv, 'hb:p:', ['bind=', 'port='])
    except getopt.GetoptError:
        print_usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print_usage()
            sys.exit()
        elif opt in ('-b', '--bind'):
            LISTENING_ADDR = arg
        elif opt in ('-p', '--port'):
            LISTENING_PORT = int(arg)


def main():
    print('\n:------- WS-Dropbear Proxy -------:')
    print('Listening addr: ' + LISTENING_ADDR)
    print('Listening port: ' + str(LISTENING_PORT))
    print('Default backend: ' + DEFAULT_HOST)
    print(':----------------------------------:\n')
    server = Server(LISTENING_ADDR, LISTENING_PORT)
    server.start()
    while True:
        try:
            time.sleep(2)
        except KeyboardInterrupt:
            print('Stopping...')
            server.close()
            break


if __name__ == '__main__':
    parse_args(sys.argv[1:])
    main()
PYEOF
    chmod +x "$WS_DROPBEAR_SCRIPT"

    echo -e "${C_BLUE}📝 Creating systemd service file...${C_RESET}"
    cat > "$WS_DROPBEAR_SERVICE_FILE" <<EOF
[Unit]
Description=WS-Dropbear WebSocket to SSH Proxy
After=network.target sshd.service

[Service]
Type=simple
User=root
ExecStart=/usr/bin/python3 $WS_DROPBEAR_SCRIPT -b 127.0.0.1 -p $ws_port
Restart=always
RestartSec=3
StandardOutput=null
StandardError=null

[Install]
WantedBy=multi-user.target
EOF

    echo "WS_PORT=$ws_port" > "$WS_DROPBEAR_CONFIG_FILE"

    echo -e "\n${C_GREEN}🚀 Starting WS-Dropbear Service...${C_RESET}"
    systemctl daemon-reload
    systemctl enable ws-dropbear.service &>/dev/null
    systemctl start ws-dropbear.service

    if systemctl is-active --quiet ws-dropbear.service; then
        echo -e "\n${C_GREEN}✅ WS-Dropbear Installed Successfully!${C_RESET}"
        echo -e "   - Internal Port (loopback only): ${C_WHITE}$ws_port${C_RESET} (forwards to local SSH on 127.0.0.1:22)"
        echo -e "   ${C_DIM}Not exposed on any public port, so it never conflicts with HAProxy edge (${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT}) or Nginx.${C_RESET}"
        echo -e "   ${C_DIM}Clients connect through the edge using the payload path /${ws_port}/ instead of a raw port, e.g.:${C_RESET}"
        echo -e "   ${C_WHITE}   Host: yourdomain.com   Path: /$ws_port/   Port: ${EDGE_PUBLIC_TLS_PORT} (or ${EDGE_PUBLIC_HTTP_PORT})${C_RESET}"
    else
        echo -e "\n${C_RED}❌ WS-Dropbear service failed to start. Check logs: journalctl -u ws-dropbear.service${C_RESET}"
    fi
}

uninstall_ws_dropbear() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🗑️ Uninstall WS-Dropbear ---${C_RESET}"

    if [ ! -f "$WS_DROPBEAR_SERVICE_FILE" ] && [ ! -f "$WS_DROPBEAR_SCRIPT" ]; then
        echo -e "\n${C_YELLOW}ℹ️ WS-Dropbear does not appear to be installed.${C_RESET}"
        return
    fi

    read -p "👉 Are you sure you want to uninstall WS-Dropbear? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then echo -e "${C_YELLOW}Cancelled.${C_RESET}"; return; fi

    echo -e "\n${C_BLUE}🛑 Stopping service...${C_RESET}"
    systemctl stop ws-dropbear.service 2>/dev/null
    systemctl disable ws-dropbear.service 2>/dev/null

    rm -f "$WS_DROPBEAR_SERVICE_FILE" "$WS_DROPBEAR_SCRIPT" "$WS_DROPBEAR_CONFIG_FILE"
    systemctl daemon-reload

    echo -e "\n${C_GREEN}✅ WS-Dropbear has been uninstalled.${C_RESET}"
}

protocol_menu() {
    while true; do
        show_banner
        local badvpn_status; if systemctl is-active --quiet badvpn; then badvpn_status="${C_STATUS_A}(Active)${C_RESET}"; else badvpn_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        local udp_custom_status; if systemctl is-active --quiet udp-custom; then udp_custom_status="${C_STATUS_A}(Active)${C_RESET}"; else udp_custom_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        local zivpn_status; if systemctl is-active --quiet zivpn.service; then zivpn_status="${C_STATUS_A}(Active)${C_RESET}"; else zivpn_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        local ws_dropbear_status; if systemctl is-active --quiet ws-dropbear.service; then ws_dropbear_status="${C_STATUS_A}(Active)${C_RESET}"; else ws_dropbear_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        local slipstream_status; if systemctl is-active --quiet slipstream-rust-server.service; then slipstream_status="${C_STATUS_A}(Active)${C_RESET}"; else slipstream_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        
        local ssl_tunnel_text="HAProxy Edge Stack (80/443)"
        local ssl_tunnel_status="${C_STATUS_I}(Inactive)${C_RESET}"
        if systemctl is-active --quiet haproxy; then
            ssl_tunnel_status="${C_STATUS_A}(Active)${C_RESET}"
        fi
        
        local dnstt_status; if systemctl is-active --quiet dnstt-server.service || systemctl is-active --quiet dnstt.service; then dnstt_status="${C_STATUS_A}(Active)${C_RESET}"; else dnstt_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        
        local falconproxy_status="${C_STATUS_I}(Inactive)${C_RESET}"
        local falconproxy_ports=""
        if systemctl is-active --quiet falconproxy; then
            if [ -f "$FALCONPROXY_CONFIG_FILE" ]; then source "$FALCONPROXY_CONFIG_FILE"; fi
            falconproxy_ports=" ($PORTS)"
            falconproxy_status="${C_STATUS_A}(Active - ${INSTALLED_VERSION:-latest})${C_RESET}"
        fi

        local nginx_status; if systemctl is-active --quiet nginx; then nginx_status="${C_STATUS_A}(Active)${C_RESET}"; else nginx_status="${C_STATUS_I}(Inactive)${C_RESET}"; fi
        local xui_status; if command -v x-ui &> /dev/null; then xui_status="${C_STATUS_A}(Installed)${C_RESET}"; else xui_status="${C_STATUS_I}(Not Installed)${C_RESET}"; fi  # 3X-UI uses same 'x-ui' binary name
        
        echo -e "\n   ${C_TITLE}══════════════[ ${C_BOLD}🔌 PROTOCOL & PANEL MANAGEMENT ${C_RESET}${C_TITLE}]══════════════${C_RESET}"
        echo -e "     ${C_ACCENT}--- TUNNELLING PROTOCOLS---${C_RESET}"
        printf "     ${C_CHOICE}[ 1]${C_RESET} %-45s %s\n" "🚀 Install badvpn (UDP 7300)" "$badvpn_status"
        printf "     ${C_CHOICE}[ 2]${C_RESET} %-45s\n" "🗑️ Uninstall badvpn"
        printf "     ${C_CHOICE}[ 3]${C_RESET} %-45s %s\n" "🚀 Install udp-custom" "$udp_custom_status"
        printf "     ${C_CHOICE}[ 4]${C_RESET} %-45s\n" "🗑️ Uninstall udp-custom"
        printf "     ${C_CHOICE}[ 5]${C_RESET} %-45s %s\n" "🔒 Install ${ssl_tunnel_text}" "$ssl_tunnel_status"
        printf "     ${C_CHOICE}[ 6]${C_RESET} %-45s\n" "🗑️ Uninstall HAProxy Edge Stack"
        printf "     ${C_CHOICE}[ 7]${C_RESET} %-45s %s\n" "📡 DNSTT (dnstt-deploy, port 53)" "$dnstt_status"
        printf "     ${C_CHOICE}[ 8]${C_RESET} %-45s\n" "🗑️ Uninstall DNSTT"
        printf "     ${C_CHOICE}[ 9]${C_RESET} %-45s %s\n" "🔥 Install Gost Proxy (Latest Version)" "$falconproxy_status"
        printf "     ${C_CHOICE}[10]${C_RESET} %-45s\n" "🗑️ Uninstall Gost Proxy"
        printf "     ${C_CHOICE}[11]${C_RESET} %-45s %s\n" "🌐 Install/Manage Internal Nginx (8880/8443)" "$nginx_status"
        printf "     ${C_CHOICE}[14]${C_RESET} %-45s %s\n" "🛡️ Install ZiVPN (UDP 5667)" "$zivpn_status"
        printf "     ${C_CHOICE}[15]${C_RESET} %-45s\n" "🗑️ Uninstall ZiVPN"
        printf "     ${C_CHOICE}[16]${C_RESET} %-45s %s\n" "🌐 Install WS-Dropbear (WS -> SSH)" "$ws_dropbear_status"
        printf "     ${C_CHOICE}[17]${C_RESET} %-45s\n" "🗑️ Uninstall WS-Dropbear"
        printf "     ${C_CHOICE}[18]${C_RESET} %-45s %s\n" "📡 slipstream-rust (DNS Tunnel, Port 53)" "$slipstream_status"
        printf "     ${C_CHOICE}[19]${C_RESET} %-45s\n" "🗑️ Uninstall slipstream-rust"
        
        echo -e "     ${C_ACCENT}--- 💻 MANAGEMENT PANELS ---${C_RESET}"
        printf "     ${C_CHOICE}[12]${C_RESET} %-45s %s\n" "💻 Install X-UI / 3X-UI Panel" "$xui_status"
        printf "     ${C_CHOICE}[13]${C_RESET} %-45s\n" "🗑️ Uninstall X-UI / 3X-UI Panel"
        
        echo -e "   ${C_DIM}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${C_RESET}"
        echo -e "     ${C_WARN}[ 0]${C_RESET} ↩️ Return"
        echo
        if ! read -r -p "$(echo -e ${C_PROMPT}"👉 Select an option: "${C_RESET})" choice; then
            echo
            return
        fi
        case $choice in
            1) install_badvpn; press_enter ;; 2) uninstall_badvpn; press_enter ;;
            3) install_udp_custom; press_enter ;; 4) uninstall_udp_custom; press_enter ;;
            5) install_ssl_tunnel; press_enter ;; 6) uninstall_ssl_tunnel; press_enter ;;
            7) run_dnstt_v2; press_enter ;; 8) uninstall_dnstt_v2; press_enter ;;
            9) install_falcon_proxy; press_enter ;; 10) uninstall_falcon_proxy; press_enter ;;
            11) nginx_proxy_menu ;;
            12) install_panel_menu; press_enter ;; 13) uninstall_xui_panel; press_enter ;;
            14) install_zivpn; press_enter ;; 15) uninstall_zivpn; press_enter ;;
            16) install_ws_dropbear; press_enter ;; 17) uninstall_ws_dropbear; press_enter ;;
            18) run_slipstream_v2; press_enter ;; 19) uninstall_slipstream_v2; press_enter ;;
            0) return ;;
            *) invalid_option ;;
        esac
    done
}


# ====================================================================
# --- Web Control Panel Functions ---
# ====================================================================

install_web_panel() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🌐 Installing Web Control Panel ---${C_RESET}"
    
    if [ -f "$PANEL_SERVICE_FILE" ]; then
        echo -e "\n${C_YELLOW}ℹ️ Web Panel is already installed.${C_RESET}"
        show_panel_credentials
        return
    fi
    
    # Check Python 3
    if ! command -v python3 &>/dev/null; then
        echo -e "${C_RED}❌ Python 3 is required but not installed.${C_RESET}"
        echo -e "${C_YELLOW}Installing python3...${C_RESET}"
        ff_pkg_install python3 || { echo -e "${C_RED}❌ Failed to install python3.${C_RESET}"; return; }
    fi
    
    echo -e "${C_BLUE}🔎 Checking if port $PANEL_PORT is available...${C_RESET}"
    check_and_free_ports "$PANEL_PORT" || return
    check_and_open_firewall_port "$PANEL_PORT" tcp || return
    
    # Generate random credentials and secret URL path
    local panel_user
    panel_user=$(tr -dc 'a-z' < /dev/urandom | head -c 4)$(tr -dc '0-9' < /dev/urandom | head -c 4)
    local panel_pass
    panel_pass=$(tr -dc 'A-Za-z0-9@#$' < /dev/urandom | head -c 16)
    local panel_pass_hash
    panel_pass_hash=$(echo -n "$panel_pass" | sha256sum | awk '{print $1}')
    local panel_secret
    panel_secret="panel_$(tr -dc 'a-z0-9' < /dev/urandom | head -c 8)"
    
    echo -e "${C_BLUE}📥 Downloading panel files...${C_RESET}"
    mkdir -p "$PANEL_HTML_DIR"
    
    # Download backend
    curl -sL "$PANEL_REPO_BASE/panel.py" -o "$PANEL_SCRIPT"
    if [ $? -ne 0 ] || [ ! -s "$PANEL_SCRIPT" ]; then
        echo -e "${C_RED}❌ Failed to download panel backend.${C_RESET}"
        return
    fi
    chmod +x "$PANEL_SCRIPT"
    sed -i 's/\r$//' "$PANEL_SCRIPT" 2>/dev/null
    
    # Download frontend
    curl -sL "$PANEL_REPO_BASE/index.html" -o "$PANEL_HTML_FILE"
    if [ $? -ne 0 ] || [ ! -s "$PANEL_HTML_FILE" ]; then
        echo -e "${C_RED}❌ Failed to download panel frontend.${C_RESET}"
        return
    fi
    
    # Save credentials
    cat > "$PANEL_CONF" <<-PEOF
PANEL_USER="$panel_user"
PANEL_PASS_HASH="$panel_pass_hash"
PANEL_PASS_PLAIN="$panel_pass"
PANEL_SECRET="$panel_secret"
PEOF
    chmod 600 "$PANEL_CONF"
    
    # Create systemd service
    cat > "$PANEL_SERVICE_FILE" <<-SEOF
[Unit]
Description=Hotscript Web Control Panel
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
ExecStart=/usr/bin/python3 $PANEL_SCRIPT
Restart=always
RestartSec=5
Nice=10
MemoryHigh=64M
MemoryMax=96M
Environment=PANEL_PORT=$PANEL_PORT

[Install]
WantedBy=multi-user.target
SEOF
    
    systemctl daemon-reload
    systemctl enable firewallfalcon-panel &>/dev/null
    systemctl start firewallfalcon-panel &>/dev/null
    sleep 2
    
    if systemctl is-active --quiet firewallfalcon-panel; then
        local server_ip
        server_ip=$(curl -s -4 --max-time 3 icanhazip.com 2>/dev/null || echo "YOUR_SERVER_IP")
        
        clear; show_banner
        echo -e "${C_GREEN}=====================================================${C_RESET}"
        echo -e "${C_GREEN}     ✅ Web Control Panel Installed Successfully!     ${C_RESET}"
        echo -e "${C_GREEN}=====================================================${C_RESET}"
        echo -e "\n${C_CYAN}  🌐 Panel URL:${C_RESET}    ${C_YELLOW}http://${server_ip}:${PANEL_PORT}/${panel_secret}${C_RESET}"
        echo -e "${C_CYAN}  👤 Username:${C_RESET}     ${C_YELLOW}${panel_user}${C_RESET}"
        echo -e "${C_CYAN}  🔑 Password:${C_RESET}     ${C_YELLOW}${panel_pass}${C_RESET}"
        echo -e "${C_CYAN}  🔐 Secret Path:${C_RESET}   ${C_YELLOW}/${panel_secret}${C_RESET}"
        echo -e "\n${C_DIM}  Save these credentials! You can view them later from option [21] > [3].${C_RESET}"
    else
        echo -e "\n${C_RED}❌ Panel service failed to start. Checking logs:${C_RESET}"
        journalctl -u firewallfalcon-panel -n 15 --no-pager
    fi
}

uninstall_web_panel() {
    if [ ! -f "$PANEL_SERVICE_FILE" ]; then
        if [[ "$UNINSTALL_MODE" != "silent" ]]; then
            echo -e "${C_YELLOW}ℹ️ Web Panel is not installed.${C_RESET}"
        fi
        return
    fi
    
    if [[ "$UNINSTALL_MODE" != "silent" ]]; then
        echo -e "\n${C_BOLD}${C_PURPLE}--- 🗑️ Uninstalling Web Control Panel ---${C_RESET}"
        read -p "👉 Are you sure you want to uninstall the Web Panel? (y/n): " confirm
        if [[ "$confirm" != "y" ]]; then
            echo -e "\n${C_YELLOW}❌ Uninstallation cancelled.${C_RESET}"
            return
        fi
    fi
    
    echo -e "${C_BLUE}🛑 Stopping and removing Web Panel service...${C_RESET}"
    systemctl stop firewallfalcon-panel &>/dev/null
    systemctl disable firewallfalcon-panel &>/dev/null
    rm -f "$PANEL_SERVICE_FILE"
    rm -f "$PANEL_SCRIPT"
    rm -rf "$PANEL_HTML_DIR"
    rm -f "$PANEL_CONF"
    systemctl daemon-reload
    
    echo -e "${C_GREEN}✅ Web Panel has been uninstalled.${C_RESET}"
}

show_panel_credentials() {
    if [ ! -f "$PANEL_CONF" ]; then
        echo -e "\n${C_YELLOW}ℹ️ Web Panel is not installed.${C_RESET}"
        return
    fi
    
    source "$PANEL_CONF"
    local server_ip secret_suffix
    server_ip=$(curl -s -4 --max-time 3 icanhazip.com 2>/dev/null || echo "YOUR_SERVER_IP")
    secret_suffix=""
    if [[ -n "$PANEL_SECRET" ]]; then
        secret_suffix="/${PANEL_SECRET}"
    fi
    
    echo -e "\n${C_GREEN}=====================================================${C_RESET}"
    echo -e "${C_GREEN}         🌐 Web Panel Credentials                    ${C_RESET}"
    echo -e "${C_GREEN}=====================================================${C_RESET}"
    echo -e "\n${C_CYAN}  🌐 Panel URL:${C_RESET}    ${C_YELLOW}http://${server_ip}:${PANEL_PORT}${secret_suffix}${C_RESET}"
    echo -e "${C_CYAN}  👤 Username:${C_RESET}     ${C_YELLOW}${PANEL_USER}${C_RESET}"
    echo -e "${C_CYAN}  🔑 Password:${C_RESET}     ${C_YELLOW}${PANEL_PASS_PLAIN}${C_RESET}"
    if [[ -n "$PANEL_SECRET" ]]; then
        echo -e "${C_CYAN}  🔐 Secret Path:${C_RESET}   ${C_YELLOW}/${PANEL_SECRET}${C_RESET}"
    fi
    
    if systemctl is-active --quiet firewallfalcon-panel 2>/dev/null; then
        echo -e "\n${C_CYAN}  📡 Status:${C_RESET}       ${C_GREEN}🟢 Running${C_RESET}"
    else
        echo -e "\n${C_CYAN}  📡 Status:${C_RESET}       ${C_RED}🔴 Stopped${C_RESET}"
    fi
}

change_panel_credentials() {
    if [ ! -f "$PANEL_CONF" ]; then
        echo -e "\n${C_YELLOW}ℹ️ Web Panel is not installed.${C_RESET}"
        return
    fi
    
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🔑 Change Web Panel Credentials & Secret Path ---${C_RESET}"
    show_panel_credentials
    
    echo ""
    read -p "👉 Enter new username (or press Enter to keep current): " new_user
    read -p "🔑 Enter new password (or press Enter to auto-generate): " new_pass
    read -p "🔐 Enter new secret URL path (e.g., secret123, or press Enter to keep): " new_secret
    
    source "$PANEL_CONF"
    
    if [[ -z "$new_user" ]]; then
        new_user="$PANEL_USER"
    fi
    if [[ -z "$new_pass" ]]; then
        new_pass=$(tr -dc 'A-Za-z0-9@#$' < /dev/urandom | head -c 16)
        echo -e "${C_GREEN}🔑 Auto-generated password: ${C_YELLOW}$new_pass${C_RESET}"
    fi
    if [[ -z "$new_secret" ]]; then
        new_secret="${PANEL_SECRET:-panel_$(tr -dc 'a-z0-9' < /dev/urandom | head -c 8)}"
    fi
    new_secret=$(echo "$new_secret" | sed 's/^\///')
    
    local new_hash
    new_hash=$(echo -n "$new_pass" | sha256sum | awk '{print $1}')
    
    cat > "$PANEL_CONF" <<-PEOF
PANEL_USER="$new_user"
PANEL_PASS_HASH="$new_hash"
PANEL_PASS_PLAIN="$new_pass"
PANEL_SECRET="$new_secret"
PEOF
    chmod 600 "$PANEL_CONF"
    
    systemctl restart firewallfalcon-panel &>/dev/null
    echo -e "\n${C_GREEN}✅ Panel credentials & secret path updated!${C_RESET}"
    echo -e "  ${C_CYAN}👤 Username:${C_RESET}    ${C_YELLOW}$new_user${C_RESET}"
    echo -e "  ${C_CYAN}🔑 Password:${C_RESET}    ${C_YELLOW}$new_pass${C_RESET}"
    echo -e "  ${C_CYAN}🔐 Secret Path:${C_RESET}  ${C_YELLOW}/$new_secret${C_RESET}"
}

web_panel_menu() {
    while true; do
        clear; show_banner
        echo -e "${C_BOLD}${C_PURPLE}--- 🌐 Web Control Panel ---${C_RESET}\n"
        
        if [ -f "$PANEL_SERVICE_FILE" ]; then
            if systemctl is-active --quiet firewallfalcon-panel 2>/dev/null; then
                echo -e "  ${C_DIM}Status: ${C_GREEN}🟢 Installed & Running${C_RESET}\n"
            else
                echo -e "  ${C_DIM}Status: ${C_RED}🔴 Installed but Stopped${C_RESET}\n"
            fi
        else
            echo -e "  ${C_DIM}Status: ${C_YELLOW}⚪ Not Installed${C_RESET}\n"
        fi
        
        printf "  ${C_GREEN}[ 1]${C_RESET} %-35s\n" "🚀 Install Web Panel"
        printf "  ${C_GREEN}[ 2]${C_RESET} %-35s\n" "🗑️  Uninstall Web Panel"
        printf "  ${C_GREEN}[ 3]${C_RESET} %-35s\n" "🔑 Show Panel Credentials"
        printf "  ${C_GREEN}[ 4]${C_RESET} %-35s\n" "🔄 Change Panel Credentials"
        printf "  ${C_GREEN}[ 5]${C_RESET} %-35s\n" "🔃 Restart Panel Service"
        echo -e "\n  ${C_RED}[ 0]${C_RESET} ↩️  Back to Main Menu"
        echo
        
        read -r -p "👉 Enter your choice: " panel_choice
        case $panel_choice in
            1) install_web_panel; press_enter ;;
            2) uninstall_web_panel; press_enter ;;
            3) show_panel_credentials; press_enter ;;
            4) change_panel_credentials; press_enter ;;
            5)
                if [ -f "$PANEL_SERVICE_FILE" ]; then
                    systemctl restart firewallfalcon-panel &>/dev/null
                    sleep 1
                    if systemctl is-active --quiet firewallfalcon-panel; then
                        echo -e "\n${C_GREEN}✅ Web Panel service restarted successfully.${C_RESET}"
                    else
                        echo -e "\n${C_RED}❌ Failed to restart. Checking logs:${C_RESET}"
                        journalctl -u firewallfalcon-panel -n 10 --no-pager
                    fi
                else
                    echo -e "\n${C_YELLOW}ℹ️ Web Panel is not installed.${C_RESET}"
                fi
                press_enter
                ;;
            0) return ;;
            *) invalid_option ;;
        esac
    done
}

uninstall_script() {
    clear; show_banner
    echo -e "${C_RED}=====================================================${C_RESET}"
    echo -e "${C_RED}       🔥 DANGER: UNINSTALL SCRIPT & ALL DATA 🔥      ${C_RESET}"
    echo -e "${C_RED}=====================================================${C_RESET}"
    echo -e "${C_YELLOW}This will PERMANENTLY remove this script and all its components, including:"
    echo -e " - The main command ($(command -v menu))"
    echo -e " - All configuration and user data ($DB_DIR)"
    echo -e " - The active limiter service ($LIMITER_SERVICE)"
    echo -e " - All installed services (badvpn, udp-custom, HAProxy Edge Stack, Nginx, DNSTT)"
    echo -e "\n${C_RED}This action is irreversible.${C_RESET}"
    echo ""
    read -p "👉 Type 'yes' to confirm and proceed with uninstallation: " confirm
    if [[ "$confirm" != "yes" ]]; then
        echo -e "\n${C_GREEN}✅ Uninstallation cancelled.${C_RESET}"
        return
    fi
    local -a removable_users=()
    local remove_users_confirm
    local remove_users_on_uninstall=false
    mapfile -t removable_users < <(get_firewallfalcon_known_users)
    if [[ ${#removable_users[@]} -gt 0 ]]; then
        echo -e "\n${C_YELLOW}Hotscript SSH users detected on this VPS:${C_RESET} ${removable_users[*]}"
        read -p "👉 Do you also want to permanently delete these SSH users before uninstalling? (y/n): " remove_users_confirm
        if [[ "$remove_users_confirm" == "y" || "$remove_users_confirm" == "Y" ]]; then
            remove_users_on_uninstall=true
        fi
    fi
    export UNINSTALL_MODE="silent"
    echo -e "\n${C_BLUE}--- 💥 Starting Uninstallation 💥 ---${C_RESET}"
    
    if [[ "$remove_users_on_uninstall" == "true" ]]; then
        echo -e "\n${C_BLUE}🗑️ Removing Hotscript SSH users before uninstall...${C_RESET}"
        delete_firewallfalcon_user_accounts "${removable_users[@]}"
    fi
    
    echo -e "\n${C_BLUE}🗑️ Removing active limiter service...${C_RESET}"
    systemctl stop firewallfalcon-limiter &>/dev/null
    systemctl disable firewallfalcon-limiter &>/dev/null
    rm -f "$LIMITER_SERVICE"
    rm -f "$LIMITER_SCRIPT"
    
    echo -e "\n${C_BLUE}🗑️ Removing bandwidth monitoring service...${C_RESET}"
    systemctl stop firewallfalcon-bandwidth &>/dev/null
    systemctl disable firewallfalcon-bandwidth &>/dev/null
    rm -f "$BANDWIDTH_SERVICE"
    rm -f "$BANDWIDTH_SCRIPT"
    rm -rf "$LEGACY_BANDWIDTH_DIR"
    rm -f "$TRIAL_CLEANUP_SCRIPT"
    
    echo -e "\n${C_BLUE}\ud83d\uddd1\ufe0f Removing SSH login banner...${C_RESET}"
    rm -f "$LOGIN_INFO_SCRIPT"
    rm -f "$SSHD_FF_CONFIG"
    systemctl reload sshd 2>/dev/null || systemctl reload ssh 2>/dev/null
    
    chattr -i /etc/resolv.conf &>/dev/null

    purge_nginx "silent"
    uninstall_dnstt
    uninstall_dnstt_v2
    uninstall_slipstream_v2
    uninstall_badvpn
    uninstall_udp_custom
    uninstall_ssl_tunnel
    uninstall_falcon_proxy
    uninstall_zivpn
    uninstall_web_panel
    delete_dns_record
    
    echo -e "\n${C_BLUE}🔄 Reloading systemd daemon...${C_RESET}"
    systemctl daemon-reload
    
    echo -e "\n${C_BLUE}🗑️ Removing script and configuration files...${C_RESET}"
    rm -rf "$BADVPN_BUILD_DIR"
    rm -rf "$UDP_CUSTOM_DIR"
    rm -rf "$DB_DIR"
    rm -f "$(command -v menu)"
    
    echo -e "\n${C_GREEN}=============================================${C_RESET}"
    echo -e "${C_GREEN}      Script has been successfully uninstalled.     ${C_RESET}"
    echo -e "${C_GREEN}=============================================${C_RESET}"
    echo -e "\nAll associated files and services have been removed."
    echo "The 'menu' command will no longer work."
    exit 0
}

# --- NEW FEATURES ---

create_trial_account() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- ⏱️ Create Trial/Test Account ---${C_RESET}"
    
    # Ensure 'at' daemon is available
    if ! command -v at &>/dev/null; then
        echo -e "${C_YELLOW}⚠️ 'at' command not found. Installing...${C_RESET}"
        ff_pkg_install at >/dev/null 2>&1 || {
            echo -e "${C_RED}❌ Failed to install 'at'. Cannot schedule auto-expiry.${C_RESET}"
            return
        }
        systemctl enable atd &>/dev/null
        systemctl start atd &>/dev/null
    fi
    
    # Ensure atd is running
    if ! systemctl is-active --quiet atd; then
        systemctl start atd &>/dev/null
    fi
    
    echo -e "\n${C_CYAN}Select trial duration:${C_RESET}\n"
    printf "  ${C_GREEN}[ 1]${C_RESET} ⏱️  1 Hour\n"
    printf "  ${C_GREEN}[ 2]${C_RESET} ⏱️  2 Hours\n"
    printf "  ${C_GREEN}[ 3]${C_RESET} ⏱️  3 Hours\n"
    printf "  ${C_GREEN}[ 4]${C_RESET} ⏱️  6 Hours\n"
    printf "  ${C_GREEN}[ 5]${C_RESET} ⏱️  12 Hours\n"
    printf "  ${C_GREEN}[ 6]${C_RESET} 📅  1 Day\n"
    printf "  ${C_GREEN}[ 7]${C_RESET} 📅  3 Days\n"
    printf "  ${C_GREEN}[ 8]${C_RESET} ⚙️  Custom (enter hours)\n"
    echo -e "\n  ${C_RED}[ 0]${C_RESET} ↩️ Cancel"
    echo
    read -p "👉 Select duration: " dur_choice
    
    local duration_hours=0
    local duration_label=""
    case $dur_choice in
        1) duration_hours=1;   duration_label="1 Hour" ;;
        2) duration_hours=2;   duration_label="2 Hours" ;;
        3) duration_hours=3;   duration_label="3 Hours" ;;
        4) duration_hours=6;   duration_label="6 Hours" ;;
        5) duration_hours=12;  duration_label="12 Hours" ;;
        6) duration_hours=24;  duration_label="1 Day" ;;
        7) duration_hours=72;  duration_label="3 Days" ;;
        8) read -p "👉 Enter custom duration in hours: " custom_hours
           if ! [[ "$custom_hours" =~ ^[0-9]+$ ]] || [[ "$custom_hours" -lt 1 ]]; then
               echo -e "\n${C_RED}❌ Invalid number of hours.${C_RESET}"; return
           fi
           duration_hours=$custom_hours
           duration_label="$custom_hours Hours"
           ;;
        0) echo -e "\n${C_YELLOW}❌ Cancelled.${C_RESET}"; return ;;
        *) echo -e "\n${C_RED}❌ Invalid option.${C_RESET}"; return ;;
    esac
    
    # Username
    local rand_suffix=$(tr -dc 'a-z0-9' < /dev/urandom | head -c 5)
    local default_username="trial_${rand_suffix}"
    read -p "👤 Username [${default_username}]: " username
    username=${username:-$default_username}
    
    if id "$username" &>/dev/null || grep -q "^$username:" "$DB_FILE"; then
        echo -e "\n${C_RED}❌ Error: User '$username' already exists.${C_RESET}"; return
    fi
    
    # Password
    local password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
    read -p "🔑 Password [${password}]: " custom_pass
    password=${custom_pass:-$password}
    
    # Connection limit
    read -p "📶 Connection limit [1]: " limit
    limit=${limit:-1}
    if ! [[ "$limit" =~ ^[0-9]+$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    
    # Bandwidth limit
    read -p "📦 Bandwidth limit in GB (0 = unlimited) [0]: " bandwidth_gb
    bandwidth_gb=${bandwidth_gb:-0}
    if ! [[ "$bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    
    # Calculate expiry
    local expire_date
    if [[ "$duration_hours" -ge 24 ]]; then
        local days=$((duration_hours / 24))
        expire_date=$(date -d "+$days days" +%Y-%m-%d)
    else
        # For sub-day durations, set expiry to tomorrow to be safe (at job does the real cleanup)
        expire_date=$(date -d "+1 day" +%Y-%m-%d)
    fi
    local expiry_timestamp
    expiry_timestamp=$(date -d "+${duration_hours} hours" '+%Y-%m-%d %H:%M:%S')
    
    # Create the system user
    ensure_firewallfalcon_system_group
    useradd -m -s /usr/sbin/nologin "$username"
    usermod -aG "$FF_USERS_GROUP" "$username" 2>/dev/null
    echo "$username:$password" | chpasswd
    chage -E "$expire_date" "$username"
    echo "$username:$password:$expire_date:$limit:$bandwidth_gb:trial" >> "$DB_FILE"
    
    # Schedule auto-cleanup via 'at'
    echo "$TRIAL_CLEANUP_SCRIPT $username" | at now + ${duration_hours} hours 2>/dev/null
    
    local bw_display="Unlimited"
    if [[ "$bandwidth_gb" != "0" ]]; then bw_display="${bandwidth_gb} GB"; fi
    
    clear; show_banner
    echo -e "${C_GREEN}✅ Trial account created successfully!${C_RESET}\n"
    echo -e "${C_YELLOW}========================================${C_RESET}"
    echo -e "  ⏱️  ${C_BOLD}TRIAL ACCOUNT${C_RESET}"
    echo -e "${C_YELLOW}========================================${C_RESET}"
    echo -e "  - 👤 Username:          ${C_YELLOW}$username${C_RESET}"
    echo -e "  - 🔑 Password:          ${C_YELLOW}$password${C_RESET}"
    echo -e "  - ⏱️ Duration:          ${C_CYAN}$duration_label${C_RESET}"
    echo -e "  - 🕐 Auto-expires at:   ${C_RED}$expiry_timestamp${C_RESET}"
    echo -e "  - 📶 Connection Limit:  ${C_YELLOW}$limit${C_RESET}"
    echo -e "  - 📦 Bandwidth Limit:   ${C_YELLOW}$bw_display${C_RESET}"
    echo -e "${C_YELLOW}========================================${C_RESET}"
    echo -e "\n${C_DIM}The account will be automatically deleted when the trial expires.${C_RESET}"
    
    # Auto-ask for config generation
    echo
    read -p "👉 Generate client config for this trial user? (y/n): " gen_conf
    if [[ "$gen_conf" == "y" || "$gen_conf" == "Y" ]]; then
        generate_client_config "$username" "$password"
    fi
    
    invalidate_banner_cache
    refresh_dynamic_banner_routing_if_enabled
}

view_user_bandwidth() {
    _select_user_interface "--- 📊 View User Bandwidth ---"
    local u=$SELECTED_USER
    if [[ "$u" == "NO_USERS" || -z "$u" ]]; then return; fi
    
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📊 Bandwidth Details: ${C_YELLOW}$u${C_PURPLE} ---${C_RESET}\n"
    
    local line; line=$(grep "^$u:" "$DB_FILE")
    local _u _p _e _l bandwidth_gb
    IFS=: read -r _u _p _e _l bandwidth_gb _ <<< "$line"
    [[ -z "$bandwidth_gb" ]] && bandwidth_gb="0"
    
    local used_bytes=0
    if [[ -f "$BANDWIDTH_DIR/${u}.usage" ]]; then
        read -r used_bytes < "$BANDWIDTH_DIR/${u}.usage" 2>/dev/null || used_bytes=0
        [[ -z "$used_bytes" ]] && used_bytes=0
    fi
    
    local used_mb; used_mb=$(awk "BEGIN {printf \"%.2f\", $used_bytes / 1048576}")
    local used_gb; used_gb=$(awk "BEGIN {printf \"%.3f\", $used_bytes / 1073741824}")
    
    echo -e "  ${C_CYAN}Data Used:${C_RESET}        ${C_WHITE}${used_gb} GB${C_RESET} (${used_mb} MB)"
    
    if [[ "$bandwidth_gb" == "0" ]]; then
        echo -e "  ${C_CYAN}Bandwidth Limit:${C_RESET}  ${C_GREEN}Unlimited${C_RESET}"
        echo -e "  ${C_CYAN}Status:${C_RESET}           ${C_GREEN}No quota restrictions${C_RESET}"
    else
        local quota_bytes; quota_bytes=$(awk "BEGIN {printf \"%.0f\", $bandwidth_gb * 1073741824}")
        local percentage; percentage=$(awk "BEGIN {printf \"%.1f\", ($used_bytes / $quota_bytes) * 100}")
        local remaining_bytes; remaining_bytes=$((quota_bytes - used_bytes))
        if [[ "$remaining_bytes" -lt 0 ]]; then remaining_bytes=0; fi
        local remaining_gb; remaining_gb=$(awk "BEGIN {printf \"%.3f\", $remaining_bytes / 1073741824}")
        
        echo -e "  ${C_CYAN}Bandwidth Limit:${C_RESET}  ${C_YELLOW}${bandwidth_gb} GB${C_RESET}"
        echo -e "  ${C_CYAN}Remaining:${C_RESET}        ${C_WHITE}${remaining_gb} GB${C_RESET}"
        echo -e "  ${C_CYAN}Usage:${C_RESET}            ${C_WHITE}${percentage}%${C_RESET}"
        
        # Progress bar
        local bar_width=30
        local filled; filled=$(awk "BEGIN {printf \"%.0f\", ($percentage / 100) * $bar_width}")
        if [[ "$filled" -gt "$bar_width" ]]; then filled=$bar_width; fi
        local empty=$((bar_width - filled))
        local bar_color="$C_GREEN"
        if (( $(awk "BEGIN {print ($percentage > 80)}" ) )); then bar_color="$C_RED"
        elif (( $(awk "BEGIN {print ($percentage > 50)}" ) )); then bar_color="$C_YELLOW"
        fi
        printf "  ${C_CYAN}Progress:${C_RESET}         ${bar_color}["
        for ((i=0; i<filled; i++)); do printf "█"; done
        for ((i=0; i<empty; i++)); do printf "░"; done
        printf "]${C_RESET} ${percentage}%%\n"
        
        if [[ "$used_bytes" -ge "$quota_bytes" ]]; then
            echo -e "\n  ${C_RED}⚠️ USER HAS EXCEEDED BANDWIDTH QUOTA — ACCOUNT LOCKED${C_RESET}"
        fi
    fi
}

bulk_create_users() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 👥 Bulk Create Users ---${C_RESET}"
    
    read -p "👉 Enter username prefix (e.g., 'user'): " prefix
    if [[ -z "$prefix" ]]; then echo -e "\n${C_RED}❌ Prefix cannot be empty.${C_RESET}"; return; fi
    
    read -p "🔢 How many users to create? " count
    if ! [[ "$count" =~ ^[0-9]+$ ]] || [[ "$count" -lt 1 ]] || [[ "$count" -gt 100 ]]; then
        echo -e "\n${C_RED}❌ Invalid count (1-100).${C_RESET}"; return
    fi
    
    read -p "🗓️ Account duration (in days) [30]: " days
    days=${days:-30}
    if ! [[ "$days" =~ ^[0-9]+$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    
    read -p "📶 Connection limit per user [1]: " limit
    limit=${limit:-1}
    if ! [[ "$limit" =~ ^[0-9]+$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    
    read -p "📦 Bandwidth limit in GB per user (0 = unlimited) [0]: " bandwidth_gb
    bandwidth_gb=${bandwidth_gb:-0}
    if ! [[ "$bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    
    read -p "📦 DAILY bandwidth limit in GB per user (0 = unlimited) [0]: " daily_bandwidth_gb
    daily_bandwidth_gb=${daily_bandwidth_gb:-0}
    if ! [[ "$daily_bandwidth_gb" =~ ^[0-9]+\.?[0-9]*$ ]]; then echo -e "\n${C_RED}❌ Invalid number.${C_RESET}"; return; fi
    
    local expire_date
    expire_date=$(date -d "+$days days" +%Y-%m-%d)
    local bw_display="Unlimited"; [[ "$bandwidth_gb" != "0" ]] && bw_display="${bandwidth_gb} GB"
    local daily_bw_display="Unlimited"; [[ "$daily_bandwidth_gb" != "0" ]] && daily_bw_display="${daily_bandwidth_gb} GB/day"
    ensure_firewallfalcon_system_group
    
    echo -e "\n${C_BLUE}⚙️ Creating $count users with prefix '${prefix}'...${C_RESET}\n"
    echo -e "${C_YELLOW}================================================================${C_RESET}"
    printf "${C_BOLD}${C_WHITE}%-20s | %-15s | %-12s${C_RESET}\n" "USERNAME" "PASSWORD" "EXPIRES"
    echo -e "${C_YELLOW}----------------------------------------------------------------${C_RESET}"
    
    local created=0
    for ((i=1; i<=count; i++)); do
        local username="${prefix}${i}"
        if id "$username" &>/dev/null || grep -q "^$username:" "$DB_FILE"; then
            echo -e "${C_RED}  ⚠️ Skipping '$username' — already exists${C_RESET}"
            continue
        fi
        local password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 8)
        useradd -m -s /usr/sbin/nologin "$username"
        usermod -aG "$FF_USERS_GROUP" "$username" 2>/dev/null
        echo "$username:$password" | chpasswd
        chage -E "$expire_date" "$username"
        echo "$username:$password:$expire_date:$limit:$bandwidth_gb:$daily_bandwidth_gb:bulk" >> "$DB_FILE"
        printf "  ${C_GREEN}%-20s${C_RESET} | ${C_YELLOW}%-15s${C_RESET} | ${C_CYAN}%-12s${C_RESET}\n" "$username" "$password" "$expire_date"
        created=$((created + 1))
    done
    
    echo -e "${C_YELLOW}================================================================${C_RESET}"
    echo -e "\n${C_GREEN}✅ Created $created users. Conn Limit: ${limit} | Total BW: ${bw_display} | Daily BW: ${daily_bw_display}${C_RESET}"
    
    invalidate_banner_cache
    refresh_dynamic_banner_routing_if_enabled
}

generate_client_config() {
    local user=$1
    local pass=$2
    
    local host_ip=$(curl -s -4 icanhazip.com)
    local host_domain
    host_domain=$(detect_preferred_host)
    [[ -z "$host_domain" ]] && host_domain="$host_ip"

    echo -e "\n${C_BOLD}${C_PURPLE}--- 📱 Client Connection Configuration ---${C_RESET}"
    echo -e "${C_CYAN}Copy the details below to your clipboard:${C_RESET}\n"

    echo -e "${C_YELLOW}========================================${C_RESET}"
    echo -e "👤 ${C_BOLD}User Details${C_RESET}"
    echo -e "   • Username: ${C_WHITE}$user${C_RESET}"
    echo -e "   • Password: ${C_WHITE}$pass${C_RESET}"
    echo -e "   • Host/IP : ${C_WHITE}$host_domain${C_RESET}"
    echo -e "${C_YELLOW}========================================${C_RESET}"
    
    # 1. SSH Direct
    echo -e "\n🔹 ${C_BOLD}SSH Direct${C_RESET}:"
    echo -e "   • Host: $host_domain"
    echo -e "   • Port: 22"
    echo -e "   • payload: (Standard SSH)"

    # 2. HAProxy edge stack
    if systemctl is-active --quiet haproxy; then
        echo -e "\n🔹 ${C_BOLD}HAProxy Edge Stack${C_RESET}:"
        echo -e "   • Host: $host_domain"
        echo -e "   • Port 80: HTTP payloads / raw SSH"
        echo -e "   • Port 443: TLS / SNI / SSL payloads"
        echo -e "   • Internal handoff: Nginx ${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}"
        echo -e "   • SNI (BugHost): $host_domain (or your preferred SNI)"
    elif systemctl is-active --quiet nginx; then
        echo -e "\n🔹 ${C_BOLD}Internal Nginx Proxy${C_RESET}:"
        echo -e "   • Internal only: ${NGINX_INTERNAL_HTTP_PORT}/${NGINX_INTERNAL_TLS_PORT}"
        echo -e "   • Public clients should connect through HAProxy on ${EDGE_PUBLIC_HTTP_PORT}/${EDGE_PUBLIC_TLS_PORT}"
    fi

    # 3. UDP Custom
    if systemctl is-active --quiet udp-custom; then
        echo -e "\n🔹 ${C_BOLD}UDP Custom${C_RESET}:"
        echo -e "   • IP: $host_ip (Must use numeric IP)"
        echo -e "   • Port: 1-65535 (Exclude 53, 5300, 5301)"
        echo -e "   • Obfs: (None/Plain)"
    fi

    # 4. DNSTT
    if systemctl is-active --quiet dnstt; then
        if [ -f "$DNSTT_CONFIG_FILE" ]; then
            source "$DNSTT_CONFIG_FILE"
            echo -e "\n🔹 ${C_BOLD}DNSTT (SlowDNS)${C_RESET}:"
            echo -e "   • Nameserver: $TUNNEL_DOMAIN"
            echo -e "   • PubKey: $PUBLIC_KEY"
            echo -e "   • DNS IP: 1.1.1.1 / 8.8.8.8"
        fi
    fi
    
    # 5. ZiVPN
    if systemctl is-active --quiet zivpn; then
        echo -e "\n🔹 ${C_BOLD}ZiVPN${C_RESET}:"
        echo -e "   • UDP Port: 5667"
        echo -e "   • Forwarded Ports: 6000-19999"
    fi
    
    echo -e "${C_YELLOW}========================================${C_RESET}"

}

client_config_menu() {
    _select_user_interface "--- 📱 Generate Client Config ---"
    local u=$SELECTED_USER
    if [[ "$u" == "NO_USERS" || -z "$u" ]]; then return; fi
    
    # We need to find the password. It's in the DB.
    local pass=$(grep "^$u:" "$DB_FILE" | cut -d: -f2)
    generate_client_config "$u" "$pass"
}

format_rate_from_kbps() {
    local kbps=${1:-0}
    if (( kbps >= 1024 )); then
        printf "%d.%02d MB/s" $((kbps / 1024)) $((((kbps % 1024) * 100) / 1024))
    else
        printf "%d KB/s" "$kbps"
    fi
}

# Lightweight Bash Monitor (No vnStat required)
simple_live_monitor() {
    local iface=$1
    local rx_file="/sys/class/net/$iface/statistics/rx_bytes"
    local tx_file="/sys/class/net/$iface/statistics/tx_bytes"
    local interval=2
    local stop_monitor=0
    local rx1 tx1 rx2 tx2 rx_diff tx_diff rx_kbs tx_kbs rx_fmt tx_fmt

    if [[ -z "$iface" || ! -r "$rx_file" || ! -r "$tx_file" ]]; then
        echo -e "\n${C_RED}❌ Could not read interface statistics for '${iface:-unknown}'.${C_RESET}"
        return
    fi

    echo -e "\n${C_BLUE}⚡ Starting Lightweight Traffic Monitor for $iface...${C_RESET}"
    echo -e "${C_DIM}Press [Ctrl+C] to stop.${C_RESET}\n"

    read -r rx1 < "$rx_file"
    read -r tx1 < "$tx_file"

    printf "%-15s | %-15s\n" "⬇️ Download" "⬆️ Upload"
    echo "-----------------------------------"

    trap 'stop_monitor=1' INT TERM
    while (( ! stop_monitor )); do
        sleep "$interval"
        read -r rx2 < "$rx_file" || break
        read -r tx2 < "$tx_file" || break

        rx_diff=$((rx2 - rx1))
        tx_diff=$((tx2 - tx1))
        (( rx_diff < 0 )) && rx_diff=0
        (( tx_diff < 0 )) && tx_diff=0

        rx_kbs=$((rx_diff / 1024 / interval))
        tx_kbs=$((tx_diff / 1024 / interval))
        rx_fmt=$(format_rate_from_kbps "$rx_kbs")
        tx_fmt=$(format_rate_from_kbps "$tx_kbs")

        printf "\r%-15s | %-15s" "$rx_fmt" "$tx_fmt"

        rx1=$rx2
        tx1=$tx2
    done
    trap - INT TERM
    echo
}

traffic_monitor_menu() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 📈 Network Traffic Monitor ---${C_RESET}"
    
    # Find active interface
    local iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
    
    echo -e "\nInterface: ${C_CYAN}${iface}${C_RESET}"
    
    echo -e "\n${C_BOLD}Select a monitoring option:${C_RESET}\n"
    printf "  ${C_CHOICE}[ 1]${C_RESET} %-40s\n" "⚡ Live Monitor ${C_DIM}(Lightweight, No Install)${C_RESET}"
    printf "  ${C_CHOICE}[ 2]${C_RESET} %-40s\n" "📊 View Total Traffic Since Boot"
    printf "  ${C_CHOICE}[ 3]${C_RESET} %-40s\n" "📅 Daily/Monthly Logs ${C_DIM}(Requires vnStat)${C_RESET}"
    
    echo -e "\n  ${C_WARN}[ 0]${C_RESET} ↩️ Return"
    echo
    read -p "👉 Enter choice: " t_choice
    case $t_choice in
        1) 
           simple_live_monitor "$iface"
           ;;
        2)
            local rx_total=$(cat /sys/class/net/$iface/statistics/rx_bytes)
            local tx_total=$(cat /sys/class/net/$iface/statistics/tx_bytes)
            local rx_mb=$((rx_total / 1024 / 1024))
            local tx_mb=$((tx_total / 1024 / 1024))
            echo -e "\n${C_BLUE}📊 Total Traffic (Since Boot):${C_RESET}"
            echo -e "   ⬇️ Download: ${C_WHITE}${rx_mb} MB${C_RESET}"
            echo -e "   ⬆️ Upload:   ${C_WHITE}${tx_mb} MB${C_RESET}"
            press_enter
            ;;
        3) 
           # vnStat Logic
           if ! command -v vnstat &> /dev/null; then
               echo -e "\n${C_YELLOW}⚠️ vnStat is not installed.${C_RESET}"
               echo -e "   This tool provides persistent history (Daily/Monthly reports)."
               echo -e "   It is lightweight but requires installation."
               read -p "👉 Install vnStat now? (y/n): " confirm
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                     echo -e "\n${C_BLUE}📦 Installing vnStat...${C_RESET}"
                     ff_pkg_install vnstat >/dev/null 2>&1 || {
                         echo -e "${C_RED}❌ Failed to install vnStat.${C_RESET}"
                         sleep 1
                         return
                     }
                     systemctl enable vnstat >/dev/null 2>&1
                     systemctl restart vnstat >/dev/null 2>&1
                    local default_iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
                    vnstat --add -i "$default_iface" >/dev/null 2>&1
                    echo -e "${C_GREEN}✅ Installed.${C_RESET}"
                    sleep 1
               else
                    return
               fi
           fi
           echo
           vnstat -i "$iface"
           echo -e "\n${C_DIM}Run 'vnstat -d' or 'vnstat -m' manually for specific views.${C_RESET}"
           press_enter
           ;;
        *) return ;;
    esac
}

torrent_block_menu() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🚫 Torrent Blocking (Anti-Torrent) ---${C_RESET}"
    
    # Check status
    local torrent_status="${C_STATUS_I}Disabled${C_RESET}"
    if iptables -L FORWARD | grep -q "ipp2p"; then
         torrent_status="${C_STATUS_A}Enabled${C_RESET}"
    elif iptables -L OUTPUT | grep -q "BitTorrent"; then
         # Fallback check for string matching
         torrent_status="${C_STATUS_A}Enabled${C_RESET}"
    fi
    
    echo -e "\n${C_WHITE}Current Status: ${torrent_status}${C_RESET}"
    echo -e "${C_DIM}This feature uses iptables string matching to block common torrent keywords.${C_RESET}"
    
    echo -e "\n${C_BOLD}Select an action:${C_RESET}\n"
    printf "  ${C_CHOICE}[ 1]${C_RESET} %-40s\n" "🔒 Enable Torrent Blocking"
    printf "  ${C_CHOICE}[ 2]${C_RESET} %-40s\n" "🔓 Disable Torrent Blocking"
    echo -e "\n  ${C_WARN}[ 0]${C_RESET} ↩️ Return"
    echo
    read -p "👉 Enter choice: " b_choice
    
    case $b_choice in
        1)
            echo -e "\n${C_BLUE}🛡️ Applying Anti-Torrent rules...${C_RESET}"
            # Clean old rules first to avoid duplicates
            _flush_torrent_rules
            
            # Block Common Torrent Ports/Keywords
            # String matching using iptables extension
            iptables -A FORWARD -m string --string "BitTorrent" --algo bm -j DROP
            iptables -A FORWARD -m string --string "BitTorrent protocol" --algo bm -j DROP
            iptables -A FORWARD -m string --string "peer_id=" --algo bm -j DROP
            iptables -A FORWARD -m string --string ".torrent" --algo bm -j DROP
            iptables -A FORWARD -m string --string "announce.php?passkey=" --algo bm -j DROP
            iptables -A FORWARD -m string --string "torrent" --algo bm -j DROP
            iptables -A FORWARD -m string --string "info_hash" --algo bm -j DROP
            iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
            iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
            
            # Same for OUTPUT to be safe
            iptables -A OUTPUT -m string --string "BitTorrent" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "BitTorrent protocol" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "peer_id=" --algo bm -j DROP
            iptables -A OUTPUT -m string --string ".torrent" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "announce.php?passkey=" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "torrent" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "info_hash" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "get_peers" --algo bm -j DROP
            iptables -A OUTPUT -m string --string "find_node" --algo bm -j DROP
            
            # Attempt to save if iptables-persistent exists
            if ff_pkg_is_installed iptables-persistent &>/dev/null; then
                netfilter-persistent save &>/dev/null
            fi
            
            echo -e "${C_GREEN}✅ Torrent Blocking Enabled.${C_RESET}"
            press_enter
            ;;
        2)
            echo -e "\n${C_BLUE}🔓 Removing Anti-Torrent rules...${C_RESET}"
            _flush_torrent_rules
            if ff_pkg_is_installed iptables-persistent &>/dev/null; then
                netfilter-persistent save &>/dev/null
            fi
            echo -e "${C_GREEN}✅ Torrent Blocking Disabled.${C_RESET}"
            press_enter
            ;;
        *) return ;;
    esac
}

_flush_torrent_rules() {
    # Helper to remove rules containing specific strings
    # This is a bit brute-force but effective for this script's scope
    iptables -D FORWARD -m string --string "BitTorrent" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "BitTorrent protocol" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "peer_id=" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string ".torrent" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "announce.php?passkey=" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "torrent" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "info_hash" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "get_peers" --algo bm -j DROP 2>/dev/null
    iptables -D FORWARD -m string --string "find_node" --algo bm -j DROP 2>/dev/null

    iptables -D OUTPUT -m string --string "BitTorrent" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "BitTorrent protocol" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "peer_id=" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string ".torrent" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "announce.php?passkey=" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "torrent" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "info_hash" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "get_peers" --algo bm -j DROP 2>/dev/null
    iptables -D OUTPUT -m string --string "find_node" --algo bm -j DROP 2>/dev/null
}

ssh_banner_menu() {
    while true; do
        show_banner
        local banner_mode
        local banner_status
        banner_mode=$(get_ssh_banner_mode)
        case "$banner_mode" in
            dynamic) banner_status="${C_STATUS_A}Dynamic${C_RESET}" ;;
            static) banner_status="${C_STATUS_A}Static${C_RESET}" ;;
            *) banner_status="${C_STATUS_I}Disabled${C_RESET}" ;;
        esac

        echo -e "\n   ${C_TITLE}═════════════════[ ${C_BOLD}🎨 SSH BANNER MODE: ${banner_status} ${C_RESET}${C_TITLE}]═════════════════${C_RESET}"
        echo -e "${C_DIM}Static mode uses 'Banner $SSH_BANNER_FILE'. Dynamic mode shows per-user account info.${C_RESET}"
        printf "     ${C_CHOICE}[ 1]${C_RESET} %-40s\n" "✨ Enable Dynamic Account Banner"
        printf "     ${C_CHOICE}[ 2]${C_RESET} %-40s\n" "📋 Paste or Replace Static Banner"
        printf "     ${C_CHOICE}[ 3]${C_RESET} %-40s\n" "👁️ View Current Static Banner"
        printf "     ${C_CHOICE}[ 4]${C_RESET} %-40s\n" "📝 Preview Dynamic Banner"
        printf "     ${C_DANGER}[ 5]${C_RESET} %-40s\n" "🗑️ Disable All SSH Banners"
        echo -e "   ${C_DIM}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${C_RESET}"
        echo -e "     ${C_WARN}[ 0]${C_RESET} ↩️ Return"
        echo
        if ! read -r -p "$(echo -e ${C_PROMPT}"👉 Select an option: "${C_RESET})" choice; then
            echo
            return
        fi
        case $choice in
            1)
                if setup_ssh_login_info; then
                    echo -e "\n${C_GREEN}✅ Dynamic account banner enabled.${C_RESET}"
                    echo -e "${C_DIM}Users will now see their account info banner instead of the static banner.${C_RESET}"
                fi
                press_enter
                ;;
            2) set_ssh_banner_paste ;;
            3) view_ssh_banner ;;
            4) preview_dynamic_ssh_banner ;;
            5) remove_ssh_banner ;;
            0) return ;;
            *) echo -e "\n${C_RED}❌ Invalid option.${C_RESET}" && sleep 1 ;;
        esac
    done
}

auto_reboot_menu() {
    clear; show_banner
    echo -e "${C_BOLD}${C_PURPLE}--- 🔄 Auto-Reboot Management ---${C_RESET}"
    
    # Check status
    local cron_check=$(crontab -l 2>/dev/null | grep "systemctl reboot")
    local status="${C_STATUS_I}Disabled${C_RESET}"
    if [[ -n "$cron_check" ]]; then
        status="${C_STATUS_A}Active (Midnight)${C_RESET}"
    fi
    
    echo -e "\n${C_WHITE}Current Status: ${status}${C_RESET}"
    
    echo -e "\n${C_BOLD}Select an action:${C_RESET}\n"
    printf "  ${C_CHOICE}[ 1]${C_RESET} %-40s\n" "🕐 Enable Daily Reboot (00:00 midnight)"
    printf "  ${C_CHOICE}[ 2]${C_RESET} %-40s\n" "❌ Disable Auto-Reboot"
    echo -e "\n  ${C_WARN}[ 0]${C_RESET} ↩️ Return"
    echo
    read -p "👉 Enter choice: " r_choice
    
    case $r_choice in
        1)
            # Remove existing to prevent duplicates
            (crontab -l 2>/dev/null | grep -v "systemctl reboot") | crontab -
            # Add new job
            (crontab -l 2>/dev/null; echo "0 0 * * * systemctl reboot") | crontab -
            echo -e "\n${C_GREEN}✅ Auto-reboot scheduled for every day at 00:00.${C_RESET}"
            press_enter
            ;;
        2)
            (crontab -l 2>/dev/null | grep -v "systemctl reboot") | crontab -
            echo -e "\n${C_GREEN}✅ Auto-reboot disabled.${C_RESET}"
            press_enter
            ;;
        *) return ;;
    esac
}


press_enter() {
    echo -e "\nPress ${C_YELLOW}[Enter]${C_RESET} to return to the menu..." && read -r || true
}
invalid_option() {
    echo -e "\n${C_RED}❌ Invalid option.${C_RESET}" && sleep 1
}

main_menu() {
    while true; do
        export UNINSTALL_MODE="interactive"
        show_banner
        
        echo
        echo -e "   ${C_TITLE}═══════════════════[ ${C_BOLD}👤 USER MANAGEMENT ${C_RESET}${C_TITLE}]═══════════════════${C_RESET}"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "1" "✨ Create New User" "2" "🗑️  Delete User"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "3" "🔄 Renew User Account" "4" "🔒 Lock User Account"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "5" "🔓 Unlock User Account" "6" "✏️  Edit User Details"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "7" "📋 List Managed Users" "8" "📱 Generate Client Config"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "9" "⏱️  Create Trial Account" "10" "📊 View User Bandwidth"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "11" "👥 Bulk Create Users"
        
        echo
        echo -e "   ${C_TITLE}══════════════[ ${C_BOLD}🌐 VPN & PROTOCOLS ${C_RESET}${C_TITLE}]═══════════════${C_RESET}"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "12" "🔌 Protocol Manager" "13" "📈 Traffic Monitor (Lite)"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "14" "🚫 Block Torrent (Anti-P2P)"

        echo
        echo -e "   ${C_TITLE}══════════════[ ${C_BOLD}⚙️ SYSTEM SETTINGS ${C_RESET}${C_TITLE}]═══════════════${C_RESET}"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "15" "🌐 Free Domain (deSEC)" "16" "🎨 SSH Banner Config"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "17" "🔄 Auto-Reboot Task" "18" "💾 Backup User Data"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "19" "📥 Restore User Data" "20" "🧹 Cleanup Expired Users"
        printf "     ${C_CHOICE}[%2s]${C_RESET} %-28s\n" "21" "🌐 Web Control Panel"

        echo
        echo -e "   ${C_DANGER}═══════════════════[ ${C_BOLD}🔥 DANGER ZONE ${C_RESET}${C_DANGER}]═══════════════════${C_RESET}"
        echo -e "     ${C_DANGER}[99]${C_RESET} Uninstall Script             ${C_WARN}[ 0]${C_RESET} Exit"
        echo
        if ! read -r -p "$(echo -e ${C_PROMPT}"👉 Select an option: "${C_RESET})" choice; then
            echo
            exit 0
        fi
        case $choice in
            1) create_user; press_enter ;;
            2) delete_user; press_enter ;;
            3) renew_user; press_enter ;;
            4) lock_user; press_enter ;;
            5) unlock_user; press_enter ;;
            6) edit_user; press_enter ;;
            7) list_users; press_enter ;;
            8) client_config_menu; press_enter ;;
            9) create_trial_account; press_enter ;;
            10) view_user_bandwidth; press_enter ;;
            11) bulk_create_users; press_enter ;;
            
            12) protocol_menu ;;
            13) traffic_monitor_menu ;;
            14) torrent_block_menu ;;
            
            15) dns_menu; press_enter ;;
            16) ssh_banner_menu ;;
            17) auto_reboot_menu ;;
            18) backup_user_data; press_enter ;;
            19) restore_user_data; press_enter ;;
            20) cleanup_expired; press_enter ;;
            21) web_panel_menu ;;
            
            99) uninstall_script ;;
            0) exit 0 ;;
            *) invalid_option ;;
        esac
    done
}

if [[ "$1" == "--install-setup" ]]; then
    initial_setup
    exit 0
fi

require_interactive_terminal
sync_runtime_components_if_needed
main_menu
