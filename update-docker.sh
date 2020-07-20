# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    update-docker.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/20 11:28:39 by fgalaup           #+#    #+#              #
#    Updated: 2020/07/20 11:33:35 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

docker image build --tag ft_nginx:1.0 ./srcs//Docker/Nginx/
docker image build --tag ft_mysql:1.0 ./srcs/Docker/MySQL/
docker image build --tag ft_phpmyadmin:1.0 ./srcs/Docker/PHPMyAdmin/
docker image build --tag ft_wordpress:1.0 ./srcs/Docker/WordPress/
docker image build --tag ft_ftps:1.0 ./srcs/Docker/FTPS/

