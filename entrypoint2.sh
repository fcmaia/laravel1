#!/bin/sh

wait-for 127.0.0.1:3306 -t 30 -- php-fpm -F -O
