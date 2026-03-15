# Scripts Reference

All scripts in `~/.local/bin/`.

---

## Wallpaper & Theming

### `wallset`
- **What it does:** Opens the wallpaper selector menu (Rofi-based) showing images from `~/.config/wallpapers/`
- **Calls:** `wallset-backend` after selection
- **Triggered by:** Keybind or manual terminal call

### `wallset-backend`
- **What it does:** The main theming engine — runs after a wallpaper is manually selected
- **Steps it runs:**
  1. `swww` — sets the new wallpaper
  2. `matugen` — generates Material You colors from the wallpaper
  3. `wallust` — generates terminal palette from the wallpaper
  4. Applies colors to: Waybar, Rofi, Kitty, Hyprland, Swaync
- **Called by:** `wallset`

### `wallset-backend-startup`
- **What it does:** Startup variant — picks a random wallpaper from `~/.config/wallpapers/` and runs the full theming pipeline
- **Called by:** Hyprland `exec-once` on login

### `pywal_cava`
- **What it does:** Applies pywal colors to Cava (audio visualizer)
- **Called by:** Likely part of the theming pipeline or run manually after wallpaper change

### `pywalch.sh`
- **What it does:** pywal color helper — likely patches a specific component with the current pywal palette
- **Note:** Verify exact behavior inside the script

---

## Waybar

### `waybar-menu`
- **What it does:** Opens a Rofi menu to interact with Waybar (likely show/hide or reload)
- **Triggered by:** Keybind or Waybar module click

### `waybar-set`
- **What it does:** Applies a selected Waybar style from `~/.config/waybar/custom styles/`
- **Called by:** The Waybar style selector menu

---

## Rofi

### `launcher`
- **What it does:** Opens the main Rofi app launcher
- **Triggered by:** Keybind

### `rofi-custom.sh`
- **What it does:** Opens a custom Rofi menu — likely a specific applet or modified launcher
- **Note:** Verify exact behavior inside the script

---

## Hyprland / Display

### `adjust-hyprsunset`
- **What it does:** Adjusts the hyprsunset blue light filter level (temperature or intensity)
- **Triggered by:** Keybind or manual call

### `toggle-hyprsunset`
- **What it does:** Toggles hyprsunset on/off
- **Triggered by:** Keybind

### `setfhd`
- **What it does:** Sets monitor resolution to Full HD (1920×1080)
- **Triggered by:** Manual call or keybind

### `sethd`
- **What it does:** Sets monitor resolution to HD (1280×720)
- **Triggered by:** Manual call or keybind

---

## Apps & Utilities

### `autostart_kitty`
- **What it does:** Launches Kitty on startup with specific flags or layout
- **Called by:** Hyprland `exec-once`

### `fastfetch-random`
- **What it does:** Picks a random config from `~/.config/fastfetch/configs/` and runs fastfetch with it
- **Called by:** Shell `~/.bashrc` or `~/.zshrc` on terminal open

### `battery`
- **What it does:** Outputs battery status — likely used by a Waybar custom module or applet

### `adb_wifi`
- **What it does:** Sets up ADB over Wi-Fi for Android device debugging

### `lyra-assistant`
- **What it does:** Opens or manages the Lyra AI assistant interface
- **Triggered by:** Keybind or manual call

### `open-chat-gpt`
- **What it does:** Opens ChatGPT in a browser or app window
- **Triggered by:** Keybind or Rofi quicklink

---

## Supporting Scripts (`~/.config/hypr/scripts/`)

| Script | What it does |
|--------|-------------|
| `reload-hyprpaper.sh` | Reloads hyprpaper after a wallpaper change |
| `matu.sh` | Manually triggers matugen color generation |