variable "resource_group_name" {}
variable "resource_group_location" {}
variable "key_vault_name" {}

resource "azurerm_key_vault" "kv" {
  name                        = "${var.key_vault_name}"
  location                    = "${var.resource_group_location}"
  resource_group_name         = "${var.resource_group_name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "837768d2-29f8-4c82-bd9c-ba95052b2c7f"

  sku {
    name = "standard"
  }

  access_policy {
    tenant_id = "837768d2-29f8-4c82-bd9c-ba95052b2c7f"
    object_id = "dfc55c9a-be64-461f-93bb-aa3379368007"

    key_permissions = [
      "get",
      "backup", 
      "create", 
      "decrypt", 
      "delete", 
      "encrypt", 
      "import", 
      "list", 
      "purge", 
      "recover", 
      "restore", 
      "sign", 
      "unwrapKey", 
      "update", 
      "verify",
      "wrapKey"
    ]

    secret_permissions = [
      "get",
      "backup", 
      "delete", 
      "list",
      "recover", 
      "restore",
      "set"
    ]

    certificate_permissions = [
      "create", 
      "delete", 
      "deleteissuers", 
      "get", 
      "getissuers", 
      "import", 
      "list", 
      "listissuers", 
      "managecontacts", 
      "manageissuers", 
      "recover", 
      "setissuers",
      "update"
    ]
  }

  tags {
    environment = "Testing"
  }
}

output "kv_id" {
  value = "${azurerm_key_vault.kv.id}"
}

output "kv_uri" {
  value = "${azurerm_key_vault.kv.vault_uri}"
}



