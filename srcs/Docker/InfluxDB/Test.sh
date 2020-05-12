# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 10:06:27 by fgalaup           #+#    #+#              #
#    Updated: 2020/05/12 09:50:25 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_influxdb:1.0 .

# Remove previous container
docker stop influxdb
docker container rm influxdb

# Docker run image
docker container run -d \
	 --name influxdb \
	 -p 8086:8086 \
	ft_influxdb:1.0

# Show log after app start (to show error)
sleep 5;
docker logs influxdb

# [i] Test Procedure