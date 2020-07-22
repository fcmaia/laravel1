FROM nginx:1.19.1-alpine

RUN apk add bash
COPY ./default.conf /etc/nginx/conf.d/

RUN mkdir -p /var/www
RUN ln -s public html
