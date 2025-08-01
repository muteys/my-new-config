#!/bin/bash

# Убедимся, что у нас есть переменные окружения Wayland
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1}
export XDG_SESSION_TYPE=${XDG_SESSION_TYPE:-wayland}
export XDG_CURRENT_DESKTOP=${XDG_CURRENT_DESKTOP:-Hyprland}

THEME_FILE="/tmp/theme_variant"
wal_arguments=""

if [ -s "$THEME_FILE" ]; then
  case $(<"$THEME_FILE") in
    "light") wal_arguments="lighten -l" ;;
  esac
fi

wal -i ~/wallpaper/wallpaper.png $wal_arguments -q -n -e

# Проверяем, запущен ли waybar, и убиваем его
if pgrep -x "waybar" >/dev/null; then
    killall waybar
    sleep 0.5  # Даем время процессу завершиться
fi

# Запускаем waybar с правильными переменными окружения
WAYLAND_DISPLAY="$WAYLAND_DISPLAY" XDG_SESSION_TYPE="$XDG_SESSION_TYPE" waybar >/dev/null 2>&1 &

# Перезагружаем swaync
swaync-client -rs >/dev/null 2>&1

# Обновляем pywalfox если доступен
if command -v pywalfox >/dev/null 2>&1; then
    pywalfox update >/dev/null 2>&1
fi
