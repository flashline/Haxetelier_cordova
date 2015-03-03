/**
 * Copyright (c) jm Delettre.
 * 
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package apix.common.display ;
#if js
	//import apix.common.util.Global;
	import apix.common.event.StandardEvent;
	import js.Browser;
	import js.html.DOMWindow;
	import js.html.Element;
	import js.html.Document;
	import js.html.Event;
	import js.html.KeyboardEvent;
	import js.html.Node;
	import js.html.NodeList;
#end
//
@:enum
abstract TagType (String) {
	var   BOX 	= "div";	
	var   SPAN 	= "span";	
	var   IMG 	= "img";
	var  LINE 	= "br";
	var HLINE 	= "hr";
	//to continue if needed
}
/**
 * Contains display static methods to abstract language specific methods
 */
class Common {	
	public static inline var DESC_EXT:String = #if (js) "html" #elseif flash "xml" #end ;
	//	
	public static inline function getElem(v:String) :  #if (js) Element #elseif flash Sprite #end {
		#if (js)
			return  Browser.document.getElementById(v);
		#elseif flash 
			//todo 
		#end
	}
	public static inline function createElem(?tag:TagType=TagType.BOX) : #if (js) Element #elseif flash Sprite #end {
		#if (js)
			var str = Std.string(tag);
			return Browser.document.createElement(str);
		#elseif flash
			return new Sprite();
		#end
	}
	public static var newLine (get, null):#if (js) Element #end ;
	static inline function get_newLine() : #if (js) Element #end {
		#if (js)
			//return Browser.document.createElement("br");
			return createElem(TagType.LINE);
		#end // TODO
	}	
	public static var newHLine (get, null):#if (js) Element #end ;
	static inline function get_newHLine() : #if (js) Element #end {
		#if (js)
			//return Browser.document.createElement("hr");
			return createElem(TagType.HLINE);
		#end // TODO
	}	
	public static inline function getElemsByTag(v:String) : #if (js) Array<Element> #else Array<Sprite> #end {
		#if (js)
			return untyped Browser.document.getElementsByTagName(v);
		#end
	}
	
	public static var window (get, null):#if (js) DOMWindow #end ;
	static function get_window() : #if (js) DOMWindow #end {
		#if (js)
			return  Browser.window; 
		#end
	}
	public static var document (get, null):#if (js) Document #end;
	static function get_document() : #if (js) Document #end {
		#if (js)
			return  Browser.document;
		#end
	}
	public static var head (get, null):#if (js) Element #end;
	static function get_head() : #if (js) Element #end {
		#if (js)
			return  Browser.document.head ;
		#else
			//todo
		#end
	}
	//
	public static var body (get, null):#if (js) Element #end;
	static function get_body() : #if (js) Element #end {
		#if (js)
			return Browser.document.body;
		#end
	}
	public static var documentElement (get, null):#if (js) Element #end;
	static function get_documentElement() : #if (js) Element #end {
		#if (js)
			return Browser.document.documentElement ;
		#end
	}
	//
	public static var availWidth (get, null): Float ;
	static function get_availWidth() : Float {
		#if (js)
			return Browser.window.screen.availWidth ;
		#else
			//todo
		#end
	}	
	public static var availHeight (get, null): Float;
	static function get_availHeight() : Float {
		#if (js)
			return Browser.window.screen.availHeight ;
		#else
			//todo
				
		#end
	}	
	//
	public static var screenWidth (get, null): Float;
	static function get_screenWidth() : Float {
		return availWidth ;
	}
	public static var screenHeight (get, null): Float;
	static function get_screenHeight() : Float {
		return availHeight;
	}
	//
	public static var windowWidth (get, null): Float ;
	static function get_windowWidth() : Float {
		#if (js)
			return Browser.window.innerWidth ;
		#else
			//todo
		#end
	}	
	public static var windowHeight (get, null): Float ;
	static function get_windowHeight() : Float {
		#if (js)
			return Browser.window.innerHeight ;
		#else
			//todo
		#end
	}	
	//
	public static var documentWidth (get, null): Float ;
	static function get_documentWidth() : Float {
		#if (js)
			return Common.body.scrollWidth ;
		#else
			//todo
		#end
	}
	public static var documentHeight (get, null): Float ;
	static function get_documentHeight() : Float {
		#if (js)
			return Common.body.scrollHeight ;
		#else
			//todo
		#end
	}
	
	//
	
	public static var userAgent (get, null): String;
	static function get_userAgent() : String {
		#if (js)
			return Browser.navigator.userAgent ;
		#end
	}	
	// get new unique Id
	public static var newSingleId(get, null):String ; static var __nextSingleId:Int=-1 ;
	static function get_newSingleId ():String { 
		__nextSingleId++ ; var id = "apix_instance_" + __nextSingleId ; 
		if (Common.getElem(id)!=null) trace("f::Id "+id+" already exists ! "); 
		return id;
	}		
	static var keyPressListener:KeyPressEvent->Void ;
	public static function  enableKeyPress (f:KeyPressEvent->Void ) {	
		keyPressListener = f;
		Browser.window.onkeypress = onKeyPress ;
	}	
	public static function  onKeyPress (e:KeyboardEvent) {	
		var kpe:KeyPressEvent = untyped e ;
		kpe.keyChr = String.fromCharCode(kpe.keyCode);
		kpe.keyChrLower = kpe.keyChr.toLowerCase();
		keyPressListener(kpe);
	}	
	public static function  disableKeyPress () {
		keyPressListener = null;
		Browser.window.onkeypress = null ;
	}	
	
	
		
}
 