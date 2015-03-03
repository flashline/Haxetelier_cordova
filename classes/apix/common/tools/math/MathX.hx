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
import apix.common.util.Object;
class MathX { 
	/**
	* used to encrypt a number
	* 
	*/
	public static inline var CODE_F:Int=7;
	/**
	* used to encrypt a number
	* 
	*/
	public static inline var CODE_E:Int=9;
	/**
	* used to encrypt a number
	* 
	*/
	public static inline var CODE_D:Int=2;
	/**
	* used to encrypt a number
	* 
	*/
	public static inline var CODE_C:Int=3;
	/**
	* used to encrypt a number
	* 
	*/
	public static inline var CODE_B:Int=5;
	
	/**
	* Compute the root Nth of a number
	* <br/>	n the number we look for its root
	* <br/>	N the level of root - by default N=3 : We look for the cubic root 
	* <br/> 	p Precision - by default : 2 digits after coma
	* <br/> return    the root Nth of n  
	*/
	static public function rootNOf (n : Float,N:Float=3,p:Int=2) : Float {
		if (p<1) p=1;p=Math.round(p);
		if (N<1) N=1;N=Math.round(N);
		return Math.round(Math.pow(n,1/N)*Math.pow(10,p))/Math.pow(10,p);
	}	
	/**
	* Encrypt a number
	* <p>If keys are null the methods take some static codes.</p>
	* <br/>	n		The number to be encrypted
	* <br/>	vbf		1st key
	* <br/>	vbe		2nd key
	* <br/>	vbd		3rd key
	* <br/>	vbc		4th key
	* <br/>	vbb		5th key
	* <br/> return  Encrypted Number
	*/
	static public function num2Crypt(n:Float,vbf:Int=null,vbe:Int=null,vbd:Int=null,vbc:Int=null,vbb:Int=null):Int {
		var nsrc:Int=Std.int(n);
		if (vbf==null) vbf=CODE_F;// sample 7;
		if (vbe==null) vbe=CODE_E;// sample 9;
		if (vbd==null) vbd=CODE_D;// sample 2;
		if (vbc==null) vbc=CODE_C;// sample 3
		if (vbb==null) vbb=CODE_B;// sample 5
		var ca=vbb*vbc*vbd*vbe*vbf;
		var cb=    vbc*vbd*vbe*vbf;
		var cc=        vbd*vbe*vbf;
		var cd=            vbe*vbf;
		var ce=               vbf;
		var a=Math.floor (nsrc/ca) ;
		var mb=nsrc%ca;
		var b=Math.floor (mb/cb) ;
		var mc=mb%cb;
		var c=Math.floor (mc/cc) ;
		var md=mc%cc;
		var d=Math.floor (md/cd) ;
		var me=md%cd;
		var e=Math.floor (me/ce) ;
		var mf=me%ce;
		var f=Math.floor (mf) ;
		var ncryp=a*100000+b*10000+c*1000+d*100+e*10+f;	
		return  ncryp;
	}	
	/**
	* <br/>	n		a number
	* <br/> d 		number of decimal after coma
	* <br/> return  Math.round(n * 10^d) / 10^d;
	*/
	static inline public function round(n:Float, d:Float = 2):Float {
		var p:Float = Math.pow(10, d);
		return Math.round(n * p) / p;
	}
	/**
	* <br/>	n		a number
	* <br/> d 		number of decimal after coma
	* <br/> return  Math.floor(n * 10^d) / 10^d;
	*/
	static inline public function floor(n:Float, ?d:Int = 2):Float {
		var p:Float = Math.pow(10, d);
		return Math.floor(n * p) / p;
	}
	
	
}
