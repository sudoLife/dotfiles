#!/bin/bash

. $HOME/.config/utilities/check_monitor.sh

vga=$(check_monitor "VGA-1")
hdmi=$(check_monitor "HDMI-1")

if [[ "$hdmi" = "connected" || "$vga" == "connected" ]]
then
	bspc monitor LVDS-1 --remove
	xrandr --output LVDS-1 --off
	
	if [ "$hdmi" = "connected" ]
	then
		xrandr --output $hdmi --mode 1920x1080
		bspc monitor $hdmi -d I II III IV V VI
		bspc monitor --focus $hdmi
	fi

	if [ "$vga" == "connected" ]
	then
		bspc monitor $vga -d I II III IV V VI
		bspc monitor --focus $vga
	fi

	if [[ "$hdmi" = "connected" && "$vga" = "connected" ]]
	then
		xrandr --output $hdmi --right-of $vga
		bspc monitor $vga -d I II III
		bspc monitor $hdmi -d IV V VI 
		bspc monitor --focus $hdmi
	fi
fi	

# Replace with your own wallpaper
feh --bg-fill $HOME/Pictures/wallpapers/mountains.jpg
