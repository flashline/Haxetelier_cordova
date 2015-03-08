package cordova.navigator;
//
// works with org.apache.cordova.contacts
//
@:native("navigator.contacts")
extern class Contacts {	
	static function create (properties:Contact):Contact;
	static function find (fields:Array<Dynamic>, success:Array <Contact> -> Void, error:Dynamic -> Void, options:ContactFindOptions):Void;
}
@:native("navigator.contacts.fieldType")
extern class FieldType {
	static var id:String;
	static var displayName:String;
	static var name:ContactName;
	static var nickname:String;
	static var phoneNumbers:Array <ContactField>;
	static var emails:Array <ContactField>;
	static var addresses:Array <ContactAddress>;
	static var ims:Array <ContactField>;
	static var organizations:Array <ContactOrganizations>;
	static var birthday:Date;
	static var note:String;
	static var photos:Array <ContactField>;
	static var categories:Array <ContactField>;
	static var urls:Array <ContactField>;
}
@:native("ContactFindOptions")
extern class ContactFindOptions {
	function new ();
	var filter:String;
	var multiple:Bool;
	var desiredFields:Array<String>;
}
//
typedef ContactOrganizations = {
	var pref:Bool;
	var type:String;
	var name:String;
	var department:String;
	var title:String;
}
//
typedef Contact = {	
	@:optional var id:String;
	@:optional var displayName:String;
	@:optional var name:ContactName;
	@:optional var nickname:String;
	@:optional var phoneNumbers:Array <ContactField>;
	@:optional var emails:Array <ContactField>;
	@:optional var addresses:Array <ContactAddress>;
	@:optional var ims:Array <ContactField>;
	@:optional var organizations:Array <ContactOrganizations>;
	@:optional var birthday:Date;
	@:optional var note:String;
	@:optional var photos:Array <ContactField>;
	@:optional var categories:Array <ContactField>;
	@:optional var urls:Array <ContactField>;	
	@:optional function clone ():Contact;
	@:optional function remove ():Void;
	@:optional function save ():Void;	
}

typedef ContactName = {	
	@:optional var formatted:String;
	@:optional var familyName:String;
	@:optional var givenName:String;
	@:optional var middleName:String;
	@:optional var honorificPrefix:String;
	@:optional var honorificSuffix:String;	
}

typedef ContactField = {
	
	@:optional var type:String;
	@:optional var value:String;
	@:optional var pref:Bool;
	
}

typedef ContactAddress = {
	
	@:optional var pref:Bool;
	@:optional var type:String;
	@:optional var formatted:String;
	@:optional var streetAddress:String;
	@:optional var locality:String;
	@:optional var region:String;
	@:optional var postalCode:String;
	@:optional var country:String;
	
}

typedef ContactOrganization = {
	
	@:optional var pref:Bool;
	@:optional var type:String;
	@:optional var name:String;
	@:optional var department:String;
	@:optional var title:String;
	
}

