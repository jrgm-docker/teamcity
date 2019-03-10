# Dockerfiles for Teamcity server and agent

## Usage:

* For production, the docker images are pulled from public [Quay.io](https://quay.io/) repositories (https://quay.io/repository/jrgm_docker/teamcity-agent-centos?tab=builds and https://quay.io/repository/jrgm_docker/teamcity-server?tab=builds). The development mode can be used on any box with docker and docker-compose installed.

* So for development:
  * Do a git clone of this repository.
  * Run `docker-compose -f development.yml build` to build images.
  * Run `docker-compose -f development.yml up` to start. Or `up -d` for detached.
