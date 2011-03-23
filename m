Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:15:56 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491920Ab1CWVJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:07 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIb-0001wG-M1; Wed, 23 Mar 2011 22:09:02 +0100
Message-Id: <20110323210536.282531266@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:01 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 18/38] mips: rm9000: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-rm9000.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq-rm9000.c |   49 +++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq-rm9000.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq-rm9000.c
+++ linux-mips-next/arch/mips/kernel/irq-rm9000.c
@@ -19,22 +19,22 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
-static inline void unmask_rm9k_irq(unsigned int irq)
+static inline void unmask_rm9k_irq(struct irq_data *d)
 {
-	set_c0_intcontrol(0x1000 << (irq - RM9K_CPU_IRQ_BASE));
+	set_c0_intcontrol(0x1000 << (d->irq - RM9K_CPU_IRQ_BASE));
 }
 
-static inline void mask_rm9k_irq(unsigned int irq)
+static inline void mask_rm9k_irq(struct irq_data *d)
 {
-	clear_c0_intcontrol(0x1000 << (irq - RM9K_CPU_IRQ_BASE));
+	clear_c0_intcontrol(0x1000 << (d->irq - RM9K_CPU_IRQ_BASE));
 }
 
-static inline void rm9k_cpu_irq_enable(unsigned int irq)
+static inline void rm9k_cpu_irq_enable(struct irq_data *d)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	unmask_rm9k_irq(irq);
+	unmask_rm9k_irq(d);
 	local_irq_restore(flags);
 }
 
@@ -43,50 +43,47 @@ static inline void rm9k_cpu_irq_enable(u
  */
 static void local_rm9k_perfcounter_irq_startup(void *args)
 {
-	unsigned int irq = (unsigned int) args;
-
-	rm9k_cpu_irq_enable(irq);
+	rm9k_cpu_irq_enable(args);
 }
 
-static unsigned int rm9k_perfcounter_irq_startup(unsigned int irq)
+static unsigned int rm9k_perfcounter_irq_startup(struct irq_data *d)
 {
-	on_each_cpu(local_rm9k_perfcounter_irq_startup, (void *) irq, 1);
+	on_each_cpu(local_rm9k_perfcounter_irq_startup, d, 1);
 
 	return 0;
 }
 
 static void local_rm9k_perfcounter_irq_shutdown(void *args)
 {
-	unsigned int irq = (unsigned int) args;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	mask_rm9k_irq(irq);
+	mask_rm9k_irq(args);
 	local_irq_restore(flags);
 }
 
-static void rm9k_perfcounter_irq_shutdown(unsigned int irq)
+static void rm9k_perfcounter_irq_shutdown(struct irq_data *d)
 {
-	on_each_cpu(local_rm9k_perfcounter_irq_shutdown, (void *) irq, 1);
+	on_each_cpu(local_rm9k_perfcounter_irq_shutdown, d, 1);
 }
 
 static struct irq_chip rm9k_irq_controller = {
 	.name = "RM9000",
-	.ack = mask_rm9k_irq,
-	.mask = mask_rm9k_irq,
-	.mask_ack = mask_rm9k_irq,
-	.unmask = unmask_rm9k_irq,
-	.eoi	= unmask_rm9k_irq
+	.irq_ack = mask_rm9k_irq,
+	.irq_mask = mask_rm9k_irq,
+	.irq_mask_ack = mask_rm9k_irq,
+	.irq_unmask = unmask_rm9k_irq,
+	.irq_eoi = unmask_rm9k_irq
 };
 
 static struct irq_chip rm9k_perfcounter_irq = {
 	.name = "RM9000",
-	.startup = rm9k_perfcounter_irq_startup,
-	.shutdown = rm9k_perfcounter_irq_shutdown,
-	.ack = mask_rm9k_irq,
-	.mask = mask_rm9k_irq,
-	.mask_ack = mask_rm9k_irq,
-	.unmask = unmask_rm9k_irq,
+	.irq_startup = rm9k_perfcounter_irq_startup,
+	.irq_shutdown = rm9k_perfcounter_irq_shutdown,
+	.irq_ack = mask_rm9k_irq,
+	.irq_mask = mask_rm9k_irq,
+	.irq_mask_ack = mask_rm9k_irq,
+	.irq_unmask = unmask_rm9k_irq,
 };
 
 unsigned int rm9000_perfcount_irq;
