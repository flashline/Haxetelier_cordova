echo on
:: change this application name
SET APPNAME=Cordovasample
::
rem enter any key to launch build release
rem after that if no error => launch makeApk.bat
pause
cordova build --release android

