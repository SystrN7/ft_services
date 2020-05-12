# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:32 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/25 11:33:47 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_graphana:1.0 .

# Remove previous container
docker stop graphana
docker container rm graphana

# Docker run image
docker container run -d \
	 --name graphana \
	 -p 3000:3000 \
	ft_graphana:1.0

# Show log after app start (to show error)
sleep 5;
docker logs graphana

# [i] Test Procedure