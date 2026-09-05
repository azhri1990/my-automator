#!/data/data/com.termux/files/usr/bin/bash

menu_network() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         NETWORKING TOOLS                      ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Install & Run Ngrok (tunnel)              ║"
        echo "║  2. Speed Test (speedtest-cli)                ║"
        echo "║  3. Install Nmap (port scanner)               ║"
        echo "║  4. Scan local network                        ║"
        echo "║  5. Show Wi‑Fi details                        ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-5]: " sub_choice
        case $sub_choice in
            1) setup_ngrok ;;
            2) speedtest ;;
            3) pkg install nmap -y && echo "✅ Nmap installed" ;;
            4) nmap_scan ;;
            5) wifi_details ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

setup_ngrok() {
    echo "Downloading Ngrok..."
    wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip
    unzip ngrok.zip
    chmod +x ngrok
    mv ngrok $PREFIX/bin/
    rm ngrok.zip
    echo "✅ Ngrok installed. Run 'ngrok http 8080' to start."
    read -p "Press Enter to continue..."
}

speedtest() {
    pkg install speedtest-cli -y 2>/dev/null
    speedtest-cli --simple
    read -p "Press Enter to continue..."
}

nmap_scan() {
    if ! command -v nmap &> /dev/null; then
        echo "Nmap not installed. Install first (option 3)."
        read -p "Press Enter to continue..."
        return
    fi
    echo "Scanning local network (192.168.1.0/24)..."
    nmap -sn 192.168.1.0/24 | grep "Nmap scan" | awk '{print $5}'
    read -p "Press Enter to continue..."
}

wifi_details() {
    echo "SSID: $(dumpsys wifi | grep 'SSID:' | head -1 | cut -d' ' -f2)"
    echo "Signal: $(dumpsys wifi | grep 'RSSI:' | head -1 | cut -d' ' -f2)"
    echo "Frequency: $(dumpsys wifi | grep 'Frequency:' | head -1 | cut -d' ' -f2)"
    read -p "Press Enter to continue..."
}
