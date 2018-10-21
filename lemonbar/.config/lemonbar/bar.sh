#!/bin/bash

scriptdir="${0%/*}"
echo $scriptdir

. $scriptdir/widgets/batwidget.sh
. $scriptdir/widgets/clockwidget.sh
. $scriptdir/widgets/kblayout.sh

while true; do
	echo -e "%{c} %{F#FFFFFF} %{B#009B9B9B} $(Clock) %{r} %{F#FFFFFF} $(Kblayout)   $(Batwidget) "
   
	sleep 1
done
