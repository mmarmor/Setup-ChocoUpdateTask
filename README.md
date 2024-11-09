# Setup-ChocoUpdateTask
Automates the creation of a scheduled task ("ChocoUpdate") to update all Chocolatey packages at user logon on Windows. Checks if Chocolatey is installed, retrieves the choco.exe path, and runs with elevated privileges. Deletes any existing task with the same name to avoid conflicts, with logs for successful task creation and error handling.
