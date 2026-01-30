#Authentication Details
variable "azure_client_id" {
  description = "The Client ID of the Service Principal used for Azure authentication."
  type        = string
}

variable "azure_client_secret" {
  description = "The Client Secret of the Service Principal used for Azure authentication."
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "The Tenant ID of the Azure Active Directory."
  type        = string
}

variable "azure_subscription_id" {
  description = "The Subscription ID for the Azure resources."
  type        = string
}