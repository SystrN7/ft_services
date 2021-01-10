# **************************************************************************** #
#                                                                             #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:38 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/16 12:04:56 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN apk update && \
	apk add --no-cache \
	curl \
	libc6-compat

# Download
RUN	mkdir -p /Application/ && \
	wget https://dl.grafana.com/oss/release/grafana-7.1.5.linux-amd64.tar.gz && \
	tar -zxvf grafana-7.1.5.linux-amd64.tar.gz && \
	rm grafana-7.1.5.linux-amd64.tar.gz && \
	mv grafana-7.1.5 /Application/Grafana

# Fix libc dependency to run the grafana binary
# RUN		mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Installation
RUN	ln -s /Application/Grafana/bin/grafana-cli /usr/bin && \
	ln -s /Application/Grafana/bin/grafana-server /usr/bin

# Configure
# RUN	mv /root/datasources.yaml /Application/Grafana/conf/provisioning/datasources && \
# 		mv /root/dashboard.yaml /Application/Grafana/conf/provisioning/dashboards && \
# 		mv /root/dashboard.json /Application/Grafana/conf/provisioning/dashboards

# Creating Grafana User
RUN adduser -DH -g 'grafana' grafana

USER grafana

# Copy Entrypoint
COPY Entrypoint.sh /

VOLUME	[ "/Application/Grafana/data" ]

EXPOSE 3000

ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
