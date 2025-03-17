#!/bin/sh

# Wait for MySQL to be ready to accept connections
if [ -d "/var/lib/mysql/mysql" ]; then
    echo "Database already initialized, starting MariaDB..."
    exec /usr/bin/mysqld --user=mysql --console
    exit 0
fi

echo "Initializing database..."
mysql_install_db --user=mysql --datadir=/var/lib/mysql

/usr/bin/mysqld --user=mysql &

echo "Waiting for MySQL to start..."
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

echo "Creating database and users..."
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p$DB_ROOT shutdown

exec /usr/bin/mysqld --user=mysql --console