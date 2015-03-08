/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.tools.math.GeoLoc;
import apix.common.util.Global;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.geolocation
//
/**
* root class
*/
class SampleGeolocation {
	var g:Global;
 	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		//here	
	}	
	
	
}