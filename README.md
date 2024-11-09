# Setup-ChocoUpdateTask

A PowerShell script to automate the creation of a scheduled task named **"ChocoUpdate"** that updates all Chocolatey packages every time a user logs on to Windows. The script checks if Chocolatey is installed, dynamically retrieves the path to `choco.exe`, and creates the task with elevated privileges to ensure smooth execution of updates. If a task with the same name already exists, it will be deleted and recreated to avoid conflicts. The script provides informative logs to confirm task creation or troubleshoot errors.

## Features
- Automatically updates all Chocolatey packages when the user logs in.
- Checks for Chocolatey installation and retrieves `choco.exe` path.
- Ensures the task runs with administrative privileges.
- Deletes any pre-existing task with the same name to prevent duplication.
- Outputs confirmation messages and error details.

## Prerequisites
- **Windows PowerShell** with permissions to create scheduled tasks.
- **Chocolatey** installed. If not installed, download from [Chocolatey](https://chocolatey.org/install).

## How to Run
1. **Open PowerShell as an Administrator**.
2. Navigate to the script's directory.
3. Run the script:
   ```powershell
   .\Setup-ChocoUpdateTask.ps1
   ```

## Troubleshooting: Execution Policy Errors
If you encounter an error related to PowerShell's execution policy:

1. **Check Current Execution Policy**:
   ```powershell
   Get-ExecutionPolicy
   ```

2. **Temporarily Change Execution Policy** (for this session only):
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```

3. **Run the Script Again**:
   ```powershell
   .\Setup-ChocoUpdateTask.ps1
   ```

4. **(Optional) Restore Execution Policy**:
   After running the script, you can revert to your previous policy. Typical settings are `Restricted` or `RemoteSigned`:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Restricted
   ```

## Example Output
The script provides feedback in the PowerShell console, confirming task creation or displaying error messages if issues occur.

```plaintext
Chocolatey is not installed. Please install Chocolatey first.
Existing scheduled task 'ChocoUpdate' removed.
Scheduled task 'ChocoUpdate' created successfully to automatically update all Chocolatey packages at logon.
```

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

This script streamlines package updates on Windows, providing a hands-off solution to keep Chocolatey packages up-to-date with minimal setup. Perfect for automated environments and routine maintenance!

