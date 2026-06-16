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
    Remove-Item -LiteralPath $Target -Recurse -Force
  }

  try
  {
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
    Write-Host "Linked $Target -> $Source"
  }
  catch [System.UnauthorizedAccessException]
  {
    if (Test-Path $Source -PathType Container)
    {
      New-Item -ItemType Junction -Path $Target -Target $Source | Out-Null
      Write-Host "Junction $Target -> $Source"
    }
    else
    {
      New-Item -ItemType HardLink -Path $Target -Target $Source | Out-Null
      Write-Host "Hard linked $Target -> $Source"
    }
  }
}

$NvimSource = Join-Path $DotfilesDir "shared\nvim\.config\nvim"
$NvimTarget = Join-Path $env:LOCALAPPDATA "nvim"

New-Symlink -Source $NvimSource -Target $NvimTarget

$IdeaVimSource = Join-Path $DotfilesDir "shared\jetbrains\.ideavimrc"
$IdeaVimTarget = Join-Path $HOME ".ideavimrc"

if (Test-Path $IdeaVimSource)
{
  New-Symlink -Source $IdeaVimSource -Target $IdeaVimTarget
}

# shared\AGENTS.md is the single source of truth shared across agents.
# Windows can't reliably check out the in-repo symlinks, so point each tool's
# expected path directly at the real shared\AGENTS.md.
$AgentsSource = Join-Path $DotfilesDir "shared\AGENTS.md"
if (Test-Path $AgentsSource)
{
  New-Symlink -Source $AgentsSource -Target (Join-Path $HOME ".claude\CLAUDE.md")
  New-Symlink -Source $AgentsSource -Target (Join-Path $HOME ".codex\AGENTS.md")
  New-Symlink -Source $AgentsSource -Target (Join-Path $HOME ".config\opencode\AGENTS.md")
}



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

$GlazeWmSource = Join-Path $DotfilesDir "windows\glazewm\config.yaml"
$GlazeWmTarget = Join-Path $HOME ".glzr\glazewm\config.yaml"

if (Test-Path $GlazeWmSource)
{
  New-Symlink -Source $GlazeWmSource -Target $GlazeWmTarget
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

function Get-VsDevCmd
{
  $VsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
  if (Test-Path $VsWhere)
  {
    $InstallPath = & $VsWhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
    if ($InstallPath)
    {
      $VsDevCmd = Join-Path $InstallPath "Common7\Tools\VsDevCmd.bat"
      if (Test-Path $VsDevCmd) { return $VsDevCmd }
    }
  }

  $KnownRoots = @(
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Community",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Professional",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\Enterprise",
    "${env:ProgramFiles}\Microsoft Visual Studio\2022\BuildTools"
  )

  foreach ($Root in $KnownRoots)
  {
    if (-not $Root) { continue }
    $VsDevCmd = Join-Path $Root "Common7\Tools\VsDevCmd.bat"
    if (Test-Path $VsDevCmd) { return $VsDevCmd }
  }

  return $null
}

$WezGui = "C:\Program Files\WezTerm\wezterm-gui.exe"
if (Test-Path $WezGui)
{
  $StartPrograms = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
  $VsDevCmd = Get-VsDevCmd

  $WezShortcuts = @(
    @{
      Name = "WezTerm PowerShell.lnk"
      Arguments = "start --always-new-process -- pwsh.exe -NoLogo"
    },
    @{
      Name = "WezTerm WSL.lnk"
      Arguments = "start --always-new-process -- wsl.exe --cd ~"
    }
  )

  if ($VsDevCmd)
  {
    $MsvcPwsh = Join-Path $DotfilesDir "windows\wezterm\msvc-x64-pwsh.cmd"
    $WezShortcuts[0].Arguments = "start --always-new-process -- cmd.exe /k `"$MsvcPwsh`""
    $WezShortcuts += @{
      Name = "WezTerm MSVC x64 PowerShell.lnk"
      Arguments = "start --always-new-process -- cmd.exe /k `"$MsvcPwsh`""
    }
    $WezShortcuts += @{
      Name = "WezTerm Plain PowerShell.lnk"
      Arguments = "start --always-new-process -- pwsh.exe -NoLogo"
    }
  }
  else
  {
    Write-Warning "Visual Studio x64 C++ tools were not found; skipping WezTerm MSVC shortcut."
  }

  foreach ($Shortcut in $WezShortcuts)
  {
    New-AppShortcut `
      -Path (Join-Path $StartPrograms $Shortcut.Name) `
      -Target $WezGui `
      -Arguments $Shortcut.Arguments
  }
}

$WinRoot = Join-Path $DotfilesDir "windows"
if (Test-Path $WinRoot)
{
  Get-ChildItem -Path $WinRoot -Directory | ForEach-Object {
    Write-Host "Windows package available: $($_.Name)"
  }
}

Write-Host "Done."
