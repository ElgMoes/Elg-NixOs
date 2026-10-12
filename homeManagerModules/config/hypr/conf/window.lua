-- -----------------------------------------------------
-- General window layout and colors
-- name: "Default"
-- -----------------------------------------------------

local colors = require("colors")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 3,
		["col.active_border"] = colors.color6,
		["col.inactive_border"] = colors.color3,
		layout = "dwindle",
		resize_on_border = true,
	},
})
