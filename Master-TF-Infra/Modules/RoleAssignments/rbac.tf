data azurerm_resource_group rg {
  name = var.rgname
}
data "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = data.azurerm_resource_group.rg.name
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
resource "azurerm_role_assignment" "aks_rbac" {
  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
resource "azurerm_role_assignment" "aks_acrpull" {
  principal_id                     = data.azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}