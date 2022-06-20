#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
# split on newline for loop
IFS=$'\n'
monitors=$(xrandr --query | grep " connected")
for monitor in $monitors; do
    m=$(echo $monitor | cut -d" " -f1)
    if [[ "$monitor" == *primary* ]]; then
        tray="right"
    else
        tray='none'
    fi
    MONITOR=$m TRAY=$tray polybar --reload bottom &
done

echo "Bars launched..."
