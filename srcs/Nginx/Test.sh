# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Test.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 11:45:34 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/17 15:03:38 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Creating docker image
docker image build --tag services_nginx:1.0 .

# Remove previous container
docker stop nginx
docker container rm nginx

# Docker run image
docker container run -d --name nginx -p 800:80 -p 4430:443 -p 220:22 services_nginx:1.0

# To login use command to get ip of vm
minikube ip
# And login with port
800 # For http
4430 # For https

# To connect to the ssh

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null admin@192.168.99.102 -p 220

# Revoke old key
ssh-keygen -R 192.168.99.102