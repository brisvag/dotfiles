#!/bin/bash

while true; do
    pscircle --output=/tmp/wp_pscircle.png
    sleep 1
    feh --no-fehbg --bg-fill /tmp/wp_pscircle.png
    sleep 3
done
