/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordovax.navigator.Contacts;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.InputElement;
import js.html.MouseEvent;
import js.html.StyleElement;
//
using apix.common.util.StringExtender;
//
// DO NOT FORGET org.apache.cordova.contacts
//
/**
* root class
*/
//
class SampleContact {
	var g:Global;
	var itemTemplateEl:Element;
	var callback:Dynamic;
	public function new (?cb:Dynamic) {		
		g = Global.get();
		callback = cb;
		//
		createHtmlCss();
		//events
		//"#contactCtnr .bSearch".get().addEventListener("click", onSearchClick);
		"#contactCtnr .search".get().addEventListener("input", findContact);
		//
		if (callback != null) callback(); 
	}
	function findContact (e:MouseEvent) {	
		"#contactCtnr .search".get().removeEventListener("input", findContact);
		"#contactCtnr .contactDisplay".get().innerHTML = "";
		//
		var v = cast( "#contactCtnr .search".get() , InputElement ).value ;
		var options :ContactFindOptions=new ContactFindOptions();
		options.multiple = true;
		//options.desiredFields = [FieldType.displayName];	// not ok except to just count contacts
		options.filter = v;
		var fields:Array<Dynamic>    = [FieldType.displayName,FieldType.name];
		Contacts.find(fields, onContactSuccess, onContactError, options);
	}	
	function onContactSuccess(contacts:Array < Contact > ) {
		var str = "";
		var n = -1;
		for (oneContact in contacts) {
			str = oneContact.displayName.unspaced();
			if (str.length>1) {	
				if (oneContact.phoneNumbers != null) {
					if (oneContact.phoneNumbers.length > 0) {
						// 
						n++; var j = -1;
						for (onePhone in oneContact.phoneNumbers) {
							var t = onePhone.type.unspaced();
							var v = onePhone.value.unspaced();
							if ((t+v).length>1) {	
								j++;
								var itemEl = createNewEmptyItem(""+n+"-"+j);							
								// name
								("#" + itemEl.id + " .name").get().innerHTML = str;								
								// phone type
								("#" + itemEl.id + " .type").get().innerHTML = t ;
								// phone number
								("#" + itemEl.id + " .phone").get().innerHTML = v  ;
							} 
						}	
					}
				} 
			} 
		}
		//trace("" + contacts.length + " contact(s) lue(s) ");
		"#contactCtnr .search".get().addEventListener("input", findContact);
	}
	function onContactError(contactError) {
		"#contactCtnr .search".get().addEventListener("input", findContact);
		" Erreur durant la lecture du carnet d'adresse !!! ".alert();
	};	
	function createNewEmptyItem (v:String) : Element {
		var itemEl:Element = cast(itemTemplateEl.cloneNode(true));
		itemEl.id = "itemContact_" + v;
		return cast("#contactCtnr .contactDisplay".get().appendChild(itemEl),Element);				
	}						
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='contactCtnr'>";
		str +=		"<h2>Les contacts</h2>";
		str += 		"<input class = 'search' placeholder=\"entrer une partie du nom...\"/>";
		str += 		"<div class='contactDisplay'>";
		str += 			"<div id='itemTemplate' class='item'> " ;
		str += 				"<span  class='name'></span>";
		str += 				"<span  class='type'></span>";
		str += 				"<span  class='phone'></span>";
		str += 			"</div>";
		str += 		"</div>";
		str += 		"<br/>";
		str += 		"<br/>";
		str += "</div>";
		var el="div".createElem(); 
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		itemTemplateEl = "#contactCtnr #itemTemplate".get();
		"#contactCtnr .contactDisplay".get().removeChild(itemTemplateEl);//
		// append css		
		var css = "";
		css += "#contactCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"padding:2px;";
		css += 		"width:18.5rem;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";				
		css += "}";	
		css += "#contactCtnr .contactDisplay {";
		css += 		"margin-top:10px;";				
		css += 		"min-height:20rem;";		
		css += 		"border-bottom:solid 1px #aaa;";		
		css += "}";	
		css += "#contactCtnr .item {";		
		css += 		"border-top:solid 1px #aaa;";
		css += 		"padding-top:7px;";
		css += 		"padding-bottom:7px;";		
		css += "}";	
		css += "#contactCtnr .item span {";		
		css += 		"display:inline-block;";
		css += 		"overflow:hidden;";		
		css += 		"vertical-align:middle;";
		css += "}";	
		css += "#contactCtnr .item .name {";
		css += 		"font-size:.9rem;";
		css += 		"width:120px;";
		css += 		"height:16px;";		
		css += 		"text-overflow:ellipsis;";
		css += "}";	
		css += "#contactCtnr .item .type {";
		css += 		"margin-left:5px;";
		css += 		"font-size:.9rem;";
		css += 		"width:50px;";
		css += 		"height:16px;";
		css += "}";	
		css += "#contactCtnr .item .phone{";
		css += 		"margin-left:5px;";
		css += 		"font-size:1rem;";
		css += 		"width:110px;";
		css += "}";	
		css += "#contactCtnr .search {";
		css += 		"font-size:1.4rem;";
		css += 		"width:280px;";
		css += 		"display:inline-block;";
		css += 		"overflow:hidden;";				
		css += 		"border:solid 2px #555;";	
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