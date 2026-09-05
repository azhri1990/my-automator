#!/data/data/com.termux/files/usr/bin/bash

menu_files() {
    while true; do
        clear
        echo "╔═══════════════════════════════════════════════╗"
        echo "║         FILE & MEDIA UTILITIES                ║"
        echo "╠═══════════════════════════════════════════════╣"
        echo "║  1. Batch Rename Files                        ║"
        echo "║  2. Convert Image (Imagemagick)               ║"
        echo "║  3. Extract Audio from Video (ffmpeg)         ║"
        echo "║  4. Find Large Files (>100MB)                 ║"
        echo "║  0. Back to Main Menu                         ║"
        echo "╚═══════════════════════════════════════════════╝"
        read -p "Choose an option [0-4]: " sub_choice
        case $sub_choice in
            1) batch_rename ;;
            2) convert_image ;;
            3) extract_audio ;;
            4) find_large_files ;;
            0) break ;;
            *) echo "Invalid"; read -p "Press Enter..." ;;
        esac
    done
}

batch_rename() {
    read -p "Enter directory path: " dirpath
    read -p "Enter pattern (e.g., '*.jpg'): " pattern
    read -p "Enter new prefix: " prefix
    cd "$dirpath" || return
    count=0
    for file in $pattern; do
        mv "$file" "${prefix}_${count}.${file##*.}" 2>/dev/null
        ((count++))
    done
    echo "✅ Renamed $count files."
    read -p "Press Enter to continue..."
}

convert_image() {
    pkg install imagemagick -y 2>/dev/null
    read -p "Enter image file: " img
    read -p "Enter output format (png/jpg/webp): " fmt
    convert "$img" "${img%.*}.$fmt"
    echo "✅ Converted."
    read -p "Press Enter to continue..."
}

extract_audio() {
    pkg install ffmpeg -y 2>/dev/null
    read -p "Enter video file: " video
    ffmpeg -i "$video" -q:a 0 -map a "${video%.*}.mp3"
    echo "✅ Audio extracted to ${video%.*}.mp3"
    read -p "Press Enter to continue..."
}

find_large_files() {
    echo "Files > 100MB in /data/data/com.termux/files/home:"
    find ~ -type f -size +100M -exec ls -lh {} \; 2>/dev/null | awk '{print $9 " (" $5 ")"}'
    read -p "Press Enter to continue..."
}
