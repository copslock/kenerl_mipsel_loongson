Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18AuVr27040
	for linux-mips-outgoing; Fri, 8 Feb 2002 02:56:31 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18AuIA27035
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 02:56:18 -0800
Message-Id: <200202081056.g18AuIA27035@oss.sgi.com>
Received: (qmail 21926 invoked from network); 8 Feb 2002 10:57:19 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 8 Feb 2002 10:57:19 -0000
Date: Fri, 8 Feb 2002 18:53:46 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: gcc-2.96-99 optimization bug?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g18AuJA27037
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
