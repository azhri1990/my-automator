#!/data/data/com.termux/files/usr/bin/bash

menu_advanced() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         ADVANCED FEATURES                     ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. AI Assistant (Ollama + Error Explainer)   ║"
        echo "║  2. Screen Recorder (Terminal)                ║"
        echo "║  3. Phone Finder / Security Alert             ║"
        echo "║  4. YouTube / Website Downloader              ║"
        echo "║  5. System Resource Monitor (htop/glances)    ║"
        echo "║  6. Weather Fetcher                           ║"
        echo "║  7. Quick Note Taker                          ║"
        echo "║  8. Password Manager (Local)                  ║"
        echo "║  9. Cloud Backup (rclone)                     ║"
        echo "║ 10. SMS & Call Blocker                        ║"
        echo "║ 11. Automated APK Downloader                  ║"
        echo "║ 12. Command History Search (fzf)              ║"
        echo "║ 13. OCR (Image to Text)                       ║"
        echo "║ 14. INFR.AD AI Chat (3 models)                ║"
        echo "║ 15. Git Sync All Repos                        ║"
        echo "║ 16. AI Swarm (Multiple AI Queries)            ║"
        echo "║ 17. Image Generation (Draw)                   ║"
        echo "║ 18. Setup Auto-Start (Termux:Boot)            ║"
        echo "║ 19. List Agency Agents                       ║"
        echo "║ 20. Use Agency Agent                         ║"
        echo "║ 21. Quick Agent Commands                     ║"
        echo "║ 22. Web Scraper (ScrapeGraphAI)              ║"
        echo "║ 23. Social Media Scraper (Agent Reach)        ║"
        echo "║ 24. Anti-Captcha Scraper (Scrapling)          ║"
        echo "║ 25. Website Builder Prompts (getlayers.ai)    ║"
        echo "║ 26. GlowUP AI - Style Assistant               ║"
        echo "║ 27. Self-Building Jarvis                      ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-27]: " sub_choice
        case $sub_choice in
            1) ai_assistant ;;
            2) screen_recorder ;;
            3) phone_finder ;;
            4) download_media ;;
            5) resource_monitor ;;
            6) weather_fetcher ;;
            7) quick_note ;;
            8) password_manager ;;
            9) cloud_backup ;;
            10) sms_blocker ;;
            11) auto_apk_download ;;
            12) fzf_history ;;
            13) ocr_tool ;;
            14) infr_chat_menu ;;
            15) git_sync_all ;;
            16) ai_swarm ;;
            17) draw_image ;;
            18) setup_autostart ;;
            19) list_agency_agents ;;
            20) use_agency_agent ;;
            21) quick_agent_menu ;;
            22) web_scraper ;;
            23) social_scraper ;;
            24) scrapling_scraper ;;
            25) website_prompts ;;
            26) glowup_ai ;;
            27) self_build_jarvis ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

# --- 1. AI Assistant ---
ai_assistant() {
    echo "Checking for Ollama..."
    if ! command -v ollama &> /dev/null; then
        echo "Ollama not found. Installing via proot-distro..."
        pkg install proot-distro -y
        proot-distro install ubuntu
        echo "✅ Installed. Now login to Ubuntu and run 'ollama pull llama3.2'"
        read -p "Press Enter to login..."
        proot-distro login ubuntu
        return
    fi
    echo "1. Ask a question"
    echo "2. Explain a command error (paste the error)"
    read -p "Choice [1-2]: " ai_choice
    if [ "$ai_choice" -eq 1 ]; then
        read -p "Enter your question: " query
        echo "Thinking..."
        ollama run llama3.2 "$query"
    elif [ "$ai_choice" -eq 2 ]; then
        read -p "Paste the error message: " err_msg
        ollama run llama3.2 "Explain this error and suggest a fix: $err_msg"
    else
        echo "Invalid"
    fi
    read -p "Press Enter to continue..."
}

# --- 2. Screen Recorder ---
screen_recorder() {
    echo "Recording terminal session... Press Ctrl+D to stop."
    mkdir -p ~/recordings
    script ~/recordings/session_$(date +%s).log
    echo "✅ Recording saved to ~/recordings/"
    read -p "Press Enter to continue..."
}

