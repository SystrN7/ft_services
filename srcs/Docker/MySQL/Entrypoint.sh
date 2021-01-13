# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: felix <felix@student.42lyon.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 15:23:52 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/13 15:44:40 by felix            ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Set default user value
[ -z "$MYSQL_DATA_PATH" ] && MYSQL_DATA_PATH=/Application/MySQL_DATA/
[ -z "$MYSQL_ROOT_NAME" ] && MYSQL_ROOT_NAME=root
[ -z "$MYSQL_ROOT_PASSWORD" ] && MYSQL_ROOT_PASSWORD=root

# Creating flolder to runing mysql deamon
if [ ! -d /run/mysqld ]
then
	mkdir -p /run/mysqld
fi

# Creating data flolder 
if [ ! -d "$MYSQL_DATA_PATH" ]
then
	mkdir -p "$MYSQL_DATA_PATH"
fi

if [ ! -d $MYSQL_DATA_PATH/mysql ]
then
	mysql_install_db --datadir="${MYSQL_DATA_PATH}" --user="${MYSQL_ROOT_NAME}"
else
	echo "Database allredy exist."
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

