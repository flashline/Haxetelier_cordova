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
import cordovax.navigator.Media;
import js.Browser;
import js.html.AudioElement;
import js.html.MouseEvent;
import js.html.StyleElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.media , org.apache.cordova.file and org.apache.cordova.media-capture
/**
* root class
*/
class SampleAudioLocal	 {
	var g:Global;
 	var callback:Dynamic;
	var mediaFiles:Array<MediaFile>;
	var media:Media;
	var name:String;
	var path:String;
	static inline var RECORDING_FOLDER = "My%20Documents/My%20Recordings/" ;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		//
		 createHtmlCss();
		if (File.externalApplicationStorageDirectory == null) "#audioCtnr".get().innerHTML = "<h1>Enlever le cable et relancer l'app. !</h1>";
		else {
			"#audioCtnr .record".get().addEventListener("click", onClickRecord);
			"#audioCtnr .play".get().addEventListener("click", onClickPlay);
			"#audioCtnr .stopPlay".get().addEventListener("click", onClickStopPlaying);
		}
		//
		if (callback != null) 	callback();
	}	
	function onClickRecord (e:MouseEvent) {		
		
	}
	function onAudioSuccess(mf:Array<MediaFile>) {
		show(false, true,null); // rec,play,stop
		//		
		
	}
	function onAudioError(e:CaptureError) {
		var arr:Array<String> = []; 
		arr[CaptureError.CAPTURE_APPLICATION_BUSY	] =  "L'application de capture cam\u00e9ra / audio est actuellement une autre demande de capture." ;
		arr[CaptureError.CAPTURE_INTERNAL_ERR		] =  "La cam\u00e9ra ou un microphone a \u00e9chou\u00e9 à capturer l'image ou le son." ;
		arr[CaptureError.CAPTURE_INVALID_ARGUMENT	] =  "Utilisation incorrecte de l'API (par exemple, la valeur de limit est inf\u00e9rieur à 1)." ;
		arr[CaptureError.CAPTURE_NO_MEDIA_FILES		] =  "L'utilisateur a quitt\u00e9 l'application capture audio sans aucun enregistrement." ;
		arr[CaptureError.CAPTURE_NOT_SUPPORTED		] =  "L'op\u00e9ration de capture demand\u00e9e n'est pas pris en charge." ;			
		arr[e.code].alert();
	}
	function onClickPlay (e:MouseEvent) {	
		show(false, false, true); // rec,play,stop
		//	
		
	}
	function playOneFile(p:String, n:String) {
		path = p; name = n;
		// using only param 'p' as fullpath return an error !
		path = File.externalRootDirectory + SampleAudioLocal.RECORDING_FOLDER + name ;		
		
	}
	function onMediaPlaySuccess() {
		show(true,true,false); // rec,play,stop		
		//trace("Recorded sound : "+path+" was playing");			
	}
	function onMediaError(e:MediaError) {
		("error #" + e.code+" : " + e.message).alert();
	}
	function onClickStopPlaying (e:MouseEvent) {	
		show(true, true,false); // rec,play,stop		
		//
		if (media != null) { 
			media.stop(); media.release(); 
			//trace("Recorded sound : "+path+" is stopped");	
		}
	}
	//
	//
	function show (?r:Bool=null,?p:Bool=null,?s:Bool=null) {	
		r!=null?"#audioCtnr .record".get().style.visibility		= r?"visible":"hidden":null;
		p!=null?"#audioCtnr .play".get().style.visibility		= p?"visible":"hidden":null;
		s!=null?"#audioCtnr .stopPlay".get().style.visibility	= s?"visible":"hidden":null;		
	}
	//
	//	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='audioCtnr'>";
		str += 		"<button class='button record'   		type='button' >Enregistrer</button>";
		str += 		"<button class='button stopPlay'   		type='button' >Arrêter</button>";
		str += 		"<button class='button play'   			type='button' >Lire</button>";
		str += "</div>";		
		str += 	"<br/>";str += 	"<br/>";		
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
		css += 		"height:5rem;";		
		css += 		"margin-top:30px;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";	
		css += 		"font-size:2rem;";
		css += "}";	
		css += "#audioCtnr .stopPlay, #audioCtnr .stopRecord, #audioCtnr .play {";
		css += 		"visibility:hidden;";
		css += "}";	
		css += "#audioCtnr .stopPlay, #audioCtnr .stopRecord {";
		css += 		"background-color:#f99;";
		css += "}";	
		css += "#audioCtnr .play, #audioCtnr .record {";
		css += 		"background-color:#9f9;";
		css += "}";	
		
		var head = Browser.document.head; 
		var styleEl:StyleElement = cast("style".get(head)) ;
		if ( styleEl== null) {
			Browser.document.head.appendChild("style".createElem());
			styleEl = cast("style".get(head)) ;
		}
		//
		styleEl.innerHTML += css;
	}	
}