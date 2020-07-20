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

COPY grafana-latest.linux-x64-musl.tar.gz /tmp/grafana.tar.gz

RUN mkdir /tmp/grafana && \
	tar xfz /tmp/grafana.tar.gz --strip-components=1 -C /tmp/grafana && \
	rm /tmp/grafana.tar.gz

ARG GF_UID="472"
ARG GF_GID="472"

ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
	GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
	GF_PATHS_DATA="/var/lib/grafana" \
	GF_PATHS_HOME="/usr/share/grafana" \
	GF_PATHS_LOGS="/var/log/grafana" \
	GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
	GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

WORKDIR $GF_PATHS_HOME

RUN apk add --no-cache ca-certificates bash tzdata && \
	apk add --no-cache --upgrade openssl musl-utils

RUN mv /tmp/grafana/* "$GF_PATHS_HOME"

RUN mkdir -p "$GF_PATHS_HOME/.aws" && \
	addgroup -S -g $GF_GID grafana && \
	adduser -S -u $GF_UID -G grafana grafana && \
	mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
			 "$GF_PATHS_PROVISIONING/dashboards" \
			 "$GF_PATHS_PROVISIONING/notifiers" \
			 "$GF_PATHS_LOGS" \
			 "$GF_PATHS_PLUGINS" \
			 "$GF_PATHS_DATA" && \
	cp "$GF_PATHS_HOME/conf/sample.ini" "$GF_PATHS_CONFIG" && \
	cp "$GF_PATHS_HOME/conf/ldap.toml" /etc/grafana/ldap.toml && \
	chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING" && \
	chmod -R 777 "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"

EXPOSE 3000

# Copy Entrypoint
COPY Entrypoint.sh /

USER grafana

ENTRYPOINT [ "sh", "/Entrypoint.sh" ]
