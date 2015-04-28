echo on
:: change this application name
SET APPNAME=Cordovasample
::
cd platforms/android/ant-build/
del apixkey.keystore
keytool -genkey -v -keystore apixkey.keystore -alias apixkey -keyalg RSA -keysize 2048 -validity 10000
rem remember alias=apixkey and password you have been entered
pause
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore apixkey.keystore %APPNAME%-release-unsigned.apk apixkey
rem look if jarsigner is ok 
pause
zipalign -f -v 4 %APPNAME%-release-unsigned.apk %APPNAME%.apk
rem if no error...
rem ... platforms/android/ant-build/%APPNAME% is released.
cd ../../..