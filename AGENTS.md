# AGENTS.md

## Project

Dockette Web publishes ready-to-use Debian-based web images for PHP applications with Nginx, PHP-FPM, Supervisor, Cron, Composer, and a default `/srv/www` site.

## Images

- Docker image: `dockette/web`.
- Default Makefile tag: `php-85`.
- Tags and build contexts: `php-70` through `php-74`, plus `php-80` through `php-85`, built from `./debian-<tag>`.
- All current Dockerfiles use `dockette/debian:bookworm` and packages from `packages.sury.org/php` plus nginx.org packages.
- `.templates/` contains shared nginx, PHP, supervisor, entrypoint, and default web files copied by `make templates`.

## Commands

- `make templates` copies `.templates/` into every versioned build context.
- `make build` builds all PHP tags.
- `make test` runs all Docker smoke tests.
- `make run` starts `${DOCKER_IMAGE}:${DOCKER_TAG}` on host port `8000`.
- `make _docker-test-php-85` builds no image; it starts the already-built tag, waits, and verifies `http://localhost:8000/` with curl.
- Override `DOCKER_TAG` or `DOCKER_IMAGE` when testing a single tag.

## Runtime Notes

- There are no compose files in this repository.
- Containers expose port `80`; the Makefile maps it to host `8000`.
- Custom Nginx config is expected at `/etc/nginx/sites.d/site.conf`.
- Cron files can be mounted at `/etc/cron.d/app` and must include the username column, for example `www-data`.
- The entrypoint starts services through Supervisor; keep PHP-FPM, nginx, cron, and supervisor config paths consistent across all version directories.

## Guidelines

- Keep README tag tables, Makefile targets, workflow matrices, and versioned directories aligned when adding or removing PHP versions.
- Update `.templates/` first for shared config changes, then regenerate or intentionally sync each `debian-php-*` context.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Avoid changing exposed ports, `/srv` layout, or config mount paths unless the README and tests are updated with the same behavior.
- Do not introduce unrelated formatting or structural changes.
