# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/09 11:47:54 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/11 14:43:38 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!bin/sh

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

# WORDPRESS_USER_RANDOM
# WORDPRESS_USER_IMPORT_CVS

# Set default value
[ -z "$WORDPRESS_SITE_URL" ] && WORDPRESS_SITE_URL=http://192.168.99.100:4050/ # TODO : Find beater way to get default url
[ -z "$WORDPRESS_SITE_NAME" ] && WORDPRESS_SITE_NAME="101 Gossip."

[ -z "$WORDPRESS_DATABASE_PORT" ] && WORDPRESS_DATABASE_PORT=3306
[ -z "$WORDPRESS_DATABASE_NAME" ] && WORDPRESS_DATABASE_NAME=wordpress

[ -z "$WORDPRESS_ADMIN_EMAIL" ] && WORDPRESS_ADMIN_EMAIL=admin@wordpress.com
[ -z "$WORDPRESS_ADMIN_NAME" ] && WORDPRESS_ADMIN_NAME=admin
[ -z "$WORDPRESS_ADMIN_PASSWORD" ] && WORDPRESS_ADMIN_PASSWORD=admin


# $WORDPRESS_SITE_NAME
# $WORDPRESS_SITE_URL

# Creating configuration file and database
if [  -n "$WORDPRESS_DATABASE_HOST" ] && [ -n "$WORDPRESS_DATABASE_USER" ] && [ -n "$WORDPRESS_DATABASE_PASSWORD" ] ;
then
	echo "Debug" ;
	# Creating config file if doesn't exit.
	if [ ! -f /Application/Wordpress/wp-config.php ] ;
	then
		echo "Creating configuartion file." ;
		wp config create --path=Application/Wordpress \
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
		wp core install --path=Application/Wordpress \
			--url="$WORDPRESS_SITE_URL" \
			--title="$WORDPRESS_SITE_NAME" \
			--admin_email="$WORDPRESS_ADMIN_EMAIL" \
			--admin_user="$WORDPRESS_ADMIN_NAME" \
			--admin_password="$WORDPRESS_ADMIN_PASSWORD"
		wp option update siteurl "$WORDPRESS_SITE_URL" --path=Application/Wordpress 
		# wp wp db create --path=Application/Wordpress 
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