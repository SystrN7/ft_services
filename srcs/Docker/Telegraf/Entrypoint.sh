# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/16 10:55:10 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/15 12:23:55 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Start telegraf
telegraf --config /Application/Telegraf/telegraf.conf