package cordovax.navigator;
//
// works with org.apache.cordova.camera
//
@:native("Media")
extern class Media {	
	static var MEDIA_NONE 		: MediaStatusConstant; // = 0;
	static var MEDIA_STARTING 	: MediaStatusConstant; // = 1;
	static var MEDIA_RUNNING 	: MediaStatusConstant; // = 2;
	static var MEDIA_PAUSED 	: MediaStatusConstant; // = 3;
	static var MEDIA_STOPPED 	: MediaStatusConstant; // = 4;
	static var MEDIA_MSG		: String; // = ["None", "Starting", "Running", "Paused", "Stopped"
	//
	public function new (src:String, success:Void -> Void, ?error: MediaError -> Void, ?statusCallback:MediaStatusConstant->Void):Void;
	//
	function getCurrentPosition (success:Void -> Void, ?error: MediaError -> Void):Void ; //Returns the current position within an audio file.  

	function getDuration ():Void ; //Returns the duration of an audio file.

	function play ():Void ; //Start or resume playing an audio file.

	function pause ():Void ; //Pause playback of an audio file.

	function release ():Void ; //Releases the underlying operating system's audio resources.

	function seekTo (miliSec:Int):Void ; //Moves the position within the audio file.

	function setVolume (value:Float):Void ; //Set the volume for audio playback.

	function startRecord ():Void ; //Start recording an audio file.

	function stopRecord ():Void ; //Stop recording an audio file.

	function stop ():Void; //Stop playing an audio file.
}
extern interface MediaStatusConstant {}
//
@:native("MediaError")
extern class MediaError  {	
	static var MEDIA_ERR_NONE_ACTIVE:Int; 		// 0
	static var MEDIA_ERR_ABORTED:Int; 			// 1; 	
	static var MEDIA_ERR_NETWORK:Int; 			// 2;
	static var MEDIA_ERR_DECODE:Int; 			// 3;
	static var MEDIA_ERR_NONE_SUPPORTED:Int; 	// 4;
	
	//
	var code:Int;
	var message:String;	
}


