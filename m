Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:18:38 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47476 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491880Ab1CWVJN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:13 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIh-0001wb-33; Wed, 23 Mar 2011 22:09:07 +0100
Message-Id: <20110323210536.937910772@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:06 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 25/38] mips: pmc-sierra: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=misp-pmc.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c |   41 +++++---------
 arch/mips/pmc-sierra/msp71xx/msp_irq_per.c |   80 ++++++-----------------------
 arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c |   18 ++++--
 3 files changed, 46 insertions(+), 93 deletions(-)

Index: linux-mips-next/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
===================================================================
--- linux-mips-next.orig/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
+++ linux-mips-next/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
@@ -77,7 +77,7 @@ static inline void cic_wmb(void)
 	dummy_read++;
 }
 
-static inline void unmask_cic_irq(unsigned int irq)
+static void unmask_cic_irq(struct irq_data *d)
 {
 	volatile u32   *cic_msk_reg = CIC_VPE0_MSK_REG;
 	int vpe;
@@ -89,18 +89,18 @@ static inline void unmask_cic_irq(unsign
 	* Make sure we have IRQ affinity.  It may have changed while
 	* we were processing the IRQ.
 	*/
-	if (!cpumask_test_cpu(smp_processor_id(), irq_desc[irq].affinity))
+	if (!cpumask_test_cpu(smp_processor_id(), d->affinity))
 		return;
 #endif
 
 	vpe = get_current_vpe();
 	LOCK_VPE(flags, mtflags);
-	cic_msk_reg[vpe] |= (1 << (irq - MSP_CIC_INTBASE));
+	cic_msk_reg[vpe] |= (1 << (d->irq - MSP_CIC_INTBASE));
 	UNLOCK_VPE(flags, mtflags);
 	cic_wmb();
 }
 
-static inline void mask_cic_irq(unsigned int irq)
+static void mask_cic_irq(struct irq_data *d)
 {
 	volatile u32 *cic_msk_reg = CIC_VPE0_MSK_REG;
 	int	vpe = get_current_vpe();
@@ -108,33 +108,27 @@ static inline void mask_cic_irq(unsigned
 	unsigned long flags, mtflags;
 #endif
 	LOCK_VPE(flags, mtflags);
-	cic_msk_reg[vpe] &= ~(1 << (irq - MSP_CIC_INTBASE));
+	cic_msk_reg[vpe] &= ~(1 << (d->irq - MSP_CIC_INTBASE));
 	UNLOCK_VPE(flags, mtflags);
 	cic_wmb();
 }
-static inline void msp_cic_irq_ack(unsigned int irq)
+static void msp_cic_irq_ack(struct irq_data *d)
 {
-	mask_cic_irq(irq);
+	mask_cic_irq(d);
 	/*
 	* Only really necessary for 18, 16-14 and sometimes 3:0
 	* (since these can be edge sensitive) but it doesn't
 	* hurt for the others
 	*/
-	*CIC_STS_REG = (1 << (irq - MSP_CIC_INTBASE));
-	smtc_im_ack_irq(irq);
-}
-
-static void msp_cic_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_cic_irq(irq);
+	*CIC_STS_REG = (1 << (d->irq - MSP_CIC_INTBASE));
+	smtc_im_ack_irq(d->irq);
 }
 
 /*Note: Limiting to VSMP . Not tested in SMTC */
 
 #ifdef CONFIG_MIPS_MT_SMP
-static inline int msp_cic_irq_set_affinity(unsigned int irq,
-					const struct cpumask *cpumask)
+static int msp_cic_irq_set_affinity(struct irq_data *d,
+				    const struct cpumask *cpumask, bool force)
 {
 	int cpu;
 	unsigned long flags;
@@ -163,13 +157,12 @@ static inline int msp_cic_irq_set_affini
 
 static struct irq_chip msp_cic_irq_controller = {
 	.name = "MSP_CIC",
-	.mask = mask_cic_irq,
-	.mask_ack = msp_cic_irq_ack,
-	.unmask = unmask_cic_irq,
-	.ack = msp_cic_irq_ack,
-	.end = msp_cic_irq_end,
+	.irq_mask = mask_cic_irq,
+	.irq_mask_ack = msp_cic_irq_ack,
+	.irq_unmask = unmask_cic_irq,
+	.irq_ack = msp_cic_irq_ack,
 #ifdef CONFIG_MIPS_MT_SMP
-	.set_affinity = msp_cic_irq_set_affinity,
+	.irq_set_affinity = msp_cic_irq_set_affinity,
 #endif
 };
 
@@ -220,7 +213,5 @@ void msp_cic_irq_dispatch(void)
 		do_IRQ(ffs(pending) + MSP_CIC_INTBASE - 1);
 	} else{
 		spurious_interrupt();
-		/* Re-enable the CIC cascaded interrupt. */
-		irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
 	}
 }
