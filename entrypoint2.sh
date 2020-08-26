#!/bin/sh

wait-for db:3306 -t 30 -- php-fpm -F -O
