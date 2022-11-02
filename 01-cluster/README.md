# Cluster

## k3d
```sh
k3d cluster create one-cluster -p "80:80@loadbalancer" -p "443:443@loadbalancer"
# will make cluster available over port 80 and 443, which makes things easier
```

## Self signed cert
```sh
openssl genrsa -out ca.key 4096
openssl req -new -x509 -sha256 -days 10950 -key ca.key -out ca.crt

# Basic Example:
# Country Name (2 letter code) [AU]:
# State or Province Name (full name) [Some-State]:
# Locality Name (eg, city) []:
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []:mydomain.com
# Email Address []:me@mydomain.com
```

## cluster-secret
```sh
export TLS_CRT="$(cat ca.crt | base64 -w 0)"
export TLS_KEY="$(cat ca.key | base64 -w 0)"
```
> Install `ca.crt` on Client as Trusted ROOT
## Cert manager
```sh
kubectl create namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.yaml
envsubst < cluster-secret.yaml | kubectl apply -n cert-manager -f -
kubectl apply -n cert-manager -f cluster-issuer.yaml
```

## Traefik
```sh
kubectl create namespace traefik
kubectl apply -n traefik -f traefik-cert.yaml
kubectl apply -n traefik -f traefik-mdw-redirecttohttps.yaml
kubectl apply -n traefik -f traefik-dashboard.yaml
```