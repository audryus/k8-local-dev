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
```
> It was supposed to no work
> And it doesn't, but works for me.