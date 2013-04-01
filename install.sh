#!/bin/sh
#
# SabiCube installer for debian
# 

#sudo apt-get install autoconf libtool libsdl1.2-dev libsdl-image1.2-dev  libsdl-mixer1.2-dev build-essentials
#cd src/enet
#autoreconf -vfi
#cd ..
#make && make install

cd src

cp sauer_client ../bin_unix/native_client
cp sauer_server ../bin_unix/native_server
strip ../bin_unix/native_client
strip ../bin_unix/native_server 
cd ..
echo "done"
