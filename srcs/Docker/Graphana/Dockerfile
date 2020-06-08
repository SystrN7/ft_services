# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:38 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/06 18:28:18 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Alpine
FROM alpine:latest

# Expose application port
EXPOSE 3000

# Add workspace
WORKDIR /Application/Grafana

# Install graphana
RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
	grafana

# Use graphana User to lanche apps
# RUN addgroup grafana && \
#     adduser -s /bin/false -G grafana -S -D /Application/Grafana
# USER grafana

COPY Config/defaults.ini /Application/Grafana/conf/

# Copy Entryoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
