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

resource "azurerm_storage_account" "example1" {
  name                     = "examplestorageaccseun2"
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

  resource "azurerm_storage_data_lake_gen2_filesystem" "gennew" {
  name               = "gennew"
  storage_account_id = azurerm_storage_account.example1.id
  
  }

  resource "azurerm_data_factory" "exampleadf" {
  name                = "exampleadf"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_data_factory_pipeline" "exampleadfp" {
  name            = "exampleadfp"
  data_factory_id = azurerm_data_factory.exampleadf.id
}