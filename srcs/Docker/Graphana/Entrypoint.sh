# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 11:26:30 by fgalaup           #+#    #+#              #
#    Updated: 2020/06/06 18:29:26 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

chown -R grafana:grafana /Application/Grafana
grafana-server --homepath=/Application/Grafana
