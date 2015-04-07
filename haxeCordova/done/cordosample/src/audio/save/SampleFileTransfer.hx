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
import js.Browser;
import js.html.ButtonElement;
import js.html.MouseEvent;
import js.html.StyleElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.file +  org.apache.cordova.file-transfer
/**
* root class
*/
class SampleFileTransfer	 {
	var g:Global;
	var bt:ButtonElement;
 	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		bt=cast(createHtmlCss());
		bt.addEventListener("click", onClick);
		if (callback != null) 	callback();
		//		
		//trace("version 1");
	}	
	function onClick (e:MouseEvent) {		
		if (g.isMobile) {
			var path = File.applicationDirectory + "www/sound/voix01.amr" ; var name="voix01.amr";
			uploadFile(path, name);
			// not ok on my phone // uploadFile(File.externalRootDirectory+"My%20Documents/My%20Rrecordings/Voix0031.amr", "Voix0031.amr");
			//
		}
	}
	function uploadFile(path:String, name:String) {
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
		trace("  path=" + path);
		//Console.log("console log test in upload");
		ft.upload(path,uri,onUploadSuccess, onUploadError, options );
    }
	function onUploadSuccess (result:FileUploadResult) {
		trace('Upload success: ' + result.responseCode);
		trace('Response : ' + result.response);
		trace(result.bytesSent + ' bytes sent');
	}
	function onUploadError (error:FileTransferError) {
		trace('Error uploading file code: ' +  error.code + ' src: ' + error.source + ' trgt: ' + error.target);
	}	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='uploadCtnr'>";
		str += 		"<button class='button upload' type='button' >Upload</button>";
		//str += 		"<button class='button play'   type='button' >Jouer</button>";
		str += "</div>";
		var el="div".createElem(); 
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		//
		// append css		
		var css = "";
		css += "#uploadCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"width:100%;";		
		css += "}";		
		css += "#uploadCtnr .button  {";
		css += 		"display:block;";
		css += 		"width:80%;";		
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";	
		css += 		"font-size:2em;";
		css += "}";		
		var head = Browser.document.head; 
		var styleEl:StyleElement = cast("style".get(head)) ;
		if ( styleEl== null) {
			Browser.document.head.appendChild("style".createElem());
			styleEl = cast("style".get(head)) ;
		}
		//
		styleEl.innerHTML += css;
		return "#uploadCtnr .upload".get();
	}	
}