#!/bin/sh
xrandr \
    --output DVI-I-0 \
    --off \
    --output DVI-I-1 \
    --mode 1920x1200 \
    --pos 0x0 \
    --rotate left \
    --dpi 96 \
    --output DP-0 \
    --off \
    --output DP-1 \
    --off \
    --output DP-3 \
    --primary \
    --mode 1920x1080 \
    --pos 1200x324 \
    --rotate normal \
    --dpi 96 \
    --output DVI-I-1-0 \
    --off \
    --output DVI-I-1-1 \
    --off \
    --output DP-1-0 \
    --off \
    --output DP-1-1 \
    --off \
    --output DP-1-2 \
    --off \
    --output DP-1-3 \
    --off
