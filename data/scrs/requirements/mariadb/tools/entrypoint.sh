#!/bin/bash

# Démarrer le service MariaDB
service mysql start
# Remplacer les variables dans le fichier SQL
envsubst < /docker-entrypoint-initdb.d/init_db_template.sql > /docker-entrypoint-initdb.d/init_db.sql
# Exécuter le script SQL d'initialisation
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /docker-entrypoint-initdb.d/init_db.sql
if [ $? -ne 0 ]; then
    echo "Échec de l'exécution du script SQL"
    exit 1
fi

echo "=== Script SQL exécuté avec succès ==="

# Fonction de surveillance pour garder le conteneur en cours d'exécution
while true; do
    sleep 60
    if ! pgrep mysqld > /dev/null; then
        echo "Le service MySQL s'est arrêté, redémarrage..."
        service mysql restart
    fi
done

