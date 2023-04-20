resource "azurerm_virtual_network" "network" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.group.name
  location            = "East US"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "privateEndpoints" {
  name                 = "privateEndpoints"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes = [
    "10.0.0.0/24"
  ]
}

resource "azurerm_subnet" "logicApp" {
  name                 = "logicApp"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes = [
    "10.0.1.0/24"
  ]

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "blobZone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_private_dns_zone" "fileZone" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_private_dns_zone" "tableZone" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_private_dns_zone" "queueZone" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blobZoneLink" {
  name                  = azurerm_virtual_network.network.name
  private_dns_zone_name = azurerm_private_dns_zone.blobZone.name
  resource_group_name   = azurerm_resource_group.group.name
  virtual_network_id    = azurerm_virtual_network.network.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "fileZoneLink" {
  name                  = azurerm_virtual_network.network.name
  private_dns_zone_name = azurerm_private_dns_zone.fileZone.name
  resource_group_name   = azurerm_resource_group.group.name
  virtual_network_id    = azurerm_virtual_network.network.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "tableZoneLink" {
  name                  = azurerm_virtual_network.network.name
  private_dns_zone_name = azurerm_private_dns_zone.tableZone.name
  resource_group_name   = azurerm_resource_group.group.name
  virtual_network_id    = azurerm_virtual_network.network.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "queueZoneLink" {
  name                  = azurerm_virtual_network.network.name
  private_dns_zone_name = azurerm_private_dns_zone.queueZone.name
  resource_group_name   = azurerm_resource_group.group.name
  virtual_network_id    = azurerm_virtual_network.network.id
}
