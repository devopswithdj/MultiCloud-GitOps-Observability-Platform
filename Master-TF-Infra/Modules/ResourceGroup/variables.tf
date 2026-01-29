variable "rgname" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}