# Use the official Ubuntu 22.04 as the base image
FROM ubuntu:22.04

EXPOSE 8211/udp
EXPOSE 25575/tcp

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

COPY ./files /tmp/files

RUN chmod a+x /tmp/files/*.sh && \
    /tmp/files/install_container.sh && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apt/*

ENTRYPOINT /home/steam/Steam/initServer.sh