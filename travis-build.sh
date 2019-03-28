#!/usr/bin/env bash

#### halt script on error
set -xe

echo '##### Print docker version'
docker --version

echo '##### Print environment'
env | sort

#### Build the Docker Images

cp env-build .env
cat .env
cp docker-compose.build.yml docker-compose.yml
docker-compose build ${BUILD_SERVICE}
docker images
docker tag laradock_${BUILD_SERVICE}:latest ${DOCKER_USERNAME}/laradock-${BUILD_SERVICE}:auto-build
docker push ${DOCKER_USERNAME}/laradock-${BUILD_SERVICE}
