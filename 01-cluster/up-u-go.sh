k3d cluster create one-cluster -p "80:80@loadbalancer" -p "443:443@loadbalancer" --wait
#openssl genrsa -out ca.key 4096
#openssl req -new -x509 -sha256 -days 10950 -key ca.key -out ca.crt
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml
kubectl wait deployment cert-manager-webhook -n cert-manager --for condition=Available=True --timeout=-1s
kubectl wait -n kube-system job.batch/helm-install-traefik-crd --for=condition=complete --timeout=-1s
export TLS_CRT="$(cat ca.crt | base64 -w 0)"
export TLS_KEY="$(cat ca.key | base64 -w 0)"
envsubst < cluster-secret.yaml | kubectl apply -n cert-manager -f -
kubectl create namespace traefik
kubectl apply -n traefik -f traefik-cert.yaml
kubectl apply -n traefik -f traefik-mdw-redirecttohttps.yaml
kubectl apply -n traefik -f traefik-dashboard.yaml
sleep 10
kubectl apply -n cert-manager -f cluster-issuer.yaml