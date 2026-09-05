#!/data/data/com.termux/files/usr/bin/bash

menu_automation() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         AUTOMATION & SCHEDULING               ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Install Cronie & Schedule Update          ║"
        echo "║  2. Add a Boot Script (Termux:Boot)           ║"
        echo "║  3. Backup Config Files                       ║"
        echo "║  4. Restore Config Files                      ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-4]: " sub_choice
        case $sub_choice in
            1) setup_cron ;;
            2) add_boot_script ;;
            3) backup_config ;;
            4) restore_config ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

setup_cron() {
    pkg install cronie -y
    crond
    echo "Adding daily update job at 3 AM..."
    (crontab -l 2>/dev/null; echo "0 3 * * * pkg update -y && pkg upgrade -y") | crontab -
    echo "✅ Cron installed and job added."
    read -p "Press Enter to continue..."
}

add_boot_script() {
    mkdir -p ~/.termux/boot
    read -p "Enter script name (e.g., my_script.sh): " scriptname
    cat > ~/.termux/boot/"$scriptname" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "Boot script running at $(date)" >> ~/boot.log
