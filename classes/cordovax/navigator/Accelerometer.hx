package cordovax.navigator;


@:native("navigator.accelerometer")
extern class Accelerometer {	
	static function getCurrentAcceleration (success:Acceleration -> Void, error:Void -> Void):Void;
	static function watchAcceleration (success:Acceleration -> Void, error:Void -> Void, ?options:AccelerometerOptions):Dynamic;
	static function clearWatch (watchID:Dynamic):Void;
}
//
typedef Acceleration = {	
	var x:Float;
	var y:Float;
	var z:Float;
	var timestamp:Int;	
}
typedef AccelerometerOptions = {	
	var frequency:Int;	
}
