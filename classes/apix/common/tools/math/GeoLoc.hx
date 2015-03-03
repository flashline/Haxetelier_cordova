/*
 * Copyright (c) jm Delettre.
 * 
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package apix.common.tools.math ;
/**
 * usage :
 * var gl = new GeoLoc(48.0578896,-29.491011);
 * trace(""+gl.latDeg+"° "+gl.latMin+"' "+gl.latSec+"'' "+gl.latDir);       // 48°  3' 28.40256'' N
 * trace(""+gl.longDeg+"° "+gl.longMin+"' "+gl.longSec+"'' "+gl.longDir);	// 29° 29' 27.63960'' W
 * 
 */
class GeoLoc  { 		
			var _secDec:Int;
			var _lat:Float;
	public var latDir(get, null):String;
	public var latDeg(get, null):Int;
	public var latMin(get, null):Int;
	public var latSec(get, null):Float;
	//
	
			var _long:Float;	
	public var longDir(get, null):String;
	public var longDeg(get, null):Int;
	public var longMin(get, null):Int;
	public var longSec(get, null):Float;
	//	
	public function new  (?la:Float=0.0,?lo:Float=0.0,?sd:Int=3) {				
		_lat = la;
		_long = lo;
		_secDec = sd;
	}	
	//private 
	//   get/set
	inline function get_latDir () :String {
		return (_lat<0)?"S":"N" ;
	}
	inline function get_latDeg () :Int {
		return  Math.floor(latAbs());
	}
	inline function get_latMin () : Int {
		return  Math.floor(latMinFloat()) ;
	}
	inline function get_latSec () :Float {
		return MathX.floor((60 * latMinDeci()), _secDec);
	}	
	//
	inline function get_longDir () :String {
		return (_long<0)?"W":"E" ;
	}	
	inline function get_longDeg () :Int {
		return  Math.floor(longAbs());
	}
	inline function get_longMin () :Int {
		return  Math.floor(longMinFloat()) ;
	}
	inline function get_longSec () :Float {
		return MathX.floor((60 * longMinDeci()), _secDec);
	}
	//end get/set
	//
	//lat
	inline function latAbs () : Float {
		return Math.abs(_lat);
	}	
	inline function latDegDeci () : Float {
		return (latAbs()-latDeg) ;
	}	
	inline function latMinFloat () :Float {
		return (latDegDeci()*60) ;
	}	
	inline function latMinDeci () :Float {
		return (latMinFloat()-latMin) ;
	}
	//long
	inline function longAbs () : Float {
		return Math.abs(_long);
	}	
	inline function longDegDeci () : Float {
		return (longAbs()-longDeg) ;
	}	
	inline function longMinFloat () :Float {
		return (longDegDeci()*60) ;
	}
	
	inline function longMinDeci () :Float {
		return (longMinFloat()-longMin) ;
	}
	public function toString () :String {
		var str = "";
		str += latDeg + "&deg; " + latMin + "' " + latSec + "'' " + latDir ; // 48°  3' 28.40256'' N
		str += "<br/> ";
		str+=longDeg+"&deg; "+longMin+"' "+longSec+"'' "+longDir ;			 // 29° 29' 27.63960'' W
		return str ;
	}
	
	
	
}