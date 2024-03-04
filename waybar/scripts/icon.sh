#!/bin/bash

# Fetch the current player name
player_name=$(playerctl -l | head -n 1)

# Map player names to icons
case "$player_name" in
    spotify) icon="";;
    vlc) icon="嗢";;
    firefox.instance_1_76) icon="";;
    *) icon="";; # Default music icon
esac

# Print the icon
echo $icon

