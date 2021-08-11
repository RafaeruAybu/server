# debian:buster
FROM debian:buster

# install
RUN apt-get update
RUN apt-get install nano
RUN apt-get install -y wget
RUN apt-get update && apt-get -y install nginx mariadb-server wget php-fpm php-mysql \
 php-xml php-mbstring
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server

# copy
COPY srcs/init.sh .
COPY srcs/nginx-conf ./tmp/nginx-conf
COPY srcs/phpmyadmin.inc.php ./tmp/phpmyadmin.inc.php
COPY srcs/wp-config.php ./tmp/wp-config.php

# init
CMD bash init.sh
