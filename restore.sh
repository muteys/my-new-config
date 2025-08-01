#!/bin/bash

# Configuration Restore Script
# This script will restore your configuration files to their proper locations
# and install all necessary packages

set -e  # Exit on any error

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d ".config" ]; then
    echo "Error: Please run this script from the mycfg directory!"
    echo "Usage: cd ~/mycfg && ./restore.sh"
    exit 1
fi

echo "Starting configuration restoration..."

# Function to check if a package is installed
check_package() {
    pacman -Qi "$1" &> /dev/null
}

# Function to check if an AUR helper is available
check_aur_helper() {
    if command -v paru &> /dev/null; then
        echo "paru"
    elif command -v yay &> /dev/null; then
        echo "yay"
    else
        echo "none"
    fi
}

# Install official packages
echo "Installing packages from official repositories..."
OFFICIAL_PACKAGES=(
    "btop"
    "fastfetch"
    "hyprland"
    "kitty"
    "lf"
    "mpv"
    "obs-studio"
    "python-pywal"
    "rofi"
    "starship"
    "waybar"
    "zsh"
)

TO_INSTALL_OFFICIAL=()
for package in "${OFFICIAL_PACKAGES[@]}"; do
    if ! check_package "$package"; then
        TO_INSTALL_OFFICIAL+=("$package")
    fi
done

if [ ${#TO_INSTALL_OFFICIAL[@]} -gt 0 ]; then
    echo "Installing official packages: ${TO_INSTALL_OFFICIAL[*]}"
    sudo pacman -S --needed --noconfirm "${TO_INSTALL_OFFICIAL[@]}"
else
    echo "All official packages are already installed."
fi

# Install AUR packages
echo "Installing packages from AUR..."
AUR_PACKAGES=(
    "anytype-bin"
    "ctpv"
    "librewolf-bin"
    "ttf-font-awesome"
    "warp-terminal-bin"
    "wlogout"
    "yandex-music"
    "yay"
)

AUR_HELPER=$(check_aur_helper)
if [ "$AUR_HELPER" = "none" ]; then
    echo "No AUR helper found. Installing yay first..."
    # Install yay manually
    CURRENT_DIR=$(pwd)
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$CURRENT_DIR"
    AUR_HELPER="yay"
fi

TO_INSTALL_AUR=()
for package in "${AUR_PACKAGES[@]}"; do
    if ! check_package "$package"; then
        TO_INSTALL_AUR+=("$package")
    fi
done

if [ ${#TO_INSTALL_AUR[@]} -gt 0 ]; then
    echo "Installing AUR packages: ${TO_INSTALL_AUR[*]}"
    $AUR_HELPER -S --needed --noconfirm "${TO_INSTALL_AUR[@]}"
else
    echo "All AUR packages are already installed."
fi

# Create necessary directories
echo "Creating directories..."
mkdir -p ~/.config
mkdir -p ~/.local/share/fonts
mkdir -p ~/wallpaper
mkdir -p ~/.cache/wal

# Copy configuration files
echo "Copying configuration files..."
cp -r .config/* ~/.config/
cp .zshrc ~/
cp .bashrc ~/
cp .bash_profile ~/
cp .profile ~/
cp .zshenv ~/

# Copy wallpapers
echo "Copying wallpapers..."
cp -r wallpaper/* ~/wallpaper/

# Copy fonts
echo "Copying fonts..."
cp fonts/* ~/.local/share/fonts/

# Copy pywal cache
echo "Copying pywal cache..."
cp -r wal-cache/* ~/.cache/wal/

# Update font cache
echo "Updating font cache..."
fc-cache -fv

# Set proper permissions
echo "Setting permissions..."
chmod -R 755 ~/.config
chmod 644 ~/.zshrc ~/.bashrc ~/.bash_profile ~/.profile ~/.zshenv

# Restore pywal theme
echo "Restoring pywal theme..."
if command -v wal &> /dev/null; then
    wal -R
    echo "Pywal theme restored!"
else
    echo "Pywal not found. Install python-pywal and run 'wal -R' to restore the theme."
fi

echo "Configuration restoration completed!"
echo "All packages have been installed and configurations have been restored."
echo "You may need to restart your shell or logout/login for changes to take effect."
echo "To switch to zsh (if not already): chsh -s /usr/bin/zsh"
