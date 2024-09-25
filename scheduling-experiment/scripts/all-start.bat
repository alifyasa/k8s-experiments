@echo off
call ./scripts/minikube-start.bat
call ./scripts/podinfo-create.bat
call ./scripts/k8s-namespace-create.bat
call ./scripts/k8s-objects-create.bat