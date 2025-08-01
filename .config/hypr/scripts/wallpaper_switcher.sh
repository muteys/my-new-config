#!/bin/bash

# Убедимся, что у нас есть переменные окружения Wayland
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1}
export XDG_SESSION_TYPE=${XDG_SESSION_TYPE:-wayland}
export XDG_CURRENT_DESKTOP=${XDG_CURRENT_DESKTOP:-Hyprland}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}

#interval in seconds 15 min = 900 sec
INTERVAL=900
#Path to random_wallpaper script
WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/random_wallpaper.sh"

while true; do
    #start script
    bash "$WALLPAPER_SCRIPT"

    sleep "$INTERVAL"
done
