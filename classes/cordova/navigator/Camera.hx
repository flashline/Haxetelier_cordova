package cordova.navigator;
//
// works with org.apache.cordova.camera
//
@:native("navigator.camera")
extern class Camera {	
	static function getPicture (success:String -> Void, error:String -> Void, ?options:CameraOptions):Void;
	static function cleanup (success:Void -> Void, error:String -> Void):Void;		
}
//
//
@:native("Camera.DestinationType")
extern class DestinationType {	
	static var DATA_URL:DestinationTypeConstant; //=0
	static var FILE_URI:DestinationTypeConstant; //=1
}
extern interface DestinationTypeConstant {}
//
@:native("Camera.PopoverArrowDirection")
extern class PopoverArrowDirection  {	
	static var ARROW_UP:PopoverArrowDirectionConstant; 		//= 1
	static var ARROW_DOWN:PopoverArrowDirectionConstant; 	//= 2
	static var ARROW_LEFT:PopoverArrowDirectionConstant; 	//= 4
	static var ARROW_RIGHT:PopoverArrowDirectionConstant; 	//= 8
	static var ARROW_ANY:PopoverArrowDirectionConstant; 	//= 15	
}
extern interface PopoverArrowDirectionConstant {}
//
@:native("Camera.PictureSourceType")
extern class PictureSourceType  {	
	static var PHOTOLIBRARY:PictureSourceTypeConstant; 		//= 0
	static var CAMERA:PictureSourceTypeConstant; 			//= 1
	static var SAVEDPHOTOALBUM:PictureSourceTypeConstant; 	//= 2
}
extern interface PictureSourceTypeConstant {}
//
@:native("Camera.EncodingType")
extern class EncodingType  {	
	static var JPEG:EncodingTypeConstant; 		//= 0
	static var PNG:EncodingTypeConstant; 		//= 1
}
extern interface EncodingTypeConstant {}
//
@:native("Camera.MediaType")
extern class MediaType  {	
	static var PICTURE:MediaTypeConstant; 		//= 0
	static var VIDEO:MediaTypeConstant; 		//= 1
	static var ALLMEDIA:MediaTypeConstant; 		//= 2
}
extern interface MediaTypeConstant {}
//
//
typedef CameraOptions = {	
	@:optional var quality:Float;
	@:optional var destinationType:DestinationTypeConstant;
	@:optional var sourceType:PictureSourceTypeConstant;
	@:optional var allowEdit:Bool;
	@:optional var encodingType:EncodingTypeConstant;
	@:optional var targetWidth:Int;
	@:optional var targetHeight:Int;
	@:optional var mediaType:MediaTypeConstant;
	@:optional var correctOrientation:Bool;
	@:optional var saveToPhotoAlbum:Bool;
	@:optional var popoverOptions:CameraPopoverOptions;	
}
typedef CameraPopoverOptions = {	
	@:optional var x:Float;
	@:optional var y:Float;
	@:optional var width:Float;
	@:optional var height:Float;
	@:optional var arrowDir:PopoverArrowDirectionConstant;
	
}
