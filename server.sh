# ALL BOX ESSENTIALS 
sudo apt install -y git curl build-essential apache2-utils figlet pwgen atop htop nmon bmon telnet ncat iptraf-ng bwm-ng \
     tmux nmap sysstat net-tools keychain whois python3-venv vnstat vim-nox fzf vim jq fping tree

# TIMEDATE
sudo timedatectl set-timezone America/Los_Angeles

# LOCAL VM
sudo apt install -y qemu-guest-agent

# WORKSTATION
sudo apt install -y ffmpeg yt-dlp imagemagick network-manager-openconnect-gnome gnome-tweaks

# gnome 
sudo apt-get install gnome-browser-connector

# MS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update && sudo aot install code

# ultralauncher
sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt -y install ulauncher

# tabby terminal
curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh | sudo bash
sudo apt install -y tabby-terminal

# tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.debfind
sudo dpkg -i google-chrome-stable_current_amd64.deb
cd -

# Cascadia Nerd font 
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
mkdir -p ~/.local/share/fonts
cp CascadiaFont/*.ttf ~/.local/share/fonts
fc-cache
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'\n")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'CaskaydiaMono Nerd Font 10'
cd -

# debian-only server additionals
sudo apt install sudo

# certbot
sudo apt install snapd
sudo snap install certbot --classic
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# EOF
