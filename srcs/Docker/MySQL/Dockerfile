# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 10:35:18 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/17 15:39:04 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use the last version of alpine linux
FROM alpine:3.12

# Exposed port
EXPOSE 3306
# Creating volume to persisting data
VOLUME [ "/Application/MySQL_DATA" ]

# Install MySQL
RUN apk update && \
	apk add --no-cache \
	mysql


# Copy entrypoint
COPY Entrypoint.sh /Entrypoint.sh

ENTRYPOINT [ "sh", "/Entrypoint.sh" ]