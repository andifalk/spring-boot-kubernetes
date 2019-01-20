variable "region" {
  description = "Google Region"
  default = "europe-west3"
}

variable "zone" {
  description = "Google Zone"
  default = "europe-west3-a"
}

variable "initial_nodes" {
  description = "Number of nodes"
  default = "2"
}

variable "gke_version" {
  description = "GKE version"
  default = "1.11.3-gke.18"
}

variable "cluster_name" {
  description = "Name of cluster"
  default = "test-cluster"
}

variable "machine_type" {
  description = "Machine type"
  default = "n1-standard-1"  # "n1-standard-1", "n1-standard-2"
}

variable "user_name" {
  description = "User for master auth"
  default = "admin"
}

variable "user_password" {
  description = "Password for master auth"
  type = "string"
}



