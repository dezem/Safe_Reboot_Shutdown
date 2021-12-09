#!/bin/sh
switchProdkeys=~/switch/prod.keys
nspTitleId=01d8dd4312429000
nspTitle=Safe_Reboot_Shutdown

# Build...
make clean
make

# Delete folder if exists
if [ -d hacBrewPack ]; then
    rm -fr hacBrewPack
fi

# Create dummy folders
mkdir -p hacBrewPack/control
mkdir -p hacBrewPack/exefs
mkdir -p hacBrewPack/logo
mkdir -p hacBrewPack/romfs

# Copy needed files
cp icon.jpg hacBrewPack/control/icon_AmericanEnglish.dat
cp build/exefs/* hacBrewPack/exefs/

# Create control.nacp
hptnacp -a createnacp -i $nspTitle.xml -o hacBrewPack/control/control.nacp 

# Build NSP
cd hacBrewPack
hacbrewpack --keys $switchProdkeys --titleid $nspTitleId --titlename $nspTitle --titlepublisher kempa
cp hacbrewpack_nsp/*.nsp ../$nspTitle\_$nspTitleId.nsp
