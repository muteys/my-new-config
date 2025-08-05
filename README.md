# My Configuration Backup

This directory contains configuration files and resources for my system setup, as well as a list of packages that should be installed.

## Quick Start (Automatic Installation)
### **WARNING!!! Before running the script, change hyprland config by adding your monitor in mycfg/.config/hypr/configs/monitors.conf !**  
For automatic installation of all packages and restoration of configuration:

```bash
cd ~/mycfg
./restore.sh
```

This script will:
- Install all necessary packages from official repositories and AUR
- Copy all configuration files to their proper locations
- Install fonts and update font cache
- Restore pywal color schemes
- Set proper permissions

## Manual Installation

## Necessary Packages

You can install the necessary packages using the following commands:

```bash
# From the official repositories
sudo pacman -Syu \
  btop \
  fastfetch \
  hyprland \
  kitty \
  lf \
  mpv \
  obs-studio \
  python-pywal \
  rofi \
  starship \
  waybar \
  zsh

# From the AUR
paru -S \
  anytype-bin \
  ctpv \
  librewolf-bin \
  ttf-font-awesome \
  warp-terminal-bin \
  wlogout \
  yandex-music \
  yay
```

## Configuration Files

Copy the configuration files to their respective locations:

- `.config/*` to `~/.config/`
- `.zshrc` to `~/`
- `.bashrc`, `.bash_profile`, `.profile`, `.zshenv` to `~/`
- `wallpaper/*` to `~/wallpaper`
- `fonts/*` to `~/.local/share/fonts/`
- `wal-cache/*` to `~/.cache/wal/`

Ensure all the directories exist or create them if they don't. You might need to adjust file permissions by running:

```bash
chmod -R 755 ~/.config
mkdir -p ~/.cache/wal
```

## Pywal Theme Setup

This configuration uses pywal for dynamic color schemes. After copying the files:

1. The `wal-cache` directory contains your current color schemes and generated theme files
2. Your pywal configuration is in `.config/wal/`
3. To apply the current theme, run: `wal -R`
4. To generate a new theme from a wallpaper, run: `wal -i /path/to/your/wallpaper.jpg`

Enjoy your configured setup!

## Original config
Original config is from: https://github.com/xeji01/hyprstellar

ty ♥