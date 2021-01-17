# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:38 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/17 16:16:25 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

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

# Creating Grafana User and 
RUN adduser -DH -g 'grafana' grafana && \
	chown -R grafana:grafana /Application/Grafana && \
	chmod -R 744 /Application/Grafana


# Installation
RUN	ln -s /Application/Grafana/bin/grafana-cli /usr/bin && \
	ln -s /Application/Grafana/bin/grafana-server /usr/bin

# Configure
COPY Config/datasources.yaml /Application/Grafana/conf/provisioning/datasources
COPY Config/dashboard.yaml /Application/Grafana/conf/provisioning/dashboards
COPY Config/dashboards /Application/Grafana/conf/provisioning/dashboards

# USER grafana

EXPOSE 3000
VOLUME	[ "/Application/Grafana/data" ]

WORKDIR /Application/Grafana/

# Copy Entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
