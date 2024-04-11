#!/bin/sh

xsetwacom set "Wacom Cintiq Pro 24 Touch Finger touch" Touch Off
xsetwacom -v set "Wacom Cintiq Pro 24 Pen stylus" MapToOutput "HEAD-2"  # stylus
xsetwacom -v set "Wacom Cintiq Pro 24 Pen eraser" MapToOutput "HEAD-2"  # eraser
xsetwacom set "Wacom Express Key Remote Pad pad" AbsWheelDown "key +ctrl button 5 key -ctrl"  # scroll on remote
xsetwacom set "Wacom Express Key Remote Pad pad" AbsWheelUp "key +ctrl button 4 key -ctrl"
xsetwacom set "Wacom Express Key Remote Pad pad" Button 21 "key +Shift_L"  # bottom left on remote
xsetwacom set "Wacom Express Key Remote Pad pad" Button 22 "key +ctrl"  # bottom right on remote
xsetwacom set "Wacom Express Key Remote Pad pad" Button 10 "key space"  # below scroll on remote
xsetwacom set "Wacom Express Key Remote Pad pad" Button 2 "key +ctrl Z -ctrl"  # left of scroll on remote
xsetwacom set "Wacom Express Key Remote Pad pad" Button 9 "key +ctrl Y -ctrl"  # right of scroll on remote
