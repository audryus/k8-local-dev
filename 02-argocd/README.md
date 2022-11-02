# Argo CD

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f cmd-params-cm.yaml
kubectl apply -n argocd -f cert.yaml
kubectl apply -n argocd -f ingress.yaml

# need to restart, don't know why
kubectl rollout restart deployment argocd-server -n argocd

# get password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
