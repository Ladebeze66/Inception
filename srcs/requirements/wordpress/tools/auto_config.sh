#!/bin/bash

# Attendre que MariaDB soit prêt à accepter des connexions
echo "Waiting for MariaDB to be ready..."
sleep 10

# Créer le répertoire pour le PID de PHP-FPM et définir les permissions
mkdir -p /run/php
chown www-data:www-data /run/php

# Installer WordPress
if ! $(wp core is-installed --path='/var/www/html' --allow-root); then
    wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USR} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --path='/var/www/html' --allow-root
    echo "=== WordPress installed ==="
	# Créer un utilisateur supplémentaire
    wp user create ${WP_USR} ${WP_EMAIL} --user_pass=${WP_PWD} --role=subscriber --path='/var/www/html' --allow-root
    echo "=== User ${WP_USR} created ==="
else
    echo "=== WordPress is already installed ==="
fi

exec "$@"
