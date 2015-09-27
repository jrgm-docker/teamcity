#!/usr/bin/env sh

set -e

if [ ! -z "$(docker ps -qa)" ]; then
    docker stop $(docker ps -qa)
    docker rm $(docker ps -qa)
fi

if [ ! -z "$(docker images -q)" ]; then
    docker rmi -f $(docker images -q)
fi

docker ps -a | grep -v ^CONTAINER
docker images -a | grep -v ^REPOSITORY



