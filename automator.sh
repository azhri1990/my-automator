#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# MY TERMUX AUTOMATOR – ULTIMATE EDITION v3.0
# ==============================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/logs/automator.log"

# --- Logging ---
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# --- Load all modules ---
for mod in "$SCRIPT_DIR"/modules/*.sh; do
    if [ -f "$mod" ]; then
        source "$mod"
        log "Loaded module: $(basename "$mod")"
    fi
done

# --- Plugin system: load user scripts from ~/.automator_plugins/ ---
PLUGIN_DIR="$HOME/.automator_plugins"
if [ -d "$PLUGIN_DIR" ]; then
    for plugin in "$PLUGIN_DIR"/*.sh; do
        if [ -f "$plugin" ]; then
            source "$plugin"
            log "Loaded plugin: $(basename "$plugin")"
        fi
    done
fi

# --- Get Current AI Model (Short) ---
get_current_model() {
    if [ -f ~/PocketStrike-AI/config.json ]; then
        MODEL=$(grep -o '"model": "[^"]*"' ~/PocketStrike-AI/config.json | cut -d'"' -f4 2>/dev/null)
        PROVIDER=$(grep -o '"ai_provider": "[^"]*"' ~/PocketStrike-AI/config.json | cut -d'"' -f4 2>/dev/null)
        
        if [ -z "$MODEL" ]; then
            echo "⚠️  No model configured"
        elif [ "$PROVIDER" = "ollama" ]; then
            echo "🟢 Local: $MODEL"
        elif [ "$PROVIDER" = "openai" ]; then
            echo "🔵 Cloud: $MODEL"
        else
            echo "❓ $MODEL"
        fi
    else
        echo "⚠️  Config not found"
    fi
}

# --- Check Current AI Model (Detailed) ---
check_current_model() {
    clear
    echo "╔═══════════════════════════════════════════════╗"
    echo "║         CURRENT AI MODEL                      ║"
    echo "╠═══════════════════════════════════════════════╣"
    
    if [ -f ~/PocketStrike-AI/config.json ]; then
        MODEL=$(grep -o '"model": "[^"]*"' ~/PocketStrike-AI/config.json | cut -d'"' -f4 2>/dev/null)
        PROVIDER=$(grep -o '"ai_provider": "[^"]*"' ~/PocketStrike-AI/config.json | cut -d'"' -f4 2>/dev/null)
        BASE_URL=$(grep -o '"base_url": "[^"]*"' ~/PocketStrike-AI/config.json | cut -d'"' -f4 2>/dev/null)
        
        echo "║  🤖 Model:       $MODEL                         ║"
        echo "║  📡 Provider:    $PROVIDER                      ║"
        
        if [ "$PROVIDER" = "ollama" ]; then
            echo "║  🟢 Status:      Local (Offline, Private)    ║"
        elif [ "$PROVIDER" = "openai" ]; then
            echo "║  🔵 Status:      Cloud (API)                  ║"
            echo "║  🌐 API Base:    $BASE_URL                    ║"
        else
            echo "║  ⚠️  Status:      Unknown                      ║"
        fi
        
        echo "║  📁 Config:      ~/PocketStrike-AI/config.json  ║"
    else
        echo "║  ❌ Config file not found                       ║"
        echo "║  💡 Run Jarvis Integration → Option 7 to start  ║"
    fi
    
    echo "╚═══════════════════════════════════════════════╝"
    echo ""
    read -p "Press Enter to continue..."
}

# --- Self-update ---
self_update() {
    echo "Checking for updates..."
    cd "$SCRIPT_DIR" || return
    git pull origin main
    echo "✅ Updated. Restarting..."
    exec "$SCRIPT_DIR/automator.sh"
}

# --- Main menu ---
show_main_menu() {
    clear
    echo "╔═══════════════════════════════════════════════╗"
    echo "║   MY TERMUX AUTOMATOR – ULTIMATE EDITION     ║"
    echo "╠═══════════════════════════════════════════════╣"
    echo "║   🤖 $(get_current_model)                     ║"
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
    echo "║ 10. Advanced Features (AI, OCR, etc.)       ║"
    echo "║ 11. Self‑Update (Git pull)                   ║"
    echo "║ 12. Check Current AI Model                   ║"
    echo "║  0. Exit                                     ║"
    echo "╚═══════════════════════════════════════════════╝"
    read -p "Choose an option [0-12]: " main_choice
}

# --- Main loop ---
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
        10) menu_advanced ;;
        11) self_update ;;
        12) check_current_model ;;
        0) echo "Goodbye!"; log "Exited"; exit 0 ;;
        *) echo "Invalid option."; read -p "Press Enter to continue..." ;;
    esac
done
