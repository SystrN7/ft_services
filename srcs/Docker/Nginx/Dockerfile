# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 12:23:59 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/17 16:16:56 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

# Exposed port
EXPOSE 443 80 22
# USER www:www

# Creating Nginx User
RUN adduser -DH -g 'www' www

# Install Nginx and tool to creating ssl key 
RUN apk update && \
	apk add --no-cache \
	nginx \
	openssl \
	openssh
# ??? Check if last dependecy is requiered

# Make Application Directory
RUN mkdir /Application && \
	mkdir /Application/Certs && \
	mkdir /Application/tmp && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /Application

# Configure Nginx
COPY Config/ /etc/nginx/
# Fix Error : https://superuser.com/questions/1306656/cant-run-nginx-in-alpine-linux-docker
RUN mkdir -p /run/nginx

RUN mkdir /etc/nginx/sites-enabled/ && \
	ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/

# Setup SSL Certificate
RUN openssl dhparam -out /etc/nginx/dhparam.pem 2048
RUN openssl req -x509 -nodes -days 365 -newkey rsa:1024 \
	-subj "/C=FT/ST=SERVICE/L=C/O=LA/CN=www.MORT.com" \
	-keyout /Application/Certs/ssl.key -out /Application/Certs/ssl.crt

# Generating SSH key
RUN ssh-keygen -A

# Setup site files
COPY Application/* /Application/tmp


# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh

ENTRYPOINT [ "sh", "/Entrypoint.sh" ]