# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 10:35:18 by fgalaup           #+#    #+#              #
#    Updated: 2020/05/12 10:22:52 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #


# Use the last version of alpine linux
FROM alpine:latest

# Exposed port
EXPOSE 3306
# Creating volume to persisting data
VOLUME [ "/Application/MySQL/DataBases", "/Application/MySQL/Log" ]

# Install MySQL
RUN apk update && \
	apk add --no-cache \
	mysql

# RUN mkdir /Application && \
# 	mkdir /Application/MySQL && \
# 	mkdir /Application/MySQL/DataBases && \
# 	mkdir /Application/MySQL/Log

# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh

ENTRYPOINT [ "sh", "/Entrypoint.sh" ]