# --- 3. Phone Finder ---
phone_finder() {
    echo "1. Send SMS alert to yourself"
    echo "2. Flashlight + Beep (if Termux:API installed)"
    read -p "Choice [1-2]: " pf_choice
    if [ "$pf_choice" -eq 1 ]; then
        read -p "Enter your phone number: " num
        read -p "Enter message: " msg
        termux-sms-send -n "$num" "$msg" 2>/dev/null || echo "Termux:API not installed."
    elif [ "$pf_choice" -eq 2 ]; then
        termux-torch on
        echo "📳 Flashlight ON. Press Enter to turn off."
        read
        termux-torch off
    else
        echo "Invalid"
    fi
    read -p "Press Enter to continue..."
}

# --- 4. YouTube / Website Downloader ---
download_media() {
    echo "1. Download YouTube video/audio"
    echo "2. Download entire website"
    read -p "Choice [1-2]: " dl_choice
    if [ "$dl_choice" -eq 1 ]; then
        pkg install python -y && pip install yt-dlp -q
        read -p "Enter YouTube URL: " url
        yt-dlp -f bestvideo+bestaudio "$url" -o "~/downloads/%(title)s.%(ext)s"
    elif [ "$dl_choice" -eq 2 ]; then
        read -p "Enter website URL: " url
        mkdir -p ~/downloads/webfiles
        wget --mirror -p --convert-links -P ~/downloads/webfiles "$url"
    else
        echo "Invalid"
    fi
    read -p "Press Enter to continue..."
}

# --- 5. Resource Monitor ---
resource_monitor() {
    echo "1. htop (interactive)"
    echo "2. glances (full-screen)"
    read -p "Choice [1-2]: " rm_choice
    if [ "$rm_choice" -eq 1 ]; then
        pkg install htop -y && htop
    elif [ "$rm_choice" -eq 2 ]; then
        pkg install python -y && pip install glances -q
        glances
    else
        echo "Invalid"
    fi
    read -p "Press Enter to continue..."
}

# --- 6. Weather Fetcher ---
weather_fetcher() {
    read -p "Enter city (e.g., London): " city
    curl "wttr.in/$city?format=%C+%t+%w" || echo "Check internet."
    read -p "Press Enter to continue..."
}

# --- 7. Quick Note Taker ---
quick_note() {
    read -p "Enter your note: " note
    echo "[$(date '+%Y-%m-%d %H:%M')] $note" >> ~/notes.txt
    echo "✅ Note saved to ~/notes.txt"
    read -p "Press Enter to continue..."
}

# --- 8. Password Manager ---
password_manager() {
    echo "1. Add a password"
    echo "2. Retrieve a password"
    read -p "Choice [1-2]: " pm_choice
    if [ "$pm_choice" -eq 1 ]; then
        read -p "Enter service name: " service
        read -p "Enter username: " user
        read -sp "Enter password: " pass
        echo
        echo "$service | $user | $pass" >> ~/.passwords.tmp
        pkg install gnupg -y 2>/dev/null
        gpg -c ~/.passwords.tmp 2>/dev/null
        mv ~/.passwords.tmp.gpg ~/.passwords.gpg
        rm ~/.passwords.tmp
        echo "✅ Encrypted password saved."
    elif [ "$pm_choice" -eq 2 ]; then
        if [ -f ~/.passwords.gpg ]; then
            gpg ~/.passwords.gpg 2>/dev/null
            cat ~/.passwords
            rm ~/.passwords
        else
            echo "No password file found."
        fi
    else
        echo "Invalid"
    fi
    read -p "Press Enter to continue..."
}

# --- 9. Cloud Backup ---
cloud_backup() {
    pkg install rclone -y
    echo "Configuring rclone..."
    echo "Visit https://rclone.org/ for setup."
    rclone config
    echo "To sync: rclone sync ~/jarvis-mega-repo remote:jarvis-backup"
    read -p "Press Enter to continue..."
}

# --- 10. SMS & Call Blocker ---
sms_blocker() {
    echo "This requires Termux:API and READ_SMS permission."
    echo "Reading last 5 SMS..."
    termux-sms-inbox | head -20
    echo "Blocking is not fully automated due to permission limits."
    read -p "Press Enter to continue..."
}

