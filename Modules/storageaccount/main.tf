
resource "azurerm_storage_account" "storage_account" {
  name                      = var.storageName
  resource_group_name       = var.resourceGroupName
  location                  = var.location
  account_tier              = var.accountTier
  account_replication_type  = var.accountReplicationType
  min_tls_version           = var.minTlsVersion
  enable_https_traffic_only = var.HttpsTrafficOnly
  account_kind              = var.accountKind
  tags                      = var.defaultTags
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.containerName
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.containerAccessType
}

resource "azurerm_storage_account_network_rules" "storage_network_rule" {
  storage_account_id         = azurerm_storage_account.storage_account.id
  default_action             = "Deny"
  bypass                     = ["Metrics"]
  ip_rules                   = [var.ipRules]
  virtual_network_subnet_ids = [var.vnetSubnetIDs]
}