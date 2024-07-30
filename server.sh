#! /bin/bash

# update
sudo apt update

# install some things
sudo apt install -y git curl build-essential pkg-config autoconf bison apache2-utils figlet pwgen \
	atop htop nmon bmon telnet ncat iptraf-ng bwm-ng tmux nmap sysstat net-tools nmap keychain whois \
	python3-venv snapd vnstat vim-nox neofetch fzf vim prettyping jq fping tree

# set timezone
sudo timedatectl set-timezone America/Los_Angeles

# tailscale
# curl -fsSL https://tailscale.com/install.sh | sh

# dotfiles
# git clone git@github.com:rickt/dotfiles.git

# EOF
