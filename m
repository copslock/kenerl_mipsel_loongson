Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 22:20:31 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:37894 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8224939AbTBCWUb>; Mon, 3 Feb 2003 22:20:31 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 646B762D06; Mon,  3 Feb 2003 23:20:26 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18foyM-0006cc-00; Mon, 03 Feb 2003 23:21:50 +0100
Date: Mon, 3 Feb 2003 23:21:50 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: [PATCH 2.5] r4k_switch task_struct/thread_info fixes
Message-ID: <Pine.LNX.4.21.0302032311160.25421-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	This patch fixes an incorrect use of THREAD_FLAGS instead of
TI_FLAGS when clearing the TIF_USEDFPU flag of the current thread info,
and an incorrect assumption when using ST_OFF, that the stack is shared
with task_struct, whereas it is shared with thread_info in 2.5.

Vivien.

Index: arch/mips64/kernel/r4k_switch.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/r4k_switch.S,v
retrieving revision 1.22
diff -u -r1.22 r4k_switch.S
--- arch/mips64/kernel/r4k_switch.S	5 Nov 2002 19:51:47 -0000	1.22
+++ arch/mips64/kernel/r4k_switch.S	3 Feb 2003 22:05:26 -0000
@@ -24,6 +24,10 @@
 
 	.set	mips3
 
+/* 
+ * Offset to the current process status flags, the first 32 bytes of the
+ * stack are not used.
+ */
 #define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
 
 /*
@@ -58,15 +62,15 @@
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
-	sd	t0, TASK_FLAGS(t3)
+	sd	t0, TI_FLAGS(t3)
 
 	/*
 	 * clear saved user stack CU1 bit
 	 */
-	ld	t0, ST_OFF(a0)
+	ld	t0, ST_OFF(t3)
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
-	sd	t0, ST_OFF(a0)
+	sd	t0, ST_OFF(t3)
 
 	
 	sll	t2, t0, 5
Index: arch/mips/kernel/r4k_switch.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/r4k_switch.S,v
retrieving revision 1.29
diff -u -r1.29 r4k_switch.S
--- arch/mips/kernel/r4k_switch.S	5 Nov 2002 19:51:47 -0000	1.29
+++ arch/mips/kernel/r4k_switch.S	3 Feb 2003 22:06:17 -0000
@@ -67,10 +67,10 @@
 	/*
 	 * clear saved user stack CU1 bit
 	 */
-	lw	t0, ST_OFF(a0)
+	lw	t0, ST_OFF(t3)
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
-	sw	t0, ST_OFF(a0)
+	sw	t0, ST_OFF(t3)
 
 	FPU_SAVE_DOUBLE(a0, t0)			# clobbers t0
 
