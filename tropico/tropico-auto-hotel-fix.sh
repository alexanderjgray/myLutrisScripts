#!/bin/bash

# Watches tropico's save folder for "s-" prefixed (s for scenario) saves and converts them into a FixHotel patched scenario

# Update paths to your specific setup if required. If installed using the Lutris script no alterations should be nessesary, unless you do something non-standard.

# Fetch full absolute path to the scripts location, save it, and goto the directroy
PATH_TO_SCRIPT=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")");
cd "$PATH_TO_SCRIPT";

inotifywait -m -e moved_to -e create "games" --format "%f" | while read game
do
    if [[ $game = s-*.GM2 ]]; then
	echo "Moving $game to root dir...";
	mv "games/$game" .;
	echo "Getting new file name and renaming...";
	new_file=`echo $game | sed 's/\(.*\.\)GM2/\1mp2/'`;
	mv "$game" `echo $game | sed 's/\(.*\.\)GM2/\1mp2/'`;
	echo "Extracting $new_file ...";
	wineconsole eventget.exe $new_file;
	echo "Getting new map folder name and applying patch...";
	new_map_folder=`echo $new_file | sed 's/.mp2//'`;
	cp -r "FixHotel" "$new_map_folder";
	echo "Recompiling $new_file ...";
	wineconsole eventadd.exe $new_file;
	mv $new_file "maps";
	echo "Cleaning up...";
	rm -r "$new_map_folder";
    fi
done
