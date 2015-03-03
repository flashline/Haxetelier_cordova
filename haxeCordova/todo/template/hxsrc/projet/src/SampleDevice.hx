/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
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
		
		//
		if (callback != null) callback(); 
	}

}