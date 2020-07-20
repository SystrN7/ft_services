# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/09 11:23:19 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/18 15:47:40 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!bin/sh

# Set default user value
[ -z "$SSH_USER" ] && SSH_USER=admin
[ -z "$SSH_PASSWORD" ] && SSH_PASSWORD=admin

# Creating ssh user
adduser -D "$SSH_USER"
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

echo "Login : $SSH_USER\n Password : $SSH_PASSWORD"

# Start SSH Service
echo "[start] - SSH Deamon"
/usr/sbin/sshd

echo "[Start] - Nginx"
# Start Nginx
nginx -g "daemon off;"