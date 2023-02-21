$PSVersionTable.PSVersion

# Get-Help -Name Get-ChildItem -Detailed
Get-Module 
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

Update-Module -Name Az

# Get-Help 
Connect-AzAccount

Get-AzContext

Get-AzSubscription

#Change the subscription by passing the name of the one to select.
Set-AzContext -Subscription ''

Get-AzResourceGroup | Format-Table

$resourceGroupName = "az104-1-4"
$vmName = "az-104-4-vm"
New-AzResourceGroup -Name $resourceGroupName -Location "southeastasia"

Get-AzResource

New-AzVM -ResourceGroupName $resourceGroupName -Name $vmName -Location "southeastasia" -Credential (Get-Credential)

Get-AzVM -Status

Stop-AzVM -Name $vmName -ResourceGroupName @resourceGroupName

Restart-AzVM -ResourceGroupName $resourceGroupName -Name $vmName

$ResourceGroupName = "ExcerciseResources"
$vm = Get-AzVM -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.VmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName -VM $vm

Get-AzResource -ResourceType Microsoft.Compute/virtualMachines

Remove-AzResourceGroup -Name $resourceGroupName -Force

#----sandbox----------
New-AzVm -ResourceGroupName learn-875e5912-a77d-481a-80a1-94b7d93e1308 -Name "testvm-wus-01" -Credential (Get-Credential) -Location "WestUS" -Image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest -OpenPorts 22 -PublicIpAddressName "testvm-01"

$vm = (Get-AzVM -Name "testvm-wus-01" -ResourceGroupName learn-875e5912-a77d-481a-80a1-94b7d93e1308)

$vm.HardwareProfile

#to get information on one of the disks, run the following command:
$vm.StorageProfile.OsDisk

#show you all available sizes for your VM
$vm | Get-AzVMSize

#get your public IP address of created VM:
Get-AzPublicIpAddress -ResourceGroupName learn-875e5912-a77d-481a-80a1-94b7d93e1308 -Name "testvm-01"

#------------------------Delete a VM------------------------
#shut it down first
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

#delete the VM
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

#list all the resources in your resource group
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table

#clean it up manually
#1. Delete the network interface:
$vm | Remove-AzNetworkInterface -Force
#2. Delete the managed OS disks and storage account:
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OsDisk.Name | Remove-AzDisk -Force
#3. Next, delete the virtual network:
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
#4. Delete the network security group:
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
#5. And finally, delete the public IP address:
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force











