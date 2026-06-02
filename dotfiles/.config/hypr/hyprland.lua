-- ╔══════════════════════════════════════╗
-- ║        HYPRLAND MAIN CONFIG          ║
-- ║   https://wiki.hyprland.org/         ║
-- ╚══════════════════════════════════════╝

-- ── Monitors ──────────────────────────────────────────────────────────
dofile(os.getenv("HOME") .. "/.config/hypr/monitors.lua")

-- ── Sources ───────────────────────────────────────────────────────────

-- dofile(os.getenv("HOME") .. "/.config/hypr/colors/colors.lua")
dofile(os.getenv("HOME") .. "/.config/hypr/configurations/keybinds.lua")

-- ── Autostart ─────────────────────────────────────────────────────────
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waypaper --restore")
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
		gaps_in = 8,
		gaps_out = 16,
		layout = "dwindle",
		border_size = 0
	},

	-- ── Decoration ────────────────────────────────────────────────────────
	decoration = {
		rounding = 12,
		active_opacity = 0.99,
		inactive_opacity = 0.96,

		blur = {
			enabled = true,
			size = 2,
			passes = 3,
			new_optimizations = true,
		},

		shadow = {
			enabled = true,
			range = 1,
			render_power = 5,
			sharp = false,
			--    ignore_window = true,
		},
	},
})
--Workspace overview swipe gesture
-- hyprexpo-gesture = 3, vertical, expo  -- hyprexpo is no longer maintained
-- gesture = 3, down, dispatcher, overview:toggle

-- workspace swipe gesture
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- hyprexpo plugin settings
hl.config({
	--[[
	plugin = {
  	hyprexpo = {
  			columns = 3
        gap_size = 5
        bg_col = $surface_container_low
        skip_empty = true
        workspace_method = current -- [center/first] [workspace] e.g. first 1 or center m+1
  	}
	}
	--]]

	-- ── Animations ────────────────────────────────────────────────────────
	animations = {
		enabled = true,
	},
	hl.curve("overshoot", { type = "bezier", points = { { 0, 1.6 }, { 0.28, 1 } } }),
	hl.curve("smooth", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } }),

	hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "default", style = "slide" }),
	hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default", style = "slidefade 90%" }),
	-- hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "smooth", style = "popin 10%" }),
	-- hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "smooth", style = "popin" }),
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


hl.curve("MySmooth", { type = "bezier", points = { {0.125, 0.706,}, {  0.245, 0.955 } } })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "MySmooth", style = "slide" })

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
	rounding = 20,
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

-- dofile(os.getenv("HOME") ..  /home/noro18/.config/hypr/plugins.conf

-- b = $mainMod SHIFT, P, exec, hyprctl layers > /tmp/layers.txt --maybe this can be a keybind?

-- HyprMod managed settings
--[[
dofile(os.getenv("HOME") ..  "/.config/hypr/hyprland-gui.conf")
--]]
