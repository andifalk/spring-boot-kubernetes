
variable "resource_group_name" {}
variable "resource_group_location" {}

variable "aks_name" {}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "acctestLAW1"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "las" {
  solution_name         = "ContainerInsights"
  location              = "${var.resource_group_location}"
  resource_group_name   = "${var.resource_group_name}"
  workspace_resource_id = "${azurerm_log_analytics_workspace.law.id}"
  workspace_name        = "${azurerm_log_analytics_workspace.law.name}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.aks_name}"
  location              = "${var.resource_group_location}"
  resource_group_name   = "${var.resource_group_name}"
  dns_prefix          = "acctestagent1"

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "00000000-0000-0000-0000-000000000000"
    client_secret = "00000000000000000000000000000000"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = "${azurerm_log_analytics_workspace.law.id}"
    }
  }

  tags {
    Environment = "Testing"
  }
}

output "id" {
    value = "${azurerm_kubernetes_cluster.aks.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
}


