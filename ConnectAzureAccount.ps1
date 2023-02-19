#Parameter
$AdminUserName = "dunglv11@vingroup.net"
$AdminPassword = "Password goes here"
  
#Variable for Pscredential object
$SecurePassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential -argumentlist $AdminUserName, $SecurePassword
   
#Connect to Azure Active Directory
Connect-AzureAD –Credential $Credential