Index: linux-mips-next/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
===================================================================
--- linux-mips-next.orig/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
+++ linux-mips-next/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
@@ -48,100 +48,61 @@ static inline void per_wmb(void)
 	dummy_read++;
 }
 
-static inline void unmask_per_irq(unsigned int irq)
+static inline void unmask_per_irq(struct irq_data *d)
 {
 #ifdef CONFIG_SMP
 	unsigned long flags;
 	spin_lock_irqsave(&per_lock, flags);
-	*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+	*PER_INT_MSK_REG |= (1 << (d->irq - MSP_PER_INTBASE));
 	spin_unlock_irqrestore(&per_lock, flags);
 #else
-	*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+	*PER_INT_MSK_REG |= (1 << (d->irq - MSP_PER_INTBASE));
 #endif
 	per_wmb();
 }
 
-static inline void mask_per_irq(unsigned int irq)
+static inline void mask_per_irq(struct irq_data *d)
 {
 #ifdef CONFIG_SMP
 	unsigned long flags;
 	spin_lock_irqsave(&per_lock, flags);
-	*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+	*PER_INT_MSK_REG &= ~(1 << (d->irq - MSP_PER_INTBASE));
 	spin_unlock_irqrestore(&per_lock, flags);
 #else
-	*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+	*PER_INT_MSK_REG &= ~(1 << (d->irq - MSP_PER_INTBASE));
 #endif
 	per_wmb();
 }
 
-static inline void msp_per_irq_enable(unsigned int irq)
+static inline void msp_per_irq_ack(struct irq_data *d)
 {
-	unmask_per_irq(irq);
-}
-
-static inline void msp_per_irq_disable(unsigned int irq)
-{
-	 mask_per_irq(irq);
-}
-
-static unsigned int msp_per_irq_startup(unsigned int irq)
-{
-	msp_per_irq_enable(irq);
-	return 0;
-}
-
-#define    msp_per_irq_shutdown    msp_per_irq_disable
-
-static inline void msp_per_irq_ack(unsigned int irq)
-{
-	mask_per_irq(irq);
+	mask_per_irq(d);
 	/*
 	 * In the PER interrupt controller, only bits 11 and 10
 	 * are write-to-clear, (SPI TX complete, SPI RX complete).
 	 * It does nothing for any others.
 	 */
-
-	*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
-
-	/* Re-enable the CIC cascaded interrupt and return */
-	irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
-}
-
-static void msp_per_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_per_irq(irq);
+	*PER_INT_STS_REG = (1 << (d->irq - MSP_PER_INTBASE));
 }
 
 #ifdef CONFIG_SMP
