DOCKER_IMAGE=dockette/web

.PHONY: build-debian-php-72
build-debian-php-72:
	docker build -t ${DOCKER_IMAGE}:php-72 ./debian-php-72

.PHONY: build-debian-php-73
build-debian-php-73:
	docker build -t ${DOCKER_IMAGE}:php-73 ./debian-php-73

.PHONY: build-debian-php-74
build-debian-php-74:
	docker build -t ${DOCKER_IMAGE}:php-74 ./debian-php-74

.PHONY: build-debian-php-80
build-debian-php-80:
	docker build -t ${DOCKER_IMAGE}:php-80 ./debian-php-80

.PHONY: build-debian-php-81
build-debian-php-81:
	docker build -t ${DOCKER_IMAGE}:php-80 ./debian-php-81
