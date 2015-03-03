:: change with your cordova devs global path 
:: 	not used if it's where start.bat is :: 
::cd C:\www\cordova\uicompo\
:: change with your < java , apache ant , android sdk > install paths 
SET PATH=%PATH%;C:\progra~1\Java\jdk1.6.0_45\bin
SET PATH=%PATH%;C:\progra~1\Java\jre6\bin;C:\Progra~1\wamp\bin\apache\ant\bin;C:\progra~1\Android\android-sdk\tools;C:\progra~1\Android\android-sdk\platform-tools
:: change with your android sdk install path 
SET emulPath=C:\progra~1\Android\android-sdk\platform-tools\adb.exe
::start cmd mode
::C:\WINDOWS\system32\cmd.exe /k
:: OR
::  start cmd mode with nodejs
C:\WINDOWS\system32\cmd.exe /k "C:\Progra~1\nodejs\nodevars.bat"