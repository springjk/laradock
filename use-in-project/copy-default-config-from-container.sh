#!/usr/bin/env bash

source .env

# copy nginx default config
docker cp "$(docker-compose ps -q nginx)":/etc/nginx/sites-available ${NGINX_SITES_PATH}

# copy php-fpm default config
docker cp "$(docker-compose ps -q php-fpm)":/usr/local/etc/php/php.ini ./php-fpm/php${PHP_VERSION}.ini

