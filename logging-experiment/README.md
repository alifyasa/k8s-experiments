# Kubernetes Scheduling Experiment

2 Deployments, 3 Nodes, 3 Taints.

## Deployments

### `podinfo-type-1`

This deployment has a toleration for `disktype=ssd:NoSchedule` and `controlnode=true:NoExecution`, a node selector of `disktype=ssd`, and a pod affinity of `preferredDuringSchedulingIgnoredDuringExecution` to its kind.

### `podinfo-type-2`

This deployment has a toleration for `disktype=ssd:NoSchedule` and `env=production:NoExecution`, and a pod anti-affinity of `preferredDuringSchedulingIgnoredDuringExecution` to its kind.

## Nodes

### minikube

This node have the `disktype=ssd` label and `controlnode=true:NoExecute` taint.

### minikube-m02

This node have the `disktype=hdd` label and `env=production:NoExecute` taint.

### minikube-m03

This node have the `disktype=ssd` label and `disktype=ssd:NoSchedule` taint.