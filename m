Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IAtEB16058
	for linux-mips-outgoing; Mon, 18 Feb 2002 02:55:14 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IAsQ916008
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 02:54:26 -0800
Message-Id: <200202181054.g1IAsQ916008@oss.sgi.com>
Received: (qmail 7693 invoked from network); 18 Feb 2002 09:57:06 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 18 Feb 2002 09:57:06 -0000
Date: Mon, 18 Feb 2002 17:51:22 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Hartvig Ekner <hartvige@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: math broken on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1IAsR916009
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
    I find that you are asking only gcc related parts,that is related less,
here they are(from posts on linux-mips,i cc them to the list in case it is
useful,sorry if it brings you inconvenience):

1.about NaN handling
-----------------begin of the first problem--------------------------------
I am sorry but it seems i can't fix this without ugly changes.
since i am not familiar with gcc code, i decide to leave it to you,
but provide some information instead.

  In gcc there are 3 spaces where the NaN handling is assumed the 
Intel way.

   1. gcc/real.c (the most important one)
       here the author seems to have known the NaN pattern problem,so
     he leaves a interface macro for defining non intel NaN patterns:
     (comment of function "make_nan()",at about line 6219)

/* Output a binary NaN bit pattern in the target machine's format.  */

/* If special NaN bit patterns are required, define them in tm.h
   as arrays of unsigned 16-bit shorts.  Otherwise, use the default
   patterns here.  */

  I have read through this file and decided that the follow defined should
be enough for mips:
 
/* NaN pattern,mips QNAN & SNAN is different from intel's 
 * DFMODE_NAN and SFMODE_NAN is used in real.c */
#define DFMODE_NAN \
        unsigned short DFbignan[4] = {0x7ff7, 0xffff, 0xffff, 0xffff}; \
        unsigned short DFlittlenan[4] = {0xffff, 0xffff, 0xffff, 0xfff7}
