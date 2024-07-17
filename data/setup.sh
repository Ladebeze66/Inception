#!/bin/bash

USER="fgras-ca"

# Vérifiez si le script est exécuté en tant que root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root"
    exit 1
fi

# Ajouter l'utilisateur au fichier sudoers
if ! grep -q "$USER ALL=(ALL:ALL) ALL" /etc/sudoers; then
    echo "Adding $USER to sudoers file..."
    echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

# Configurer le délai de validité du mot de passe sudo à une durée indéfinie
if ! grep -q "timestamp_timeout=-1" /etc/sudoers; then
    echo "Setting sudo password timeout to indefinite..."
    echo "Defaults        timestamp_timeout=-1" >> /etc/sudoers
fi

# Mise à jour des paquets
echo "Updating package lists..."
apt-get update

# Installer les dépendances nécessaires pour Docker
echo "Installing necessary packages..."
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    make \
    wget

# Ajouter la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajouter le dépôt Docker
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour les paquets à nouveau et installer Docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Installer Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="1.29.2"
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Ajouter l'utilisateur au groupe Docker
echo "Adding user to Docker group..."
usermod -aG docker $USER

# Installation de Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
apt-get install -y code
rm packages.microsoft.gpg

echo "Setup completed. Please log out and log back in for the Docker group changes to take effect."


