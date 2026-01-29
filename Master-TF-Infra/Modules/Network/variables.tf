variable "rgname" {
  description = "Name of the resource group"
  type        = string
}

variable "vnetname" {
  description = "Name of the virtual network"
  type        = string
}

variable "snetname" {
  description = "Name of the subnet"
  type        = string
}

variable "vnetaddress" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "snetaddress" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}