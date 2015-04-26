/**
* app root package
*/
package ;
/**
* classes imports
*/

import apix.common.util.Global;
import js.Browser;
import js.html.Element;
//
//
using apix.common.util.StringExtender;
/**
* root class
*/
class Main {
	static var g:Global; 	
	
	function new () {		
		//new SampleEvent (audioLocal); 
		new SampleEvent (audioServer); 
	}
	function audioLocal () 	{ new SampleAudioLocal	 (end); }	
	function audioServer () { new SampleAudioServer	 (end); }	
	
	function end () {	
		//"c fini".trace();
	}
	static function main() {  
		"#appHtmlCtnr".get().appendChild("h1".createElem()).textContent = "HX-Cordova" ;
		"#appHtmlCtnr h1".get().style.width = "280px";
		g=Global.get();
		g.setupTrace("appHtmlCtnr");			
		//
		
		new Main();
	}	
	
}