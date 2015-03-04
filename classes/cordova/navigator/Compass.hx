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

typedef CompassHeading = {	
	var magneticHeading:Float;
	var trueHeading:Float;
	var headingAccuracy:Float;
	var timestamp:Int;	
}
extern class CompassError {	
	static inline var COMPASS_INTERNAL_ERR:Int=0;
	static inline var COMPASS_NOT_SUPPORTED:Int=20;
	public var code:Int;
}

typedef CompassOptions = {	
	@:optional var frequency:Int;
	@:optional var filter:Float;	
}