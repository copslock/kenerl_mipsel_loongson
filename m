Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2I0ruM11364
	for linux-mips-outgoing; Sun, 17 Mar 2002 16:53:56 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2I0ri911360
	for <linux-mips@oss.sgi.com>; Sun, 17 Mar 2002 16:53:45 -0800
Message-Id: <200203180053.g2I0ri911360@oss.sgi.com>
Received: (qmail 31152 invoked from network); 18 Mar 2002 01:02:25 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 18 Mar 2002 01:02:25 -0000
Date: Mon, 18 Mar 2002 8:55:47 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Hartvig Ekner <hartvige@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Compiler problem in glibc
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g2I0rk911361
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

 good news to hear they are being fixed. I reported this problem
about one month ago,it was fixed in gcc3.1. But i have no time
to investigate other math test problems,wish you good luck:)

ÔÚ 2002-03-17 11:52:00 you wrote£º
>I have found a problem in glibc caused by the gcc-2.96-99.1 compiler
>from H.J's miniport.
>
>in the exp() function (file w_expf.c), there is code like: 
>
>#ifdef __STDC__
>        float __expf(float x)           /* wrapper expf */
>#else
>        float __expf(x)                 /* wrapper expf */
>        float x;
>#endif
>{
>#ifdef _IEEE_LIBM
>        return __ieee754_expf(x);
>#else
>        float z;
>        z = __ieee754_expf(x);
>        if(_LIB_VERSION == _IEEE_) return z;
>
>        if(__finitef(x)) {
>            if(x>o_threshold)
>
>
>(IEEE_LIBM is not set). Note that there are two function calls (ieee754_expf
>and finitef()) followed by a FP if-statement (x>o_threshold). This 
>translates into:
>
>00400570 <__expf>:
>  400570:       3c1c0fc1        lui     gp,0xfc1
>  400574:       279cc090        addiu   gp,gp,-16240
>  400578:       0399e021        addu    gp,gp,t9
>  40057c:       27bdffc8        addiu   sp,sp,-56
>  400580:       afbc0018        sw      gp,24(sp)
>  400584:       e7b60030        swc1    $f22,48(sp)
>  400588:       e7b70034        swc1    $f23,52(sp)
>  40058c:       e7b40028        swc1    $f20,40(sp)
>  400590:       e7b5002c        swc1    $f21,44(sp)
>  400594:       afbf0024        sw      ra,36(sp)
>  400598:       46006506        mov.s   $f20,$f12
>  40059c:       afbc0020        sw      gp,32(sp)
>  4005a0:       8f998630        lw      t9,-31184(gp)
>  4005a4:       00000000        nop
>  4005a8:       0320f809        jalr    t9		__ieee754_expf
>  4005ac:       00000000        nop
>  4005b0:       8fbc0018        lw      gp,24(sp)
>  4005b4:       00000000        nop
>  4005b8:       8f8388f4        lw      v1,-30476(gp)
>  4005bc:       00000000        nop
>  4005c0:       8c630000        lw      v1,0(v1)
>  4005c4:       2402ffff        li      v0,-1
>  4005c8:       46000586        mov.s   $f22,$f0
>  4005cc:       1062002d        beq     v1,v0,400684 <__expf+0x114>
>  4005d0:       4600a306        mov.s   $f12,$f20
>  4005d4:       8f9986d0        lw      t9,-31024(gp)
>  4005d8:       00000000        nop
>  4005dc:       0320f809        jalr    t9		finitef()
>  4005e0:       00000000        nop
>  4005e4:       8fbc0018        lw      gp,24(sp)
>  4005e8:       00000000        nop
>  4005ec:       3c0142b1        lui     at,0x42b1
>  4005f0:       34217180        ori     at,at,0x7180
>  4005f4:       44810000        mtc1    at,$f0
>  4005f8:       00000000        nop
>  4005fc:       4614003c        c.lt.s  $f0,$f20	Wow!!!!
>        ...
>  400608:       1040001e        beqz    v0,400684 <__expf+0x114>
>  40060c:       4600b006        mov.s   $f0,$f22
>  400610:       4500000b        bc1f    400640 <__expf+0xd0>
>
>
>Note that the c.lt.s (from the FP compare) is done before the finitef()
>value has been checked (beqz in 400608). This particular issue causes
>the wrong setting of bits in the FPU SR in some cases (with exp(nan)),
>and "make check" in glibc to fail.
>
>BTW, the "make check" in glibc has so far turned up a few other items in 
>glibc as well as in the kernel (FPU emulator), which are being fixed.
>
>/Hartvig
>
>-- 
> _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
> |\  /| | |____)(____                          Direct: +45 4486 5503
> | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
>T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
