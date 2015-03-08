package cordova.navigator;

@:native("navigator.app") 
extern class App {	
	public static function exitApp () : Void;
}
@:native("navigator") 
extern class Navigator {	
	@:overload(function(durArray:Array<Int>):Void {})
	public static function vibrate (dur:Int):Void;
}

