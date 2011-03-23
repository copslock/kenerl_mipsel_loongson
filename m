Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:09:18 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491892Ab1CWVIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:51 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIL-0001vH-5U; Wed, 23 Mar 2011 22:08:46 +0100
Message-Id: <20110323210534.669706549@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:44 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 01/38] mips; Convert alchemy to new irq chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-alch.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Fix the deadlock in set_type() while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/alchemy/common/irq.c     |   98 ++++++++++++++++++-------------------
 arch/mips/alchemy/devboards/bcsr.c |   18 +++---
 2 files changed, 59 insertions(+), 57 deletions(-)

Index: linux-mips-next/arch/mips/alchemy/common/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/alchemy/common/irq.c
+++ linux-mips-next/arch/mips/alchemy/common/irq.c
@@ -39,7 +39,7 @@
 #include <asm/mach-pb1x00/pb1000.h>
 #endif
 
-static int au1x_ic_settype(unsigned int irq, unsigned int flow_type);
+static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type);
 
 /* NOTE on interrupt priorities: The original writers of this code said:
  *
@@ -218,17 +218,17 @@ struct au1xxx_irqmap au1200_irqmap[] __i
 };
 
 
-static void au1x_ic0_unmask(unsigned int irq_nr)
+static void au1x_ic0_unmask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 	au_writel(1 << bit, IC0_MASKSET);
 	au_writel(1 << bit, IC0_WAKESET);
 	au_sync();
 }
 
-static void au1x_ic1_unmask(unsigned int irq_nr)
+static void au1x_ic1_unmask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 	au_writel(1 << bit, IC1_MASKSET);
 	au_writel(1 << bit, IC1_WAKESET);
 
@@ -236,31 +236,31 @@ static void au1x_ic1_unmask(unsigned int
  * nowhere in the current kernel sources is it disabled.	--mlau
  */
 #if defined(CONFIG_MIPS_PB1000)
-	if (irq_nr == AU1000_GPIO15_INT)
+	if (d->irq == AU1000_GPIO15_INT)
 		au_writel(0x4000, PB1000_MDR); /* enable int */
 #endif
 	au_sync();
 }
 
-static void au1x_ic0_mask(unsigned int irq_nr)
+static void au1x_ic0_mask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 	au_writel(1 << bit, IC0_MASKCLR);
 	au_writel(1 << bit, IC0_WAKECLR);
 	au_sync();
 }
 
-static void au1x_ic1_mask(unsigned int irq_nr)
+static void au1x_ic1_mask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 	au_writel(1 << bit, IC1_MASKCLR);
 	au_writel(1 << bit, IC1_WAKECLR);
 	au_sync();
 }
 
