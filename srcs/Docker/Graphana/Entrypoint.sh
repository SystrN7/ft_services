# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:30 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/16 15:25:36 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/bash -e

PERMISSIONS_OK=0

# Check config folder permition
if [ ! -r "$GF_PATHS_CONFIG" ]; then
    echo "GF_PATHS_CONFIG='$GF_PATHS_CONFIG' is not readable."
    PERMISSIONS_OK=1
fi

# Check data folder permition
if [ ! -w "$GF_PATHS_DATA" ]; then
    echo "GF_PATHS_DATA='$GF_PATHS_DATA' is not writable."
    PERMISSIONS_OK=1
fi

# Check home folder permition
if [ ! -r "$GF_PATHS_HOME" ]; then
    echo "GF_PATHS_HOME='$GF_PATHS_HOME' is not readable."
    PERMISSIONS_OK=1
fi

# Display Error messages if directory is not redable
if [ $PERMISSIONS_OK -eq 1 ]; then
    echo "You may have issues with file permissions, more information here: http://docs.grafana.org/installation/docker/#migration-from-a-previous-version-of-the-docker-container-to-5-1-or-later"
fi

# Creating plugin directory
if [ ! -d "$GF_PATHS_PLUGINS" ]; then
    mkdir "$GF_PATHS_PLUGINS"
fi

export HOME="$GF_PATHS_HOME"

if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then
  OLDIFS=$IFS
  IFS=','
  for plugin in ${GF_INSTALL_PLUGINS}; do
    IFS=$OLDIFS
    if [[ $plugin =~ .*\;.* ]]; then
        pluginUrl=$(echo "$plugin" | cut -d';' -f 1)
        pluginWithoutUrl=$(echo "$plugin" | cut -d';' -f 2)
        grafana-cli --pluginUrl "${pluginUrl}" --pluginsDir "${GF_PATHS_PLUGINS}" plugins install ${pluginWithoutUrl}
    else
        grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install ${plugin}
    fi
  done
fi

exec grafana-server                                         \
  --homepath="$GF_PATHS_HOME"                               \
  --config="$GF_PATHS_CONFIG"                               \
  --packaging=docker                                        \
  "$@"                                                      \
  cfg:default.log.mode="console"                            \
  cfg:default.paths.data="$GF_PATHS_DATA"                   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"                   \
  cfg:default.paths.plugins="$GF_PATHS_PLUGINS"             \
  cfg:default.paths.provisioning="$GF_PATHS_PROVISIONING"
