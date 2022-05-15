#!/bin/bash

if [[ $(xrandr --query | grep " connected" | wc -l) -gt 1 ]]
then
	xrandr --output HDMI-1-0 --primary --mode 1920x1080 --rate 144.00 --right-of eDP-1 --mode 1920x1080 --rate 144.00
	bspc monitor HDMI-1-0 -d 3 4 5 6 7 8 9 0
	bspc monitor eDP-1 -d 1 2
else
	bspc monitor eDP-1 -d 1 2 3 4 5 6 7 8 9 0
fi
