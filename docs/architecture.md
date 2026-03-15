# Architecture Overview

A high-level map of how all the pieces in this setup connect and interact.

---

## The Big Picture

```
Wallpaper Selection
      │
      ▼
 wallset (menu)
      │
      ▼
wallset-backend
      ├──▶ swww               → changes the wallpaper
      ├──▶ matugen            → generates Material You color tokens
      ├──▶ wallust            → generates terminal/app color scheme
      └──▶ apply scripts      → patches each component with new colors
                │
                ├──▶ Waybar      (colors-waybar.css)
                ├──▶ Rofi        (colors-matugen.rasi)
                ├──▶ Kitty       (~/.cache/wallust/colors-kitty.conf)
                ├──▶ Hyprland    (colors/)
                └──▶ Swaync      (colors-swaync.css)
```

---

## Color Generation Tools

| Tool | Role | Output location |
|------|------|-----------------|
| **matugen** | Material You palette from wallpaper | Templates → config dirs |
| **wallust** | Terminal/app palette from wallpaper | `~/.cache/wallust/` |

Both tools run every time a wallpaper is set and overwrite the color files. **Never manually edit generated color files** — they will be overwritten on the next wallpaper change.

---

## Component Dependency Map

| Component | Color source | Config entry point |
|-----------|--------------|--------------------|
| Waybar | `colors.css` + `colors-waybar.css` (generated) | `config.jsonc` |
| Rofi | `colors/colors-matugen.rasi` → `shared/colors.rasi` | per-launcher `launcher.sh` |
| Kitty | `~/.cache/wallust/colors-kitty.conf` | `kitty.conf` |
| Hyprland | `colors/` (generated) | `hyprland.conf` |
| Swaync | `colors-swaync.css` (generated) | `style.css` |

---

## Startup vs Manual Wallpaper Flow

**On startup** → `wallset-backend-startup` runs automatically, picks a random wallpaper and applies the full theming pipeline.

**Manually** → User runs `wallset` (keybind or menu), selects a wallpaper, and `wallset-backend` handles the rest.

---

## Related Docs

- [File Structure](./file-structure.md)
- [Theming Pipeline](./theming-pipeline.md)
- [Scripts Reference](./scripts.md)
- Components: [Waybar](./components/waybar.md) · [Rofi](./components/rofi.md) · [Hyprland](./components/hyprland.md) · [Kitty](./components/kitty.md)