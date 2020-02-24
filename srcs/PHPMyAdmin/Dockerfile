# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/19 12:31:39 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/24 17:50:29 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


# Use the last version of alpine linux
FROM services_nginx:1.0

# Exposed port
EXPOSE 80

# Install PHP and fast cgi + mysql client
RUN apk update && \
	apk add --no-cache \
	php7-fpm \
	php7-session \
	php7-mbstring \
	php7-mcrypt \
	php7-soap \
	php7-openssl \
	php7-gmp \
	php7-pdo_odbc \
	php7-json \
	php7-dom \
	php7-pdo \
	php7-zip \
	php7-mysqli \
	php7-apcu \
	php7-pdo_pgsql \
	php7-bcmath \
	php7-gd \
	php7-odbc \
	php7-pdo_mysql \
	php7-gettext \
	php7-xmlreader \
	php7-xmlrpc \
	php7-bz2 \
	php7-iconv \
	php7-pdo_dblib \
	php7-curl \
	php7-ctype \ 
	mysql-client

# Creating applicaton directory
# RUN mkdir /Application/PHPMyAdmin

# Setup PHPMyAdmin Files
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-all-languages.tar.gz && \
	tar zxf phpMyAdmin-5.0.1-all-languages.tar.gz && \
	rm -f phpMyAdmin-5.0.1-all-languages.tar.gz && \
	mv phpMyAdmin-5.0.1-all-languages /Application/PHPMyAdmin

# RUN echo "<?php phpinfo(); ?>" > /Application/PHPMyAdmin/index.php

# Configure Nginx
COPY Config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
RUN sed -i 's/user = nobody/user = www/g' etc/php7/php-fpm.d/www.conf && \
	sed -i 's/group = nobody/group = www/g' etc/php7/php-fpm.d/www.conf && \
	sed -i 's/;clear_env = no/clear_env = no/g ' etc/php7/php-fpm.d/www.conf

# Configure PHPMyAdmin
COPY Config/config.inc.php /Application/PHPMyAdmin/config.inc.php

RUN mkdir /Application/PHPMyAdmin/tmp && \
	chown www:www /Application/PHPMyAdmin/tmp

# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]