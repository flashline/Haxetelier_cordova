package cordova.navigator;
//
// works with org.apache.cordova.dialogs
//
@:native("navigator.notification")
extern class Pop {	
	static function alert (msg:String,?cb:Void->Void,?title:String,?buttonLabel:String):Void;
	static function confirm (msg:String,cb:Int->Void,?title:String,?buttonLabelArray:Array<String>):Void;
	static function prompt (msg:String,cb:PromptResult->Void,?title:String,?buttonLabelArray:Array<String>,?defInput:String):Void;
	static function beep (?times:Int):Void;		
}
typedef PromptResult = {
    var buttonIndex : Int;
	var input1:String;
}
