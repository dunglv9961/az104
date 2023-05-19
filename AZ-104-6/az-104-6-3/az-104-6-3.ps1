$location = "useast"
$rgName = "az104-11-rg0"
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateParameterFile .\AZ-104-6\az-104-6-3\az104-11-vm-parameters.json -TemplateFile .\AZ-104-6\az-104-6-3\az104-11-vm-template.json -AsJob

Register-AzResourceProvider -ProviderNamespace Microsoft.Insights

Register-AzResourceProvider -ProviderNamespace Microsoft.AlertsManagement

