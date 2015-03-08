package cordova.navigator;
//
// works with org.apache.cordova.device-orientation
//
@:native("navigator.compass")
extern class Compass {
	
	static function getCurrentHeading (success:CompassHeading -> Void, error:CompassError -> Void, ?options:CompassOptions):Void;
	static function watchHeading (success:CompassHeading -> Void, error:CompassError -> Void, ?options:CompassOptions):Dynamic;
	static function clearWatch (watchID:Dynamic):Void;
	
}
//
@:native("CompassError")
extern class CompassError {	
	static var COMPASS_INTERNAL_ERR:CompassErrorConstant;   // =0;
	static var COMPASS_NOT_SUPPORTED:CompassErrorConstant;  // =20;
	public var code:CompassErrorConstant;
}
extern interface CompassErrorConstant { }
//
//
typedef CompassHeading = {	
	var magneticHeading:Float;
	var trueHeading:Float;
	var headingAccuracy:Float;
	var timestamp:Int;	
}
typedef CompassOptions = {	
	@:optional var frequency:Int;
	@:optional var filter:Float;	
}