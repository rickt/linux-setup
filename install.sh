# 
# rickt's automatic ubuntu setup script
# DON'T DO THIS!!! --> curl -s -L https://rickt.dev/linux_setup.sh | bash
# 

# exit immediately if a command exits with a non-zero status
# set -e

# are we running gnome?
RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)

# yes we are
if $RUNNING_GNOME; then
	echo "*** workstation or laptop detected ***"
	# disable screenlock
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
else
	echo "*** server detected ***"
fi

# setup my ssh key
mkdir -p $HOME/.ssh 2> /dev/null
echo "# rickt personal" >> $HOME/.ssh/authorized_keys
curl -s https://github.com/rickt.keys >> $HOME/.ssh/authorized_keys 
echo "# rickt HMS" >> $HOME/.ssh/authorized_keys
curl -s https://github.com/rickthms.keys >> $HOME/.ssh/authorized_keys 
chmod -R 700 $HOME/.ssh

# install the basics that all boxes need
echo "*** installing the basics ***"
sudo apt install -y -qq git curl build-essential apache2-utils figlet pwgen atop btop htop \
     bmon nmon telnet ncat iptraf-ng bwm-ng nmap sysstat net-tools keychain whois \
     python3-venv vnstat vim-nox fzf vim jq fping tree lsof bind9-dnsutils tmux

# install qemu agent if we're on a kvm/proxmox/etc vm
echo "*** qemu ***"
BOXTYPE=$(systemd-detect-virt)
if [ "$BOXTYPE" == "kvm" ]; then
	sudo apt install -y -qq qemu-guest-agent
fi

# install gui stuff (laptop/workstation that i'm logged into gnome on)
if $RUNNING_GNOME; then
	echo "*** installing workstation/laptop-only stuff ***"
	# install chrome
	cd ~/Downloads
	wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb
	cd -

	# install vpn stuff
	sudo apt install -y -qq network-manager-openconnect-gnome 

	# install gnome
	sudo apt install -y -qq gnome-browser-connector gnome-tweaks

	# install tabby terminal
	curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh | sudo bash
	sudo apt install -y -qq tabby-terminal

	# install tailscale
	curl -fsSL https://tailscale.com/install.sh | sh

	# install ultralauncher
	sudo add-apt-repository universe -y && sudo add-apt-repository -y ppa:agornostal/ulauncher -y && sudo apt update && sudo apt -y -qq install ulauncher

	# install Code
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
	rm -f packages.microsoft.gpg
	sudo apt update && sudo apt install -qq code

	# install OG docker
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo usermod -aG docker ${USER}
	echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

	# Cascadia Nerd Font
	cd ~/Downloads
	wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaMono.zip
	unzip CascadiaMono.zip -d CascadiaFont
	mkdir -p ~/.local/share/fonts
	cp CascadiaFont/*.ttf ~/.local/share/fonts
	fc-cache
	PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'\n")
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'CaskaydiaMono Nerd Font 10'
	cd -

	# install node
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

	# install github-cli
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install -y -qq gh

	# install various stuff
	sudo apt install -y -qq ffmpeg yt-dlp
fi

# EOF
