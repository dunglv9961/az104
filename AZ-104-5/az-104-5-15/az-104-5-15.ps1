# ----Create IP addresses------------
$location = $(Get-AzResourceGroup -ResourceGroupName rg).Location

$publicIP = New-AzPublicIpAddress `
    -ResourceGroupName rg `
    -Location $location `
    -AllocationMethod Static `
    -Name "myPublicIP"

$frontendIP = New-AzLoadBalancerFrontendIpConfig -Name "myFrontEnd" -PublicIpAddress $publicIP

# -----Create the load balancer-----------
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "myBackEndPool"

# The health probe dynamically adds or removes VMs from the load balancer rotation based on their response to health checks
$probe = New-AzLoadBalancerProbeConfig -Name "myHealthProbe" -Protocol Http -Port 80 -IntervalInSeconds 5 -ProbeCount 2 -RequestPath "/"

# define the front-end IP configuration for the incoming traffic and the back-end IP pool to receive the traffic
$lbrule = New-AzLoadBalancerRuleConfig -Name "myLoadBalancerRule" `
    -FrontendIpConfiguration $frontendIP -BackendAddressPool $backendPool `
    -Protocol Tcp -FrontendPort 80 -BackendPort 80 -Probe $probe

# create the basic load balancer    
$lb = New-AzLoadBalancer -ResourceGroupName rg -Name "myLoadBalancer" -Location $location `
    -FrontendIpConfiguration $frontendIP -BackendAddressPool $backendPool -Probe $probe -LoadBalancingRule $lbrule

# Connect the VMs to the back-end pool by updating the network interfaces that the script created to use the back-end pool information
$nic1 = Get-AzNetworkInterface -ResourceGroupName rg -Name "webNic1"
$nic2 = Get-AzNetworkInterface -ResourceGroupName rg -Name "webNic2"

$nic1.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool
$nic2.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool

Set-AzNetworkInterface -NetworkInterface $nic1 -AsJob
Set-AzNetworkInterface -NetworkInterface $nic2 -AsJob

Write-Host http://$($(Get-AzPublicIpAddress -ResourceGroupName rg -Name "myPublicIP").IpAddress)

