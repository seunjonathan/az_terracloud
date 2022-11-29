terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.4.1"
    }
  }
}

provider "azurerm" {
  features {}

 }

resource "azurerm_resource_group" "example" {
  name     = "myterrasucceed"
  location = "East US"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageaccseun"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}


resource "azurerm_storage_data_lake_gen2_filesystem" "gen1" {
  name               = "gen1"
  storage_account_id = azurerm_storage_account.example.id
  
  }

 
  resource "azurerm_data_factory" "seunadf" {
  name                = "seunadf"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_data_factory_pipeline" "exampleadfp" {
  name            = "exampleadfp"
  data_factory_id = azurerm_data_factory.seunadf.id
}

#Creating Synapse things dependent on ADLS above

resource "azurerm_synapse_workspace" "seunwksp" {
  name                                 = "seunwksp"
  resource_group_name                  = azurerm_resource_group.example.name
  location                             = azurerm_resource_group.example.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.gen1.id
  sql_administrator_login              = "seunjonathan"
  sql_administrator_login_password     = "Gre@tness123"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_synapse_sql_pool" "seunsqlpool" {
  name                 = "seunsqlpool"
  synapse_workspace_id = azurerm_synapse_workspace.seunwksp.id
  sku_name             = "DW100c"
  create_mode          = "Default"
}