Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA2493688 for <linux-archive@neteng.engr.sgi.com>; Sat, 25 Apr 1998 21:37:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA16645247
	for linux-list;
	Sat, 25 Apr 1998 21:35:05 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA16179620
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 25 Apr 1998 21:35:01 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id VAA19971
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Apr 1998 21:35:00 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA17765;
	Sun, 26 Apr 1998 00:34:54 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 26 Apr 1998 00:34:54 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: gcc RPM missing crtbegin.o
In-Reply-To: <19980426053938.20282@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980426002620.16850A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 26 Apr 1998 ralf@uni-koblenz.de wrote:
> > I do have a problem that just came up.  Here it is, hand typed.  I was
> > doing a lot of work on sdc, which is an external 3GB drive that I know
> > works well.  It hasn't reported any problems in e2fsck.  There was a lot
> > of activity when this happened:
> 
> Did you already fsck the filesystems running .91?  The corruption in the
> older kernels was happening silently, so the boot fsck may have been skipped
> even though the fs was corrupted.

Yup, I've had this problem twice now, both with .91. I'm pretty sure I can
reproduce it (but not until I'm at my desk tomorrow, since I need to hit
the little thumbtack to reboot it.  I still think SGI should have shipped
the Indys with thumbtacks.)

> > $0 : 00000000 1000fc00 00001000 ffffffe0
> > $4 : 00000020 00000000 1000fc00 00000001
> > $8 : 1000fc00 1000001f 00000000 00000007
> > $12: 40000000 8bf50020 1000fc00 00000001
> > $16: 00000000 00001000 abf56020 8bf53800
> > $20: 00000002 bfbc0003 1fffffff bfb90000
> > $24: 00000002 0fb6f710 
> > $28: 00008000 08009d28 8bf57e70 080f3b5c
>                                   ^^^^^^^^
> > epc   :88020fc0
>          ^^^^^^^^
> tell me where these two addresses are pointing to?  Just send me twenty
> lines or so around the addresses.  (In general that's the right thing to
> do when the machine bombs with a register dump.)
> (Also I'm pretty shure that you misstyped $28 and $29 or something really
> bad happend.)

Uh, there was nothing at 080f3b5c or nearby, so I'm pretty sure that that
was misttyped as 880f3b5c.  Here are both:



88020f44 <r4k_dma_cache_wback_inv_pc>:
88020f44:	3c028814 	lui	$v0,0x8814
88020f48:	8c425564 	lw	$v0,21860($v0)
88020f4c:	27bdffe0 	addiu	$sp,$sp,-32
88020f50:	afb00010 	sw	$s0,16($sp)
88020f54:	00808021 	move	$s0,$a0
88020f58:	afb10014 	sw	$s1,20($sp)
88020f5c:	00a08821 	move	$s1,$a1
88020f60:	0222102b 	sltu	$v0,$s1,$v0
88020f64:	14400007 	bnez	$v0,88020f84 <r4k_dma_cache_wback_inv_pc+40>
88020f68:	afbf0018 	sw	$ra,24($sp)
88020f6c:	3c028817 	lui	$v0,0x8817
88020f70:	8c42fab4 	lw	$v0,-1356($v0)
88020f74:	0040f809 	jalr	$v0
88020f78:	00000000 	nop
88020f7c:	0a0083f7 	j	88020fdc <r4k_dma_cache_wback_inv_pc+98>
88020f80:	00000000 	nop
88020f84:	40066000 	mfc0	$a2,$12
88020f88:	34c10001 	ori	$at,$a2,0x1
88020f8c:	38210001 	xori	$at,$at,0x1
88020f90:	40816000 	mtc0	$at,$12
88020fa0:	3c02a000 	lui	$v0,0xa000
88020fa4:	3c048814 	lui	$a0,0x8814
88020fa8:	8c84556c 	lw	$a0,21868($a0)
88020fac:	8c420000 	lw	$v0,0($v0)
88020fb0:	02111021 	addu	$v0,$s0,$s1
88020fb4:	00041823 	negu	$v1,$a0
88020fb8:	02032824 	and	$a1,$s0,$v1
88020fbc:	00431024 	and	$v0,$v0,$v1
88020fc0:	bcb50000 	cache	0x15,0($a1)
88020fc4:	14a2fffe 	bne	$a1,$v0,88020fc0 <r4k_dma_cache_wback_inv_pc+7c>
88020fc8:	00a42821 	addu	$a1,$a1,$a0
88020fcc:	40866000 	mtc0	$a2,$12
88020fdc:	3c028813 	lui	$v0,0x8813
88020fe0:	8c423d90 	lw	$v0,15760($v0)
88020fe4:	02002021 	move	$a0,$s0
88020fe8:	8c420008 	lw	$v0,8($v0)
88020fec:	0040f809 	jalr	$v0
88020ff0:	02202821 	move	$a1,$s1
88020ff4:	8fbf0018 	lw	$ra,24($sp)
88020ff8:	8fb10014 	lw	$s1,20($sp)
88020ffc:	8fb00010 	lw	$s0,16($sp)




