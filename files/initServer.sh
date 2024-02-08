#!/usr/bin/env bash
cd /home/steam/Steam
./auto_install.exp
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/
FEXBash ~/Steam/steamapps/common/PalServer/PalServer.sh
