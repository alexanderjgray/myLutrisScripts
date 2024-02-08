#!/bin/bash

# Watches tropico's save folder for "s-" prefixed (s for scenario) saves and converts them into a FixHotel patched scenario

# Update paths to your specific setup if required. If installed using the Lutris script no alterations should be nessesary.

# Tropico's Wine Prefix
PREFIX="$HOME/Games/gog/tropico";
echo "$PREFIX";

# Tropico's root folder
TROPICO="$PREFIX/drive_c/GOG Games/Tropico";
echo "$TROPICO";

# Tropico's games folder (saves)
GAMES="$TROPICO/game";
echo "$GAMES";

# Tropico's maps folder (scenarios)
MAPS="$TROPICO/maps";
echo "$MAPS";

# where is the FixHotel folder and other extras
FIXHOTEL="$PREFIX/extras/FixHotel";
echo "$FIXHOTEL";

inotifywait -m -e moved_to -e create "$GAMES" --format "%f" | while read f
do
    if [[ $f = s-*.GM2 ]]; then
	cd "$TROPICO";
	echo "Moving $f to root dir...";
	mv "$GAMES/$f" "$TROPICO";
	echo "Getting new file name and renaming...";
	new_file=`echo $f | sed 's/\(.*\.\)GM2/\1mp2/'`;
	mv "$TROPICO/$f" "$TROPICO/"`echo $f | sed 's/\(.*\.\)GM2/\1mp2/'`;
	echo "Extracting $new_file ...";
	wineconsole eventget.exe $new_file;
	echo "Getting new map folder name and applying patch...";
	new_map_folder=`echo $new_file | sed 's/.mp2//'`;
	cp -r "$FIXHOTEL" "$TROPICO/$new_map_folder";
	echo "Recompiling $new_file ...";
	wineconsole eventadd.exe $new_file;
	mv $new_file "$MAPS";
    fi
done
