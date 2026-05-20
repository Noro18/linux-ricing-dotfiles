-- This is the migrated Hyprland Lua config file.
-- Migrated from hyprland.conf
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60.0",
	position = "0x0",
	scale = 1.0,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60.0",
	position = "1920x0",
	scale = 1.0,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local fileManager = "thunar" -- Changed from dolphin to thunar based on keybinds
local menu = "launcher" -- Using generic launcher based on keybinds
local browser = "zen-browser"
local editor = "code" -- Using code based on keybinds
-- local cursor    = "cursor"    -- This might be a custom script

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("awww-daemon &")
	hl.exec_cmd("waypaper --restore")
	hl.exec_cmd("start-waybar & nm-applet --indicator & swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset &")
	hl.exec_cmd("~/.config/hypr/scripts/waybar-light-controls/hyprsunset_init.sh")
	hl.exec_cmd("setxkbmap -option compose:ralt")
	hl.exec_cmd("battery_monitor &")
	hl.exec_cmd("sudo input-remapper-service")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_THEME", "breeze")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- KVM / software rendering fallback
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = { 8, 0, 0, 0 }, -- Converted from "8 0 0 0"
		gaps_out = { 8, 16, 16, 16 }, -- Converted from "8 16 16 16"

		border_size = 0, -- Commented in original, but setting explicitly

		col = {
			active_border = { colors = { "$primary" }, angle = 0 }, -- Using primary color from colors.conf
			inactive_border = "$(rgba(595959aa))", -- Keeping original format
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 12,
		rounding_power = 2, -- Assuming default value since not specified

		-- Change transparency of focused and unfocused windows
		active_opacity = 0.95,
		inactive_opacity = 0.86,

		shadow = {
			enabled = true,
			range = 1,
			render_power = 5,
			color = 0xee000000, -- Black shadow with alpha
		},

		blur = {
			enabled = true,
			size = 2,
			passes = 3,
			vibrancy = 0.0, -- Using default since new_optimizations is true
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Custom bezier from config
hl.curve("MySmooth", { type = "bezier", points = { { 0.484, 0.039 }, { 0.324, 0.991 } } })

-- Override animations with custom settings
hl.animation({ leaf = "layers", enabled = true, speed = 1, bezier = "MySmooth", style = "slide" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "default", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default", style = "slidefade 90%" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
		pseudotile = true, -- Added from configurations
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- From configurations
		disable_splash_rendering = true, -- From configurations
		vrr = 0, -- From configurations
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "compose:ralt", -- From configurations
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true, -- From configurations
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "expo", -- For hyprexpo gesture
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(
	mainMod .. " + ALT + RETURN",
	hl.dsp.exec_cmd(
		string.format(
			'paplay --volume=32768 "%s/.config/hypr/config_Kitty-Efeckt_rezero_death.mp3" & kitty',
			os.getenv("HOME")
		)
	)
)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cursor")) -- Assuming cursor is a command
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.local/bin/killall")) -- close_all_windows from keybinds
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/.local/bin/killall"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pkill rofi || launcher"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("pkill rofi || battery"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill rofi || wallset"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("pkill rofi || wallset-dark"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill rofi || waybar-menu"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("pkill rofi || ~/.config/rofi/applets/bin/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofimoji --action copy"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("pkill rofi || focus-menu"))
hl.bind(mainMod .. " + J", hl.dsp.layout("swapsplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true, repeating = true }) -- Assuming same for mic
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

-- Ignore maximize requests from all apps. You'll probably like this.
local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- No blur for specific app
hl.window_rule({
	name = "no_blur_openboard",
	match = { class = "org.oe-f.openboard" },
	blur = { enabled = false },
})

-- Android Studio rules
hl.window_rule({
	name = "android-studio-rule",
	match = {
		class = "^(jetbrains-.*|android-studio)$",
		title = "^(win[0-9]+)$",
	},
	float = true,
	no_focus = true,
	rounding = 20,
	decorate = true,
	border_size = 2,
})

-- Desktop Editor rule
hl.window_rule({
	name = "desktopeditors-fix",
	match = { class = "^(DesktopEditors)$" },
	float = true,
	center = true,
	monitor = "current",
	workspace = "unset",
})

-- Layer rules for waybar
hl.layer_rule({
	name = "waybar-blur",
	match = { namespace = "waybar" },
	blur = { enabled = true },
})

hl.layer_rule({
	name = "waybar-ignore-alpha",
	match = { namespace = "waybar" },
	ignore_alpha = true,
})

-- Layer rules for rofi
hl.layer_rule({
	name = "rofi-blur",
	match = { namespace = "rofi" },
	blur = { enabled = true },
})

hl.layer_rule({
	name = "rofi-ignore-alpha",
	match = { namespace = "rofi" },
	ignore_alpha = { 0.7, 0.7 }, -- Matching the original layerrule format
})

-- Animation for swaync
hl.layer_rule({
	name = "swaync-notification-anim",
	match = { namespace = "swaync-notification-window" },
	animation = { name = "slide", direction = "right" },
})

hl.layer_rule({
	name = "swaync-control-center-anim",
	match = { namespace = "swaync-control-center" },
	animation = { name = "slide", direction = "right" },
})

-- Animation for awww-daemon
hl.layer_rule({
	name = "awww-daemon-fade",
	match = { namespace = "awww-daemon" },
	animation = { name = "fade" },
})

-- Workspace configurations from workspaces.conf
hl.workspace({
	id = 1,
	monitor = "eDP-1",
	default = true,
})

hl.workspace({
	id = 2,
	monitor = "eDP-1",
})

hl.workspace({
	id = 3,
	monitor = "eDP-1",
})

hl.workspace({
	id = 4,
	monitor = "HDMI-A-1",
	default = true,
})

hl.workspace({
	id = 5,
	monitor = "HDMI-A-1",
})

hl.workspace({
	id = 6,
	monitor = "HDMI-A-1",
})

hl.workspace({
	id = 7,
	monitor = "HDMI-A-1",
})

hl.workspace({
	id = 8,
	monitor = "HDMI-A-1",
})

hl.workspace({
	id = 9,
	monitor = "HDMI-A-1",
})

hl.workspace({
	id = 10,
	monitor = "HDMI-A-1",
})

-- Monitor reserved area from configurations
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
	reserved = { -10, 0, 0, 0 }, -- From: monitor = , addreserved, -10, 0, 0, 0
})

