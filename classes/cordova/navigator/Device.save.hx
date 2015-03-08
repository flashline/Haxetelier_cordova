package cordova.navigator;
//
// works with org.apache.cordova.device
//
@:native("window.device")
extern class Device {
	
	static var model:String;
	static var cordova:String;
	static var platform:String;
	static var uuid:String;
	static var version:String;
	static var name:String;
	
}