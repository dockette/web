DOCKER_IMAGE=dockette/web
DOCKER_TAG?=php-85


.PHONY: templates
templates:
	cp -R .templates/ debian-php-70
	cp -R .templates/ debian-php-71
	cp -R .templates/ debian-php-72
	cp -R .templates/ debian-php-73
	cp -R .templates/ debian-php-74
	cp -R .templates/ debian-php-80
	cp -R .templates/ debian-php-81
	cp -R .templates/ debian-php-82
	cp -R .templates/ debian-php-83
	cp -R .templates/ debian-php-84
	cp -R .templates/ debian-php-85

_docker-build-%: VERSION=$*
.PHONY: _docker-build-%
_docker-build-%:
	docker buildx build \
		--pull \
		-t ${DOCKER_IMAGE}:${VERSION} \
		./debian-${VERSION}

.PHONY: docker-build-php-70
docker-build-php-70: _docker-build-php-70
.PHONY: docker-build-php-71
docker-build-php-71: _docker-build-php-71
.PHONY: docker-build-php-72
docker-build-php-72: _docker-build-php-72
.PHONY: docker-build-php-73
docker-build-php-73: _docker-build-php-73
.PHONY: docker-build-php-74
docker-build-php-74: _docker-build-php-74
.PHONY: docker-build-php-80
docker-build-php-80: _docker-build-php-80
.PHONY: docker-build-php-81
docker-build-php-81: _docker-build-php-81
.PHONY: docker-build-php-82
docker-build-php-82: _docker-build-php-82
.PHONY: docker-build-php-83
docker-build-php-83: _docker-build-php-83
.PHONY: docker-build-php-84
docker-build-php-84: _docker-build-php-84
.PHONY: docker-build-php-85
docker-build-php-85: _docker-build-php-85

.PHONY: build
build: docker-build-all

.PHONY: test
test: docker-test-all

.PHONY: run
run:
	docker run --rm -it --name dockette-web -p 8000:80 ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: docker-build-all
docker-build-all:
	$(MAKE) docker-build-php-70
	$(MAKE) docker-build-php-71
	$(MAKE) docker-build-php-72
	$(MAKE) docker-build-php-73
	$(MAKE) docker-build-php-74
	$(MAKE) docker-build-php-80
	$(MAKE) docker-build-php-81
	$(MAKE) docker-build-php-82
	$(MAKE) docker-build-php-83
	$(MAKE) docker-build-php-84
	$(MAKE) docker-build-php-85


.PHONY: docker-test-all
docker-test-all:
	$(MAKE) _docker-test-php-70
	$(MAKE) _docker-test-php-71
	$(MAKE) _docker-test-php-72
	$(MAKE) _docker-test-php-73
	$(MAKE) _docker-test-php-74
	$(MAKE) _docker-test-php-80
	$(MAKE) _docker-test-php-81
	$(MAKE) _docker-test-php-82
	$(MAKE) _docker-test-php-83
	$(MAKE) _docker-test-php-84
	$(MAKE) _docker-test-php-85

_docker-test-%: VERSION=$*
.PHONY: _docker-test-%
_docker-test-%:
	set -e; \
	container="dockette-web-${VERSION}"; \
	docker rm -f "$${container}" >/dev/null 2>&1 || true; \
	trap 'docker rm -f "$${container}" >/dev/null 2>&1 || true' EXIT; \
	docker run --rm -d --name "$${container}" -p 8000:80 ${DOCKER_IMAGE}:${VERSION}; \
	sleep 5; \
	curl -f -Li localhost:8000
