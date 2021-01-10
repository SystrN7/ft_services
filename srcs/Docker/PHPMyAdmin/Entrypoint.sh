# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/23 14:43:30 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/10 15:35:12 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!bin/sh

export PHP_FPM_USER="www"
export PHP_FPM_GROUP="www"
export PHP_DISPLAY_ERRORS="On"
export PHP_DISPLAY_STARTUP_ERRORS="On"
export PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"

# Set default user value
[ -z "$PMA_PORT" ] && PMA_PORT=3306
[ -z "$PMA_PMADB" ] && PMA_PMADB=phpmyadmin





# Install PHPMyAdmin Database
if [  -n "$PMA_HOST" ] && [ -n "$PMA_USER" ] ;
then
	# Wait MySQL server start
	counter=0;
	while [ ["mysql --host=${PMA_HOST} --port=${PMA_PORT} --user=${PMA_USER} --password=${PMA_PASSWORD} -e\"quit\""] && [counter < 10]]
	do
		echo "Trying to connect to the database : $counter"
		sleep 5;
		counter=$((counter+1));
	done

	# Install PHPMyAdmin Database (only if the database does not exist).
	if [[ -z "`mysql --host=${PMA_HOST} --port=${PMA_PORT} --user=${PMA_USER} --password=${PMA_PASSWORD} -qfsBe "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='$PMA_PMADB'"`" ]];
	then
		echo "Setup Database"
		mysql --host=${PMA_HOST} --port=${PMA_PORT} --user=${PMA_USER} --password=${PMA_PASSWORD} -e "CREATE DATABASE $PMA_PMADB;"
		mysql --host=${PMA_HOST} --port=${PMA_PORT} --user=${PMA_USER} --password=${PMA_PASSWORD} ${PMA_PMADB} < /Application/PHPMyAdmin/sql/create_tables.sql
	fi
fi

# Start PHP FPM
/usr/sbin/php-fpm7

# Start Nginx
nginx -g "daemon off;"