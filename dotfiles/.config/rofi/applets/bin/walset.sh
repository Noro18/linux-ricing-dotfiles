#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/wallpapers"
MONITOR="eDP-1"
HYPR_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Pick random image
FILE=$1

if [ -z "$FILE" ]; then
  notify-send "No images found in $WALLPAPER_DIR"
  exit 1
fi

export PATH="$HOME/anaconda3/bin:/usr/local/bin:/usr/bin:$PATH"

# Set wallpaper and generateasdfsdf theme with Pywal
/home/noro18/anaconda3/bin/wal --saturate 0.8 --vte -a 50 -i "$FILE" -b 000000
/home/noro18/.cargo/bin/matugen image "$FILE"

hyprctl hyprpaper preload "$FILE"
hyprctl hyprpaper wallpaper "$MONITOR","$FILE"

swaync-client -rs
pkill waybar
waybar &

# Set wallpaper live

# Restart waybar with new theme

# Update hyprpaper.conf (overwrite safely)
cat >"$HYPR_CONF" <<EOF
preload = $FILE
wallpaper = $MONITOR,$FILE
EOF

notify-send "Wallpaper changed to '$(basename "$FILE")'"
