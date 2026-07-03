-- ╔══════════════════════════════════════╗
-- ║        HYPRLAND MAIN CONFIG          ║
-- ║   https://wiki.hyprland.org/         ║
-- ╚══════════════════════════════════════╝

-- ── Monitors ──────────────────────────────────────────────────────────
-- ── Sources ───────────────────────────────────────────────────────────

-- dofile(os.getenv("HOME") .. "/.config/hypr/colors/colors.lua")
require("configurations.keybinds")

-- ── Autostart ─────────────────────────────────────────────────────────
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("awww-daemon")
	-- hl.exec_cmd("wallset-backend ~/.config/wallpapers/f.")
	hl.exec_cmd("start-waybar")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("~/.config/hypr/scripts/waybar-light-controls/hyprsunset_init.sh")
	hl.exec_cmd('export PATH="$PATH $HOME/.local/bin"')

	hl.exec_cmd("setxkbmap -option compose:ralt")
	hl.exec_cmd("battery_monitor")
	hl.exec_cmd("sudo input-remapper-service")
end)

-- ── Environment Variables ─────────────────────────────────────────────
hl.env("XCURSOR_THEME", "breeze")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- KVM / software rendering fallback
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-- ── Input ─────────────────────────────────────────────────────────────
hl.config({
	input = {
		kb_layout = "us",
		kb_options = "compose:ralt",

		follow_mouse = 1,
		sensitivity = 0, -- -1.0 to 1.0, 0 = no modification

		touchpad = {
			natural_scroll = true,
		},
	},
})
-- ── General ───────────────────────────────────────────────────────────
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 12,
		layout = "dwindle",
		border_size = 0,
	},

	-- ── Decoration ────────────────────────────────────────────────────────
	decoration = {
		rounding = 12,
		rounding_power = 4.0,
		active_opacity = 0.95,
		inactive_opacity = 0.90,

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
		},

		shadow = {
			enabled = true,
			range = 10,
			render_power = 1,
			sharp = false,
			offset = { 0, 2 },
		},

		-- motion_blur = {
		-- 	enabled = true,
		-- },
	},
})
--Workspace overview swipe gesture
-- hyprexpo-gesture = 3, vertical, expo  -- hyprexpo is no longer maintained
-- gesture = 3, down, dispatcher, overview:toggle

-- workspace swipe gesture
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Expo gesture for opening

hl.plugin.hyprexpo.gesture({
	fingers = 3,
	direction = "up",
	action = "expo",
})

-- Vim Motion binds for navigation

hl.define_submap("hyprexpo", function()
	hl.bind("h", function()
		hl.plugin.hyprexpo.kb_focus("left")
	end)
	hl.bind("l", function()
		hl.plugin.hyprexpo.kb_focus("right")
	end)
	hl.bind("k", function()
		hl.plugin.hyprexpo.kb_focus("up")
	end)
	hl.bind("j", function()
		hl.plugin.hyprexpo.kb_focus("down")
	end)
	hl.bind("return", function()
		hl.plugin.hyprexpo.kb_confirm()
	end)
	hl.bind("escape", function()
		hl.plugin.hyprexpo.expo("cancel")
	end)
end)

hl.config({

	plugin = {
		hyprexpo = {
			columns = 3,
			gaps_in = 5,
			gaps_out = 0,
			bg_col = "rgb(111111)",
			workspace_method = "center first",
			gesture_distance = 200,
			cancel_key = "escape",
			show_cursor = 1,
			skip_empty = 0,
			max_workspace = 10,
		},
	},

	-- ── Animations ────────────────────────────────────────────────────────
	animations = {
		enabled = true,
	},

	-- ── Layout ────────────────────────────────────────────────────────────
	dwindle = {
		-- pseudotile     = true --discarded from hyprland v0.55 onwards
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	-- ── Misc ──────────────────────────────────────────────────────────────
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 0,
	},
})

hl.curve("MySmooth", { type = "bezier", points = { { 0.125, 0.706 }, { 0.245, 0.955 } } })
hl.curve("overshoot", { type = "bezier", points = { { 0, 1.6 }, { 0.28, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "default", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "MySmooth", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "smooth", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "smooth", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "MySmooth", style = "slidevert" })
-- ── Layer Rules ───────────────────────────────────────────────────────
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.7 })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, animation = "slide right" })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide right" })

-- Animation for swww-daemon
-- animation = layers, 1,
hl.layer_rule({ match = { namespace = "awww-daemon" }, animation = "fade" })

-- layerrule = animation rofi_anim, rofi
-- hl.layer_rule({  match = { namespace = ".*"}, blur_popups=true  })

hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "MySmooth", style = "slide" })

-- hl.layer_rule({
-- 	match = { namespace = "rofi" },
-- 	animation = "layers",
-- })

-- ── Window Rules ──────────────────────────────────────────────────────
hl.window_rule({ match = { class = "org.oe-f.openboard" }, no_blur = true })

-- ── Window Rules Complex GUI specific toolsbar flickering ──────────────────────────────────────────────────────
hl.window_rule({
	--    name = "android-studio-rule",
	match = {
		class = "^(jetbrains-.*|android-studio)$",
		title = "^(win[0-9]+)$",
	},
	float = true,
	no_focus = true,
	decorate = true,
})
-- Desktop Editor
hl.window_rule({
	--    name = "desktopeditors-fix"
	match = {
		class = "^(DesktopEditors)$",
	},
	float = true,
	center = true,
	--    monitor = current
	workspace = "unset",
})

hl.window_rule({
	workspace = "special:notes",
	border_color = "rgb(f6c177)",
	border_size = 2,
})

hl.window_rule({
	workspace = "special:term",
	border_color = "rgb(9ccfd8)",
	border_size = 2,
})

hl.window_rule({
	workspace = "special:browser",
	border_color = "rgb(eb6f92)",
	border_size = 2,
})

require("monitors")
require("workspaces")

-- Define modifier key
local mainMod = "SUPER"

-- Dynamic Zoom Function
local function adjust_zoom(operation)
	-- Fetch current factor or default to 1.0
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	local new_zoom = 1.0

	if operation == "in" then
		new_zoom = current * 1.1 -- Multiplies zoom for smoother increments
	elseif operation == "out" then
		new_zoom = current / 1.1
		if new_zoom < 1.0 then
			new_zoom = 1.0 -- Prevents breaking the layout boundaries
		end
	elseif operation == "reset" then
		new_zoom = 1.0
	end

	-- Apply the new configuration state dynamically
	hl.config({
		cursor = {
			zoom_factor = new_zoom,
		},
	})
end

hl.bind(mainMod .. " + equal", function()
	adjust_zoom("in")
end, { repeating = true, description = "Zoom In" })
hl.bind(mainMod .. " + minus", function()
	adjust_zoom("out")
end, { repeating = true, description = "Zoom Out" })
hl.bind(mainMod .. " + 0", function()
	adjust_zoom("reset")
end, { description = "Reset Zoom" })
