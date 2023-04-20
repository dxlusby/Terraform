terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

resource "azurerm_resource_group" "group" {
  name     = "logic-app-private"
  location = "East US"
}

resource "random_string" "randomSuffix" {
  length  = 5
  special = false
  upper   = false
}