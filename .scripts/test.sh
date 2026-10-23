#!/usr/bin/env bash
#
# Smoke test for one dockette/web image.
#
# Usage: .scripts/test.sh <tag> [image]
#   tag    image tag, for example php-84
#   image  image to test (default: dockette/web:<tag>)
#
set -uo pipefail

TAG="${1:?Usage: $0 <tag> [image]}"
IMAGE="${2:-dockette/web:${TAG}}"
VERSION="${TAG#php-}"
PHP="${VERSION:0:1}.${VERSION:1}"
NAME="dockette-web-test-${TAG}-$$"
FAILED=0

# Run a shell command in the image and print its output.
run() {
	docker run --rm "${IMAGE}" sh -c "$1" 2>&1
}

# Run a shell command in the running container and print its output.
exec_() {
	docker exec "${NAME}" sh -c "$1" 2>&1
}

# check <name> <command> [runner]: the command must exit with 0.
check() {
	local out
	if out="$(${3:-run} "$2")"; then
		echo "ok   $1: $(echo "${out}" | head -n 1)"
	else
		echo "FAIL $1"
		echo "${out}" | sed 's/^/     /'
		FAILED=1
	fi
}

# expect <name> <command> <value>: the command output must be equal to the value.
expect() {
	local out
	out="$(run "$2")"
	if [ "${out}" = "$3" ]; then
		echo "ok   $1: ${out}"
	else
		echo "FAIL $1: expected '$3', got:"
		echo "${out}" | sed 's/^/     /'
		FAILED=1
	fi
}

echo "Testing ${IMAGE}"

# Image
expect "php version" "php -r 'echo PHP_MAJOR_VERSION . PHP_MINOR_VERSION;'" "${VERSION}"
# A broken extension prints a startup warning, but php still exits with 0.
check "php startup" "out=\$(php -v 2>&1) && echo \"\$out\" | head -n 1 && ! echo \"\$out\" | grep -iE 'warning|error|unable to load|failed loading'"
check "php extensions" "m=\$(php -m) && for e in apcu bcmath curl gd intl mbstring pdo_mysql pdo_pgsql pdo_sqlite redis soap zip; do echo \"\$m\" | grep -qix \$e || { echo \"missing \$e\"; exit 1; }; done && echo all"
check "php-fpm config" "\$PHP_FPM_BIN -t -y \$PHP_FPM_CONF"
check "nginx config" "nginx -t"
check "composer" "composer --version"

# Runtime: supervisor starts nginx and php-fpm
if ! docker run -d --rm --name "${NAME}" "${IMAGE}" >/dev/null; then
	echo "FAIL container start"
	exit 1
fi
trap 'docker stop "${NAME}" >/dev/null 2>&1' EXIT

for _ in $(seq 1 30); do
	exec_ "curl -fs -o /dev/null http://localhost/" >/dev/null && break
	sleep 1
done

check "http index" "curl -fsS -o /dev/null -w '%{http_code}' http://localhost/" exec_
check "http php" "curl -fsS http://localhost/phpinfo.php | grep -o 'PHP Version ${PHP}[0-9.]*' | head -n 1 | grep ." exec_

if [ "${FAILED}" -ne 0 ]; then
	echo "Container logs:"
	docker logs "${NAME}" 2>&1 | tail -n 30 | sed 's/^/     /'
fi

exit "${FAILED}"
