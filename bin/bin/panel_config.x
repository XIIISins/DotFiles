#! /bin/bash

PANEL_FIFO=/tmp/pamel-fifo
PANEL_HEIGHT=20
PANEL_WM_NAME="lemonbar"
PANEL_FONT_FAMILY=-*-erusfont-medium-*-*-*-11-*-*-*-*-*-*-*
PANEL_FONT_FAMILY2=-*-ipagothic-medium-r-*-*-8-*-*-*-*-*-*-*
#PANEL_FONT_FAMILY=-misc-terminusmod,icons-medium-r-normal--12-120-72-72-c-60-*-*
PANEL_ICON_FONT_FAMILY=-*-siji-medium-*-*-*-10-*-*-*-*-*-*-*
REFRESH_VOLUME=0.5
REFRESH_MUSIC=1
REFRESH_BATTERY=10

#num_mon=$(bspc query -M | wc -l)
num_mon=$(xrandr | grep " connected" | wc -l)
max_res=$(xrandr | grep "primary" | awk -F'[ +]' '{print $4}')
IFS=x; read -a sizes <<<"$max_res"
top_pad=$(bspc config window_gap)
side_pad=$(bspc config window_gap)
monitor_pad=$(xrandr | grep "primary" | awk -F'+' '{print $2}')
IFS=x; read -a sizes <<<"$max_res"
rwidth=$(expr ${sizes[0]} - 2 \* $side_pad)
#rwidth=$(expr ${sizes[0]})
#BAR_GEOMETRY="${rwidth}x${PANEL_HEIGHT}+$(($side_pad + $monitor_pad))+${top_pad}"
BAR_GEOMETRY="${rwidth}x${PANEL_HEIGHT}+$(($side_pad + $monitor_pad))+${top_pad}"
