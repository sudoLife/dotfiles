#!/bin/bash

. $HOME/.config/utilities/check_monitor.sh

vga="VGA-1"
hdmi="HDMI-1"

vga_status=$(check_monitor $vga)
hdmi_status=$(check_monitor $hdmi)

if [[ "$hdmi_status" = "connected" || "$vga_status" == "connected" ]]
then
	bspc monitor LVDS-1 --remove
	xrandr --output LVDS-1 --off
	
	if [ "$hdmi_status" = "connected" ]
	then
		xrandr --output $hdmi --mode 1920x1080
		bspc monitor $hdmi -d I II III IV V VI
		bspc monitor --focus $hdmi
	fi

	if [ "$vga_status" == "connected" ]
	then
		bspc monitor $vga -d I II III IV V VI
		bspc monitor --focus $vga
	fi

	if [[ "$hdmi_status" = "connected" && "$vga_status" = "connected" ]]
	then
		xrandr --output $hdmi --right-of $vga
		bspc monitor $vga -d I II III
		bspc monitor $hdmi -d IV V VI 
		bspc monitor --focus $hdmi
	fi
fi	

# Replace with your own wallpaper
feh --bg-fill ~/Pictures/background/wallhaven-cyberpunk_city.png 