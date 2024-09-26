minikube start --image-repository=auto ^
    --nodes=3 ^
    --cni=calico ^
    --driver=docker ^
    --preload=true ^
    --network=minikube

kubectl label nodes minikube disktype=ssd
kubectl label nodes minikube-m02 disktype=hdd
kubectl label nodes minikube-m03 disktype=ssd

kubectl taint nodes minikube-m03 disktype=ssd:NoSchedule
kubectl taint nodes minikube-m02 env=production:NoExecute
@REM kubectl taint nodes minikube controlnode=true:NoExecute
