# Project Name: Zenith OS

## Description:
Zenith OS is an ambitious endeavor to develop a new operating system from scratch.

- **From Scratch Development**: Zenith OS is being built entirely from scratch, allowing for complete control over its design and implementation.

## Requirements:
- docker
- VcXsrv ( access controlled)
---
```
 docker build -t zenith:latest .
```
---

```
docker run -it --rm -e DISPLAY=192.168.1.6:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix zenith:latest

docker run -it -p 5000:5000 -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix zenith:latest

```