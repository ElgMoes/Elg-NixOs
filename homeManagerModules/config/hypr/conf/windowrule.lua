-- -----------------------------------------------------
-- Window rules
-- -----------------------------------------------------

-- Force tiling
hl.window_rule({
	match = { class = "^Aseprite$" },
	tile = true,
})

hl.window_rule({
	match = { class = "^protonvpn-app$" },
	tile = true,
})

-- Browser Picture-in-Picture
hl.window_rule({
	match = { title = "^Picture-in-Picture$" },
	float = true,
})

hl.window_rule({
	match = { title = "^Picture-in-Picture$" },
	pin = true,
})

hl.window_rule({
	match = { title = "^Picture-in-Picture$" },
	move = { "69.5%", "4%" },
})

-- idle inhibit
hl.window_rule({
	match = { class = ".*" },
	idle_inhibit = "fullscreen",
})

-- Steam games, non-Gamescope
hl.window_rule({
	match = { class = "^steam_app_?%d+$" },
	workspace = "name:gaming",
	monitor = "DP-1",
	fullscreen = true,
})

-- Gamescope sessions
hl.window_rule({
	match = { class = "^gamescope$" },
	workspace = "name:gaming",
	monitor = "DP-1",
	fullscreen = true,
})

-- Minecraft
hl.window_rule({
	match = { class = "^Minecraft.*$" },
	workspace = "name:gaming",
	monitor = "DP-1",
	fullscreen = true,
})

-- Music
hl.window_rule({
	match = { class = "^(Spotify)$" },
	workspace = "special:music",
})
