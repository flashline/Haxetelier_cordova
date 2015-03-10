package cordova;
//
// works with org.apache.cordova.console -but not necessary for android
//
/**
 * to use with JsConsole :
 * 		go to 
 * 			http://jsconsole.com/ 
 * 		enter 
 * 			:listen
 * 		copy/paste given line like
 * 			<script src="http://jsconsole.com/remote.js?FAE031CD-74A0-46D3-AE36-757BAB262BEA"></script>
 * 		into <head> of index.html
 * 		... messages from mobile will be displayed on connected main computer in jsconsole.com page.
 */
@:native("console") 
extern class Console {	
	public static function log(msg: String):Void;
}
