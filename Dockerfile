FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# required tools and packages
RUN apt-get update && apt-get install -y \
    build-essential \
    nasm \
    qemu-system-x86 \
    bochs \
    bochs-sdl \
    xorriso \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/zenith

COPY . .

# Script to download and install Open Watcom on container startup
RUN echo '#!/bin/bash\n' \
    'wget https://github.com/open-watcom/open-watcom-v2/releases/download/Current-build/open-watcom-2_0-c-linux-x64 -O /tmp/open-watcom-installer\n' \
    'chmod +x /tmp/open-watcom-installer\n' \
    '/tmp/open-watcom-installer --mode unattended\n' \
    'rm /tmp/open-watcom-installer\n' \
    'make\n' \
    'bash run.sh' > /opt/zenith/start.sh

# Make the script executable
RUN chmod +x /opt/zenith/start.sh

# Set the default command to run the start script
CMD ["/opt/zenith/start.sh"]
