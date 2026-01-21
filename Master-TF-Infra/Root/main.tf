# Configure the Azure provider
resource "azurerm_resource_group" "rg" {
  name     = "testingTF-rg"
  location = "westus2"
}
