Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA68714 for <linux-archive@neteng.engr.sgi.com>; Fri, 2 Apr 1999 13:56:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA44128
	for linux-list;
	Fri, 2 Apr 1999 13:54:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA12817
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 2 Apr 1999 13:54:46 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup85-9-3.swipnet.se [130.244.85.131]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA27540
	for <linux@cthulhu.engr.sgi.com>; Fri, 2 Apr 1999 13:54:24 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id WAA20097
	for linux@cthulhu.engr.sgi.com; Fri, 2 Apr 1999 22:33:18 -0500
Date: Fri, 2 Apr 1999 22:33:17 -0500
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: ALSA compile error
Message-ID: <19990402223303.A20067@bun.falkenberg.se>
Mail-Followup-To: linux-sgi@bun.falkenberg.se
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I've written an ALSA driver for the HAL2 today, programming ALSA was a very nice
experience. Anyhow, to compile ALSA wasn't as nice as writing a driver. The
problem is that I can't compile it (even without my driver).

Maybe I should learn how to fix gcc and as on my own.. *sigh*

I've been trying with egcs 1.0.2, gcc 2.7.2, binutils 2.8.1 and binutils 2.9.1
and it doesn't make any difference. I've also been trying without -pipe and
-fomit-frame-pointer.

This is the error message:

gcc -O2  -DLINUX -mips2 -mcpu=r4600 -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -I/usr/src/linux/include -I../include -c -o sound.o sound.c
/tmp/cca03757.s: Assembler messages:
/tmp/cca03757.s:1228: Error: Can not represent BFD_RELOC_16_PCREL_S2 relocation in this object file format
/tmp/cca03757.s:1285: Error: Can not represent BFD_RELOC_16_PCREL_S2 relocation in this object file format

I think I've had this error message before when I was compiling the kernel. That
was about half a year ago so I don't remember exactly how I fixed it that time.
It was something about the haifa scheduler I think.

	[snip]

	.set	macro
	.set	reorder

 #APP
	1:	lw	$4,0($5)
	move	$2,$0
2:
	.section	.fixup,"ax"
3:	li	$2,-14
	move	$4,$0
	j	2b			<---- line 1228
	.previous
	.section	__ex_table,"a"
	.word	1b,3b
	.previous
 #NO_APP
	move	$2,$4
$L977:
	lw	$31,28($sp)
	addu	$sp,$sp,32
	j	$31
	.end	snd_ioctl_in_R1cd575d7

	[snap]

	[snip]

	bltz	$3,$L991
	move	$2,$0
	.set	macro
	.set	reorder

 #APP
	1:	sw	$5,0($4)
	move	$2,$0
2:
	.section	.fixup,"ax"
3:	li	$2,-14
	j	2b			<---- line 1285
	.previous
	.section	__ex_table,"a"
	.word	1b,3b
	.previous
 #NO_APP

 	[snap]

- Ulf
