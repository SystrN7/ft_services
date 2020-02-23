# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.le-101.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 15:23:52 by fgalaup           #+#    #+#              #
#    Updated: 2020/02/23 11:49:46 by fgalaup          ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Set default user value
[ -z "$MYSQL_DATA_PATH" ] && MYSQL_DATA_PATH=/Application/MySQL/DataBases
[ -z "$MYSQL_ROOT_NAME" ] && MYSQL_ROOT_NAME=root
[ -z "$MYSQL_ROOT_PASSWORD" ] && MYSQL_ROOT_PASSWORD=root

# Creating flolder to runing mysql deamon
if [ ! -d /run/mysqld ]
then
	mkdir -p /run/mysqld
fi

# Init MySQL database
if [ ! -d $MYSQL_DATA_PATH/mysql ]
then
	mysql_install_db --datadir="${MYSQL_DATA_PATH}" --user="${MYSQL_ROOT_NAME}" > /dev/null
fi

# Creating root user for remote access to the databases.
echo "FLUSH PRIVILEGES;" > /tmps
echo "CREATE USER '$MYSQL_ROOT_NAME'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /tmps
echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_NAME'@'%' WITH GRANT OPTION;" >> /tmps

if ! /usr/bin/mysqld --datadir="${MYSQL_DATA_PATH}" --user="${MYSQL_ROOT_NAME}" --bootstrap --verbose=0 < /tmps
then
	exit 1
fi

# Start Mysql
/usr/bin/mysqld \
	--datadir="${MYSQL_DATA_PATH}" \
	--user="${MYSQL_ROOT_NAME}" \
	--skip-networking=false \
	--bind-address="0.0.0.0" \
	--port="3306" \
	--console