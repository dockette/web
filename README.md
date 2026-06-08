<h1 align=center>Dockette / Web</h1>

<p align=center>
   🐳 Ready-to-use docker images for websites (nginx, PHP 7.0/7.1/7.2/7.3/7.4/8.0/8.1/8.2/8.3/8.4/8.5 + FPM, supervisor, cron).
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
   <a href="https://github.com/dockette/web/actions"><img src="https://github.com/dockette/web/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/web"><img src="https://img.shields.io/docker/pulls/dockette/web.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

![](https://github.com/dockette/web/blob/master/screenshot.png "It works")

## Overview

This project provides ready-to-use Docker images for web development and deployment. These images are built with a focus on PHP applications, offering a complete environment with Nginx, PHP-FPM, Supervisor, and Cron capabilities.

### Key Features

- **Multiple PHP Versions**: Support for PHP 7.0, 7.1, 7.2, 7.3, 7.4, 8.0, 8.1, 8.2, 8.3, 8.4, and 8.5; older EOL tags are retained for compatibility
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
| `dockette/web:php-85` | Bookworm | 8.5 |
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

PHP 7.0 through 8.1 are outside upstream active/security support and are kept here for compatibility with legacy applications. Prefer a maintained PHP tag for new projects.

You can easily start your Docker container with following command.

```
docker run \
	-it \
	--rm \
	--name dockette-web \
	-p 8000:80 \
	dockette/web:php-85
```

This matches the default `make run` behavior and serves the container on `http://localhost:8000/`.

### Makefile commands

- `make build` builds all PHP tags for `dockette/web`.
- `make test` runs Docker smoke tests for all tags and checks `http://localhost:8000/`.
- `make run` starts `${DOCKER_IMAGE}:${DOCKER_TAG}` with default tag `php-85`, container name `dockette-web`, and port mapping `8000:80`.

### Custom Nginx config

To customize Nginx config just bind new config to the path `/etc/nginx/sites.d/site.conf`, for example,
in such way:

```
docker run \
	-it \
	--rm \
	--name dockette-web \
	-v my-lovely-nginx.conf:/etc/nginx/sites.d/site.conf \
	-p 8000:80 \
	dockette/web:php-85
```

### Run cron tasks

You could also run cron tasks, just simply bind your `crontab` to `/etc/cron.d/app`, for example,
in such way:

```
docker run \
	-it \
	--rm \
	--name dockette-web \
	-v my-crontab:/etc/cron.d/app \
	-p 8000:80 \
	dockette/web:php-85
```

Please note, this crontab should has a little bit different format.
There is also username, for example:

```
57 19 * * *   www-data    my_command
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