-static void au1x_ic0_ack(unsigned int irq_nr)
+static void au1x_ic0_ack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 
 	/*
 	 * This may assume that we don't get interrupts from
@@ -271,9 +271,9 @@ static void au1x_ic0_ack(unsigned int ir
 	au_sync();
 }
 
-static void au1x_ic1_ack(unsigned int irq_nr)
+static void au1x_ic1_ack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 
 	/*
 	 * This may assume that we don't get interrupts from
@@ -284,9 +284,9 @@ static void au1x_ic1_ack(unsigned int ir
 	au_sync();
 }
 
-static void au1x_ic0_maskack(unsigned int irq_nr)
+static void au1x_ic0_maskack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 
 	au_writel(1 << bit, IC0_WAKECLR);
 	au_writel(1 << bit, IC0_MASKCLR);
@@ -295,9 +295,9 @@ static void au1x_ic0_maskack(unsigned in
 	au_sync();
 }
 
-static void au1x_ic1_maskack(unsigned int irq_nr)
+static void au1x_ic1_maskack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 
 	au_writel(1 << bit, IC1_WAKECLR);
 	au_writel(1 << bit, IC1_MASKCLR);
@@ -306,9 +306,9 @@ static void au1x_ic1_maskack(unsigned in
 	au_sync();
 }
 
-static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
+static int au1x_ic1_setwake(struct irq_data *d, unsigned int on)
 {
-	int bit = irq - AU1000_INTC1_INT_BASE;
+	int bit = d->irq - AU1000_INTC1_INT_BASE;
 	unsigned long wakemsk, flags;
 
 	/* only GPIO 0-7 can act as wakeup source.  Fortunately these
@@ -336,28 +336,30 @@ static int au1x_ic1_setwake(unsigned int
  */
 static struct irq_chip au1x_ic0_chip = {
 	.name		= "Alchemy-IC0",
-	.ack		= au1x_ic0_ack,
-	.mask		= au1x_ic0_mask,
-	.mask_ack	= au1x_ic0_maskack,
-	.unmask		= au1x_ic0_unmask,
-	.set_type	= au1x_ic_settype,
+	.irq_ack	= au1x_ic0_ack,
+	.irq_mask	= au1x_ic0_mask,
+	.irq_mask_ack	= au1x_ic0_maskack,
+	.irq_unmask	= au1x_ic0_unmask,
+	.irq_set_type	= au1x_ic_settype,
 };
 
 static struct irq_chip au1x_ic1_chip = {
 	.name		= "Alchemy-IC1",
-	.ack		= au1x_ic1_ack,
-	.mask		= au1x_ic1_mask,
-	.mask_ack	= au1x_ic1_maskack,
-	.unmask		= au1x_ic1_unmask,
-	.set_type	= au1x_ic_settype,
-	.set_wake	= au1x_ic1_setwake,
+	.irq_ack	= au1x_ic1_ack,
+	.irq_mask	= au1x_ic1_mask,
+	.irq_mask_ack	= au1x_ic1_maskack,
+	.irq_unmask	= au1x_ic1_unmask,
+	.irq_set_type	= au1x_ic_settype,
+	.irq_set_wake	= au1x_ic1_setwake,
 };
 
