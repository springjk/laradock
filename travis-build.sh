#!/usr/bin/env bash

#### halt script on error
set -xe

echo '##### Print docker version'
docker --version

echo '##### Print environment'
env | sort

#### Build the Docker Images

BUILD_VERSION=latest

cp env-build .env

if [ -n "${PHP_VERSION}" ]; then
    sed -i -- "s/PHP_VERSION=.*/PHP_VERSION=${PHP_VERSION}/g" .env
    BUILD_VERSION=${PHP_VERSION}
fi

if [ -n "${MYSQL_VERSION}" ]; then
    sed -i -- "s/MYSQL_VERSION=.*/MYSQL_VERSION=${MYSQL_VERSION}/g" .env
    BUILD_VERSION=${MYSQL_VERSION}
fi

echo  build version is ${BUILD_VERSION}

cat .env

cp docker-compose.build.yml docker-compose.yml
docker-compose build ${BUILD_SERVICE}
docker images

# push latest
docker push ${DOCKER_USERNAME}/laradock-${BUILD_SERVICE}

if [ ${BUILD_VERSION} != "latest" ]; then
    # push build version
    docker tag laradock_${BUILD_SERVICE}:latest ${DOCKER_USERNAME}/laradock-${BUILD_SERVICE}:${BUILD_VERSION}
    docker push ${DOCKER_USERNAME}/laradock-${BUILD_SERVICE}
fi

