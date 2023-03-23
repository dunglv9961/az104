$invitations = Import-Csv invitation.csv
$messageInfo = New-Object Microsoft.Opem.MSGrapth.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello"

foreach ($email in $invitations) {
    New-AzureADMSInvitation
}

Remove-AzADUser

