--[[
	 ╔══════════════════════════════════════╗
	 ║         HYPRLAND KEYBINDINGS         ║
	 ║   https://wiki.hyprland.org/         ║
	 ╚══════════════════════════════════════╝
--]]
local mainMod = "SUPER"

-- ── Core ──────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(
	mainMod .. " + ALT + RETURN",
	hl.dsp.exec_cmd("paplay --volume=32768 ~/.config/hypr/config_Kitty-Efeckt_rezero_death.mp3 & kitty")
)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + SHIFT + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + TAB", function()
	hl.plugin.hyprexpo.expo("toggle")
end)

-- Toggle special workspaces
hl.bind(mainMod .. " + COMMA", hl.dsp.workspace.toggle_special("notes"))

hl.bind(mainMod .. " + PERIOD", hl.dsp.workspace.toggle_special("term"))

hl.bind(mainMod .. " + SLASH", hl.dsp.workspace.toggle_special("browser"))

-- Move focused window to special workspace
hl.bind(mainMod .. " + SHIFT + COMMA", function()
	hl.dispatch(hl.dsp.window.move({
		workspace = "special:notes",
		follow = false,
	}))
end)

hl.bind(mainMod .. " + SHIFT + PERIOD", function()
	hl.dispatch(hl.dsp.window.move({
		workspace = "special:term",
		follow = false,
	}))
end)

hl.bind(mainMod .. " + SHIFT + SLASH", function()
	hl.dispatch(hl.dsp.window.move({
		workspace = "special:browser",
		follow = false,
	}))
end)

-- ── Applications ──────────────────────────────────────────────────────
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cursor"))

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("close_all_windows"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/.local/bin/killall"))

-- ── Launchers & Menus ─────────────────────────────────────────────────
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pkill rofi || launcher"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("pkill rofi || battery"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill rofi || wallset"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("pkill rofi || wallset-dark"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill rofi || waybar-menu"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("pkill rofi || ~/.config/rofi/applets/bin/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofimoji --typer wtype --action type"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("pkill rofi || focus-menu"))

-- ── Layout (Dwindle)) ──────────────────────────────────────────────────
hl.bind(mainMod .. " + J", hl.dsp.layout("swapsplit"))

-- ── Focus ─────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- ── Workspaces ────────────────────────────────────────────────────────
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ── Move & Resize Windows ─────────────────────────────────────────────
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── System ────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill waybar; waybar &"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("wallset-backend-startup"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("wallset-dark-backend-startup"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("colorscheme-set"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("toggle-hyprsunset"))

-- ── Screenshots ───────────────────────────────────────────────────────
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		[[bash -c 'grim "$HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png" && notify-send "📸 Screenshot saved!" "Saved to ~/Pictures"']]
	)
)

hl.bind(
	"CTRL + PRINT",
	hl.dsp.exec_cmd(
		[[bash -c 'grim -g "$(slurp)" "$HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png" && notify-send "📸 Area screenshot saved!" "Saved to ~/Pictures"']]
	)
)

hl.bind(
	"ALT + PRINT",
	hl.dsp.exec_cmd(
		[[bash -c 'FILE="$HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"; grim -g "$(slurp)" "$FILE" && swappy -f "$FILE" -o "$FILE"']]
	)
)
-- ── Audio ─────────────────────────────────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))

-- ── Brightness ────────────────────────────────────────────────────────
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
