# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: felix <felix@student.42lyon.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/09 11:47:54 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/14 16:15:58 by felix            ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!bin/sh

### SETTINGS ###
# $WORDPRESS_SITE_ URL
# $WORDPRESS_SITE_NAME

# $WORDPRESS_DATABASE_HOST
# $WORDPRESS_DATABASE_PORT
# $WORDPRESS_DATABASE_NAME
# $WORDPRESS_DATABASE_USER
# $WORDPRESS_DATABASE_PASSWORD

# $WORDPRESS_ADMIN_EMAIL
# $WORDPRESS_ADMIN_NAME
# $WORDPRESS_ADMIN_PASSWORD

# WORDPRESS_USER_IMPORT_CSV
# WORDPRESS_USER_RANDOM

# Set default value
[ -z "$WORDPRESS_SITE_URL" ] && WORDPRESS_SITE_URL=http://192.168.99.100:5050/ # TODO : Find beater way to get default url
[ -z "$WORDPRESS_SITE_NAME" ] && WORDPRESS_SITE_NAME="101 Gossip."

[ -z "$WORDPRESS_DATABASE_PORT" ] && WORDPRESS_DATABASE_PORT=3306
[ -z "$WORDPRESS_DATABASE_NAME" ] && WORDPRESS_DATABASE_NAME=wordpress

[ -z "$WORDPRESS_ADMIN_EMAIL" ] && WORDPRESS_ADMIN_EMAIL=admin@wordpress.com
[ -z "$WORDPRESS_ADMIN_NAME" ] && WORDPRESS_ADMIN_NAME=admin
[ -z "$WORDPRESS_ADMIN_PASSWORD" ] && WORDPRESS_ADMIN_PASSWORD=admin

[ -z "$WORDPRESS_USER_RANDOM" ] && WORDPRESS_USER_RANDOM=0

# Copy default file in Volume Wordpress if dir is empty
if [ -z "$(ls -A /Application/Wordpress)" ]
then
	echo "Copy To the volume";
	mv /Application/tmp/wordpress/* /Application/Wordpress;
	rm -R /Application/tmp;
fi

# Creating configuration file and database
if [  -n "$WORDPRESS_DATABASE_HOST" ] && [ -n "$WORDPRESS_DATABASE_USER" ] && [ -n "$WORDPRESS_DATABASE_PASSWORD" ] ;
then
	# Wait MySQL server start
	counter=0;
	while [[ mysql --host=${WORDPRESS_DATABASE_HOST} --port=${WORDPRESS_DATABASE_PORT} --user=${WORDPRESS_DATABASE_USER} --password=${WORDPRESS_DATABASE_PASSWORD} -e"quit"] && [counter < 10]]
	do
		echo "Trying to connect to the database : " $counter
		sleep 5;
		counter=$((counter+1));
	done
	
	# Creating config file if doesn't exit.
	if [ ! -f /Application/Wordpress/wp-config.php ] ;
	then
		echo "Creating configuration file." ;
		wp config create --path=/Application/Wordpress \
			--dbhost="$WORDPRESS_DATABASE_HOST" \
			--dbname="$WORDPRESS_DATABASE_NAME" \
			--dbuser="$WORDPRESS_DATABASE_USER" \
			--dbpass="$WORDPRESS_DATABASE_PASSWORD"
	fi

	# Install Wordpress Database if not exist
	if [[ -z "`mysql --host=${WORDPRESS_DATABASE_HOST} \
					 --port=${WORDPRESS_DATABASE_PORT} \
					 --user=${WORDPRESS_DATABASE_USER} \
					 --password=${WORDPRESS_DATABASE_PASSWORD} \
					 -qfsBe "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='$WORDPRESS_DATABASE_NAME'"`" \
		]];
	then
		echo "Creating MySQL database." ;
		# Creating database
		mysql --host=${WORDPRESS_DATABASE_HOST} \
			--port=${WORDPRESS_DATABASE_PORT} \
			--user=${WORDPRESS_DATABASE_USER} \
			--password=${WORDPRESS_DATABASE_PASSWORD} \
			-e "CREATE DATABASE $WORDPRESS_DATABASE_NAME;"
		
		# Fill it with basic instalation
		wp core install --path=/Application/Wordpress \
			--url="$WORDPRESS_SITE_URL" \
			--title="$WORDPRESS_SITE_NAME" \
			--admin_email="$WORDPRESS_ADMIN_EMAIL" \
			--admin_user="$WORDPRESS_ADMIN_NAME" \
			--admin_password="$WORDPRESS_ADMIN_PASSWORD"
		wp option update siteurl "$WORDPRESS_SITE_URL" --path=/Application/Wordpress 
	fi

	# Import Users via csv
	if [ -f /Application/Users.csv ] && [ "$WORDPRESS_USER_IMPORT_CSV"  == "true" ] ;
	then
		echo "Importing Users" ;
		wp user import-csv --path=/Application/Wordpress --skip-update /Application/Users.csv
	fi

	# Creating Random Users
	if [ "$WORDPRESS_USER_RANDOM" -ge 1 ] ;
	then
		echo "Generating Users" ;
		wp user generate --path=/Application/Wordpress --count=$WORDPRESS_USER_RANDOM
	fi
fi

# Configure PHP-FPM
export PHP_FPM_USER="www"
export PHP_FPM_GROUP="www"
export PHP_DISPLAY_ERRORS="On"
export PHP_DISPLAY_STARTUP_ERRORS="On"
export PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"

# Start PHP-FPM
/usr/sbin/php-fpm7

# Start Nginx
nginx -g "daemon off;"