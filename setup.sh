# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/19 16:30:48 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/10 16:49:16 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


#!/bin/sh

# ================================== SETUP =================================== #

# Check if dependency is installed and install.
# Docker
if ! which docker > /dev/null 2>&1
then
    # Install Docker
    brew install docker
fi

# Minikube
if ! which minikube > /dev/null 2>&1
then
    # Install Minikube
    brew install minikube
fi

# =============================== RUN MINIKUBE =============================== #

# Check if minikube is 
if ! minikube status > /dev/null 2>&1
then
    echo "Start Minikube ..."
    if ! minikube start --driver=virtualbox \
        --cpus 4 --disk-size=30000mb --memory=4000mb
        # \
        # --bootstrapper=kubeadm # allow telegraf to query metrics
        # -p ft_services # add namek8
    then
        echo "Cannot start minikube!"
        exit 1
    fi

    # Make search to enable
	minikube addons enable metallb
	minikube addons enable dashboard
	minikube addons enable metrics-server
fi

# ================================== DEPLOY ================================== #

# Get Minikube IP Addrress For Configuration


# Linking client docker with docker in virtual box
eval $(minikube docker-env)

# Build docker all docker image
docker image build --tag ft_nginx:1.0 ./srcs/Docker/Nginx/
docker image build --tag ft_mysql:1.0 ./srcs/Docker/MySQL/
docker image build --tag ft_phpmyadmin:1.0 ./srcs/Docker/PHPMyAdmin/
docker image build --tag ft_wordpress:1.0 ./srcs/Docker/WordPress/
docker image build --tag ft_ftps:1.0 ./srcs/Docker/FTPS/
docker image build --tag ft_influxdb:1.0 ./srcs/Docker/InfluxDB/
docker image build --tag ft_grafana:1.0 ./srcs/Docker/Grafana/

# Deploy with kubernetes
kubectl apply -k ./srcs/Kubernetes/

minikube dashboard