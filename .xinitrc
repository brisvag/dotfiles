#!/bin/sh
xrdb -merge ~/.Xresources
~/.config/xrandr/screen_layout.sh
exec i3
