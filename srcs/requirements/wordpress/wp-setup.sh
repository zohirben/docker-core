#!/bin/bash

set -e

echo "SH::Starting wp-setup.sh script..."

if [ ! -f "/var/www/html/wp-config.php" ]; then
  echo "SH::wp-config.php not found. Setting up WordPress..."
  mkdir -p /var/www/html

  echo "SH::Downloading WordPress..."
  wp core download --path="/var/www/html" --allow-root

  echo "SH::Creating wp-config.php..."
  wp config create \
     --dbname="${DB_NAME}" \
     --dbuser="${DB_USER}" \
     --dbpass="${DB_PASSWORD}" \
     --dbhost="mariadb" \
     --path="/var/www/html" \
     --allow-root

  echo "SH::Installing WordPress..."
  wp core install \
     --url="${WORDPRESS_URL}" \
     --title="${WORDPRESS_TITLE}" \
     --admin_user="${WORDPRESS_ADMIN_USERNAME}" \
     --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
     --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
     --path="/var/www/html" \
     --allow-root

  echo "SH::Creating WordPress user..."
  wp user create "${WORDPRESS_USER}" "${WORDPRESS_USER_EMAIL}" \
      --role="subscriber" \
      --user_pass="${WORDPRESS_USER_PASSWORD}" \
      --path="/var/www/html" \
      --allow-root

  chown -R www-data:www-data /var/www/html
else
  echo "SH::wp-config.php found. Skipping setup..."
  chown -R www-data:www-data /var/www/html
fi

echo "SH::wp-setup.sh script completed."

exec "$@"