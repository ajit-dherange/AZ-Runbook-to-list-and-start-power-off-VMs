### AZ RB Test 002 v2: List All Power off Vms and Start them
$resourceGroupName = "myResourceGroup"
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context
# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
# Start Power Off VMs
$vms = Get-AzVM -ResourceGroupName $resourceGroupName -Status -DefaultProfile $AzureContext
$PWFVMS = ($vms | where-object {$_.PowerState -eq 'VM deallocated'}).Name
Write-output "Power Off VMs:"
Write-output $PWFVMS
foreach ($VM in $PWFVMS) {
	Write-output "  "	   
	Write-output $VM
    Write-output "--------"	
    Write-output "starting $VM..."
    Start-AzVM -ResourceGroupName $resourceGroupName -Name $VM
    sleep 30
    Write-Output "started $VM...."	
    }
Write-Output "Account ID of current context: " $AzureContext.Account.Id