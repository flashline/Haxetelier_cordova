package cordova.navigator;
//
// works with org.apache.cordova.camera
//
@:native("navigator.camera")
extern class Camera {
	
	static function getPicture (success:String -> Void, error:String -> Void, ?options:CameraOptions):Void;
	static function cleanup (success:Void -> Void, error:String -> Void):Void;
		
}
@:native("Camera.DestinationType")
extern class DestinationType {	
	static var DATA_URL;
	static var FILE_URI;	
}

class PopoverArrowDirection  {	
	static var ARROW_UP = 1;
	static var ARROW_DOWN = 2;
	static var ARROW_LEFT = 4;
	static var ARROW_RIGHT = 8;
	static var ARROW_ANY = 15;
	
}
typedef CameraOptions = {
	
	@:optional var quality:Float;
	@:optional var destinationType:DestinationType;
	@:optional var sourceType:PictureSourceType;
	@:optional var allowEdit:Bool;
	@:optional var encodingType:EncodingType;
	@:optional var targetWidth:Int;
	@:optional var targetHeight:Int;
	@:optional var mediaType:MediaType;
	@:optional var correctOrientation:Bool;
	@:optional var saveToPhotoAlbum:Bool;
	@:optional var popoverOptions:CameraPopoverOptions;
	
}



@:fakeEnum(Int)
enum PictureSourceType {	
	PHOTOLIBRARY;
	CAMERA;
	SAVEDPHOTOALBUM;
	
}

@:fakeEnum(Int)
enum EncodingType {
	
	JPEG;
	PNG;
	
}

@:fakeEnum(Int)
enum MediaType {
	
	PICTURE;
	VIDEO;
	ALLMEDIA;
	
}

typedef CameraPopoverOptions = {
	
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var width:Float;
	@:optional var height:Float;
	@:optional var arrowDir:Int;
	
}
