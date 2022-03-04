#!/bin/sh

# Automatically goes through each scenario, extracts them, applys the hotel fix and recompiles.

# For loop through map dir, backup originals, extract, patch, recompile.

DIR="/home/<your_user>/Games/gog/tropico/drive_c/GOG Games/Tropico/";
echo "$DIR";

map_dir="$DIR/maps/";
echo "$map_dir";

extras_dir="/home/<your_user>/Games/gog/tropico/extras/";
echo "$extras_dir";

working_dir="/home//<your_user>Games/gog/tropico/drive_c/GOG Games/Tropico/working/";

cd "$DIR";
mv "$map_dir" "$DIR/maps.bak/";
mkdir "$map_dir";
mkdir "$working_dir";
cp "$DIR/maps.bak/"* "$working_dir";

for f in "$working_dir"*
do
    echo "Processing $f map...";
    echo "Extracting $f...";
    wineconsole eventget.exe "$f";
    extractedScenario=`echo $f | sed 's/.mp2//i'`;
    echo "$extractedScenario";
    cp -r "$extras_dir/FixHotel" "$extractedScenario";
    echo "Re-compiling $f..."
    wineconsole eventadd.exe "$f";
    echo "Moving $f to map dir..."
    mv "$f" "$map_dir";
done
echo "Finished."; 
