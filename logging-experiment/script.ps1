param (
    [string]$Action,
    [string]$Target = "all",
    [string]$NamespaceName = "k8s-logging-experiment"
)

switch ($Action) {
    "start" {
        if ($Target -eq "all" -or $Target -eq "minikube") {
            minikube.exe start --image-repository=auto `
                --nodes=3 `
                --cni=calico `
                --driver=docker `
                --preload=true
        }
        if ($Target -eq "all" -or $Target -eq "podinfo") {
            docker.exe build -t podinfo:latest .\podinfo\
            minikube.exe image load podinfo:latest --daemon
        }
        if ($Target -eq "all" -or $Target -eq "k8s") {
            kubectl.exe create namespace $NamespaceName
            kubectl.exe apply -n $NamespaceName `
                -f .\k8s\dep-type-1.yml `
                -f .\k8s\dep-type-2.yml `
                -f .\k8s\svc-type-1.yml `
                -f .\k8s\svc-type-2.yml `
                -f .\k8s\ds-nginx.yml
        }
        if ($Target -notin @("all", "minikube", "podinfo", "k8s")) {
            Write-Host "Wrong Argument"
        }
    }
    "stop" {
        if ($Target -eq "all" -or $Target -eq "k8s") {
            kubectl.exe delete all --all -n $NamespaceName
            kubectl.exe delete namespace $NamespaceName
        }
        if ($Target -eq "all" -or $Target -eq "podinfo") {
            docker.exe rmi podinfo:latest
        }
        if ($Target -eq "all" -or $Target -eq "minikube") {
            minikube.exe stop --all
        }
        if ($Target -notin @("all", "minikube", "podinfo", "k8s")) {
            Write-Host "Wrong Argument"
        }
    }
    "delete" {
        minikube.exe delete
    }
    default {
        Write-Host "Unknown action: $Action. Valid actions are 'start', 'stop', or 'delete'."
    }
}
