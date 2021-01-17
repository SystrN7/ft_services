# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 09:56:16 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/17 15:38:57 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use the last version of alpine linux
FROM alpine:3.12

# Expose application port
EXPOSE 8086
# Volume to persiting data
VOLUME /Application/InfluxDB/

# Install InfluxDB
RUN apk update && \
	apk add --no-cache \
	influxdb

# Copy InfluxDB config
COPY Config/influxdb.conf /etc/influxdb/influxdb.conf

# Copy Entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
