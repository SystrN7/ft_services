# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    clear.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 15:19:43 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/07 18:31:39 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


#!/bin/sh

# ================================= REMOVE =================================== #

# Clear all services deploy with Kubernetes.
kubectl delete -k ./srcs/Kubernetes/
kubectl delete --all pod
kubectl delete --all deployment
kubectl delete --all service
kubectl delete --all ingress
# kubectl delete service mysql-service
# kubectl delete service phpmyadmin-service
# kubectl delete service nginx-service
# kubectl delete service ssh-service
# kubectl delete ingress ingress-redirect


if [ "$1" = "--minikube" ] || [ "$1" = "--all" ]
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
	bew remove minikube
	bew remove docker
fi
