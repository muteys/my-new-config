#!/bin/bash

echo "=== Wallpaper Status ==="
echo "Current wallpaper symlink:"
ls -la ~/wallpaper/wallpaper.png

echo -e "\nCurrent wallpaper according to swww:"
swww query

echo -e "\n=== Waybar Status ==="
if pgrep -x waybar > /dev/null; then
    echo "Waybar is running (PID: $(pgrep -x waybar))"
else
    echo "Waybar is NOT running"
fi

echo -e "\n=== Wallpaper Switcher Status ==="
if pgrep -f wallpaper_switcher.sh > /dev/null; then
    echo "Wallpaper switcher is running (PID: $(pgrep -f wallpaper_switcher.sh))"
else
    echo "Wallpaper switcher is NOT running"
fi

echo -e "\n=== Recent Logs ==="
journalctl --since "5 minutes ago" | grep -i "wallpaper\|waybar\|swww" | tail -5
