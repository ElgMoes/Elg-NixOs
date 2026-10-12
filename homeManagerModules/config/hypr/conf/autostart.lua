-- Load Wallpaper
hl.exec_cmd("hyprpaper")

-- Load Notification Daemon
hl.exec_cmd("swaync")

-- Load cliphist history
hl.exec_cmd("wl-paste --watch cliphist store")

-- Soundboard manager
hl.exec_cmd("~/.scripts/soundboard-init.sh")
