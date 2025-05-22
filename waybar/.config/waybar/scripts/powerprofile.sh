#!/bin/bash

chosen=$(printf "performance\nbalanced\npower-saver" | rofi -dmenu -p "Power Profile")
[ -n "$chosen" ] && powerprofilesctl set "$chosen"
