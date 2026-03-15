#!/bin/bash

MODE="$1"

CONFIG="$HOME/.config/waybar/scripts/waybar-light-controls/default_values/default_temperature.conf"
temperature=$(<"$CONFIG")


if [ "$MODE" == "up" ]; then

	temperature=$((temperature + 300))
        if [ "$temperature" -gt 6500 ]; then
                temperature=6500
        fi

elif [ "$MODE" == "down" ]; then

        temperature=$((temperature - 300))
        if [ "$temperature" -lt 1500 ]; then
                temperature=1500
        fi

fi
echo "$temperature" > "$CONFIG"

echo "$temperature"
hyprctl hyprsunset temperature "$temperature" > /dev/null 2>&1
