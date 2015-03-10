/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordovax.Device;
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.device 
//
/**
* root class
*/
//
class SampleDevice {
	var g:Global;
	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g = Global.get();
		callback = cb; 
		//
		var str = "";
		str+=("Infos sur l'appareil :"+"<br/>");
		str+=("Mod&egrave;le : "   	+  Device.model +"<br/>");
		str+=("Cordova version : "   	+  Device.cordova +"<br/>");
		str+=("Plateforme : "   	+  Device.platform +"<br/>");
		str+=("Version syst&egrave;me : "   	+  Device.version +"<br/>");
		str += ("Id. Unique Universel : <br/>"   	+  Device.uuid +"<br/>");
		trace(str);
		//
		if (callback != null) callback(); 
	}

}