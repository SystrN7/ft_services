# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 09:56:16 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/16 15:32:22 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use the last version of alpine linux
FROM alpine:latest

# Expose application port
EXPOSE 8086
# Volume to persiting data
VOLUME /var/lib/influxdb

# Install InfluxDB
RUN apk update && \
	apk add --no-cache \
	influxdb

# Copy IfluxDB config
COPY Config/influxdb.conf /etc/influxdb/influxdb.conf

# Copy Entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
