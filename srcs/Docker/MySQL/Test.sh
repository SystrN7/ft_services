# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 11:45:34 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/08 11:00:33 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_mysql:1.0 .

# Remove previous container
docker stop mysql
docker container rm mysql

# Docker run image
docker container run -d --name mysql -p 3306:3306 ft_mysql:1.0

# Show log after app start (to show error)
sleep 5;
docker logs mysql


# [i] Test Procedure
# To connect to the MySQL
# Before you need to install mysql-client with brew
# ~/.brew/Cellar/mysql-client/8.0.18/bin/mysql -h 192.168.99.102 -u root --password="root"