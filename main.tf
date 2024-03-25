terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "joe-dev-devops-rg"
  #   storage_account_name = "devstorpubsub"
  #   container_name       = "terramaster"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# ==============================================================

data "azurerm_client_config" "current" {}

data "external" "my_ip_address" {
  program = ["Powershell.exe", "./Helper/GetIp.ps1"]
}

resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
  tags     = var.defaultTags
}

module "keyvaults" {
  source            = "./Modules/keyvaults"
  kvName            = var.kvName
  resourceGroupName = azurerm_resource_group.rg.name
  location          = var.location
  tenantId          = data.azurerm_client_config.current.tenant_id
  objectId          = data.azurerm_client_config.current.object_id
  defaultTags       = var.defaultTags
  ipRules           = data.external.my_ip_address.result.ip
  vnetSubnetIDs     = module.networking.subnet_id
}

module "storageaccount" {
  source                 = "./Modules/storageaccount"
  storageName            = var.storageName
  resourceGroupName      = azurerm_resource_group.rg.name
  location               = var.location
  accountTier            = var.accountTier
  defaultTags            = var.defaultTags
  accountReplicationType = var.accountReplicationType
  minTlsVersion          = var.minTlsVersion
  HttpsTrafficOnly       = var.HttpsTrafficOnly
  accountKind            = var.accountKind
  containerName          = var.containerName
  containerAccessType    = var.containerAccessType
  ipRules                = data.external.my_ip_address.result.ip
  vnetSubnetIDs          = module.networking.subnet_id
}

module "networking" {
  source            = "./Modules/networking"
  vnetName          = var.vnetName
  resourceGroupName = azurerm_resource_group.rg.name
  location          = var.location
  addressSpace      = var.addressSpace
  defaultTags       = var.defaultTags
  subnetName        = var.subnetName
  addressPrefixes   = var.addressPrefixes
  nsgName           = var.nsgName
}
