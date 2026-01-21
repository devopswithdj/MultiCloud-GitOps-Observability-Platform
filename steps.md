1) Setup a github repository
2) install terraform in local - https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli
3) Setup the Terraform and start building in local

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

# PowerShell
> $env:ARM_CLIENT_ID = "00000000-0000-0000-0000-000000000000"
> $env:ARM_CLIENT_SECRET = "12345678-0000-0000-0000-000000000000"
> $env:ARM_TENANT_ID = "10000000-0000-0000-0000-000000000000"
> $env:ARM_SUBSCRIPTION_ID = "20000000-0000-0000-0000-000000000000"



az group create --name terraform-rg --location centralus

az storage account create --name tfinfrastgacct --resource-group terraform-rg --location centralus --sku Standard_LRS --kind StorageV2 --min-tls-version TLS1_2 --allow-blob-public-access false

