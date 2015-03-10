/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordovax.navigator.App;
import cordovax.navigator.Notification;
import haxe.Timer;
import js.Browser;
import js.html.Event;
import js.html.StyleElement;
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.vibration
//
/**
* root class
*/
//
class SampleSOS {
	static var SECOND:Int = 1000;
	var g:Global;
	var timer:Timer;
	var stk:Array<Timer>;
	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g = Global.get();
		callback = cb;
		//
		createHtmlCss();
		"#vibrateCtnr .start".get().addEventListener("click", onStart);
		"#vibrateCtnr .stop".get().addEventListener("click", onStop);
		//
		if (callback != null) callback(); 
	}
	
	function onStart(e:Event) {	
		"#vibrateCtnr .start".get().style.display = "none";
		"#vibrateCtnr .stop".get().style.display = "block";
		timer=new Timer(Math.round(6 * SECOND));
		timer.run = onClock;
		onClock();
		stk.push(timer);
	}
	function onStop(e:Event) {	
		"#vibrateCtnr .start".get().style.display = "block";
		"#vibrateCtnr .stop".get().style.display = "none";
		timer.run=null;
		timer.stop();
		for (t in stk) t.run=null;
	}
	function onClock() {	
		Pop.vibrate([150,100,150,100,150,200, 1000,200,1000,200,1000,200,   150,100,150,100,150,100]); // ...---... // S-O-S
	}
	
		
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='vibrateCtnr'>";
		str +=		"<h2>Le SOS haptique : </h2>";
		str += 		"<br/>";
		str += 		"<button class='start' type='button' >D&eacute;marrer SOS</button>";
		str += 		"<br/>";
		str += 		"<button class='stop'  type='button' >Arr&ecirc;ter SOS</button>";
		str += 		"<br/>";
		str += "</div>";
		var el="div".createElem(); 
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		//
		// append css		
		var css = "";
		css += "#vibrateCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"padding:.5rem;";
		css += 		"width:17.5rem;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";
		css += 		"border:dashed 1px #555;";		
		css += "}";		
		css += "#vibrateCtnr   button  {";
		css += 		"display:block;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";
		css += 		"font-size:2rem;";		
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