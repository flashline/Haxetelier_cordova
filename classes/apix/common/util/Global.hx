
package apix.common.util ;
import haxe.Log;
import haxe.PosInfos;
import js.Browser;
import js.html.Element;

/**
 * Singleton containing  all-purpose methods.
 */
class Global {
	static public inline var STD_ERROR_MSG:String = "apix error. See last message above." ;
	static public inline var RED_IN_PAGE_ERROR_MSG:String = "apix error. See red message in page." ;
	static public inline var IN_PAGE_ERROR_MSG:String = "apix error. See message in page." ;
	//
	public var isWindowsPhone(get, null):Bool;
	public var isMobile(get, null):Bool;	
	public var isWebKit(get, null):Bool;	
	public var isAndroidNative(get, null):Bool;	
	public var isAndroidNative300(get, null):Bool;	
	public var isFirefox(get, null):Bool;	
	public var isIE(get, null):Bool;	
	public var isSafari(get, null):Bool;	
	public var isOpera(get, null):Bool;		
	public var isIphoneIpad(get, null):Bool;	
	public var isPhone(get, null):Bool;	
	public var isTablet(get, null):Bool;		
	public var isKhtml(get, null):Bool;		
	//
	//
	static public var alertFunction:Dynamic ;		
	//
	static var _instance:Global;
	//
	function new () {}
	public static function get() : Global {	 
		if (_instance == null) _instance = new Global();
		return _instance ;
	}
	/**
	* return full classname of inst
	*/
	public function className(inst:Dynamic) :String {
		return Type.getClassName(Type.getClass(inst)) ;
	}
	/**
	 * <br/><b>v</b> dynamic value.
	 * <br/><b>return</b> true or false.
	 */
	public function boolVal(b:Dynamic,?defVal:Bool=false) :Bool {
		if (b==null) return defVal ;
		if (Std.is(b,String)) {
			if 		(b=="true" ) return true;
			else if (b=="false") return false;				
			else  				return defVal ;
		} else if (Std.is(b,Float)  ) {
			if 		(b==0) 		return false ;
			else if (b==1) 		return true ;
			else  				return defVal ;
		} else if (Std.is(b,Bool) ) return b ;
		return defVal;
	}
	/**
	 * <br/><b>v</b> dynamic value.
	 * <br/><b>return</b> a string.
	 */
	public function strVal(s:Dynamic,?defVal:String="") :String {	
		if (s==null) return defVal ;
		if (s=="") return defVal;
		return Std.string(s);
	}
	public function numVal(n:Dynamic,?defVal:Float=0) : Float {
		if (n=="0") return Std.parseFloat("0"); 
		if (n == null) return defVal ;
		if (Math.isNaN(n)) return defVal ;
		if (n == "") return defVal ; 
		if (Std.is(n, String)) return Std.parseFloat(n);
		return Math.pow(n,1) ;
	}
	public function intVal(n:Dynamic,?defVal:Int=0) : Int {
		if (n=="0") return Std.parseInt("0"); 
		if (n==null) return defVal ;
		if (Math.isNaN(n)) return defVal ;
		if (n == "") return defVal ; 
		if (Std.is(n,String)) return Std.parseInt(n); 
		return n ;
	}
	public function isNaN(v:String) : Bool {
		var i:Dynamic = v;
		return  (Math.isNaN(i)) ;
		// or // return (Std.string(Std.parseFloat(v)) == "NaN") ;
	}
	/**
	 * <br/><b>string</b> A string.
	 * <br/><b>return</b> true if string is empty ; or false.
	 */
	public function empty ( v : Dynamic) : Bool {
		if (v == null) return true;
		if (v.length == 0) return true ;
		return false;
	}
	/**
	 * Call js confirm()
	 * <br/><b>v</b> Message.
	 * <br/><b>return</b> true if user confirm ; or false.
	 */
	public function confirm ( v : Dynamic ) : Bool {
		return untyped __js__("confirm")(js.Boot.__string_rec(v,""));
	}
	/**
	 * Call js alert()
	 * <br/><b>v</b> Message.
	 */
	public function alert( v : Dynamic,?cb:Dynamic,?title ) : Void {
		if (Global.alertFunction != null) Global.alertFunction(v,cb,title);
		else {
			if (strVal(title,"") != "") v = title + "\n"+v ;
			untyped __js__("alert")(js.Boot.__string_rec(v, ""));
			if (cb!=null) cb();
		}
	}
	/*
		public function prompt ( v : Dynamic,?str:Dynamic="" ) : String {
		return untyped __js__("prompt")(js.Boot.__string_rec(v,""),js.Boot.__string_rec(str,""));
	}*/
	/**
	 * Call js prompt()
	 * <br/><b>v</b> Message.
	 * <br/><b>def</b> By default value.
	 * <br/><b>return</b> true if user confirm or false.
	 */
	public function prompt ( v : String,?def:String="" ) : String {
		return untyped __js__("prompt")(v,def);
	}	
	/**
	* return string <b>str</b> where <b>from</b> is replaced by <b>to</b> .
	*/
	public function strReplace (str:String,from:String,to:String ) :String {
		var reg = untyped __js__ ("new RegExp('('+from+')', 'g');");
		str = untyped __js__ ("str.replace(reg,to);");
		return str;
	}	
	/**
	 * remove debug trace
	 * <br/>
	 */
	public function removeTrace ()  {
		var el:Element;
		el = Browser.document.getElementById("apix:error");
		if (el != null) el.id = "";		
		el = Browser.document.getElementById("apix:info");
		if (el != null) el.id = "";	
	}	
	