880f3b00:	afb00018 	sw	$s0,24($sp)
880f3b04:	afa50014 	sw	$a1,20($sp)
880f3b08:	8e620000 	lw	$v0,0($s3)
880f3b0c:	8c52008c 	lw	$s2,140($v0)
880f3b10:	8c550074 	lw	$s5,116($v0)
880f3b14:	ac45007c 	sw	$a1,124($v0)
880f3b18:	9663007e 	lhu	$v1,126($s3)
880f3b1c:	8c57004c 	lw	$s7,76($v0)
880f3b20:	10600027 	beqz	$v1,880f3bc0 <dma_setup+ec>
880f3b24:	245e0070 	addiu	$s8,$v0,112
880f3b28:	00008821 	move	$s1,$zero
880f3b2c:	8e6400ec 	lw	$a0,236($s3)
880f3b30:	2462ffff 	addiu	$v0,$v1,-1
880f3b34:	04400018 	bltz	$v0,880f3b98 <dma_setup+c4>
880f3b38:	0000a021 	move	$s4,$zero
880f3b3c:	3c161fff 	lui	$s6,0x1fff
880f3b40:	36d6ffff 	ori	$s6,$s6,0xffff
880f3b44:	00808021 	move	$s0,$a0
880f3b48:	8e040000 	lw	$a0,0($s0)
880f3b4c:	3c028817 	lui	$v0,0x8817
880f3b50:	8c42fac0 	lw	$v0,-1344($v0)
880f3b54:	0040f809 	jalr	$v0
880f3b58:	24051000 	li	$a1,4096
880f3b5c:	8e020000 	lw	$v0,0($s0)
880f3b60:	00561024 	and	$v0,$v0,$s6
880f3b64:	ae420000 	sw	$v0,0($s2)
880f3b68:	8e020008 	lw	$v0,8($s0)
880f3b6c:	26940001 	addiu	$s4,$s4,1
880f3b70:	30423fff 	andi	$v0,$v0,0x3fff
880f3b74:	ae420004 	sw	$v0,4($s2)
880f3b78:	8e030008 	lw	$v1,8($s0)
880f3b7c:	26100010 	addiu	$s0,$s0,16
880f3b80:	26520010 	addiu	$s2,$s2,16
880f3b84:	9662007e 	lhu	$v0,126($s3)
880f3b88:	2442ffff 	addiu	$v0,$v0,-1
880f3b8c:	0054102a 	slt	$v0,$v0,$s4
880f3b90:	1040ffed 	beqz	$v0,880f3b48 <dma_setup+74>
880f3b94:	02238821 	addu	$s1,$s1,$v1
880f3b98:	24020012 	li	$v0,18
880f3b9c:	afd10020 	sw	$s1,32($s8)

> When did the kernel bomb?  During boot or?  What activity was going on
> at the time when it happend?

This was well after the boot.  The first time it happened, I was
installing a lot of .src.rpms onto sdc while I was compiling on sdc.  The
second time (after e2fsck'ing sda1 (1GB) and scd (3GB), which takes like
30 mins), I was just compiling by building RPMs.

- Alex
