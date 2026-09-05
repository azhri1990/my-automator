#!/data/data/com.termux/files/usr/bin/bash

menu_hardware() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         HARDWARE CONTROL (Termux:API)        ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Install Termux:API                        ║"
        echo "║  2. Show Battery Status                       ║"
        echo "║  3. Toggle Flashlight                         ║"
        echo "║  4. Take a Photo (camera)                     ║"
        echo "║  5. List Contacts                             ║"
        echo "║  6. Send SMS                                  ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-6]: " sub_choice
        case $sub_choice in
            1) pkg install termux-api -y ;;
            2) termux-battery-status ;;
            3) toggle_flashlight ;;
            4) take_photo ;;
            5) list_contacts ;;
            6) send_sms ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
        read -p "Press Enter to continue..."
    done
}

toggle_flashlight() {
    termux-torch on && echo "💡 Light ON" || echo "Failed (API not installed or permission denied)"
    read -p "Press Enter to turn OFF..."
    termux-torch off
}

take_photo() {
    termux-camera-photo -c 0 ~/photo_$(date +%s).jpg
    echo "✅ Photo saved to ~/photo_*.jpg"
}

list_contacts() {
    termux-contact-list | head -20
}

send_sms() {
    read -p "Enter phone number: " number
    read -p "Enter message: " message
    termux-sms-send -n "$number" "$message"
    echo "✅ SMS sent."
}
