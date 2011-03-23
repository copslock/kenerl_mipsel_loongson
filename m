Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:14:03 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491911Ab1CWVJD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:03 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIX-0001vu-JW; Wed, 23 Mar 2011 22:08:58 +0100
Message-Id: <20110323210535.810236940@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:57 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 13/38] mips: i8259: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-8259.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/include/asm/irq.h      |    4 ++--
 arch/mips/kernel/i8259.c         |   37 +++++++++++++++++--------------------
 arch/mips/mti-malta/malta-smtc.c |    9 +++++----
 3 files changed, 24 insertions(+), 26 deletions(-)

Index: linux-mips-next/arch/mips/include/asm/irq.h
===================================================================
--- linux-mips-next.orig/arch/mips/include/asm/irq.h
+++ linux-mips-next/arch/mips/include/asm/irq.h
@@ -55,8 +55,8 @@ static inline void smtc_im_ack_irq(unsig
 #ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
 #include <linux/cpumask.h>
 
-extern int plat_set_irq_affinity(unsigned int irq,
-				  const struct cpumask *affinity);
+extern int plat_set_irq_affinity(struct irq_data *d,
+				 const struct cpumask *affinity, bool force);
 extern void smtc_forward_irq(unsigned int irq);
 
 /*
Index: linux-mips-next/arch/mips/kernel/i8259.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/i8259.c
+++ linux-mips-next/arch/mips/kernel/i8259.c
@@ -31,19 +31,19 @@
 
 static int i8259A_auto_eoi = -1;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
-static void disable_8259A_irq(unsigned int irq);
-static void enable_8259A_irq(unsigned int irq);
-static void mask_and_ack_8259A(unsigned int irq);
+static void disable_8259A_irq(struct irq_data *d);
+static void enable_8259A_irq(struct irq_data *d);
+static void mask_and_ack_8259A(struct irq_data *d);
 static void init_8259A(int auto_eoi);
 
 static struct irq_chip i8259A_chip = {
-	.name		= "XT-PIC",
-	.mask		= disable_8259A_irq,
-	.disable	= disable_8259A_irq,
-	.unmask		= enable_8259A_irq,
-	.mask_ack	= mask_and_ack_8259A,
+	.name			= "XT-PIC",
+	.irq_mask		= disable_8259A_irq,
+	.irq_disable		= disable_8259A_irq,
+	.irq_unmask		= enable_8259A_irq,
+	.irq_mask_ack		= mask_and_ack_8259A,
 #ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
-	.set_affinity	= plat_set_irq_affinity,
+	.irq_set_affinity	= plat_set_irq_affinity,
 #endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
 };
 
@@ -59,12 +59,11 @@ static unsigned int cached_irq_mask = 0x
 #define cached_master_mask	(cached_irq_mask)
 #define cached_slave_mask	(cached_irq_mask >> 8)
 
-static void disable_8259A_irq(unsigned int irq)
+static void disable_8259A_irq(struct irq_data *d)
 {
-	unsigned int mask;
+	unsigned int mask, irq = d->irq - I8259A_IRQ_BASE;
 	unsigned long flags;
 
-	irq -= I8259A_IRQ_BASE;
 	mask = 1 << irq;
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask |= mask;
@@ -75,12 +74,11 @@ static void disable_8259A_irq(unsigned i
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
-static void enable_8259A_irq(unsigned int irq)
+static void enable_8259A_irq(struct irq_data *d)
 {
-	unsigned int mask;
+	unsigned int mask, irq = d->irq - I8259A_IRQ_BASE;
 	unsigned long flags;
 
-	irq -= I8259A_IRQ_BASE;
 	mask = ~(1 << irq);
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask &= mask;
@@ -145,12 +143,11 @@ static inline int i8259A_irq_real(unsign
  * first, _then_ send the EOI, and the order of EOI
  * to the two 8259s is important!
  */
-static void mask_and_ack_8259A(unsigned int irq)
+static void mask_and_ack_8259A(struct irq_data *d)
 {
-	unsigned int irqmask;
+	unsigned int irqmask, irq = d->irq - I8259A_IRQ_BASE;
 	unsigned long flags;
 
-	irq -= I8259A_IRQ_BASE;
 	irqmask = 1 << irq;
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 	/*
@@ -290,9 +287,9 @@ static void init_8259A(int auto_eoi)
 		 * In AEOI mode we just have to mask the interrupt
 		 * when acking.
 		 */
-		i8259A_chip.mask_ack = disable_8259A_irq;
+		i8259A_chip.irq_mask_ack = disable_8259A_irq;
 	else
-		i8259A_chip.mask_ack = mask_and_ack_8259A;
+		i8259A_chip.irq_mask_ack = mask_and_ack_8259A;
 
 	udelay(100);		/* wait for 8259A to initialize */
 
Index: linux-mips-next/arch/mips/mti-malta/malta-smtc.c
===================================================================
--- linux-mips-next.orig/arch/mips/mti-malta/malta-smtc.c
+++ linux-mips-next/arch/mips/mti-malta/malta-smtc.c
@@ -113,7 +113,8 @@ struct plat_smp_ops msmtc_smp_ops = {
  */
 
 
-int plat_set_irq_affinity(unsigned int irq, const struct cpumask *affinity)
+int plat_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity,
+			  bool force)
 {
 	cpumask_t tmask;
 	int cpu = 0;
@@ -143,7 +144,7 @@ int plat_set_irq_affinity(unsigned int i
 		if ((cpu_data[cpu].vpe_id != 0) || !cpu_online(cpu))
 			cpu_clear(cpu, tmask);
 	}
-	cpumask_copy(irq_desc[irq].affinity, &tmask);
+	cpumask_copy(d->affinity, &tmask);
 
 	if (cpus_empty(tmask))
 		/*
@@ -154,8 +155,8 @@ int plat_set_irq_affinity(unsigned int i
 			"IRQ affinity leaves no legal CPU for IRQ %d\n", irq);
 
 	/* Do any generic SMTC IRQ affinity setup */
-	smtc_set_irq_affinity(irq, tmask);
+	smtc_set_irq_affinity(d->irq, tmask);
 
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 #endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
