Param (
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

)

# Replace values in the backend.tf file
cd D:\a\1\s\Master-TF-Infra\Root

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

Copy-Item -Path "D:\a\1\s\Master-TF-Infra\InputJsonFiles\$projectName-$environment.json" -Destination "D:\a\1\s\Master-TF-Infra\Root\" -Force

Write-Host "Copied $projectName-$environment.json to Root directory successfully."