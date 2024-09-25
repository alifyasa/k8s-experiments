kubectl apply ^
    -n k8s-scheduling-experiment ^
    -f .\k8s\dep-type-1.yml ^
    -f .\k8s\dep-type-2.yml ^
    -f .\k8s\svc-type-1.yml ^
    -f .\k8s\svc-type-2.yml
