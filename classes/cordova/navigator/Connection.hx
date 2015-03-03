package cordova.navigator;


@:native ("navigator.network.Connection")
extern class Connection {
	
	static var UNKNOWN:Dynamic;
	static var ETHERNET:Dynamic;
	static var WIFI:Dynamic;
	static var CELL_2G:Dynamic;
	static var CELL_3G:Dynamic;
	static var CELL_4G:Dynamic;
	static var NONE:Dynamic;
	
	static var type:Dynamic;
	
}