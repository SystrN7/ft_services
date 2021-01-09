# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/19 12:31:39 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/09 12:02:18 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use Nginx servers
FROM ft_nginx:1.0

# Exposed port
EXPOSE 80

# Install PHP and fast cgi + mysql client
RUN apk update && \
	apk add --no-cache \
	php7 \
	php7-fpm \
	php7-phar \
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

# Setup Wordpress Files
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz && \
	tar zxf latest-fr_FR.tar.gz && \
	rm -f latest-fr_FR.tar.gz && \
	mv wordpress /Application/Wordpress && \
	chown -R www:www /Application/Wordpress && \
	chmod -R 744 /Application/Wordpress


# Configure Nginx
COPY Config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
RUN sed -i 's/user = nobody/user = www/g' etc/php7/php-fpm.d/www.conf && \
	sed -i 's/group = nobody/group = www/g' etc/php7/php-fpm.d/www.conf && \
	sed -i 's/;clear_env = no/clear_env = no/g ' etc/php7/php-fpm.d/www.conf

# Install WordPress CLI
# - 1 : Download Wordpress CLI.
# - 2 : Renaming and moving wp-cli file to the bin forlder
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	mv wp-cli.phar /bin/wp && \
	chmod +x /bin/wp

COPY Config/User.csv /Application/Users.csv
	
# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]