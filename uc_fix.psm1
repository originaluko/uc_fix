Function Get-LRO
{
    	<#
	.SYNOPSIS
		Fixes for UC environments
	
	.DESCRIPTION
		Retrieve LRO settings for a ESXi host. 
	
	.PARAMETER Name
		The Name of the Host.
		
	.EXAMPLE
		PS> Get-LRO -Name 'ESXi-Host'
		
		Retrieves the LRO settings of the Host.
	
	.INPUTS
		None.
	
	.OUTPUTS
		System.Management.Automation.PSCustomObject
	
	.NOTES
		Requirements: None
	
	.LINK
		http://blog.ukotic.net
	
	#>


    [CmdletBinding(DefaultParameterSetName = 'None')]
    param(
        [Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateCount(1, 5)]
		[string[]]$Name
    )

    Get-vmHost $Name | Get-AdvancedSetting -name Net.VmxnetSwLROSL, Net.Vmxnet3SwLRO, Net.Vmxnet3HwLRO, Net.Vmxnet2SwLRO, Net.Vmxnet2HwLRO | Format-Table Entity, Name, Value

}

Function Set-LRO
{
   <#
	.SYNOPSIS
		Fixes for UC environments
	
	.DESCRIPTION
		Sets LRO settings for a ESXi host. 
	
	.PARAMETER Name
		The Name of the Host.

	.PARAMETER Value
		'0' to Disable. '1' to Enable
		
	.EXAMPLE
		PS> Set-LRO -Name 'ESXi-Host' -Value 0
		
		Disables LRO settings of the Host.
	
	.INPUTS
		None.
	
	.OUTPUTS
		System.Management.Automation.PSCustomObject
	
	.NOTES
		Requirements: None
	
	.LINK
		http://blog.ukotic.net
	
	#>

    param(
        [Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateCount(1, 5)]
		[string[]]$Name,

        [Parameter(Mandatory)]
		[ValidateSet('0', '1')]
        [ValidateNotNullOrEmpty()]		
        [Int]$Value

    )

    Get-AdvancedSetting -Entity ($Name) -Name Net.VmxnetSwLROSL | Set-AdvancedSetting -Value $Value -Confirm:$False
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet3SwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet3HwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet2SwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet2HwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False
   
    if ($value -eq '1')
    {
    Write-Output 'LRO Enabled'
    }
    else
    {
    Write-Output 'LRO Disabled'
    }
}

Function Test-LRO
{
     <#
	.SYNOPSIS
		Does a WhatIf on setting LRO settings
	
	.DESCRIPTION
		Sets LRO settings for a ESXi host. 
	
	.PARAMETER Name
		The Name of the Host.

	.PARAMETER Value
		'0' to Disable. '1' to Enable
		
	.EXAMPLE
		PS> Test-LRO -Name 'ESXi-Host' -Value 0
		
		Tests what would change with LRO settings on the Host.
	
	.INPUTS
		None.
	
	.OUTPUTS
		System.Management.Automation.PSCustomObject
	
	.NOTES
		Requirements: None
	
	.LINK
		http://blog.ukotic.net
	
	#>

    param(
        [Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateCount(1, 5)]
		[string[]]$Name,

        [Parameter(Mandatory)]
		[ValidateSet('0', '1')]
        [ValidateNotNullOrEmpty()]		
        [Int]$Value

    )

    Get-AdvancedSetting -Entity ($Name) -Name Net.VmxnetSwLROSL | Set-AdvancedSetting -Value $Value -Confirm:$False -WhatIf
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet3SwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False -WhatIf
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet3HwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False -WhatIf
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet2SwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False -WhatIf
    Get-AdvancedSetting -Entity ($Name) -Name Net.Vmxnet2HwLRO | Set-AdvancedSetting -Value $Value -Confirm:$False -WhatIf
    
    if ($value -eq '1')
    {
    Write-Output 'LRO Enabled'
    }
    else
    {
    Write-Output 'LRO Disabled'
    }
}

Function Get-IOV
{

 <#
	.SYNOPSIS
		Check the iovDisableIR setting
	
	.DESCRIPTION
		Check the Interrrupt Routing value in the IOMMU. 
	
	.PARAMETER Name
		The Name of the Host.

	.EXAMPLE
		PS> Get-IVO -Name 'ESXi-Host'
		
		Retrieves the iovDisableIR object
	
	.INPUTS
		None.
	
	.OUTPUTS
		System.Management.Automation.PSCustomObject
	
	.NOTES
		Requirements: None
	
	.LINK
		http://blog.ukotic.net
	
	#>

 param(
        [Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateCount(1, 5)]
		[string[]]$Name

        
    )

    
    $myesxcli = Get-EsxCli -VMHost $Name
    $myesxcli.system.settings.kernel.list() | Where-Object {$_.name -contains 'iovDisableIR'}
    
}

Function Set-IOV
{

 <#
	.SYNOPSIS
		Changes the iovDisableIR setting
	
	.DESCRIPTION
		Changes the  Interrrupt Routing value in the IOMMU to True or False. 
	
	.PARAMETER Name
		The Name of the Host.

	PARAMETER Value
		'True' to Disable. 'False' to Enable
		
	.EXAMPLE
		PS> Set-LRO -Name 'ESXi-Host' -Value True
		
		Changes the iovDisableIR setting to True
	
	.INPUTS
		None.
	
	.OUTPUTS
		System.Management.Automation.PSCustomObject
	
	.NOTES
		Requirements: None
	
	.LINK
		http://blog.ukotic.net
	
	#>
 
 param(
        [Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateCount(1, 5)]
		[string[]]$Name,

        [Parameter(Mandatory)]
		[ValidateSet('True', 'False')]
        [ValidateNotNullOrEmpty()]		
        [string]$Value

    )

    $myesxcli = Get-EsxCli -VMHost $Name
    if ($value -eq 'True')
    {
    $myesxcli.system.settings.kernel.set('iovDisableIR', 'TRUE')
    Write-Output 'Interrupt Routing Disabled'
    }
    else
    {
    $myesxcli.system.settings.kernel.set('iovDisableIR', 'FALSE')
    Write-Output 'Interrupt Routing Enabled'
    }
}