Set-Alias -Name touch -Value New-Item

if (Get-Module -ListAvailable -Name PSReadLine)
{
  Set-PSReadLineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit
}

Invoke-Expression (&starship init powershell)

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
