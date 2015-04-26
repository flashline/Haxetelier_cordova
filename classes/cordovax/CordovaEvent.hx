package cordovax;
import js.html.Event;
//
// works with org.apache.cordova.network-information for online/offline
//       with org.apache.cordova.battery-status for battery*
//
class CordovaEvent extends Event {
	static public inline var DEVICE_READY:String = "deviceready";
	static public inline var PAUSE:String = "pause";
	static public inline var RESUME:String = "resume";
	static public inline var BACK_BUTTON:String = "backbutton";
	static public inline var MENU_BUTTON:String = "menubutton";
	static public inline var SEARCH_BUTTON:String = "searchbutton";
	static public inline var START_CALL_BUTTON:String = "startcallbutton";
	static public inline var END_CALL_BUTTON:String = "endcallbutton";
	static public inline var VOLUME_DOWN_BUTTON:String = "volumedownbutton";
	static public inline var VOLUME_UP_BUTTON:String = "volumeupbutton";
	//
	static public inline var BATTERY_STATUS:String = "batterystatus";
	static public inline var BATTERY_CRITICAL:String = "batterycritical";
	static public inline var BATTERY_LOW:String = "batterylow";
	//
	static public inline var ON_LINE:String = "online";
	static public inline var OFF_LINE:String = "offline";
}
class BatteryStatusEvent {	
	//
	/**
	 * The percentage of battery charge (0-100)
	 */
	public var level:Float;
	/**
	 * indicates whether the device is plugged in
	 */
	public var isPlugged:Bool;
}