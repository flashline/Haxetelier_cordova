/**
 * Copyright (c) jm Delettre.
 */
/**
* app root package
*/
package;
/**
* classes imports
*/

import apix.common.util.Global;
import cordova.CordovaEvent;
import js.Browser;
import js.html.Element;

import cordova.navigator.Device;
//
//
using apix.common.util.StringExtender;
/**
* root class
*/
class Main {
	static var g:Global; 	
	
	function new () {	
		var str = "";
		str += ("hello" + "\n");
		trace(str);
		deviceTest ();	 
	}	
	function onBatteryStatus(info:Dynamic) {		
		js.Lib.alert("toto");
	}
	function deviceTest () {
		var str = "";
		str+=("Infos sur l'appareil :"+"\n");
		str+=("Mod&egrave;le : "   	+ Device.model +"\n");
		str+=("Cordova version : "   	+ Device.cordova +"\n");
		str+=("Plateforme : "   	+ Device.platform +"\n");
		str+=("Version syst&egrave;me : "   	+ Device.version +"\n");
		str += ("Identifiant Unique Universel : "   	+ Device.uuid +"\n");
		trace(str);
		
		Browser.window.addEventListener("batterystatus", onBatteryStatus, false);
	}
	static function main() {  	
		g=Global.get();
		g.setupTrace("appHtmlCtnr");	
		new Main();
	}	
	
}