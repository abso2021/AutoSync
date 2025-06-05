# Load the necessary .NET class for folder dialog
Add-Type -AssemblyName System.Windows.Forms

# Function to prompt user to select a folder, with custom message
function Get-FolderPath {
    param (
        [string]$promptMessage
    )
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $promptMessage
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.SelectedPath
    } else {
        Write-Error "No folder was selected. Exiting."
        exit
    }
}

# Function to copy only new files (skip existing)
function Copy-NewFiles {
    param (
        [string]$source,
        [string]$destination
    )

    $files = Get-ChildItem -Path $source -File

    foreach ($file in $files) {
        $targetPath = Join-Path $destination $file.Name
        if (-Not (Test-Path $targetPath)) {
            Copy-Item -Path $file.FullName -Destination $destination
            Write-Host "Copied: $($file.Name)"
        } else {
            Write-Host "Skipped (already exists): $($file.Name)"
        }
    }
}

# Prompt user for source and destination folders
$sourceFolder = Get-FolderPath -promptMessage "Please select the SOURCE folder"
Write-Host "Source folder selected: $sourceFolder"

$destinationFolder = Get-FolderPath -promptMessage "Please select the DESTINATION folder"
Write-Host "Destination folder selected: $destinationFolder"

# Run the sync loop every 1 hour
while ($true) {
    Write-Host "`n==== Starting sync: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===="
    Copy-NewFiles -source $sourceFolder -destination $destinationFolder
    Write-Host "Waiting 1 hour for next sync..."
    Start-Sleep -Seconds 60
}
