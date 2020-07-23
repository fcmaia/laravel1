FROM php:7.3.6-fpm-alpine3.9

RUN apk add bash mysql-client zlib-dev libzip libzip-dev
RUN apk add --no-cache shadow
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php
#RUN php -r "unlink('composer-setup.php');"
#RUN mv composer.phar /usr/bin/composer
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php --  && \ 
 mv composer.phar /usr/bin/composer

RUN ls -l /usr/bin/compos*
RUN docker-php-ext-install pdo pdo_mysql zip 

RUN composer global require laravel/installer

WORKDIR /var/www

#RUN composer create-project --prefer-dist laravel/laravel laravel
#RUN mv laravel/* .
#RUN mv laravel/.env* .

RUN sed -i -e 's/DB_HOST=.+/DB_HOST=db/' .env.example > .env
RUN sed -i -e 's/DB_DATABASE=.*/DB_DATABASE=laravel/' .env
RUN sed -i -e 's/DB_USERNAME=.*/DB_USERNAME=root/' .env
RUN sed -i -e 's/DB_PASSWORD=.*/DB_PASSWORD=root/' .env
RUN sed -i -e 's/REDIS_HOST=.+/REDIS_HOST=redis/'  .env

RUN php artisan key:generate
RUN wget https://raw.githubusercontent.com/capripot/wait-for/master/wait-for -O /usr/bin/wait-for
RUN chmod 0755 /usr/bin/wait-for

##COPY . /var/www
RUN rm -rf html
RUN ln -s public html

RUN usermod -u 1000 www-data
USER www-data

EXPOSE 8000
EXPOSE 9000

CMD wait-for db:3306 -t 30 -- php artisan migrate

ENTRYPOINT ["php-fpm"]