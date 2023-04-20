
resource "azurerm_storage_account" "storage" {
  name                          = "logicappstorage${random_string.randomSuffix.result}"
  resource_group_name           = azurerm_resource_group.group.name
  location                      = "East US"
  account_replication_type      = "LRS"
  account_tier                  = "Standard"
  public_network_access_enabled = false
}

resource "azurerm_storage_share" "fileshare" {
    name = "logicapp"
    storage_account_name = azurerm_storage_account.storage.name
    quota = "5120"
}

resource "azurerm_private_endpoint" "blobEndpoint" {
  name                = "${azurerm_storage_account.storage.name}-blob-endpoint"
  resource_group_name = azurerm_resource_group.group.name
  location            = "East US"
  subnet_id           = azurerm_subnet.privateEndpoints.id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.blobZone.id
    ]
  }

  private_service_connection {
    name                           = "blob-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names = [
      "blob"
    ]
  }
}

resource "azurerm_private_endpoint" "fileEndpoint" {
  name                = "${azurerm_storage_account.storage.name}-file-endpoint"
  resource_group_name = azurerm_resource_group.group.name
  location            = "East US"
  subnet_id           = azurerm_subnet.privateEndpoints.id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.fileZone.id
    ]
  }

  private_service_connection {
    name                           = "file-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names = [
      "file"
    ]
  }
}

resource "azurerm_private_endpoint" "tableEndpoint" {
  name                = "${azurerm_storage_account.storage.name}-table-endpoint"
  resource_group_name = azurerm_resource_group.group.name
  location            = "East US"
  subnet_id           = azurerm_subnet.privateEndpoints.id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.tableZone.id
    ]
  }

  private_service_connection {
    name                           = "table-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names = [
      "table"
    ]
  }
}

resource "azurerm_private_endpoint" "queueEndpoint" {
  name                = "${azurerm_storage_account.storage.name}-queue-endpoint"
  resource_group_name = azurerm_resource_group.group.name
  location            = "East US"
  subnet_id           = azurerm_subnet.privateEndpoints.id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.queueZone.id
    ]
  }

  private_service_connection {
    name                           = "queue-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names = [
      "queue"
    ]
  }
}
