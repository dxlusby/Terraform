resource "azurerm_service_plan" "plan" {
  name                = "logicapp-plan-${random_string.randomSuffix.result}"
  resource_group_name = azurerm_resource_group.group.name
  location            = "East US"
  os_type             = "Windows"
  sku_name            = "WS1"

}

resource "azurerm_logic_app_standard" "logicapp" {
  depends_on = [
    azurerm_private_endpoint.blobEndpoint,
    azurerm_private_endpoint.fileEndpoint,
    azurerm_private_endpoint.queueEndpoint,
    azurerm_private_endpoint.tableEndpoint
  ]

  name                       = "logicapp-${random_string.randomSuffix.result}"
  location                   = "East US"
  resource_group_name        = azurerm_resource_group.group.name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  virtual_network_subnet_id  = azurerm_subnet.logicApp.id


  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
    "WEBSITE_CONTENTOVERVNET"      = "1"
  }

  site_config {
    vnet_route_all_enabled = true
  }
  
  storage_account_share_name = azurerm_storage_share.fileshare.name
}
