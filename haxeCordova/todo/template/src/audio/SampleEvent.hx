/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordovax.Console;
import cordovax.CordovaEvent;
import cordovax.File;
//
import cordovax.navigator.Notification;
import cordovax.navigator.App;
import js.Browser;
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.dialogs for alert,etc
// DO NOT FORGET org.apache.cordova.network-information for online/offline
// DO NOT FORGET org.apache.cordova.battery-status for battery
//
//
// DO NOT FORGET TO REMOVE windows add evt list in index.js
/**
* root class
*/
//
class SampleEvent {
	var g:Global;
 	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb; 
		//
		//
		Browser.document.addEventListener(CordovaEvent.BACK_BUTTON, onBackButton) ; 
		if (g.isMobile) {
			/* external */
			/* test or use these 3 directories when pc and mobile are disconnected by cable */
				/* Application space on external storage. (Android) */
				/*   ie: file:///mnt/sdcard/Android/data/net.pixaline.myAppName/ */
				// comment to be removed // trace("File.externalApplicationStorageDirectory=" + File.externalApplicationStorageDirectory);
				/* Where to put app-specific data files on external storage. (Android) */
				/*   ie: file:///mnt/sdcard/Android/data/net.pixaline.myAppName/files/ */					
				trace("File.externalDataDirectory=" + File.externalDataDirectory);
				/* where to read other app writing. External storage (SD card) root. (Android, BlackBerry 10) */
				/*   ie: file:///mnt/sdcard/ */					
				trace("File.externalRootDirectory="+File.externalRootDirectory); // comment to be removed // 
			/* local cordova */
				/* where app is installed -readonly- */
				/*   ie: file:///android_asset/   -where  www/ is : file:///android_asset/www/index.html */					
				// comment to be removed // trace("File.applicationDirectory="+File.applicationDirectory);
				//
				/* these are write-enable only when pc and mobile are connected by cable */
					/* Root directory of the application's sandbox; */
					/*   ie: file:///data/data/net.pixaline.myAppName/ */					
					// comment to be removed // trace("File.applicationStorageDirectory=" + File.applicationStorageDirectory);
					/* Persistent and private data storage within the application's sandbox using internal memory (on Android, if you need to use external memory, use .externalDataDirectory). On iOS, this directory is not synced with iCloud (use .syncedDataDirectory). (iOS, Android, BlackBerry 10)*/
					/*   ie: file:///data/data/net.pixaline.myAppName/files */					
					// comment to be removed // trace("File.dataDirectory=" + File.dataDirectory);
		}
		//
		if (callback != null) callback(); 
		//
	}
	
	function onBackButton (e:CordovaEvent) {	
		 Pop.confirm ("Confirmer ? ",onBackValid,"Fermeture de l'application",["Sortir","Rester"]) ;
	}
	function onBackValid (idx:Int) {	
		([close, function() { Pop.alert("Heureux de continuer avec vous ! ") ; } ][idx - 1])() ;
	}
	function close () {	
		 App.exitApp();
	}
}