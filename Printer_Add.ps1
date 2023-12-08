# Define the print server
$printServer = "\\YourPrintServer"

# Prompt the technician for printer names
$printerNames = Read-Host "Enter printer names (separated by commas)"

# Split the input into an array of printer names
$printerNames = $printerNames -split ',' | ForEach-Object { $_.Trim() }

# Install printers for all users
foreach ($printerName in $printerNames) {
    # Install the printer
    Add-Printer -ConnectionName "$printServer\$printerName"

    # Set the printer as the default for all users
    $keyPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Providers\Client Side Rendering Print Provider"
    $valueName = "CsidlPrintHood"
    $printHoodPath = Join-Path $env:SystemRoot "system32\spool\drivers\color"
    
    if (-not (Test-Path $keyPath)) {
        New-Item -Path $keyPath -Force
    }

    Set-ItemProperty -Path $keyPath -Name $valueName -Value $printHoodPath
}

Write-Host "Printers installed successfully for all users."
