data "azurerm_resource_group" "rg" {
  name = var.rgname
}

resource "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = var.acrsku
  admin_enabled       = var.adminenabled
}
