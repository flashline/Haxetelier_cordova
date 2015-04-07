REM start Cordova dev environment
echo off
::
:: change with your < java , apache ant , android sdk > install paths 
SET PATH=%PATH%;C:\Program Files\Java\jdk1.8.0_40\bin
SET PATH=%PATH%;C:\Program Files\Java\jre1.8.0_40\bin;C:\Program Files\wamp\bin\apache\ant\bin;C:\Program Files (x86)\Android\android-sdk\tools;C:\Program Files (x86)\Android\android-sdk\platform-tools
:: change with your android sdk install path 
SET emulPath=C:\Program Files (x86)\Android\android-sdk\platform-tools\adb.exe
::start cmd mode
::C:\WINDOWS\system32\cmd.exe /k
:: OR
::  start cmd mode with nodejs
C:\Windows\System32\cmd.exe /k "C:\Program Files\nodejs\nodevars.bat"
