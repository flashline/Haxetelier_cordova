/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.tools.math.MathX;
import apix.common.util.Global;
import cordovax.navigator.Accelerometer;
import cordovax.Device;
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
		//createHtmlCss();
		createMario();
		stand = "#marioCtnr .stand".get();
		var opt:AccelerometerOptions = { frequency:41 } ; //24fps
		var watchID = Accelerometer.watchAcceleration(onAccel, onAccelError, opt);
		//
		if (callback != null) callback(); 
	}
	function onAccel(accel:Acceleration) { 
		if (false) {
			cast("#xid".get(),InputElement).value=""+accel.x ; 
			cast("#yid".get(),InputElement).value=""+accel.y ; 
			cast("#zid".get(), InputElement).value = "" + accel.z ; 
		} else moveMario(accel.x,accel.y,accel.z);
	}
	function onAccelError() {
		cast("#xid".get(),InputElement).value="" ; 
		cast("#yid".get(),InputElement).value="erreur de d&eacute;tection de mouvement !"  ; 
		cast("#zid".get(),InputElement).value="" ; 
	}
	//
	function moveMario(x:Float, y:Float, z:Float) {	
		var v;
		v  	  = (Device.portrait)? x : y ;
		left  = (Device.portrait || upSideDown)? "#marioCtnr .left".get() :"#marioCtnr .right".get();
		right = (Device.portrait  || upSideDown)? "#marioCtnr .right".get() :"#marioCtnr .left".get();
		if (Math.abs(v) < 4) {
			left.style.display = "none";
			right.style.display = "none";
			stand.style.display = "block";
			locateMario (v, stand,Device.portrait);
		}
		else {
			stand.style.display = "none";
			if (v > 0) {
				left.style.display = "block";
				right.style.display = "none";
				locateMario (v, left,Device.portrait);
			}
			else {
				left.style.display = "none";
				right.style.display = "block";
				locateMario (v, right,Device.portrait);
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
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div class='motionCtnr'>";
		str +=		"<h2>Mouvements de l'appareil</h2>";
		str += 		"<label> X : </label>" ;
		str += 		"<input disable='disable' type = 'text' id = 'xid' />";
		str += 		"<label> Y : </label>" ;
		str += 		"<input disable='disable' type = 'text' id = 'yid' />";
		str += 		"<label> Z : </label>" ;
		str += 		"<input disable='disable' type = 'text' id = 'zid' />";		
		str += "</div>";
		var el="div".createElem(); // Browser.document.createElement("div") ;
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		//
		// append css		
		var css = "";
		css += ".motionCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"padding:.5rem;";
		css += 		"width:17.5rem;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";
		css += 		"border:dashed 1px #555;";
		css += 		"background-color:#fdfdfd;";		
		css += "}";
		css += ".motionCtnr label, .motionCtnr input  {";
		css += 		"display:block;";
		css += 		"font-size:1.5rem;";
		css += 		"overflow:hidden;";	
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
	var upSideDown(get, null):Bool; inline function get_upSideDown () : Bool return ( (Device.orientation == -90) ) ; 
	
}