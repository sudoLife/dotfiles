#!/bin/bash

vga=$(xrandr --query | sed -n "s|^VGA-1\s\([a-z]*\).*$|\1|p")
hdmi=$(xrandr --query | sed -n "s|^HDMI-1\s\([a-z]*\).*$|\1|p")

if [[ "$hdmi" = "connected" || "$vga" == "connected" ]]
then
	bspc monitor LVDS-1 --remove
	xrandr --output LVDS-1 --off
	
	if [ "$hdmi" = "connected" ]
	then
		xrandr --output HDMI-1 --mode 1920x1080
		bspc monitor HDMI-1 -d I II III IV V VI
		bspc monitor --focus HDMI-1
	fi

	if [ "$vga" == "connected" ]
	then
		bspc monitor VGA-1 -d I II III IV V VI
		bspc monitor --focus VGA-1
	fi

	if [[ "$hdmi" = "connected" && "$vga" = "connected" ]]
	then
		xrandr --output HDMI-1 --right-of VGA-1
		bspc monitor VGA-1 -d I II III
		bspc monitor HDMI-1 -d IV V VI 
		bspc monitor --focus HDMI-1
	fi
fi	

# Replace with your own wallpaper
feh --bg-fill Pictures/wallpapers/mountains.jpg
