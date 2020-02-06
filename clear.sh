# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    clear.sh                                         .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: fgalaup <fgalaup@student.le-101.fr>        +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/02/05 15:19:43 by fgalaup      #+#   ##    ##    #+#        #
#    Updated: 2020/02/05 15:37:07 by fgalaup     ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/sh

# ================================= REMOVE =================================== #

# Clear all services deploy with Kubernetes.
kubectl delete -k srcs

# Stop minikube
sh ./stop.sh

# Delete the cluster
minikube delete

# Optional if you want clear all
if [ "$1" = "--all" ]
then
    brew remove minikube
    brew remove docker
    brew clean
fi