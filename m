Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 13:47:28 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5383 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022720AbXEUMr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 13:47:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 536A2E1E26;
	Mon, 21 May 2007 14:47:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B52K8glP49xX; Mon, 21 May 2007 14:47:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EC8ADE1E0F;
	Mon, 21 May 2007 14:47:15 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l4LClPFh010246;
	Mon, 21 May 2007 14:47:25 +0200
Date:	Mon, 21 May 2007 13:47:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] Fix KMODE for the R3000
Message-ID: <Pine.LNX.4.64N.0705211331001.8263@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3273/Mon May 21 07:31:50 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This must be the oldest bug that we have got.  Leaving interrupts "as 
they are" for the R3000 obviously means copying IEp to IEc.  Since we have 
got STATMASK now, I took this opportunity to mask the status register 
"correctly" for the R3000 now too.  Oh, and the R3000 hardly ever is 
64-bit.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 The KMODE change is important, the others -- not so much, but I have 
thought there is not much point in separating these into three patches -- 
they are just too trivial.  Call them "R3000 fixes for <asm/stackframe.h>" 
if you like instead.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-r3000-kmode-2
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/stackframe.h linux-mips-2.6.18-20060920/include/asm-mips/stackframe.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/stackframe.h	2006-06-22 05:11:41.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/stackframe.h	2007-05-21 00:03:57.000000000 +0000
@@ -17,6 +17,18 @@
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
 
+/*
+ * For SMTC kernel, global IE should be left set, and interrupts
+ * controlled exclusively via IXMT.
+ */
+#ifdef CONFIG_MIPS_MT_SMTC
+#define STATMASK 0x1e
+#elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#define STATMASK 0x3f
+#else
+#define STATMASK 0x1f
+#endif
+
 #ifdef CONFIG_MIPS_MT_SMTC
 #include <asm/mipsmtregs.h>
 #endif /* CONFIG_MIPS_MT_SMTC */
@@ -244,10 +256,10 @@
 		.set	reorder
 		.set	noat
 		mfc0	a0, CP0_STATUS
-		ori	a0, 0x1f
-		xori	a0, 0x1f
-		mtc0	a0, CP0_STATUS
 		li	v1, 0xff00
+		ori	a0, STATMASK
+		xori	a0, STATMASK
+		mtc0	a0, CP0_STATUS
 		and	a0, v1
 		LONG_L	v0, PT_STATUS(sp)
 		nor	v1, $0, v1
@@ -257,10 +269,6 @@
 		LONG_L	$31, PT_R31(sp)
 		LONG_L	$28, PT_R28(sp)
 		LONG_L	$25, PT_R25(sp)
-#ifdef CONFIG_64BIT
-		LONG_L	$8, PT_R8(sp)
-		LONG_L	$9, PT_R9(sp)
-#endif
 		LONG_L	$7,  PT_R7(sp)
 		LONG_L	$6,  PT_R6(sp)
 		LONG_L	$5,  PT_R5(sp)
@@ -281,16 +289,6 @@
 		.endm
 
 #else
-/*
- * For SMTC kernel, global IE should be left set, and interrupts
- * controlled exclusively via IXMT.
- */
-
-#ifdef CONFIG_MIPS_MT_SMTC
-#define STATMASK 0x1e
-#else
-#define STATMASK 0x1f
-#endif
 		.macro	RESTORE_SOME
 		.set	push
 		.set	reorder
@@ -393,9 +391,9 @@
 		.macro	CLI
 #if !defined(CONFIG_MIPS_MT_SMTC)
 		mfc0	t0, CP0_STATUS
-		li	t1, ST0_CU0 | 0x1f
+		li	t1, ST0_CU0 | STATMASK
 		or	t0, t1
-		xori	t0, 0x1f
+		xori	t0, STATMASK
 		mtc0	t0, CP0_STATUS
 #else /* CONFIG_MIPS_MT_SMTC */
 		/*
@@ -428,9 +426,9 @@
 		.macro	STI
 #if !defined(CONFIG_MIPS_MT_SMTC)
 		mfc0	t0, CP0_STATUS
-		li	t1, ST0_CU0 | 0x1f
+		li	t1, ST0_CU0 | STATMASK
 		or	t0, t1
-		xori	t0, 0x1e
+		xori	t0, STATMASK & ~1
 		mtc0	t0, CP0_STATUS
 #else /* CONFIG_MIPS_MT_SMTC */
 		/*
@@ -459,7 +457,8 @@
 		.endm
 
 /*
- * Just move to kernel mode and leave interrupts as they are.
+ * Just move to kernel mode and leave interrupts as they are.  Note
+ * for the R3000 this means copying the previous enable from IEp.
  * Set cp0 enable bit as sign that we're running on the kernel stack
  */
 		.macro	KMODE
@@ -490,9 +489,14 @@
 		move	ra, t0
 #endif /* CONFIG_MIPS_MT_SMTC */
 		mfc0	t0, CP0_STATUS
-		li	t1, ST0_CU0 | 0x1e
+		li	t1, ST0_CU0 | (STATMASK & ~1)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+		andi	t2, t0, ST0_IEP
+		srl	t2, 2
+		or	t0, t2
+#endif
 		or	t0, t1
-		xori	t0, 0x1e
+		xori	t0, STATMASK & ~1
 		mtc0	t0, CP0_STATUS
 #ifdef CONFIG_MIPS_MT_SMTC
 		_ehb
