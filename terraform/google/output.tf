# The following outputs allow authentication and connectivity to the GKE Cluster.

output "cluster_endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}

output "cluster_version" {
  value = "${google_container_cluster.primary.master_version}"
}

output "instance_urls" {
  value = "${google_container_cluster.primary.instance_group_urls}"
}

output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}