#define SFMODE_NAN \
        unsigned short SFbignan[2] = {0x7fbf, 0xffff}; \
        unsigned short SFlittlenan[2] = {0xffff, 0xffbf}

   But the problem is where to put them:(. Obviously it is target specified
definitions and should be in config/mips/. Documents say tm.h is a symbol
link and included in config.h,but it is no long true.If i add them to xm-mips.h
then for native compilation it is ok but it fails for cross-compile.

   2.gcc/reg-stack.c (H.J. tell me it is not used on mips)
     There is a hardcoded QNaN used around line 477:
      nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
     I sugest defining a macro QNAN_HAS_1ST_FRACBIT_CLEARED for mips and change
     it to,just don't know where to put it:
      #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
         nan = gen_lowpart (SFmode, GEN_INT (0x7fc00000));
      #else
         nan = gen_lowpart (SFmode, GEN_INT (0x7fbfffff));
      #endif

   3. config/fp-bit.c (H.J. said it is not mean to target specified)
      this is for machine having no fpu hardware.
      again i susgest define QNAN_HAS_1ST_FRACBIT_CLEARED and then apply this patch:

190d189
< #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
192,195d190
< #else
<         fraction &= ~QUIET_NAN;
< #endif
< 
379,380d373
< 
< #ifndef QNAN_HAS_1ST_FRACBIT_CLEARED
382,384d374
< #else
<         if (!(fraction & QUIET_NAN))
< #endif
     
 
ÔÚ 2002-02-03 22:54:00 you wrote£º
>On Mon, Feb 04, 2002 at 02:22:48PM +0800, Zhang Fuxin wrote:
>> hi,
>> 
>> Gcc (2.96 20000731,H.J.LU's rh port for mips) think 0x7fc00000 is QNaN and 
>> optimize 0.0/0.0 as 0x7fc00000 for single precision ops,while for my cpu
>> (maybe most mips cpu) is a SNaN. R4k user's manual and "See Mips Run" both
>>  say so.And experiments confirm this.
>> 
>> Should we correct it?
>
>Yes. Do you have a patch?
>
>Thanks.
>
>
>H.J.
-------------------------end of first problem--------------------------------

--------------------------begin of the second problem------------------------

2. gcc -O2 optimization bug No.1
    It seems gcc with optimization > -O2 will produce incorrect code for fp code:
I find this example when tracking down the libm-test failures.
  ( expf(NaN) == NaN will report an extra "invalid operation" exception )
The faulting code snippet is(from glibc/sysdeps/ieee754/flt-32/w_expf.c):
	float __my_expf(float x)		/* wrapper expf */
{
	float z;
	unsigned int hx;
	z = __ieee754_expf(x);
	if(_LIB_VERSION == _IEEE_) return z;
	if(__finitef(x)) {
	    if(x>o_threshold)
		return 1.0;
	    else if(x<u_threshold)
		return 2.0;
            printf("haha\n");
	} 
	return z;
}

with -O2(or higher),some statements inside "if (__finitef(x))" are put before
testing the return value of __finitef(x),one of which is a c.lt.s that cause
the extra "invalid operation" exception being raised.

the obj codes is listed below:
1.  without -O
0000000000401290 <__my_expf>:
  401290:	3c1c0fc0 	lui	gp,0xfc0
  401294:	279c6dd0 	addiu	gp,gp,28112
  401298:	0399e021 	addu	gp,gp,t9
  40129c:	27bdffd0 	addiu	sp,sp,-48
  4012a0:	afbc0010 	sw	gp,16(sp)
  4012a4:	afbf0028 	sw	ra,40(sp)
  4012a8:	afbe0024 	sw	s8,36(sp)
  4012ac:	afbc0020 	sw	gp,32(sp)
  4012b0:	03a0f021 	move	s8,sp
  4012b4:	e7cc0030 	swc1	$f12,48(s8)
  4012b8:	c7cc0030 	lwc1	$f12,48(s8)
  4012bc:	8f998088 	lw	t9,-32632(gp)
  4012c0:	00000000 	nop
  4012c4:	0320f809 	jalr	t9
  4012c8:	00000000 	nop
  4012cc:	8fdc0010 	lw	gp,16(s8)
  4012d0:	e7c00018 	swc1	$f0,24(s8)
  4012d4:	8f8380ac 	lw	v1,-32596(gp)
  4012d8:	00000000 	nop
  4012dc:	8c630000 	lw	v1,0(v1)
  4012e0:	2402ffff 	li	v0,-1
  4012e4:	14620004 	bne	v1,v0,4012f8 <__my_expf+0x68>
  4012e8:	00000000 	nop
  4012ec:	c7c00018 	lwc1	$f0,24(s8)
  4012f0:	10000032 	b	4013bc <__my_expf+0x12c>
  4012f4:	00000000 	nop
  4012f8:	c7cc0030 	lwc1	$f12,48(s8)
  4012fc:	8f998090 	lw	t9,-32624(gp)
  401300:	00000000 	nop
  401304:	0320f809 	jalr	t9
  401308:	00000000 	nop
  40130c:	8fdc0010 	lw	gp,16(s8)
  401310:	10400029 	beqz	v0,4013b8 <__my_expf+0x128>
  401314:	00000000 	nop
  401318:	c7c20030 	lwc1	$f2,48(s8)
  40131c:	8f818018 	lw	at,-32744(gp)
  401320:	00000000 	nop
  401324:	242142a0 	addiu	at,at,17056
  401328:	c4200000 	lwc1	$f0,0(at)
  40132c:	00000000 	nop
  401330:	4602003c 	c.lt.s	$f0,$f2
  401334:	00000000 	nop
  401338:	45010003 	bc1t	401348 <__my_expf+0xb8>
  40133c:	00000000 	nop
  401340:	10000005 	b	401358 <__my_expf+0xc8>
  401344:	00000000 	nop
  401348:	3c013f80 	lui	at,0x3f80
  40134c:	44810000 	mtc1	at,$f0
  401350:	1000001a 	b	4013bc <__my_expf+0x12c>
  401354:	00000000 	nop
  401358:	c7c20030 	lwc1	$f2,48(s8)
  40135c:	8f818018 	lw	at,-32744(gp)
  401360:	00000000 	nop
  401364:	242142a4 	addiu	at,at,17060
  401368:	c4200000 	lwc1	$f0,0(at)
  40136c:	00000000 	nop
  401370:	4600103c 	c.lt.s	$f2,$f0
  401374:	00000000 	nop
  401378:	45010003 	bc1t	401388 <__my_expf+0xf8>
  40137c:	00000000 	nop
  401380:	10000005 	b	401398 <__my_expf+0x108>
  401384:	00000000 	nop
  401388:	3c014000 	lui	at,0x4000
  40138c:	44810000 	mtc1	at,$f0
  401390:	1000000a 	b	4013bc <__my_expf+0x12c>
  401394:	00000000 	nop
  401398:	8f848018 	lw	a0,-32744(gp)
  40139c:	00000000 	nop
  4013a0:	248442a8 	addiu	a0,a0,17064
  4013a4:	8f998058 	lw	t9,-32680(gp)
  4013a8:	00000000 	nop
  4013ac:	0320f809 	jalr	t9
  4013b0:	00000000 	nop
  4013b4:	8fdc0010 	lw	gp,16(s8)
  4013b8:	c7c00018 	lwc1	$f0,24(s8)
  4013bc:	03c0e821 	move	sp,s8
  4013c0:	8fbf0028 	lw	ra,40(sp)
  4013c4:	8fbe0024 	lw	s8,36(sp)
  4013c8:	03e00008 	jr	ra
  4013cc:	27bd0030 	addiu	sp,sp,48

2. with -O2
   0000000000400fc0 <__my_expf>:
  400fc0:	3c1c0fc0 	lui	gp,0xfc0
  400fc4:	279c70a0 	addiu	gp,gp,28832
  400fc8:	0399e021 	addu	gp,gp,t9
  400fcc:	27bdffd0 	addiu	sp,sp,-48
  400fd0:	afbc0010 	sw	gp,16(sp)
  400fd4:	e7b60028 	swc1	$f22,40(sp)
  400fd8:	e7b7002c 	swc1	$f23,44(sp)
  400fdc:	e7b40020 	swc1	$f20,32(sp)
  400fe0:	e7b50024 	swc1	$f21,36(sp)
  400fe4:	afbf001c 	sw	ra,28(sp)
  400fe8:	46006506 	mov.s	$f20,$f12
  400fec:	afbc0018 	sw	gp,24(sp)
  400ff0:	8f998088 	lw	t9,-32632(gp)
  400ff4:	00000000 	nop
  400ff8:	0320f809 	jalr	t9
  400ffc:	00000000 	nop
  401000:	8fbc0010 	lw	gp,16(sp)
  401004:	00000000 	nop
  401008:	8f8380ac 	lw	v1,-32596(gp)
  40100c:	00000000 	nop
  401010:	8c630000 	lw	v1,0(v1)
  401014:	2402ffff 	li	v0,-1
  401018:	46000586 	mov.s	$f22,$f0
  40101c:	10620021 	beq	v1,v0,4010a4 <__my_expf+0xe4>
  401020:	4600a306 	mov.s	$f12,$f20
  401024:	8f998090 	lw	t9,-32624(gp)
  401028:	00000000 	nop
  40102c:	0320f809 	jalr	t9
  401030:	00000000 	nop
  401034:	8fbc0010 	lw	gp,16(sp)
  401038:	3c0142b1 	lui	at,0x42b1
  40103c:	34217180 	ori	at,at,0x7180
  401040:	44811000 	mtc1	at,$f2
  401044:	3c013f80 	lui	at,0x3f80
  401048:	44810000 	mtc1	at,$f0
  40104c:	4614103c 	c.lt.s	$f2,$f20  // this is wrongly put ahead ?
  401050:	10400013 	beqz	v0,4010a0 <__my_expf+0xe0>
  401054:	00000000 	nop
  401058:	45010012 	bc1t	4010a4 <__my_expf+0xe4>
  40105c:	00000000 	nop
  401060:	3c01c2cf 	lui	at,0xc2cf
  401064:	3421f1b5 	ori	at,at,0xf1b5
  401068:	44810000 	mtc1	at,$f0
  40106c:	8f848018 	lw	a0,-32744(gp)
  401070:	00000000 	nop
  401074:	24843fa8 	addiu	a0,a0,16296
  401078:	4600a03c 	c.lt.s	$f20,$f0
  40107c:	3c014000 	lui	at,0x4000
  401080:	44810000 	mtc1	at,$f0
  401084:	45010007 	bc1t	4010a4 <__my_expf+0xe4>
  401088:	00000000 	nop
  40108c:	8f998058 	lw	t9,-32680(gp)
  401090:	00000000 	nop
  401094:	0320f809 	jalr	t9
  401098:	00000000 	nop
  40109c:	8fbc0010 	lw	gp,16(sp)
  4010a0:	4600b006 	mov.s	$f0,$f22
  4010a4:	8fbf001c 	lw	ra,28(sp)
  4010a8:	c7b60028 	lwc1	$f22,40(sp)
  4010ac:	c7b7002c 	lwc1	$f23,44(sp)
  4010b0:	c7b40020 	lwc1	$f20,32(sp)
  4010b4:	c7b50024 	lwc1	$f21,36(sp)
  4010b8:	03e00008 	jr	ra
  4010bc:	27bd0030 	addiu	sp,sp,48

----------------------------end of the second problem------------------------

----------------------------begin of 3rd problem-----------------------------
3.wrong code from gcc -O2,No.2
hi,
    it seems fixed in latest gcc (3.1). gcc 2.96 does produce wrong code
 for -O2, i posted another example one or two days ago.


ÔÚ 2002-02-08 19:37:00 you wrote£º
>I found gcc 2.96 (gcc-2.96-99.1.mipsel.rpm in H.J.Lu's RedHat 7.1)
>outputs wrong code for this short program.
>
>int foo(unsigned long long a, unsigned long long b)
>{
>	int as, bs;
>	as = a >> 63;
>	bs = b >> 63;
>	if (as != bs)
>		return as || !(b << 1);
>	return (a == b) || as;
>}
>
>int main(int argc, char **argv)
>{
>	return foo(0, 0xffffffffffffffffull);
>}
>
>This program must return 0.  But compiling with -O2 it returns 1 !!
>
># gcc -O -o foo foo.c;./foo;echo $?
>0
># gcc -O2 -o foo foo.c;./foo;echo $?
>1
>
>Output wth -O -g are:
>
>00400780 <foo>:
>  400780:	3c1c0fc0 	lui	gp,0xfc0
>  400784:	279c78b0 	addiu	gp,gp,30896
>  400788:	0399e021 	addu	gp,gp,t9
>  40078c:	00804021 	move	t0,a0
>  400790:	00a04821 	move	t1,a1
>  400794:	000917c2 	srl	v0,t1,0x1f
>  400798:	00402821 	move	a1,v0
>  40079c:	000717c2 	srl	v0,a3,0x1f
>  4007a0:	10a2000d 	beq	a1,v0,4007d8 <foo+0x58>
>  4007a4:	00001821 	move	v1,zero
>  4007a8:	14a00008 	bnez	a1,4007cc <foo+0x4c>
>  4007ac:	00004021 	move	t0,zero
>  4007b0:	00071840 	sll	v1,a3,0x1
>  4007b4:	000627c2 	srl	a0,a2,0x1f
>  4007b8:	00641825 	or	v1,v1,a0
>  4007bc:	00061040 	sll	v0,a2,0x1
>  4007c0:	00621025 	or	v0,v1,v0
>  4007c4:	14400002 	bnez	v0,4007d0 <foo+0x50>
>  4007c8:	00000000 	nop
>  4007cc:	24080001 	li	t0,1
>  4007d0:	03e00008 	jr	ra
>  4007d4:	01001021 	move	v0,t0
>  4007d8:	15060003 	bne	t0,a2,4007e8 <foo+0x68>
>  4007dc:	00001021 	move	v0,zero
>  4007e0:	11270003 	beq	t1,a3,4007f0 <foo+0x70>
>  4007e4:	00000000 	nop
>  4007e8:	10a00002 	beqz	a1,4007f4 <foo+0x74>
>  4007ec:	00000000 	nop
>  4007f0:	24020001 	li	v0,1
>  4007f4:	03e00008 	jr	ra
>  4007f8:	00000000 	nop
>
>Output with -O2 -g are:
>
>00400780 <foo>:
>  400780:	3c1c0fc0 	lui	gp,0xfc0
>  400784:	279c78b0 	addiu	gp,gp,30896
>  400788:	0399e021 	addu	gp,gp,t9
>  40078c:	00805021 	move	t2,a0
>  400790:	00c04021 	move	t0,a2
>  400794:	00a05821 	move	t3,a1
>  400798:	00e04821 	move	t1,a3
>  40079c:	000b17c2 	srl	v0,t3,0x1f
>  4007a0:	000927c2 	srl	a0,t1,0x1f
>  4007a4:	00001821 	move	v1,zero
>  4007a8:	1044000a 	beq	v0,a0,4007d4 <foo+0x54>
>  4007ac:	00002821 	move	a1,zero
>  4007b0:	14400006 	bnez	v0,4007cc <foo+0x4c>
>  4007b4:	24050001 	li	a1,1
>  4007b8:	00091840 	sll	v1,t1,0x1
>  4007bc:	000827c2 	srl	a0,t0,0x1f
>  4007c0:	00641825 	or	v1,v1,a0
>  4007c4:	00081040 	sll	v0,t0,0x1
>  4007c8:	00621025 	or	v0,v1,v0
>  4007cc:	03e00008 	jr	ra
>  4007d0:	00a01021 	move	v0,a1
>  4007d4:	15480003 	bne	t2,t0,4007e4 <foo+0x64>
>  4007d8:	00001821 	move	v1,zero
>  4007dc:	11690003 	beq	t3,t1,4007ec <foo+0x6c>
>  4007e0:	00000000 	nop
>  4007e4:	10400002 	beqz	v0,4007f0 <foo+0x70>
>  4007e8:	00000000 	nop
>  4007ec:	24030001 	li	v1,1
>  4007f0:	03e00008 	jr	ra
>  4007f4:	00601021 	move	v0,v1
>
>
>It seems one 'bnez' in good code (at 4007c4) was lost in bad code.
>
>Is this a know problem?  If so, is there any patches available?
>
>Thank you.
>---
>Atsushi Nemoto 
-----------------------------end of 3rd problem------------------------


ÔÚ 2002-02-18 09:16:00 you wrote£º
>Hi Zhang,
>
>we're talking to Algorithmics about the possibility of productizing their
>SDE compiler for Linux. If this materializes, we should be able to get the
>GCC issues you mention fixed.
>
>Could you therefore pls. send me examples showing all the GCC issues you
>mention:
>
>1) SNan & QNan handling wrong
>2) Wrong code generated with -O2 (exception handling problem)
>3) Wrong code generated with -O2 (long long type problem)
>
>I would like (small!) examples suitable for inclusion directly in a work 
>specification, so items like "Mozilla doesn't run" is not good enough :-)
>
>Finally, Kjeld E. at MIPS is spending some time on math-emu. So if you have
>specific issues, you can try to mail him as well (kjelde@mips.com).
>
>Problem #4 you report could be either in glibc or math-emu. If it's math-emu
>we'll fix it.
>
>/Hartvig
>
>
>Zhang Fuxin writes:
>> 
>> hi,
>>    There are so many problems on math handling for linux-mips,including:
>> 1. SNaN & QNan handling(both gcc & glibc)
>> 2. gcc2.96 generates wrong code with -O2,at least 
>>      one will lead to exception handling problem(reported by me)
>>      one will lead to some 'long long' type mishandling(reported by Atsushi Nemoto)
>> 
>>    (gcc3.1 seems a lot better,but it has problem to compile glibc.I can't even compile
>>  current glibc cvs code(with dl-conflict.c etc patched) with it. The best result is
>>  a segment fault when using ld.so.1:
>>       ../elf/ld.so.1 --library-path ..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:
>>   ../crypt:../linuxthreads ./rpcgen -Y ../scripts -c rpcsvc/bootparam_prot.x -o 
>>   xbootparam_prot.T
>>   make[1]: *** [xbootparam_prot.stmp] Segmentation fault
>>   )     
>> 3. problems with math-emu
>> 4. other problems to be investigated for its cause,including this one,
>>   
>>        pow(2,7) = 128.0 when rounding = TONEAREST or UPWARD
>>                 = 64.1547.. when rounding = DOWNWARD or TOWARDZERO
>> 
>>  when today i find out the above problem I was feeling almost despaired:(
>> 
>>  I want to fix these problems,if i could.But it concerns so many things that i am not
>>  expert on and no time to dig:(. So any help will be highly appreciated.
>> 
>>  
>> 
>> 
>> Regards
>>             Zhang Fuxin
>>             fxzhang@ict.ac.cn

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
