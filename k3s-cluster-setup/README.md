# k3s Cluster Setup

## Local Setup Using VirtualBox and Alpine Linux

### Requirements

 1. VirtualBox
 2. [Alpine ISO](https://alpinelinux.org/downloads/). Download the virtual ISO.

### Step 1: VM Creation

Based on [k3s requirements](https://docs.k3s.io/installation/requirements#hardware), the minimum recommended hardware is 2 CPU cores and 1 GB of RAM.

Also set the network settings to "Adapted to Bridge" to enable ssh from host terminal.

### Alpine Installation

 1. Do `setup-alpine` and follow the instructions.
 2. Reboot.
 3. Login and escalate to root.
 4. Install curl.
 5. Power off.
 6. Clone the VMs.

### k3s Setup

Before doing this, escalate to root.

#### Main Node

Install k3s.

```
curl -sfL https://get.k3s.io | sh -
```

After installation, get the node token.

```
cat /var/lib/rancher/k3s/server/node-token
```

Also get the ip address

```
ifconfig
```

#### Worker Node

Install k3s, but specify `K3S_URL=https://<main-node-ip>:6443`, `K3S_TOKEN=<node-token>`, and `K3S_NODE_NAME=<unique-node-name>`

```
curl -sfL https://get.k3s.io | K3S_URL=https://<main-node-ip>:6443 K3S_TOKEN=<main-node-token> K3S_NODE_NAME=<unique-node-name> sh -
```

### Checking Installation

ssh to main node and check all nodes.

```
k3s-node:~# k3s kubectl get nodes
NAME         STATUS   ROLES                  AGE   VERSION
k3s-node     Ready    control-plane,master   10m   v1.30.5+k3s1
k3s-node-2   Ready    <none>                 5s    v1.30.5+k3s1
```