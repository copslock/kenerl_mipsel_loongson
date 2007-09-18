Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 18:49:23 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:36311 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023717AbXIRRtP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 18:49:15 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 66E2740097;
	Tue, 18 Sep 2007 19:49:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Z+RixE7oFYXz; Tue, 18 Sep 2007 19:49:09 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1C48B40070;
	Tue, 18 Sep 2007 19:49:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8IHnDm8014376;
	Tue, 18 Sep 2007 19:49:13 +0200
Date:	Tue, 18 Sep 2007 18:49:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] kernel/process.c: R3000 setup for kernel_thread()
Message-ID: <Pine.LNX.4.64N.0709181834420.18665@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4321/Tue Sep 18 15:29:56 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Match the R4000 semantics for the initial state of interrupt/kernel
status register flags for the R3000 in kernel_thread().

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 The R4000 variation preserves the interrupt/kernel status flags; the 
R3000 assumes a certain state.  It may not matter, at least at the current 
state of the code, but for consistency I think the R3000 variation should 
do the same as the R4000 one, first for purity and second because there is 
less maintenance force available for the R3000 and any discrepancy between 
the two variations means a greater chance for subtle bugs.  The 
performance hit is negligible.

 Tested at the runtime.

 Please consider.

  Maciej

patch-mips-2.6.23-rc5-20070904-r3000-process-1
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/process.c linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/process.c
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/process.c	2007-09-04 04:55:19.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/process.c	2007-09-18 15:43:16.000000000 +0000
@@ -231,8 +231,8 @@ long kernel_thread(int (*fn)(void *), vo
 	regs.cp0_epc = (unsigned long) kernel_thread_helper;
 	regs.cp0_status = read_c0_status();
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
-	regs.cp0_status &= ~(ST0_KUP | ST0_IEC);
-	regs.cp0_status |= ST0_IEP;
+	regs.cp0_status = (regs.cp0_status & ~(ST0_KUP | ST0_IEP | ST0_IEC)) |
+			  ((regs.cp0_status & (ST0_KUC | ST0_IEC)) << 2);
 #else
 	regs.cp0_status |= ST0_EXL;
 #endif
