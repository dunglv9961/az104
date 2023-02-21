$resourceGroupName = "az104-1-6"
$location = "southeastasia"

Connect-AzAccount

# obtain available location values
Get-AzLocation

New-AzResourceGroup -Name $resourceGroupName -Location $location

# To start a template deployment at the resource group
$templateFile = ""
New-AzResourceGroupDeployment `
-Name blanktemplate `
-ResourceGroupName $resourceGroupName `
-TemplateFile $templateFile






