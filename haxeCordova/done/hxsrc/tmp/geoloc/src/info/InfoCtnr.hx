package info ;
/**
* classes imports
*/

import apix.common.display.Common;
import js.html.Element;
import js.Browser;
using apix.common.util.StringExtender;
using apix.common.display.ElementExtender;
/**
* root class
*/
class InfoCtnr {
	static var styleString:String = "font-family: Arial,sans-serif;font-size:26px;" ;
	static var classString:String = "apix_info" ;
	var element:Element;
	var id:String;
	var ctnrEl:Element;
	var ctnrIsStatic:Bool;
	public function new (?ctnr:String = null,?h:String="Informations") {		
		if (ctnr == null) {
			ctnrEl = Common.createElem();
			ctnrEl.id = Common.newSingleId;
			Common.body.addChild(ctnrEl);
			ctnrIsStatic = false;
		}
		else {
			ctnrEl = ctnr.get();
			ctnrIsStatic = true;
		}
		var h1:Element = Browser.document.createElement("h1");
		h1.setAttribute("style", InfoCtnr.styleString);
		h1.inner(h);
		ctnrEl.addChild(h1);
	}
	public function remove () {
		if (ctnrIsStatic) ctnrEl.innerHTML = "";
		else Common.body.removeChild(ctnrEl);
		return null ;
	}
	public function add (?h:String = "") : Info {
		if (element == null) initElemCtnr () ;
		var info = new Info();
		element.addChild(info.element);
		getElem("#" + info.id + " .title").text(h);		
		return info;
	}
	public function addLine (?m:String = "")  {
		//element.appendInner("<li>"+m+"</li>");	
		var line:Element = Browser.document.createElement("div");
		line.inner(m);
		ctnrEl.addChild(line);
	}
	public inline static function getElem (str:String) {
		return (("." + classString + " ") + str).get() ;
	}
	// private
	function initElemCtnr () {
		element = Browser.document.createElement("ul");
		element.setAttribute("class", InfoCtnr.classString);
		//element.setAttribute("style",InfoCtnr.styleString);		
		id = Common.newSingleId;
		element.id = id;
		ctnrEl.addChild(element);	
	}
	
}

class Info {
	static var styleString:String = "list-style-type:circle;font-size:14px;" ;
	static var innerString:String = "<h3 class='title'></h3><ul style='list-style-type: none;'></ul>" ; //class='line' 
	public var element:Element;
	public var id:String;
	public function new () {
		element = Browser.document.createElement("li");
		element.setAttribute("style",Info.styleString);		
		id = Common.newSingleId;
		element.id = id;
		element.inner(Info.innerString);
	}
	public function addLine (?m:String = "")  {
		InfoCtnr.getElem("#" + id + " ul").appendInner("<li>"+m+"</li>");			
	}
	public function add (?h:String = "") : Info {
		var info = new Info();		
		InfoCtnr.getElem("#" + id + " ul").addChild(info.element);
		InfoCtnr.getElem("#" + info.id + " .title").text(h);		
		return info;
	}
}