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
package apix.common.util ;
import js.Browser;
import js.html.Element;
import js.html.NodeList;
//
/**
 * extends String usage in caller : using apix.common.util.StringExtender;
 */
class StringExtender  {
	static public var rootHtmlElement:Element;
	//
	
	/**
	* run f() function on each Element of given array
	*/		
	public static function each(v:String, ?f:Element->Void , ?parent:Element=null) : Array<Element> {	
		var arr:Array<Element> = all (v, parent);	
		for (el in arr) f(el);
		return arr ;
	}
	
	public static function all (v:String, ?parent = null) :Array<Element> {
		if (rootHtmlElement == null) rootHtmlElement = Browser.document.body;
		if (parent == null) parent = rootHtmlElement;	
		return untyped parent.querySelectorAll(v);	
	}
	public static function get (v:String,?parent:Element=null):Element{
		if (rootHtmlElement == null) rootHtmlElement = Browser.document.body;
		if (parent == null) parent = rootHtmlElement;	
		return untyped parent.querySelector(v);	
	}
	public static function createElem (v:String):Element {		
		return Browser.document.createElement(v);	
	}
	public static function toDecimal(v:String, ?d:Int=2):String {
		var n = Std.parseFloat(v);
		var mul= Math.pow(10, d);
		var str=Std.string(mul + (Math.floor(n * mul) % mul));
		return Std.string(Math.floor(n))+"."+str.substr(1, d);	
	}
	public inline static function unspaced (v:String):String {
		return  (v==null)?"":StringTools.rtrim(StringTools.ltrim(v));
	}
	
	public static function replaceOnce (str:String,from:String,to:String ) :String {
		var p = str.indexOf(from); var v = str;
		if (p != -1) {
			v=str.substr(0, p) + to + str.substr(p+(from.length));
		}
		return v;
	}
	public static inline function alert (s:String) {
		js.Lib.alert(s);
	}
	public static inline function trace (s:String, ?v:Dynamic) {
		if (v!=null) s += "="+v.toString();
		trace(s);
	}
	
}
 