variable rgname {
  description = "The name of the Resource Group"
  type        = string
}

variable vnetname {
  description = "The name of the Virtual Network"
  type        = string
}

variable snetname {
  description = "The name of the Subnet"
  type        = string
}

variable aksname {
  description = "The name of the AKS Cluster"
  type        = string
}

variable aksdnsprefix {
  description = "The DNS Prefix for the AKS Cluster"
  type        = string
}

variable aks_pricing_tier {
  description = "The pricing tier of the AKS Cluster"
  type        = string
}

variable aks_kubernetes_version {
  description = "The Kubernetes version for the AKS Cluster"
  type        = string
}

variable aks_node_rgname {
  description = "The name of the Node Resource Group for the AKS Cluster"
  type        = string
}

variable aks_nodepool_name {
  description = "The name of the AKS Node Pool"
  type        = string
}

variable aks_node_count {
  description = "The number of nodes in the AKS Node Pool"
  type        = number
}

variable aks_nodepool_sku {
  description = "The VM size for the AKS Node Pool"
  type        = string
}

variable availability_zones {
  description = "The availability zones for the AKS Node Pool"
  type        = list(any)
}

variable max_pods_per_node {
  description = "The maximum number of pods per node"
  type        = number
}

variable aks_service_cidr {
  description = "The service CIDR for the AKS Cluster"
  type        = string
}

variable aks_dns_service_ip {
  description = "The DNS service IP for the AKS Cluster"
  type        = string
}

variable default_tags {
  description = "A map of default tags to apply to resources"
  type        = map(string)
}

variable tenant_id {
  description = "The Azure AD Tenant ID for AKS integration"
  type        = string
}