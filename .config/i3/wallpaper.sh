#!/bin/bash

while true; do
    pscircle --output=/tmp/wp_pscircle.png
    sleep 1
    feh --no-fehbg --bg-fill ~/pictures/arch-linux-wallpaper.png --bg-fill ~/pictures/arch-linux-wallpaper.png --bg-fill /tmp/wp_pscircle.png
    sleep 10
done
