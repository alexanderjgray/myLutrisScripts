#!/bin/sh

# Watches tropico's save folder for "s-" prefixed (s for scenario) saves and converts them into a FixHotel patched scenario
# If installed with Lutris Install script you should only have to replace <your_user> with your username

# the folder to watch
DIR="/home/<your_user>/Games/gog/tropico/drive_c/GOG Games/Tropico/games/"

# tropico's scenario folder
target_dir="/home/<your_user>/Games/gog/tropico/drive_c/GOG Games/Tropico/maps/"

# tropico's root folder
working_dir="/home/<your_user>/Games/gog/tropico/drive_c/GOG Games/Tropico/"

# where is the FixHotel folder and other extras
extras_dir="/home/<your_user>/Games/gog/tropico/extras/"

inotifywait -m -r -e moved_to -e create "$DIR" --format "%f" | while read f
do
    if [[ $f = s-*.GM2 ]]; then
	cd "$DIR";
	mv $f "$working_dir";
	cd "$working_dir";
	# new file name
	nf=`echo $f | sed 's/\(.*\.\)GM2/\1mp2/'`;
	mv $f `echo $f | sed 's/\(.*\.\)GM2/\1mp2/'`;
	# uncompile the map
	wineconsole eventget.exe $nf;
	# map folders name
	mdir=`echo $nf | sed 's/.mp2//'`;
	cp -r "$extras_dir/FixHotel" "$working_dir/$mdir";
	# recompile the map
	wineconsole eventadd.exe $nf;
	mv $nf "$target_dir";
    fi
done
