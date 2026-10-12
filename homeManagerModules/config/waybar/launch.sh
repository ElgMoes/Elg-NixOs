#!/usr/bin/env bash
pkill waybar
sleep 0.5

theme="$HOME/.config/waybar/themes/elg"
nohup waybar -c "$theme/config" -s "$theme/default/style.css" >/dev/null 2>&1 &