/**
 * Copyright (c) jm Delettre.
 */
/**
* app root package
*/
package;
/**
* classes imports
*/

import apix.common.event.StandardEvent;
import apix.common.util.Global;
import cordova.navigator.Accelerometer;
import cordova.navigator.Accelerometer.AccelerometerOptions;
import cordova.navigator.Compass;
import cordova.navigator.Compass.CompassOptions;
import cordova.navigator.Pop;
import js.html.Event;
import js.html.sql.Database;
import js.html.sql.Error;
import js.html.sql.ResultSet;
import js.html.sql.Transaction;
import cordova.CordovaEvent; // << cordova.CordovaEvent.BatteryStatusEvent
import cordova.navigator.App;
import cordova.navigator.Camera;
import cordova.navigator.Camera.DestinationType;
import cordova.navigator.Contacts;
import cordova.navigator.Device;
import cordova.navigator.Geolocation;
import info.InfoCtnr;
import js.Browser;
import js.html.Element;
import js.html.ImageElement;
//
//
using apix.common.event.EventTargetExtender;
using apix.common.display.ElementExtender;
using apix.common.util.StringExtender;

/**
* root class
*/
using apix.common.util.StringExtender;
using apix.common.display.ElementExtender;
using apix.common.util.FloatExtender; 
class Main {
	var g:Global;
	var infoCtnr:InfoCtnr;
	var dbCtnr:InfoCtnr;
	var pluginBloc:Info;
	var chBloc:Info;
	var compass:Element;
	var db:Database;
	function new () {
		g=Global.get();
		g.setupTrace();		
		//
		compass="#compass".get();
		//
		infoCtnr = new InfoCtnr("#info", "Test des plugins Cordova");	
		infoCtnr.addLine("(g&eacute;olocalisation - contacts - etc)");
		//
		//		
		compassTest();		
		dbTest();
		accelTest();
		evtTest();
		butTest();
		camTest();	// ...and other cordova plugins tests
		
	}
	
	/**/
	
	//------------------------ DB SQL lite Test
	function dbTest () {	
		"#appendDbButId".on(StandardEvent.CLICK, onAppendDbClick);
		"#clearDbButId".on(StandardEvent.CLICK, onClearDbClick);
		db = openDb();
		readDb();
	}
	function openDb () :Database {
		return Browser.window.openDatabase("testdb", "1.0", "Cordova Demo", 200000);
	}
	function readDb() {
		db.transaction(selectDb, onErrorReadDb);
	}
	function selectDb (tx:Transaction) :Bool {
		tx.executeSql("CREATE TABLE IF NOT EXISTS demo (id unique, label, stock)",[]);
		tx.executeSql( "SELECT * FROM demo" , [] , displayDb , onDbExecuteError);	
		return true;
	}
	function displayDb (tx:Transaction, result:ResultSet) : Bool {	
		if (dbCtnr != null) dbCtnr.remove();
		dbCtnr = new InfoCtnr("#dbDisplay", "Lecture de la table 'demo'");	
		dbCtnr.addLine("lignes affect&eacute;e(s) =" + result.rowsAffected);
		var len = result.rows.length ;
		if (len == 0) dbCtnr.addLine("La table est vide !");
		else {
			dbCtnr.addLine("Nombre de lignes lues =" + len);
			for (i in 0...len) {
				var dbBloc = dbCtnr.add("ligne #"+(i+1));
				dbBloc.addLine("item :" + result.rows.item(i).id );
				dbBloc.addLine("label :" + result.rows.item(i).label );
				dbBloc.addLine("stock :" + result.rows.item(i).stock );
			}
		}
		return true ;
	}
	function  onAppendDbClick (e) {	
		db.transaction(insertDb, onErrorInsertDb, onSuccessInsertDb);
	}
	function  insertDb (tx:Transaction) :Bool {	
		var id=".dbCtnr input#id".get().text();
		var label=".dbCtnr input#label".get().text();
		var stock=g.numVal(".dbCtnr input#stock".get().text(),0);
		tx.executeSql("CREATE TABLE IF NOT EXISTS demo (id unique, label, stock)",[]);
		tx.executeSql("INSERT INTO demo (id, label, stock ) VALUES ( '" + id + "' , '" + label + "' , " + stock + ")", []);
		return true;
	}
	function  onSuccessInsertDb () :Bool {	
		readDb();
		return true;
	}
	function  onClearDbClick (e) {	
		db.transaction(dropDbTable, onErrorDropDbTable, onSuccessDropDbTable);
	}
	function  dropDbTable(tx:Transaction) : Bool {	
		tx.executeSql('DROP TABLE IF EXISTS demo', []);
		return true ;
	}
	function  onSuccessDropDbTable () :Bool {	
		readDb();
		return true ;
	}
	function onErrorDropDbTable (err:Error) : Bool {
		("DB drop demo error #"+err.code+":"+err.message).alert();
		return false;
	}
	function onErrorInsertDb (err:Error) : Bool {
		("DB insert error #"+err.code+":"+err.message).alert();
		return false;
	}
	function onErrorReadDb (err:Error) : Bool {
		("DB read error #"+err.code+":"+err.message).alert();
		return false;
	}
	function onDbExecuteError (tx:Transaction,err:Error) : Bool {
		("DB Select error #"+err.code+":"+err.message).alert();
		return false;
	}	
	//------------------------ orientation / compass Test
	function compassTest () {			
		var opt:CompassOptions = { frequency:100 };
		//Compass.getCurrentHeading(onCurHeading, onCurHeadingError);
		var watchID = Compass.watchHeading(onCurHeading, onCurHeadingError,opt);
	}	
	function onCurHeading(heading:CompassHeading) {
		//compass.setRotation(-heading.trueHeading);
		compass.setRotation(-heading.magneticHeading);		
		/*
		(chBloc==null)?chBloc = infoCtnr.add("Orientations");
		chBloc.addLine("------------------------------") ;
		chBloc.addLine("magneticHeading: " + heading.magneticHeading) ;
		chBloc.addLine("trueHeading : " + heading.trueHeading) ;
		chBloc.addLine("headingAccuracy : " + heading.headingAccuracy) ;
		chBloc.addLine("timestamp : " + heading.timestamp);		
		*/
	}
	function onCurHeadingError(error:CompassError) {
		("CompassError: " + error.code).alert();
	}
	//------------------------ acceleration Test
	function accelTest () {	
		var opt:AccelerometerOptions = { frequency:500 };
		var watchID = Accelerometer.watchAcceleration(onAccel, onAccelError, opt);
	}	
	function onAccel(accel:Acceleration) {
		"#xId".get().text(accel.x.string(10,{len:7})); 
		"#yId".get().text(accel.y.string(10,{len:7})); 
		"#zId".get().text(accel.z.string(10,{len:7})); 
	}
	function onAccelError() {
		"#xId".get().text(""); 
		"#yId".get().text("erreur de d&eacute;tection de mouvement !" ); 
		"#zId".get().text(""); 
	}
	
