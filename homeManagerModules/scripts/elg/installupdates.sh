#!/usr/bin/env bash

sleep 1
clear
figlet -f smslant "Updates"
echo

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

if gum confirm "DO YOU WANT TO START THE UPDATE NOW?"; then
    echo
    echo ":: Update started."
elif [ $? -eq 130 ]; then
    exit 130
else
    echo
    echo ":: Update canceled."
    exit
fi

_isInstalled() {
    pacman -Qi "$1" &>/dev/null
}

yay -Syyu

if _isInstalled flatpak; then
    flatpak upgrade
fi

notify-send "Update complete"
echo
echo ":: Update complete"
echo
echo

if _isInstalled clamav; then
    if gum confirm "Update malware signatures and scan downloaded packages?"; then
        echo ":: Updating signatures..."
        sudo freshclam --verbose --stdout
        echo ":: Scanning downloaded packages..."
        sudo clamscan -r --infected --no-summary --verbose /var/cache/pacman/pkg

	notify-send "Scanning complete"
	echo
	echo ":: Scanning complete"
	echo
	echo
    fi
fi

echo "Press [ENTER] to close."
read
