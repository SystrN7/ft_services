# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 11:45:34 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/19 12:26:34 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_wordpress:1.0 .

# Remove previous container
docker stop wordpress
docker container rm wordpress

# Docker run image
docker container run -d \
	 --name wordpress \
	 -e WORDPRESS_DATABASE_HOST=192.168.99.100 \
	 -e WORDPRESS_DATABASE_PORT=3306 \
	 -e WORDPRESS_DATABASE_NAME=wordpress \
	 -e WORDPRESS_DATABASE_USER=root \
	 -e WORDPRESS_DATABASE_PASSWORD=root \
	 -e WORDPRESS_SITE_URL=http://192.168.99.100:4050
	 -e WORDPRESS_USER_IMPORT_CSV=true \
	 -e WORDPRESS_USER_RANDOM=25 \
	 -p 4050:80 \
	ft_wordpress:1.0

# Show log after app start (to show error)
sleep 5;
docker logs wordpress

# [i] Test Procedure
# To login use command to get ip of Vitual Machine
# minikube ip
# And login with port
# 5350 # Http