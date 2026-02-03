data "azurerm_resource_group" "rg" {
  name = var.rgname
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_subnet" "snet" {
  name                 = var.snetname
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.aksdnsprefix
  sku_tier            = var.aks_pricing_tier
  kubernetes_version  = var.aks_kubernetes_version
  node_resource_group = var.aks_node_rgname
  tags = var.default_tags
  default_node_pool {
    name                   = var.aks_nodepool_name
    node_count             = var.aks_node_count
    vm_size                = var.aks_nodepool_sku  #"Standard_D4as_v5"
    node_public_ip_enabled = false
    os_disk_size_gb        = 128
    os_sku                 = "Ubuntu"
    type                   = "VirtualMachineScaleSets"
    vnet_subnet_id         = data.azurerm_subnet.snet.id
    zones                  = var.availability_zones
    max_pods               = var.max_pods_per_node
  }

  network_profile {
    network_plugin      = "azure"
    network_policy      = "calico"
    network_plugin_mode = "overlay"
    outbound_type       = "loadBalancer"
    load_balancer_sku   = "standard"
    service_cidr = var.aks_service_cidr #"10.0.0.0/16" should not overlap with VNet
    dns_service_ip = var.aks_dns_service_ip #"10.0.0.10"
  }

  azure_policy_enabled = true

  azure_active_directory_role_based_access_control {
    tenant_id = var.tenant_id
    azure_rbac_enabled = true
  }

  local_account_disabled = true
  identity {
    type = "SystemAssigned"
  }
}
