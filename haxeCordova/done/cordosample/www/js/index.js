/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
 var app = {
	
    // Application Constructor
    initialize: function() {
		document.addEventListener('deviceready', this.onDeviceReady, false);
		//remove comment on next rows to test in PC browser
		if (!(window.navigator.userAgent.toLowerCase().match(/iphone|ipad|ipod|android|opera mini|blackberry|palm os|palm|hiptop|avantgo|plucker|xiino|blazer|elaine|iris|3g_t|opera mobi|windows phone|iemobile|mobile/i)))
			window.addEventListener('load', this.onDeviceReady, false);
	}
	,
	// global cordova app container id 
	initCtnrElementId:"initCtnr"
	,
    // ready-waiting element id 
	deviceReadyElementId:"deviceready"
	,
    // ready-waiting element id 
	appHtmlCtnrElementId:"appHtmlCtnr"
	,
    // deviceready Event Handler
    onDeviceReady: function() {
		document.body.removeChild(document.getElementById(app.initCtnrElementId));
		document.getElementById(app.appHtmlCtnrElementId).style.display="block";
		// haxe js launch
		app.haxeAppStart();
        
    },
    // haxe app starting
    haxeAppStart: function() {		
		console.log("v 2");
		var s = document.createElement('script');
		s.src = "js/main.js"; 
		document.getElementsByTagName("head")[0].appendChild(s);		
		// OR
		/*
			var s = document.createElement('iframe');
			s.src = "http://www.apixline.org/pm/app/web/html5/calendar/"; 
			s.style.border="0px";
			s.style.width="100%";
			s.style.height="100%";
			document.getElementById(this.appElementId).appendChild(s);
		*/
		// OR BETTER
			//window.location="http://www.apixline.org/pm/app/web/html5/calendar/";
			//document.location.href="http://www.apixline.org/pm/app/web/html5/calendar/" ;
			//window.location.assign("http://www.apixline.org/pm/app/web/html5/calendar/");
			// replace() must be used. If using assign() -or href- the user can't close app.
			//window.location.replace("https://normapedroche.wordpress.com/");
    }
};

app.initialize();


