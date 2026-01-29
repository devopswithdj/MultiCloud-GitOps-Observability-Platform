data azurerm_resource_group rg {
  name = var.rgname
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnetaddress #["192.168.0.0/16"]
  tags = var.default_tags
}

resource "azurerm_subnet" "snet" {
  name                 = var.snetname
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snetaddress #["192.168.0.0/24"]
}