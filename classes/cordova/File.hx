/**
 * --- NOT TESTED ---
 */
//
// works with org.apache.cordova.file
//
package cordova;
//
@:native("cordova.file") 
extern class File {		
	/**
	 * URLs to important file-system directories are provided. 
	 * Each URL is in the form file:///path/to/spot/, and can be converted to a DirectoryEntry using Browser.window.resolveLocalFileSystemURL().
	 */
	static var applicationDirectory:String ; 				// Read-only directory where the application is installed. (iOS, Android, BlackBerry 10)
	static var applicationStorageDirectory:String ; 		// Root directory of the application's sandbox; on iOS this location is read-only (but specific subdirectories [like /Documents] are read-write). All data contained within is private to the app. ( iOS, Android, BlackBerry 10)
	static var dataDirectory:String ; 						// Persistent and private data storage within the application's sandbox using internal memory (on Android, if you need to use external memory, use .externalDataDirectory). On iOS, this directory is not synced with iCloud (use .syncedDataDirectory). (iOS, Android, BlackBerry 10)
	static var cacheDirectory:String ; 						// Directory for cached data files or any files that your app can re-create easily. The OS may delete these files when the device runs low on storage, nevertheless, apps should not rely on the OS to delete files in here. (iOS, Android, BlackBerry 10)
	static var externalApplicationStorageDirectory:String ; // Application space on external storage. (Android)
	static var externalDataDirectory:String ; 				// Where to put app-specific data files on external storage. (Android)
	static var externalCacheDirectory:String ; 				// Application cache on external storage. (Android)
	static var externalRootDirectory:String ; 				// External storage (SD card) root. (Android, BlackBerry 10)
	static var tempDirectory:String ; 						// Temp directory that the OS can clear at will. Do not rely on the OS to clear this directory; your app should always remove files as applicable. (iOS)
	static var syncedDataDirectory:String ; 				// Holds app-specific files that should be synced (e.g. to iCloud). (iOS)
	static var documentsDirectory:String ; 					// Files private to the app, but that are meaningful to other application (e.g. Office files). (iOS)
	static var sharedDirectory:String ; 					// Files globally available to all applications (BlackBerry 10)
}

