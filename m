Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18AXFa25810
	for linux-mips-outgoing; Fri, 8 Feb 2002 02:33:15 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18AX3A25804
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 02:33:03 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 8 Feb 2002 10:33:03 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 58C3CB479
	for <linux-mips@oss.sgi.com>; Fri,  8 Feb 2002 19:33:01 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA32445; Fri, 8 Feb 2002 19:33:00 +0900 (JST)
Date: Fri, 08 Feb 2002 19:37:31 +0900 (JST)
Message-Id: <20020208.193731.48536791.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Subject: gcc-2.96-99 optimization bug? 
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I found gcc 2.96 (gcc-2.96-99.1.mipsel.rpm in H.J.Lu's RedHat 7.1)
outputs wrong code for this short program.

int foo(unsigned long long a, unsigned long long b)
{
	int as, bs;
	as = a >> 63;
	bs = b >> 63;
	if (as != bs)
		return as || !(b << 1);
	return (a == b) || as;
}

int main(int argc, char **argv)
{
	return foo(0, 0xffffffffffffffffull);
}

This program must return 0.  But compiling with -O2 it returns 1 !!

# gcc -O -o foo foo.c;./foo;echo $?
0
# gcc -O2 -o foo foo.c;./foo;echo $?
1

Output wth -O -g are:

00400780 <foo>:
  400780:	3c1c0fc0 	lui	gp,0xfc0
  400784:	279c78b0 	addiu	gp,gp,30896
  400788:	0399e021 	addu	gp,gp,t9
  40078c:	00804021 	move	t0,a0
  400790:	00a04821 	move	t1,a1
  400794:	000917c2 	srl	v0,t1,0x1f
  400798:	00402821 	move	a1,v0
  40079c:	000717c2 	srl	v0,a3,0x1f
  4007a0:	10a2000d 	beq	a1,v0,4007d8 <foo+0x58>
  4007a4:	00001821 	move	v1,zero
  4007a8:	14a00008 	bnez	a1,4007cc <foo+0x4c>
  4007ac:	00004021 	move	t0,zero
  4007b0:	00071840 	sll	v1,a3,0x1
  4007b4:	000627c2 	srl	a0,a2,0x1f
  4007b8:	00641825 	or	v1,v1,a0
  4007bc:	00061040 	sll	v0,a2,0x1
  4007c0:	00621025 	or	v0,v1,v0
  4007c4:	14400002 	bnez	v0,4007d0 <foo+0x50>
  4007c8:	00000000 	nop
  4007cc:	24080001 	li	t0,1
  4007d0:	03e00008 	jr	ra
  4007d4:	01001021 	move	v0,t0
  4007d8:	15060003 	bne	t0,a2,4007e8 <foo+0x68>
  4007dc:	00001021 	move	v0,zero
  4007e0:	11270003 	beq	t1,a3,4007f0 <foo+0x70>
  4007e4:	00000000 	nop
  4007e8:	10a00002 	beqz	a1,4007f4 <foo+0x74>
  4007ec:	00000000 	nop
  4007f0:	24020001 	li	v0,1
  4007f4:	03e00008 	jr	ra
  4007f8:	00000000 	nop

Output with -O2 -g are:

00400780 <foo>:
  400780:	3c1c0fc0 	lui	gp,0xfc0
  400784:	279c78b0 	addiu	gp,gp,30896
  400788:	0399e021 	addu	gp,gp,t9
  40078c:	00805021 	move	t2,a0
  400790:	00c04021 	move	t0,a2
  400794:	00a05821 	move	t3,a1
  400798:	00e04821 	move	t1,a3
  40079c:	000b17c2 	srl	v0,t3,0x1f
  4007a0:	000927c2 	srl	a0,t1,0x1f
  4007a4:	00001821 	move	v1,zero
  4007a8:	1044000a 	beq	v0,a0,4007d4 <foo+0x54>
  4007ac:	00002821 	move	a1,zero
  4007b0:	14400006 	bnez	v0,4007cc <foo+0x4c>
  4007b4:	24050001 	li	a1,1
  4007b8:	00091840 	sll	v1,t1,0x1
  4007bc:	000827c2 	srl	a0,t0,0x1f
  4007c0:	00641825 	or	v1,v1,a0
  4007c4:	00081040 	sll	v0,t0,0x1
  4007c8:	00621025 	or	v0,v1,v0
  4007cc:	03e00008 	jr	ra
  4007d0:	00a01021 	move	v0,a1
  4007d4:	15480003 	bne	t2,t0,4007e4 <foo+0x64>
  4007d8:	00001821 	move	v1,zero
  4007dc:	11690003 	beq	t3,t1,4007ec <foo+0x6c>
  4007e0:	00000000 	nop
  4007e4:	10400002 	beqz	v0,4007f0 <foo+0x70>
  4007e8:	00000000 	nop
  4007ec:	24030001 	li	v1,1
  4007f0:	03e00008 	jr	ra
  4007f4:	00601021 	move	v0,v1


It seems one 'bnez' in good code (at 4007c4) was lost in bad code.

Is this a know problem?  If so, is there any patches available?

Thank you.
---
Atsushi Nemoto
