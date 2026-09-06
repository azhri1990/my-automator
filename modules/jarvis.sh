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
        echo "║  7. Launch PocketStrike-AI (all services)     ║"
        echo "║  8. Stop PocketStrike-AI                      ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-8]: " sub_choice
        case $sub_choice in
            1) clone_jarvis ;;
            2) install_jarvis_deps ;;
            3) launch_rehan ;;
            4) launch_isair ;;
            5) download_offgrid ;;
            6) install_offgrid ;;
            7) launch_pocketstrike ;;
            8) stop_pocketstrike ;;
            0) break ;;
            *) echo "Invalid option."; read -p "Press Enter..." ;;
        esac
    done
}

clone_jarvis() {
    echo "📦 Cloning/Updating jarvis-mega-repo..."
    if [ -d "$HOME/jarvis-mega-repo" ]; then
        cd "$HOME/jarvis-mega-repo" && git pull --recurse-submodules
    else
        git clone --recurse-submodules https://github.com/azhri1990/jarvis-mega-repo.git "$HOME/jarvis-mega-repo"
    fi
    echo "✅ Jarvis repo ready."
    read -p "Press Enter to continue..."
}

install_jarvis_deps() {
    echo "📦 Installing dependencies..."
    if [ -d "$HOME/jarvis-mega-repo/assistants/RehanIlyas-JARVIS" ]; then
        cd "$HOME/jarvis-mega-repo/assistants/RehanIlyas-JARVIS" && pip install -r requirements.txt 2>/dev/null
    fi
    if [ -d "$HOME/jarvis-mega-repo/assistants/isair-jarvis" ]; then
        cd "$HOME/jarvis-mega-repo/assistants/isair-jarvis" && pip install -r requirements.txt 2>/dev/null
    fi
    echo "✅ Dependencies installed."
    read -p "Press Enter to continue..."
}

launch_rehan() {
    echo "🚀 Launching RehanIlyas-JARVIS..."
    if [ -d "$HOME/jarvis-mega-repo/assistants/RehanIlyas-JARVIS" ]; then
        cd "$HOME/jarvis-mega-repo/assistants/RehanIlyas-JARVIS" && python main.py
    else
        echo "❌ Not found. Clone first (option 1)."
    fi
    read -p "Press Enter to continue..."
}

launch_isair() {
    echo "🚀 Launching isair-jarvis..."
    if [ -d "$HOME/jarvis-mega-repo/assistants/isair-jarvis" ]; then
        cd "$HOME/jarvis-mega-repo/assistants/isair-jarvis" && python jarvis.py
    else
        echo "❌ Not found. Clone first (option 1)."
    fi
    read -p "Press Enter to continue..."
}

download_offgrid() {
    echo "📥 Downloading Off Grid APK..."
    mkdir -p ~/downloads
    cd ~/downloads
    wget -O offgrid.apk https://github.com/marshaltang/off-grid-mobile-ai/releases/latest/download/app-release.apk
    echo "✅ Downloaded to ~/downloads/offgrid.apk"
    read -p "Press Enter to continue..."
}

install_offgrid() {
    echo "📲 Installing Off Grid APK..."
    if [ -f ~/downloads/offgrid.apk ]; then
        termux-open ~/downloads/offgrid.apk
        echo "✅ Installer opened. Install manually."
    else
        echo "❌ APK not found. Download first (option 5)."
    fi
    read -p "Press Enter to continue..."
}

launch_pocketstrike() {
    echo "🚀 Starting PocketStrike-AI..."
    
    if ! pgrep -f "llama-server" > /dev/null; then
        echo "⚠️  Starting llama-server..."
        cd ~/llama.cpp
        ./build/bin/llama-server -m Phi-3-mini-4k-instruct-Q4_K_M.gguf --host 127.0.0.1 --port 11434 -t 4 --ctx-size 2048 &
        sleep 5
    else
        echo "✅ llama-server is running."
    fi

    if ! pgrep -f "ollama_proxy.py" > /dev/null; then
        echo "⚠️  Starting proxy..."
        cd ~/PocketStrike-AI
        python ollama_proxy.py &
        sleep 2
    else
        echo "✅ Proxy is running."
    fi

    if ! pgrep -f "server.py" > /dev/null; then
        echo "🚀 Starting PocketStrike-AI..."
        cd ~/PocketStrike-AI
        python server.py &
        sleep 3
    else
        echo "✅ PocketStrike-AI is running."
    fi

    echo ""
    echo "🌐 Web UI: http://127.0.0.1:5000"
    echo "🎙️  Voice: 'Hey Strike'"
    echo "📡 Proxy: http://127.0.0.1:11435"
    echo "🧠 Model: Phi-3-mini-4k-instruct"
    echo "✅ PocketStrike-AI is ready!"
    read -p "Press Enter to continue..."
}

stop_pocketstrike() {
    echo "🛑 Stopping PocketStrike-AI..."
    pkill -f "server.py"
    pkill -f "ollama_proxy.py"
    pkill -f "llama-server"
    echo "✅ All services stopped."
    read -p "Press Enter to continue..."
}
