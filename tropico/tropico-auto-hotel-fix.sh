#!/bin/bash

# Watches tropico's save folder for "s-" prefixed (s for scenario) saves and converts them into a FixHotel patched scenario

# Fetch full absolute path to the scripts location, save it, and goto the directroy
PATH_TO_SCRIPT=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")");
cd "$PATH_TO_SCRIPT";

inotifywait -m -e moved_to -e create "games" --format "%f" | while read game
do
    if [[ $game = s-*.GM2 ]]; then
	echo "Moving $game to root dir...";
	mv "games/$game" .;
	echo "Getting new file name and renaming...";
	# Convert game file (.GM2) to a map file (.MP2)
	map=`echo $game | sed 's/\(.*\.\)GM2/\1mp2/'`;
	mv "$game" "$map";
	echo "Extracting $map ...";
	wineconsole eventget.exe $map;
	echo "Getting new map folder name and applying patch...";
	extracted_map=`echo $map | sed 's/.mp2//'`;
	cp -r "FixHotel" "$extracted_map";
	echo "Recompiling $map ...";
	wineconsole eventadd.exe $map;
	mv $map "maps";
	echo "Cleaning up...";
	rm -r "$extracted_map";
    fi
done
