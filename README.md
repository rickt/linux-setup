# linux-setup
rickt's Linux setup scripts

## all box essentials
```
sudo apt install -y git curl build-essential apache2-utils figlet pwgen atop htop nmon bmon \
telnet ncat iptraf-ng bwm-ng nmap sysstat net-tools keychain whois python3-venv vnstat vim-nox \
fzf vim jq fping tree
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

# install tabby terminal
```
curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh | sudo bash
sudo apt install -y tabby-terminal
```

# install tailscale
```
curl -fsSL https://tailscale.com/install.sh | sh
```

