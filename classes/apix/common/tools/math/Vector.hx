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
import apix.common.util.Global;
class Vector  {
	var g:Global ;
	//
	private var _x:Float;
    private var _y:Float;
    private var _z:Float;
    // get/set	
	/**
	 * abscissa
	 */
	public var x(get_x, set_x):Float;
    private function get_x(): Float { 
    	return _x; 
    }
	private function set_x(v:Float)  { 
		_x=v;
		 return v ; 
	}
	/**
	 * ordinate
	 */
	public var y(get_y, set_y):Float;
    private function get_y(): Float { 
    	return _y; 
    }
	private function set_y(v:Float)  { 
		_y=v;
		 return v ; 
	}
	/**
	 * z-coordinate -or applicate-  
	 */
	public var z(get_z, set_z):Float;
    private function get_z(): Float { 
    	return _z; 
    }
	private function set_z(v:Float)  { 
		_z=v;
		 return v ; 
	}
	public var length(get_length,null):Float;
    private function get_length(): Float { 
    	return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2) + (z == null?0:Math.pow(z, 2)));
    }
	
    public function new(vx:Float, vy:Float, ?vz:Float = null) {
		g = Global.get();
    	x=vx;
    	y=vy;
    	z=vz;  	
    }
    public function add(v:Vector) :Vector {
		return new Vector(x + v.x, y + v.y,(z == null?null:z+v.z));
    }
    public function sub(v:Vector) :Vector {
		return new Vector(x - v.x, y - v.y,(z == null?null:z-v.z));	
    }
    
    public function toString() :String {
		var str = "";
		str += "x="+x+" / " ;			
		str += "y="+y ;			
		str += (z == null?"":" / z="+z) ;							
		return str;
    }
}