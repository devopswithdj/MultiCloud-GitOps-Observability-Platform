data azurerm_resource_group rg {
  name = var.rgname
}
data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "snet" {
  name                 = var.snetname
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}
resource azurem_role_assignment "aks" {
  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azurerm_kubernetes_cluster.aks.identity[0].principal_id
}