echo 'Creating cluster ...'
k3d cluster create one-cluster --servers 1 -p "443:443@loadbalancer" -p "80:80@loadbalancer" --k3s-arg "--disable=traefik@server:0" --k3s-arg "--disable=metrics-server@server:0" --api-port 6550
#openssl genrsa -out ca.key 4096
#openssl req -new -x509 -sha256 -days 10950 -key ca.key -out ca.crt
echo 'Installing Gateway API'
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.5.1/standard-install.yaml
echo 'Cert manager ...'
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml
echo 'Waiting Cert manager finish install ...'
kubectl wait deployment cert-manager-webhook -n cert-manager --for condition=Available=True --timeout=-1s
export TLS_CRT="$(cat ca.crt | base64 -w 0)"
export TLS_KEY="$(cat ca.key | base64 -w 0)"
envsubst < cluster-secret.yaml | kubectl apply -n cert-manager -f -
kubectl apply -n cert-manager -f cluster-issuer.yaml
echo 'Finish ;-)'
