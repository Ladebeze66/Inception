SHELL := /bin/bash

# Variables
HOSTNAME=fgras-ca.42.fr
HOSTS_FILE=/etc/hosts
VOLUME_DIR_MYSQL=/home/fgras-ca/Inception/data/mysql
VOLUME_DIR_HTML=/home/fgras-ca/Inception/data/html

all: sudo-validate setup-hosts create-volumes start-docker

sudo-validate:
	@echo "Validating sudo credentials..."
	@sudo -v

down:
	@echo "Stopping and removing all Docker containers..."
	@docker-compose -f /home/fgras-ca/Inception/data/scrs/docker-compose.yml down

re: down all

clean: down
	@echo "Cleaning up Docker resources..."
	@if [ $$(docker ps -qa | wc -l) -gt 0 ]; then \
		echo "Stopping containers..."; \
		docker stop $$(docker ps -qa); \
		echo "Removing containers..."; \
		docker rm $$(docker ps -qa); \
	fi
	@if [ $$(docker images -qa | wc -l) -gt 0 ]; then \
		echo "Removing images..."; \
		docker rmi -f $$(docker images -qa); \
	fi
	@if [ $$(docker volume ls -q | wc -l) -gt 0 ]; then \
		echo "Removing volumes..."; \
		docker volume rm $$(docker volume ls -q); \
	fi

	@docker system prune -a --force --volumes
	@echo "Removing MySQL and HTML data directories..."
	@sudo chmod -R 777 $(VOLUME_DIR_MYSQL)
	@sudo chmod -R 777 $(VOLUME_DIR_HTML)
	@sudo rm -rf $(VOLUME_DIR_MYSQL) $(VOLUME_DIR_HTML)

setup-hosts:
	@echo "Configuring /etc/hosts..."
	@if ! grep -q "$(HOSTNAME)" $(HOSTS_FILE); then \
		echo "127.0.0.1 $(HOSTNAME)" | sudo tee -a $(HOSTS_FILE); \
	fi

create-volumes:
	@echo "Creating volume directories..."
	@mkdir -p $(VOLUME_DIR_MYSQL) $(VOLUME_DIR_HTML)

start-docker:
	@echo "Starting Docker Compose in detached mode..."
	@docker-compose -f /home/fgras-ca/Inception/data/scrs/docker-compose.yml up -d --build

.PHONY: all re down clean setup-hosts create-volumes start-docker sudo-validate




