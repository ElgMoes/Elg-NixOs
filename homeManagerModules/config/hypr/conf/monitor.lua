-- -----------------------------------------------------
-- Monitor Setup
-- name: "Default"
-- -----------------------------------------------------

hl.monitor({
	output = "DP-1",
	mode = "2560x1440@165",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	position = "auto-right",
	scale = "1",
})
