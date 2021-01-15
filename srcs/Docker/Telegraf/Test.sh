# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 10:06:27 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/15 12:14:10 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_telegraf:1.0 .

# Remove previous container
docker stop telegraf
docker container rm telegraf

# Docker run image
docker container run -d \
	 --name telegraf \
	 -p 8086:8086 \
	ft_telegraf:1.0

# Show log after app start (to show error)
sleep 5;
docker logs telegraf

# [i] Test Procedure