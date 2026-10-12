#!/usr/bin/env bash
#eval $(/usr/bin/gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK

# Start polkit (for password authentication popups)
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start proton vpn in tray
#protonvpn-app &

# Start ckb-next in tray
#ckb-next --background &

# Start easyeffects in tray
#easyeffects -w &

# Run waybar
sleep 3
~/.config/waybar/launch.sh