-static inline int msp_per_irq_set_affinity(unsigned int irq,
-				const struct cpumask *affinity)
+static int msp_per_irq_set_affinity(struct irq_data *d,
+				    const struct cpumask *affinity, bool force)
 {
-	unsigned long flags;
-	/*
-	 * Calls to ack, end, startup, enable are spinlocked in setup_irq and
-	 * __do_IRQ.Callers of this function do not spinlock,so we need to
-	 * do so ourselves.
-	 */
-	raw_spin_lock_irqsave(&irq_desc[irq].lock, flags);
-	msp_per_irq_enable(irq);
-	raw_spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
+	/* WTF is this doing ????? */
+	unmask_per_irq(d);
 	return 0;
-
 }
 #endif
 
 static struct irq_chip msp_per_irq_controller = {
 	.name = "MSP_PER",
-	.startup = msp_per_irq_startup,
-	.shutdown = msp_per_irq_shutdown,
-	.enable = msp_per_irq_enable,
-	.disable = msp_per_irq_disable,
+	.irq_enable = unmask_per_irq.
+	.irq_disable = mask_per_irq,
+	.irq_ack = msp_per_irq_ack,
 #ifdef CONFIG_SMP
-	.set_affinity = msp_per_irq_set_affinity,
+	.irq_set_affinity = msp_per_irq_set_affinity,
 #endif
-	.ack = msp_per_irq_ack,
-	.end = msp_per_irq_end,
 };
 
 void __init msp_per_irq_init(void)
@@ -152,10 +113,7 @@ void __init msp_per_irq_init(void)
 	*PER_INT_STS_REG  = 0xFFFFFFFF;
 	/* initialize all the IRQ descriptors */
 	for (i = MSP_PER_INTBASE; i < MSP_PER_INTBASE + 32; i++) {
-		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = NULL;
-		irq_desc[i].depth = 1;
-		irq_desc[i].chip = &msp_per_irq_controller;
+		irq_set_chip(i, &msp_per_irq_controller);
 #ifdef CONFIG_MIPS_MT_SMTC
 		irq_hwmask[i] = C_IRQ4;
 #endif
@@ -173,7 +131,5 @@ void msp_per_irq_dispatch(void)
 		do_IRQ(ffs(pending) + MSP_PER_INTBASE - 1);
 	} else {
 		spurious_interrupt();
-	/* Re-enable the CIC cascaded interrupt and return */
-	irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
 	}
 }
Index: linux-mips-next/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
===================================================================
--- linux-mips-next.orig/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
+++ linux-mips-next/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
@@ -21,8 +21,10 @@
 #include <msp_slp_int.h>
 #include <msp_regs.h>
 
-static inline void unmask_msp_slp_irq(unsigned int irq)
+static inline void unmask_msp_slp_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	/* check for PER interrupt range */
 	if (irq < MSP_PER_INTBASE)
 		*SLP_INT_MSK_REG |= (1 << (irq - MSP_SLP_INTBASE));
@@ -30,8 +32,10 @@ static inline void unmask_msp_slp_irq(un
 		*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
 }
 
-static inline void mask_msp_slp_irq(unsigned int irq)
+static inline void mask_msp_slp_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	/* check for PER interrupt range */
 	if (irq < MSP_PER_INTBASE)
 		*SLP_INT_MSK_REG &= ~(1 << (irq - MSP_SLP_INTBASE));
@@ -43,8 +47,10 @@ static inline void mask_msp_slp_irq(unsi
  * While we ack the interrupt interrupts are disabled and thus we don't need
  * to deal with concurrency issues.  Same for msp_slp_irq_end.
  */
-static inline void ack_msp_slp_irq(unsigned int irq)
+static inline void ack_msp_slp_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	/* check for PER interrupt range */
 	if (irq < MSP_PER_INTBASE)
 		*SLP_INT_STS_REG = (1 << (irq - MSP_SLP_INTBASE));
@@ -54,9 +60,9 @@ static inline void ack_msp_slp_irq(unsig
 
 static struct irq_chip msp_slp_irq_controller = {
 	.name = "MSP_SLP",
-	.ack = ack_msp_slp_irq,
-	.mask = mask_msp_slp_irq,
-	.unmask = unmask_msp_slp_irq,
+	.irq_ack = ack_msp_slp_irq,
+	.irq_mask = mask_msp_slp_irq,
+	.irq_unmask = unmask_msp_slp_irq,
 };
 
 void __init msp_slp_irq_init(void)
