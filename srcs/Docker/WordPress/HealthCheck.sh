# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    HealthCheck.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: felix <felix@student.42lyon.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/20 16:24:43 by felix             #+#    #+#              #
#    Updated: 2021/01/21 14:23:07 by felix            ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Cheking if PHP-FPM Deamon is running
pgrep php-fpm > /dev/null

return $?