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
  name                     = "examplestorageacc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  name               = "gen1"
  storage_account_id = azurerm_storage_account.example.id
  
  }

  resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  name               = "gen2"
  storage_account_id = azurerm_storage_account.example.id
  
  }