FROM debian:bullseye

# Installer Nginx et OpenSSL
RUN apt update -y && apt upgrade -y
RUN apt-get install -y nginx vim openssl

# Créer le répertoire requis pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Copier les configurations de Nginx et le fichier default
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Générer des certificats auto-signés pour SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Perpignan/O=42/OU=42/CN=fgras-ca.42.fr"

RUN mkdir -p /run/nginx

EXPOSE 443

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
