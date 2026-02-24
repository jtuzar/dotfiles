$ErrorActionPreference = "Stop"

$DotfilesDir = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function New-Symlink
{
  param(
    [Parameter(Mandatory = $true)]
    [string]$Source,
    [Parameter(Mandatory = $true)]
    [string]$Target
  )

  $Parent = Split-Path -Parent $Target
  if (-not (Test-Path $Parent))
  {
    New-Item -ItemType Directory -Path $Parent -Force | Out-Null
  }

  if (Test-Path $Target)
  {
    Remove-Item -Path $Target -Recurse -Force
  }

  New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
  Write-Host "Linked $Target -> $Source"
}

$NvimSource = Join-Path $DotfilesDir "shared\nvim\.config\nvim"
$NvimTarget = Join-Path $env:LOCALAPPDATA "nvim"

New-Symlink -Source $NvimSource -Target $NvimTarget



$PwshProfileSource = Join-Path $DotfilesDir "windows\powershell\Microsoft.PowerShell_profile.ps1"
$PwshProfileTarget = Join-Path $HOME "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

if (Test-Path $PwshProfileSource)
{
  New-Symlink -Source $PwshProfileSource -Target $PwshProfileTarget
}

$WtSettingsSource = Join-Path $DotfilesDir "windows\windows-terminal\settings.json"
$WtSettingsTarget = Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $WtSettingsSource)
{
  New-Symlink -Source $WtSettingsSource -Target $WtSettingsTarget
}

$WinRoot = Join-Path $DotfilesDir "windows"
if (Test-Path $WinRoot)
{
  Get-ChildItem -Path $WinRoot -Directory | ForEach-Object {
    Write-Host "Windows package available: $($_.Name)"
  }
}

Write-Host "Done."
