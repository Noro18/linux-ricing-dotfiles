#!/bin/zsh

# Explicit PATH so Hyprland can find everything
export PATH="$HOME/anaconda3/bin:/usr/local/bin:/usr/bin:$PATH"

# Set wallpaper and generate theme with Pywal
/home/noro18/anaconda3/bin/wal --contrast 3.6 -i ~/.config/wallpapers/blue.jpg -a 60 -b 000000

# Optional notification
notify-send "Wallpaper changed"
