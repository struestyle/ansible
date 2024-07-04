#!/bin/bash

# Fonction pour vérifier si un utilisateur est root
is_root() {
  [ "$(id -u)" -eq 0 ]
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

# Exécution des fonctions
install_pipx
install_ansible_core
ensure_pipx_path

echo "Script execution completed."
