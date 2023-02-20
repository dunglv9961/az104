param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

for ($i = 1; $i -le 3; $i++) {
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName

    #create a VM using the $vmName variable
    New-AzVM -Name $vmName -ResourceGroupName $resourceGroup -Credential $adminCredential -Image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest
}