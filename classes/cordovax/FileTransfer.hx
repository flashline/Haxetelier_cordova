/**
 * from https://code.google.com/p/haxe-hxcordova/source/browse/library/cordova/File.hx by Yaros...@YHOST
 * modified by apix --- BUT NOT TESTED ---
 */
//
// works with org.apache.cordova.file-transfer
//
package cordovax;
//
import js.html.fs.FileEntry;
import js.html.ProgressEvent;
//
@:native("FileTransfer") 
extern class FileTransfer {	
	function new ();
	/**
	 * Sends a file to a server. 
	 * @param	filePath	Full path of the file on the device.
	 * @param	serverUrl		URL of the server to receive the file (must already be encoded using encodeURI()).
	 * @param	success		A callback that is called with a Metadata object.
	 * @param	error		A callback that is called if an error occurs retrieving the Metadata. Invoked with a FileTransferError object. 
	 * @param	options		Optional parameters such as file name and mimetype.
	 */ 
	function upload (filePath:String, serverUrl:EncodedUrl,success:FileUploadResult -> Void, error:FileTransferError -> Void, options:FileUploadOptions):Void;
	/**
	 * Downloads a file from server.
	 * @param	serverUrl		URL of the server to download the file (must already be encoded using encodeURI()).
	 * @param	targetFile		Full path of the file on the device.
	 * @param	success			A callback that is called with a FileEntry object.
	 * @param	error			A callback that is called if an error occurs retrieving the Metadata. Invoked with a FileTransferError object.
	 */ 
	function download(serverUrl:EncodedUrl, targetFile:String, success:FileEntry->Void, error:FileTransferError->Void,?trustAllHosts:Bool,options:FileDownloadOptions) : Void;
	/**
	 * abort previous upload/download
	 */
	function abort() : Void ; 
	
	var onprogress : ProgressEvent -> Void;
}
typedef EncodedUrl = String ;
//	
@:native("FileUploadOptions") 
extern class FileUploadOptions  {		
	function new ();
	/**
     * The name of the form element. If not set defaults to "file". (DOMString)
     */
	var fileKey : String;
    
	/**
	 * The file name you want the file to be saved as on the server. If not set defaults to "image.jpg". (DOMString)
	 */
	var fileName : String;
    
	/**
	 * The mime type of the data you are uploading. If not set defaults to "image/jpeg". (DOMString)
	 */
	var mimeType : String;
    
	/**
	 * A set of optional key/value pairs to be passed along in the HTTP request. (Object)
	 */
	var params : Dynamic;
    
	/**
	 * Should the data be uploaded in chunked streaming mode. If not set defaults to "true". This parameter is ignored on WP7.
	 */
	var chunkedMode : Bool;
    
	/**
	 * A map of header name => header value. To specify multiple values for a header, use an array of values. (Object)
	 */
	var headers : Dynamic;
}

@:native("FileTransferError") 
extern class FileTransferError {
    static var FILE_NOT_FOUND_ERR : Int; 	//=1
    static var INVALID_URL_ERR : Int;		//=2
    static var CONNECTION_ERR : Int;		//=3
	static var ABORT_ERR : Int;				//=4
	static var NOT_MODIFIED_ERR : Int;		//=5
	
    /**
     * One of the predefined error codes listed below.
     */
	var code  : Int;
	
	/**
	 * URI to the source
	 */
    var source : String;
	
	/**
	 * URI to the target
	 */
    var target : String;
    
	/**
	 * HTTP status code. This attribute is only available when a response code is received from the HTTP connection.
	 */
	var http_status : Int;
}

typedef FileUploadResult = {
	/**
	 * The number of bytes sent to the server as part of the upload. (long)
	 */
    var bytesSent : Int;
    
	/**
	 * The HTTP response code returned by the server. (long)
	 */
	var responseCode : Int;
    
	/**
     * The HTTP response returned by the server. (DOMString)
     */
	var response : String;
}	

typedef FileDownloadOptions = {
   	var headers : Dynamic;
}
