Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA36286 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Apr 1999 10:37:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA05360
	for linux-list;
	Thu, 15 Apr 1999 10:36:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA62554
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Apr 1999 10:36:15 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from aw.ivm.net (mail.ivm.net [195.78.161.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09394
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Apr 1999 10:36:13 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port52.koeln.ivm.de [195.247.239.52])
	by aw.ivm.net (8.8.8/8.8.8) with ESMTP id TAA06665;
	Thu, 15 Apr 1999 19:35:57 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990415193839.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.3.p0.Linux:990415192036:195=_"
Date: Thu, 15 Apr 1999 19:38:39 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: linux-mips@fnet.fr, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: DECstation patches
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This message is in MIME format
--_=XFMail.1.3.p0.Linux:990415192036:195=_
Content-Type: text/plain; charset=us-ascii

Hi Gang,

some of you may have noticed that I started to commit some changes to the
CVS Repository ;-). Well, I did my very best not to break anything and
commited only those changes which are either harmless or wouldn't affect
code for existing machines. My apologies if I *did* break something.

The intention is to prepare a base of discussion for the not so harmless
R3000 specific changes. Therefore I'd like to bring the CVS repository to
a state where it works for R4xx0 based DECstations. There are, however,
two patches left to accomplish that which might have ill side effects on
other machines.

One is relatively boring, consisting mainly of changes to Makefiles and
Config.in to activate the whole stuff. If you are interested it can be
downloaded via

ftp://ftp.linux.sgi.com/pub/linux/mips/test/dec-activate-patch.gz

The second one is more interesting. On the DECstations some interrupts are
directly handled by the CPU, not via some sort of interrupt multiplexer.
With the current implementation of restore(flags) code like:

        save_and_cli(flags);
        enable_irq(irq);
        restore(flags);

simply doesn't work on DECstations. The same is true for the RESTORE_SOME
macro and r4xx0_resume().

My patch leaves the interrupt mask in CP0_STATUS intact in those places.
In theory this should work on all machines but might trigger bugs which
are undiscovered until now.

I'll attach this patch and would appreciate if some you would test it on
as much different MIPS boxes as possible.

Thanks in advance.
---
Regards,
Harald

--_=XFMail.1.3.p0.Linux:990415192036:195=_
Content-Disposition: attachment; filename="r4k-patch"
Content-Transfer-Encoding: 7bit
Content-Description: r4k-patch
Content-Type: text/plain; charset=us-ascii; name=r4k-patch; SizeOnDisk=1918

diff -rubN development/clean/linux/arch/mips/kernel/r4k_switch.S linux/arch/mips
/kernel/r4k_switch.S
--- development/clean/linux/arch/mips/kernel/r4k_switch.S	Tue Sep 22 22:12:47 19
98
+++ linux/arch/mips/kernel/r4k_switch.S	Sun Apr 11 16:16:51 1999
@@ -41,8 +41,14 @@
 	CPU_RESTORE_NONSCRATCH($28)
 	addiu	t0, $28, KERNEL_STACK_SIZE-32
 	sw	t0, kernelsp
-	lw	a3, TASK_MM($28)
+	mfc0	t1, CP0_STATUS		/* Do we really need this? */
+	li	a3, 0xff00
+	and	t1, a3
 	lw	a2, THREAD_STATUS($28)
+	nor	a3, $0, a3
+	and	a2, a3
+	lw	a3, TASK_MM($28)
+	or	a2, t1
 	lw	a3, MM_CONTEXT(a3)
 	mtc0	a2, CP0_STATUS
 	andi	a3, a3, 0xff
diff -rubN development/clean/linux/include/asm-mips/stackframe.h linux/include/a
sm-mips/stackframe.h
--- development/clean/linux/include/asm-mips/stackframe.h	Wed Sep 23 23:05:55 19
98
+++ linux/include/asm-mips/stackframe.h	Sun Apr 11 16:16:52 1999
@@ -139,7 +139,12 @@
 		ori	t0, 0x1f;                        \
 		xori	t0, 0x1f;                        \
 		mtc0	t0, CP0_STATUS;                  \
+		li	v1, 0xff00;                      \
+		and	t0, v1;				 \
 		lw	v0, PT_STATUS(sp);               \
+		nor	v1, $0, v1;			 \
+		and	v0, v1;				 \
+		or	v0, t0;				 \
 		mtc0	v0, CP0_STATUS;                  \
 		lw	v1, PT_EPC(sp);                  \
 		mtc0	v1, CP0_EPC;                     \
diff -rubN development/clean/linux/include/asm-mips/system.h linux/include/asm-m
ips/system.h
--- development/clean/linux/include/asm-mips/system.h	Mon Feb 15 11:51:25 1999
+++ linux/include/asm-mips/system.h	Sun Apr 11 16:16:52 1999
@@ -88,6 +88,12 @@
 {
 	__asm__ __volatile__(
 		".set\tnoreorder\n\t"
+		"mfc0\t$8,$12\n\t"
+		"li\t$9,0xff00\n\t"
+		"and\t$8,$9\n\t"
+		"nor\t$9,$0,$9\n\t"
+		"and\t%0,$9\n\t"
+		"or\t%0,$8\n\t"
 		"mtc0\t%0,$12\n\t"
 		"nop\n\t"
 		"nop\n\t"
@@ -95,7 +101,7 @@
 		".set\treorder"
 		: /* no output */
 		: "r" (flags)
-		: "memory");
+		: "$8", "$9", "memory");
 }
 
 /*


--_=XFMail.1.3.p0.Linux:990415192036:195=_--
End of MIME message
