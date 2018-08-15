#!/usr/bin/env bash

#### halt script on error
set -xe

echo '##### Print docker version'
docker --version

echo '##### Print environment'
env | sort

#### Build the Docker Images
if [ -n "${PHP_VERSION}" ]; then
    cp env-build .env
    cat .env
    docker-compose build ${BUILD_SERVICE}
    docker images
    docker tag laradock_${BUILD_SERVICE}:latest {$DOCKER_USERNAME}/laradock-${BUILD_SERVICE}:auto-build
    docker images
    docker push {$DOCKER_USERNAME}/laradock-${BUILD_SERVICE}
fi

