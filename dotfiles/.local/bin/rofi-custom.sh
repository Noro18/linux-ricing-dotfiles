#!/usr/bin/env bash

# Simple rofi menu
options=$'Say Hello\nOpen Terminal\nExit'

chosen=$(echo "$options" | rofi -dmenu -p "Quick Menu:")

case "$chosen" in
"Say Hello")
  # send a notification
  notify-send "Hello" "This is a hello notification"
  ;;
"Open Terminal")
  # replace alacritty with your terminal if different
  alacritty &
  ;;
"Exit" | "")
  # do nothing / exit
  ;;
*)
  # fallback: you can handle other entries here
  ;;
esac
