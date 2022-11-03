# AZ-Runbook-to-list-and-start-power-off-VMs
Azure PowerShell Runbook to detect and start all power off VMs


# I. using Azure default ID

LAB Prerequisite:

Login to Azure portal, open cloud shell, select powershell and create lab using below powershell commands ...

1. Create resource group

$ New-AzResourceGroup -Name 'myResourceGroup' -Location 'EastUS'

2. Create VM

$ New-AzVm -ResourceGroupName 'myResourceGroup' -Name 'myVM01' -Location 'East US'  -VirtualNetworkName 'myVnet' -SubnetName 'mySubnet' -SecurityGroupName 'myNetworkSecurityGroup' -PublicIpAddressName 'myPublicIpAddress' -OpenPorts 80,3389

3. Change size of the VM

$ $vm = Get-AzureRmVM -ResourceGroupName "myResourceGroup" -VMName "myVM01"

$ $vm.HardwareProfile.VmSize = "Standard_B2s"

4. Power off VM

$ Stop-AzVM -ResourceGroupName "myResourceGroup" -Name "myVM01"

5. Create Automation account (Home > Automation Accounts > Create > Select Resource Group Name "myResourceGroup" & provide Automation account Name "autouser01"> Review + Create

Note: you can repeat steps 2 and 3 for creating more VMs 

# Create Runbook ....

1. Open Automation Account "autouser01"

2. Select Runbook

3. Create a runbook (Select + Create a runbook)
    Name the runbook "AZRB-PWRON-VM"
    From the Runbook type drop-down menu, select "PowerShell"
    From the Runtime version drop-down, select "5.1"
    Enter applicable Description "Azure PowerShell Runbook to detect and start power off VMs"
    Select Create
    
4. Add code to the runbook
    copy code from the attached script "AZRB-Test002_v2.ps1" and paste it on your new runbook code pane 
    Note: Verify your $resourceGroupName @ line no. 5. update if required
    
5. Test the runbook
    a. Select Test pane to open the Test page.
    b. Select Start to start the test. A runbook job is created and its status is displayed in the pane.
    The job status starts as Queued, indicating that the job is waiting for a runbook worker in the cloud to become available. 
    The status changes to Starting when a worker claims the job. Finally, the status becomes Running when the runbook actually starts to run.
    c. When the runbook job completes, the Test page displays its output. The output should show names of all started VMs like "started myVM01 ...."
    
6. Publish and start the runbook

    The runbook that you've created is still in Draft mode. You must publish it before you can run it in production. 
    When you publish a runbook, you overwrite the existing Published version with the Draft version. In this case, you don't have a Published version yet because 
    you just created the runbook.

    Select Publish to publish the runbook and then Yes when prompted.
  
 Note: Now your runbook is ready, you can open it and run anytime, if you want you can shedule job to run it.
 


# II. Using Azure ID

Resourese group "myResourceGroup", Azure ID with active subcrption and Ditributed permission on the Resourese group "myResourceGroup"
  
