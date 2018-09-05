# Web

Ready-to-use image with Nginx + PHP 7.2 + FPM + Supervisor.

-----

[![Docker Stars](https://img.shields.io/docker/stars/dockette/web.svg?style=flat)](https://hub.docker.com/r/dockette/web/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/web.svg?style=flat)](https://hub.docker.com/r/dockette/web/)

## Discussion / Help

[![Join the chat](https://img.shields.io/gitter/room/dockette/dockette.svg?style=flat-square)](https://gitter.im/dockette/dockette?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Images

There are main 2 images.

- `dockette/web` - based on Alpine Linux 3.8
- `dockette/web:debian` - based on Debian Stretch

## Usage

You can easily start your Docker container with following command.

```
docker run \
	-it \
	--rm \
	--name www \
	-p 80:80 \
	-p 9001:9001 \
	dockette/web
```

Port 80 is for webserver and 9001 is for supervisor web interface.
