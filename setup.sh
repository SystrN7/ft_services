# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/19 16:30:48 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/17 11:46:45 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


#!/bin/sh

# ================================== SETUP =================================== #

# Check if dependency is installed and install.
# Brew
if ! which brew > /dev/null 2>&1
then
    # Install Brew
    curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
fi

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
    if ! minikube start --vm-driver=virtualbox \
        --cpus 3 --disk-size=30000mb --memory=3000mb
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

# Build docker image
