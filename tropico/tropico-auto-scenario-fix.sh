#!/bin/bash

# Automatically goes through each scenario, extracts them, applys the hotel fix and recompiles.

PATH_TO_SCRIPT=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")");
cd "$PATH_TO_SCRIPT";

mv "maps" "maps.bak";
mkdir "maps";
mkdir "working";
cp -r "maps.bak/"* "working";

for f in "working/"*
do
    echo "Processing $f map...";
    echo "Extracting $f...";
    wineconsole eventget.exe "$f";
    extracted_scenario=`echo $f | sed 's/.mp2//i'`;
    echo "$extracted_scenario";
    cp -r "FixHotel" "$extracted_scenario";
    echo "Re-compiling $f..."
    wineconsole eventadd.exe "$f";
    echo "Moving $f to map dir..."
    mv "$f" "maps";
done
echo "Removing working dir...";
rm -r "working";
echo "Finished.";
