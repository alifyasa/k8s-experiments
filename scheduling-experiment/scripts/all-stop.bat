@echo off
call ./scripts/k8s-objects-delete.bat
call ./scripts/k8s-namespace-delete.bat
call ./scripts/podinfo-delete.bat
call ./scripts/minikube-stop.bat