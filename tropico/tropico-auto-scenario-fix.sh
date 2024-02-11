#!/bin/bash

# Automatically goes through each scenario, extracts them, applys the hotel fix and recompiles.

# Where is Tropico's Wine Prefix?
PREFIX="$HOME/Games/gog/tropico";
echo "PREFIX";

# Where is Tropico's installed (where the tropico.exe is)?
TROPICO="$PREFIX/drive_c/GOG Games/Tropico";
echo "$TROPICO";

# Where are Tropico's maps (scenarios)?
MAPS="$TROPICO/maps";
echo "$MAPS";

# Where are the FixHotel files?
FIXHOTEL="$PREFIX/extras/FixHotel";
echo "$FIXHOTEL";

# Where the script is going to work on the scenarios
WORKING="$TROPICO/working";
echo "$WORKING";

cd "$TROPICO";
mv "$MAPS" "$TROPICO/maps.bak";
mkdir "$MAPS";
mkdir "$WORKING";
cp -r "$TROPICO/maps.bak/"* "$WORKING";

for f in "$WORKING/"*
do
    echo "Processing $f map...";
    echo "Extracting $f...";
    wineconsole eventget.exe "$f";
    extracted_scenario=`echo $f | sed 's/.mp2//i'`;
    echo "$extracted_scenario";
    cp -r "$FIXHOTEL" "$extracted_scenario";
    echo "Re-compiling $f..."
    wineconsole eventadd.exe "$f";
    echo "Moving $f to map dir..."
    mv "$f" "$MAPS";
done
echo "Removing working dir...";
rm -r "$WORKING";
echo "Finished."; 
