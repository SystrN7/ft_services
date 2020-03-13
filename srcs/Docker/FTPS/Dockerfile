# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/12 09:15:58 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/12 15:14:23 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Use the last version of alpine linux
FROM alpine:latest

EXPOSE 21

# ENV PUREFTPD_VERSION=1.0.42-r0 \
#     SYSLOG_STDOUT_VERSION=1.1.1

# Enable the testing repository
RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

# Install ftps software with testing branch
RUN apk update && \
	apk add --no-cache \
    pure-ftpd@testing=1.0.49-r0

# puts self signed certs
COPY Config/Cert/pure-ftpd-dhparams.pem /etc/ssl/private/
COPY Config/Cert/pure-ftpd.pem /etc/ssl/private/
RUN chmod 600 /etc/ssl/private/*.pem

# Copy entrypoint
COPY Entrypoint.sh /
ENTRYPOINT [ "sh", "/Entrypoint.sh" ]