# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    update-docker.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/20 11:28:39 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/15 12:42:14 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if minikube status > /dev/null 2>&1
then
	eval $(minikube docker-env);
	docker image build --tag ft_nginx:1.0 ./srcs/Docker/Nginx/
	docker image build --tag ft_mysql:1.0 ./srcs/Docker/MySQL/
	docker image build --tag ft_phpmyadmin:1.0 ./srcs/Docker/PHPMyAdmin/
	docker image build --tag ft_wordpress:1.0 ./srcs/Docker/WordPress/
	docker image build --tag ft_ftps:1.0 ./srcs/Docker/FTPS/
	docker image build --tag ft_influxdb:1.0 ./srcs/Docker/InfluxDB/
	docker image build --tag ft_grafana:1.0 ./srcs/Docker/Grafana/
	docker image build --tag ft_telegraf:1.0 ./srcs/Docker/Telegraf/
fi
