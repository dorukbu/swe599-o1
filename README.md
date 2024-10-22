### TODO
- [x] Create Resource group and public IP (static) via Azure portal
- [x] Add Terraform directory to do the following:
  - Create a virtual machine (VM):
    - in a public subnet (will be shared with the k8s cluster).
    - w/ public ssh key found under ./swe599-o1/ssh_keys/ (Prequisite)
    - w/ the preexisting public IP assigned
  - Set up a Kubernetes cluster within the same subnet as the VM
  - Other required & compementary components (e.g. Virtual Network, Service Principal role assignments, Network Security Group)
  - Output important information to be utilized in further steps (kubeconfig, public ip etc.)
- [x] Create a Type A DNS record for the public IP assigned to the vm
- [x] Add k8s directory to do the following:
  - Deploy a sample app from AKS tutorial
  - Deploy Kubernetes cloud load balancer (internal lb) with custom internal IP (within the subnet CIDR block)
- [ ] Add system architecture diagram to README
- [ ] Add Ansible directory to take care of provisioning the following tools:
  - Nginx for TLS termination and as a reverse proxy (proxy to UI)
  - net-tools, 
  - Deploy a simple UI to interact with the kuberntes load balancer
  - Grafana to monitor Kubernetes
  - JMeter to conduct tests
- [ ] Write kubernetes manifests:
  - Deploy LLM model w/ Prometheus sidecar to send logs & metrics to Grafana on VM
  - Prometheus node exporter
  - Internal load balancer (with private ip 10.0.1.111)
  - Prometheus sidecar 
- [ ] Create a Bash entrypoint script to:
  - generate the SSH key pair in the directory ./swe599-o1/ssh_keys/
  - automate the processes of resource creation, provisioning, deployment, destruction
  - KUBECONFIG setup

#### Current DNS address for the virtual machine (VM)*
[swe599.o1.dorukbu.com](swe599.o1.dorukbu.com)
##### *DISCLAIMER: The system is shut down when it is not in operation to reduce cloud costs.

# How to Guide

## 0. Prerequisites

- **Azure Resource Group**: Ensure that a Resource Group is created in an available Azure region. The name of this Resource Group should match the value of `var.resource_group_name_var` (e.g., `rg-swe599-objective-1`).

- **Public IP**: A Public IP address must be provisioned in the same region. Its name should match the value of `var.public_ip_name` (e.g., `public-ip-swe599-objective-1`).

- **RSA SSH Key Pair**: An RSA SSH key pair is required and must be placed under `./swe599-o1/ssh_keys/`.

## 1. Terraform Commands

`terraform init -upgrade`

`terraform plan -out main.tfplan`

`terraform apply main.tfplan`

## After Creation:

`resource_group_name=$(terraform output -raw resource_group_name)`

`az aks list --resource-group $resource_group_name --query "[].{\"K8s cluster name\":name}" --output table`

`echo "$(terraform output kube_config)" > ../k8s/azurek8s`

`cd ../k8s`

`cat ./azurek8s` → delete lines w/ EOF if exists

`export KUBECONFIG=./azurek8s`

`kubectl get nodes`

`kubectl apply -f ./manifests/aks-store-quickstart.yaml`

`kubectl get pods`

`kubectl get service store-front --watch` -> The service should be able to get external IP defined in LB service annotation

### To Destroy everything

`kubectl delete -f ./manifests/aks-store-quickstart.yaml` -> Just in case

`terraform plan -destroy -out main.destroy.tfplan`

`terraform apply main.destroy.tfplan`