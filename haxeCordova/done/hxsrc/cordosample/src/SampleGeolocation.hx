/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.tools.math.GeoLoc;
import apix.common.util.Global;
import cordova.navigator.Geolocation;
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
		Geolocation.getCurrentPosition(onGeolocSuccess, onGeolocError,{enableHighAccuracy:true});		
	}	
	function onGeolocSuccess (position:Position) {		
		var str = "Votre position :<br/>";
		str += "<h1>"+new GeoLoc(position.coords.latitude, position.coords.longitude).toString() +"</h1><br/>";
		str.trace();
		//position.timestamp
		//position.coords.accuracy
		//position.coords.altitudeAccuracy
		//position.coords.heading
		//position.coords.speed
		if (callback != null) callback();
		
	};
	function onGeolocError(error:PositionError) {
		var str = "G\u00e9olocation error:<br/>";
		str += "code: "   		+ error.code+" ";
		str += "message: "      + error.message + " ";
		str.alert();
	}
	
}