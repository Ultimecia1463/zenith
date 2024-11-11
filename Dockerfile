FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    nasm \
    qemu-system-x86 \
    bochs \
    bochs-sdl \
    xorriso \
    wget \
    mtools \
    dosfstools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/zenith
COPY . .

RUN echo '#!/bin/bash\n' \
    'wget https://github.com/open-watcom/open-watcom-v2/releases/download/Current-build/ow-snapshot.tar.xz -O /tmp/open-watcom-installer.tar.xz\n' \
    'mkdir /usr/bin/watcom\n'  \
    'tar -xf /tmp/open-watcom-installer.tar.xz -C /usr/bin/watcom\n'   > /opt/zenith/watcom.sh 
#   'cd /tmp/open-watcom-v2\n' \
#   './install.sh' > /opt/zenith/watcom.sh 

RUN echo '#!/bin/bash\n' \
    'make'  > /opt/zenith/build.sh

RUN chmod +x /opt/zenith/watcom.sh
RUN chmod +x /opt/zenith/build.sh
RUN chmod +x /opt/zenith/run.sh