# --- 11. Automated APK Downloader ---
auto_apk_download() {
    read -p "Enter GitHub repo (e.g., 'marshaltang/off-grid-mobile-ai'): " repo
    echo "Fetching latest release..."
    url=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | grep "browser_download_url" | head -1 | cut -d '"' -f 4)
    if [ -n "$url" ]; then
        mkdir -p ~/downloads
        wget -O ~/downloads/latest.apk "$url"
        echo "✅ Downloaded to ~/downloads/latest.apk"
        termux-open ~/downloads/latest.apk
    else
        echo "Repo not found or no releases."
    fi
    read -p "Press Enter to continue..."
}

# --- 12. Command History Search ---
fzf_history() {
    pkg install fzf -y
    echo "Searching bash history..."
    cat ~/.bash_history | fzf --reverse
    read -p "Press Enter to continue..."
}

# --- 13. OCR ---
ocr_tool() {
    pkg install tesseract -y
    read -p "Enter path to image file: " img
    if [ -f "$img" ]; then
        tesseract "$img" ~/ocr_output
        echo "✅ Text extracted:"
        cat ~/ocr_output.txt
        rm ~/ocr_output.txt
    else
        echo "File not found."
    fi
    read -p "Press Enter to continue..."
}

# --- 14. INFR.AD AI Chat ---
infr_chat_menu() {
    echo ""
    echo "╔═══════════════════════════════════════════════╗"
    echo "║         INFR.AD AI CHAT                       ║"
    echo "╠═══════════════════════════════════════════════╣"
    echo "║  1. deepseek-v4-flash (fast, 1M context)     ║"
    echo "║  2. hy3 (strong reasoning, 262k context)     ║"
    echo "║  3. gpt-5.6-luna (vision, capable)           ║"
    echo "╚═══════════════════════════════════════════════╝"
    read -p "Choose model [1-3]: " model_choice
    
    case $model_choice in
        1) MODEL="deepseek-v4-flash" ;;
        2) MODEL="hy3" ;;
        3) MODEL="gpt-5.6-luna" ;;
        *) echo "❌ Invalid choice"; read -p "Press Enter..."; return ;;
    esac
    
    read -p "Enter your prompt: " PROMPT
    echo ""
    echo "🤖 Thinking... (press Ctrl+C to stop)"
    echo ""
    
    ~/bin/infr_chat "$MODEL" "$PROMPT"
    
    echo ""
    read -p "Press Enter to continue..."
}

# --- 15. Git Sync All Repos ---
git_sync_all() {
    echo "🔄 Syncing all Jarvis repositories..."
    echo "========================================"
    
    repos="jarvis-mega-repo my-automator PocketStrike-AI jarvis-unified jarvis-boot omniroute-config llama-cpp-config termux-config"
    
    for repo in $repos; do
        if [ -d ~/$repo ]; then
            echo "📁 Syncing $repo..."
            cd ~/$repo
            git pull 2>/dev/null || echo "   ⚠️  No remote set"
            git push 2>/dev/null || echo "   ⚠️  Push failed"
            echo "   ✅ Done"
        else
            echo "❌ $repo not found"
        fi
    done
    
    echo "========================================"
    echo "✅ All repos synced!"
    read -p "Press Enter to continue..."
}

# --- 16. AI Swarm ---
ai_swarm() {
    read -p "Enter your question: " query
    
    echo "🧠 Querying AI Swarm..."
    echo ""
    
    # Query OmniRoute
    echo "🟢 OmniRoute:"
    curl -s -X POST http://localhost:20128/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
        -d "{\"model\":\"kr/claude-sonnet-4.5\",\"messages\":[{\"role\":\"user\",\"content\":\"$query\"}]}" \
        | grep -o '"content":"[^"]*"' | cut -d'"' -f4
    
    echo ""
    echo "🔵 DeepSeek:"
    curl -s -X POST https://api.infr.ad/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-infr-8la1zjzz.60uqyxbskno8cvj3y4dnu3t2xr1y2u1v" \
        -d "{\"model\":\"deepseek-v4-flash\",\"messages\":[{\"role\":\"user\",\"content\":\"$query\"}]}" \
        | grep -o '"content":"[^"]*"' | cut -d'"' -f4
    
    echo ""
    echo "🟣 Local Phi-3 (if running):"
    curl -s -X POST http://127.0.0.1:11434/api/generate \
        -d "{\"model\":\"Phi-3-mini-4k-instruct-Q4_K_M\",\"prompt\":\"$query\",\"stream\":false}" \
        | grep -o '"response":"[^"]*"' | cut -d'"' -f4 || echo "   Not running"
    
    echo ""
    read -p "Press Enter to continue..."
}

