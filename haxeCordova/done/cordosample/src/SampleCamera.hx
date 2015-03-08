/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordova.navigator.Camera;
import haxe.Timer;
import js.Browser;
import js.html.ButtonElement;
import js.html.Event;
import js.html.ImageElement;
import js.html.MouseEvent;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.camera
/**
* root class
*/
class SampleCamera {
	var g:Global;
	var bt:ButtonElement;
 	var img:ImageElement;
 	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		createButton();
		createEmptyImg ();
		bt.addEventListener("click", onClick);
		if (callback != null) 	callback();
	}	
	function onClick (e:MouseEvent) {
		if (g.isMobile) Camera.getPicture(onCamSuccess, onCamError, { targetWidth:400, targetHeight:400 ,quality: 50, destinationType: DestinationType.DATA_URL } );			
		else  img.src = "img/photo.jpg";  
	}
	function onCamSuccess(imageData) {
		img.src = "data:image/jpeg;base64," + imageData;	
	}
	function onCamError(m:String) {
		("Erreur photo : " + m).alert() ;
	}
	function createButton () {		
		bt = cast("button".createElem());
		"#appHtmlCtnr".get().appendChild(bt);
		bt.style.fontSize = "2em";
		bt.style.marginTop = "2em";
		bt.style.display = "block";
		bt.style.marginLeft = "auto";
		bt.style.marginRight = "auto";
		bt.type = "button";
		bt.textContent = "Prendre une photo";		
	}	
	function createEmptyImg () {		
		img = cast("img".createElem());
		"#appHtmlCtnr".get().appendChild(img);
		img.style.marginTop = "2em";
		img.style.width = "400px";
		img.style.height = "auto";
		img.style.display = "block";
		img.style.marginLeft = "auto";
		img.style.marginRight = "auto";			
	}	
	
}