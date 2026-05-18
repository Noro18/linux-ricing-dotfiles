<div align="center">

# 〔 Noro's Hyprland Dotfiles 〕

*A Windows-inspired, color-reactive Hyprland setup with themeable bars, menus, and wallpaper-driven styling.*

</div>

---

![Desktop Preview](assets/slideshow.gif)

## Overview

This repo contains my personal Hyprland rice: a desktop that mixes Linux flexibility with a polished Windows-like visual language.  
The setup is built around dynamic wallpaper theming, switchable Waybar styles, and menus that are meant to feel cohesive instead of patched together.

## Highlights

### Dynamic Color Pipeline

Wallpaper colors flow through the desktop using **[Matugen](https://github.com/InioX/matugen)** and **[Wallust](https://codeberg.org/explosion-mental/wallust)** so the shell, notifications, terminal, and bars stay visually in sync.

<table>
  <tr>
    <td width="50%"><img src="assets/images/screenshots7.png" alt="Dynamic themed desktop preview 1"></td>
    <td width="50%"><img src="assets/images/screenshots13.png" alt="Dynamic themed desktop preview 2"></td>
  </tr>
  <tr>
    <td width="50%"><img src="assets/images/screenshots15.png" alt="Dynamic themed desktop preview 3"></td>
    <td width="50%"><img src="assets/images/screenshots11.png" alt="Dynamic themed desktop preview 4"></td>
  </tr>
</table>

### Built-In Selectors

The repo includes selectors and menu flows that make it easy to change the look without digging through every config file by hand.

| Wallpaper Selector | Waybar Style Selector |
| --- | --- |
| ![Wallpaper Selector](assets/images/wallpaper-selector.png) | ![Waybar Selector](assets/images/waybar-selector.png) |

## Windows-Inspired Themes

These screenshots from `assets/windows/` show the Windows-style direction of the rice on Linux: centered taskbar layouts, glassy panels, darker Win11-like surfaces, and launcher variants that still fit the Hyprland workflow.

<table>
  <tr>
    <td width="50%" align="center">
      <img src="assets/windows/screenshot_2026-05-17_22-27-15.png" alt="Windows-inspired Hyprland editing workspace">
      <br>
      <sub>Config-focused workspace with a Windows-style taskbar and soft glass panels.</sub>
    </td>
    <td width="50%" align="center">
      <img src="assets/windows/screenshot_2026-05-18_08-58-37.png" alt="Windows-inspired file manager and browser theme on Hyprland">
      <br>
      <sub>Integrated app styling across Thunar, Firefox, and the desktop shell.</sub>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <img src="assets/windows/screenshot_2026-05-18_08-59-29.png" alt="Windows-inspired Hyprland desktop collage">
      <br>
      <sub>Full desktop composition showing the wallpaper, widgets, and shell pieces working together.</sub>
    </td>
    <td width="50%" align="center">
      <img src="assets/windows/screenshot_2026-05-18_10-07-51.png" alt="Windows-style launcher on a bright wallpaper">
      <br>
      <sub>Launcher variant on the light wallpaper profile.</sub>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <img src="assets/windows/screenshot_2026-05-18_11-37-56.png" alt="Windows-style launcher on a dark wallpaper" width="82%">
      <br>
      <sub>Dark wallpaper profile with the same Windows-like launcher treatment.</sub>
    </td>
  </tr>
</table>

## Documentation

| Area | Link |
| --- | --- |
| Architecture Overview | [docs/architecture.md](docs/architecture.md) |
| File Structure | [docs/file-structure.md](docs/file-structure.md) |
| Theming Pipeline | [docs/theming-pipeline.md](docs/theming-pipeline.md) |
| Scripts Reference | [docs/scripts.md](docs/scripts.md) |

### Component Docs

| Component | Link |
| --- | --- |
| Waybar | [docs/components/waybar.md](docs/components/waybar.md) |
| Rofi | [docs/components/rofi.md](docs/components/rofi.md) |
| Hyprland | [docs/components/hyprland.md](docs/components/hyprland.md) |
| Kitty | [docs/components/kitty.md](docs/components/kitty.md) |
| Fastfetch | [docs/components/fastfetch.md](docs/components/fastfetch.md) |
