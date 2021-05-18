#!/bin/bash

# Moves the .gpd file
sudo mv /Salt-Minion-Setup/salt-archive-keyring.gpg /usr/share/keyrings/

# Adds the SaltStack repository to trusted sources
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list

# Update repository list
sudo apt-get update

# Install salt minion package
sudo apt-get install salt-minion
