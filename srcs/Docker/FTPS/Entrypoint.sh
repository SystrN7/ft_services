# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/12 10:09:19 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/09 16:08:51 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Set default settings default value
[ -z "$FTP_USER" ] && FTP_USER=admin
[ -z "$FTP_PASSWORD" ] && FTP_PASSWORD=admin

# Creating FTPS User
echo "[i] - Creating FTP user"
adduser -D "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
echo " - Username = $FTP_USER \n - Password = $FTP_PASSWORD"


echo "[i] - Creating TSL key"
openssl req -newkey rsa:2048 -x509 -days 365 -sha256 -nodes -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=FR/ST=Lyon/L=Lyon/O=101/OU=fgalaup/CN=localhost"

# Start FTPS Server
echo "[i] - Starting FTPS servers"
/usr/sbin/pure-ftpd -Y 2 -j -P 192.168.99.100 -p 15000:15000 
# /usr/sbin/pure-ftpd --tls 2 --createhomedir -P 192.168.99.100 -p 15000:15000