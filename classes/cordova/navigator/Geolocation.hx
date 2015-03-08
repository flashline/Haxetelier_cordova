package cordova.navigator;
//
// works with org.apache.cordova.geolocation
//
@:native("navigator.geolocation") 
extern class Geolocation {	
	static function getCurrentPosition (success:Position -> Void, ?error:PositionError -> Void, ?options:GeolocationOptions):Void;
	static function watchPosition (success:Position -> Void, ?error:PositionError -> Void, ?options:GeolocationOptions):String;
	static function clearWatch (watchID:String):Void;
}
extern class PositionError {	
	var code:Int;
	var message:String;	
	static inline var PERMISSION_DENIED:Int=1;
	static inline var POSITION_UNAVAILABLE:Int=2;
	static inline var TIMEOUT:Int = 3;
}
//
typedef Position = {	
	var coords:Coordinates;
	var timestamp:Date;	
}
typedef Coordinates = {	
	var latitude: Float;
	var longitude: Float;
	/**
	 * Height of the position in meters above the ellipsoid.
	 */
	var altitude: Float;
	/**
	 * Accuracy level of the latitude and longitude coordinates in meters. 
	 */
	var accuracy: Int;
	var altitudeAccuracy : Int;
	/**
	 * Direction of travel, specified in degrees counting clockwise relative to the true north. 
	 */
	var heading: Float;
	/**
	 * Current ground speed of the device, specified in meters per second
	 */
	var speed: Float;
}
typedef GeolocationOptions = {	
	/**
	 * Provides a hint that the application needs the best possible results. 
	 * By default, the device attempts to retrieve a Position using network - based methods. 
	 * Setting this property to true tells the framework to use more accurate methods, such as satellite positioning.
	 */	
	@:optional var enableHighAccuracy:Bool; 
	/**
	 * The maximum length of time (milliseconds) that is allowed to pass from the call to navigator.geolocation.getCurrentPosition or geolocation.watchPosition 
	 * until the corresponding geolocationSuccess callback executes. 
	 * If the geolocationSuccess callback is not invoked within this time, the geolocationError callback is passed a PositionError.TIMEOUT error code. 
	 * (Note that when used in conjunction with geolocation.watchPosition, the geolocationError callback could be called on an interval every timeout milliseconds!) 
	 */
	@:optional var timeout: Int; 
	/**
	 * Accept a cached position whose age is no greater than the specified time in milliseconds. 
	 */	
	@:optional var maximumAge:Int; 
}