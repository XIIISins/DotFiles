#!/usr/local/bin/bash
set -x

screens=$(xrandr | awk '/ connected/' | wc -l)
#exec &>> /tmp/poly.log

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bars
if [ $screens -eq 2 ]; then
  polybar top &
else
  polybar top &
  polybar top-left &
  polybar top-right &
fi
