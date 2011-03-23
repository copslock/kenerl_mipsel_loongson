Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:10:29 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491898Ab1CWVIx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:53 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIO-0001vR-5F; Wed, 23 Mar 2011 22:08:48 +0100
Message-Id: <20110323210534.952010129@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:47 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 04/38] mips: bcm63xx: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-bcm63xx.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/bcm63xx/irq.c |   77 +++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 45 deletions(-)

Index: linux-mips-next/arch/mips/bcm63xx/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/bcm63xx/irq.c
+++ linux-mips-next/arch/mips/bcm63xx/irq.c
@@ -76,88 +76,80 @@ asmlinkage void plat_irq_dispatch(void)
  * internal IRQs operations: only mask/unmask on PERF irq mask
  * register.
  */
-static inline void bcm63xx_internal_irq_mask(unsigned int irq)
+static inline void bcm63xx_internal_irq_mask(struct irq_data *d)
 {
+	unsigned int irq = d->irq - IRQ_INTERNAL_BASE;
 	u32 mask;
 
-	irq -= IRQ_INTERNAL_BASE;
 	mask = bcm_perf_readl(PERF_IRQMASK_REG);
 	mask &= ~(1 << irq);
 	bcm_perf_writel(mask, PERF_IRQMASK_REG);
 }
 
-static void bcm63xx_internal_irq_unmask(unsigned int irq)
+static void bcm63xx_internal_irq_unmask(struct irq_data *d)
 {
+	unsigned int irq = d->irq - IRQ_INTERNAL_BASE;
 	u32 mask;
 
-	irq -= IRQ_INTERNAL_BASE;
 	mask = bcm_perf_readl(PERF_IRQMASK_REG);
 	mask |= (1 << irq);
 	bcm_perf_writel(mask, PERF_IRQMASK_REG);
 }
 
-static unsigned int bcm63xx_internal_irq_startup(unsigned int irq)
-{
-	bcm63xx_internal_irq_unmask(irq);
-	return 0;
-}
-
 /*
  * external IRQs operations: mask/unmask and clear on PERF external
  * irq control register.
  */
-static void bcm63xx_external_irq_mask(unsigned int irq)
+static void bcm63xx_external_irq_mask(struct irq_data *d)
 {
+	unsigned int irq = d->irq - IRQ_EXT_BASE;
 	u32 reg;
 
-	irq -= IRQ_EXT_BASE;
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg &= ~EXTIRQ_CFG_MASK(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 }
 
-static void bcm63xx_external_irq_unmask(unsigned int irq)
+static void bcm63xx_external_irq_unmask(struct irq_data *d)
 {
+	unsigned int irq = d->irq - IRQ_EXT_BASE;
 	u32 reg;
 
-	irq -= IRQ_EXT_BASE;
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg |= EXTIRQ_CFG_MASK(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 }
 
-static void bcm63xx_external_irq_clear(unsigned int irq)
+static void bcm63xx_external_irq_clear(struct irq_data *d)
 {
+	unsigned int irq = d->irq - IRQ_EXT_BASE;
 	u32 reg;
 
-	irq -= IRQ_EXT_BASE;
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg |= EXTIRQ_CFG_CLEAR(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 }
 
-static unsigned int bcm63xx_external_irq_startup(unsigned int irq)
+static unsigned int bcm63xx_external_irq_startup(struct irq_data *d)
 {
-	set_c0_status(0x100 << (irq - IRQ_MIPS_BASE));
+	set_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
 	irq_enable_hazard();
-	bcm63xx_external_irq_unmask(irq);
+	bcm63xx_external_irq_unmask(d);
 	return 0;
 }
 
-static void bcm63xx_external_irq_shutdown(unsigned int irq)
+static void bcm63xx_external_irq_shutdown(struct irq_data *d)
 {
-	bcm63xx_external_irq_mask(irq);
-	clear_c0_status(0x100 << (irq - IRQ_MIPS_BASE));
+	bcm63xx_external_irq_mask(d);
+	clear_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
 	irq_disable_hazard();
 }
 
-static int bcm63xx_external_irq_set_type(unsigned int irq,
+static int bcm63xx_external_irq_set_type(struct irq_data *d,
 					 unsigned int flow_type)
 {
+	unsigned int irq = d->irq - IRQ_EXT_BASE;
 	u32 reg;
-	struct irq_desc *desc = irq_desc + irq;
-
-	irq -= IRQ_EXT_BASE;
 
 	flow_type &= IRQ_TYPE_SENSE_MASK;
 
@@ -199,37 +191,32 @@ static int bcm63xx_external_irq_set_type
 	}
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 
-	if (flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))  {
-		desc->status |= IRQ_LEVEL;
-		desc->handle_irq = handle_level_irq;
-	} else {
-		desc->handle_irq = handle_edge_irq;
-	}
+	irqd_set_trigger_type(d, flow_type);
+	if (flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
+		__irq_set_handler_locked(d->irq, handle_level_irq);
+	else
+		__irq_set_handler_locked(d->irq, handle_edge_irq);
 
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
 static struct irq_chip bcm63xx_internal_irq_chip = {
 	.name		= "bcm63xx_ipic",
-	.startup	= bcm63xx_internal_irq_startup,
-	.shutdown	= bcm63xx_internal_irq_mask,
-
-	.mask		= bcm63xx_internal_irq_mask,
-	.mask_ack	= bcm63xx_internal_irq_mask,
-	.unmask		= bcm63xx_internal_irq_unmask,
+	.irq_mask	= bcm63xx_internal_irq_mask,
+	.irq_unmask	= bcm63xx_internal_irq_unmask,
 };
 
 static struct irq_chip bcm63xx_external_irq_chip = {
 	.name		= "bcm63xx_epic",
-	.startup	= bcm63xx_external_irq_startup,
-	.shutdown	= bcm63xx_external_irq_shutdown,
+	.irq_startup	= bcm63xx_external_irq_startup,
+	.irq_shutdown	= bcm63xx_external_irq_shutdown,
 
-	.ack		= bcm63xx_external_irq_clear,
+	.irq_ack	= bcm63xx_external_irq_clear,
 
-	.mask		= bcm63xx_external_irq_mask,
-	.unmask		= bcm63xx_external_irq_unmask,
+	.irq_mask	= bcm63xx_external_irq_mask,
+	.irq_unmask	= bcm63xx_external_irq_unmask,
 
-	.set_type	= bcm63xx_external_irq_set_type,
+	.irq_set_type	= bcm63xx_external_irq_set_type,
 };
 
 static struct irqaction cpu_ip2_cascade_action = {
