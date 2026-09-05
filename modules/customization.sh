#!/data/data/com.termux/files/usr/bin/bash

menu_custom() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         TERMINAL CUSTOMIZATION                ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Install Zsh + Oh‑My‑Zsh                   ║"
        echo "║  2. Install Powerlevel10k theme               ║"
        echo "║  3. Apply Dark Theme + Extra Keys             ║"
        echo "║  4. Download & Apply Nerd Font                ║"
        echo "║  5. Choose Color Scheme (Nord/Dracula)        ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-5]: " sub_choice
        case $sub_choice in
            1) install_zsh ;;
            2) install_p10k ;;
            3) apply_dark_theme ;;
            4) install_nerd_font ;;
            5) color_scheme ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

install_zsh() {
    pkg install zsh -y
    chsh -s zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Zsh + Oh‑My‑Zsh installed. Restart Termux to use Zsh."
    read -p "Press Enter to continue..."
}

install_p10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    echo "✅ Powerlevel10k installed. Restart Zsh."
    read -p "Press Enter to continue..."
}

apply_dark_theme() {
    mkdir -p ~/.termux
    cat > ~/.termux/termux.properties << 'EOF'
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]
use-black-ui = true
bell-character = ignore
