# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    setup.sh                                         .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: fgalaup <fgalaup@student.le-101.fr>        +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/19 16:30:48 by fgalaup      #+#   ##    ##    #+#        #
#    Updated: 2020/02/05 15:06:11 by fgalaup     ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/sh

# ================================= SETUP ==================================== #

# Check if dependency is installed and install.
# Brew
if ! which brew >/dev/null 2>&1
then
    # Install Brew
    curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
fi

# Docker
if ! which docker >/dev/null 2>&1
then
    # Install Docker
    brew install docker
fi

# Minikube
if ! which minikube >/dev/null 2>&1
then
    # Install Minikube
    brew install minikube
fi

# ================================== RUN ===================================== #