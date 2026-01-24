# Configure the Azure provider
resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg-01"
  location = "Central US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tf-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet" {
  name                 = "tf-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "tf-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "tfaksdns"
  sku_tier = "Standard"
  kubernetes_version = "1.33.7"
  node_resource_group = "tf-aks-node-rg"

  default_node_pool {
    name       = "tfpool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    node_public_ip_enabled = false
    os_disk_size_gb = 128
    os_sku = "Ubuntu"
    type = "VirtualMachineScaleSets"
    vnet_subnet_id = azurerm_subnet.snet.id
    zones = ["1", "2", "3"]
    max_pods = "250"
  }

  network_profile {
    network_plugin = "azure"
    network_plugin_mode = "overlay"
    network_policy = "calico"
    outbound_type = "loadBalancer"
    load_balancer_sku = "standard"
  }

  azure_policy_enabled = true

  azure_active_directory_role_based_access_control {
    tenant_id = "7facfc55-87e0-4390-a951-abdbb862b7fb"
    azure_rbac_enabled = true
  }
  identity {
    type = "SystemAssigned"
  }
}

