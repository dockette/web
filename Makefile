.PHONY: build-debian-php-72

DOCKER_IMAGE=dockette/web

build-debian-php-72:
	docker build -t ${DOCKER_IMAGE}:php-72 ./debian-php-72

build-debian-php-73:
	docker build -t ${DOCKER_IMAGE}:php-73 ./debian-php-73

build-debian-php-74:
	docker build -t ${DOCKER_IMAGE}:php-74 ./debian-php-74
