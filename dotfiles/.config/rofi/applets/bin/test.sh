#!/usr/bin/env bash

# Path to your icon folder
ICON_DIR="$HOME/.config/wallpapers/wal-icons"

# Define your options
OPTIONS="Option 1\nOption 2"

# Rofi command with icons
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Choose:" -show-icons -icon-theme "custom")

echo "You selected: $CHOICE"
