provider "azurerm" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.target_resource_group_name}"
  location = "westeurope"
  tags = {
      terraform = "true"
  }
}

module "kv" {
  source = "./kv"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  resource_group_location = "${azurerm_resource_group.rg.location}"   
  key_vault_name = "${var.target_key_vault_name}"
}

module "aks" {
  source = "./aks"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  resource_group_location = "${azurerm_resource_group.rg.location}"   
  aks_name = "${var.target_aks_name}"
}

