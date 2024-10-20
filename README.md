# Terraform Commands

`terraform init -upgrade`

`terraform plan -out main.tfplan`

`terraform apply main.tfplan`

### After Creation:

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

`kubectl delete -f ./manifests/aks-store-quickstart.yaml` → Just in case

`terraform plan -destroy -out main.destroy.tfplan`

`terraform apply main.destroy.tfplan`