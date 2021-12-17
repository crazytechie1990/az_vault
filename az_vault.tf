data "azurerm_client_config" "current" {}

# Azure Key Vault for storing secrets
resource "azurerm_key_vault" "vault" {
  name                       = var.vault_name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  enabled_for_deployment     = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "get",
      "set",
      "delete",
      "list",
      "backup",
      "restore",
      "recover",
      "purge"
    ]
  }
  tags = var.default_tags
}


