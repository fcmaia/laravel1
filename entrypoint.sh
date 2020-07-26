#!/bin/sh

ls
ln -sf public html

test -f .env.example && \
    sed -e 's/DB_HOST=.*/DB_HOST=db/' .env.example > .env && \
    sed -i -e 's/DB_DATABASE=.*/DB_DATABASE=laravel/' .env && \
    sed -i -e 's/DB_USERNAME=.*/DB_USERNAME=root/' .env && \
    sed -i -e 's/DB_PASSWORD=.*/DB_PASSWORD=root/' .env && \
    sed -i -e 's/REDIS_HOST=.*/REDIS_HOST=redis/'  .env

php artisan key:generate
wait-for db:3306 -t 30 -- php artisan migrate -n

php-fpm
