#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Theme Switch Utility${NC}"
echo "1. Use pywal theme (if available)"
echo "2. Use fallback theme"
echo "3. Check current setup"

read -p "Choose option (1-3): " choice

case $choice in
    1)
        if command -v wal &> /dev/null; then
            echo -e "${GREEN}Applying pywal theme...${NC}"
            
            # Check if wallpaper exists
            if [ -f ~/wallpaper/wallpaper.png ]; then
                wal -i ~/wallpaper/wallpaper.png -n
                echo -e "${GREEN}Pywal theme applied successfully!${NC}"
            else
                echo -e "${RED}Wallpaper not found. Using existing pywal colors.${NC}"
            fi
            
            # Update rofi config to use pywal
            sed -i '1s/.*/\@theme "~\/.cache\/wal\/colors-rofi-dark.rasi"/' ~/.config/rofi/config.rasi
            
            # Restart waybar if running
            if pgrep -x "waybar" > /dev/null; then
                pkill waybar
                waybar &
                echo -e "${GREEN}Waybar restarted with new theme${NC}"
            fi
        else
            echo -e "${RED}Pywal is not installed. Install it with: pip install pywal${NC}"
        fi
        ;;
    2)
        echo -e "${GREEN}Switching to fallback theme...${NC}"
        
        # Update rofi config to use fallback
        sed -i '1s/.*/\@theme "~\/.config\/rofi\/config-fallback.rasi"/' ~/.config/rofi/config.rasi
        
        # Copy fallback colors to wal cache
        cp ~/.cache/wal/colors-waybar.css ~/.cache/wal/colors-waybar.css.bak 2>/dev/null
        
        echo -e "${GREEN}Fallback theme activated${NC}"
        ;;
    3)
        echo -e "${BLUE}Current setup:${NC}"
        echo "Pywal installed: $(command -v wal &> /dev/null && echo 'Yes' || echo 'No')"
        echo "Rofi config:"
        head -1 ~/.config/rofi/config.rasi
        echo "Waybar running: $(pgrep -x waybar &> /dev/null && echo 'Yes' || echo 'No')"
        echo "Files present:"
        echo "  - Pywal rofi theme: $([ -f ~/.cache/wal/colors-rofi-dark.rasi ] && echo 'Present' || echo 'Missing')"
        echo "  - Waybar colors: $([ -f ~/.cache/wal/colors-waybar.css ] && echo 'Present' || echo 'Missing')"
        echo "  - Fallback rofi theme: $([ -f ~/.config/rofi/config-fallback.rasi ] && echo 'Present' || echo 'Missing')"
        ;;
    *)
        echo -e "${RED}Invalid option${NC}"
        ;;
esac
