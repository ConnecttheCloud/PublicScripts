# Define the path to the text file containing the Chocolatey commands
$commandsFile = "C:\install.txt"

# Read the commands from the text file
$commands = Get-Content -Path $commandsFile

# Execute each command
foreach ($command in $commands) {
    # Skip commented lines (lines starting with '#')
    if ($command -notmatch '^#') {
        Write-Host "Executing: $command"
        Invoke-Expression $command
    }
}

# Add the following content to the PowerShell profile ($PROFILE)
$profilePath = $PROFILE

# Content to add to the profile
$profileContent = @"
# Terminal Config
code $PROFILE

set-alias grep findstr
set-alias g gcloud
set-alias k kubectl
set-alias tf terraform

oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/ConnecttheCloud/my-ohmyposh/main/mytheme.omp.json' | Invoke-Expression
"@

# Check if the profile file exists, if not, create it
if (-not (Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}

# Append content to the profile
Add-Content -Path $profilePath -Value $profileContent

Write-Host "Profile configuration has been added to $PROFILE"
