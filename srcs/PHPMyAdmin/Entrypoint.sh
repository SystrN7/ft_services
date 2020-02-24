# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/23 14:43:30 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/24 17:54:05 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

export PHP_FPM_USER="www"
export PHP_FPM_GROUP="www"
export PHP_DISPLAY_ERRORS="On"
export PHP_DISPLAY_STARTUP_ERRORS="On"
export PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"

# Start PHP FPM
/usr/sbin/php-fpm7 -d clear_env=no

# Install PHPMyAdmin Database
if []
	if [[ -z "`mysql -qfsBe "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='$PMA_PMADB'" 2>&1`" ]];
	then
		mysql --host=${PMA_HOST} --user=${PMA_USER} --password=${PMA_PASSWORD} -e "CREATE DATABASE $PMA_PMADB;" && \
		mysql --host=${PMA_HOST} --user=${PMA_USER} --password=${PMA_PASSWORD} ${PMA_PMADB} < phpmyadmin.sql
	fi
fi

# Start Nginx
nginx -g "daemon off;"