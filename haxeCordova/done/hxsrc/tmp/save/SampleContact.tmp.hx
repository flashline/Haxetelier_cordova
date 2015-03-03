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
		"#contactCtnr .bSearch".get().addEventListener("click", onSearchClick);
		//
		if (callback != null) callback(); 
	}
	function onSearchClick (e:MouseEvent) {	
		contactFind ( cast("#contactCtnr .search".get(), TextAreaElement).value) ;
	}
	function contactFind (?v:String = "") {	
		
		var options :ContactFindOptions=new ContactFindOptions();
		options.multiple = true;
		//options.desiredFields = [FieldType.displayName];
		//options.filter = v;
		var fields:Array<Dynamic>    = [FieldType.displayName, FieldType.name];
		Contacts.find(fields, onContactSuccess, onContactError, options);
	}	
	function onContactSuccess(contacts:Array < Contact > ) {
		var str = "";
		"#contactCtnr .contactDisplay h2".get().innerHTML = "" + contacts.length + " contact(s) trouv&eacute;(s) ";
		var n = -1;
		/*for (oneContact in contacts) {
			if (oneContact.name != null) n++;
				//if (g.strVal(oneContact.name.formatted, "") != "") n++;
			//oneContact.name 
			//	oneContact.name.formatted
			//	oneContact.name.familyName
			//	oneContact.name.givenName
			//
			// oneContact.phoneNumbers[n].type
			// oneContact.phoneNumbers[n].value
			//
			
			if (oneContact.phoneNumbers != null) {
				if (oneContact.phoneNumbers.length > 1) {
					"phone len >1".trace();
					// if (g.strVal(oneContact.displayName,"")!="") {	
					//ici n++;
					var itemEl = createNewEmptyItem(n);	
					str = "";
					if (oneContact.name != null) {
						str += "formaté : " + oneContact.name.formatted + "\n";
						str += "family : " + oneContact.name.familyName + "\n";
						str += "given : " + oneContact.name.givenName + "\n";
						str += "middle : " + oneContact.name.middleName + "\n";
					}
					str += "display : " + oneContact.displayName + "\n";
					str += "nick : " + oneContact.nickname + "\n";
					//
					var exist = "" + oneContact.name.formatted + oneContact.name.familyName + oneContact.name.givenName + oneContact.name.middleName;
					exist += "" + oneContact.displayName + oneContact.nickname ;
					//
					//if (exist!="") cast(("#" + itemEl.id + " .nameList").get(), TextAreaElement).value = str ;					
					for (o in oneContact.phoneNumbers) {
						"next phone".trace();
						var onePhone:ContactField = o ;
						str = "";
						str += "" + onePhone.type + " : " + onePhone.value + "<br/>";
						//cast(("#" + itemEl.id + " .phoneList").get(), TextAreaElement).value = str ;						
					}
				}
			}
			
		}
		*/
	
		
		
		
		var f = 0; var y = 0; var p = 0; var d = 0;
		//------------------
		for (ct in contacts) {
			if (g.strVal(ct.displayName, "") != "") d++;					
				
			if (ct.name != null) {				
				if (g.strVal(ct.name.formatted, "") != "") f++;					
				if (g.strVal(ct.name.familyName, "") != "") y++;
				if (ct.phoneNumbers != null) {
					if (ct.phoneNumbers.length>0) {
						p+=ct.phoneNumbers.length;
					}
				}
			}
		}
		//------------------
		"fin".trace();
		("display=" + d + " match").trace();
		("f=" + f + " match").trace();
		("y=" + y + " match").trace();
		("p=" + p + " match").trace();
		
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
		str += 		"<br/>";
		str += 		"<button class='bSearch' type='button' >Chercher</button>";
		str += 		"<br/>";
		str += 		"<div class='contactDisplay'>";
		str +=			"<h2></h2>";		
		str += 			"<div class='itemCtnr'>" ;
		str += 				"<div id='itemTemplate'>" ;
		str += 					"<br/>";
		str += 					"<label>Noms : </label>" ;
		str += 					"<textarea readonly='readonly' class='nameList'></textarea>";
		str += 					"<label>Num&eacute;ros : </label>" ;
		str += 					"<textarea readonly='readonly' class='phoneList'></textarea>";		
		str += 				"</div>";
		str += 			"</div>";
		str += 		"</div>";
		str += 		"<br/>";
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
		css += 		"border:dashed 1px #555;";		
		css += 		"font-size:1.5rem;";
		css += "}";			
		css += "#contactCtnr label, #contactCtnr input, #contactCtnr textarea, #contactCtnr button  {";
		css += 		"display:block;";
		css += 		"font-size:1.5rem;";
		css += "}";
		css += "#contactCtnr textarea {";
		css += 		"min-height:12rem;";
		css += 		"width:17rem;";	
		css += "}";
		css += "#contactCtnr textarea.search {";
		css += 		"min-height:6rem;";
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