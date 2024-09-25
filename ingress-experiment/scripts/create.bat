kubectl create namespace k8s-ingress-tls-experiment
kubectl apply -f .\k8s\dep-A.yml -f .\k8s\svc-A.yml -f .\k8s\dep-B.yml -f .\k8s\svc-B.yml -f .\k8s\ingress.yml -n k8s-ingress-tls-experiment
