#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    mysqld_safe &
    
    until mysqladmin ping --silent; do
        sleep 2
    done

    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown
fi

exec "$@"
# exec "mysqld_safe"