# Kubernetes Ingress Experiment

Requirements:
 1. Docker
 2. Kubernetes Cluster
 3. `kubectl`

## Setup using [Minikube](https://minikube.sigs.k8s.io/docs/)

 1. Install and start Minikube
 2. Build `podinfo` image and load it to `minikube` (see [./scripts/build.bat](./scripts/build.bat)).
 3. Create namespace & objects using yaml files in [k8s](./k8s/) (see [./scripts/build.bat](./scripts/create.bat)).