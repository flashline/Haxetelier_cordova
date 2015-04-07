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
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
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
	new SampleEvent($bind(this,this.audioLocal));
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
	audioLocal: function() {
		new SampleAudioLocal($bind(this,this.end));
	}
	,end: function() {
	}
};
var SampleAudioLocal = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	this.createHtmlCss();
	if(cordova.file.externalApplicationStorageDirectory == null) apix.common.util.StringExtender.get("#audioCtnr").innerHTML = "<h1>Enlever le cable et relancer l'app. !</h1>"; else {
		apix.common.util.StringExtender.get("#audioCtnr .record").addEventListener("click",$bind(this,this.onClickRecord));
		apix.common.util.StringExtender.get("#audioCtnr .play").addEventListener("click",$bind(this,this.onClickPlay));
		apix.common.util.StringExtender.get("#audioCtnr .stopPlay").addEventListener("click",$bind(this,this.onClickStopPlaying));
	}
	if(this.callback != null) this.callback();
};
SampleAudioLocal.__name__ = true;
SampleAudioLocal.prototype = {
	onClickRecord: function(e) {
		navigator.device.capture.captureAudio($bind(this,this.onAudioSuccess),$bind(this,this.onAudioError),{ limit : 1});
	}
	,onAudioSuccess: function(mf) {
		this.show(false,true,null);
		this.mediaFiles = mf;
	}
	,onAudioError: function(e) {
		var arr = [];
		arr[CaptureError.CAPTURE_APPLICATION_BUSY] = "L'application de capture caméra / audio est actuellement une autre demande de capture.";
		arr[CaptureError.CAPTURE_INTERNAL_ERR] = "La caméra ou un microphone a échoué à capturer l'image ou le son.";
		arr[CaptureError.CAPTURE_INVALID_ARGUMENT] = "Utilisation incorrecte de l'API (par exemple, la valeur de limit est inférieur à 1).";
		arr[CaptureError.CAPTURE_NO_MEDIA_FILES] = "L'utilisateur a quitté l'application capture audio sans aucun enregistrement.";
		arr[CaptureError.CAPTURE_NOT_SUPPORTED] = "L'opération de capture demandée n'est pas pris en charge.";
		js.Lib.alert(arr[e.code]);
	}
	,onClickPlay: function(e) {
		this.show(false,false,true);
		if(this.mediaFiles == null || this.mediaFiles == []) js.Lib.alert("Auncun son enregistré ! "); else {
			var _g = 0;
			var _g1 = this.mediaFiles;
			while(_g < _g1.length) {
				var mf = _g1[_g];
				++_g;
				this.playOneFile(mf.fullPath,mf.name);
			}
		}
	}
	,playOneFile: function(p,n) {
		this.path = p;
		this.name = n;
		this.path = cordova.file.externalRootDirectory + "My%20Documents/My%20Recordings/" + this.name;
		this.media = new Media(this.path,$bind(this,this.onMediaPlaySuccess),$bind(this,this.onMediaError));
		this.media.play();
	}
	,onMediaPlaySuccess: function() {
		this.show(true,true,false);
	}
	,onMediaError: function(e) {
		js.Lib.alert("error #" + e.code + " : " + e.message);
	}
	,onClickStopPlaying: function(e) {
		this.show(true,true,false);
		if(this.media != null) {
			this.media.stop();
			this.media.release();
		}
	}
	,show: function(r,p,s) {
		if(r != null) if(r) apix.common.util.StringExtender.get("#audioCtnr .record").style.visibility = "visible"; else apix.common.util.StringExtender.get("#audioCtnr .record").style.visibility = "hidden"; else null;
		if(p != null) if(p) apix.common.util.StringExtender.get("#audioCtnr .play").style.visibility = "visible"; else apix.common.util.StringExtender.get("#audioCtnr .play").style.visibility = "hidden"; else null;
		if(s != null) if(s) apix.common.util.StringExtender.get("#audioCtnr .stopPlay").style.visibility = "visible"; else apix.common.util.StringExtender.get("#audioCtnr .stopPlay").style.visibility = "hidden"; else null;
	}
	,createHtmlCss: function() {
		var str = "";
		str += "<div id='audioCtnr'>";
		str += "<button class='button record'   \t\ttype='button' >Enregistrer</button>";
		str += "<button class='button stopPlay'   \t\ttype='button' >Arrêter</button>";
		str += "<button class='button play'   \t\t\ttype='button' >Lire</button>";
		str += "</div>";
		str += "<br/>";
		str += "<br/>";
		var el = apix.common.util.StringExtender.createElem("div");
		el.innerHTML = str;
		var dvEl = el.childNodes[0];
		apix.common.util.StringExtender.get("#appHtmlCtnr").appendChild(dvEl);
		var css = "";
		css += "#audioCtnr {";
		css += "margin-top:2rem;";
		css += "width:100%;";
		css += "}";
		css += "#audioCtnr .button  {";
		css += "display:block;";
		css += "width:80%;";
		css += "height:5rem;";
		css += "margin-top:30px;";
		css += "margin-left:auto;";
		css += "margin-right:auto;";
		css += "font-size:2rem;";
		css += "}";
		css += "#audioCtnr .stopPlay, #audioCtnr .stopRecord, #audioCtnr .play {";
		css += "visibility:hidden;";
		css += "}";
		css += "#audioCtnr .stopPlay, #audioCtnr .stopRecord {";
		css += "background-color:#f99;";
		css += "}";
		css += "#audioCtnr .play, #audioCtnr .record {";
		css += "background-color:#9f9;";
		css += "}";
		var head = window.document.head;
		var styleEl = apix.common.util.StringExtender.get("style",head);
		if(styleEl == null) {
			window.document.head.appendChild(apix.common.util.StringExtender.createElem("style"));
			styleEl = apix.common.util.StringExtender.get("style",head);
		}
		styleEl.innerHTML += css;
	}
};
var SampleEvent = function(cb) {
	this.g = apix.common.util.Global.get();
	this.callback = cb;
	window.document.addEventListener("backbutton",$bind(this,this.onBackButton));
	if(this.g.get_isMobile()) {
		haxe.Log.trace("File.externalDataDirectory=" + cordova.file.externalDataDirectory,{ fileName : "SampleEvent.hx", lineNumber : 47, className : "SampleEvent", methodName : "new"});
		haxe.Log.trace("File.externalRootDirectory=" + cordova.file.externalRootDirectory,{ fileName : "SampleEvent.hx", lineNumber : 50, className : "SampleEvent", methodName : "new"});
	}
	if(this.callback != null) this.callback();
};
SampleEvent.__name__ = true;
SampleEvent.prototype = {
	onBackButton: function(e) {
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
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var apix = {};
apix.common = {};
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
};
apix.common.util.StringExtender = function() { };
apix.common.util.StringExtender.__name__ = true;
apix.common.util.StringExtender.get = function(v,parent) {
	if(apix.common.util.StringExtender.rootHtmlElement == null) apix.common.util.StringExtender.rootHtmlElement = window.document.body;
	if(parent == null) parent = apix.common.util.StringExtender.rootHtmlElement;
	return parent.querySelector(v);
};
apix.common.util.StringExtender.createElem = function(v) {
	return window.document.createElement(v);
};
var cordovax = {};
cordovax.CordovaEvent = function() { };
cordovax.CordovaEvent.__name__ = true;
cordovax.CordovaEvent.__super__ = Event;
cordovax.CordovaEvent.prototype = $extend(Event.prototype,{
});
var haxe = {};
haxe.Log = function() { };
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
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
js.Lib = function() { };
js.Lib.__name__ = true;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
Main.main();
})();
