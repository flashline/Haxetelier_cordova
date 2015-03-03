/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import cordova.navigator.Contacts;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.MouseEvent;
import js.html.StyleElement;
import js.html.TextAreaElement;
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
		"#contactCtnr .search".get().addEventListener("input", onSearchClick);
		//
		if (callback != null) callback(); 
	}
	function onSearchClick (e:MouseEvent) {	
		contactFind ( cast("#contactCtnr .search".get(), TextAreaElement).value) ;
	}
	function contactFind (?v:String = "") {	
		"#contactCtnr .contactDisplay .itemCtnr".get().innerHTML = "";
		var options :ContactFindOptions=new ContactFindOptions();
		options.multiple = true;
		//options.desiredFields = [FieldType.displayName];	// not ok except to just count contacts
		options.filter = v;
		var fields:Array<Dynamic>    = [FieldType.displayName,FieldType.name];
		Contacts.find(fields, onContactSuccess, onContactError, options);
	}	
	function onContactSuccess(contacts:Array < Contact > ) {
		"#contactCtnr .contactDisplay h2".get().innerHTML = "" + contacts.length + " contact(s) trouv&eacute;(s) ";
		var str = "";
		var n = -1;
		for (oneContact in contacts) {
			//oneContact.name 
			//	oneContact.name.formatted
			//	oneContact.name.familyName
			//	oneContact.name.givenName
			//
			// oneContact.phoneNumbers[n].type
			// oneContact.phoneNumbers[n].value
			//
			str = StringTools.ltrim(g.strVal(oneContact.displayName, ""));
			if (str !="") {	
				if (oneContact.phoneNumbers != null) {
					if (oneContact.phoneNumbers.length > 0) {
						// 
						n++;
						var itemEl=createNewEmptyItem(n);
						cast(("#" + itemEl.id + " .nameList").get(), TextAreaElement).value = str;					
						str = "";
						for (o in oneContact.phoneNumbers) {
							var onePhone:ContactField = o ;							
							str += "" + onePhone.type + " : " + onePhone.value + "\n";													
						}						
						("#" + itemEl.id + " .phoneList").get().innerHTML = str ;
					}
				}
			}
		}
		
	}
	function createNewEmptyItem (n:Int) : Element {
		var itemEl:Element = cast(itemTemplateEl.cloneNode(true));
		itemEl.id = "itemContact_" + n;
		return cast("#contactCtnr .contactDisplay .itemCtnr".get().appendChild(itemEl),Element);				
	}						
	function onContactError(contactError) {
		" Erreur durant la lecture du carnet d'adresse !!! ".alert();
	};	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div id='contactCtnr'>";
		str +=		"<h2>Les contacts</h2>";
		str += 		"<br/>";
		str += 		"<textarea class = 'search' placeholder=\"entrer une partie du nom...\"></textarea>";
		//str += 		"<br/>";
		//str += 		"<button class='bSearch' type='button' >Chercher</button>";
		str += 		"<br/>";
		str += 		"<div class='contactDisplay'>";
		str +=			"<h2></h2>";		
		str += 			"<div class='itemCtnr'>" ;
		str += 				"<div id='itemTemplate' class='item'> " ;
		str += 					"<br/>";
		str += 					"<label>Noms : </label>" ;
		str += 					"<textarea readonly='readonly' class='nameList'></textarea>";
		str += 					"<label>Num&eacute;ros : </label>" ;
		str += 					"<span readonly='readonly' class='phoneList'></span>";		
		str += 					"<br/>";
		str += 				"</div>";
		str += 			"</div>";
		str += 		"</div>";
		str += "</div>";
		var el="div".createElem(); 
		el.innerHTML = str;		
		var dvEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dvEl); // N-E-V-E-R do an innerHTML+=
		itemTemplateEl = "#contactCtnr #itemTemplate".get();
		"#contactCtnr .itemCtnr".get().removeChild(itemTemplateEl);//
		// append css		
		var css = "";
		css += "#contactCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"padding:.5rem;";
		css += 		"width:17.5rem;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";				
		css += 		"font-size:1.5rem;";
		css += "}";	
		css += "#contactCtnr .item {";
		css += 		"border:dashed 1px #999;";
		css += "}";	
		css += "#contactCtnr label, #contactCtnr input, #contactCtnr textarea, #contactCtnr button , #contactCtnr span {";
		css += 		"display:block;";
		css += 		"font-size:1.5rem;";
		css += "}";
		css += "#contactCtnr textarea {";
		css += 		"min-height:4rem;";
		css += 		"width:17rem;";	
		css += "}";
		css += "#contactCtnr span.phoneList {";
		css += 		"/*border:solid 1px #555;*/";
		css += 		"/*overflow:auto;*/";
		css += "}";
		css += "#contactCtnr textarea.search {";
		css += 		"min-height:5rem;";
		css += "}";
		css += "#contactCtnr button  {";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";
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