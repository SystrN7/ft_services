# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:32 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/10 16:51:56 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_grafana:1.0 .

# Remove previous container
docker stop grafana
docker container rm grafana

# Docker run image
docker container run -d \
	 --name grafana \
	 -p 3000:3000 \
	ft_grafana:1.0

# Show log after app start (to show error)
sleep 5;
docker logs grafana

# [i] Test Procedure