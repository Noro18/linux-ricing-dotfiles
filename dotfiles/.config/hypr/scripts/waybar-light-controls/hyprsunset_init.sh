#!/bin/bash

hyprsunset &

sleep 1

hyprctl hyprsunset gamma $(cat ~/.config/waybar/scripts/waybar-light-controls/default_values/default_light.conf)
hyprctl hyprsunset temperature $(cat ~/.config/waybar/scripts/waybar-light-controls/default_values/default_temperature.conf)
