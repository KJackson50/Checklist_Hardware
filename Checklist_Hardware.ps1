# PowerShell Hardware Repair Checklist

# Function to prompt for completion of each step
function PromptForStepCompletion($step) {
    $response = Read-Host -Prompt "$step completed? (Y/N)"
    return $response -eq 'Y'
}

# Function to display canned response
function DisplayCannedResponse {
    $ticketNumber = Read-Host -Prompt "Enter the ticket number"
    Write-Host "Canned response: Thank you for reaching out! We have received your hardware repair request with ticket number $ticketNumber and are actively working on it. We will keep you updated on the progress. Please be on the lookout for an email from UPS."
    return $ticketNumber
}

# Function to procure a machine name from AD
function GetNextAvailableMachineName {
    $computerName = Read-Host -Prompt "Enter the computer name"
    Write-Host "Machine name set to: $computerName"
    return $computerName
}

# Function to open UPS website
function OpenUpsWebsite {
    # OPEN SPEEDSHIP WEBSITE HERE
    start chrome https://speedship.wwex.com/pls/apex/f?p=77055:101
}

# Function to open Excel macro file
function OpenExcelMacroFile {
    # Example: Manual intervention needed here
    # EDIT MACRO TO OPEN TICKET TRACKER AND ALLOCATION, THEN OPEN IT HERE
    Write-Host "Manually open the Excel macro file."
}

# Array of steps
$steps = @(
    "Initial Ticket: Respond to PCT and User",
    "Procure a machine name from AD",
    "Create a shipping label via UPS",
    "Input data into 'Tracking' and 'Allocation' Excel sheets",
    "Image machine (not done already)",
    "Join Domain",
    "Install McAfee",
    "Install SyncToy",
    "Windows Updates",
    "Confirm NinjaRMM is installed",
    "Confirm Bitlocker is on and encrypted",
    "Run and save machine diagnostics",
    "Capture the above data into a summary sheet for internal QA",
    "Capture the quality assurance and machine check into a document to add with the package",
    "Package machine with a return label, diagnostic, checklist"
)

# Prompt for computer name and ticket number
$computerName = GetNextAvailableMachineName
$ticketNumber = DisplayCannedResponse

# Define the output file name based on computer name and ticket number
$checklistFile = "C:\Projects\Finished_Repairs\HardwareRepairChecklist_${computerName}_${ticketNumber}.txt"

# Check if the checklist file exists, if not, create it
if (-not (Test-Path $checklistFile)) {
    $null | Out-File -FilePath $checklistFile
}

# Iterate through each step and prompt for completion
foreach ($step in $steps) {
    switch ($step) {
        "Initial Ticket: Respond to PCT and User" {
            $completed = PromptForStepCompletion $step
            "$step - Ticket: $ticketNumber - Completed: $completed" | Out-File -Append -FilePath $checklistFile
        }
        "Procure a machine name from AD" {
            $completed = PromptForStepCompletion $step
            "$step - Machine Name: $computerName - Completed: $completed" | Out-File -Append -FilePath $checklistFile
        }
        "Create a shipping label via UPS" {
            OpenUpsWebsite
            $completed = PromptForStepCompletion $step
            "$step - Completed: $completed" | Out-File -Append -FilePath $checklistFile
        }
        "Input data into 'Tracking' and 'Allocation' Excel sheets" {
            OpenExcelMacroFile
            $completed = PromptForStepCompletion $step
            "$step - Completed: $completed" | Out-File -Append -FilePath $checklistFile
        }
        default {
            $completed = PromptForStepCompletion $step
            "$step - Completed: $completed" | Out-File -Append -FilePath $checklistFile
        }
    }
}

# Display completion status
Write-Host "`nHardware Repair Checklist Results:`n"
Get-Content -Path $checklistFile
