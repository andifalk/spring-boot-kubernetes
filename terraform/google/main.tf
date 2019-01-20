provider "google" {
  credentials = "${file("account.json")}"
  project     = "afa-kubernetes"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

resource "google_container_cluster" "primary" {
  name               = "${var.cluster_name}"
  zone               = "${var.zone}"
  initial_node_count = "${var.initial_nodes}"
  min_master_version = "${var.gke_version}"
  node_version = "${var.gke_version}"

  master_auth {
    username = "${var.user_name}"
    password = "${var.user_password}"
  }

  node_config {
    machine_type = "${var.machine_type}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]

    labels {
      terraform = "true"
    }

    tags = ["terraform", "true"]
  }

}


