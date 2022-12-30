# Invoke-Mathfuscation
A quick command line utility that generates uses simple addition to obfuscate individual characters, then executes it

When prompted, specify a command to invoke, remote URL or full local path to a .ps1 file. 

Example: 
```Write-Host "Hello world!"``` using 6000 as an offset:
```powershell
@(6087,6114,6105,6116,6101,6045,6072,6111,6115,6116,6032,6034,6072,6101,6108,6108,6111,6032,6119,6111,6114,6108,6100,6033,6034)| % {$wdAQf=$wdAQf+[char]($_-6000)};.(gcm ?e[?x])($wdAQf)
```
