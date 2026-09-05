#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# MY TERMUX AUTOMATOR – ULTIMATE EDITION v2.0
# ==============================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/logs/automator.log"

# --- Logging function ---
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# --- Source all modules ---
for mod in "$SCRIPT_DIR"/modules/*.sh; do
    if [ -f "$mod" ]; then
        source "$mod"
        log "Loaded module: $(basename "$mod")"
    fi
done

# --- Main menu ---
show_main_menu() {
    clear
    echo "╔═══════════════════════════════════════════════╗"
    echo "║   MY TERMUX AUTOMATOR – ULTIMATE EDITION     ║"
    echo "╠═══════════════════════════════════════════════╣"
    echo "║  1. System Info & Maintenance                ║"
    echo "║  2. Development Tools                        ║"
    echo "║  3. Networking Tools                         ║"
    echo "║  4. Security & Privacy                       ║"
    echo "║  5. Terminal Customization                   ║"
    echo "║  6. Automation & Scheduling                  ║"
    echo "║  7. Hardware Control (Termux:API)            ║"
    echo "║  8. Jarvis Integration                       ║"
    echo "║  9. File & Media Utilities                   ║"
    echo "║  0. Exit                                     ║"
    echo "╚═══════════════════════════════════════════════╝"
    read -p "Choose an option [0-9]: " main_choice
}

# --- Sub‑menus (each calls a function from the respective module) ---
while true; do
    show_main_menu
    case $main_choice in
        1) menu_core ;;
        2) menu_dev ;;
        3) menu_network ;;
        4) menu_security ;;
        5) menu_custom ;;
        6) menu_automation ;;
        7) menu_hardware ;;
        8) menu_jarvis ;;
        9) menu_files ;;
        0) echo "Goodbye!"; log "Exited"; exit 0 ;;
        *) echo "Invalid option."; read -p "Press Enter to continue..." ;;
    esac
done
