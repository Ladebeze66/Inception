FROM debian:bullseye

# Installer les paquets nécessaires
RUN apt update -y && apt upgrade -y && \
    apt-get install -y php7.4-fpm php7.4-mysql mariadb-client wget curl vim && \
    mkdir -p /var/www/html && \
    wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

#RUN apt-get install sendmail -y

# Copier les fichiers de configuration PHP et le script d'auto-configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./tools/auto_config.sh /usr/local/bin/

# Assurer les bonnes permissions pour les fichiers
RUN chmod +x /usr/local/bin/auto_config.sh && \
    chmod -R 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html ; \
    chown www-data:www-data /var/www/html/index.php
RUN chmod -R 777 /var/www/html


ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
