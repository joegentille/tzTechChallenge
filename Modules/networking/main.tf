resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnetName
  resource_group_name = var.resourceGroupName
  location            = var.location
  address_space       = var.addressSpace
  tags                = var.defaultTags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnetName
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.addressPrefixes
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}

# ==============================================================

resource "azurerm_subnet_network_security_group_association" "joeassociation" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

# ==============================================================

resource "azurerm_network_security_group" "network_security_group" {
  name                = var.nsgName
  location            = var.location
  resource_group_name = var.resourceGroupName
  tags                = var.defaultTags
}

resource "azurerm_network_security_rule" "outbound_security_rule" {
  name                        = "DenyTCP"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourceGroupName
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "inbound_security_rule" {
  name                        = "allowTCP"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resourceGroupName
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}