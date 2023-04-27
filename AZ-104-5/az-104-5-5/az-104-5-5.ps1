$location1 = "eastus"
$location2 = "westus"
$rgName = "az-104-5-5"

New-AzResourceGroupDeployment `
-ResourceGroupName $rgName `
-TemplateFile .\AZ-104-5\az-104-5-5\az104-05-vnetvm-loop-template.json `
-TemplateParameterFile .\AZ-104-5\az-104-5-5\az104-05-vnetvm-loop-parameters.json `
-location1 $location1 `
-location2 $location2


