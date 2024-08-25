SHELL := /bin/bash

# Variables
USER = $(shell whoami)
HOSTNAME=fgras-ca.42.fr
HOSTS_FILE=/etc/hosts
VOLUME_DIR_MYSQL = /home/$(USER)/data/mysql
VOLUME_DIR_HTML = /home/$(USER)/data/html
VOLUMES_DIR = /home/$(USER)/data
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

all: sudo-validate setup-hosts create-volumes start-docker

sudo-validate:
	@echo "Validating sudo credentials..."
	@sudo -v

down:
	@echo "Stopping and removing all Docker containers..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down

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
	@sudo rm -rf $(VOLUMES_DIR)

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
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up --build

.PHONY: all re down clean setup-hosts create-volumes start-docker sudo-validate
