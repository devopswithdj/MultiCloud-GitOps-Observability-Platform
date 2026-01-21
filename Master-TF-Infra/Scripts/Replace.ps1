Param {
    [String]
    $environment = "string",
    [String]
    $projectName = "string",
    [String]
    $storageRG = "string",
    [String]
    $storageAccount = "string",
    [String]
    $storageContainer = "string",
    [String]
    $storageKey = "string"

}

# Replace values in the backend.tf file
cd D:\devopswithdj\MultiCloud-GitOps-Observability-Platform\Master-TF-Infra\Root

# Setting up backend configuration
$filePath = ".\backend.tf"

(Get-Content $filePath) | ForEach-Object {
    $_ -replace 'env', $environment `
       -replace 'projectname', $projectName `
       -replace 'StorageRG', $storageRG `
       -replace 'StorageName', $storageAccount `
       -replace 'StorageContainer', $storageContainer `
       -replace 'StorageString', $storageKey
} | Set-Content $filePath

Write-Host "Replaced values in backend.tf file successfully."