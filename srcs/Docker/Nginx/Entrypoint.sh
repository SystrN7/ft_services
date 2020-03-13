# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/09 11:23:19 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/12 12:09:54 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!bin/sh

# Set default user value
[ -z "$SSH_USER" ] && SSH_USER=admin
[ -z "$SSH_PASSWORD" ] && SSH_PASSWORD=admin

# Creating ssh user
adduser -D "$SSH_USER"
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

# Start SSH Services
/usr/sbin/sshd

# Start Nginx
nginx -g "daemon off;"