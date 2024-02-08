#!/bin/bash

# Automatically goes through each scenario, extracts them, applys the hotel fix and recompiles.

PREFIX="$HOME/Games/gog/tropico";
echo "PREFIX";

TROPICO="$PREFIX/drive_c/GOG Games/Tropico";
echo "$TROPICO";

MAPS="$TROPICO/maps";
echo "$MAPS";

FIXHOTEL="$PREFIX/extras/FixHotel";
echo "$FIXHOTEL";

WORKING="$TROPICO/working";

cd "$TROPICO";
mv "$MAPS" "$TROPICO/maps.bak/";
mkdir "$MAPS";
mkdir "$WORKING";
cp "$TROPICO/maps.bak/"* "$WORKING";

for f in "$WORKING"*
do
    echo "Processing $f map...";
    echo "Extracting $f...";
    wineconsole eventget.exe "$f";
    extractedScenario=`echo $f | sed 's/.mp2//i'`;
    echo "$extractedScenario";
    cp -r "$FIXHOTEL" "$extractedScenario";
    echo "Re-compiling $f..."
    wineconsole eventadd.exe "$f";
    echo "Moving $f to map dir..."
    mv "$f" "$MAPS";
done
echo "Finished."; 
