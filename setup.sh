# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/19 16:30:48 by fgalaup           #+#    #+#              #
#    Updated: 2020/07/20 11:32:40 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


#!/bin/sh

# ================================== SETUP =================================== #

# Check if dependency is installed and install.
# Docker
if ! which docker > /dev/null 2>&1
then
    # Install Docker
    sudo apt install docker
fi

# Minikube
if ! which minikube > /dev/null 2>&1
then
    # Install Minikube
    sudo apt install minikube
fi

# =============================== RUN MINIKUBE =============================== #

# Check if minikube is 
if ! minikube status > /dev/null 2>&1
then
    echo "Start Minikube ..."
    if ! minikube start --vm-driver=virtualbox \
        --cpus 4 --disk-size=30000mb --memory=4000mb
        # \
        # --bootstrapper=kubeadm # allow telegraf to query metrics
        # -p ft_services # add name
    then
        echo "Cannot start minikube!"
        exit 1
    fi

    # Make search to enable
    minikube addons enable ingress
    # minikube addons enable metrics-server
fi

# ================================== DEPLOY ================================== #

# Linking client docker with docker in virtual box
eval $(minikube docker-env)

# Build docker all docker image
docker image build --no-cache=true --tag ft_nginx:1.0 ./srcs//Docker/Nginx/
docker image build --no-cache=true --tag ft_mysql:1.0 ./srcs/Docker/MySQL/
docker image build --no-cache=true --tag ft_phpmyadmin:1.0 ./srcs/Docker/PHPMyAdmin/
docker image build --no-cache=true --tag ft_wordpress:1.0 ./srcs/Docker/WordPress/
docker image build --no-cache=true --tag ft_ftps:1.0 ./srcs/Docker/FTPS/
docker image build --no-cache=true --tag ft_influxdb:1.0 ./srcs/Docker/InfluxDB/

# Deploy with kubernetes
kubectl apply -k ./srcs/Kubernetes/

