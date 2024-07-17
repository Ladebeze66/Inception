#!/bin/bash

# Démarrer PHP-FPM
service php7.3-fpm start

# Attendre que MariaDB soit prêt
until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Télécharger WP-CLI si nécessaire
if [ ! -f /usr/local/bin/wp ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Télécharger et extraire WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
    wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -O /tmp/wordpress.tar.gz
    tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    chmod -R 777 /var/www/html
fi

# Installer WordPress
if ! $(wp core is-installed --path='/var/www/html' --allow-root); then
    wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USR} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --path='/var/www/html' --allow-root
    echo "=== WordPress installed ==="
else
    echo "=== WordPress is already installed ==="
fi

# Garder le conteneur en cours d'exécution
tail -f /dev/null