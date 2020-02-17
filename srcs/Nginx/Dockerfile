# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 12:23:59 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/17 14:36:48 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


# Use the last version of alpine linux
FROM alpine:latest

# Exposed port
EXPOSE 443 80 22

# Install Nginx
RUN apk add --update nginx && \
    apk add --update openssh && \
	rm -f /var/cache/apk/*
    # apk cache clean

# Generate SSH key
RUN ssh-keygen -A

# Make Application Directory
RUN mkdir /Application && \
	mkdir /Application/Certs && \
	mkdir /Application/www

# Configure Nginx
COPY Config/nginx.conf /etc/nginx/

# Setup SSL Certificate
COPY Config/Certs/tls.crt /Application/Certs/
COPY Config/Certs/tls.key /Application/Certs/

# Setup site files
COPY Application/* /Application/www

# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh

ENTRYPOINT [ "sh", "Entrypoint.sh" ]
# Unusable beacause i need to start ssh services befor
# CMD ["nginx", "-g", "daemon off;"]