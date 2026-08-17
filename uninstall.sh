#!/bin/bash
# One-shot uninstaller for the Hotscript (FirewallFalcon) manager.
# Runs the SAME uninstall_script() logic that's already inside menu.sh
# (badvpn, udp-custom, HAProxy edge stack, Nginx, DNSTT, Gost/Falcon Proxy,
# ZiVPN, web panel, limiter/bandwidth services, DB, and the `menu` command),
# just without needing to open the interactive menu first.
#
# Usage:
#   sudo bash uninstall.sh                # keep existing Hotscript SSH users
#   sudo bash uninstall.sh --delete-users  # also delete Hotscript SSH users

if [[ $EUID -ne 0 ]]; then
    echo "Error: this must be run as root (use: sudo bash uninstall.sh)"
    exit 1
fi

MENU_BIN="/usr/local/bin/menu"

# Allow pointing at a local menu.sh too, e.g.:
#   sudo bash uninstall.sh /path/to/menu.sh
if [[ -n "$1" && -f "$1" && "$1" != "--delete-users" ]]; then
    MENU_BIN="$1"
    shift
fi

if [[ ! -f "$MENU_BIN" ]]; then
    echo "Error: could not find the installed script at $MENU_BIN"
    echo "Pass its path manually: sudo bash uninstall.sh /path/to/menu.sh"
    exit 1
fi

DELETE_USERS="n"
if [[ "$1" == "--delete-users" ]]; then
    DELETE_USERS="y"
fi

echo "Loading uninstall routines from: $MENU_BIN"

# Pull out just the function/variable definitions (everything before the
# auto-run tail at the bottom of menu.sh), so sourcing it does NOT open
# the interactive menu.
TMP_FUNCS="$(mktemp)"
sed '/^if \[\[ "\$1" == "--install-setup" \]\]; then/,$d' "$MENU_BIN" > "$TMP_FUNCS"

# shellcheck disable=SC1090
source "$TMP_FUNCS"
rm -f "$TMP_FUNCS"

if ! declare -F uninstall_script >/dev/null; then
    echo "Error: uninstall_script() not found in $MENU_BIN (unexpected format)."
    exit 1
fi

echo "Running full uninstall (auto-confirmed, delete SSH users: $DELETE_USERS)..."
echo

# uninstall_script() asks: "Type 'yes' to confirm" then (if hotscript SSH
# users exist) "delete these SSH users too? (y/n)". Feed both answers.
printf 'yes\n%s\n' "$DELETE_USERS" | uninstall_script
