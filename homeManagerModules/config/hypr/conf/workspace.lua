-- -----------------------------------------------------
-- General workspace rules
-- name: "Default"
-- -----------------------------------------------------

hl.workspace_rule({
	workspace = "1",
	monitor = "DP-1",
	default = true,
})

hl.workspace_rule({
	workspace = "2",
	monitor = "HDMI-A-1",
	default = true,
})

hl.workspace_rule({
	workspace = "name:discord",
	monitor = "HDMI-A-1",
	on_created_empty = "discord",
})

hl.workspace_rule({
	workspace = "name:gaming",
	monitor = "DP-1",
	no_border = true,
	no_rounding = true,
	no_shadow = true,
	decorate = false,
})

hl.workspace_rule({
	workspace = "name:steam",
	monitor = "DP-1",
	on_created_empty = "steam -e",
})

hl.workspace_rule({
	workspace = "special:music",
	on_created_empty = "spotify-launcher",
	gaps_out = 100,
})

hl.workspace_rule({
	workspace = "special:terminal",
	on_created_empty = "kitty -o font_size=10",
	gaps_out = 100,
})

hl.workspace_rule({
	workspace = "special:files",
	on_created_empty = "nautilus",
	gaps_out = 100,
})

hl.workspace_rule({
	workspace = "special:default",
	gaps_out = 100,
})
