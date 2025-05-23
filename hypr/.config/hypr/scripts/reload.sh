#!/usr/bin/env bash

# Kill and restart Waybar and SwayNC
killall -9 waybar
killall -9 swaync

# Optional: Kill any currently running Rofi instances
killall -9 rofi

# Reload Hyprland configuration
hyprctl reload

# Restart SwayNC and Waybar
swaync &
waybar &
