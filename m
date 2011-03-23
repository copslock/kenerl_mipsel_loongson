Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:14:26 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491913Ab1CWVJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:04 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIY-0001vx-Ii; Wed, 23 Mar 2011 22:08:58 +0100
Message-Id: <20110323210535.903372061@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:58 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 14/38] mips: gic: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-gic.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq-gic.c |   44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq-gic.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq-gic.c
+++ linux-mips-next/arch/mips/kernel/irq-gic.c
@@ -87,17 +87,9 @@ unsigned int gic_get_int(void)
 	return i;
 }
 
-static unsigned int gic_irq_startup(unsigned int irq)
+static void gic_irq_ack(struct irq_data *d)
 {
-	irq -= _irqbase;
-	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
-	GIC_SET_INTR_MASK(irq);
-	return 0;
-}
-
-static void gic_irq_ack(unsigned int irq)
-{
-	irq -= _irqbase;
+	unsigned int irq = d->irq - _irqbase;
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	GIC_CLR_INTR_MASK(irq);
 
@@ -105,16 +97,16 @@ static void gic_irq_ack(unsigned int irq
 		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
 }
 
-static void gic_mask_irq(unsigned int irq)
+static void gic_mask_irq(struct irq_data *d)
 {
-	irq -= _irqbase;
+	unsigned int irq = d->irq - _irqbase;
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	GIC_CLR_INTR_MASK(irq);
 }
 
-static void gic_unmask_irq(unsigned int irq)
+static void gic_unmask_irq(struct irq_data *d)
 {
-	irq -= _irqbase;
+	unsigned int irq = d->irq - _irqbase;
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	GIC_SET_INTR_MASK(irq);
 }
@@ -123,13 +115,14 @@ static void gic_unmask_irq(unsigned int 
 
 static DEFINE_SPINLOCK(gic_lock);
 
-static int gic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
+			    bool force)
 {
+	unsigned int irq = d->irq - _irqbase;
 	cpumask_t	tmp = CPU_MASK_NONE;
 	unsigned long	flags;
 	int		i;
 
-	irq -= _irqbase;
 	pr_debug("%s(%d) called\n", __func__, irq);
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
@@ -147,23 +140,22 @@ static int gic_set_affinity(unsigned int
 		set_bit(irq, pcpu_masks[first_cpu(tmp)].pcpu_mask);
 
 	}
-	cpumask_copy(irq_desc[irq].affinity, cpumask);
+	cpumask_copy(d->affinity, cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 #endif
 
 static struct irq_chip gic_irq_controller = {
-	.name		=	"MIPS GIC",
-	.startup	=	gic_irq_startup,
-	.ack		=	gic_irq_ack,
-	.mask		=	gic_mask_irq,
-	.mask_ack	=	gic_mask_irq,
-	.unmask		=	gic_unmask_irq,
-	.eoi		=	gic_unmask_irq,
+	.name			=	"MIPS GIC",
+	.irq_ack		=	gic_irq_ack,
+	.irq_mask		=	gic_mask_irq,
+	.irq_mask_ack		=	gic_mask_irq,
+	.irq_unmask		=	gic_unmask_irq,
+	.irq_eoi		=	gic_unmask_irq,
 #ifdef CONFIG_SMP
-	.set_affinity	=	gic_set_affinity,
+	.irq_set_affinity	=	gic_set_affinity,
 #endif
 };
 
