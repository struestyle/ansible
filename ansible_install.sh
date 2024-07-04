#!/bin/bash

# Fonction pour vérifier si un utilisateur est root
is_root() {
  [ "$(id -u)" -eq 0 ]
}

# Fonction pour vérifier si ansible est déjà installé
is_ansible_installed() {
  if command -v ansible > /dev/null; then
    echo "Ansible is already installed."
    return 0
  else
    return 1
  fi
}

# Installation de pipx
install_pipx() {
  if is_root; then
    echo "Installing pipx as root user..."
    apt install pipx -y
  else
    echo "Installing pipx as non-root user using sudo..."
    sudo apt install pipx -y
  fi
}

# Installation de ansible-core avec pipx
install_ansible_core() {
  echo "Installing ansible-core with pipx..."
  pipx install ansible-core
}

# Assurer que pipx est dans le PATH
ensure_pipx_path() {
  echo "Ensuring pipx is in the PATH..."
  pipx ensurepath
}

# Vérifier et installer ansible si nécessaire
install_ansible_if_needed() {
  if is_ansible_installed; then
    echo "Skipping ansible-core installation."
  else
    echo "Ansible is not installed with default packet manager. Proceeding with pipx installation."
    install_pipx
    install_ansible_core
    ensure_pipx_path
  fi
}

# Exécution des fonctions
install_ansible_if_needed

echo "Script execution completed. Make sure to reauthenticate to take change of pipx ensured path"
