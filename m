Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 14:26:59 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:16861 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133380AbWGEN0u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2006 14:26:50 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id CB4504413B; Wed,  5 Jul 2006 15:26:49 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fy7Oo-0008Fe-Fu; Wed, 05 Jul 2006 14:26:38 +0100
Date:	Wed, 5 Jul 2006 14:26:38 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Improve interrupt latency again for sb1250/bcm1480
Message-ID: <20060705132638.GC29112@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch restores the behaviour of the old (assembly-written)
interrupt handler, the handler is left as soon as a single interrupt
cause is handled.


Thiemo


diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 0eb0b10..ed325f0 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -502,22 +502,23 @@ #endif
 #ifdef CONFIG_SIBYTE_BCM1480_PROF
 	if (pending & CAUSEF_IP7)	/* Cpu performance counter interrupt */
 		sbprof_cpu_intr(exception_epc(regs));
+	else
 #endif
 
 	if (pending & CAUSEF_IP4)
 		bcm1480_timer_interrupt(regs);
 
 #ifdef CONFIG_SMP
-	if (pending & CAUSEF_IP3)
+	else if (pending & CAUSEF_IP3)
 		bcm1480_mailbox_interrupt(regs);
 #endif
 
 #ifdef CONFIG_KGDB
-	if (pending & CAUSEF_IP6)
+	else if (pending & CAUSEF_IP6)
 		bcm1480_kgdb_interrupt(regs);		/* KGDB (uart 1) */
 #endif
 
-	if (pending & CAUSEF_IP2) {
+	else if (pending & CAUSEF_IP2) {
 		unsigned long long mask_h, mask_l;
 		unsigned long base;
 
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 8d49cb5..1de71ad 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -460,25 +460,25 @@ #endif
 	pending = read_c0_cause();
 
 #ifdef CONFIG_SIBYTE_SB1250_PROF
-	if (pending & CAUSEF_IP7) { /* Cpu performance counter interrupt */
+	if (pending & CAUSEF_IP7) /* Cpu performance counter interrupt */
 		sbprof_cpu_intr(exception_epc(regs));
-	}
+	else
 #endif
 
 	if (pending & CAUSEF_IP4)
 		sb1250_timer_interrupt(regs);
 
 #ifdef CONFIG_SMP
-	if (pending & CAUSEF_IP3)
+	else if (pending & CAUSEF_IP3)
 		sb1250_mailbox_interrupt(regs);
 #endif
 
 #ifdef CONFIG_KGDB
-	if (pending & CAUSEF_IP6)			/* KGDB (uart 1) */
+	else if (pending & CAUSEF_IP6)			/* KGDB (uart 1) */
 		sb1250_kgdb_interrupt(regs);
 #endif
 
-	if (pending & CAUSEF_IP2) {
+	else if (pending & CAUSEF_IP2) {
 		unsigned long long mask;
 
 		/*
