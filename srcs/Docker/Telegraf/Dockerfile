# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 09:56:16 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/17 15:39:13 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use the last version of alpine linux
FROM alpine:3.12

# Install Telegraf
RUN apk update && \
	apk add --no-cache --allow-untrusted --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
	telegraf=1.17.0-r0

# Copy Telegraf config
COPY Config/telegraf.conf /Application/Telegraf/

# Copy Entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
