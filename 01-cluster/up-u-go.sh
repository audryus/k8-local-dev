echo 'Creating cluster ...'
curl -sfL https://get.k3s.io | sh -s - server --disable traefik --disable metrics-server --cluster-init
sudo chown $USER: /etc/rancher/k3s/k3s.yaml
sudo chown -R $USER: /etc/rancher/k3s/
#openssl genrsa -out ca.key 4096
#openssl req -new -x509 -sha256 -days 10950 -key ca.key -out ca.crt
echo 'Installing Gateway API'
sudo kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.6.1/standard-install.yaml
echo 'Cert manager ...'
sudo kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
echo 'Waiting Cert manager finish install ...'
sudo kubectl wait deployment cert-manager-webhook -n cert-manager --for condition=Available=True --timeout=-1s
export TLS_CRT="$(cat ca.crt | base64 -w 0)"
export TLS_KEY="$(cat ca.key | base64 -w 0)"
envsubst < cluster-secret.yaml | sudo kubectl apply -n cert-manager -f -
sudo kubectl apply -n cert-manager -f cluster-issuer.yaml
echo 'Finish ;-)'