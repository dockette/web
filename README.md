<h1 align=center>Dockette / Web</h1>

<p align=center>
   🐳 Ready-to-use docker images for websites (nginx, PHP 7.0/7.1/7.2/7.3/7.4/8.0/8.1/8.2/8.3/8.4 + FPM, supervisor, cron).
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://hub.docker.com/r/dockette/web/"><img src="https://badgen.net/docker/pulls/dockette/web"></a>
  <a href="https://bit.ly/ctteg"><img src="https://badgen.net/badge/support/gitter/cyan"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
</p>

![](https://github.com/dockette/web/blob/master/screenshot.png "It works")

## Overview

This project provides ready-to-use Docker images for web development and deployment. These images are built with a focus on PHP applications, offering a complete environment with Nginx, PHP-FPM, Supervisor, and Cron capabilities.

### Key Features

- **Multiple PHP Versions**: Support for PHP 7.0, 7.1, 7.2, 7.3, 7.4, 8.0, 8.1, 8.2, 8.3, and 8.4
- **Nginx Web Server**: Pre-configured with sensible defaults for PHP applications
- **PHP-FPM**: Optimized for performance with common extensions installed
- **Supervisor**: Process control system to manage services
- **Cron Support**: Schedule and run periodic tasks
- **Debian-based**: All images are built on Debian Bookworm for stability
- **Customizable**: Easy configuration through volume mounts
- **Production-Ready**: Optimized for both development and production environments

## Usage

| Image                 | Distro   | PHP |
|-----------------------|----------|-----|
| `dockette/web:php-84` | Bookworm | 8.4 |
| `dockette/web:php-83` | Bookworm | 8.3 |
| `dockette/web:php-82` | Bookworm | 8.2 |
| `dockette/web:php-81` | Bookworm | 8.1 |
| `dockette/web:php-80` | Bookworm | 8.0 |
| `dockette/web:php-74` | Bookworm | 7.4 |
| `dockette/web:php-73` | Bookworm | 7.3 |
| `dockette/web:php-72` | Bookworm | 7.2 |
| `dockette/web:php-71` | Bookworm | 7.1 |
| `dockette/web:php-70` | Bookworm | 7.0 |

You can easily start your Docker container with following command.

```
docker run \
	-it \
	--rm \
	--name www \
	-p 80:80 \
	dockette/web:php-84
```

### Custom Nginx config

To customize Nginx config just bind new config to the path `/etc/nginx/sites.d/site.conf`, for example,
in such way:

```
docker run \
	-it \
	--rm \
	--name www \
	-v my-lovely-nginx.conf:/etc/nginx/sites.d/site.conf \
	-p 80:80 \
	dockette/web:php-84
```

### Run cron tasks

You could also run cron tasks, just simply bind your `crontab` to `/etc/cron.d/app`, for example,
in such way:

```
docker run \
	-it \
	--rm \
	--name www \
	-v my-crontab:/etc/cron.d/app \
	-p 80:80 \
	dockette/web:php-84
```

Please note, this crontab should has a little bit different format.
There is also username, for example:

```
57 19 * * *   www-data    my_command
```

## Maintainers

<a href="https://github.com/f3l1x">
    <img width="80" height="80" src="https://avatars2.githubusercontent.com/u/538058?v=3&s=80">
</a>

-----

Consider to [support](https://bit.ly/f3l1xsponsor) **f3l1x**. Also thank you for using this package.
