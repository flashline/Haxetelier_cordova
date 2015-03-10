package cordovax.navigator;
//
// works with org.apache.cordova.media-capture
//
@:native("navigator.device.capture")
extern class Capture {
	
	static var supportedAudioModes:Array <ConfigurationData>;
	static var supportedImageModes:Array <ConfigurationData>;
	static var supportedVideoModes:Array <ConfigurationData>;
	
	static function captureAudio (success:Array <MediaFile> -> Void, error:CaptureError -> Void, ?options:CaptureAudioOptions):Void;
	static function captureImage (success:Array <MediaFile> -> Void, error:CaptureError -> Void, ?options:CaptureImageOptions):Void;
	static function captureVideo (success:Array <MediaFile> -> Void, error:CaptureError -> Void, ?options:CaptureVideoOptions):Void;
	
}
@:native("CaptureError")
extern class CaptureError  {	
	static var CAPTURE_INTERNAL_ERR:CaptureErrorConstant; 		// 0; 	
	static var CAPTURE_APPLICATION_BUSY:CaptureErrorConstant; 	// 1;
	static var CAPTURE_INVALID_ARGUMENT:CaptureErrorConstant; 	// 2;
	static var CAPTURE_NO_MEDIA_FILES:CaptureErrorConstant; 	// 3;	
	static var CAPTURE_NOT_SUPPORTED:CaptureErrorConstant; 		// 20;
	//
	var code:CaptureErrorConstant;	
}
extern interface CaptureErrorConstant { }
//
//
extern class MediaFile {	
	var name:String;
	var fullPath:String;
	var type:String;
	var lastModifiedDate:Date;
	var size:Int;
	//
	function getFormatData(success:MediaFileData -> Void, error:Void -> Void) : Void;	
}
typedef ConfigurationData  = {	
	var type:String;
	var height:Int;
	var width:Int;	
}
typedef MediaFileData  = {	
	var codecs:String;
	var bitrate:Float;
	var height:Int;
	var width:Int;
	var duration:Int;	
}
typedef CaptureAudioOptions  = {	
	@:optional var limit:Int;
	@:optional var duration:Float;
	@:optional var mode:ConfigurationData;	
}
typedef CaptureImageOptions  = {	
	@:optional var limit:Int;
	@:optional var mode:ConfigurationData;	
}

typedef CaptureVideoOptions  = {	
	@:optional var limit:Int;
	@:optional var duration:Int;
	@:optional var mode:ConfigurationData;	
}