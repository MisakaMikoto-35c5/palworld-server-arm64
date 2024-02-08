#!/bin/bash

sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# Install necessary dependencies
apt-get update && \
    apt-get install -y \
    git \
    cmake \
    ninja-build \
    pkg-config \
    ccache \
    clang \
    llvm \
    lld \
    binfmt-support \
    libsdl2-dev \
    libepoxy-dev \
    libssl-dev \
    python-setuptools \
    g++-x86-64-linux-gnu \
    nasm \
    python3-clang \
    libstdc++-10-dev-i386-cross \
    libstdc++-10-dev-amd64-cross \
    libstdc++-10-dev-arm64-cross \
    squashfs-tools \
    squashfuse \
    libc-bin \
    expect \
    curl \
    sudo \
    fuse \
    wget

# Create a new user and set their home directory
useradd -m -s /bin/bash fex
usermod -aG sudo fex
echo "fex ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/fex

useradd -m -s /bin/bash steam
echo 'root:steamcmd' | chpasswd

cd /home/fex

# Clone the FEX repository and build it
git clone --recurse-submodules https://github.com/FEX-Emu/FEX.git
cd FEX
mkdir Build
cd Build
CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_LINKER=lld -DENABLE_LTO=True -DBUILD_TESTS=False -DENABLE_ASSERTIONS=False -G Ninja ..
chown -R fex:fex /home/fex
su fex -c ninja

cd /home/fex/FEX/Build

ninja install
ninja binfmt_misc_32
ninja binfmt_misc_64

mkdir -p /home/steam/.fex-emu/RootFS/
cd /home/steam/.fex-emu/RootFS/

# Set up rootfs
wget -O Ubuntu_22_04.tar.gz https://www.dropbox.com/scl/fi/16mhn3jrwvzapdw50gt20/Ubuntu_22_04.tar.gz?rlkey=4m256iahwtcijkpzcv8abn7nf
tar xzf Ubuntu_22_04.tar.gz
rm ./Ubuntu_22_04.tar.gz

echo '{"Config":{"RootFS":"Ubuntu_22_04"}}' > /home/steam/.fex-emu/Config.json

mkdir -p /home/steam/Steam
cd /home/steam/Steam

# Download and run SteamCMD
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

apt install expect

mv /tmp/files/initServer.sh /home/steam/Steam/initServer.sh
mv /tmp/files/auto_install.exp /home/steam/Steam/auto_install.exp

chmod +x /home/steam/Steam/initServer.sh
chmod +x /home/steam/Steam/auto_install.exp
mkdir -p /home/steam/Steam/steamapps/common/PalServer
mkdir -p /home/steam/.steam/sdk64/

chmod -R 777 /home/steam/Steam

chmod -R steam:steam /home/steam
