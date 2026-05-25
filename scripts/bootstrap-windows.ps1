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

$WezSource = Join-Path $DotfilesDir "windows\wezterm\.wezterm.lua"
$WezTarget = Join-Path $HOME ".wezterm.lua"

if (Test-Path $WezSource)
{
  New-Symlink -Source $WezSource -Target $WezTarget
}

function New-AppShortcut
{
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Target,
    [Parameter(Mandatory = $true)][string]$Arguments,
    [string]$WorkingDirectory = ""
  )

  $Parent = Split-Path -Parent $Path
  if (-not (Test-Path $Parent))
  {
    New-Item -ItemType Directory -Path $Parent -Force | Out-Null
  }

  $Shell = New-Object -ComObject WScript.Shell
  $Shortcut = $Shell.CreateShortcut($Path)
  $Shortcut.TargetPath = $Target
  $Shortcut.Arguments = $Arguments
  if ($WorkingDirectory) { $Shortcut.WorkingDirectory = $WorkingDirectory }
  $Shortcut.IconLocation = $Target
  $Shortcut.Save()
  Write-Host "Shortcut $Path -> $Target $Arguments"
}

$WezGui = "C:\Program Files\WezTerm\wezterm-gui.exe"
if (Test-Path $WezGui)
{
  $StartPrograms = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"

  New-AppShortcut `
    -Path (Join-Path $StartPrograms "WezTerm WSL.lnk") `
    -Target $WezGui `
    -Arguments "start --always-new-process -- wsl.exe --cd ~"

  New-AppShortcut `
    -Path (Join-Path $StartPrograms "WezTerm PowerShell.lnk") `
    -Target $WezGui `
    -Arguments "start --always-new-process -- pwsh.exe -NoLogo"
}

$WinRoot = Join-Path $DotfilesDir "windows"
if (Test-Path $WinRoot)
{
  Get-ChildItem -Path $WinRoot -Directory | ForEach-Object {
    Write-Host "Windows package available: $($_.Name)"
  }
}

Write-Host "Done."
