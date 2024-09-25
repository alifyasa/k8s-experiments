docker rmi podinfo:latest
docker build -t podinfo:latest .\podinfo\
minikube image load podinfo:latest --daemon