# Example

This creates a flask container and an nginx contianer which redirects https in a secure way

```sh
minikube delete
minikube start
eval $(minikube docker-env)
helm init

docker build -t hello:v1 .
docker build -t hello-nginx:v1 . -f Dockerfile.nginx

kubectl create secret tls tls-certificate --key tls.key --cert tls.crt
openssl dhparam -out dhparam.pem 4096
kubectl create secret generic tls-dhparam --from-file=dhparam.pem
```