Set-Alias -Name touch -Value New-Item

Invoke-Expression (&starship init powershell)

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
