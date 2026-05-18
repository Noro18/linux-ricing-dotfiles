# Fastfetch

A system information tool that displays system info, logo, and colors in a visually appealing way.

---

## File Structure

```
~/.config/fastfetch/
├── config.jsonc                # Main configuration (logo, modules, colors, layout)
├── configs/                    # Preset configurations (optional)
├── noros/                      # Custom logo and text files (e.g., noro.txt, shadow.txt)
├── archey.jsonc                # Alternative config (not used by default)
├── arch.txt                    # Alternative logo (not used by default)
├── fania.txt                   # Alternative logo (not used by default)
├── sharingan.txt               # Alternative logo (not used by default)
├── *.txt                       # Various logo and art files
└── managed_context/            # Metadata for applets (if used)
└── test_suite_analysis/        # Metadata for applets (if used)
```

---

## How the Files Relate

- `config.jsonc` is the main configuration that defines:
  - Which logo to display (from `noros/` or other directories)
  - The layout and order of modules (user, hostname, uptime, distro, etc.)
  - Colors for specific elements (like the logo color)
  - Custom separator and formatting
- The `noros/` directory contains custom text files used as logos (e.g., `shadow.txt`, `noro.txt`).
- Other files in `configs/` are alternative configurations that can be used by specifying them with `-c` (not used in the default setup).
- The `managed_context/` and `test_suite_analysis/` directories are used by Rofi applets for metadata and are not directly relevant to fastfetch's operation.

---

## How Colors Work

Fastfetch in this setup does **not** automatically pull colors from the wallpaper via `matugen` or `wallust`. Instead, colors are defined statically in the `config.jsonc` file.

In the default `config.jsonc`:
- The logo color is set to `"38;5;14"` (a cyan color) under the `logo.color` object.
- Module labels use color codes like `{#31}`, `{#32}`, etc., which are ANSI color codes (31=red, 32=green, 33=yellow, 34=blue, 35=magenta, 36=cyan, 37=white, 39=default).
- The `colors` module (near the bottom) displays a color circle that shows the terminal's color palette (which *is* set by wallust via the terminal colors, but fastfetch itself does not change its own colors based on the wallpaper).

To change how fastfetch colors are applied:
1. Edit `~/.config/fastfetch/config.jsonc` directly.
2. Change the `logo.color` value to a different ANSI color code or RGB value.
3. Modify the color codes in the `format` strings of modules (e.g., change `{#31}` to `{#34}` for blue).
4. Alternatively, replace the logo file in `~/.config/fastfetch/noros/` with a different ASCII art and adjust its color.

---

## Key Configuration Options in config.jsonc

- `logo.source`: Path to the logo file (default: `~/.config/fastfetch/noros/shadow.txt`).
- `logo.color`: ANSI color code for the logo (default: `"38;5;14"`).
- `modules`: Array of objects defining what to display and in what order.
  - Each module has a `type` (e.g., `user`, `host-name`, `uptime`, `os`, `kernel`, `de`, `terminal`, `shell`, `cpu`, `disk`, `memory`, `localip`, `colors`, `custom`).
  - `key`: The text to display (can include formatting like `{#31}` for color and `{user-name}` for variables).
  - `format`: How to format the value (if applicable).
- `display.separator`: The separator between the key and value (default: a space).
- Custom modules (type: `custom`) are used for drawing lines and boxes (e.g., `╭───────────╮`).

---

## How Fastfetch Relates to the Theming Pipeline

Fastfetch is not automatically part of the wallpaper-driven theming pipeline. However:
- The terminal's color palette (used by the `colors` module) is set by `wallust` and thus reflects the wallpaper colors.
- Users can manually update fastfetch's colors to match the new wallpaper by editing `config.jsonc` or by creating a script that regenerates the config based on the wallpaper (not currently set up in this rice).

---

## ⚠️ Things Not to Edit Manually (in this setup)

There are no auto-generated files for fastfetch in this setup. All configuration is static and under user control. However, if you wish to keep the setup consistent, avoid changing the logo source or module types unless you intend to change the displayed information.
