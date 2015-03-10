/**
* app root package
*/
package;
/**
* classes imports
*/

import apix.common.util.Global;
import cordova.File;
import cordova.FileTransfer;
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
		new SampleEvent (geolocation); //4
		new SampleDevice(); //4
		new SampleSOS(); //6/**/
		
		new FileTransfer();
		trace(File.applicationDirectory);
		trace(File.applicationStorageDirectory);
		trace(File.dataDirectory);
		trace(File.cacheDirectory);
		trace(File.externalApplicationStorageDirectory);
		trace(File.externalCacheDirectory);
		trace(File.externalDataDirectory);
		/*
		trace(File);
		trace(File);
		trace(File);
		trace(File);
		trace(File);
		trace(File);
		trace(File);*/
		
	}	
	function geolocation() { new SampleGeolocation(compass);}	//1
	function compass() {new SampleCompass (camera);}	//1
	function camera() { new SampleCamera (database); }	//2
	function database() { new SampleDatabase (motion); }	//3
	function motion() { new SampleMotion (contact); }	//5
	function contact() { new SampleContact (end); }	//7
	
	function end () {	
		"c fini".trace();
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