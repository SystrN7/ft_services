# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgalaup <fgalaup@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 15:23:52 by fgalaup           #+#    #+#              #
#    Updated: 2021/01/15 09:55:33 by fgalaup          ###   ########lyon.fr    #
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

# Init Database
if [ ! -d $MYSQL_DATA_PATH/mysql ]
then
	echo "Init Database"
	mysql_install_db --datadir="${MYSQL_DATA_PATH}" --user="${MYSQL_ROOT_NAME}"

	echo "Creating root users"
	# Creating root user for remote access to the databases.
	echo "FLUSH PRIVILEGES;" > /tmps
	echo "CREATE USER '$MYSQL_ROOT_NAME'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /tmps
	echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_NAME'@'%' WITH GRANT OPTION;" >> /tmps

	if ! /usr/bin/mysqld --datadir="${MYSQL_DATA_PATH}" --user="${MYSQL_ROOT_NAME}" --bootstrap --verbose=0 < /tmps
	then
		exit 1
	fi
else
	echo "Database allready exist."
fi

# Start Mysql
/usr/bin/mysqld \
	--datadir="${MYSQL_DATA_PATH}" \
	--user="${MYSQL_ROOT_NAME}" \
	--skip-networking=false \
	--bind-address="0.0.0.0" \
	--port="3306" \
	--console

