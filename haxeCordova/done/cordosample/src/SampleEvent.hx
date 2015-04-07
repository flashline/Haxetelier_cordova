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
		Browser.window.addEventListener(CordovaEvent.BATTERY_STATUS, onBatteryStatus, false);
		//
		Browser.document.addEventListener(CordovaEvent.PAUSE,onPause) ; 
		Browser.document.addEventListener(CordovaEvent.RESUME, onResume) ; 
		Browser.document.addEventListener(CordovaEvent.MENU_BUTTON, onMenuButton) ; 
		Browser.document.addEventListener(CordovaEvent.SEARCH_BUTTON, onSearchButton) ; 
		Browser.document.addEventListener(CordovaEvent.OFF_LINE, onOffLine) ; 
		Browser.document.addEventListener(CordovaEvent.BACK_BUTTON, onBackButton) ; 
		// Not ok on my phone. To test on my tablet
		// Browser.document.addEventListener(CordovaEvent.START_CALL_BUTTON, onStartCall) ; 
		// Browser.document.addEventListener(CordovaEvent.END_CALL_BUTTON, onEndCall) ; 
		// Browser.document.addEventListener(CordovaEvent.VOLUME_DOWN_BUTTON, onVolumeDown) ; 
		// Browser.document.addEventListener(CordovaEvent.VOLUME_UP_BUTTON, onVolumeUp) ;
		//
		if (g.isMobile) {
			if (false) {
				Console.log("Test de console.log() avec jsConsole.com");
				Console.log("File.applicationDirectory="+File.applicationDirectory);
				Console.log("File.applicationStorageDirectory="+File.applicationStorageDirectory);
				Console.log("File.dataDirectory="+File.dataDirectory);
				Console.log("File.cacheDirectory=" + File.cacheDirectory);
			} 
			else {
				/* external */
				/* test or use these 3 directories when pc and mobile are disconnected by cable */
					/* Application space on external storage. (Android) */
					/*   ie: file:///mnt/sdcard/Android/data/net.pixaline.myAppName/ */
					trace("File.externalApplicationStorageDirectory=" + File.externalApplicationStorageDirectory);
					/* Where to put app-specific data files on external storage. (Android) */
					/*   ie: file:///mnt/sdcard/Android/data/net.pixaline.myAppName/files/ */					
					trace("File.externalDataDirectory=" + File.externalDataDirectory);
					/* where to read other app writing. External storage (SD card) root. (Android, BlackBerry 10) */
					/*   ie: file:///mnt/sdcard/ */					
					trace("File.externalRootDirectory="+File.externalRootDirectory);
				/* local cordova */
					/* where app is installed -readonly- */
					/*   ie: file:///android_asset/   -where  www/ is : file:///android_asset/www/index.html */					
					// trace("File.applicationDirectory="+File.applicationDirectory);
					//
					/* these are write-enable only when pc and mobile are connected by cable */
						/* Root directory of the application's sandbox; */
						/*   ie: file:///data/data/net.pixaline.myAppName/ */					
						//trace("File.applicationStorageDirectory=" + File.applicationStorageDirectory);
						/* Persistent and private data storage within the application's sandbox using internal memory (on Android, if you need to use external memory, use .externalDataDirectory). On iOS, this directory is not synced with iCloud (use .syncedDataDirectory). (iOS, Android, BlackBerry 10)*/
						/*   ie: file:///data/data/net.pixaline.myAppName/files */					
						//trace("File.dataDirectory=" + File.dataDirectory);
				
			}
			
		}
		//
		if (callback != null) callback(); 
		//
	}
	function onBatteryStatus(info:BatteryStatusEvent) {			
		var str = "Etat de la batterie :<br/>";
		str += "Niveau (%) : "+info.level+"<br/>";
		str += "En charge sur secteur ? : "+((info.isPlugged)?"Oui":"Non")+"<br/>";
		str.trace();
	}
	//
	function onPause (e:CordovaEvent) {	
		Pop.beep(1);
	}
	function onResume (e:CordovaEvent) {	
		Pop.alert ("Heureux de vous retrouver :))",function(){Pop.beep(1);}, "Ceci n'est pas un titre", "Ceci est un bouton");
	}
	function onMenuButton (e:CordovaEvent) {	
		Pop.beep(1);
		Pop.alert("Il n'y a pas de menu mais on y travaille :-( ") ;
	}
	function onSearchButton (e:CordovaEvent) {	
		 Pop.prompt ("Mots cl\u00e9s : ",onSearchValid,"Recherche",["Valider","Abandon"],"haxe,cordova") ;
	}
	function onSearchValid (result:PromptResult) {
		var str = "";
		str += "Vous avez cliqu\u00e9 le bouton " + ([ "Valider","Abandon"][result.buttonIndex-1]) + "\n";
		str += "Vous avez saisi ''" + result.input1 + "''\n";
		str += "Je n'ai rien trouv\u00e9 !\nMais je n'ai pas bien cherch\u00e9 non plus ;D";		
		Pop.alert (str); // ou str.alert();
	}
	function onOffLine (e:CordovaEvent) {	
		Pop.beep(2);
		Pop.alert("La connexion Internet est inexistante !") ;	
		Browser.document.removeEventListener(CordovaEvent.OFF_LINE, onOnLine) ; 
		Browser.document.addEventListener(CordovaEvent.ON_LINE, onOnLine) ; 				
	}
	function onOnLine (e:CordovaEvent) {	
		"La connexion Internet est active...".alert();
		Browser.document.removeEventListener(CordovaEvent.ON_LINE, onOnLine) ; 
		Browser.document.addEventListener(CordovaEvent.OFF_LINE, onOnLine) ; 
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