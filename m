Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 22:53:12 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:35596 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8225240AbTBDWxM>; Tue, 4 Feb 2003 22:53:12 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id C1DB962D6E; Tue,  4 Feb 2003 23:53:08 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18gBxe-0000cc-00; Tue, 04 Feb 2003 23:54:38 +0100
Date: Tue, 4 Feb 2003 23:54:38 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: [PATCH 2.5] clear USEDFPU in copy_thread
Message-ID: <Pine.LNX.4.21.0302042349200.31806-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	When copying a thread, access to the FPU is disabled by clearing
the ST0_CU1 bit in the new thread saved CP0_STATUS register. However, the
corresponding TIF_USEDFPU flag is not cleared at it should to indicate the
FPU has not yet been used by the new process.
	This patch also clears user_tid in mips64 code, and moves it away
from the FPU comment in the mips code.

Vivien.

Index: arch/mips64/kernel/process.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/process.c,v
retrieving revision 1.36
diff -u -r1.36 process.c
--- arch/mips64/kernel/process.c	9 Jan 2003 19:16:50 -0000	1.36
+++ arch/mips64/kernel/process.c	4 Feb 2003 22:47:00 -0000
@@ -114,6 +114,8 @@
 	p->thread.reg29 = (unsigned long) childregs;
 	p->thread.reg31 = (unsigned long) ret_from_fork;
 
+	p->user_tid = NULL;
+
 	/*
 	 * New tasks loose permission to use the fpu. This accelerates context
 	 * switching for most programs since they don't use the fpu.
@@ -121,6 +123,7 @@
 	p->thread.cp0_status = read_c0_status() &
                             ~(ST0_CU3|ST0_CU2|ST0_CU1|ST0_KSU);
 	childregs->cp0_status &= ~(ST0_CU3|ST0_CU2|ST0_CU1);
+	clear_ti_thread_flag(ti, TIF_USEDFPU);
 
 	return 0;
 }
Index: arch/mips/kernel/process.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/process.c,v
retrieving revision 1.50
diff -u -r1.50 process.c
--- arch/mips/kernel/process.c	9 Jan 2003 19:16:50 -0000	1.50
+++ arch/mips/kernel/process.c	4 Feb 2003 22:47:04 -0000
@@ -117,6 +117,8 @@
 	p->thread.reg29 = (unsigned long) childregs;
 	p->thread.reg31 = (unsigned long) ret_from_fork;
 
+	p->user_tid = NULL;
+
 	/*
 	 * New tasks loose permission to use the fpu. This accelerates context
 	 * switching for most programs since they don't use the fpu.
@@ -124,7 +126,7 @@
 	p->thread.cp0_status = read_c0_status() &
                             ~(ST0_CU2|ST0_CU1|KU_MASK);
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
-	p->user_tid = NULL;
+	clear_ti_thread_flag(ti, TIF_USEDFPU);
 
 	return 0;
 }
