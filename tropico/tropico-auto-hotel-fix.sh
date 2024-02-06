#!/bin/bash

# Watches tropico's save folder for "s-" prefixed (s for scenario) saves and converts them into a FixHotel patched scenario

# Update paths to your specific setup if required. If installed using the Lutris script no alterations should be nessesary.

# Tropico's Wine Prefix
PREFIX="$HOME/Games/gog/tropico";

# Tropico's root folder
DIR="$PREFIX/drive_c/GOG Games/Tropico";

# Tropico's games folder (saves)
GAMES="$DIR/game/";

# Tropico's maps folder (scenarios)
MAPS="$DIR/maps";

# where is the FixHotel folder and other extras
FIXHOTEL="$PREFIX/extras/FixHotel";

inotifywait -m -e moved_to -e create "$GAMES" --format "%f" | while read f
do
    if [[ $f = s-*.GM2 ]]; then
	cd "$DIR";
	echo "Moving $f to root dir...";
	mv "$GAMES/$f" "$DIR";
	echo "Getting new file name and renaming...";
	new_file=`echo $f | sed 's/\(.*\.\)GM2/\1mp2/'`;
	mv "$DIR/$f" "$DIR/"`echo $f | sed 's/\(.*\.\)GM2/\1mp2/'`;
	echo "Extracting $new_file ...";
	wineconsole eventget.exe $new_file;
	echo "Getting new map folder name and applying patch...";
	mdir=`echo $new_file | sed 's/.mp2//'`;
	cp -r "$FIXHOTEL" "$DIR/$mdir";
	echo "Recompiling $new_file ...";
	wineconsole eventadd.exe $new_file;
	mv $new_file "$MAPS";
    fi
done
