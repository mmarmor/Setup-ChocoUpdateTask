# Setup-ChocoUpdateTask.ps1 | MSM 9-Nov-2024

# Description:
# This PowerShell script automates the creation of a scheduled task named "ChocoUpdate" to update all 
# Chocolatey packages each time a user logs on. It checks if Chocolatey is installed, retrieves the 
# correct path to choco.exe, and creates a task that runs with elevated privileges to ensure all 
# updates proceed smoothly. If the task already exists, it deletes and recreates it to avoid conflicts. 
# The script outputs confirmation messages and error details to aid troubleshooting.

# Open PowerShell as an administrator and run: .\Setup-ChocoUpdateTask.ps1

# If you encounter an execution policy error:
# Check execution policy with: Get-ExecutionPolicy
# Temporarily allow the script to run by setting the execution policy:
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# Then run the script: .\Setup-ChocoUpdateTask.ps1
# (Optional) Restore the default execution policy afterward. Common settings are Restricted or RemoteSigned:
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Restricted

# Check if Chocolatey is Installed
if (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Please install Chocolatey first."
    exit
}

# Display current execution policy for reference
Write-Host "Current Execution Policy: $(Get-ExecutionPolicy)"

# Retrieve the Path to choco.exe
$chocoPath = (Get-Command choco.exe).Source
$taskName = "ChocoUpdate"

# Check if the Scheduled Task already exists, remove if it does
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host "Existing scheduled task '$taskName' removed."
}

# Define Task Parameters
$action = New-ScheduledTaskAction -Execute $chocoPath -Argument 'upgrade all --exit-when-reboot-detected --yes'
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest
$task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal

# Register the Scheduled Task
try {
    Register-ScheduledTask -TaskName $taskName -InputObject $task -Force
    Write-Host "Scheduled task '$taskName' created successfully to automatically update all Chocolatey packages at logon."
} catch {
    Write-Host "Failed to create scheduled task '$taskName': $($_.Exception.Message)"
}
