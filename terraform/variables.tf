variable "project_id" {
  description = "GCP project ID."
  type        = string
  default     = "project-swe599"
}

variable "region" {
  description = "GCP region."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone."
  type        = string
  default     = "us-central1-a"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "vpc-swe599"
}

variable "subnet_name" {
  description = "The name of the Subnet."
  type        = string
  default     = "subnet-swe599"
}

variable "subnet_cidr" {
  description = "The address space that is used for the Subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "gke-cluster-swe599"
}

variable "gke_cpu_node_pool_name" {
  description = "The name of the GKE cpu node pool."
  type        = string
  default     = "gke-cpu-node-pool-swe599"
}

variable "gke_tpu_node_pool_name" {
  description = "The name of the GKE tpu node pool."
  type        = string
  default     = "gke-tpu-node-pool-swe599"
}

# variable "tpu_type" {
#   description = "The type of the TPU."
#   type        = string
#   default     = "ct5lp"
# }

# variable "tpu_count" {
#   description = "The number of TPUs."
#   type        = number
#   default     = 1
# }

variable "node_vm_size" {
  description = "The size of the nodes in the GKE cluster."
  type        = string
  default     = "n2-highmem-8"
}

variable "node_count" {
  description = "The number of nodes in the GKE cluster."
  type        = number
  default     = 1
}

variable "node_disk_size_gb" {
  description = "The size of the disk in the nodes of the GKE cluster."
  type        = number
  default     = 80
}

# Some GPU types might not be available in all regions. "Error: NodePool was created in the error state" gcloud compute accelerator-types list --zones=us-central1-a

variable "gpu_type" {
  description = "The type of the GPU."
  type        = string
  default     = "nvidia-tesla-t4"
}

variable "gpu_count" {
  description = "The number of GPUs."
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "The name of the Compute Engine instance."
  type        = string
  default     = "vm-swe599"
}

variable "vm_size" {
  description = "The size of the Compute Engine instance."
  type        = string
  default     = "e2-medium"
}
