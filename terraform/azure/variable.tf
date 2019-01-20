variable "target_resource_group_name" {
  type = "string"
  description = "Name of azure resource group"
}

variable "target_key_vault_name" {
  type = "string"
  description = "Name of azure key vault"
}

variable "target_aks_name" {
  description = "Name of azure kubernetes cluster"
  type = "string"
}



