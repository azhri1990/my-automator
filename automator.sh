#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# MY TERMUX AUTOMATOR – v1.0
# ==============================================

show_menu() {
    clear
    echo "===================================="
    echo "       MY TERMUX AUTOMATOR          "
    echo "===================================="
    echo "1. Install Developer Tools"
    echo "2. Show System Info"
    echo "3. Customize Terminal"
    echo "4. Launch Jarvis Assistant"
    echo "5. Exit"
    echo "===================================="
    read -p "Choose an option [1-5]: " choice
}

while true; do
    show_menu
    case $choice in
        1)
            echo "Installing Python, Node.js, Git..."
            pkg update -y && pkg install python nodejs git -y
            echo "✅ Done."
            read -p "Press Enter to continue..."
            ;;
        2)
            echo "Device Info:"
            pkg install termux-api -y 2>/dev/null
            termux-battery-status
            echo "IP: $(ifconfig wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}')"
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "Customizing terminal..."
            mkdir -p ~/.termux
            cat > ~/.termux/termux.properties << 'EOF'
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]
use-black-ui = true
EOF
            termux-reload-settings
            echo "✅ Terminal customized (dark theme + extra keys)."
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "Launching Jarvis (RehanIlyas)..."
            cd ~/jarvis-mega-repo/assistants/RehanIlyas-JARVIS && python main.py || echo "Error: Repo not found or missing dependencies."
            read -p "Press Enter to continue..."
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice."
            read -p "Press Enter to continue..."
            ;;
    esac
done
