# The Cluster Name (Non-sensitive)
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}