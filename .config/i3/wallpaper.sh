#!/bin/bash

while true; do
    pscircle --output=/tmp/wp_pscircle.png  --output-width=2560 --output-height=1600 --collapse-threads=1 --tree-center=-100.0:0.0 --tree-font-face=JuliaMono --toplists-font-face=JuliaMono --cpulist-center=800.0:-100.0 --memlist-center=800.0:100.0
    sleep 1
    feh --no-fehbg --bg-fill /tmp/wp_pscircle.png
    sleep 3
done