	//------------------------ vibrate and close buttons test
	function butTest () {	
		"#closeButId".on(StandardEvent.CLICK, onCloseClick);
		"#vibrateButId".on(StandardEvent.CLICK, onVibrateClick);
		"#alert".on(StandardEvent.CLICK, onAlertClick);
		"#prompt".on(StandardEvent.CLICK, onPromptClick);
		"#confirm".on(StandardEvent.CLICK, onConfirmClick);
		
		"#beep".on(StandardEvent.CLICK, onBeepClick);
		
		
	}
	function onVibrateClick (e) {	
		 Navigator.vibrate([1000, 500, 1000, 500, 1000]);		
	}
	function onCloseClick (e) {	
		 App.exitApp();		
	}
	function onAlertClick (e:Event) {	
		Pop.alert ("Alerte simple avec callBack", onAlertOut, "Alerte Cordova", "Valider SVP");
	}
	function onPromptClick (e:Event) {	
		Pop.prompt ("Quel age a jesus+ ?", onPromptOut, "Boite à questions Cordova", ["Valider","Abandonner"],"33");		
	}
	function onConfirmClick (e:Event) {	
		Pop.confirm ("est-on d'accord ?", onConfirmOut, "Confirm-box Cordova", ["Oui","Bof"]);		
	}	
	function onBeepClick (e:Event) {	
		Pop.beep(1);		
	}	
	//
	function onAlertOut () {	
		Pop.beep(1);
	}
	function onPromptOut (n:Int) {	
		Pop.beep(n*2);	
	}
	function onConfirmOut (n:Int) {	
		Pop.beep(n*4);	
	}
	//------------------------ mobile spécific -events or buttons-  tests
	function evtTest () {	
		Browser.document.on(CordovaEvent.RESUME, onResume) ; // OR Browser.document.on(CordovaEvent.PAUSE, onPause) ; // OR  
		Browser.document.on(CordovaEvent.MENU_BUTTON, onMenuButton) ; 
		Browser.document.on(CordovaEvent.SEARCH_BUTTON, onSearchButton) ; 
		Browser.document.on(CordovaEvent.OFF_LINE, onOffLine) ; 
		Browser.document.on(CordovaEvent.BACK_BUTTON, onBackButton) ; 
		//not ok :Browser.document.on(CordovaEvent.START_CALL_BUTTON, onStartCall) ; // Browser.document.on(CordovaEvent.END_CALL_BUTTON, onEndCall) ; 		
		// test it on my tablet : Browser.document.on(CordovaEvent.VOLUME_DOWN_BUTTON, onVolumeDown) ; 
		// test it on my tablet : Browser.document.on(CordovaEvent.VOLUME_UP_BUTTON, onVolumeUp) ; 
		//	
	}
	function onPause () {	
		"c'est la pause !".alert();
	}
	function onResume () {	
		"La pause c'est fini !".alert();
	}
	function onBackButton () {	
		"De quoi ! Tu veux sortir ! ".alert();
		 App.exitApp();
	}
	function onMenuButton () {	
		"Y'a pas de menu :-( ".alert();
	}
	function onSearchButton () {	
		"Kek tu veux mec !! ".alert();
	}
	function onStartCall () {	
		"ça d&eacute;marre".alert();
	}
	function onEndCall () {	
		"ça s'arr&ecirc;te".alert();
	}
	function onOffLine () {	
		"On est offLine !!!".alert();
	}
	function onVolumeDown () {	
		"Le volume du son baisse ! ".alert();
	}
	function onVolumeUp () {	
		"Le volume du son monte ! ".alert();
	}
	//------------------- camera test
	function camTest () {	
		"#photoButId".on("click", onSelfieClick);
		deviceTest ();
	}
	function onSelfieClick (e) {	
		Camera.getPicture(onCamSuccess, onCamError, { targetWidth:400, targetHeight:400 ,quality: 50, destinationType: DestinationType.DATA_URL } );			
	}
	function onCamSuccess(imageData) {
		var image = cast(Browser.document.getElementById("imgId"),ImageElement);
		image.src = "data:image/jpeg;base64," + imageData;
	}
	function onCamError(m:String) {
		("Erreur : " + m).alert() ;
	}
	//------------------- geolocation test
	function geoLocTest () {	
		Geolocation.getCurrentPosition(onGeolocSuccess, onGeolocError,{enableHighAccuracy:true});		
	}
	function onGeolocSuccess (position:Position) {			
		var geoBloc = infoCtnr.add("Geolocation");
		geoBloc.addLine("Latitude: "   		+ position.coords.latitude );
		geoBloc.addLine("Longitude: "       + position.coords.longitude );
		//geoBloc.addLine("Altitude: "          + position.coords.altitude );
		geoBloc.addLine("Accuracy: "          + position.coords.accuracy );
		//geoBloc.addLine("Altitude Accuracy: " + position.coords.altitudeAccuracy  );
		//geoBloc.addLine("Heading: "           + position.coords.heading      );     
		//geoBloc.addLine("Speed: "             + position.coords.speed      );       
		geoBloc.addLine("Timestamp: "         + position.timestamp  );
		//
		contactsTest();
	};
	function onGeolocError(error:PositionError) {
		var geoBloc = infoCtnr.add("Geolocation");
		geoBloc.addLine("code: "   		+ error.code );
		geoBloc.addLine("message: "       + error.message );
	}
	//------------------------ battery test
	function batteryTest () {	
		Browser.window.addEventListener(CordovaEvent.BATTERY_STATUS, onBatteryStatus, false);
	}
	function onBatteryStatus(info:BatteryStatusEvent) {		
		var batBloc = infoCtnr.add("Test de la batterie : ");
		batBloc.addLine("Niveau (%) : " + info.level );
		batBloc.addLine("En charge sur secteur ? : " + (info.isPlugged?"Oui":"Non"));
		
		geoLocTest();
	}
	//------------------------ device informations tests
	function deviceTest () {
		var devBloc = infoCtnr.add("Infos sur l'appareil :");
		devBloc.addLine("Mod&egrave;le : "   	+ Device.model );
		devBloc.addLine("Cordova version : "   	+ Device.cordova );
		devBloc.addLine("Plateforme : "   	+ Device.platform );
		devBloc.addLine("Version syst&egrave;me : "   	+ Device.version );
		devBloc.addLine("Identifiant Unique Universel : "   	+ Device.uuid );
		batteryTest () ;
	}
	//------------------------ reading phone contacts test
	function contactsTest () {	
		var options :ContactFindOptions=new ContactFindOptions();
		options.multiple = true;
		//options.desiredFields = [FieldType.id,FieldType.displayName];
		var fields:Array<Dynamic>    = [FieldType.displayName,FieldType.name];
		Contacts.find(fields, onContactSuccess, onContactError, options);
	}	
	function onContactSuccess(contacts:Array<Contact>) {
		var ctBloc = infoCtnr.add("Contacts");
		ctBloc.addLine(" " + contacts.length + " contact(s) trouv&eacute(s) "   );		
		for (ct in contacts) {
			if (ct.name != null) {
				if (ct.phoneNumbers != null) {
					if (ct.phoneNumbers.length>1) {
						if (g.strVal(ct.name.formatted, "") != "") {
							if (g.strVal(ct.name.familyName,"") != "") {
								var oneCtBloc = ctBloc.add("given name : " + ct.name.givenName);					
								var no = ct.phoneNumbers;
								var o:Dynamic=null;
								for (o in ct.phoneNumbers) {
									oneCtBloc.addLine(o.type + '=' + o.value);
								}					
								oneCtBloc.addLine("formatted name : " + ct.name.formatted);
								oneCtBloc.addLine("family name : " + ct.name.familyName);
							}
						}
					}
				}
			}
		}
	}
				
	function onContactError(contactError) {
		var ctBloc = infoCtnr.add("Contacts");		
		ctBloc.addLine(" contacts erreur !!! "   );
	};
	//------------------------ 
	//------------------------ 
	static function main() {  
		 new Main();
	}	
	
}