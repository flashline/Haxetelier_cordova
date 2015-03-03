/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.tools.math.MathX;
import apix.common.util.Global;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.StyleElement;
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.device-motion 
//
/**
* root class
*/
//
class SampleMotion {
	var g:Global;
	var callback:Dynamic;
	var stand:Element;
	var right:Element;
	var left:Element;
	public function new (?cb:Dynamic) {	
		g = Global.get();
		callback = cb;
		//
		createMario();
		stand = "#marioCtnr .stand".get();
		//
		//here
		//
		if (callback != null) callback(); 
	}	
	//
	function moveMario(x:Float, y:Float, z:Float) {	
		var v;
		v  	  = (portrait)? x : y ;
		left  = (portrait || upSideDown)? "#marioCtnr .left".get() :"#marioCtnr .right".get();
		right = (portrait  || upSideDown)? "#marioCtnr .right".get() :"#marioCtnr .left".get();
		if (Math.abs(v) < 4) {
			left.style.display = "none";
			right.style.display = "none";
			stand.style.display = "block";
			locateMario (v, stand,portrait);
		}
		else {
			stand.style.display = "none";
			if (v > 0) {
				left.style.display = "block";
				right.style.display = "none";
				locateMario (v, left,portrait);
			}
			else {
				left.style.display = "none";
				right.style.display = "block";
				locateMario (v, right,portrait);
			}
			
		}
	}
	function locateMario (x:Float, img:Element,?portrait:Bool=true) {
		var d = (portrait || (upSideDown) )? -1 : 1; //
		var p = img.offsetLeft + (3*x * d); 
		if (p<-img.clientWidth) p=-img.clientWidth ;if (p>280) p=280;		
		var str = "" + MathX.round(p, 2) + "px";		
		for (el in "#marioCtnr img.mario".all()) {
			el.style.left = str;
		}		
	}
	function createMario() {		
		// append html
		var str = "";
		str += "<div id='marioCtnr'>";
		str +=		"<h2>Acc&eacute;l&eacute;rom&egrave;tre :</h2>";
		str += 		"<img src='img/mario.back.png' alt='mario.back' /> " ;
		str += 		"<img class='stand mario' src='img/mario.stand.png' alt='mario.stand' /> " ;
		str += 		"<img class='right mario' src='img/mario.right.png' alt='mario.right' /> " ;
		str += 		"<img class='left mario' src='img/mario.left.png' alt='mario.left' /> " ;
		str += "</div>";				
		var el="div".createElem(); // Browser.document.createElement("div") ;
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		//
		// append css		
		var css = "";
		css += "#marioCtnr {";
		css += 		"position:relative;";	
		css += 		"margin-top:2rem;";	
		css += 		"width:280px;";
		css += 		"height:170px;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";	
		css += "}";
		css += "#marioCtnr h2 {";
		css += 		"position:relative;";
		css += 		"border:solid 1px #999;";
		css += "}";
		css += "#marioCtnr img  {";
		css += 		"position:absolute;";
		css += 		"display:block;";
		css += "}";	
		css += "#marioCtnr img.mario  {";
		css += 		"top:65px;";
		css += 		"left:102px;";
		css += "}";	
		var head = Browser.document.head;
		var styleEl:StyleElement = cast("style".get(head)) ;
		if ( styleEl== null) {
			Browser.document.head.appendChild("style".createElem());
			styleEl = cast("style".get(head)) ;
		}
		//
		styleEl.innerHTML += css;
		//
		
		
	}
	
	//
	var portrait(get, null):Bool; inline function get_portrait () : Bool return (! (Math.abs(ScreenView.orientation) == 90) ) ; 
	var upSideDown(get, null):Bool; inline function get_upSideDown () : Bool return ( (ScreenView.orientation == -90) ) ; 
	
}