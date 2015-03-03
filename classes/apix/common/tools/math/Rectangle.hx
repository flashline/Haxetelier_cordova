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
class Rectangle extends Vector {
	private var _width:Float;
    private var _height:Float;
    // get/set	
	/**
	 * width
	 */
	public var width(get_width, set_width):Float;
    private function get_width(): Float { 
    	return _width; 
    }
	private function set_width(v:Float)  { 
		_width=v;
		 return v ; 
	}
	override private function get_length(): Float { 
    	return Math.max(width,height); 
    }
	/**
	 * height
	 */
	public var height(get_height, set_height):Float;
    private function get_height(): Float { 
    	return _height; 
    }
	private function set_height(v:Float)  { 
		_height=v;
		 return v ; 
	}	
    public function new(vx:Float,vy:Float,w:Float,h:Float) {
    	super(vx, vy);
		//if (numVal(w)<0 or numVal(h
		width=w;
    	height = h; 	
    }
    override public function toString ():String {
		return "x=" + x + ";y=" + y + ";w=" + width + ";h=" + height;
	}
    
}