	/**
	 * remove debug trace
	 * <br/>
	 */
	public function setupTrace (?ctnrId:String) :Bool  {
		var ctnr:Element;
		if (empty(ctnrId)) ctnr = Browser.document.body;
		else ctnr = Browser.document.getElementById(ctnrId) ;
		if (ctnr!=null) {
			if (Browser.document.getElementById("apix:error") == null){
				ctnr.innerHTML = "<div id='apix:error' style='font-weight:bold;color:#900;' ></div>"+ctnr.innerHTML;			
			}
			if (Browser.document.getElementById("apix:info") == null){
				//ctnr.innerHTML = "<div id='apix:info' style='font-weight:bold;' ></div>" + ctnr.innerHTML;
				// OR
				ctnr.innerHTML += "<div id='apix:info' style='font-weight:bold;' ></div>" ;
			}
			Log.trace = Global.apixTrace;
		} 
		else return false;
		return true;
	}		
	static function apixTrace ( v : Dynamic, ?i : PosInfos ) {
		var str = Std.string(v) ; var len = str.length; 
		if (len > 2 && str.substr(1, 2) == "::" ) {			
			if (str.substr(0,1) == "e" || str.substr(0,1) == "f" ) {
				var d = Browser.document.getElementById("apix:error");
				if ( d != null )	{
					str = "<br/>error " + ( if ( i != null ) "in " + i.fileName + " line " + i.lineNumber else "") + " : " + str.substr(3, len - 3) + "<br/>" ; 			
					d.innerHTML += str + "<br/>";		
					throw Global.RED_IN_PAGE_ERROR_MSG;
				} else {
					if (str.substr(0, 1) == "f" )	 {	
						var msg="";
						v = str.substr(3, len - 3);		
						if (Browser.document.getElementById("haxe:trace") != null) msg = Global.IN_PAGE_ERROR_MSG;
						else msg = Global.STD_ERROR_MSG;
						untyped js.Boot.__trace(v, i);
						throw msg;	
					}
				}
			}
			else if (str.substr(0, 1) == "i") {			
				str = "<br/>notice in "+( if( i != null ) i.fileName+":"+i.lineNumber else "")+"<br/>"+str.substr(3, len-3)  ;
				var d = Browser.document.getElementById("apix:info");
				if ( d != null )	d.innerHTML += str + "<br/>";	
			}
		}  
		else {			
			//str = "notice in "+( if( i != null ) i.fileName+":"+i.lineNumber else "")+"<br/>"+str  ;
			var d = Browser.document.getElementById("apix:info");
			if ( d != null )	d.innerHTML += "<br/><div style='border: dotted 1px black;' >"+str+"</div>" ;	
			else untyped js.Boot.__trace(v,i);
		}
	}
	/**
	* return true if year is leap year
	* <br/><b>n</b> a year as 9999
	*/
	public function isBissextile(n:Int) :Bool{
		return (new Date(n,1,29,0,0,0).getDay() != new Date(n,2,1,0,0,0).getDay());
	}
	/**
	 * @param	m		month (1 to 12)
	 * @param	?leap	true if year is leap
	 * @return	number of days in a month
	 */
	public function maxDayIn (m:Int,?leap:Bool=false) : Int {
		m=intVal(m);
		if (m < 1 || m > 12) { trace ("f::Month must be from 1 to 12 !"); }	
		var v = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][m - 1] ;
		if (m == 2 && leap) v++;
		return v;
	}
	/**
	 * @param	v	Date with format : yyy-mm-jj or any separator
	 * @return 	"" if correct or error msg
	 */
	public function verifyDate (v:String) : String {
		var msg = "";
		if (v.length != 10) msg = "invalid date format yyyy-mm-dd";
		else { 
			var yy = Std.parseInt(v.substr(0,4));var mm = Std.parseInt(v.substr(5,2));var dd = Std.parseInt(v.substr(8,2));
			if (yy < 1000 || yy > 9999) msg = "invalid year "+yy;
			else if (mm < 1 || mm > 12) msg = "invalid month "+mm;
			else if (dd < 1 || dd > maxDayIn(mm,isBissextile(yy))) msg= "invalid day "+dd+" for month="+mm+" and year="+yy;
		}
		return msg;
	}
	/**
	 * @param	os 	source object
	 * @return 		a new object with same members than os
	 */
	public inline function newObject (os:Dynamic) : Dynamic {
		var o = {};
		untyped __js__ ("for (var i in os) { o[i]=os[i] }");
		return o;
	}
	public inline function addToObject (os:Dynamic,od:Dynamic) {
		if (od==null) trace ("f::Impossible to append in null destination object ! ");
		untyped __js__ ("for (var i in os) { od[i]=os[i] }");
	}
	/**
	 * convert hexa string to dec Int. ex: "1A" ==> 26
	 * <b>return</b> a decimal int
	 * <br/><b>v</b> an hexa string 
	 */
	public function hexToDec(v:String) :Int {	
		return untyped __js__("Number('0x'+v) ;") ;
		 
	}
	/**
	 * convert dec int to hexa string. ex: 26 ==> "1A"
	 * <b>return</b> a decimal int
	 * <br/><b>v</b> an hexa string 
	 */
	public function decToHex(n:Int) :String {	 
		return untyped __js__("n.toString(16)") ;
	}
	/**
	 * add 2 hexa string. ex: "99" + "22" ==> "BB"
	 * <b>return</b> v1+v2 as hexa string 
	 * <br/><b>v1</b> an hexa string 
	 * <br/><b>v2</b> an hexa string 
	 */
	public function addHex(v1:String, v2:String) :String {	 
		return decToHex( hexToDec(v1) + hexToDec(v2) ); 
	}	
	/**
	 * <b>return</b> an rgb() format
	 * <br/><b>v</b> a #hexa format
	 * <br/><b>see</b> net.flash_line.util.GetColor.
	 */
	/*public function toRgb(v:String) :String {	 
		return GetColor.toRgb(v);
	}*/
	/**
	 * <b>return</b> an #hexa format
	 * <br/><b>v</b> an rgb() format
	 * <br/><b>see</b> net.flash_line.util.GetColor.
	 */
	/*public function toHexa(v:String) :String {	 
		return GetColor.toHexa(v);
	}*/
	public function mailIsValid (v:String) : Bool {
		var r:EReg = ~/[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z][A-Z][A-Z]?/i;
		return r.match(v);		
    }
	
	//
	// machines
	function get_isPhone ():Bool {
		return (Browser.window.screen.availHeight < 800 && isMobile) ;
	}	
	function get_isTablet ():Bool {
		return (Browser.window.screen.availHeight >= 800 && isMobile) ;
	}	
	function get_isMobile() :Bool {
		return new EReg("iPhone|ipad|iPod|Android|opera mini|blackberry|palm os|palm|hiptop|avantgo|plucker|xiino|blazer|elaine|iris|3g_t|opera mobi|windows phone|iemobile|mobile".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase());
	}	
	// os
	function get_isIphoneIpad() :Bool {
		return new EReg("iPhone|iPad".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) ;
	}
	function get_isWindowsPhone() :Bool {
		return new EReg("windows phone|iemobile".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase());
	}
	// browsers
	/// isSafari() is used also for android native browser.
	function get_isIE() :Bool {
		return new EReg("msie".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) ;
	}
	function get_isOpera() :Bool {
		return new EReg("opera".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) ;
	}
	function get_isSafari() :Bool {
		return new EReg("safari".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) && (!new EReg("chrome".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase())) && (!new EReg("android".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) );
	}
	function get_isFirefox() :Bool {
		return new EReg("firefox".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) ;
	}
	function get_isKhtml() :Bool {
		return new EReg("konqueror".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase()) ;
	}
	function get_isAndroid() :Bool {
		return new EReg("android".toLowerCase(), "i").match(Browser.navigator.userAgent.toLowerCase()) ;
	}
	function get_isChrome() :Bool {
		return new EReg("chrome".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase());
	}
	function get_isAndroidNative() :Bool {	
		return get_isAndroid() && (!isFirefox) ;
	}	
	function get_isWebKit() :Bool {
		return new EReg("webkit|chrome|safari".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase());
	}
	function get_isAndroidNative300 () :Bool {		
		return isAndroidNative && new EReg("android 2|android 3".toLowerCase(),"i").match(Browser.navigator.userAgent.toLowerCase());
	}
	
}
 