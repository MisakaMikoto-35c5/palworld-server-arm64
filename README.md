# Palworld Server for ARM macinhes

## Build this image

```
git clone https://github.com/MisakaMikoto-35c5/palworld-server-arm64
cd palworld-server-arm64
docker build --tag palworld-server .
```

## Create Server

```
docker create -t \
   --name palworld-server \
   -p 8211:8211/udp \
   -p 25575:25575/tcp \
   -v /var/data/palworld:/home/steam/Steam/steamapps \
   palworld-server
```