provider "azurerm" {
  features {}

  subscription_id = "d05a370d-b349-4308-ab9d-55806e06a489"
  tenant_id       = "afae30e9-40d9-49dc-885e-ec7372387820"
}

provider "azapi" {
  subscription_id = "d05a370d-b349-4308-ab9d-55806e06a489"
  tenant_id       = "afae30e9-40d9-49dc-885e-ec7372387820"
}