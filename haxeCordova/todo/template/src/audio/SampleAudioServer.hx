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
import cordovax.FileTransfer;
import cordovax.navigator.Media;
import js.Browser;
import js.html.AudioElement;
import js.html.Event;
import js.html.MouseEvent;
import js.html.SpanElement;
import js.html.StyleElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.media , org.apache.cordova.file and org.apache.cordova.file-transfer
/**
* root class
*/
class SampleAudioServer	  {
	var g:Global;
 	var callback:Dynamic;
	var media:Media;
	var name:String;
	var path:String;
	var ply:AudioElement;
	static var soundOrder:Int = 0;
	static inline var SERVER_URL = "http://www.pixaline.net/intra/cordosample/sound/";
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//		
		callback = cb;
		//
		 createHtmlCss();
		if (File.externalApplicationStorageDirectory == null) "#audioCtnr".get().innerHTML = "<h1>Enlever le cable et relancer l'app. !</h1>";
		else {
			"#audioCtnr .record".get().addEventListener("click", onClickRecord);
			"#audioCtnr .stopRecord".get().addEventListener("click", onClickStopRecording);
			"#audioCtnr .uploadAndPlay".get().addEventListener("click", onClickUploadAndPlay);					
		}
		//
		if (callback != null) 	callback();		
	}	
	function onClickRecord (e:MouseEvent) {		
		show(false, null, true); // rec,upload,stop
		//
		
	}	
	function onMediaSuccess() {
		//trace("End of recording sound to "+path+name);			
	}
	function onMediaError(e:MediaError) {
		("error #" + e.code+" : " + e.message).alert();
	}
	function onClickStopRecording (e:MouseEvent) {				
		show(null, true, false);
		
	}
	function onClickUploadAndPlay (e:MouseEvent) {	
		if (media != null) {	
			show(null, false, false); // rec,upload,stop
			
			
			
			
			//trace ("Asking upload'n play" + path+name); 
		} else "media is null".alert();
		
	}
	//
	function uploadFile(pathname:String, name:String) {
		
    }
	function onUploadSuccess (result:FileUploadResult) {
		//trace('Upload success: ' + result.responseCode);
		//
		var url = SampleAudioServer.SERVER_URL+name;
		playOneFile(url,"from "+SampleAudioServer.SERVER_URL+" :<br/>"+result.response+"<br/>"+result.bytesSent+" byte(s) sent");	
		
	}
	function onUploadError (error:FileTransferError) {
		show(true, true, null); // rec,upload,stop
		trace('Error uploading file code: ' +  error.code + ' src: ' + error.source + ' trgt: ' + error.target);
	}
	function playOneFile(url:String,?response:String="No server response") {		
		ply = cast("#audioCtnr .player".get()).cloneNode();
		var span:SpanElement = cast("#audioCtnr .name".get()).cloneNode();
		span.style.display = "block";
		"#audioCtnr .playerCtnr".get().appendChild(span);
		"#audioCtnr .playerCtnr".get().appendChild(ply);
		
		
		
		
	}
	function onStopPlaying (e:Event) {	
		show(true, false, false); // rec,upload,stop
	}
	//
	function show (?r:Bool=null,?u:Bool=null,?s:Bool=null) {	
		r!=null?"#audioCtnr .record".get().style.visibility			= r?"visible":"hidden":null;
		u!=null?"#audioCtnr .uploadAndPlay".get().style.visibility	= u?"visible":"hidden":null;
		s!=null?"#audioCtnr .stopRecord".get().style.visibility		= s?"visible":"hidden":null;
	}
	//
	//
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='audioCtnr'>";
		str += 		"<span class='name' ></span>";
		str += 		"<audio class='player' controls   >Audio not supported</audio>";
		str += 		"<div class='playerCtnr'></div>";
		str += 		"<button class='button record'   		type='button' >Enregistrer</button>";
		str += 		"<button class='button stopRecord'  	type='button' >Stop enregistrement</button>";
		str += 		"<button class='button uploadAndPlay'  	type='button' >Upload et lire</button>";
		str += "</div>";		
		str += 	"<p>&nbsp;</p>";
		var el="div".createElem(); 
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		//
		// append css		
		var css = "";
		css += "#audioCtnr {";
		css += 		"margin-top:.3rem;";
		css += 		"width:100%;";		
		css += "}";		
		css += "#audioCtnr .name {";
		css += 		"margin-top:2rem;";
		css += 		"display:none;";
		css += 		"width:100%;";			
		css += "}";		
		css += "#audioCtnr .player {";
		css += 		"margin-top:1rem;";
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
		css += "#audioCtnr .stopRecord, #audioCtnr .uploadAndPlay, #audioCtnr .player {";
		css += 		"visibility:hidden;";
		css += "}";	
		css += "#audioCtnr .stopRecord {";
		css += 		"background-color:#f99;";
		css += "}";	
		css += "#audioCtnr .record, #audioCtnr .uploadAndPlay {";
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