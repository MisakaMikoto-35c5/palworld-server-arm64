#!/bin/bash

CONTAINER_PROGRAM=docker
which docker
if [[ $? != 0 ]]; then
	CONTAINER_PROGRAM=podman
fi

$CONTAINER_PROGRAM build --tag palworld .
$CONTAINER_PROGRAM kill palworld
$CONTAINER_PROGRAM rm palworld
#$CONTAINER_PROGRAM rmi palworld

#$CONTAINER_PROGRAM build --tag palworld .
$CONTAINER_PROGRAM create -t \
	--name palworld \
	-p 8211:8211/udp \
	-p 25575:25575 \
	-v /var/data/palworld:/home/steam/Steam/steamapps \
	palworld


