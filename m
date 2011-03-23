Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:17:51 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47470 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491926Ab1CWVJL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:11 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIf-0001wV-LE; Wed, 23 Mar 2011 22:09:05 +0100
Message-Id: <20110323210536.749955280@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:05 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 23/38] mips: Use generic show_interrupts()
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-use-generic-show-int.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig      |    1 +
 arch/mips/kernel/irq.c |   43 ++-----------------------------------------
 2 files changed, 3 insertions(+), 41 deletions(-)

Index: linux-mips-next/arch/mips/Kconfig
===================================================================
--- linux-mips-next.orig/arch/mips/Kconfig
+++ linux-mips-next/arch/mips/Kconfig
@@ -22,6 +22,7 @@ config MIPS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
 
 menu "Machine selection"
Index: linux-mips-next/arch/mips/kernel/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq.c
+++ linux-mips-next/arch/mips/kernel/irq.c
@@ -81,48 +81,9 @@ void ack_bad_irq(unsigned int irq)
 
 atomic_t irq_err_count;
 
-/*
- * Generic, controller-independent functions:
- */
-
-int show_interrupts(struct seq_file *p, void *v)
+int arch_show_interrupts(struct seq_file *p, int prec)
 {
-	int i = *(loff_t *) v, j;
-	struct irqaction * action;
-	unsigned long flags;
-
-	if (i == 0) {
-		seq_printf(p, "           ");
-		for_each_online_cpu(j)
-			seq_printf(p, "CPU%d       ", j);
-		seq_putc(p, '\n');
-	}
-
-	if (i < NR_IRQS) {
-		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
-		action = irq_desc[i].action;
-		if (!action)
-			goto skip;
-		seq_printf(p, "%3d: ", i);
-#ifndef CONFIG_SMP
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#else
-		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-#endif
-		seq_printf(p, " %14s", irq_desc[i].chip->name);
-		seq_printf(p, "  %s", action->name);
-
-		for (action=action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
-
-		seq_putc(p, '\n');
-skip:
-		raw_spin_unlock_irqrestore(&irq_desc[i].lock, flags);
-	} else if (i == NR_IRQS) {
-		seq_putc(p, '\n');
-		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-	}
+	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
 	return 0;
 }
 
