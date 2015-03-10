/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordovax.navigator.Compass;
import js.Browser;
import js.html.ImageElement;
//
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.device-orientation
/**
* root class
*/
class SampleCompass {
	var g:Global;
 	var callback:Dynamic;
	var watchID:Dynamic;
	var img:ImageElement;
	public function new (cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		//
		createCompassElement();
		var opt:CompassOptions = { frequency:100 }; // in milliseconds
		//Compass.getCurrentHeading(onCurHeading, onWatchHeadingError,opt);
				if (g.isMobile) 		watchID = Compass.watchHeading(onWatchHeading, onWatchHeadingError, opt);
		else 	if (callback != null) 	callback(); 
	}	
	function onWatchHeading(heading:CompassHeading) {
		//setRotation(img,-heading.trueHeading);
		setRotation(img,-heading.magneticHeading);
		if (callback != null) { callback(); callback = null; }
	}	
	function onCurHeading(heading:CompassHeading) {
		("------") .trace() ;
		("trueHeading : " + heading.trueHeading).trace() ;
		("magneticHeading: " + heading.magneticHeading) .trace() ;
		("headingAccuracy : " + heading.headingAccuracy).trace() ;
		("timestamp : " + heading.timestamp).trace() ;
		if (callback != null) { callback(); callback = null; }
	}	
	function onWatchHeadingError(error:CompassError) {
		("CompassError: " + error.code).alert();
	}
	function createCompassElement() {
		//var back:ImageElement = cast(Browser.document.createElement("img"));
		var back:ImageElement = cast("img".createElem());
		back.src = "img/compass.back.png";		
		//		
		img=cast("img".createElem());
		img.src = "img/compass.arrow.png";		
		//
		//var ctnr = Browser.document.createElement("div");
		var ctnr = "div".createElem();
		"#appHtmlCtnr".get().appendChild(ctnr);
		ctnr.appendChild(back);
		ctnr.appendChild(img);
		//
		ctnr.style.position = "relative";
		ctnr.style.top = "1em";
		ctnr.style.width = "300px";
		ctnr.style.height = "300px";
		ctnr.style.marginLeft = "auto";
		ctnr.style.marginRight = "auto";
		//
		back.style.position = "absolute";
		back.style.display = "inline-block";
		//
		img.style.position = "absolute";
		img.style.display = "inline-block";
	}
	function  setRotation (e:ImageElement, v:Float) {	
		var el:Dynamic = untyped e;
		var r = Std.string(v);
				if(g.isWebKit) 	el.style.webkitTransform = "rotate(" + r + "deg)" ;
		else 	if(g.isFirefox)	el.style.mozTransform = "rotate(" + r + "deg)" ;
		else 	if(g.isIE) 		el.style.msTransform = "rotate(" + r + "deg)" ;
		else 	if(g.isOpera) 	el.style.oTransform = "rotate(" + r + "deg)" ;		
		else 	if(g.isKhtml) 	el.style.khtmlTransform = "rotate(" + r + "deg)" ;
		else 					el.style.transform = "rotate(" + r + "deg)" ;		
	}
	
}