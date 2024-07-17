FROM debian:buster

# Install necessary packages
RUN apt update -y && apt upgrade -y
RUN apt-get install -y mariadb-server mariadb-client gettext-base

# Create the required directory for the Unix socket file
RUN mkdir -p /run/mysqld /var/www
RUN chown mysql:mysql /run/mysqld

# Copy configuration files
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init_db.sql /etc/mysql/init_db.sql
COPY ./tools/init_db.sql /docker-entrypoint-initdb.d/init_db.sql
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

# Ensure the script and SQL file have the correct permissions
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod 644 /etc/mysql/init_db.sql
RUN chmod 644 /docker-entrypoint-initdb.d/init_db.sql
RUN chmod -R 777 /var/lib/mysql

EXPOSE 3306

# Use the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
