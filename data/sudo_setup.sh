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

echo "Sudo setup completed."