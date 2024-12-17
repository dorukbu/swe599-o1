output "vm_public_ip_address" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "project_id" {
  value = var.project_id
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "client_certificate" {
  value     = google_container_cluster.gke_cluster.master_auth[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.gke_cluster.master_auth[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
  sensitive = true
}

# output "cluster_password" {
#   value     = google_container_cluster.gke_cluster.master_auth[0].password
#   sensitive = true
# }

# output "cluster_username" {
#   value     = google_container_cluster.gke_cluster.master_auth[0].username
#   sensitive = true
# }

output "host" {
  value     = google_container_cluster.gke_cluster.endpoint
  sensitive = true
}

# output "kube_config" {
#   value     = google_container_cluster.gke_cluster.kube_config_raw
#   sensitive = true
# }
