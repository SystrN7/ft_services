# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/12 10:09:19 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/16 09:58:14 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Set default value
[ -z "$FTP_USER" ] && FTP_USER=admin
[ -z "$FTP_PASSWORD" ] && FTP_PASSWORD=admin

# Creating FTPS User
adduser -D "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
echo "user:password = $FTP_USER:$FTP_PASSWORD"

# Start FTPS Server
/usr/sbin/pure-ftpd -Y 2 -p 15477:15477