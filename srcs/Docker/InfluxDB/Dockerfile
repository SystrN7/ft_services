# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 09:56:16 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/16 11:15:16 by fgalaup          ###   ########lyon.fr    #
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
	apk add influxdb && \
    rm -f /var/cache/apk/*

# Copy IfluxDB config
COPY Config/influxdb.conf /etc/influxdb/influxdb.conf

# Copy Entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
