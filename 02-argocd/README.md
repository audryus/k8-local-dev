# Argo CD

```sh
kubectl apply -k overlays/dev
kubectl wait deployment argocd-server -n argocd --for condition=Available=True --timeout=-1s
kubectl apply -n argocd -f dev-project.yaml

# get password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
