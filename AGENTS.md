# AGENTS.md

## Project

Docker image repository in the Dockette organization.

## Commands

- `make build` builds the default Docker image.
- `make test` runs the repository smoke tests.
- `make run` starts the image for local use.

## Guidelines

- Keep Dockerfiles, `Makefile`, README, and GitHub Actions workflow changes aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Keep README badges and maintenance sections consistent with other Dockette image repos.
- Do not introduce unrelated formatting or structural changes.
