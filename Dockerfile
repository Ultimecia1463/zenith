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
    python3 \
    python3-pip \
    x11-apps \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/zenith
COPY . .

RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 8080

RUN chmod +x /opt/zenith/watcom.sh
RUN chmod +x /opt/zenith/run.sh

ENTRYPOINT ["bash", "-c", "/opt/zenith/watcom.sh && python3 /opt/zenith/server.py"]
