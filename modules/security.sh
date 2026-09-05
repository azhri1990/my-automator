#!/data/data/com.termux/files/usr/bin/bash

menu_security() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         SECURITY & PRIVACY                    ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Encrypt a File (GPG)                      ║"
        echo "║  2. Decrypt a File (GPG)                      ║"
        echo "║  3. Setup SSH Server                          ║"
        echo "║  4. Show SSH Connection Info                  ║"
        echo "║  5. Clear Bash History & Logs                 ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-5]: " sub_choice
        case $sub_choice in
            1) encrypt_file ;;
            2) decrypt_file ;;
            3) setup_ssh ;;
            4) show_ssh_info ;;
            5) wipe_privacy ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

encrypt_file() {
    pkg install gnupg -y 2>/dev/null
    read -p "Enter file path to encrypt: " filepath
    if [ -f "$filepath" ]; then
        gpg -c "$filepath"
        echo "✅ Encrypted: ${filepath}.gpg"
    else
        echo "File not found."
    fi
    read -p "Press Enter to continue..."
}

decrypt_file() {
    read -p "Enter .gpg file path: " filepath
    if [ -f "$filepath" ]; then
        gpg "$filepath"
        echo "✅ Decrypted."
    else
        echo "File not found."
    fi
    read -p "Press Enter to continue..."
}

setup_ssh() {
    pkg install openssh -y
    sshd
    echo "✅ SSH server started on port 8022."
    echo "Connect with: ssh -p 8022 $(whoami)@$(ifconfig wlan0 | grep 'inet ' | awk '{print $2}')"
    read -p "Press Enter to continue..."
}

show_ssh_info() {
    echo "SSH status: $(ps aux | grep sshd | grep -v grep > /dev/null && echo 'Running' || echo 'Stopped')"
    echo "IP: $(ifconfig wlan0 | grep 'inet ' | awk '{print $2}'):8022"
    read -p "Press Enter to continue..."
}

wipe_privacy() {
    echo "Clearing bash history, logs, and caches..."
    > ~/.bash_history
    rm -rf ~/logs/* 2>/dev/null
    pkg clean
    echo "✅ Privacy wiped."
    read -p "Press Enter to continue..."
}
