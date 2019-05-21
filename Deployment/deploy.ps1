param (
    [Parameter(Mandatory = $true)]
    [string]$environmentName,
    [Parameter(Mandatory = $true)]
    [string]$functionName,
    [Parameter(Mandatory = $true)]
    [string]$deploymentId
)
process {
    Write-Host "Starting deployment at $((Get-Date).ToString("yyyyMMdd:hhmmss"))"

    #Assign parameter values for template deployment
    $templateParameters = @{
        envCode      = $environmentName
        functionName = $functionName
        deploymentId = $deploymentId
        environmentName =$env:RELEASE_ENVIRONMENTNAME
    }

    $resourceGroupName = 'AnugDemo'

    Write-Host "Executing template.json with $( $templateParameters | Format-Table | Out-String )"

    #Prepare template deployment data
    $deploymentParameters = @{
        Name                    = ($resourceGroupName + 'AnugDemo-deployment-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
        ResourceGroupName       = $resourceGroupName
        TemplateFile            = (Get-Item -Path "$PSScriptRoot\template.json")
        TemplateParameterObject = $templateParameters
        Force                   = $true
        Verbose                 = $true
    }

    #Deploy template -- RG HAS BEEN PRECREATED
    $outputs = New-AzResourceGroupDeployment  @deploymentParameters
    Write-Host "Deployment finished at $((Get-Date).ToString("yyyyMMdd:hhmmss"))"

    return $outputs
}