resourceGroupName="joe-dev-devops-rg"
location="eastus2"

# Key Vault
kvName="joe-dev-infra-kv"

# Storage account
storageName="devstorpubsub"
accountTier="Standard"
accountReplicationType="LRS"
minTlsVersion="TLS1_2"
HttpsTrafficOnly=true
accountKind="StorageV2"
containerName="terramaster"
containerAccessType="container"

# Networking
vnetName="kratos-dev-vnet"
subnetName="kratos-subnet-1"
nsgName="kratos-dev-nsg"