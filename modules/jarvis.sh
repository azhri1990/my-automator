#!/data/data/com.termux/files/usr/bin/bash

menu_jarvis() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         JARVIS INTEGRATION                    ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Clone/Update jarvis-mega-repo             ║"
        echo "║  2. Install Dependencies for All Assistants   ║"
        echo "║  3. Launch RehanIlyas-JARVIS                  ║"
        echo "║  4. Launch isair-jarvis                       ║"
        echo "║  5. Download Off Grid APK                     ║"
        echo "║  6. Install Off Grid APK                      ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-6]: " sub_choice
        case $sub_choice in
            1) clone_jarvis ;;
            2) install_jarvis_deps ;;
            3) launch_rehan ;;
            4) launch_isair ;;
            5) download_offgrid ;;
            6) install_offgrid ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

clone_jarvis() {
    if [ -d "$HOME/jarvis-mega-repo" ]; then
        cd "$HOME/jarvis-mega-repo" && git pull --recurse-submodules
    else
        git clone --recurse-submodules https://github.com/azhri1990/jarvis-mega-repo.git "$HOME/jarvis-mega-repo"
    fi
    echo "✅ Jarvis repo ready."
    read -p "Press Enter to continue..."
}

install_jarvis_deps() {
    cd "$HOME/jarvis-mega-repo/assistants/RehanIlyas-JARVIS" && pip install -r requirements.txt 2>/dev/null
    cd "$HOME/jarvis-mega-repo/assistants/isair-jarvis" && pip install -r requirements.txt 2>/dev/null
    echo "✅ Dependencies installed."
    read -p "Press Enter to continue..."
}

launch_rehan() {
    cd "$HOME/jarvis-mega-repo/assistants/RehanIlyas-JARVIS" && python main.py || echo "Error: Repo not found."
    read -p "Press Enter to continue..."
}

launch_isair() {
    cd "$HOME/jarvis-mega-repo/assistants/isair-jarvis" && python jarvis.py || echo "Error: Repo not found."
    read -p "Press Enter to continue..."
}

download_offgrid() {
    mkdir -p ~/downloads
    cd ~/downloads
    wget -O offgrid.apk https://github.com/marshaltang/off-grid-mobile-ai/releases/latest/download/app-release.apk
    echo "✅ APK downloaded to ~/downloads/offgrid.apk"
    read -p "Press Enter to continue..."
}

install_offgrid() {
    if [ -f ~/downloads/offgrid.apk ]; then
        termux-open ~/downloads/offgrid.apk
        echo "✅ Installer opened. Please install manually."
    else
        echo "APK not found. Download first (option 5)."
    fi
    read -p "Press Enter to continue..."
}
