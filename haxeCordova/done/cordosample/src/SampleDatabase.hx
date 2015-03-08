/**
* app root package
*/
package;
/**
* classes imports
*/
import apix.common.util.Global;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.InputElement;
import js.html.sql.Database;
import js.html.sql.Error;
import js.html.sql.ResultSet;
import js.html.sql.Transaction;
import js.html.StyleElement;
import js.html.TextAreaElement;
//
//
using apix.common.util.StringExtender;
//
/**
* root class
*/
class SampleDatabase {
	var g:Global;
 	var callback:Dynamic;
	var itemTemplateEl:Element;
	var db:Database;
	public function new (?cb:Dynamic) {		
		g=Global.get();
		//
		callback = cb;
		createHtmlCss();
		//events
		"#appendDbButId".get().addEventListener("click", onAppendDbClick);
		"#clearDbButId".get().addEventListener("click", onClearDbClick);
		db = openDb();
		readDb();
		if (callback != null) 	callback();
	}	
	function createHtmlCss() {		
		// append html
		var str = "";
		str += "<div class='dbCtnr'>";
		str +=		"<h2>Saisie dans une table de la base de donn&eacute;e</h2>";
		str += 		"<label>Nom : </label>" ;
		str += 		"<input type = 'text' id = 'lastname' />";
		str += 		"<label>Pr&eacute;nom : </label>" ;
		str += 		"<input type = 'text' id = 'firstname' />";
		str += 		"<label>Email : </label>" ;
		str += 		"<input type = 'text' id = 'email' />";
		str += 		"<label>Message : </label>" ;
		str += 		"<textarea id = 'message'></textarea>";		
		str += 		"<br/><br/>";
		str += 		"<button id='appendDbButId' type='button' >Ajouter</button>";
		str += 		"<br/>";
		str += 		"<button id='clearDbButId'  type='button' >Raz de la table</button>";
		str += 		"<br/>";
		str += 		"<div class='dbDisplay'>";
		str +=			"<h2></h2>";		
		str += 			"<div class='itemCtnr'>" ;
		str += 				"<div id='itemTemplate'>" ;
		str += 					"<br/>";
		str += 					"<span class='id'></span>";		
		str += 					"<label>Nom : </label>" ;
		str += 					"<span class='lastname'></span>";
		str += 					"<label>Pr&eacute;nom : </label>" ;
		str += 					"<span class='firstname'></span>";
		str += 					"<label>Email : </label>" ;
		str += 					"<span class='email'></span>";
		str += 					"<label>Message : </label>" ;
		str += 					"<span class='message'></span>";		
		str += 				"</div>";
		str += 			"</div>";
		str += 		"</div>";
		str += "</div>";
		var el="div".createElem(); // Browser.document.createElement("div") ;
		el.innerHTML = str;		
		var dbEl=el.childNodes[0];		
		"#appHtmlCtnr".get().appendChild(dbEl); // N-E-V-E-R do an innerHTML+=
		itemTemplateEl = ".dbCtnr #itemTemplate".get();
		".dbCtnr .itemCtnr".get().removeChild(itemTemplateEl);
		//
		// append css		
		var css = "";
		css += ".dbCtnr {";
		css += 		"margin-top:2rem;";
		css += 		"padding:.5rem;";
		css += 		"width:17.5rem;";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";
		css += 		"border:dashed 1px #555;";
		css += 		"background-color:#fdfdfd;";		
		css += "}";
		css += ".dbCtnr label, .dbCtnr input, .dbCtnr textarea, .dbCtnr button, .dbCtnr span  {";
		css += 		"display:block;";
		css += 		"font-size:1.5rem;";
		css += "}";
		css += ".dbCtnr textarea {";
		css += 		"height:12rem;";
		css += 		"width:17rem;";	
		css += "}";
		css += ".dbCtnr span  {";
		css += 		"border:solid 1px #555;";
		css += 		"width:17.5rem;";
		css += 		"background-color:#f5f5f5;";
		css += "}";
		css += ".dbCtnr span.id  {";
		css += 		"width:3rem;";
		css += 		"xborder:solid 0px ;";
		css += 		"xbackground-color:#fff;";
		css += "}";
		css += ".dbCtnr button  {";
		css += 		"margin-left:auto;";
		css += 		"margin-right:auto;";
		css += "}";		
		css += ".dbCtnr span.message  {";
		css += 		"height:auto;";
		css += 		"max-height:12rem;";		
		css += 		"overflow:auto;";	
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
	function ads(str) {
		return g.strReplace(str, "'", "''");
	}
	//
	function openDb () :Database {
		return Browser.window.openDatabase("sampleDb", "1.0", "Cordova Sample", 200000);
	}
	function readDb() {
		db.transaction(selectDb, onErrorDb);
	}
	function selectDb (tx:Transaction) :Bool {
		tx.executeSql("CREATE TABLE IF NOT EXISTS demo (lastname,firstname,email,message )",[]);
		tx.executeSql( "SELECT * FROM demo" , [] , displayDb , onDbExecuteError);	
		return true;
	}
	function displayDb (tx:Transaction, result:ResultSet) : Bool {	
		".dbCtnr .dbDisplay .itemCtnr".get().innerHTML="";
		var len = result.rows.length ;
		if (len == 0) ".dbCtnr .dbDisplay h2".get().textContent="La table est vide !";
		else {
			".dbCtnr .dbDisplay h2".get().textContent="Contenu de la table:";
			for (i in 0...len) {
				var itemEl:Element = cast(itemTemplateEl.cloneNode(true));
				itemEl.id = "item_" + i;
				".dbCtnr .dbDisplay .itemCtnr".get().appendChild(itemEl);				
				("#" + itemEl.id + " .id").get().textContent = "#"+(i+1) ;
				("#" + itemEl.id + " .lastname").get().innerHTML = result.rows.item(i).lastname+"&nbsp;" ;
				("#" + itemEl.id + " .firstname").get().innerHTML = result.rows.item(i).firstname+"&nbsp;" ;
				("#" + itemEl.id + " .email").get().innerHTML = result.rows.item(i).email+"&nbsp;" ;
				("#" + itemEl.id + " .message").get().innerHTML = result.rows.item(i).message +"&nbsp;";
			}
		}
		return true ;
	}
	function  onAppendDbClick (e:Event) {	
		db.transaction(insertDb, onErrorDb, onSuccessInsertDb);
	}
	function  insertDb (tx:Transaction) :Bool {	
		var lastname:InputElement=cast(".dbCtnr input#lastname".get());
		var firstname:InputElement=cast(".dbCtnr input#firstname".get());
		var email:InputElement=cast(".dbCtnr input#email".get() );
		var message:TextAreaElement=cast(".dbCtnr textarea#message".get() );
		tx.executeSql("CREATE TABLE IF NOT EXISTS demo (lastname , firstname , email , message) ; ",[]);
		tx.executeSql("INSERT INTO demo (lastname , firstname , email , message) VALUES ( '" + lastname.value + "' , '" + firstname.value + "' , '" + email.value + "' , '" + ads(message.value) + "'  ) ; "    , []);
		return true;
	}
	function  onSuccessInsertDb () :Bool {	
		readDb();
		return true;
	}
	function  onClearDbClick (e:Event) {	
		db.transaction(dropDbTable, onErrorDb, onSuccessDropDbTable);
	}
	function  dropDbTable(tx:Transaction) : Bool {	
		tx.executeSql('DROP TABLE IF EXISTS demo', []);
		return true ;
	}
	function  onSuccessDropDbTable () :Bool {	
		readDb();
		return true ;
	}
	function onErrorDb (err:Error) : Bool {
		("DB drop demo error #"+err.code+":"+err.message).alert();
		return false;
	}
	function onDbExecuteError (tx:Transaction,err:Error) : Bool {
		("DB Select error #"+err.code+":"+err.message).alert();
		return false;
	}
	
}