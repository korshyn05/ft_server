# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tludwig <tludwig@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/20 01:29:36 by tludwig           #+#    #+#              #
#    Updated: 2020/08/20 01:29:38 by tludwig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install nginx wget tar openssl default-mysql-server wordpress
RUN apt-get -y install lsb-release apt-transport-https ca-certificates 
RUN mkdir /var/www/myProj

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get -y install php7.4 php7.4-fpm php7.4-mbstring php7.4-gd php7.4-curl php7.4-mysql php7.4-intl php7.4-gmp \
	 php7.4-xml  php7.4-intl  php7.4-common  php7.4-zip  php7.4-xmlrpc

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=RU/ST=Moscow/L=Moscow/O=School21/CN=tludwig"\
 -keyout /etc/ssl/certs/myProj.key -out /etc/ssl/certs/myProj.crt

ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz phpMyAdmin.tar.gz
RUN tar -xf phpMyAdmin.tar.gz
RUN mv phpMyAdmin-4.9.5-all-languages /var/www/myProj/phpMyAdmin
RUN cp -r /usr/share/wordpress /var/www/myProj && rm /var/www/myProj/wordpress/wp-config.php
RUN chown -R www-data /var/www/myProj

WORKDIR /srcs
COPY srcs/mysql_setup.sql srcs/*.sh ./
RUN chmod +x *.sh
COPY srcs/config.inc.php /var/www/myProj/phpMyAdmin
COPY srcs/wp-config.php /var/www/myProj/wordpress
COPY srcs/myProj.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/myProj.conf /etc/nginx/sites-enabled/myProj.conf && \ 
	rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default


CMD ["bash", "start.sh"]

RUN bash

EXPOSE 80 443