(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
EReg.__name__ = true;
EReg.prototype = {
	match: function(s) {
		if(this.r.global) this.r.lastIndex = 0;
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	,__class__: EReg
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
var Main = function() {
	new SampleEvent($bind(this,this.geolocation));
	new SampleDevice();
	new SampleSOS();
};
Main.__name__ = true;
Main.main = function() {
	apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(apix.common.util.StringExtender.createElem("h1")).textContent = "HX-Cordova";
	apix.common.util.StringExtender.get("#appHtmlCtnr h1").style.width = "280px";
	Main.g = apix.common.util.Global.get();
	Main.g.setupTrace("appHtmlCtnr");
	new Main();
};
Main.prototype = {
	geolocation: function() {
		new SampleGeolocation($bind(this,this.compass));
	}
	,compass: function() {
		new SampleCompass($bind(this,this.camera));
	}
	,camera: function() {
		new SampleCamera($bind(this,this.database));
	}
	,database: function() {
		new SampleDatabase($bind(this,this.motion));
	}
	,motion: function() {
		new SampleMotion($bind(this,this.contact));
	}
	,contact: function() {
		new SampleContact($bind(this,this.end));
	}
	,end: function() {
		apix.common.util.StringExtender.trace("c fini",null);
	}
	,__class__: Main
};
Math.__name__ = true;
var SampleCamera = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createButton();
	this.createEmptyImg();
	this.bt.addEventListener("click",$bind(this,this.onClick));
	if(this.callback != null) this.callback();
};
SampleCamera.__name__ = true;
SampleCamera.prototype = {
	onClick: function(e) {
		if(this.g.get_isMobile()) navigator.camera.getPicture($bind(this,this.onCamSuccess),$bind(this,this.onCamError),{ targetWidth : 400, targetHeight : 400, quality : 50, destinationType : Camera.DestinationType.DATA_URL}); else this.img.src = "img/photo.jpg";
	}
	,onCamSuccess: function(imageData) {
		this.img.src = "data:image/jpeg;base64," + imageData;
	}
	,onCamError: function(m) {
		js.Lib.alert("Erreur photo : " + m);
	}
	,createButton: function() {
		this.bt = apix.common.util.StringExtender.createElem("button");
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(this.bt);
		this.bt.style.fontSize = "2em";
		this.bt.style.marginTop = "2em";
		this.bt.style.display = "block";
		this.bt.style.marginLeft = "auto";
		this.bt.style.marginRight = "auto";
		this.bt.type = "button";
		this.bt.textContent = "Prendre une photo";
	}
	,createEmptyImg: function() {
		this.img = apix.common.util.StringExtender.createElem("img");
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(this.img);
		this.img.style.marginTop = "2em";
		this.img.style.width = "400px";
		this.img.style.height = "auto";
		this.img.style.display = "block";
		this.img.style.marginLeft = "auto";
		this.img.style.marginRight = "auto";
	}
	,__class__: SampleCamera
};
var SampleCompass = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createCompassElement();
	var opt = { frequency : 100};
	if(this.g.get_isMobile()) this.watchID = navigator.compass.watchHeading($bind(this,this.onWatchHeading),$bind(this,this.onWatchHeadingError),opt); else if(this.callback != null) this.callback();
};
SampleCompass.__name__ = true;
SampleCompass.prototype = {
	onWatchHeading: function(heading) {
		this.setRotation(this.img,-heading.magneticHeading);
		if(this.callback != null) {
			this.callback();
			this.callback = null;
		}
	}
	,onWatchHeadingError: function(error) {
		apix.common.util.StringExtender.alert("CompassError: " + Std.string(error.code));
	}
	,createCompassElement: function() {
		var back = apix.common.util.StringExtender.createElem("img");
		back.src = "img/compass.back.png";
		this.img = apix.common.util.StringExtender.createElem("img");
		this.img.src = "img/compass.arrow.png";
		var ctnr = apix.common.util.StringExtender.createElem("div");
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(ctnr);
		ctnr.appendChild(back);
		ctnr.appendChild(this.img);
		ctnr.style.position = "relative";
		ctnr.style.top = "1em";
		ctnr.style.width = "300px";
		ctnr.style.height = "300px";
		ctnr.style.marginLeft = "auto";
		ctnr.style.marginRight = "auto";
		back.style.position = "absolute";
		back.style.display = "inline-block";
		this.img.style.position = "absolute";
		this.img.style.display = "inline-block";
	}
	,setRotation: function(e,v) {
		var el = e;
		var r;
		if(v == null) r = "null"; else r = "" + v;
		if(this.g.get_isWebKit()) el.style.webkitTransform = "rotate(" + r + "deg)"; else if(this.g.get_isFirefox()) el.style.mozTransform = "rotate(" + r + "deg)"; else if(this.g.get_isIE()) el.style.msTransform = "rotate(" + r + "deg)"; else if(this.g.get_isOpera()) el.style.oTransform = "rotate(" + r + "deg)"; else if(this.g.get_isKhtml()) el.style.khtmlTransform = "rotate(" + r + "deg)"; else el.style.transform = "rotate(" + r + "deg)";
	}
	,__class__: SampleCompass
};
var SampleContact = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createHtmlCss();
	apix.common.util.StringExtender.get("#contactCtnr .search").addEventListener("input",$bind(this,this.findContact));
	if(this.callback != null) this.callback();
};
SampleContact.__name__ = true;
SampleContact.prototype = {
	findContact: function(e) {
		apix.common.util.StringExtender.get("#contactCtnr .search").removeEventListener("input",$bind(this,this.findContact));
		apix.common.util.StringExtender.get("#contactCtnr .contactDisplay").innerHTML = "";
		var v = (js.Boot.__cast(apix.common.util.StringExtender.get("#contactCtnr .search") , HTMLInputElement)).value;
		var options = new ContactFindOptions();
		options.multiple = true;
		options.filter = v;
		var fields = [navigator.contacts.fieldType.displayName,navigator.contacts.fieldType.$name];
		navigator.contacts.find(fields,$bind(this,this.onContactSuccess),$bind(this,this.onContactError),options);
	}
	,onContactSuccess: function(contacts) {
		var str = "";
		var n = -1;
		var _g = 0;
		while(_g < contacts.length) {
			var oneContact = contacts[_g];
			++_g;
			str = apix.common.util.StringExtender.unspaced(oneContact.displayName);
			if(str.length > 1) {
				if(oneContact.phoneNumbers != null) {
					if(oneContact.phoneNumbers.length > 0) {
						n++;
						var j = -1;
						var _g1 = 0;
						var _g2 = oneContact.phoneNumbers;
						while(_g1 < _g2.length) {
							var onePhone = _g2[_g1];
							++_g1;
							var t = apix.common.util.StringExtender.unspaced(onePhone.type);
							var v = apix.common.util.StringExtender.unspaced(onePhone.value);
							if((t + v).length > 1) {
								j++;
								var itemEl = this.createNewEmptyItem("" + n + "-" + j);
								apix.common.util.StringExtender.get("#" + itemEl.id + " .name").innerHTML = str;
								apix.common.util.StringExtender.get("#" + itemEl.id + " .type").innerHTML = t;
								apix.common.util.StringExtender.get("#" + itemEl.id + " .phone").innerHTML = v;
							}
						}
					}
				}
			}
		}
		apix.common.util.StringExtender.get("#contactCtnr .search").addEventListener("input",$bind(this,this.findContact));
	}
	,onContactError: function(contactError) {
		apix.common.util.StringExtender.get("#contactCtnr .search").addEventListener("input",$bind(this,this.findContact));
		js.Lib.alert(" Erreur durant la lecture du carnet d'adresse !!! ");
	}
	,createNewEmptyItem: function(v) {
		var itemEl = this.itemTemplateEl.cloneNode(true);
		itemEl.id = "itemContact_" + v;
		return js.Boot.__cast(apix.common.util.StringExtender.get("#contactCtnr .contactDisplay").appendChild(itemEl) , Element);
	}
	,createHtmlCss: function() {
		var str = "";
		str += "<div id='contactCtnr'>";
		str += "<h2>Les contacts</h2>";
		str += "<input class = 'search' placeholder=\"entrer une partie du nom...\"/>";
		str += "<div class='contactDisplay'>";
		str += "<div id='itemTemplate' class='item'> ";
		str += "<span  class='name'></span>";
		str += "<span  class='type'></span>";
		str += "<span  class='phone'></span>";
		str += "</div>";
		str += "</div>";
		str += "<br/>";
		str += "<br/>";
		str += "</div>";
		var el = apix.common.util.StringExtender.createElem("div");
		el.innerHTML = str;
		var dvEl = el.childNodes[0];
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(dvEl);
		this.itemTemplateEl = apix.common.util.StringExtender.get("#contactCtnr #itemTemplate");
		apix.common.util.StringExtender.get("#contactCtnr .contactDisplay").removeChild(this.itemTemplateEl);
		var css = "";
		css += "#contactCtnr {";
		css += "margin-top:2rem;";
		css += "padding:2px;";
		css += "width:18.5rem;";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "}";
		css += "#contactCtnr .contactDisplay {";
		css += "margin-top:10px;";
		css += "min-height:20rem;";
		css += "border-bottom:solid 1px #aaa;";
		css += "}";
		css += "#contactCtnr .item {";
		css += "border-top:solid 1px #aaa;";
		css += "padding-top:7px;";
		css += "padding-bottom:7px;";
		css += "}";
		css += "#contactCtnr .item span {";
		css += "display:inline-block;";
		css += "overflow:hidden;";
		css += "vertical-align:middle;";
		css += "}";
		css += "#contactCtnr .item .name {";
		css += "font-size:.9rem;";
		css += "width:120px;";
		css += "height:16px;";
		css += "text-overflow:ellipsis;";
		css += "}";
		css += "#contactCtnr .item .type {";
		css += "margin-left:5px;";
		css += "font-size:.9rem;";
		css += "width:50px;";
		css += "height:16px;";
		css += "}";
		css += "#contactCtnr .item .phone{";
		css += "margin-left:5px;";
		css += "font-size:1rem;";
		css += "width:110px;";
		css += "}";
		css += "#contactCtnr .search {";
		css += "font-size:1.4rem;";
		css += "width:280px;";
		css += "display:inline-block;";
		css += "overflow:hidden;";
		css += "border:solid 2px #555;";
		css += "}";
		var head = window.document.head;
		var styleEl = apix.common.util.StringExtender.get("style",head);
		if(styleEl == null) {
			window.document.head.appendChild(apix.common.util.StringExtender.createElem("style"));
			styleEl = apix.common.util.StringExtender.get("style",head);
		}
		styleEl.innerHTML += css;
	}
	,__class__: SampleContact
};
var SampleDatabase = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createHtmlCss();
	apix.common.util.StringExtender.get("#appendDbButId").addEventListener("click",$bind(this,this.onAppendDbClick));
	apix.common.util.StringExtender.get("#clearDbButId").addEventListener("click",$bind(this,this.onClearDbClick));
	this.db = this.openDb();
	this.readDb();
	if(this.callback != null) this.callback();
};
SampleDatabase.__name__ = true;
SampleDatabase.prototype = {
	createHtmlCss: function() {
		var str = "";
		str += "<div class='dbCtnr'>";
		str += "<h2>Saisie dans une table de la base de donn&eacute;e</h2>";
		str += "<label>Nom : </label>";
		str += "<input type = 'text' id = 'lastname' />";
		str += "<label>Pr&eacute;nom : </label>";
		str += "<input type = 'text' id = 'firstname' />";
		str += "<label>Email : </label>";
		str += "<input type = 'text' id = 'email' />";
		str += "<label>Message : </label>";
		str += "<textarea id = 'message'></textarea>";
		str += "<br/><br/>";
		str += "<button id='appendDbButId' type='button' >Ajouter</button>";
		str += "<br/>";
		str += "<button id='clearDbButId'  type='button' >Raz de la table</button>";
		str += "<br/>";
		str += "<div class='dbDisplay'>";
		str += "<h2></h2>";
		str += "<div class='itemCtnr'>";
		str += "<div id='itemTemplate'>";
		str += "<br/>";
		str += "<span class='id'></span>";
		str += "<label>Nom : </label>";
		str += "<span class='lastname'></span>";
		str += "<label>Pr&eacute;nom : </label>";
		str += "<span class='firstname'></span>";
		str += "<label>Email : </label>";
		str += "<span class='email'></span>";
		str += "<label>Message : </label>";
		str += "<span class='message'></span>";
		str += "</div>";
		str += "</div>";
		str += "</div>";
		str += "</div>";
		var el = apix.common.util.StringExtender.createElem("div");
		el.innerHTML = str;
		var dbEl = el.childNodes[0];
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(dbEl);
		this.itemTemplateEl = apix.common.util.StringExtender.get(".dbCtnr #itemTemplate");
		apix.common.util.StringExtender.get(".dbCtnr .itemCtnr").removeChild(this.itemTemplateEl);
		var css = "";
		css += ".dbCtnr {";
		css += "margin-top:2rem;";
		css += "padding:.5rem;";
		css += "width:17.5rem;";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "border:dashed 1px #555;";
		css += "background-color:#fdfdfd;";
		css += "}";
		css += ".dbCtnr label, .dbCtnr input, .dbCtnr textarea, .dbCtnr button, .dbCtnr span  {";
		css += "display:block;";
		css += "font-size:1.5rem;";
		css += "}";
		css += ".dbCtnr textarea {";
		css += "height:12rem;";
		css += "width:17rem;";
		css += "}";
		css += ".dbCtnr span  {";
		css += "border:solid 1px #555;";
		css += "width:17.5rem;";
		css += "background-color:#f5f5f5;";
		css += "}";
		css += ".dbCtnr span.id  {";
		css += "width:3rem;";
		css += "xborder:solid 0px ;";
		css += "xbackground-color:#fff;";
		css += "}";
		css += ".dbCtnr button  {";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "}";
		css += ".dbCtnr span.message  {";
		css += "height:auto;";
		css += "max-height:12rem;";
		css += "overflow:auto;";
		css += "}";
		var head = window.document.head;
		var styleEl = apix.common.util.StringExtender.get("style",head);
		if(styleEl == null) {
			window.document.head.appendChild(apix.common.util.StringExtender.createElem("style"));
			styleEl = apix.common.util.StringExtender.get("style",head);
		}
		styleEl.innerHTML += css;
	}
	,ads: function(str) {
		return this.g.strReplace(str,"'","''");
	}
	,openDb: function() {
		return window.openDatabase("sampleDb","1.0","Cordova Sample",200000);
	}
	,readDb: function() {
		this.db.transaction($bind(this,this.selectDb),$bind(this,this.onErrorDb));
	}
	,selectDb: function(tx) {
		tx.executeSql("CREATE TABLE IF NOT EXISTS demo (lastname,firstname,email,message )",[]);
		tx.executeSql("SELECT * FROM demo",[],$bind(this,this.displayDb),$bind(this,this.onDbExecuteError));
		return true;
	}
	,displayDb: function(tx,result) {
		apix.common.util.StringExtender.get(".dbCtnr .dbDisplay .itemCtnr").innerHTML = "";
		var len = result.rows.length;
		if(len == 0) apix.common.util.StringExtender.get(".dbCtnr .dbDisplay h2").textContent = "La table est vide !"; else {
			apix.common.util.StringExtender.get(".dbCtnr .dbDisplay h2").textContent = "Contenu de la table:";
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				var itemEl = this.itemTemplateEl.cloneNode(true);
				itemEl.id = "item_" + i;
				apix.common.util.StringExtender.get(".dbCtnr .dbDisplay .itemCtnr").appendChild(itemEl);
				apix.common.util.StringExtender.get("#" + itemEl.id + " .id").textContent = "#" + (i + 1);
				apix.common.util.StringExtender.get("#" + itemEl.id + " .lastname").innerHTML = Std.string(result.rows.item(i).lastname) + "&nbsp;";
				apix.common.util.StringExtender.get("#" + itemEl.id + " .firstname").innerHTML = Std.string(result.rows.item(i).firstname) + "&nbsp;";
				apix.common.util.StringExtender.get("#" + itemEl.id + " .email").innerHTML = Std.string(result.rows.item(i).email) + "&nbsp;";
				apix.common.util.StringExtender.get("#" + itemEl.id + " .message").innerHTML = Std.string(result.rows.item(i).message) + "&nbsp;";
			}
		}
		return true;
	}
	,onAppendDbClick: function(e) {
		this.db.transaction($bind(this,this.insertDb),$bind(this,this.onErrorDb),$bind(this,this.onSuccessInsertDb));
	}
	,insertDb: function(tx) {
		var lastname = apix.common.util.StringExtender.get(".dbCtnr input#lastname");
		var firstname = apix.common.util.StringExtender.get(".dbCtnr input#firstname");
		var email = apix.common.util.StringExtender.get(".dbCtnr input#email");
		var message = apix.common.util.StringExtender.get(".dbCtnr textarea#message");
		tx.executeSql("CREATE TABLE IF NOT EXISTS demo (lastname , firstname , email , message) ; ",[]);
		tx.executeSql("INSERT INTO demo (lastname , firstname , email , message) VALUES ( '" + lastname.value + "' , '" + firstname.value + "' , '" + email.value + "' , '" + this.ads(message.value) + "'  ) ; ",[]);
		return true;
	}
	,onSuccessInsertDb: function() {
		this.readDb();
		return true;
	}
	,onClearDbClick: function(e) {
		this.db.transaction($bind(this,this.dropDbTable),$bind(this,this.onErrorDb),$bind(this,this.onSuccessDropDbTable));
	}
	,dropDbTable: function(tx) {
		tx.executeSql("DROP TABLE IF EXISTS demo",[]);
		return true;
	}
	,onSuccessDropDbTable: function() {
		this.readDb();
		return true;
	}
	,onErrorDb: function(err) {
		js.Lib.alert("DB drop demo error #" + err.code + ":" + err.message);
		return false;
	}
	,onDbExecuteError: function(tx,err) {
		js.Lib.alert("DB Select error #" + err.code + ":" + err.message);
		return false;
	}
	,__class__: SampleDatabase
};
var SampleDevice = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	var str = "";
	str += "Infos sur l'appareil :" + "<br/>";
	str += "Mod&egrave;le : " + cordovax.Device.get_model() + "<br/>";
	str += "Cordova version : " + cordovax.Device.get_cordova() + "<br/>";
	str += "Plateforme : " + cordovax.Device.get_platform() + "<br/>";
	str += "Version syst&egrave;me : " + cordovax.Device.get_version() + "<br/>";
	str += "Id. Unique Universel : <br/>" + cordovax.Device.get_uuid() + "<br/>";
	haxe.Log.trace(str,{ fileName : "SampleDevice.hx", lineNumber : 33, className : "SampleDevice", methodName : "new"});
	if(this.callback != null) this.callback();
};
SampleDevice.__name__ = true;
SampleDevice.prototype = {
	__class__: SampleDevice
};
var SampleEvent = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	window.addEventListener("batterystatus",$bind(this,this.onBatteryStatus),false);
	window.document.addEventListener("pause",$bind(this,this.onPause));
	window.document.addEventListener("resume",$bind(this,this.onResume));
	window.document.addEventListener("menubutton",$bind(this,this.onMenuButton));
	window.document.addEventListener("searchbutton",$bind(this,this.onSearchButton));
	window.document.addEventListener("offline",$bind(this,this.onOffLine));
	window.document.addEventListener("backbutton",$bind(this,this.onBackButton));
	if(this.g.get_isMobile()) {
		console.log("Test de console.log() avec jsConsole.com");
		console.log("File.applicationDirectory=" + cordova.file.applicationDirectory);
		console.log("File.applicationStorageDirectory=" + cordova.file.applicationStorageDirectory);
		console.log("File.dataDirectory=" + cordova.file.dataDirectory);
		console.log("File.cacheDirectory=" + cordova.file.cacheDirectory);
	}
	if(this.callback != null) this.callback();
};
SampleEvent.__name__ = true;
SampleEvent.prototype = {
	onBatteryStatus: function(info) {
		var str = "Etat de la batterie :<br/>";
		str += "Niveau (%) : " + info.level + "<br/>";
		str += "En charge sur secteur ? : " + (info.isPlugged?"Oui":"Non") + "<br/>";
		apix.common.util.StringExtender.trace(str,null);
	}
	,onPause: function(e) {
		navigator.notification.beep(1);
	}
	,onResume: function(e) {
		navigator.notification.alert("Heureux de vous retrouver :))",function() {
			navigator.notification.beep(1);
		},"Ceci n'est pas un titre","Ceci est un bouton");
	}
	,onMenuButton: function(e) {
		navigator.notification.beep(1);
		navigator.notification.alert("Il n'y a pas de menu mais on y travaille :-( ");
	}
	,onSearchButton: function(e) {
		navigator.notification.prompt("Mots clés : ",$bind(this,this.onSearchValid),"Recherche",["Valider","Abandon"],"haxe,cordova");
	}
	,onSearchValid: function(result) {
		var str = "";
		str += "Vous avez cliqué le bouton " + ["Valider","Abandon"][result.buttonIndex - 1] + "\n";
		str += "Vous avez saisi ''" + result.input1 + "''\n";
		str += "Je n'ai rien trouvé !\nMais je n'ai pas bien cherché non plus ;D";
		navigator.notification.alert(str);
	}
	,onOffLine: function(e) {
		navigator.notification.beep(2);
		navigator.notification.alert("La connexion Internet est inexistante !");
		window.document.removeEventListener("offline",$bind(this,this.onOnLine));
		window.document.addEventListener("online",$bind(this,this.onOnLine));
	}
	,onOnLine: function(e) {
		js.Lib.alert("La connexion Internet est active...");
		window.document.removeEventListener("online",$bind(this,this.onOnLine));
		window.document.addEventListener("offline",$bind(this,this.onOnLine));
	}
	,onBackButton: function(e) {
		navigator.notification.confirm("Confirmer ? ",$bind(this,this.onBackValid),"Fermeture de l'application",["Sortir","Rester"]);
	}
	,onBackValid: function(idx) {
		[$bind(this,this.close),function() {
			navigator.notification.alert("Heureux de continuer avec vous ! ");
		}][idx - 1]();
	}
	,close: function() {
		navigator.app.exitApp();
	}
	,__class__: SampleEvent
};
var SampleGeolocation = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	navigator.geolocation.getCurrentPosition($bind(this,this.onGeolocSuccess),$bind(this,this.onGeolocError),{ enableHighAccuracy : true});
};
SampleGeolocation.__name__ = true;
SampleGeolocation.prototype = {
	onGeolocSuccess: function(position) {
		var str = "Votre position :<br/>";
		str += "<h1>" + new apix.common.tools.math.GeoLoc(position.coords.latitude,position.coords.longitude).toString() + "</h1><br/>";
		apix.common.util.StringExtender.trace(str,null);
		if(this.callback != null) this.callback();
	}
	,onGeolocError: function(error) {
		var str = "Géolocation error:<br/>";
		str += "code: " + error.code + " ";
		str += "message: " + error.message + " ";
		js.Lib.alert(str);
	}
	,__class__: SampleGeolocation
};
var SampleMotion = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createMario();
	this.stand = apix.common.util.StringExtender.get("#marioCtnr .stand");
	var opt = { frequency : 41};
	var watchID = navigator.accelerometer.watchAcceleration($bind(this,this.onAccel),$bind(this,this.onAccelError),opt);
	if(this.callback != null) this.callback();
};
SampleMotion.__name__ = true;
SampleMotion.prototype = {
	onAccel: function(accel) {
		this.moveMario(accel.x,accel.y,accel.z);
	}
	,onAccelError: function() {
		(js.Boot.__cast(apix.common.util.StringExtender.get("#xid") , HTMLInputElement)).value = "";
		(js.Boot.__cast(apix.common.util.StringExtender.get("#yid") , HTMLInputElement)).value = "erreur de d&eacute;tection de mouvement !";
		(js.Boot.__cast(apix.common.util.StringExtender.get("#zid") , HTMLInputElement)).value = "";
	}
	,moveMario: function(x,y,z) {
		var v;
		if(cordovax.Device.get_portrait()) v = x; else v = y;
		if(cordovax.Device.get_portrait() || cordovax.Device.get_orientation() == -90) this.left = apix.common.util.StringExtender.get("#marioCtnr .left"); else this.left = apix.common.util.StringExtender.get("#marioCtnr .right");
		if(cordovax.Device.get_portrait() || cordovax.Device.get_orientation() == -90) this.right = apix.common.util.StringExtender.get("#marioCtnr .right"); else this.right = apix.common.util.StringExtender.get("#marioCtnr .left");
		if(Math.abs(v) < 4) {
			this.left.style.display = "none";
			this.right.style.display = "none";
			this.stand.style.display = "block";
			this.locateMario(v,this.stand,cordovax.Device.get_portrait());
		} else {
			this.stand.style.display = "none";
			if(v > 0) {
				this.left.style.display = "block";
				this.right.style.display = "none";
				this.locateMario(v,this.left,cordovax.Device.get_portrait());
			} else {
				this.left.style.display = "none";
				this.right.style.display = "block";
				this.locateMario(v,this.right,cordovax.Device.get_portrait());
			}
		}
	}
	,locateMario: function(x,img,portrait) {
		if(portrait == null) portrait = true;
		var d;
		if(portrait || cordovax.Device.get_orientation() == -90) d = -1; else d = 1;
		var p = img.offsetLeft + 3 * x * d;
		if(p < -img.clientWidth) p = -img.clientWidth;
		if(p > 280) p = 280;
		var str = "" + apix.common.tools.math.MathX.round(p,2) + "px";
		var _g = 0;
		var _g1 = apix.common.util.StringExtender.all("#marioCtnr img.mario");
		while(_g < _g1.length) {
			var el = _g1[_g];
			++_g;
			el.style.left = str;
		}
	}
	,createMario: function() {
		var str = "";
		str += "<div id='marioCtnr'>";
		str += "<h2>Acc&eacute;l&eacute;rom&egrave;tre :</h2>";
		str += "<img src='img/mario.back.png' alt='mario.back' /> ";
		str += "<img class='stand mario' src='img/mario.stand.png' alt='mario.stand' /> ";
		str += "<img class='right mario' src='img/mario.right.png' alt='mario.right' /> ";
		str += "<img class='left mario' src='img/mario.left.png' alt='mario.left' /> ";
		str += "</div>";
		var el = apix.common.util.StringExtender.createElem("div");
		el.innerHTML = str;
		var dvEl = el.childNodes[0];
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(dvEl);
		var css = "";
		css += "#marioCtnr {";
		css += "position:relative;";
		css += "margin-top:2rem;";
		css += "width:280px;";
		css += "height:170px;";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "}";
		css += "#marioCtnr h2 {";
		css += "position:relative;";
		css += "border:solid 1px #999;";
		css += "}";
		css += "#marioCtnr img  {";
		css += "position:absolute;";
		css += "display:block;";
		css += "}";
		css += "#marioCtnr img.mario  {";
		css += "top:65px;";
		css += "left:102px;";
		css += "}";
		var head = window.document.head;
		var styleEl = apix.common.util.StringExtender.get("style",head);
		if(styleEl == null) {
			window.document.head.appendChild(apix.common.util.StringExtender.createElem("style"));
			styleEl = apix.common.util.StringExtender.get("style",head);
		}
		styleEl.innerHTML += css;
	}
	,__class__: SampleMotion
};
var SampleSOS = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createHtmlCss();
	apix.common.util.StringExtender.get("#vibrateCtnr .start").addEventListener("click",$bind(this,this.onStart));
	apix.common.util.StringExtender.get("#vibrateCtnr .stop").addEventListener("click",$bind(this,this.onStop));
	if(this.callback != null) this.callback();
};
SampleSOS.__name__ = true;
SampleSOS.prototype = {
	onStart: function(e) {
		apix.common.util.StringExtender.get("#vibrateCtnr .start").style.display = "none";
		apix.common.util.StringExtender.get("#vibrateCtnr .stop").style.display = "block";
		this.timer = new haxe.Timer(Math.round(6 * SampleSOS.SECOND));
		this.timer.run = $bind(this,this.onClock);
		this.onClock();
		this.stk.push(this.timer);
	}
	,onStop: function(e) {
		apix.common.util.StringExtender.get("#vibrateCtnr .start").style.display = "block";
		apix.common.util.StringExtender.get("#vibrateCtnr .stop").style.display = "none";
		this.timer.run = null;
		this.timer.stop();
		var _g = 0;
		var _g1 = this.stk;
		while(_g < _g1.length) {
			var t = _g1[_g];
			++_g;
			t.run = null;
		}
	}
	,onClock: function() {
		navigator.notification.vibrate([150,100,150,100,150,200,1000,200,1000,200,1000,200,150,100,150,100,150,100]);
	}
	,createHtmlCss: function() {
		var str = "";
		str += "<div id='vibrateCtnr'>";
		str += "<h2>Le SOS haptique : </h2>";
		str += "<br/>";
		str += "<button class='start' type='button' >D&eacute;marrer SOS</button>";
		str += "<br/>";
		str += "<button class='stop'  type='button' >Arr&ecirc;ter SOS</button>";
		str += "<br/>";
		str += "</div>";
		var el = apix.common.util.StringExtender.createElem("div");
		el.innerHTML = str;
		var dvEl = el.childNodes[0];
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(dvEl);
		var css = "";
		css += "#vibrateCtnr {";
		css += "margin-top:2rem;";
		css += "padding:.5rem;";
		css += "width:17.5rem;";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "border:dashed 1px #555;";
		css += "}";
		css += "#vibrateCtnr   button  {";
		css += "display:block;";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "font-size:2rem;";
		css += "}";
		var head = window.document.head;
		var styleEl = apix.common.util.StringExtender.get("style",head);
		if(styleEl == null) {
			window.document.head.appendChild(apix.common.util.StringExtender.createElem("style"));
			styleEl = apix.common.util.StringExtender.get("style",head);
		}
		styleEl.innerHTML += css;
	}
	,__class__: SampleSOS
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.isSpace = function(s,pos) {
	var c = HxOverrides.cca(s,pos);
	return c > 8 && c < 14 || c == 32;
};
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) r++;
	if(r > 0) return HxOverrides.substr(s,r,l - r); else return s;
};
StringTools.rtrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,l - r - 1)) r++;
	if(r > 0) return HxOverrides.substr(s,0,l - r); else return s;
};
var apix = {};
apix.common = {};
apix.common.tools = {};
apix.common.tools.math = {};
apix.common.tools.math.GeoLoc = function(la,lo,sd) {
	if(sd == null) sd = 3;
	if(lo == null) lo = 0.0;
	if(la == null) la = 0.0;
	this._lat = la;
	this._long = lo;
	this._secDec = sd;
};
apix.common.tools.math.GeoLoc.__name__ = true;
apix.common.tools.math.GeoLoc.prototype = {
	toString: function() {
		var str = "";
		str += Math.floor(Math.abs(this._lat)) + "&deg; " + Math.floor((Math.abs(this._lat) - Math.floor(Math.abs(this._lat))) * 60) + "' " + apix.common.tools.math.MathX.floor(60 * ((Math.abs(this._lat) - Math.floor(Math.abs(this._lat))) * 60 - Math.floor((Math.abs(this._lat) - Math.floor(Math.abs(this._lat))) * 60)),this._secDec) + "'' " + (this._lat < 0?"S":"N");
		str += "<br/> ";
		str += Math.floor(Math.abs(this._long)) + "&deg; " + Math.floor((Math.abs(this._long) - Math.floor(Math.abs(this._long))) * 60) + "' " + apix.common.tools.math.MathX.floor(60 * ((Math.abs(this._long) - Math.floor(Math.abs(this._long))) * 60 - Math.floor((Math.abs(this._long) - Math.floor(Math.abs(this._long))) * 60)),this._secDec) + "'' " + (this._long < 0?"W":"E");
		return str;
	}
	,__class__: apix.common.tools.math.GeoLoc
};
apix.common.tools.math.MathX = function() { };
apix.common.tools.math.MathX.__name__ = true;
apix.common.tools.math.MathX.round = function(n,d) {
	if(d == null) d = 2;
	var p = Math.pow(10,d);
	return Math.round(n * p) / p;
};
apix.common.tools.math.MathX.floor = function(n,d) {
	if(d == null) d = 2;
	var p = Math.pow(10,d);
	return Math.floor(n * p) / p;
};
apix.common.util = {};
apix.common.util.Global = function() {
};
apix.common.util.Global.__name__ = true;
apix.common.util.Global.get = function() {
	if(apix.common.util.Global._instance == null) apix.common.util.Global._instance = new apix.common.util.Global();
	return apix.common.util.Global._instance;
};
apix.common.util.Global.apixTrace = function(v,i) {
	var str = Std.string(v);
	var len = str.length;
	if(len > 2 && HxOverrides.substr(str,1,2) == "::") {
		if(HxOverrides.substr(str,0,1) == "e" || HxOverrides.substr(str,0,1) == "f") {
			var d = window.document.getElementById("apix:error");
			if(d != null) {
				str = "<br/>error " + (i != null?"in " + i.fileName + " line " + i.lineNumber:"") + " : " + HxOverrides.substr(str,3,len - 3) + "<br/>";
				d.innerHTML += str + "<br/>";
				throw "apix error. See red message in page.";
			} else if(HxOverrides.substr(str,0,1) == "f") {
				var msg = "";
				v = HxOverrides.substr(str,3,len - 3);
				if(window.document.getElementById("haxe:trace") != null) msg = "apix error. See message in page."; else msg = "apix error. See last message above.";
				js.Boot.__trace(v,i);
				throw msg;
			}
		} else if(HxOverrides.substr(str,0,1) == "i") {
			str = "<br/>notice in " + (i != null?i.fileName + ":" + i.lineNumber:"") + "<br/>" + HxOverrides.substr(str,3,len - 3);
			var d1 = window.document.getElementById("apix:info");
			if(d1 != null) d1.innerHTML += str + "<br/>";
		}
	} else {
		var d2 = window.document.getElementById("apix:info");
		if(d2 != null) d2.innerHTML += "<br/><div style='border: dotted 1px black;' >" + str + "</div>"; else js.Boot.__trace(v,i);
	}
};
apix.common.util.Global.prototype = {
	empty: function(v) {
		if(v == null) return true;
		if(v.length == 0) return true;
		return false;
	}
	,strReplace: function(str,from,to) {
		var reg = new RegExp('('+from+')', 'g');;
		str = str.replace(reg,to);;
		return str;
	}
	,setupTrace: function(ctnrId) {
		var ctnr;
		if(this.empty(ctnrId)) ctnr = window.document.body; else ctnr = window.document.getElementById(ctnrId);
		if(ctnr != null) {
			if(window.document.getElementById("apix:error") == null) ctnr.innerHTML = "<div id='apix:error' style='font-weight:bold;color:#900;' ></div>" + ctnr.innerHTML;
			if(window.document.getElementById("apix:info") == null) ctnr.innerHTML += "<div id='apix:info' style='font-weight:bold;' ></div>";
			haxe.Log.trace = apix.common.util.Global.apixTrace;
		} else return false;
		return true;
	}
	,get_isMobile: function() {
		return new EReg("iPhone|ipad|iPod|Android|opera mini|blackberry|palm os|palm|hiptop|avantgo|plucker|xiino|blazer|elaine|iris|3g_t|opera mobi|windows phone|iemobile|mobile".toLowerCase(),"i").match(window.navigator.userAgent.toLowerCase());
	}
	,get_isIE: function() {
		return new EReg("msie".toLowerCase(),"i").match(window.navigator.userAgent.toLowerCase());
	}
	,get_isOpera: function() {
		return new EReg("opera".toLowerCase(),"i").match(window.navigator.userAgent.toLowerCase());
	}
	,get_isFirefox: function() {
		return new EReg("firefox".toLowerCase(),"i").match(window.navigator.userAgent.toLowerCase());
	}
	,get_isKhtml: function() {
		return new EReg("konqueror".toLowerCase(),"i").match(window.navigator.userAgent.toLowerCase());
	}
	,get_isWebKit: function() {
		return new EReg("webkit|chrome|safari".toLowerCase(),"i").match(window.navigator.userAgent.toLowerCase());
	}
	,__class__: apix.common.util.Global
};
apix.common.util.StringExtender = function() { };
apix.common.util.StringExtender.__name__ = true;
apix.common.util.StringExtender.all = function(v,parent) {
	if(apix.common.util.StringExtender.rootHtmlElement == null) apix.common.util.StringExtender.rootHtmlElement = window.document.body;
	if(parent == null) parent = apix.common.util.StringExtender.rootHtmlElement;
	return parent.querySelectorAll(v);
};
apix.common.util.StringExtender.get = function(v,parent) {
	if(apix.common.util.StringExtender.rootHtmlElement == null) apix.common.util.StringExtender.rootHtmlElement = window.document.body;
	if(parent == null) parent = apix.common.util.StringExtender.rootHtmlElement;
	return parent.querySelector(v);
};
apix.common.util.StringExtender.createElem = function(v) {
	return window.document.createElement(v);
};
apix.common.util.StringExtender.unspaced = function(v) {
	if(v == null) return ""; else return StringTools.rtrim(StringTools.ltrim(v));
};
apix.common.util.StringExtender.alert = function(s) {
	js.Lib.alert(s);
};
apix.common.util.StringExtender.trace = function(s,v) {
	if(v != null) s += "=" + Std.string(v.toString());
	haxe.Log.trace(s,{ fileName : "StringExtender.hx", lineNumber : 81, className : "apix.common.util.StringExtender", methodName : "trace"});
};
var cordovax = {};
cordovax.CordovaEvent = function() { };
cordovax.CordovaEvent.__name__ = true;
cordovax.CordovaEvent.__super__ = Event;
cordovax.CordovaEvent.prototype = $extend(Event.prototype,{
	__class__: cordovax.CordovaEvent
});
cordovax.BatteryStatusEvent = function() { };
cordovax.BatteryStatusEvent.__name__ = true;
cordovax.BatteryStatusEvent.prototype = {
	__class__: cordovax.BatteryStatusEvent
};
cordovax.Device = function() { };
cordovax.Device.__name__ = true;
cordovax.Device.get_model = function() {
	return window.device.model;
};
cordovax.Device.get_cordova = function() {
	return window.device.cordova;
};
cordovax.Device.get_platform = function() {
	return window.device.platform;
};
cordovax.Device.get_uuid = function() {
	return window.device.uuid;
};
cordovax.Device.get_version = function() {
	return window.device.version;
};
cordovax.Device.get_orientationMode = function() {
	if(Math.abs(cordovax.Device.get_orientation()) == 90) return "landscape"; else return "portrait";
};
cordovax.Device.get_orientation = function() {
	return window.orientation;
};
cordovax.Device.get_portrait = function() {
	return cordovax.Device.get_orientationMode() == "portrait";
};
var haxe = {};
haxe.Log = function() { };
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
};
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe.Timer.__name__ = true;
haxe.Timer.prototype = {
	stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
	,__class__: haxe.Timer
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js.Boot.__trace = function(v,i) {
	var msg;
	if(i != null) msg = i.fileName + ":" + i.lineNumber + ": "; else msg = "";
	msg += js.Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js.Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js.Boot.__unhtml(msg) + "<br/>"; else if(typeof console != "undefined" && console.log != null) console.log(msg);
};
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js.Boot.__cast = function(o,t) {
	if(js.Boot.__instanceof(o,t)) return o; else throw "Cannot cast " + Std.string(o) + " to " + Std.string(t);
};
js.Lib = function() { };
js.Lib.__name__ = true;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i1) {
	return isNaN(i1);
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
SampleSOS.SECOND = 1000;
Main.main();
})();
