minikube start --nodes 3

kubectl label nodes minikube disktype=ssd
kubectl label nodes minikube-m02 disktype=hdd
kubectl label nodes minikube-m03 disktype=ssd

kubectl taint nodes minikube-m03 disktype=ssd:NoSchedule
kubectl taint nodes minikube-m02 env=production:NoExecute
kubectl taint nodes minikube controlnode=true:NoExecute
