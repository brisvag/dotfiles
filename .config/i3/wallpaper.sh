#!/bin/bash

while true; do
    pscircle --output=/tmp/wp_pscircle.png --collapse-threads=1 --tree-center=-100.0:0.0 --tree-font-face="MesloLGS NF" --toplists-font-face="MesloLGS NF" --cpulist-center=800.0:-100.0 --memlist-center=800.0:100.0
    sleep 1
    feh --no-fehbg --bg-fill ~/pictures/arch-linux-wallpaper.png --bg-fill ~/pictures/arch-linux-wallpaper.png --bg-fill /tmp/wp_pscircle.png
    sleep 3
done
