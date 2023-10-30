#!/bin/bash -e
# Essential software for a fresh debian system

# Install basic packages
sudo apt-get update --allow-releaseinfo-change
sudo apt-get install -y build-essential cmake apt-transport-https \
  ca-certificates curl gnupg2 wget software-properties-common dirmngr unzip \
  git expect jq lsb-release ufw

# Install docker
curl -fsSL https://download.docker.com/linux/debian/gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo groupadd -f docker
sudo usermod -aG docker "$(whoami)"
sudo chgrp docker /usr/bin/docker 

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz.sha256sum

if ! sha256sum -c nvim-linux64.tar.gz.sha256sum; then
    echo "Checksum validation failed! Aborting..."
    exit 1
fi

tar xf nvim-linux64.tar.gz
sudo mv nvim-linux64/bin/nvim /usr/bin/
rm -rf nvim-linux*

mkdir ~/.config
mv nvim ~/.config/
nvim --headless -c "luafile ~/.config/nvim/init.lua" -c "q"

exit 0
