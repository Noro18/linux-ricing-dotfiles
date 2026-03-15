#!/bin/bash

MODE="$1"

CONFIG="$HOME/.config/waybar/scripts/waybar-light-controls/default_values/default_light.conf"
light=$(<"$CONFIG")                                                                         


if [ "$MODE" == "up" ]; then

        light=$((light + 10))
        if [ "$light" -gt 100 ]; then
                light=100
        fi

elif [ "$MODE" == "down" ]; then

        light=$((light - 10))
        if [ "$light" -lt 20 ]; then
                light=20
        fi     

fi
echo "$light" > "$CONFIG"             


hyprctl hyprsunset gamma "$light" > /dev/null 2>&1
