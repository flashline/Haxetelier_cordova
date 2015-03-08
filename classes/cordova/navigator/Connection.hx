package cordova.navigator;
//
// works with org.apache.cordova.network-information
//
#if (cordova23) 
@:native("navigator.network.connection") // cordova version before 2.3
#else 
@:native("navigator.connection") 
#end
extern class Connection {	
	static inline var UNKNOWN:String="unknown";
	static inline var ETHERNET:String= "ethernet";
	static inline var WIFI:String= "wifi";
	static inline var CELL_2G:String= "2g";
	static inline var CELL_3G:String= "3g";
	static inline var CELL_4G:String= "4g";
	static inline var NONE:String = "none";	
	static var type:String;
}