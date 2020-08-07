#!/bin/bash

sleep 2

# initialize volume and brightness
amixer -q set Master 70
light -S 100

optimus-manager-qt
