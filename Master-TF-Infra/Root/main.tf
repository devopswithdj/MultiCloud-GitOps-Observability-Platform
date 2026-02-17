# Module for Resource Group
module "ResourceGroup" {
  source   = "..//Modules/ResourceGroup"
  rgname   = "${var.ProjectName}-${var.Loc}-${var.Environment}-rg"
  location = var.Location
  default_tags     = var.default_tags
}

# Module for Network
module "Network" {
  source      = "..//Modules/Network"
  depends_on = [ module.ResourceGroup ]
  rgname      = "${var.ProjectName}-${var.Loc}-${var.Environment}-rg"
  vnetname    = "${var.ProjectName}-${var.Loc}-${var.Environment}-vnet"
  snetname    = "${var.ProjectName}-${var.Loc}-${var.Environment}-snet"
  vnetaddress = var.vnet_address_space
  snetaddress = var.snet_address_space
  default_tags = var.default_tags
}

module "ACR" {
  source      = "..//Modules/ACR"
  depends_on = [ module.ResourceGroup ]
  rgname                 = "${var.ProjectName}-${var.Loc}-${var.Environment}-rg"
  acrname                = "${var.ProjectName}${var.Loc}${var.Environment}acr"  # ACR name must be globally unique
  acrsku                 = var.acr_sku
  adminenabled           = var.acr_admin_enabled
  default_tags           = var.default_tags
}

module "AKS" {
  source      = "..//Modules/AKS"
  depends_on = [ module.Network ]
  rgname                 = "${var.ProjectName}-${var.Loc}-${var.Environment}-rg"
  vnetname               = "${var.ProjectName}-${var.Loc}-${var.Environment}-vnet"
  snetname               = "${var.ProjectName}-${var.Loc}-${var.Environment}-snet"
  aksname                = "${var.ProjectName}-${var.Loc}-${var.Environment}-aks"
  aksdnsprefix           = "${var.ProjectName}-${var.Loc}-${var.Environment}-aks-dns"
  aks_pricing_tier       = var.aks_pricing_tier
  aks_kubernetes_version = var.aks_kubernetes_version
  aks_node_rgname        = "${var.ProjectName}-${var.Loc}-${var.Environment}-aks-node-rg"
  aks_nodepool_name      = "${substr(var.ProjectName, 0, 3)}${var.Environment}aks"  # Functions in terraform substr
  aks_node_count         = var.aks_node_count
  aks_nodepool_sku       = var.aks_nodepool_sku
  availability_zones    = var.availability_zones
  max_pods_per_node     = var.max_pods_per_node
  aks_service_cidr      = var.aks_service_cidr
  aks_dns_service_ip    = var.aks_dns_service_ip
  tenant_id = var.azure_tenant_id
  default_tags          = var.default_tags
}

module "RoleAssignments" {
  source      = "..//Modules/RoleAssignments"
  depends_on = [ module.AKS, module.Network ]
  rgname   = "${var.ProjectName}-${var.Loc}-${var.Environment}-rg"
  vnetname = "${var.ProjectName}-${var.Loc}-${var.Environment}-vnet"
  snetname = "${var.ProjectName}-${var.Loc}-${var.Environment}-snet"
  aksname  = "${var.ProjectName}-${var.Loc}-${var.Environment}-aks"
}

# Output the AKS cluster info
output "aks_info" {
  description = "Name of the AKS cluster"
  value       = module.AKS.cluster_name
  sensitive   = false
}