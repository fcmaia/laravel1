FROM php:7.3.6-fpm-alpine3.9

COPY ./entrypoint2.sh /
RUN apk add bash mysql-client zlib-dev libzip libzip-dev
RUN apk add --no-cache shadow
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php
#RUN php -r "unlink('composer-setup.php');"
#RUN mv composer.phar /usr/bin/composer
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php --  
RUN mv composer.phar /usr/bin/composer

RUN docker-php-ext-install pdo pdo_mysql zip 

RUN composer global require laravel/installer

WORKDIR /var/www

#RUN composer create-project --prefer-dist laravel/laravel laravel
#RUN mv laravel/* .
#RUN mv laravel/.env* .

RUN wget https://raw.githubusercontent.com/capripot/wait-for/master/wait-for -O /usr/bin/wait-for
RUN chmod 0755 /usr/bin/wait-for

RUN rm -f .env
RUN rm -rf html
RUN ln -s public html

RUN usermod -u 1000 www-data
USER www-data

EXPOSE 9000

#ENTRYPOINT ["/entrypoint2.sh"]
ENTRYPOINT ["php-fpm","-F","-O"]
