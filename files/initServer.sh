#!/usr/bin/env bash
cd /home/steam/Steam

chown steam:steam /home/steam/Steam/steamapps/
su steam -c './auto_install.sh'
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/
su steam -c 'FEXBash ~/Steam/steamapps/common/PalServer/PalServer.sh'
