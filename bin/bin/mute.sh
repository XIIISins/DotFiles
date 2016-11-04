#!/bin/bash
#
#

MUTE=$(pamixer --get-mute)

if [ $MUTE == "true" ]; then
	pamixer -u
else
	pamixer -m
fi
