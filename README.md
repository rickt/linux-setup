# linux-setup
rickt's Linux setup scripts

## if you dare
```
curl -s -L https://rickt.dev/linux_setup.sh | bash
```

## all box essentials
```
sudo apt install -y git curl build-essential apache2-utils figlet pwgen atop btop htop \
     bmon nmon telnet ncat iptraf-ng bwm-ng nmap sysstat net-tools keychain whois \
     python3-venv vnstat vim-nox fzf vim jq fping tree
```

## timedate fix for workstation
```
sudo timedatectl set-timezone America/Los_Angeles
```

## qemu agent for VM
```
sudo apt install -y qemu-guest-agent
```

## gnome-only workstation stuff
```
sudo apt-get install gnome-browser-connector ffmpeg yt-dlp imagemagick network-manager-openconnect-gnome gnome-tweaks
```

## install chrome
```
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.debfind
sudo dpkg -i google-chrome-stable_current_amd64.deb
cd -
```

## install MS code
```
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update && sudo apt install code
```

## install ultralauncher
```
sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt -y install ulauncher
```

## install tabby terminal
```
curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh | sudo bash
sudo apt install -y tabby-terminal
```

## install tailscale
```
curl -fsSL https://tailscale.com/install.sh | sh
```

## install OG docker
```
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker ${USER}
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json
```

## Cascadia Nerd font
```
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
mkdir -p ~/.local/share/fonts
cp CascadiaFont/*.ttf ~/.local/share/fonts
fc-cache
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'\n")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'CaskaydiaMono Nerd Font 10'
cd -
```

## install node
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

## install ollama
```
curl -fsSL https://ollama.com/install.sh | sh
```

## install github-cli
```
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install gh -y
```
