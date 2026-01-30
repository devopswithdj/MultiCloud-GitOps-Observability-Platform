terraform {
  backend "azurerm" {
    resource_group_name = "StorageRG"
    access_key           = "StorageString"
    storage_account_name = "StorageName"
    container_name       = "StorageContainer"
    key                  = "projectname-env-modules.tfstate"
  }
}

# Above values get fetched from Replace.ps1 script during deployment
# /Replace.ps1 -StorageAccountName "StorageName" -StorageContainerName "StorageContainer" -StorageAccessKey "StorageString" -ResourceGroupName "StorageRG" -ProjectName "projectname" -Environment "env"


# terraform {
#   backend "azurerm" {
#     use_oidc             = true
#     use_azuread_auth     = true
#     tenant_id            = "7facfc55-87e0-4390-a951-abdbb862b7fb"
#     client_id            = "94b8521d-41e9-4cc1-a313-ad7e85410d90"
#     storage_account_name = "tfinfrastgacct"
#     container_name       = "tfteststatefiles"
#     key                  = "test.terraform.tfstate"
#   }
# }