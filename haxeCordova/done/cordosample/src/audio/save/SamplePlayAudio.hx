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
import js.Browser;
import js.html.AudioElement;
import js.html.ButtonElement;
import js.html.MouseEvent;
import js.html.StyleElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.media-capture +  org.apache.cordova.file-transfer
/**
* root class
*/
class SamplePlayAudio	 {
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
		//trace("version 5");
	}	
	function onClick (e:MouseEvent) {		
		if (g.isMobile) {
			var path ;
			// pas ok : path= File.applicationDirectory + "www/sound/voix01.amr" ; 
			// pas ok : path = "cdvfile://localhost/persistent/sound/voix01.amr"; //cdvfile://localhost/persistent
			// ok : 
			path = "http://www.pixaline.net/intra/cordosample/sound/voix01.amr";
			playOneFile(path);			
		}
	}
	//
	function playOneFile(src:String) {
		var ply:AudioElement = cast(("#audioCtnr .player".get())).cloneNode();
		"#audioCtnr".get().appendChild(ply);
		ply.src = src;
		trace("src=" + src);
		Console.log("src=" + src);
		//i.e.     file:/mnt/sdcard/My%20Documents/My%20Recordings/Voix0022.amr
		ply.play();
	}
	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='audioCtnr'>";
		str += 		"<audio class='player'>Audio not supported</audio>";
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
		var head = Browser.document.head; 
		var styleEl:StyleElement = cast("style".get(head)) ;
		if ( styleEl== null) {
			Browser.document.head.appendChild("style".createElem());
			styleEl = cast("style".get(head)) ;
		}
		//
		styleEl.innerHTML += css;
		return "#audioCtnr .play".get();
	}	
}