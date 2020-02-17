# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    clear.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 15:19:43 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/17 11:46:57 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


#!/bin/sh

# ================================= REMOVE =================================== #

# Clear all services deploy with Kubernetes.
kubectl delete -k srcs

# Stop minikube
sh ./stop.sh

# Delete the cluster
minikube delete --all

# Optional if you want clear all
if [ "$1" = "--all" ]
then
    minikube delete --purge=true
    brew remove minikube
    brew remove docker
    brew clean
fi