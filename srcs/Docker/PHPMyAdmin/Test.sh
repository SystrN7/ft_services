# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 11:45:34 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/08 11:00:29 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_phpmyadmin:1.0 .

# Remove previous container
docker stop phpmyadmin
docker container rm phpmyadmin

# Docker run image
docker container run -d \
	 --name phpmyadmin \
	 -e PMA_HOST=192.168.99.100 \
	 -e PMA_PMADB=phpmyadmin \
	 -e PMA_PORT=3306 \
	 -e PMA_USER=root \
	 -e PMA_PASSWORD=root \
	 -p 5000:80 \
	ft_phpmyadmin:1.0

# Show log after app start (to show error)
sleep 5;
docker logs phpmyadmin

# [i] Test Procedure
# To login use command to get ip of Vitual Machine
# minikube ip
# And login with port
# 5350 # Http