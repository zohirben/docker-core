#!/bin/bash

set -e


if [ ! -f "/var/www/html/wp-config.php" ]; then
#   # Create directory for WordPress if it doesn't exist
  mkdir -p /var/www/html

  # Download WordPress
  echo "SH::Downloading WordPress..."
  wp core download --path="/var/www/html" --allow-root


  # Create wp-config.php with database credentials
  wp config create \
     --dbname="${DB_NAME}" \
     --dbuser="${DB_USER}" \
     --dbpass="${DB_PASSWORD}" \
     --dbhost="mariadb" \
     --path="/var/www/html" \
     --allow-root

  # Install WordPress with the given admin credentials and site details
  echo "SH::Installing WordPress..."
  wp core install \
     --url="${WORDPRESS_URL}" \
     --title="${WORDPRESS_TITLE}" \
     --admin_user="${WORDPRESS_ADMIN_USERNAME}" \
     --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
     --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
     --path="/var/www/html" \
     --allow-root

   # Create user
   wp user create "${WORDPRESS_USER}" "${WORDPRESS_USER_EMAIL}" \
      --role="subscriber" \
      --user_pass="${WORDPRESS_USER_PASSWORD}" \
      --path="/var/www/html" \
      --allow-root
  chown -R www-data:www-data /var/www/html
else
  chown -R www-data:www-data /var/www/html
fi

exec "$@"
# exec "php-fpm8.2 -F"
