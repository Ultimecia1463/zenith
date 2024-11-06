# Use Ubuntu as the base image
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Install required tools and packages
RUN apt-get update && apt-get install -y \
    build-essential \
    nasm \
    qemu-system-x86 \
    bochs \
    bochs-sdl \
    xorriso \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /opt/zenith

# Copy project files to the container
COPY . .

RUN echo '#!/bin/bash\n' \
    'wget https://github.com/open-watcom/open-watcom-v2/releases/download/Current-build/open-watcom-2_0-c-linux-x64 -O /tmp/open-watcom-installer\n' \
    'chmod +x /tmp/open-watcom-installer\n' \
    '/tmp/open-watcom-installer -f=override.inf -s\n' \ 
    'rm /tmp/open-watcom-installer\n' \
    'export WATCOM=/usr/bin/watcom\n' \
    'export PATH=$PATH:$WATCOM/binl\n' \
    'make\n' \
    'bash run.sh' > /opt/zenith/start.sh

# Give execution permissions and run start.sh on container startup
RUN chmod +x /opt/zenith/start.sh

ENTRYPOINT ["/opt/zenith/start.sh"]


# Set the default command to run the start script
CMD ["/opt/zenith/start.sh"]
