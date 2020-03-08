# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    clear.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 15:19:43 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/26 16:51:46 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


#!/bin/sh

# ================================= REMOVE =================================== #

# Clear all services deploy with Kubernetes.
kubectl delete --all pod
kubectl delete service mysql-service
kubectl delete service phpmyadmin-service
kubectl delete service nginx-service
kubectl delete service ssh-service
kubectl delete ingress ingress-redirect


if [ "$1" = "--minikube" ]
then
# Stop minikube
sh ./stop.sh

# Delete the cluster
minikube delete --all
fi

# Optional if you want clear all
if [ "$1" = "--all" ]
then
    minikube delete --purge=true
    brew remove minikube
    brew remove docker
    brew clean
fi
