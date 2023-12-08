# Function to display menu and get user choice
function Show-Menu {
    Clear-Host
    Write-Host "1. Rename Machine"
    Write-Host "2. Join to domain"
    Write-Host "3. Install McAfee"
    Write-Host "4. Install Synctoy"
    Write-Host "5. Windows Updates"
    Write-Host "6. Install Ninja"
    Write-Host "7. Run All in Bulk"
    Write-Host "0. Exit"
    $choice = Read-Host "Enter the number of your choice"
    return $choice
}

# Function to perform actions based on user choice
function Perform-Action {
    param (
        [string]$choice,
        [switch]$Silent
    )

    switch ($choice) {
        1 {
            $newName = Read-Host "Enter the new machine name"
            Rename-Computer -NewName $newName -Force -Restart
        }
        2 {
            $domain = Read-Host "Enter the domain name"
            $credential = Get-Credential
            Add-Computer -DomainName $domain -Credential $credential -Restart
        }
        3 {
            $mcafeePath = "C:\Path\To\McAfeeInstaller.exe"
            if ($Silent) {
                Start-Process -FilePath $mcafeePath -ArgumentList "/S" -Wait
            } else {
                Start-Process -FilePath $mcafeePath -Wait
            }
        }
        4 {
            $synctoyPath = "C:\Path\To\SynctoyInstaller.exe"
            if ($Silent) {
                Start-Process -FilePath $synctoyPath -ArgumentList "/S" -Wait
            } else {
                Start-Process -FilePath $synctoyPath -Wait
            }
        }
        5 {
            Write-Host "Running Windows Updates..."
            Install-WindowsUpdate -AcceptAll -AutoReboot
        }
        6 {
            $ninjaPath = "C:\Path\To\NinjaInstaller.exe"
            if ($Silent) {
                Start-Process -FilePath $ninjaPath -ArgumentList "/S" -Wait
            } else {
                Start-Process -FilePath $ninjaPath -Wait
            }
        }
        7 {
            Write-Host "Running All in Bulk..."
            Perform-Action -choice 1 -Silent:$Silent
            Perform-Action -choice 2 -Silent:$Silent
            Perform-Action -choice 3 -Silent:$Silent
            Perform-Action -choice 4 -Silent:$Silent
            Perform-Action -choice 5 -Silent:$Silent
            Perform-Action -choice 6 -Silent:$Silent
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
    $silent = $false
    if ($choice -eq 7) {
        $silent = Read-Host "Run in Silent mode? (Y/N)" -eq 'Y'
    }
    Perform-Action -choice $choice -Silent:$silent
    Write-Host "Press Enter to continue..."
    Read-Host
}