# --- 17. Image Generation ---
draw_image() {
    read -p "Enter your image prompt: " prompt
    
    echo "🎨 Generating image: \"$prompt\""
    echo "⏳ This may take a moment..."
    
    result=$(curl -s -X POST http://localhost:20128/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-5f238e76072d7926-92e57f-f18174b2" \
        -d "{\"model\":\"aihorde/SDXL 1.0\",\"messages\":[{\"role\":\"user\",\"content\":\"Generate an image: $prompt\"}]}")
    
    image_url=$(echo "$result" | grep -o 'https://[^"]*\.png' | head -1)
    
    if [ -n "$image_url" ]; then
        echo "✅ Image generated!"
        echo "🔗 $image_url"
        termux-open "$image_url" 2>/dev/null || echo "Open the URL in your browser"
    else
        echo "❌ Could not generate image."
        echo "Response: $result"
    fi
    
    read -p "Press Enter to continue..."
}

# --- 18. Auto-Start Setup ---
setup_autostart() {
    echo "🚀 Setting up Termux:Boot auto-start..."
    mkdir -p ~/.termux/boot
    
    cat > ~/.termux/boot/start_jarvis.sh << 'INNER_EOF'
#!/data/data/com.termux/files/usr/bin/bash
LOG_FILE="$HOME/jarvis-boot.log"
echo "========================================" >> "$LOG_FILE"
echo "Jarvis boot script started at $(date)" >> "$LOG_FILE"
sleep 10
if command -v omniroute &> /dev/null; then
    omniroute >> "$LOG_FILE" 2>&1 &
else
    npx omniroute >> "$LOG_FILE" 2>&1 &
fi
sleep 5
cd ~/PocketStrike-AI
python server.py >> "$LOG_FILE" 2>&1 &
echo "✅ All services started at $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
INNER_EOF

    chmod +x ~/.termux/boot/start_jarvis.sh
    echo "✅ Boot script created at ~/.termux/boot/start_jarvis.sh"
    echo "📋 Install Termux:Boot from F-Droid and reboot"
    read -p "Press Enter to continue..."
}

# --- 19. List Agency Agents ---
list_agency_agents() {
    clear
    echo "╔═══════════════════════════════════════════════╗"
    echo "║         AGENCY AGENTS BY DIVISION            ║"
    echo "╠═══════════════════════════════════════════════╣"
    for dir in ~/.aider/agents/*/; do
        if [ -d "$dir" ]; then
            count=$(find "$dir" -name "*.md" | wc -l)
            if [ $count -gt 0 ]; then
                printf "║  📁 %-20s %3d agents           ║\n" "$(basename "$dir")" "$count"
            fi
        fi
    done
    echo "╠═══════════════════════════════════════════════╣"
    echo "║  Total agents: $(find ~/.aider/agents -name "*.md" | wc -l)                         ║"
    echo "╚═══════════════════════════════════════════════╝"
    read -p "Press Enter to continue..."
}

# --- 20. Use Agency Agent ---
use_agency_agent() {
    clear
    echo "╔═══════════════════════════════════════════════╗"
    echo "║         USE AGENCY AGENT                      ║"
    echo "╠═══════════════════════════════════════════════╣"
    echo "║  Available divisions:                         ║"
    for dir in ~/.aider/agents/*/; do
        if [ -d "$dir" ]; then
            echo "║    $(basename "$dir")"
        fi
    done
    echo "╚═══════════════════════════════════════════════╝"
    echo ""
    read -p "Enter division (e.g., sales, engineering): " division
    read -p "Enter agent name (e.g., sales-outbound-strategist): " agent
    read -p "Enter your task: " task
    echo ""
    ~/bin/use_agent "$division" "$agent" "$task"
    read -p "Press Enter to continue..."
}

