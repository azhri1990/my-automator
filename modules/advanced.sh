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
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-13]: " sub_choice
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
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

# --- 1. AI Assistant + Error Explainer ---
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

# --- 3. Phone Finder / Security Alert ---
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

# --- 8. Password Manager (Local) ---
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

# --- 9. Cloud Backup (rclone) ---
cloud_backup() {
    pkg install rclone -y
    echo "Configuring rclone..."
    echo "Visit https://rclone.org/ for setup."
    rclone config
    echo "To sync: rclone sync ~/jarvis-mega-repo remote:jarvis-backup"
    read -p "Press Enter to continue..."
}

# --- 10. SMS & Call Blocker (experimental) ---
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

# --- 12. Command History Search (fzf) ---
fzf_history() {
    pkg install fzf -y
    echo "Searching bash history..."
    cat ~/.bash_history | fzf --reverse
    read -p "Press Enter to continue..."
}

# --- 13. OCR (Image to Text) ---
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
