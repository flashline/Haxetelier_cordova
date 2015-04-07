/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordovax.Console;
import cordovax.File;
import cordovax.navigator.Capture;
import js.Browser;
import js.html.AudioElement;
import js.html.ButtonElement;
import js.html.MouseEvent;
import js.html.StyleElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.media-capture
/**
* root class
*/
class SampleCaptureAudio	 {
	var g:Global;
	var bt:ButtonElement;
 	var callback:Dynamic;
	var mediaFiles:Array<MediaFile>;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		bt=cast(createHtmlCss());
		bt.addEventListener("click", onClick);
		if (callback != null) 	callback();
		//		
		//trace("version 5");
	}	
	function onClick (e:MouseEvent) {		
		Capture.captureAudio(onAudioSuccess, onAudioError, { limit: 2 } ); 
	}
	function onAudioSuccess(mf:Array<MediaFile>) {
		mediaFiles = mf;
		bt.style.display = "none";
		"#audioCtnr .play".get().style.display = "block";
		"#audioCtnr .play".get().addEventListener("click", onPlay);
			
	}
	function onAudioError(e:CaptureError) {
		var arr:Array<String> = []; 
		arr[CaptureError.CAPTURE_APPLICATION_BUSY	] =  "L'application de capture cam&eacute;ra / audio est actuellement une autre demande de capture." ;
		arr[CaptureError.CAPTURE_INTERNAL_ERR		] =  "La cam&eacute;ra ou un microphone a &eacute;chou&eacute; à capturer l'image ou le son." ;
		arr[CaptureError.CAPTURE_INVALID_ARGUMENT	] =  "Utilisation incorrecte de l'API (par exemple, la valeur de limit est inf&eacute;rieur à 1)." ;
		arr[CaptureError.CAPTURE_NO_MEDIA_FILES		] =  "L'utilisateur a quitt&eacute; l'application capture audio sans aucun enregistrement." ;
		arr[CaptureError.CAPTURE_NOT_SUPPORTED		] =  "L'op&eacute;ration de capture demand&eacute;e n'est pas pris en charge." ;			
		arr[e.code].alert();
	}
	
	function onPlay(e:MouseEvent) {
		if (mediaFiles == null || mediaFiles == []) "Auncun son enregistr&eacute; ! ".alert();
		else {
			for (mf in mediaFiles) {
			   playOneFile(mf.fullPath,mf.name) ;
			}
		}
	}
	
	function playOneFile(src:String,name:String) {
		//var ply:AudioElement = cast(("#audioCtnr .player".get())).cloneNode();
		//"#audioCtnr".get().appendChild(ply);
		//not ok : ply.src = src ;
		//not ok : ply.src = File.externalRootDirectory + "My%20Documents/My%20Recordings/" + name ;
		ply.src =  "http://www.pixaline.net/intra/cordosample/sound/test.amr"; //ok : 
		//
		trace("ply.src=" + ply.src);
		//i.e.     file:/mnt/sdcard/My%20Documents/My%20Recordings/Voix0022.amr
		//ply.play();
	}
	
	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='audioCtnr'>";
		str += 		"<audio class='player'>Audio not supported</audio>";
		str += 		"<button class='button record' type='button' >Enregistrement Audio</button>";
		str += 		"<button class='button play'   type='button' >Jouer</button>";
		str += "</div>";
		var el="div".createElem(); 
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		//
		// append css		
		var css = "";
		css += "#audioCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"width:100%;";		
		css += "}";		
		css += "#audioCtnr .button  {";
		css += 		"display:block;";
		css += 		"width:80%;";		
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";	
		css += 		"font-size:2em;";
		css += "}";		
		css += "#audioCtnr .play  {";
		css += 		"display:none;";	
		css += "}";		
		var head = Browser.document.head; 
		var styleEl:StyleElement = cast("style".get(head)) ;
		if ( styleEl== null) {
			Browser.document.head.appendChild("style".createElem());
			styleEl = cast("style".get(head)) ;
		}
		//
		styleEl.innerHTML += css;
		return "#audioCtnr .record".get();
	}	
}