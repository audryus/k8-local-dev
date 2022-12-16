echo 'Installing Argo CD ...'
kubectl apply -k overlays/dev
echo 'Waiting Argo CD ...'
kubectl wait deployment argocd-server -n argocd --for condition=Available=True --timeout=-1s
echo 'Applying GitOps Argo CD ...'
kubectl apply -n argocd -f dev-project.yaml
echo 'Argo CD admin pass:'
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
