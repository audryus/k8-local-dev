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
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
# add `alias k=kubectl` to bash/zsh
cp .profile .zprofile
```

## kubectx and kubens
```sh
git clone https://github.com/ahmetb/kubectx /opt/kubectx
mv kubectx/kubectx .local/bin 
mv kubectx/kubens .local/bin

# add `alias kx=kubectx` to bash/zsh
# add `alias kn=kubens` to bash/zsh
```
> Logout / Login

## k3d
```sh
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

## Helm
```sh
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## Linkerd
```sh
helm repo add linkerd https://helm.linkerd.io/stable
```

## Step
```sh
wget https://dl.step.sm/gh-release/cli/docs-cli-install/v0.21.0/step-cli_0.21.0_amd64.deb
sudo dpkg -i step-cli_0.21.0_amd64.deb
```
