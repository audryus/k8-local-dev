# Pre requisite

## VM
#### Network
- NAT
- HOST

## Debian
> As root ...
```sh
vi /etc/network/interfaces
```
> allow-hotplug enp0s3 enp0s8
> iface enp0s8 inet dhcp
```sh
apt-get install sudo
usermod -a -G sudo $USER
```
#### Restart VM
> As $USER

```sh
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release vim zsh git
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Docker
```sh
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
```

## kubectl
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mkdir -p ~/.local/bin
sudo mv ./kubectl ~/.local/bin/kubectl
# and add `alias k=kubectl` to bash/zsh
cp .profile .zprofile
# logout / login
```

## k3d
```sh
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```
