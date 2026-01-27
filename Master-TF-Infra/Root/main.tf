# Configure the Azure provider
resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg-01"
  location = "Central US"
}

resource "azurerm_virtual_network" "vnet" {
  depends_on = [ azurerm_resource_group.rg ]
  name                = "tf-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

resource "azurerm_subnet" "snet" {
  depends_on = [ azurerm_virtual_network.vnet ]
  name                 = "tf-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.0.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  depends_on = [ azurerm_resource_group.rg, azurerm_subnet.snet ]
  name                = "tf-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "tfaksdns"
  sku_tier            = "Free"
  kubernetes_version  = "1.33.5"
  node_resource_group = "tf-aks-node-rg"

  default_node_pool {
    name                   = "tfpool"
    node_count             = 1
    vm_size                = "Standard_D4as_v5"
    node_public_ip_enabled = false
    os_disk_size_gb        = 128
    os_sku                 = "Ubuntu"
    type                   = "VirtualMachineScaleSets"
    vnet_subnet_id         = azurerm_subnet.snet.id
    zones                  = [1,2,3]
    max_pods               = 250
  }

  network_profile {
    network_plugin      = "azure"
    network_policy      = "calico"
    network_plugin_mode = "overlay"
    outbound_type       = "loadBalancer"
    load_balancer_sku   = "standard"
    service_cidr = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
  }

  azure_policy_enabled = true

  azure_active_directory_role_based_access_control {
    tenant_id          = "7facfc55-87e0-4390-a951-abdbb862b7fb"
    azure_rbac_enabled = true
  }

  local_account_disabled = true
  identity {
    type = "SystemAssigned"
  }
}

