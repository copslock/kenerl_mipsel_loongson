Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Nov 2002 22:41:20 +0100 (CET)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:39722 "EHLO
	brian.localnet") by linux-mips.org with ESMTP id <S1123966AbSKQVlT>;
	Sun, 17 Nov 2002 22:41:19 +0100
Received: from brm by brian.localnet with local (Exim 3.35 #1 (Debian))
	id 18DXAH-0002KJ-00; Sun, 17 Nov 2002 22:41:13 +0100
To: linux-mips@linux-mips.org
Subject: [PATCH 2.4] load average fix for lasat boards (timer interrupt handling fix)
Cc: flo@rfc822.org, ralf@linux-mips.org
Message-Id: <E18DXAH-0002KJ-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sun, 17 Nov 2002 22:41:13 +0100
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Florian, Ralf,
	it seems the method of calling the new time code changed
or it was wrong all along, This patch fixes the problem of the
ksoftirqd running all the time on Lasat systems, can you apply
Ralf?

/Brian
	
Index: arch/mips/lasat/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/setup.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 setup.c
--- arch/mips/lasat/setup.c	6 Oct 2002 11:38:14 -0000	1.1.2.5
+++ arch/mips/lasat/setup.c	17 Nov 2002 21:31:42 -0000
@@ -109,14 +109,10 @@
 	change_cp0_status(ST0_IM, IE_IRQ0 | IE_IRQ5);
 }
 
+#define MIPS_CPU_TIMER_IRQ 7
 asmlinkage void lasat_timer_interrupt(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
-
-	timer_interrupt(7, NULL, regs);
-
-	if (softirq_pending(cpu))
-		do_softirq();
+	ll_timer_interrupt(MIPS_CPU_TIMER_IRQ, regs);
 }
 
 void __init lasat_setup(void)
