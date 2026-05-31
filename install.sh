#!/bin/bash

# Color-coded logging
info()    { echo -e "\e[34m[INFO]\e[0m $*"; }
success() { echo -e "\e[32m[OK]\e[0m $*"; }
warn()    { echo -e "\e[33m[WARN]\e[0m $*"; }
error()   { echo -e "\e[31m[ERROR]\e[0m $*"; exit 1; }

# Check if script is run as root
if [[ $EUID -eq 0 ]]; then
   error "This script must not be run as root. Please run as a regular user."
fi

# Detect distribution and set package manager
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
        # Handle Manjaro specifically
        if [[ "$NAME" == "Manjaro Linux" ]]; then
            OS="Manjaro Linux"
        fi
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [[ -f /etc/lsb-release ]]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [[ -f /etc/debian_version ]]; then
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [[ -f /etc/SuSe-release ]]; then
        OS=SuSE
        VER=$(cat /etc/SuSe-release)
    elif [[ -f /etc/redhat-release ]]; then
        OS=Red Hat
        VER=$(cat /etc/redhat-release)
    else
        OS=$(uname -s)
        VER=$(uname -r)
    fi
}

detect_distro

# Set package manager based on OS
case "$OS" in
    *"Arch Linux"*|*"Manjaro Linux"*)
        PKG_MANAGER="pacman"
        PKG_INSTALL="sudo pacman -S --noconfirm"
        PKG_UPDATE="sudo pacman -Sy"
        PKG_CHECK="pacman -Ss"
        ;;
    *"Fedora"*|*"Red Hat"*|*"CentOS"*)
        PKG_MANAGER="dnf"
        PKG_INSTALL="sudo dnf install -y"
        PKG_UPDATE="sudo dnf check-update"
        PKG_CHECK="dnf list"
        ;;
    *"Ubuntu"*|*"Debian"*|*"Linux Mint"*)
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
        PKG_UPDATE="sudo apt update"
        PKG_CHECK="apt-cache policy"
        ;;
    *)
        warn "Unsupported distribution: $OS"
        warn "Defaulting to apt (may not work correctly)"
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
        PKG_UPDATE="sudo apt update"
        PKG_CHECK="apt-cache policy"
        ;;
esac

info "Detected distribution: $OS $VER"
info "Using package manager: $PKG_MANAGER"

# List of packages to install
PACKAGES=(
    "hyprland"
    "waybar"
    "rofi"
    "kitty"
    "swaync"
    "wallust"
    "matugen"
    "wget"      # needed for font download
    "unzip"     # needed for font extraction
    "fontconfig" # for fc-cache
)

# Check if packages are available in repositories
info "Checking package availability..."
for pkg in "${PACKAGES[@]}"; do
    if ! $PKG_CHECK "$pkg" >/dev/null 2>&1; then
        warn "Package '$pkg' not found in repositories. May fail during installation."
    else
        success "Package '$pkg' found in repositories."
    fi
done

# Update package repositories
info "Updating package repositories..."
if ! $PKG_UPDATE; then
    warn "Repository update failed. Continuing anyway..."
fi

# Backup existing config files
info "Backing up existing config files..."
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/.config.bak-$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

CONFIG_DIRS=("hyprland" "waybar" "rofi" "kitty" "swaync")
for dir in "${CONFIG_DIRS[@]}"; do
    if [[ -d "$HOME/.config/$dir" ]]; then
        mv "$HOME/.config/$dir" "$BACKUP_DIR/"
        success "Backed up $HOME/.config/$dir to $BACKUP_DIR/$dir"
    fi
done

# Install packages
info "Installing required packages..."
if ! $PKG_INSTALL "${PACKAGES[@]}"; then
    error "Package installation failed. Check the output above for details."
fi
success "All packages installed successfully."

# Deploy configs
info "Deploying dotfiles..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Copy config files
if [[ -d "$DOTFILES_DIR/.config" ]]; then
    cp -r "$DOTFILES_DIR/.config/"* "$HOME/.config/"
    success "Copied config files to $HOME/.config"
else
    warn "No .config directory found in dotfiles repository at $DOTFILES_DIR/.config"
fi

# Copy bin files
if [[ -d "$DOTFILES_DIR/.local/bin" ]]; then
    mkdir -p "$HOME/.local/bin"
    cp -r "$DOTFILES_DIR/.local/bin/"* "$HOME/.local/bin/"
    success "Copied bin files to $HOME/.local/bin"
else
    warn "No .local/bin directory found in dotfiles repository at $DOTFILES_DIR/.local/bin"
fi

# Set permissions for bin files
info "Setting permissions for executable files..."
find "$HOME/.local/bin" -type f -exec chmod +x {} \;
success "Permissions set for executables in $HOME/.local/bin"

# Install JetBrains Nerd Font
info "Installing JetBrains Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR" || error "Failed to access font directory"

# Download latest JetBrains Nerd Font
if ! wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip; then
    error "Failed to download JetBrains Nerd Font"
fi

# Extract font
if ! unzip -q JetBrainsMono.zip; then
    error "Failed to extract JetBrains Nerd Font"
fi
rm JetBrainsMono.zip

# Update font cache
if ! fc-cache -fv >/dev/null 2>&1; then
    warn "Font cache update failed. You may need to run 'fc-cache -fv' manually."
else
    success "Font cache updated successfully."
fi

# Final summary
echo
success "Installation completed successfully!"
echo
info "Summary:"
info "- Packages installed: ${PACKAGES[*]}"
info "- Config files backed up to: $BACKUP_DIR"
info "- Dotfiles deployed from: $DOTFILES_DIR"
info "- JetBrains Nerd Font installed to: $FONT_DIR"
info
info "Next steps:"
info "1. Restart your Hyprland session (Super + Shift + R)"
info "2. Set wallpaper with: wallset"
info "3. Enjoy your newly riced Linux system!"