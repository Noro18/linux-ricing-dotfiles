
#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-3"
theme='style-4'
WALL_DIR="$HOME/.config/wallpapers"
SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CWD="$(pwd)"
# Build list of wallpaper filenames (include extensions)
# list=""
# for img in "$WALL_DIR"/*.{jpg,png}; do
#     [ -f "$img" ] || continue
#     name=$(basename "$img")
#     list+="$name\n"
# done

# # Show Rofi menu (no icons)
# chosen=$(echo -e "$list" | rofi -dmenu -i -p "Wallpaper" \
#     -theme "${dir}/${theme}.rasi")

IFS=$'\n'
cd "$WALL_DIR" || exit

chosen=$(for a in *.jpg *.png; do echo -en "$a\0icon\x1f$a\n" ; done | rofi -dmenu -p "Select Wallpaper" -theme "${dir}/${theme}.rasi")

if [ -n "$chosen" ]; then
    # call walset.sh with the chosen filename (including extension)
    "$SCRIPTDIR/walset.sh" "$WALL_DIR/$chosen"
fi

cd "$CWD" || exit