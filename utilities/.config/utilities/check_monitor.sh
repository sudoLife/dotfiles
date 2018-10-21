#!/bin/bash

check_monitor() {
	echo $(xrandr --query | sed -n "s|^$1\s\([a-z]*\).*$|\1|p")
}
