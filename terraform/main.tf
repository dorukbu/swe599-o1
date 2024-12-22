provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# VPC Network
resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.name
}

# Service Account
resource "google_service_account" "default" {
  account_id   = "sa-swe599"
  display_name = "Custom Service Account"
}

# # GKE Cluster
# resource "google_container_cluster" "gke_cluster" {
#   name     = var.gke_cluster_name
#   location = var.zone

#   network    = google_compute_network.vpc.id
#   subnetwork = google_compute_subnetwork.subnet.id

#   remove_default_node_pool = true
#   initial_node_count       = 1

#   deletion_protection = false
# }

# # GKE Node Pool
# resource "google_container_node_pool" "gke_node_pool" {
#   name       = var.gke_node_pool_name
#   cluster    = google_container_cluster.gke_cluster.name
#   location   = var.zone
#   node_count = var.node_count

#   node_config {
#     machine_type = var.node_vm_size
#     disk_size_gb = 20

#     preemptible = true

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = google_service_account.default.email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform",
#     ]

#     metadata = {
#       "ssh-keys" = "gcpadmin:${file("../ssh_keys/id_rsa.pub")}"
#     }

#     # Accelerators (GPUs)
#     # guest_accelerator {
#     #   type  = var.gpu_type
#     #   count = var.gpu_count

#     #   # GPU driver installation config -> Do not install if using Nvida GPU Operator
#     #   gpu_driver_installation_config {
#     #     gpu_driver_version = "LATEST"
#     #   }
#     # }
#   }
# }

# Existing Static IP Address
data "google_compute_address" "existing_static_ip" {
  name   = "public-ip-swe599-0"
  region = "us-central1" # Replace with the region where the IP is reserved
}

# VM Instance
resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.vm_size
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    access_config {
      nat_ip       = data.google_compute_address.existing_static_ip.address
      network_tier = "STANDARD" # Match the static IP tie
    }
  }

  metadata = {
    ssh-keys = "gcpadmin:${file("../ssh_keys/id_rsa.pub")}"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

# Firewall Rules
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow SSH from any IP
}

resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow HTTP/HTTPS from any IP
}
