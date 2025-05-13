# Set the terminal to allow script execution
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Define the script content
$scriptContent = @"
# Function to check if a command exists
function CommandExists {
    param ([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Ensure Chocolatey is installed
if (!(CommandExists "choco")) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; `
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed."
}

# Install Git if not already installed
if (!(CommandExists "git")) {
    Write-Host "Installing Git..."
    choco install git -y
} else {
    Write-Host "Git is already installed."
}

# Install Node.js (LTS version) if not already installed
if (!(CommandExists "node")) {
    Write-Host "Installing Node.js (LTS)..."
    choco install nodejs-lts -y
} else {
    Write-Host "Node.js is already installed."
}

# Install .NET SDK if not already installed
if (!(CommandExists "dotnet")) {
    Write-Host "Installing .NET SDK..."
    choco install dotnet-sdk -y
} else {
    Write-Host ".NET SDK is already installed."
}

# Install .NET MAUI workload if not already installed
if (!(dotnet workload list | Select-String -Pattern "maui")) {
    Write-Host "Installing .NET MAUI workload..."
    dotnet workload install maui
} else {
    Write-Host ".NET MAUI workload is already installed."
}

# Install Azure CLI if not already installed
if (!(CommandExists "az")) {
    Write-Host "Installing Azure CLI..."
    choco install azure-cli -y
} else {
    Write-Host "Azure CLI is already installed."
}

# Install Postman if not already installed (optional)
if (!(CommandExists "postman")) {
    Write-Host "Installing Postman..."
    choco install postman -y
} else {
    Write-Host "Postman is already installed."
}

# Install Docker Desktop if not already installed (optional)
if (!(CommandExists "docker")) {
    Write-Host "Installing Docker Desktop..."
    choco install docker-desktop -y
} else {
    Write-Host "Docker Desktop is already installed."
}

# Install Visual Studio Code if not already installed
if (!(CommandExists "code")) {
    Write-Host "Installing Visual Studio Code..."
    choco install vscode -y
} else {
    Write-Host "Visual Studio Code is already installed."
}

# Add any additional tools with similar checks
# Example: Add other tools as needed
"@

# Write the script to a file
$scriptPath = "setup-environment.ps1"
Set-Content -Path $scriptPath -Value $scriptContent

# Run the script
Write-Host "Running the setup script..."
& .\$scriptPath

