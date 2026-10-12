--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Monitor
-- -----------------------------------------------------
require("conf.monitor")

-- unscale wayland
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-- -----------------------------------------------------
-- Load pywal color file
-- -----------------------------------------------------
require("colors")

-- -----------------------------------------------------
-- Autostart
-- -----------------------------------------------------
hl.on("hyprland.start", function()
	require("conf.autostart")
	require("conf.cursor")
	hl.exec_cmd("~/.config/hypr/scripts/autostart.sh")
end)

-- -----------------------------------------------------
-- Load configuration files
-- -----------------------------------------------------
require("conf.keyboard")
require("conf.window")
require("conf.decoration")
require("conf.layout")
require("conf.workspace")
require("conf.misc")
require("conf.keybinding")
require("conf.windowrule")

-- -----------------------------------------------------
-- Animation
-- -----------------------------------------------------
require("conf.animation")

-- -----------------------------------------------------
-- Environment for xdg-desktop-portal-hyprland
-- -----------------------------------------------------
hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

-- -----------------------------------------------------
-- Hyprshot
-- -----------------------------------------------------
require("conf.hyprshot")

-- -----------------------------------------------------
-- Debug
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Host specifics
-- -----------------------------------------------------
require("host.main")