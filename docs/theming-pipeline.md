# Theming Pipeline

How colors flow from a wallpaper image all the way to every visible component.

---

## Overview

```
[Wallpaper Image]
       │
       ├──▶ matugen ──▶ Material You palette
       │                    │
       │         ┌──────────┼──────────────┐
       │         ▼          ▼              ▼
       │      Waybar      Rofi          Swaync
       │   colors.css   colors-        colors-
       │               matugen.rasi   swaync.css
       │
       └──▶ wallust ──▶ Terminal palette
                            │
                 ┌──────────┼──────────┐
                 ▼          ▼          ▼
              Waybar      Kitty     Hyprland
          colors-waybar  (cache)   colors/
              .css
```

Both `matugen` and `wallust` run on every wallpaper change. Each tool writes to different files and targets different components.

---

## Step-by-Step Flow

### 1. Wallpaper is Set

Either via `wallset` or **Super + W**  (manual) to open wallpaper selection and and when ou select the wallpaper it will call `wallset-backend` or you can just press **Super + Shift + R** `wallset-backend-startup` that function as random wallpaper setter and on login wallpaper setter. 

### 2. `swww` Changes the Wallpaper

The visible desktop wallpaper is updated immediately you can change the aniamtion inside `~/.local/bin/wallset-backend` and `wallset-backend-startup`.

### 3. `matugen` Generates a Material You Palette

Reads the wallpaper image and fills in its templates (`~/.config/matugen/templates/`), writing color files to:

| Output file | Used by |
|-------------|---------|
| `~/.config/waybar/colors.css` | Waybar |
| `~/.config/rofi/colors/colors-matugen.rasi` | Rofi (all launchers + applets) |
| `~/.config/swaync/colors-swaync.css` | Swaync |
| `~/.config/hypr/colors/` | Hyprland |

### 4. `wallust` Generates a Terminal Palette

Reads the wallpaper and fills its templates (`~/.config/wallust/templates/`), writing to:

| Output file | Used by |
|-------------|---------|
| `~/.config/waybar/colors-waybar.css` | Waybar |
| `~/.cache/wallust/colors-kitty.conf` | Kitty |
| `~/.cache/wallust/colors.json` | VS code (Wallust theme extension) |
| `~/.cache/wallust/colors` | VS code (Wallust theme extension) |

### 5. Components Reload

Each component picks up the new colors. Some reload automatically (e.g. Waybar via signal), others apply on next launch.

---

## Where to Make Changes

| Goal | What to edit |
|------|-------------|
| Change how colors are applied to Waybar | `~/.config/matugen/templates/` or `~/.config/wallust/templates/` |
| Change how colors are applied to Kitty | `~/.config/wallust/templates/` |
| Change Rofi color variable names | `~/.config/matugen/templates/` |
| Add a new component to the theming pipeline | Add a new template in `matugen/templates/` or `wallust/templates/` |

**Never edit generated output files directly** — they are overwritten on every wallpaper change.

---

## Tools Reference

### matugen
- Config: `~/.config/matugen/config.toml`
- Templates: `~/.config/matugen/templates/`
- Generates: Material You color tokens (primary, secondary, surface, etc.)

### wallust
- Config: `~/.config/wallust/wallust.toml`
- Templates: `~/.config/wallust/templates/`
- Generates: 16-color terminal palette (color0–color15, foreground, background)