-static int au1x_ic_settype(unsigned int irq, unsigned int flow_type)
+static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type)
 {
 	struct irq_chip *chip;
 	unsigned long icr[6];
-	unsigned int bit, ic;
+	unsigned int bit, ic, irq = d->irq;
+	irq_flow_handler_t handler = NULL;
+	unsigned char *name = NULL;
 	int ret;
 
 	if (irq >= AU1000_INTC1_INT_BASE) {
@@ -387,47 +389,47 @@ static int au1x_ic_settype(unsigned int 
 		au_writel(1 << bit, icr[5]);
 		au_writel(1 << bit, icr[4]);
 		au_writel(1 << bit, icr[0]);
-		set_irq_chip_and_handler_name(irq, chip,
-				handle_edge_irq, "riseedge");
+		handler = handle_edge_irq;
+		name = "riseedge";
 		break;
 	case IRQ_TYPE_EDGE_FALLING:	/* 0:1:0 */
 		au_writel(1 << bit, icr[5]);
 		au_writel(1 << bit, icr[1]);
 		au_writel(1 << bit, icr[3]);
-		set_irq_chip_and_handler_name(irq, chip,
-				handle_edge_irq, "falledge");
+		handler = handle_edge_irq;
+		name = "falledge";
 		break;
 	case IRQ_TYPE_EDGE_BOTH:	/* 0:1:1 */
 		au_writel(1 << bit, icr[5]);
 		au_writel(1 << bit, icr[1]);
 		au_writel(1 << bit, icr[0]);
-		set_irq_chip_and_handler_name(irq, chip,
-				handle_edge_irq, "bothedge");
+		handler = handle_edge_irq;
+		name = "bothedge";
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:	/* 1:0:1 */
 		au_writel(1 << bit, icr[2]);
 		au_writel(1 << bit, icr[4]);
 		au_writel(1 << bit, icr[0]);
-		set_irq_chip_and_handler_name(irq, chip,
-				handle_level_irq, "hilevel");
+		handler = handle_level_irq;
+		name = "hilevel";
 		break;
 	case IRQ_TYPE_LEVEL_LOW:	/* 1:1:0 */
 		au_writel(1 << bit, icr[2]);
 		au_writel(1 << bit, icr[1]);
 		au_writel(1 << bit, icr[3]);
-		set_irq_chip_and_handler_name(irq, chip,
-				handle_level_irq, "lowlevel");
+		handler = handle_level_irq;
+		name = "lowlevel";
 		break;
 	case IRQ_TYPE_NONE:		/* 0:0:0 */
 		au_writel(1 << bit, icr[5]);
 		au_writel(1 << bit, icr[4]);
 		au_writel(1 << bit, icr[3]);
-		/* set at least chip so we can call set_irq_type() on it */
-		set_irq_chip(irq, chip);
 		break;
 	default:
 		ret = -EINVAL;
 	}
+	__irq_set_chip_handler_name_locked(d->irq, chip, handler, name);
+
 	au_sync();
 
 	return ret;
@@ -504,11 +506,11 @@ static void __init au1000_init_irq(struc
 	 */
 	for (i = AU1000_INTC0_INT_BASE;
 	     (i < AU1000_INTC0_INT_BASE + 32); i++)
-		au1x_ic_settype(i, IRQ_TYPE_NONE);
+		au1x_ic_settype(irq_get_irq_data(i), IRQ_TYPE_NONE);
 
 	for (i = AU1000_INTC1_INT_BASE;
 	     (i < AU1000_INTC1_INT_BASE + 32); i++)
-		au1x_ic_settype(i, IRQ_TYPE_NONE);
+		au1x_ic_settype(irq_get_irq_data(i), IRQ_TYPE_NONE);
 
 	/*
 	 * Initialize IC0, which is fixed per processor.
@@ -526,7 +528,7 @@ static void __init au1000_init_irq(struc
 				au_writel(1 << bit, IC0_ASSIGNSET);
 		}
 
-		au1x_ic_settype(irq_nr, map->im_type);
+		au1x_ic_settype(irq_get_irq_data(irq_nr), map->im_type);
 		++map;
 	}
 
Index: linux-mips-next/arch/mips/alchemy/devboards/bcsr.c
===================================================================
--- linux-mips-next.orig/arch/mips/alchemy/devboards/bcsr.c
+++ linux-mips-next/arch/mips/alchemy/devboards/bcsr.c
@@ -97,26 +97,26 @@ static void bcsr_csc_handler(unsigned in
  * CPLD generates tons of spurious interrupts (at least on my DB1200).
  *	-- mlau
  */
-static void bcsr_irq_mask(unsigned int irq_nr)
+static void bcsr_irq_mask(struct irq_data *d)
 {
-	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	unsigned short v = 1 << (d->irq - bcsr_csc_base);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
 	wmb();
 }
 
-static void bcsr_irq_maskack(unsigned int irq_nr)
+static void bcsr_irq_maskack(struct irq_data *d)
 {
-	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	unsigned short v = 1 << (d->irq - bcsr_csc_base);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTSTAT);	/* ack */
 	wmb();
 }
 
-static void bcsr_irq_unmask(unsigned int irq_nr)
+static void bcsr_irq_unmask(struct irq_data *d)
 {
-	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	unsigned short v = 1 << (d->irq - bcsr_csc_base);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTSET);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKSET);
 	wmb();
@@ -124,9 +124,9 @@ static void bcsr_irq_unmask(unsigned int
 
 static struct irq_chip bcsr_irq_type = {
 	.name		= "CPLD",
-	.mask		= bcsr_irq_mask,
-	.mask_ack	= bcsr_irq_maskack,
-	.unmask		= bcsr_irq_unmask,
+	.irq_mask	= bcsr_irq_mask,
+	.irq_mask_ack	= bcsr_irq_maskack,
+	.irq_unmask	= bcsr_irq_unmask,
 };
 
 void __init bcsr_init_irq(int csc_start, int csc_end, int hook_irq)
