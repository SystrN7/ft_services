# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/12 10:09:42 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/12 10:12:45 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

eval $(minikube docker-env);

# Creating docker image
docker image build --tag ft_ftps:1.0 .

# Remove previous container
docker stop ftps
docker container rm ftps

# Docker run image
docker container run -d \
	 --name ftps \
	 -p 21:21 \
	ft_ftps:1.0

# Show log after app start (to show error)
sleep 5;
docker logs ftps

# [i] Test Procedure