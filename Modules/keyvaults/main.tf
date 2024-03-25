resource "azurerm_key_vault" "infra_kv" {
  name                        = var.kvName
  location                    = var.location
  resource_group_name         = var.resourceGroupName
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenantId
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenantId
    object_id = var.objectId

    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set"
    ]

    certificate_permissions = [
      "Get",
      "List"
    ]
  }

  tags = var.defaultTags

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = [var.ipRules]
    virtual_network_subnet_ids = [var.vnetSubnetIDs]
  }
}
