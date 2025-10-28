#!/bin/bash

# Set path to wallpapers directory
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Get list of all image files in directory
wallpapers=("$WALLPAPER_DIR"/*)

# Start an infinite loop
while true; do
	# Check if wallpapers array is empty
	if [ ${#wallpapers[@]} -eq 0 ]; then
		# If array is empty, refill it with image files
		wallpapers=("$WALLPAPER_DIR"/*)
	fi

	# Select a random wallpaper from the array
	wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
	selectedWallpaper="${wallpapers[$wallpaperIndex]}"

	# Update the wallpaper using swww
	swww img "$selectedWallpaper" --transition-type any --transition-duration 3 --transition-fps 144

	# Remove the selected wallpaper from the array
	unset "wallpapers[$wallpaperIndex]"

	# Delay for 10 minutes before selecting the next wallpaper
	sleep 10m

done
