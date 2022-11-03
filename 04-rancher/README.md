# Rancher

### Helm
```sh
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
```

### Rancher
```sh
kubectl create namespace cattle-system
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=rancher.audryus.arpa --set ingress.extraAnnotations.'cert-manager\.io/cluster-issuer'=cluster-issuer 
kubectl -n cattle-system apply -f cert.yaml 
kubectl -n cattle-system apply -f traefik-mdw-redirecttohttps.yaml
kubectl -n cattle-system apply -f ingress.yaml
```
> It wasn't supposed to work, but it does