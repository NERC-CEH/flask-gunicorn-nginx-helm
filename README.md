# Flask, Gunicorn, Nginx, Helm

This is a work in progress but it should work

## Super quick hello world example

* Flask application which says `Hello, World!`
* Using Gunicorn to run the application and spin up a couple of workers
* Use nginx to add security to your application (want to change this to nginx-ingress)
* Use helm to create all these containers and have them scalable and robust

## Setup

You need docker, minikube, kubectl and helm installed

```sh
# turn everything on
minikube delete
minikube start
eval $(minikube docker-env)
helm init

# build your containers
docker build -t hello:v1 .
docker build -t hello-nginx:v1 . -f Dockerfile.nginx

# setup ssl
openssl req -x509 -nodes -newkey rsa:2048 -keyout tls.key -out tls.crt
kubectl create secret tls tls-certificate --key tls.key --cert tls.crt
openssl dhparam -out dhparam.pem 4096
kubectl create secret generic tls-dhparam --from-file=dhparam.pem

# install
helm install hello --name hello

# to get the url from the command line, playing with `kubectl cluster-info` and `kubectl get service`
echo "https://`echo $DOCKER_HOST | cut -d/ -f3 | cut -d: -f1`:30301"

# you can also look at the dashboard
minikube dashboard
```
