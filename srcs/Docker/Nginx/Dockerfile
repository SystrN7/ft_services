# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 12:23:59 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/24 18:00:18 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


# Use the last version of alpine linux
FROM alpine:latest

# Exposed port
EXPOSE 443 80 22
# USER www:www

# Creating Nginx User
RUN adduser -DH -g 'www' www

# Install Nginx
RUN apk update && \
	apk add nginx && \
    apk add openssh && \
	rm -f /var/cache/apk/*
    # apk cache clean

# Generate SSH key
RUN ssh-keygen -A

# Make Application Directory
RUN mkdir /Application && \
	mkdir /Application/Certs && \
	mkdir /Application/www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /Application

# Configure Nginx
COPY Config/nginx.conf /etc/nginx/

# Setup SSL Certificate
COPY Config/Certs/tls.crt /Application/Certs/
COPY Config/Certs/tls.key /Application/Certs/

# Setup site files
COPY Application/* /Application/www


# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh

ENTRYPOINT [ "sh", "/Entrypoint.sh" ]