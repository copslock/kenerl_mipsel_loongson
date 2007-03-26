Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 14:49:20 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:34251 "EHLO
	rwcrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022801AbXCZNtP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 14:49:15 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20070326134813m11004cq4he>; Mon, 26 Mar 2007 13:48:14 +0000
Message-ID: <4607CF1D.50904@gentoo.org>
Date:	Mon, 26 Mar 2007 09:48:13 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <4606AA74.3070907@gentoo.org>	<20070326.020705.63742150.anemo@mba.ocn.ne.jp>	<4606C063.1030802@gentoo.org> <20070326.193641.15269037.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070326.193641.15269037.nemoto@toshiba-tops.co.jp>
Content-Type: multipart/mixed;
 boundary="------------040102000707030204010708"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040102000707030204010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Atsushi Nemoto wrote:

> It looks very strange.  "lui k1, %hi(kernelsp)" should be enough for
> the -msym32 kernel.  What is a version of binutils and gcc you are using?
> 
> And could you show me disassembled list of handle_int (or some other
> rountines using get_saved_sp) of failed kernel?
> 
> If you were using gcc 3.x, does this fix work for you?
> 
> #if defined(CONFIG_32BIT) || (defined(KBUILD_64BIT_SYM32) &&  __GNUC__ >= 4)
>   		lui	k1, %hi(kernelsp)
> #else

# mips64-unknown-linux-gnu-ld --version
GNU ld version 2.16.1

# mips64-unknown-linux-gnu-gcc --version
mips64-unknown-linux-gnu-gcc (GCC) 4.1.1 (Gentoo 4.1.1-r3)

And the disassembly of vmlinux.32 for the handle_int function is attached.

I haven't built a kernel w/ gcc-3.x for some time, probably last time being when 
I was chasing down the strange funkiness in my Octane's userland in 2.6.19.



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------040102000707030204010708
Content-Type: text/plain;
 name="vmlnx-26204-dis-hi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmlnx-26204-dis-hi.txt"

80006ac0 <handle_int>:
80006ac0:	401a6000 	mfc0	k0,$12
80006ac4:	001ad0c0 	sll	k0,k0,0x3
80006ac8:	07400007 	bltz	k0,80006ae8 <handle_int+0x28>
80006acc:	03a0d82d 	move	k1,sp
80006ad0:	3c1b0000 	lui	k1,0x0
80006ad4:	677b0000 	daddiu	k1,k1,0
80006ad8:	001bdc38 	dsll	k1,k1,0x10
80006adc:	677b8047 	daddiu	k1,k1,-32697
80006ae0:	001bdc38 	dsll	k1,k1,0x10
80006ae4:	df7b5008 	ld	k1,20488(k1)
80006ae8:	03a0d02d 	move	k0,sp
80006aec:	677dfed0 	daddiu	sp,k1,-304
80006af0:	ffba00e8 	sd	k0,232(sp)
80006af4:	ffa30018 	sd	v1,24(sp)
80006af8:	ffa00000 	sd	zero,0(sp)
80006afc:	40036000 	mfc0	v1,$12
80006b00:	ffa20010 	sd	v0,16(sp)
80006b04:	ffa30100 	sd	v1,256(sp)
80006b08:	ffa40020 	sd	a0,32(sp)
80006b0c:	40036800 	mfc0	v1,$13
80006b10:	ffa50028 	sd	a1,40(sp)
80006b14:	ffa30120 	sd	v1,288(sp)
80006b18:	ffa60030 	sd	a2,48(sp)
80006b1c:	40237000 	dmfc0	v1,$14
80006b20:	ffa70038 	sd	a3,56(sp)
80006b24:	ffa80040 	sd	t0,64(sp)
80006b28:	ffa90048 	sd	t1,72(sp)
80006b2c:	ffa30128 	sd	v1,296(sp)
80006b30:	ffb900c8 	sd	t9,200(sp)
80006b34:	ffbc00e0 	sd	gp,224(sp)
80006b38:	ffbf00f8 	sd	ra,248(sp)
80006b3c:	37bc3fff 	ori	gp,sp,0x3fff
80006b40:	3b9c3fff 	xori	gp,gp,0x3fff
80006b44:	ffa10008 	sd	at,8(sp)
80006b48:	00001810 	mfhi	v1
80006b4c:	ffa30108 	sd	v1,264(sp)
80006b50:	00001812 	mflo	v1
80006b54:	ffaa0050 	sd	t2,80(sp)
80006b58:	ffab0058 	sd	t3,88(sp)
80006b5c:	ffa30110 	sd	v1,272(sp)
80006b60:	ffac0060 	sd	t4,96(sp)
80006b64:	ffad0068 	sd	t5,104(sp)
80006b68:	ffae0070 	sd	t6,112(sp)
80006b6c:	ffaf0078 	sd	t7,120(sp)
80006b70:	ffb800c0 	sd	t8,192(sp)
80006b74:	ffb00080 	sd	s0,128(sp)
80006b78:	ffb10088 	sd	s1,136(sp)
80006b7c:	ffb20090 	sd	s2,144(sp)
80006b80:	ffb30098 	sd	s3,152(sp)
80006b84:	ffb400a0 	sd	s4,160(sp)
80006b88:	ffb500a8 	sd	s5,168(sp)
80006b8c:	ffb600b0 	sd	s6,176(sp)
80006b90:	ffb700b8 	sd	s7,184(sp)
80006b94:	ffbe00f0 	sd	s8,240(sp)
80006b98:	400c6000 	mfc0	t4,$12
80006b9c:	3c0d1000 	lui	t5,0x1000
80006ba0:	35ad001f 	ori	t5,t5,0x1f
80006ba4:	018d6025 	or	t4,t4,t5
80006ba8:	398c001f 	xori	t4,t4,0x1f
80006bac:	408c6000 	mtc0	t4,$12
	...
80006bbc:	df900058 	ld	s0,88(gp)
80006bc0:	ff9d0058 	sd	sp,88(gp)
80006bc4:	3c1f8000 	lui	ra,0x8000
80006bc8:	0800154e 	j	80005538 <plat_irq_dispatch>
80006bcc:	67ff68a0 	daddiu	ra,ra,26784


--------------040102000707030204010708--
