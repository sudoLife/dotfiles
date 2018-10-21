#!/bin/bash

Batwidget() {
	batperc=$(acpi | sed -n "s|^.*,\s\(\S*\)%.*$|\1|p")

	if [ $batperc -eq "100" ]
	then
		echo -e "\uf240 $batperc%"
	elif [ $batperc -ge "75" ]
	then
		echo -e "\uf241 $batperc%"
	elif [ $batperc -ge "50" ]
	then
		echo -e "\uf242 $batperc%"
	elif [ $batperc -ge "25" ]
	then
		echo -e "\uf243 $batperc%"
	else
		echo -e "\uf244 $batperc%"
	fi

}
