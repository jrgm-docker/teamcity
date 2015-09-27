# Dockerfiles for Teamcity server and agent


## Usage:

* Currently, in production mode, the Docker image is installed from a private [Quay.io](https://quay.io/) repository. But the development mode can be used on any box with docker and docker-compose installed
* So for development:
  * Do a git clone of this repository.
  * Optionally run `./tools/docker-purge.sh` to remove all docker images and containers. Obviously don't do this if you care to preserve them for other projects you have on the same box. I recommend using a VM for this work.
  * Run `docker-compose -f development.yml build` to build images.
  * Run `docker-compose -f development.yml up` to start. Or `up -d` for detached.
