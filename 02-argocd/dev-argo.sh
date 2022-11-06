kubectl apply -k overlays/dev
kubectl wait deployment argocd-server -n argocd --for condition=Available=True --timeout=-1s
kubectl apply -n argocd -f dev-project.yaml
