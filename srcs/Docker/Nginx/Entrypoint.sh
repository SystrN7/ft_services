# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: felix <felix@student.42lyon.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/09 11:23:19 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/13 18:37:41 by felix            ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!bin/sh


# Copy default file in www
if [ -z "$(ls -A /Application/WWW)" ]
then
	echo "Copy To the volume";
	mv /Application/tmp/* /Application/WWW/;
fi

echo "[Start] - Nginx"
# Start Nginx
nginx -g "daemon off;"