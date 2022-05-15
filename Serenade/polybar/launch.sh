#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)

if type "xrandr"; then
	for m in $(xrandr --query| grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload main --config=~/.config/polybar/config.ini &
	done 
else 
	polybar --reload example &
fi
