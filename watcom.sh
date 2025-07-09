#!/bin/bash
wget https://github.com/open-watcom/open-watcom-v2/releases/download/Current-build/ow-snapshot.tar.xz -O /tmp/open-watcom-installer.tar.xz

mkdir -p /usr/bin/watcom

tar -xf /tmp/open-watcom-installer.tar.xz -C /usr/bin/watcom
