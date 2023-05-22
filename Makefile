DOCKER_IMAGE=dockette/web

templates:
	cp -R .templates/ debian-php-70
	cp -R .templates/ debian-php-71
	cp -R .templates/ debian-php-72
	cp -R .templates/ debian-php-73
	cp -R .templates/ debian-php-74
	cp -R .templates/ debian-php-80
	cp -R .templates/ debian-php-81
	cp -R .templates/ debian-php-82

_docker-build-%: VERSION=$*
_docker-build-%:
	docker buildx build \
		--pull \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./debian-${VERSION}

docker-build-php-70: _docker-build-php-70
docker-build-php-71: _docker-build-php-71
docker-build-php-72: _docker-build-php-72
docker-build-php-73: _docker-build-php-73
docker-build-php-74: _docker-build-php-74
docker-build-php-80: _docker-build-php-80
docker-build-php-81: _docker-build-php-81
docker-build-php-82: _docker-build-php-82

docker-build-all:
	$(MAKE) docker-build-php-70
	$(MAKE) docker-build-php-71
	$(MAKE) docker-build-php-72
	$(MAKE) docker-build-php-73
	$(MAKE) docker-build-php-74
	$(MAKE) docker-build-php-80
	$(MAKE) docker-build-php-81
	$(MAKE) docker-build-php-82


docker-test-all:
	$(MAKE) _docker-test-php-70
	$(MAKE) _docker-test-php-71
	$(MAKE) _docker-test-php-72
	$(MAKE) _docker-test-php-73
	$(MAKE) _docker-test-php-74
	$(MAKE) _docker-test-php-80
	$(MAKE) _docker-test-php-81
	$(MAKE) _docker-test-php-82

_docker-test-%: VERSION=$*
_docker-test-%:
	docker run --rm -d --name dockette-web-${VERSION} -p 8000:80 ${DOCKER_IMAGE}:${VERSION}
	sleep 5
	curl -f -Li localhost:8000
	docker stop dockette-web-${VERSION}
