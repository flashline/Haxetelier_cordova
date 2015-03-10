package cordovax.navigator;
//
// works with org.apache.cordova.globalization
//
/**
 * --- COMPILED OK BUT NOT ACTUALY TESTED ---
 */
@:native("navigator.globalization")
extern class Globalization {	
	static function getPreferredLanguage (success:GlobalizationResult->Void, error:GlobalizationError -> Void ):Void;
	static function getLocaleName (success:GlobalizationResult -> Void, error:GlobalizationError->Void ):Void;
	static function dateToString (date:Date,success:GlobalizationResult -> Void, error:GlobalizationError->Void,options:GlobalizationDateOptions ):Void;
	/**
	 * @param	currencyCode should be a String of one of the ISO 4217 currency codes, for example 'USD'.
	 */
	static function getCurrencyPattern (currencyCode:String ,success:GlobalizationCurrency -> Void, error:GlobalizationError->Void ):Void;	
	static function getDateNames (success:Array<GlobalizationResult> -> Void, error:GlobalizationError -> Void,options:GlobalizationDateNameOptions ):Void;	
	static function getDatePattern (success:GlobalizationDatePattern -> Void, error:GlobalizationError -> Void,options:GlobalizationDateOptions ):Void;	
	static function getFirstDayOfWeek (success:GlobalizationIntResult -> Void, error:GlobalizationError -> Void ):Void;
	
	/* TODO */
	/*
	static function stringToDate	 		();
	static function isDayLightSavingsTime	();
	static function numberToString 			();
	static function stringToNumber	 		();
	static function getNumberPattern 		();
	*/
}
//
@:native("GlobalizationError")
extern class GlobalizationError {
	static var UNKNOWN_ERROR:Int; 		//0
	static var FORMATTING_ERROR:Int; 	//1
	static var PARSING_ERROR:Int; 		//2
	static var PATTERN_ERROR:Int; 		//3
	
	var code:Int;
	var message:String;
}
//
typedef GlobalizationDatePattern = {
	var pattern:String ; // The date and time pattern to format and parse dates. The patterns follow Unicode Technical Standard #35. 
	var timezone:String ; //  The abbreviated name of the time zone on the client. 
	var utc_offset:Int ; //  The current difference in seconds between the client's time zone and coordinated universal time.
	var dst_offset:Int ; //  The current daylight saving time offset in seconds between the client's non-daylight saving's time zone and the client's daylight saving's time zone. 
}
typedef GlobalizationCurrency = {
	var pattern:String;	// The currency pattern to format and parse currency values. The patterns follow Unicode Technical Standard #35 eg:$#,##0.##;($#,##0.##)
	var code:String;		// The ISO 4217 currency code for the pattern
	var fraction:Int;		// The number of fractional digits to use when parsing and formatting currency. 
	var rounding:Int;		// The rounding increment to use when parsing and formatting.
	var decimal:String; 	// The decimal symbol to use for parsing and formatting.
	var grouping:String; 	// The grouping symbol to use for parsing and formatting.
}
typedef GlobalizationResult = {
	var value:String;
}
typedef GlobalizationIntResult = {
	var value:Int;
}
typedef GlobalizationDateOptions = {
	var formatLength:String; // short, medium, long, or full
	var selector:String; 	 // date, time or date and time.
}
typedef GlobalizationDateNameOptions = {
	var type:String; 	// 'narrow' or 'wide'
	var item:String; 	// 'months' or 'days'
}