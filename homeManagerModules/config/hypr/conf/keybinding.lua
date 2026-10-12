-- -----------------------------------------------------
-- Key bindings
-- name: "Default"
-- -----------------------------------------------------

-- Variables and objects
local mainMod = "SUPER"
local ELGSCRIPTS = "~/.config/elg/scripts"

local Workspaces = {
	{ key = "1", workspace = 1 },
	{ key = "2", workspace = 2 },
	{ key = "3", workspace = 3 },
	{ key = "4", workspace = 4 },
	{ key = "5", workspace = 5 },
	{ key = "6", workspace = 6 },
	{ key = "7", workspace = 7 },
	{ key = "8", workspace = 8 },
	{ key = "9", workspace = 9 },
	{ key = "0", workspace = 10 },
	{ key = "G", workspace = "name:gaming" },
	{ key = "D", workspace = "name:discord" },
	{ key = "S", workspace = "name:steam" },
}

-- Applications
hl.bind(mainMod .. " + Q", function()
	local workspace = hl.get_active_special_workspace()
	if not workspace then
		hl.dispatch(hl.dsp.exec_cmd("kitty"))
	else
		hl.dispatch(hl.dsp.exec_cmd("kitty -o font_size=10"))
	end
end)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))

-- Windows
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + C", hl.dsp.window.kill())
hl.bind(
	mainMod .. " + M",
	hl.dsp.window.fullscreen({
		mode = "maximized",
		action = "toggle",
	})
)
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({
		mode = "fullscreen",
		action = "toggle",
	})
)
hl.bind(mainMod .. " + T", hl.dsp.window.float())

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- -----------------------------------------------------
-- Workspaces
-- -----------------------------------------------------
-- Move all windows to workspace
local function moveAllWindowsToWorkspace(destination)
	local currentWs = hl.get_active_workspace()
	if currentWs == nil then
		return
	end

	for _, w in ipairs(hl.get_windows()) do
		if w.workspace ~= nil and w.workspace.id == currentWs.id then
			hl.dispatch(hl.dsp.window.move({
				workspace = destination,
				window = w,
			}))
		end
	end
end

for _, target in ipairs(Workspaces) do
	-- focus workspaces
	hl.bind(mainMod .. " + " .. target.key, hl.dsp.focus({ workspace = target.workspace }))

	-- Move active window to workspace
	hl.bind(mainMod .. " + SHIFT + " .. target.key, hl.dsp.window.move({ workspace = target.workspace }))

	-- Move all windows to workspace
	hl.bind(mainMod .. " + CTRL + " .. target.key, function()
		moveAllWindowsToWorkspace(target.workspace)
	end)
end

--- Actions
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i "))
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ELGSCRIPTS .. "/cliphist.sh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Pause", hl.dsp.exec_cmd(ELGSCRIPTS .. "/powermenu.sh"))
--hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("kitty " .. ELGSCRIPTS .. "/wallpaper.sh"))

local function toggleIntlVariant()
	local current = hl.get_config("input.kb_variant")
	if current == "intl" then
		hl.config({ ["input.kb_variant"] = "" })
		hl.dispatch(hl.dsp.exec_cmd('notify-send "Keyboard intl" "intl disabled"'))
	else
		hl.config({ ["input.kb_variant"] = "intl" })
		hl.dispatch(hl.dsp.exec_cmd('notify-send "Keyboard intl" "intl enabled"'))
	end
end

hl.bind(mainMod .. " + space", toggleIntlVariant)

-- -----------------------------------------------------
-- Submaps
-- -----------------------------------------------------
hl.define_submap("passthrough", function()
	hl.bind(mainMod .. " + P", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + P", hl.dsp.submap("passthrough"))

-- -----------------------------------------------------
-- Special
-- -----------------------------------------------------
-- Default
hl.bind(mainMod .. " + code:90", hl.dsp.workspace.toggle_special("default"))

-- Terminal
hl.bind(mainMod .. " + code:87", hl.dsp.workspace.toggle_special("terminal"))

-- File browser
hl.bind(mainMod .. " + code:88", hl.dsp.workspace.toggle_special("files"))

-- Music
hl.bind(mainMod .. " + code:89", hl.dsp.workspace.toggle_special("music"))

-- Audio
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +5%")
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%")
)

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

-- Keyboard backlight
hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))

hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))

-- Discord bindings
hl.bind("XF86Launch5", hl.dsp.send_shortcut({ mods = "CTRL + SHIFT", key = "M", window = "class:^(discord)$" }))

hl.bind("XF86Launch6", hl.dsp.send_shortcut({ mods = "CTRL + SHIFT", key = "D", window = "class:^(discord)$" }))
