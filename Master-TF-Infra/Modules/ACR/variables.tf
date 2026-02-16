variable "rgname" {
  type = string
  description = "Name of the resource group"
}
variable "acrname" {
  type = string
  description = "Name of the Azure Container Registry"
}
variable "acrsku" {
  type = string
  description = "SKU of the Azure Container Registry (Basic, Standard, Premium)"
}
variable "adminenabled" {
  type = bool
  description = "Enable admin user for ACR (true/false)"
}