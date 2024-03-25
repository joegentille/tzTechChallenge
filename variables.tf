variable "resourceGroupName" {}

variable "location" {}

variable "defaultTags" {
  default = {
    Owner = "Joe"
  }
}

variable "kvName" {}

variable "storageName" {}

variable "accountTier" {}

variable "accountReplicationType" {}

variable "minTlsVersion" {}

variable "HttpsTrafficOnly" {}

variable "accountKind" {}

variable "containerName" {}

variable "containerAccessType" {}

variable "addressSpace" {
  default = ["10.0.0.0/16"]
}

variable "vnetName" {}

variable "subnetName" {}

variable "addressPrefixes" {
  default = ["10.0.1.0/24"]
}

variable "nsgName" {}
