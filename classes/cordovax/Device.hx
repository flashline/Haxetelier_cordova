package cordovax;
//
// works with org.apache.cordova.device
//
/**
 * Device is not : "@:native('window.device') extern"
 * to include "orientation" and "orientationMode" in this class.
 */
class Device {	
	public static var model(get, null):String;	
	public static var cordova(get, null):String;
	public static var platform(get, null):String;
	public static var uuid(get, null):String;
	public static var version(get, null):String;
	public static var name(get, null):String;	
	//
	static function get_model () :String return untyped __js__ ("window.device.model") ;
	static function get_cordova () :String return untyped __js__ ("window.device.cordova") ;
	static function get_platform () :String return untyped __js__ ("window.device.platform") ;
	static function get_uuid () :String return untyped __js__ ("window.device.uuid") ;
	static function get_version () :String return untyped __js__ ("window.device.version") ;
	static function get_name () :String return untyped __js__ ("window.device.name") ;
	//
	public static var orientationMode(get, null):OrientationMode ;
	static function get_orientationMode () :OrientationMode {
		if (Math.abs(orientation) == 90 ) return OrientationMode.LANDSCAPE;
		else return OrientationMode.PORTRAIT ;
	}
	//
	public static var orientation(get, null):Int ;
	static function get_orientation () :Int return untyped __js__ ("window.orientation") ;
	//
	public static var portrait(get, null):Bool ;
	static function get_portrait () :Bool return orientationMode==OrientationMode.PORTRAIT;
}
//
@:enum
abstract OrientationMode (String) {
	var PORTRAIT="portrait";
	var LANDSCAPE="landscape";
}
