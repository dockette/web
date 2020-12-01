# Web

Ready-to-use docker images for websites (nginx, PHP 7.2/7.3/7.4 + FPM, supervisor).

-----

[![Docker Stars](https://img.shields.io/docker/stars/dockette/web.svg?style=flat)](https://hub.docker.com/r/dockette/web/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/web.svg?style=flat)](https://hub.docker.com/r/dockette/web/)

## Discussion / Help

[![Join the chat](https://img.shields.io/gitter/room/dockette/dockette.svg?style=flat-square)](https://gitter.im/dockette/dockette?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Images

| Image                 | Distro | PHP |
|-----------------------|--------|-----|
| `dockette/web:php-74` | Buster | 7.4 |
| `dockette/web:php-73` | Buster | 7.3 |
| `dockette/web:php-72` | Buster | 7.2 |

## Usage

You can easily start your Docker container with following command.

```
docker run \
	-it \
	--rm \
	--name www \
	-p 80:80 \
	dockette/web:php74
```
