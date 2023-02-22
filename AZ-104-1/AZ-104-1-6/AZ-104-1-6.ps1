# obtain available location values
Get-AzLocation


# sign in to your account
Connect-AzAccount

# obtain your subscription(s) and their ID(s). The subscription ID is the second column.
Get-AzSubscription

$subscriptionId = "783cb51a-2543-4179-bfec-1c156b31d006"
$tenantId = "604c1504-c6a3-4080-81aa-b33091104187"
# let the default resource group be the resource group created for you. 
$resourceGroupName = "learn-5f4fdc1e-0e0e-4cf4-a45c-4aa4d8754bc6"
# $location = "westus"

$context = Get-AzSubscription -SubscriptionId $subscriptionId
Set-AzContext $context

Set-AzDefault -ResourceGroupName $resourceGroupName

# Excersice 3
# New-AzResourceGroup -Name $resourceGroupName -Location $location

# To start a template deployment at the resource group
$templateFile = "azuredeploy3-1.json"
$today = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "blanktemplate-" + "$today"
New-AzResourceGroupDeployment `
-Name $deploymentName `
-TemplateFile $templateFile

# Deploy the updated ARM template
$templateFile = "azuredeploy3-2.json"
$today = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "addstorage-" + "$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile


$storageName = "az10465storage"
# ----------Excersice 5---------
# Part 1
$templateFile = "azuredeploy5-1.json"
$today = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "addnameparameter-$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName $storageName

# Part 2
$templateFile = "azuredeploy5-2.json"
$deploymentName = "addSkuParameter-$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName $storageName -storageSKU Standard_GRS

# test not allowed value for SKU
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName $storageName -storageSKU Basic

# Part 3 Add output to the ARM template
$templateFile = "azuredeploy5-3.json"
$deploymentName = "addOutputs-$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName $storageName -storageSKU Standard_LRS



# Disconnect sandbox
Disconnect-AzAccount -TenantId $tenantId