Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA01631 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 13:03:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA37851
	for linux-list;
	Wed, 19 Aug 1998 13:03:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA69357
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 13:03:13 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.169.102]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA15914
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 13:03:10 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: (from grim@localhost)
	by calypso.saturn (8.9.1/8.9.1/Debian/GNU) id WAA13671
	for linux@cthulhu.engr.sgi.com; Wed, 19 Aug 1998 22:03:06 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
Message-Id: <199808192003.WAA13671@calypso.saturn>
Subject: [PATCH] sc
To: linux@cthulhu.engr.sgi.com
Date: Wed, 19 Aug 1998 22:03:05 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM903556985-13659-0_
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--ELM903556985-13659-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Here's the patch for SC, still some BUS Errors when using the network device
(bootp doesn't work), sometimes even without obvious reason.

- Ulf

--ELM903556985-13659-0_
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: attachment; filename=sc-patch.diff
Content-Description: /home/grim/sc-patch.diff
Content-Transfer-Encoding: 7bit

--- head.S	Thu Jul  9 19:51:48 1998
+++ sgi-lin/linux/arch/mips/kernel/head.S	Tue Aug 18 22:34:35 1998
@@ -5,6 +5,7 @@
  *  Copyright (C) 1996, 1997, 1998 Ralf Baechle
  *  Modified for DECStation and hence R3000 support by Paul M. Antoine
  *  Further modifications by David S. Miller
+ *  Modified for R4000SC/R44000SC support by Ulf Carlsson
  *
  *  Head.S contains the MIPS exception handler and startup code.
  */
@@ -22,6 +23,7 @@
 #include <asm/stackframe.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/cacheops.h>
 
 	.text
 	/*
@@ -315,16 +317,46 @@
 	NESTED(except_vec3_r4000, 0, sp)
 	.set	noat
 	mfc0	k1, CP0_CAUSE
-
-	/* XXX Have to check for VCE's _before_ we do a load or store. */
-
-	la	k0, exception_handlers
 	andi	k1, k1, 0x7c
+	li	k0, 31<<2
+	beq	k1, k0, handle_vced
+	 li	k0, 14<<2
+	beq	k1, k0, handle_vcei
+	 la	k0, exception_handlers
 	addu	k0, k0, k1
 	lw	k0, (k0)
 	nop
 	jr	k0
 	 nop
+
+/*
+ * Big shit, we now may have two dirty primary cache lines for the same
+ * physical address.  We can savely invalidate the line pointed to by
+ * c0_badvaddr because after return from this exception handler the load /
+ * store will be re-executed.
+ *
+ * XXX should bitch on console.
+ */
+handle_vced:
+	mfc0	k0, CP0_BADVADDR
+	mtc0	zero, CP0_TAGLO
+	nop;nop
+	cache	Index_Store_Tag_D,(k0)
+	nop;nop
+	cache	Hit_Writeback_Inv_SD,(k0)
+	eret
+
+/*
+ * VCEI is simpler and should never happen unless userland is doing something
+ * really stupid.  It's actually worth a SIGFRY.
+ *
+ * XXX should bitch on console.
+ */
+handle_vcei:
+	mfc0	k0, CP0_BADVADDR
+	cache	Hit_Invalidate_SD,(k0)		# also cleans pi
+	eret
+
 	END(except_vec3_r4000)
 	.set	at
 

--ELM903556985-13659-0_--
