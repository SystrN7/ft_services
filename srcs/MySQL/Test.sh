# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 11:45:34 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/19 16:49:42 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Creating docker image
docker image build --tag services_mysql:1.0 .

# Remove previous container
docker stop mysql
docker container rm mysql

# Docker run image
docker container run -d --name mysql -p 3306:3306 services_mysql:1.0


sleep 5;
docker logs mysql

# To connect to the MySQL
