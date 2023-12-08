# Function to display menu and get user choice
function Show-Menu {
    Clear-Host
    Write-Host "1. Run device diagnostic"
    Write-Host "2. Install winget and update all programs"
    Write-Host "3. Install PowerShell Windows Update and update the machine"
    Write-Host "4. Reminder to delete old name from AD"
    Write-Host "5. Check Bitlocker"
    Write-Host "6. Run All in Bulk"
    Write-Host "0. Exit"
    $choice = Read-Host "Enter the number of your choice"
    return $choice
}

# Function to perform actions based on user choice
function Perform-Action {
    param (
        [string]$choice
    )

    switch ($choice) {
        1 {
            # Run device diagnostic
            Get-WmiObject Win32_LogicalDisk | Select-Object DeviceID, MediaType, FreeSpace, Size | Out-File -FilePath "DeviceDiagnostic.log"
            sfc /scannow | Out-File -FilePath "SFCScan.log"
            Test-NetConnection | Out-File -FilePath "NetworkCheck.log"
            Write-Host "Device diagnostic completed. Logs saved to DeviceDiagnostic.log, SFCScan.log, and NetworkCheck.log."
        }
        2 {
            # Install winget and update all programs
            Install-Module -Name winget -Force -AllowClobber
            winget upgrade --all
            Write-Host "Winget installed and all programs updated."
        }
        3 {
            # Install PowerShell Windows Update and update the machine
            Install-Module -Name PSWindowsUpdate -Force -AllowClobber
            Get-WindowsUpdate -Install -AcceptAll -AutoReboot
            Write-Host "PowerShell Windows Update installed and machine updated."
        }
        4 {
            # Reminder to delete old name from AD
            $deleteOldName = Read-Host "Did you delete the old name from AD? (Y/N)"
            if ($deleteOldName -eq 'Y') {
                Write-Host "Reminder completed. Old name deleted from AD."
            } else {
                Write-Host "Reminder: Please delete the old name from AD when applicable."
            }
        }
        5 {
            # Check Bitlocker
            Get-BitLockerVolume | Out-File -FilePath "BitlockerStatus.log"
            Write-Host "Bitlocker status checked. Log saved to BitlockerStatus.log."
        }
        6 {
            # Run All in Bulk
            Perform-Action -choice 1
            Perform-Action -choice 2
            Perform-Action -choice 3
            Perform-Action -choice 4
            Perform-Action -choice 5
        }
        0 {
            Write-Host "Exiting..."
            exit
        }
        default {
            Write-Host "Invalid choice. Please enter a valid option."
        }
    }
}

# Main loop to display menu and perform actions
while ($true) {
    $choice = Show-Menu
    Perform-Action -choice $choice
    Write-Host "Press Enter to continue..."
    Read-Host
}

