# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    update-kubernetes.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: felix <felix@student.42lyon.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/20 11:27:56 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/12 11:22:50 by felix            ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if minikube status > /dev/null 2>&1
then
	# Deploy with kubernetes
	kubectl apply -k ./srcs/Kubernetes/
fi