# --- 21. Quick Agent Commands ---
quick_agent_menu() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         QUICK AGENT COMMANDS                  ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Sales - Outbound Strategist               ║"
        echo "║  2. Sales - Coach                             ║"
        echo "║  3. Sales - Engineer                          ║"
        echo "║  4. Engineering - Software Architect          ║"
        echo "║  5. Engineering - AI Engineer                 ║"
        echo "║  6. Marketing - Content Creator               ║"
        echo "║  7. Marketing - SEO Specialist                ║"
        echo "║  8. Security - AppSec Engineer                ║"
        echo "║  9. Security - Penetration Tester             ║"
        echo "║  0. Back                                       ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an agent [0-9]: " agent_choice
        case $agent_choice in
            1) read -p "Enter your task: " task; ~/bin/use_agent sales sales-outbound-strategist "$task" ;;
            2) read -p "Enter your task: " task; ~/bin/use_agent sales sales-coach "$task" ;;
            3) read -p "Enter your task: " task; ~/bin/use_agent sales sales-engineer "$task" ;;
            4) read -p "Enter your task: " task; ~/bin/use_agent engineering engineering-software-architect "$task" ;;
            5) read -p "Enter your task: " task; ~/bin/use_agent engineering engineering-ai-engineer "$task" ;;
            6) read -p "Enter your task: " task; ~/bin/use_agent marketing marketing-content-creator "$task" ;;
            7) read -p "Enter your task: " task; ~/bin/use_agent marketing marketing-seo-specialist "$task" ;;
            8) read -p "Enter your task: " task; ~/bin/use_agent security security-appsec-engineer "$task" ;;
            9) read -p "Enter your task: " task; ~/bin/use_agent security security-penetration-tester "$task" ;;
            0) break ;;
            *) echo "Invalid option."; read -p "Press Enter..." ;;
        esac
    done
}

# --- 22. Web Scraper ---
web_scraper() {
    read -p "Enter URL to scrape: " url
    read -p "What data to extract? " prompt
    python -c "
from scrapegraphai import scrape
result = scrape('$url', '$prompt')
print('📊 Extracted Data:')
print(result)
" 2>/dev/null || echo "❌ ScrapeGraphAI not installed. Run: pip install scrapegraphai"
    read -p "Press Enter to continue..."
}

# --- 23. Social Media Scraper ---
social_scraper() {
    read -p "Enter social media URL: " url
    ~/bin/agent_reach "$url" 2>/dev/null || echo "❌ Agent Reach not installed."
    read -p "Press Enter to continue..."
}

# --- 24. Anti-Captcha Scraper ---
scrapling_scraper() {
    read -p "Enter URL to scrape: " url
    ~/bin/scrapling "$url" 2>/dev/null || echo "❌ Scrapling not installed."
    read -p "Press Enter to continue..."
}

# --- 25. Website Builder Prompts ---
website_prompts() {
    ~/bin/getlayers
    read -p "Press Enter to continue..."
}

# --- 26. GlowUP AI ---
glowup_ai() {
    echo "✨ Starting GlowUP AI Style Assistant..."
    cd ~/jarvis-mega-repo/assistants/glowup-ai
    python server.py &
    echo "🌐 GlowUP AI running on http://127.0.0.1:8008"
    read -p "Press Enter to continue..."
}

# --- 27. Self-Building Jarvis ---
self_build_jarvis() {
    ~/jarvis-unified/self_build.sh
    read -p "Press Enter to continue..."
}

# --- Infr Chat Function (needed for option 14) ---
infr_chat() {
    curl -s -X POST https://api.infr.ad/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer sk-infr-8la1zjzz.60uqyxbskno8cvj3y4dnu3t2xr1y2u1v" \
        -d "{\"model\":\"$1\",\"messages\":[{\"role\":\"user\",\"content\":\"$2\"}]}" \
        | grep -o '"content":"[^"]*"' | cut -d'"' -f4
}

