Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 01:52:13 +0100 (BST)
Received: from sccrmhc14.comcast.net ([63.240.77.84]:20168 "EHLO
	sccrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021792AbXC0AwM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 01:52:12 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (sccrmhc14) with ESMTP
          id <2007032700512801400bmqtle>; Tue, 27 Mar 2007 00:51:28 +0000
Message-ID: <46086A90.7070402@gentoo.org>
Date:	Mon, 26 Mar 2007 20:51:28 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <4606C063.1030802@gentoo.org>	<20070326.193641.15269037.nemoto@toshiba-tops.co.jp>	<4607CF1D.50904@gentoo.org> <20070326.234316.23009158.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070326.234316.23009158.anemo@mba.ocn.ne.jp>
Content-Type: multipart/mixed;
 boundary="------------080803040003020303000201"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080803040003020303000201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Atsushi Nemoto wrote:
> Thanks.  Is this a disassembly of _failed_ kernel?
> 
> If so, it looks KBUILD_64BIT_SYM32 is not defined.  So strange...
> 
> And even if %highest, etc. were used, it should work for CKSEG0
> kernel, while using only %hi should be just an optimization.  Another
> strangeness.
> 
>> 80006ad0:	3c1b0000 	lui	k1,0x0
>> 80006ad4:	677b0000 	daddiu	k1,k1,0
>> 80006ad8:	001bdc38 	dsll	k1,k1,0x10
>> 80006adc:	677b8047 	daddiu	k1,k1,-32697
>> 80006ae0:	001bdc38 	dsll	k1,k1,0x10
>> 80006ae4:	df7b5008 	ld	k1,20488(k1)
> 
> The address of kernelsp should be 0xffffffff80475008.  It seems
> a regular value.

Note to Self: Drink coffee before attempting to follow clearly-stated 
instructions on sending in disassembly of failed kernel.

Lets try this one; the kernel was built with gcc-4.1.2 and binutils-2.17 this 
time around, and I tested it before running objdump on it.  It just hangs right 
after loading:

 > bootp(): console=ttyS0,38400 root=/dev/md0
Setting $netaddr to 192.168.1.12 (from server )
Obtaining  from server
4358278+315290 entry: 0x80401000



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------080803040003020303000201
Content-Type: text/plain;
 name="vmlnx-26204-dis-hi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmlnx-26204-dis-hi.txt"

80006ae0 <handle_int>:
80006ae0:	401a6000 	mfc0	k0,$12
80006ae4:	001ad0c0 	sll	k0,k0,0x3
80006ae8:	07400003 	bltz	k0,80006af8 <handle_int+0x18>
80006aec:	03a0d82d 	move	k1,sp
80006af0:	3c1b8048 	lui	k1,0x8048
80006af4:	df7b9008 	ld	k1,-28664(k1)
80006af8:	03a0d02d 	move	k0,sp
80006afc:	677dfed0 	daddiu	sp,k1,-304
80006b00:	ffba00e8 	sd	k0,232(sp)
80006b04:	ffa30018 	sd	v1,24(sp)
80006b08:	ffa00000 	sd	zero,0(sp)
80006b0c:	40036000 	mfc0	v1,$12
80006b10:	ffa20010 	sd	v0,16(sp)
80006b14:	ffa30100 	sd	v1,256(sp)
80006b18:	ffa40020 	sd	a0,32(sp)
80006b1c:	40036800 	mfc0	v1,$13
80006b20:	ffa50028 	sd	a1,40(sp)
80006b24:	ffa30120 	sd	v1,288(sp)
80006b28:	ffa60030 	sd	a2,48(sp)
80006b2c:	40237000 	dmfc0	v1,$14
80006b30:	ffa70038 	sd	a3,56(sp)
80006b34:	ffa80040 	sd	t0,64(sp)
80006b38:	ffa90048 	sd	t1,72(sp)
80006b3c:	ffa30128 	sd	v1,296(sp)
80006b40:	ffb900c8 	sd	t9,200(sp)
80006b44:	ffbc00e0 	sd	gp,224(sp)
80006b48:	ffbf00f8 	sd	ra,248(sp)
80006b4c:	37bc3fff 	ori	gp,sp,0x3fff
80006b50:	3b9c3fff 	xori	gp,gp,0x3fff
80006b54:	ffa10008 	sd	at,8(sp)
80006b58:	00001810 	mfhi	v1
80006b5c:	ffa30108 	sd	v1,264(sp)
80006b60:	00001812 	mflo	v1
80006b64:	ffaa0050 	sd	t2,80(sp)
80006b68:	ffab0058 	sd	t3,88(sp)
80006b6c:	ffa30110 	sd	v1,272(sp)
80006b70:	ffac0060 	sd	t4,96(sp)
80006b74:	ffad0068 	sd	t5,104(sp)
80006b78:	ffae0070 	sd	t6,112(sp)
80006b7c:	ffaf0078 	sd	t7,120(sp)
80006b80:	ffb800c0 	sd	t8,192(sp)
80006b84:	ffb00080 	sd	s0,128(sp)
80006b88:	ffb10088 	sd	s1,136(sp)
80006b8c:	ffb20090 	sd	s2,144(sp)
80006b90:	ffb30098 	sd	s3,152(sp)
80006b94:	ffb400a0 	sd	s4,160(sp)
80006b98:	ffb500a8 	sd	s5,168(sp)
80006b9c:	ffb600b0 	sd	s6,176(sp)
80006ba0:	ffb700b8 	sd	s7,184(sp)
80006ba4:	ffbe00f0 	sd	s8,240(sp)
80006ba8:	400c6000 	mfc0	t4,$12
80006bac:	3c0d1000 	lui	t5,0x1000
80006bb0:	35ad001f 	ori	t5,t5,0x1f
80006bb4:	018d6025 	or	t4,t4,t5
80006bb8:	398c001f 	xori	t4,t4,0x1f
80006bbc:	408c6000 	mtc0	t4,$12
	...
80006bcc:	df900058 	ld	s0,88(gp)
80006bd0:	ff9d0058 	sd	sp,88(gp)
80006bd4:	3c1f8000 	lui	ra,0x8000
80006bd8:	0800154e 	j	80005538 <plat_irq_dispatch>
80006bdc:	67ff68c0 	daddiu	ra,ra,26816

--------------080803040003020303000201--
