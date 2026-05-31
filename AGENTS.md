# Linux Rice Dotfiles Agent Guidance

## Critical Rules
- **Never edit generated color files** (marked ⚠️ in docs): They are overwritten on every wallpaper change
- Edit templates instead: `~/.config/matugen/templates/` or `~/.config/wallust/templates/`
- Generated files include:
  - `~/.config/waybar/colors.css` and `colors-waybar.css`
  - `~/.config/rofi/colors/colors-matugen.rasi`
  - `~/.config/swaync/colors-swaync.css`
  - `~/.config/hypr/colors/*`
  - `~/.cache/wallust/colors-kitty.conf`

## Essential Commands
- Change wallpaper: `wallset` (opens selector) or `Super + W`
- Random wallpaper on login: `wallset-backend-startup` (or `Super + Shift + R`)
- Apply current wallpaper theme manually: `wallset-backend`
- Reload Hyprland: `Super + Shift + R` (restarts Hyprland)
- Waybar style selector: Available through Rofi menus

## Configuration Locations
- Hyprland: `dotfiles/.config/hypr/hyprland.conf` (main entry)
- Waybar: `dotfiles/.config/waybar/config.jsonc` + styles in `custom styles/`
- Rofi: Launchers in `dotfiles/.config/rofi/launchers/`, applets in `applets/`
- Kitty: `dotfiles/.config/kitty/kitty.conf` (references wallust cache)
- Swaync: `dotfiles/.config/swaync/config.json`
- Wallpapers: `dotfiles/.config/wallpapers/` (scanned by selector)

## Path Portability
Scripts in `~/.local/bin/` have been updated to use portable paths:
- Uses `$HOME` instead of hardcoded usernames
- Relies on `$PATH` for executables when possible (wal, matugen)
- Refer to scripts for examples of portable path usage

## Theming Pipeline
1. Wallpaper set via `wallset` or `wallset-backend-startup`
2. `swww` updates wallpaper
3. `matugen` generates Material You colors → Waybar, Rofi, Swaync, Hyprland
4. `wallust` generates terminal colors → Waybar, Kitty, Hyprland
5. Components reload/Apply on next start

## Verification
- Check if changes survived wallpaper switch: Run `wallset` → pick same/wallpaper
- Test theme application: `wallset-backend` applies without changing wallpaper