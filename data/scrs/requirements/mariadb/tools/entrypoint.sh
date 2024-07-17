#!/bin/bash

# Créer un fichier SQL pour initialiser la base de données
cat << EOF > /docker-entrypoint-initdb.d/init_db.sql
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

service mysql start

# Vérifier si le socket existe
if [ ! -S /var/run/mysqld/mysqld.sock ]; then
    echo "Le fichier de socket MySQL n'existe pas. Création du socket..."
    mkdir -p /var/run/mysqld
    chown mysql:mysql /var/run/mysqld
    service mysql restart
fi

# Exécuter le script SQL
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /docker-entrypoint-initdb.d/init_db.sql
if [ $? -ne 0 ]; then
    echo "Échec de l'exécution du script SQL"
    exit 1
fi

echo "=== Script SQL exécuté avec succès ==="

# Garder le conteneur en cours d'exécution
chown -R mysql:mysql /var/lib/mysql
tail -f /dev/null
