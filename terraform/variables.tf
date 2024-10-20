#### resource group variables ####
variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_var" {
  type        = string
  default     = "rg-swe599-objective-1"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

#### Network variables ####
variable "vnet_name" {
  type        = string
  default     = "vnet-swe599-objective-1"
  description = "The name of the Virtual Network."
}

variable "vnet_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The address space that is used the Virtual Network."
}

variable "subnet_name" {
  type        = string
  default     = "subnet-swe599-objective-1"
  description = "The name of the Subnet."
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The address space that is used the Subnet."
}

variable "public_ip_name" {
  type        = string
  default     = "public-ip-swe599-objective-1"
  description = "The name of the Public IP."
}

#### K8s and node pool variables ####
variable "azurerm_kubernetes_cluster_name" {
  type        = string
  default     = "cluster-swe599-objective-1"
  description = "The name of the Kubernetes cluster."
}

variable "azurerm_kubernetes_cluster_dns_prefix" {
  type        = string
  default     = "dns-swe599-objective-1"
  description = "The DNS prefix to use with the Kubernetes cluster."
}

variable "node_vm_size" {
  type        = string
  description = "The size of the Virtual Machine."
  default     = "standard_d2ps_v5"
}

variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key."
  default     = "ssh-key-swe599-objective-1"

}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

#### VM variables ####
variable "vm_name" {
  type        = string
  default     = "vm-swe599-objective-1"
  description = "The name of the Virtual Machine."
}

variable "vm_size" {
  type        = string
  default     = "standard_d2ps_v5"
  description = "The size of the Virtual Machine."
}