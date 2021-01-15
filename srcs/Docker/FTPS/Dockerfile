# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/12 09:15:58 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/15 09:49:34 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use the last version of alpine linux
FROM alpine:latest

EXPOSE 21 15000 15001 15002

# ENV PUREFTPD_VERSION=1.0.42-r0 \
#     SYSLOG_STDOUT_VERSION=1.1.1

# Install ftps software with testing branch
RUN apk update && \
	apk add openssl && \
	apk add --no-cache --allow-untrusted --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
	pure-ftpd

# # puts self signed certs
# COPY Config/Cert/pure-ftpd-dhparams.pem /etc/ssl/private/
# COPY Config/Cert/pure-ftpd.pem /etc/ssl/private/
# RUN chmod 600 /etc/ssl/private/*.pem

# Copy entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]