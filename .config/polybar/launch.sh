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
        bar="primary"
    else
        bar='secondary'
    fi
    MONITOR=$m polybar --reload $bar &
done

echo "Bars launched..."
