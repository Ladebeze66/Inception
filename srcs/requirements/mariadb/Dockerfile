FROM debian:bullseye

# Exposer le port 3306
EXPOSE 3306

# Installer les paquets nécessaires
RUN apt update -y && apt upgrade -y && \
    apt-get install -y mariadb-server mariadb-client gettext-base procps && \
    apt-get clean

# Créer les répertoires requis
RUN mkdir -p /run/mysqld /var/www && \
    chown mysql:mysql /run/mysqld

# Copier les fichiers de configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

# Assurer les permissions correctes pour le script et les fichiers SQL
RUN chmod +x /usr/local/bin/entrypoint.sh

# Utiliser le script d'entrée
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mariadbd"]
