# obtain available location values
Get-AzLocation

# -----------sandbox------------
# sign in to your account
Connect-AzAccount

# obtain your subscription(s) and their ID(s). The subscription ID is the second column.
Get-AzSubscription
$subscriptionId = "1cc8e07f-87af-4d1c-87bc-9107b6851819"

$context = Get-AzSubscription -SubscriptionId $subscriptionId
Set-AzContext $context

# let the default resource group be the resource group created for you. 
$resourceGroupName = "learn-f4cb85ce-9b33-4b3d-92c2-91d9377ec141"
$location = "westus"

New-AzResourceGroup -Name $resourceGroupName -Location $location

Set-AzDefault -ResourceGroupName $resourceGroupName

# To start a template deployment at the resource group
$templateFile = "azuredeploy.json"
$today = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "blanktemplate-" + "$today"
New-AzResourceGroupDeployment `
-Name $deploymentName `
-TemplateFile $templateFile

# Deploy the updated ARM template
$templateFile = "azuredeploy.json"
$today = Get-Date -Format "MM-dd-yyyy"
$deploymentName = "addstorage-" + "$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile

Disconnect-AzAccount -TenantId "604c1504-c6a3-4080-81aa-b33091104187"


