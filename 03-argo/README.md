# Argo - CI

## This way allow to open dashboard with IngressRoute
### Bad Gateway Or Internal Server
### So, follow the rabbit.

```sh
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.3/install.yaml
kubectl -n argo  patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server",
  "--secure=false"
]}]'
kubectl -n argo  patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": 
  "HTTP"
}]'
kubectl -n argo  apply -f cert.yaml
kubectl -n argo  apply -f ingress.yaml

```




