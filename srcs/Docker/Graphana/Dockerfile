# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:38 by fgalaup           #+#    #+#              #
#    Updated: 2020/03/26 12:05:58 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# To build application I using this pages
# https://github.com/grafana/grafana/blob/master/contribute/developer-guide.md

# Alpine build set (git, golang, js ...) 
FROM alpine:latest

WORKDIR /Application/Grafana

# Path to install graphana
# ENV GOPATH=/Application/Grafana

# Install All dependency
RUN apk update && \
	apk add --no-cache \
	git \
	make \
	go \
	gcc \
	musl-dev \
	g++ \
	nodejs \
	yarn

# Clone repository
RUN git clone https://github.com/grafana/grafana.git /Application/Grafana && \
	git checkout v6.7.1

# Download and install graphana
# RUN go get github.com/grafana/grafana
# RUN go mod verify
# RUN go run build.go build


# Install frontend dependency
RUN yarn install --pure-lockfile

# Build Frontend
RUN yarn start

# Build Backend
RUN make build

EXPOSE 3000

USER grafana

ENTRYPOINT [ "sh" "Entrypoint.sh" ]

# Alpine build container (Backend)
# FROM golang:1.13.4-alpine as build-backend


# Install 
# RUN apk update && \
# 	apk add --no-cache \
# 	git \
# 	gcc \
# 	g++

# RUN git                                                                                                                                                                            3 clone https://github.com/grafana/grafana.git /Application/Grafana

# COPY go.mod go.sum ./
# COPY vendor vendor


# COPY pkg pkg
# COPY build.go package.json ./


# Node build container (Frontend)
# FROM node:12.13.0-alpine as build-frontend

# Get result of previous compilation state
# COPY --from=buildbackend Application/Grafana Application/Grafana

# ENV NODE_ENV production

# WORKDIR /Application/Grafana
# WORKDIR /usr/src/app/

# PhantomJS
# RUN apk add --no-cache curl &&\
# 	cd /tmp && curl -Ls https://github.com/dustinblackman/phantomized/releases/download/2.1.1/dockerized-phantomjs.tar.gz | tar xz &&\
# 	cp -R lib lib64 / &&\
# 	cp -R usr/lib/x86_64-linux-gnu /usr/lib &&\
# 	cp -R usr/share /usr/share &&\
# 	cp -R etc/fonts /etc &&\
# 	curl -k -Ls https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar -jxf - &&\
# 	cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs


# COPY package.json yarn.lock ./
# COPY packages packages



# COPY Gruntfile.js tsconfig.json .eslintrc .editorconfig .browserslistrc ./
# COPY public public
# COPY scripts scripts
# COPY emails emails
# RUN yarn install --pure-lockfile
# RUN ./node_modules/.bin/grunt build

################################################################################

# Final container
# FROM alpine:latest

# ARG GF_UID="472"
# ARG GF_GID="472"

# ENV PATH="/usr/share/grafana/bin:$PATH" \
# 	GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
# 	GF_PATHS_DATA="/var/lib/grafana" \
# 	GF_PATHS_HOME="/usr/share/grafana" \
# 	GF_PATHS_LOGS="/var/log/grafana" \
# 	GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
# 	GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

# WORKDIR $GF_PATHS_HOME

# RUN apk add --no-cache ca-certificates bash tzdata && \
# 	apk add --no-cache --upgrade --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main openssl musl-utils

# COPY conf ./conf

# RUN mkdir -p "$GF_PATHS_HOME/.aws" && \
# 	addgroup -S -g $GF_GID grafana && \
# 	adduser -S -u $GF_UID -G grafana grafana && \
# 	mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
# 	"$GF_PATHS_PROVISIONING/dashboards" \
# 	"$GF_PATHS_PROVISIONING/notifiers" \
# 	"$GF_PATHS_LOGS" \
# 	"$GF_PATHS_PLUGINS" \
# 	"$GF_PATHS_DATA" && \
# 	cp "$GF_PATHS_HOME/conf/sample.ini" "$GF_PATHS_CONFIG" && \
# 	cp "$GF_PATHS_HOME/conf/ldap.toml" /etc/grafana/ldap.toml && \
# 	chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING" && \
# 	chmod -R 777 "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"

# PhantomJS
# COPY --from=1 /tmp/lib /lib
# COPY --from=1 /tmp/lib64 /lib64
# COPY --from=1 /tmp/usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
# COPY --from=1 /tmp/usr/share /usr/share
# COPY --from=1 /tmp/etc/fonts /etc/fonts
# COPY --from=1 /usr/local/bin/phantomjs /usr/local/bin

# COPY --from=0 /go/src/github.com/grafana/grafana/bin/linux-amd64/grafana-server /go/src/github.com/grafana/grafana/bin/linux-amd64/grafana-cli ./bin/
# COPY --from=1 /usr/src/app/public ./public
# COPY --from=1 /usr/src/app/tools ./tools
# COPY tools/phantomjs/render.js ./tools/phantomjs/render.js


# COPY ./packaging/docker/run.sh /run.sh

EXPOSE 3000

USER grafana

# ENTRYPOINT [ "/run.sh" ]