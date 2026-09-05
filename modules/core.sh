#!/data/data/com.termux/files/usr/bin/bash

menu_core() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         SYSTEM & MAINTENANCE                  ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Show System Info (battery, storage, RAM) ║"
        echo "║  2. Update All Packages                       ║"
        echo "║  3. Clean Cache & Free Space                  ║"
        echo "║  4. List Installed Packages                   ║"
        echo "║  5. Show Device IP & Network Info             ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-5]: " sub_choice
        case $sub_choice in
            1) show_system_info ;;
            2) update_all ;;
            3) clean_cache ;;
            4) list_packages ;;
            5) show_network_info ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

show_system_info() {
    echo "=== SYSTEM INFO ==="
    echo "Battery: $(termux-battery-status 2>/dev/null | grep -E 'percentage|status' || echo 'API not installed')"
    echo "Storage: $(df -h /data | awk 'NR==2 {print $3 " used / " $2 " total (" $5 ")"}')"
    echo "RAM: $(free -m | awk '/Mem:/ {print $3 "MB used / " $2 "MB total"}')"
    echo "Uptime: $(uptime | awk '{print $3,$4}' | sed 's/,//')"
    read -p "Press Enter to continue..."
}

update_all() {
    echo "Updating packages..."
    pkg update -y && pkg upgrade -y
    echo "✅ Done."
    read -p "Press Enter to continue..."
}

clean_cache() {
    echo "Cleaning package caches..."
    pkg clean && apt autoclean
    echo "✅ Done."
    read -p "Press Enter to continue..."
}

list_packages() {
    echo "Installed packages:"
    pkg list-installed | less
}

show_network_info() {
    echo "=== NETWORK INFO ==="
    echo "Wi‑Fi IP: $(ifconfig wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' || echo 'Not connected')"
    echo "Mobile IP: $(ifconfig rmnet0 2>/dev/null | grep 'inet ' | awk '{print $2}' || echo 'Not active')"
    echo "Public IP: $(curl -s ifconfig.me || echo 'Could not fetch')"
    read -p "Press Enter to continue..."
}
