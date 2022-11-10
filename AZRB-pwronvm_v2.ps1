##########################################################
### AZ RB Start Power Off VMs v2 - Ajit D.             ###
### List All VMs, Filter Power off VMs and Start them  ###
### Prerequisite - Automation acct & permission on RG  ###
##########################################################
$resourceGroupName = "myResourceGroup"
# Ensure you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context
# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
# List all VMs status
$vms = Get-AzVM -ResourceGroupName $resourceGroupName -Status -DefaultProfile $AzureContext
# List Power Off  VMs
$PWFVMS = ($vms | where-object {$_.PowerState -eq 'VM deallocated'}).Name -join '; '
Write-output "Power Off VMs:"
Write-output $PWFVMS
# Start Power Off  VMs
foreach ($VM in $PWFVMS) {
	Write-output "  "	   
	Write-output $VM
    Write-output "--------"	
    Write-output "starting $VM..."
    Start-AzVM -ResourceGroupName $resourceGroupName -Name $VM
    sleep 30
    Write-Output "started $VM !!!"	
    }
Write-Output "Account ID of current context: " $AzureContext.Account.Id
