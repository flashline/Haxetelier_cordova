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
import js.html.MouseEvent;
import js.html.StyleElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.media
/**
* root class
*/
class SampleMedia	 {
	var g:Global;
 	var callback:Dynamic;
	var media:Media;
	var name:String;
	var path:String;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		//
		 createHtmlCss();
		"#audioCtnr .playFromServer".get().addEventListener("click", onClickReadFromServer);
		"#audioCtnr .play".get().addEventListener("click", onClickExistingRead);
		"#audioCtnr .stop".get().addEventListener("click", onClickStopReading);
		"#audioCtnr .record".get().addEventListener("click", onClickRecord);
		"#audioCtnr .stopRecord".get().addEventListener("click", onClickStopRecording);
		"#audioCtnr .localReplay".get().addEventListener("click", onClickReplay);
		"#audioCtnr .uploadAndReplay".get().addEventListener("click", onClickUpload);
		
		
		if (callback != null) 	callback();
		//		
		//trace("version 5");
	}	
	function onClickReadFromServer (e:MouseEvent) {		
		"#audioCtnr .stop".get().style.display 					= "block";
		"#audioCtnr .play".get().style.display 					= "none";
		"#audioCtnr .playFromServer".get().style.display 		= "none";
		"#audioCtnr .record".get().style.display 				= "none";		
		//
		var url ;
		//  : 
		url = "http://www.pixaline.net/intra/cordosample/sound/test.amr";
		media = new Media(url, onPlayingRecordedFromServer, onAudioError ); 
		media.play();		
	}
	function onClickExistingRead (e:MouseEvent) {		
		"#audioCtnr .stop".get().style.display 				= "block";
		"#audioCtnr .play".get().style.display 				= "none";
		"#audioCtnr .playFromServer".get().style.display 	= "none";		
		"#audioCtnr .record".get().style.display 			= "none";		
		
		//
		if (media!=null) media.release();
		var url ;
		//  in wwww
		//url =  File.applicationDirectory + "www/sound/voix01.amr" ;
		// or in external from app
		url = File.externalRootDirectory + "My%20Documents/My%20Recordings/Voix0036.amr" ;
		media = new Media(url, onPlayingExisting, onAudioError ); 
		media.play();		
	}
	function onClickStopReading (e:MouseEvent) {	
		"#audioCtnr .stop".get().style.display 				= "none";
		"#audioCtnr .play".get().style.display 				= "block";
		"#audioCtnr .playFromServer".get().style.display 	= "block";
		"#audioCtnr .record".get().style.display 			= "block";	
		//
		if (media!=null) { media.stop(); media.release(); }
	}
	function onClickRecord (e:MouseEvent) {		
		//  path= File.applicationDirectory + "www/sound/voix01.amr" ; 
		//  path = "cdvfile://localhost/persistent/sound/voix01.amr"; //cdvfile://localhost/persistent
		//		
		"#audioCtnr .stopRecord".get().style.display		= "block";		
		"#audioCtnr .play".get().style.display 				= "none";
		"#audioCtnr .playFromServer".get().style.display 	= "none";
		"#audioCtnr .record".get().style.display 			= "none";		
		
		//
		name =  "recordedSound.amr";	
		path = File.externalDataDirectory ; // File.dataDirectory ; // File.cacheDirectory ; //  File.applicationStorageDirectory ; // 
		media = new Media(path + name, onEndRecording, onAudioError ); 
		media.startRecord();
		trace ("Asking record of" + path+name); 
	}
	function onClickStopRecording (e:MouseEvent) {				
		"#audioCtnr .stopRecord".get().style.display 		= "none";		
		"#audioCtnr .localReplay".get().style.display		= "block";
		"#audioCtnr .uploadAndReplay".get().style.display	= "block";			
		//
		media.stopRecord();
	}
	function onClickReplay (e:MouseEvent) {	
		"#audioCtnr .stop".get().style.display 				= "block";		
		"#audioCtnr .localReplay".get().style.display		= "none";
		"#audioCtnr .uploadAndReplay".get().style.display	= "none";
		/*
		str += 		"<button class='button play'   			type='button' >Lire un son existant dans www</button>";
		str += 		"<button class='button stop'   			type='button' >Arrêter de jouer un son</button>";
		str += 		"<button class='button record'   		type='button' >Enregistrer un son sur local ''data storage''</button>";
		str += 		"<button class='button stopRecord'  	type='button' >Stop enregistrement</button>";
		str += 		"<button class='button localReplay' 	type='button' >Replay from local ''data storage''</button>";
		str += 		"<button class='button uploadAndReplay'  type='button' >Upload puis replay from serveur</button>";
		*/
		
		if (media != null) {
			media = new Media(path+name, onPlayingRecorded, onAudioError ); 
			media.play();
			trace ("Asking play " + path+name); 
		}
	}
	function onClickUpload (e:MouseEvent) {	
		if (media != null) {	
			"#audioCtnr .stopRecord".get().style.display 		= "none";		
			"#audioCtnr .localReplay".get().style.display		= "none";
			"#audioCtnr .uploadAndReplay".get().style.display	= "none";
			//
			uploadFile(path+name,name);
			//
			trace ("Asking upload'n play" + path+name); 
		}
	}
	
	//
	function onPlayingExisting() {
		"#audioCtnr .play".get().style.display 				= "block";		
		"#audioCtnr .playFromServer".get().style.display 	= "block";
		"#audioCtnr .record".get().style.display 			= "block";	
		"#audioCtnr .stop".get().style.display 	 			= "none";	
		trace("end of playing an existing sound from File.applicationDirectory or File.externalRootDirectory + 'My%20Documents/My%20Recordings/'");			
	}
	function onEndRecording() {
		trace("End of recording sound to "+path+name);			
	}
	function onPlayingRecorded() {
		"#audioCtnr .play".get().style.display 				= "block";
		"#audioCtnr .playFromServer".get().style.display 	= "block";
		"#audioCtnr .record".get().style.display 			= "block";	
		"#audioCtnr .stop".get().style.display 	 			= "none";	
		trace("playing the recorded sound : dataDirectory/recordedSound.amr ");			
	}
	function onPlayingRecordedFromServer() {		
		"#audioCtnr .play".get().style.display 				= "block";		
		"#audioCtnr .playFromServer".get().style.display 	= "block";
		"#audioCtnr .record".get().style.display 			= "block";	
		"#audioCtnr .stop".get().style.display 	 			= "none";	
		//
		trace("playing the uploaded and recorded sound from www.pixaline.net/intra/cordosample/sound/test.amr ");			
	}
	
	function onAudioError(e:MediaError) {
		("error #" + e.code+" : " + e.message).alert();
	}
	//
	//
	//
	function uploadFile(pathname:String, name:String) {
		var ft = new FileTransfer();	
		//var uri = StringTools.urlEncode("http://www.pixaline.net/intra/cordosample/sound/upload.php");
		var uri = "http://www.pixaline.net/intra/cordosample/sound/upload.php";
		var options = new FileUploadOptions();
		options.fileKey="file";
		options.fileName=name;
		options.mimeType = "audio/AMR";		
		trace("before upload()");
		trace("  uri="+uri);
		trace("  name="+name);
		trace("  pathname=" + pathname);
		//Console.log("console log test in upload");
		ft.upload(pathname,uri,onUploadSuccess, onUploadError, options );
    }
	function onUploadSuccess (result:FileUploadResult) {
		//
		trace('Upload success: ' + result.responseCode);
		trace('Response : ' + result.response);
		trace(result.bytesSent + ' bytes sent');
		//
		var url;
		//if (media != null) media.release();
		url = "http://www.pixaline.net/intra/cordosample/sound/test.amr";
		media = new Media(url, onPlayingRecordedFromServer, onAudioError ); 
		media.play();			
		
	}
	function onUploadError (error:FileTransferError) {
		"#audioCtnr .play".get().style.display 				= "block";		
		"#audioCtnr .record".get().style.display 			= "block";	
		trace('Error uploading file code: ' +  error.code + ' src: ' + error.source + ' trgt: ' + error.target);
	}	
	//
	//
	//	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='audioCtnr'>";
		//str += 		"<audio class='player'>Audio not supported</audio>";
		str += 		"<button class='button playFromServer'  type='button' >Lire dernier son depuis le serveur</button>";
		str += 		"<button class='button play'   			type='button' >Lire un son existant dans www</button>";
		str += 		"<button class='button stop'   			type='button' >Arrêter de jouer un son</button>";
		str += 		"<button class='button record'   		type='button' >Enregistrer un son sur local ''data storage''</button>";
		str += 		"<button class='button stopRecord'  	type='button' >Stop enregistrement</button>";
		str += 		"<button class='button localReplay' 	type='button' >Replay from local ''data persistent storage''</button>";
		str += 		"<button class='button uploadAndReplay'  type='button' >Upload puis replay from serveur</button>";
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
		css += 		"height:12rem;";		
		css += 		"margin-top:30px;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";	
		css += 		"font-size:2rem;";
		css += "}";	
		css += "#audioCtnr .stop, #audioCtnr .stopRecord, #audioCtnr .localReplay, #audioCtnr .uploadAndReplay {";
		css += 		"display:none;";
		css += "}";	
		css += "#audioCtnr .stop, #audioCtnr .stopRecord {";
		css += 		"background-color:#f99;";
		css += "}";	
		css += "#audioCtnr .playFromServer, #audioCtnr .localReplay, #audioCtnr .uploadAndReplay, #audioCtnr .play, #audioCtnr .record {";
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