/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
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
		if (callback != null) callback(); 
		//
	}
	
}