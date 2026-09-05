#!/data/data/com.termux/files/usr/bin/bash

menu_dev() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         DEVELOPMENT TOOLS                     ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Install Python & pip                      ║"
        echo "║  2. Install Node.js & npm                     ║"
        echo "║  3. Install Go                                ║"
        echo "║  4. Install Rust                              ║"
        echo "║  5. Install Clang (C/C++)                     ║"
        echo "║  6. Install MariaDB (SQL)                     ║"
        echo "║  7. Install proot-distro (Ubuntu)             ║"
        echo "║  8. Launch Ubuntu (proot)                     ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-8]: " sub_choice
        case $sub_choice in
            1) pkg install python -y && echo "✅ Python installed" ;;
            2) pkg install nodejs -y && echo "✅ Node.js installed" ;;
            3) pkg install golang -y && echo "✅ Go installed" ;;
            4) pkg install rust -y && echo "✅ Rust installed" ;;
            5) pkg install clang -y && echo "✅ Clang installed" ;;
            6) pkg install mariadb -y && echo "✅ MariaDB installed" ;;
            7) pkg install proot-distro -y && proot-distro install ubuntu ;;
            8) proot-distro login ubuntu ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
        read -p "Press Enter to continue..."
    done
}
