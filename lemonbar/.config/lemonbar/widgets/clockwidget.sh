#!/usr/bin/bash

Clock() {
	DATE=$(date "+%a %d")
	TIME=$(date "+%I:%M %p")
	echo -e "$DATE \uf017 $TIME"
}
