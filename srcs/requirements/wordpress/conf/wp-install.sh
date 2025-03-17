#!/bin/sh

until mysqladmin ping -h "mariadb" --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

echo "MariaDB is ready! Starting WordPress setup."

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    # Install WordPress
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USR}" \
        --admin_password="${WP_ADMIN_PWD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    echo "WordPress installed successfully!! ${DOMAIN_NAME}"
    
    # Create a second user
    echo "Creating second user..."
    wp user create ${SECOND_USER_NAME} ${SECOND_USER_EMAIL} \
        --role=subscriber \
        --user_pass="${SECOND_USER_PWD}" \
        --allow-root
    
    echo "Second user created successfully!"
    
    # Disable comment moderation
    echo "Disabling comment moderation..."
    wp option update comment_moderation 0 --allow-root
    wp option update comment_whitelist 0 --allow-root
    echo "Comment moderation disabled!"
else
    echo "WordPress is already installed."
fi

# Additional setup if needed (plugins, themes, etc)
# wp plugin install redis-cache --activate --allow-root
# wp plugin update --all --allow-root

echo "WordPress setup complete!"