Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 22:55:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36651 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3IVUzTK6crB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 22:55:19 +0200
Date:   Sun, 22 Sep 2013 21:55:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DECstation I/O ASIC DMA interrupt classes
Message-ID: <alpine.LFD.2.03.1309222128400.16797@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This change complements commits d0da7c002f7b2a93582187a9e3f73891a01d8ee4 
[MIPS: DEC: Convert to new irq_chip functions] and 
5359b938c088423a28c41499f183cd10824c1816 [MIPS: DECstation I/O ASIC DMA 
interrupt handling fix] and implements automatic handling of the two 
classes of DMA interrupts the I/O ASIC implements, informational and 
errors.

Informational DMA interrupts do not stop the transfer and use the 
`handle_edge_irq' handler that clears the request right away so that 
another request may be recorded while the previous is being handled.

DMA error interrupts stop the transfer and require a corrective action 
before DMA can be reenabled.  Therefore they use the `handle_fasteoi_irq' 
handler that only clears the request on the way out.  Because MIPS 
processor interrupt inputs, one of which the I/O ASIC's interrupt 
controller is cascaded to, are level-triggered it is recommended that 
error DMA interrupt action handlers are registered with the IRQF_ONESHOT 
flag set so that they are run with the interrupt line masked.

This change removes the export of clear_ioasic_dma_irq that now does not 
have to be called by device drivers to clear interrupts explicitly 
anymore.  Originally these interrupts were cleared in the .end handler of 
the `irq_chip' structure, before it was removed.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

> > The first patch is already upstream in 3.12-rc1, so I will need an 
> > incremental patch.
> 
> Argh, that means I'll have to rewrite the explanation...  Ran out of time
> now, will post later.

 So here it is, please apply.  Additionally:

>  This change was tested at run time, however the LANCE does not work quite
> right -- while data is exchanged so that multi-user login can be reached
> NFS-rooted, link keeps being dropped all the time.  This is not a hardware
> problem, because net-booting using the firmware does not exhibit this
> behaviour.

-- well, I had never expected I would ever say or write that, but 
fortunately it was a hardware problem after all.  It has turned out the 
uplink switch's PSU was on the way out; its operation has since 
deteriorated even further, enough for me to notice it being the cause.  
With the PSU replaced, the LANCE stopped misbehaving and the DECstation is 
fully operational NFS-rooted over Ethernet as well.

  Maciej

linux-dec-ioasic-dma-irq.patch
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/dec/ioasic-irq.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/dec/ioasic-irq.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/dec/ioasic-irq.c
@@ -1,7 +1,7 @@
 /*
  *	DEC I/O ASIC interrupts.
  *
- *	Copyright (c) 2002, 2003  Maciej W. Rozycki
+ *	Copyright (c) 2002, 2003, 2013  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -51,22 +51,51 @@ static struct irq_chip ioasic_irq_type =
 	.irq_unmask = unmask_ioasic_irq,
 };
 
-void clear_ioasic_dma_irq(unsigned int irq)
+static void clear_ioasic_dma_irq(struct irq_data *d)
 {
 	u32 sir;
 
-	sir = ~(1 << (irq - ioasic_irq_base));
+	sir = ~(1 << (d->irq - ioasic_irq_base));
 	ioasic_write(IO_REG_SIR, sir);
+	fast_iob();
 }
 
 static struct irq_chip ioasic_dma_irq_type = {
 	.name = "IO-ASIC-DMA",
-	.irq_ack = ack_ioasic_irq,
+	.irq_ack = clear_ioasic_dma_irq,
 	.irq_mask = mask_ioasic_irq,
-	.irq_mask_ack = ack_ioasic_irq,
 	.irq_unmask = unmask_ioasic_irq,
+	.irq_eoi = clear_ioasic_dma_irq,
 };
 
+/*
+ * I/O ASIC implements two kinds of DMA interrupts, informational and
+ * error interrupts.
+ *
+ * The formers do not stop DMA and should be cleared as soon as possible
+ * so that if they retrigger before the handler has completed, usually as
+ * a side effect of actions taken by the handler, then they are reissued.
+ * These use the `handle_edge_irq' handler that clears the request right
+ * away.
+ *
+ * The latters stop DMA and do not resume it until the interrupt has been
+ * cleared.  This cannot be done until after a corrective action has been
+ * taken and this also means they will not retrigger.  Therefore they use
+ * the `handle_fasteoi_irq' handler that only clears the request on the
+ * way out.  Because MIPS processor interrupt inputs, one of which the I/O
+ * ASIC is cascaded to, are level-triggered it is recommended that error
+ * DMA interrupt action handlers are registered with the IRQF_ONESHOT flag
+ * set so that they are run with the interrupt line masked.
+ *
+ * This mask has `1' bits in the positions of informational interrupts.
+ */
+#define IO_IRQ_DMA_INFO							\
+	(IO_IRQ_MASK(IO_INR_SCC0A_RXDMA) |				\
+	 IO_IRQ_MASK(IO_INR_SCC1A_RXDMA) |				\
+	 IO_IRQ_MASK(IO_INR_ISDN_TXDMA) |				\
+	 IO_IRQ_MASK(IO_INR_ISDN_RXDMA) |				\
+	 IO_IRQ_MASK(IO_INR_ASC_DMA))
+
 void __init init_ioasic_irqs(int base)
 {
 	int i;
@@ -79,7 +108,9 @@ void __init init_ioasic_irqs(int base)
 		irq_set_chip_and_handler(i, &ioasic_irq_type,
 					 handle_level_irq);
 	for (; i < base + IO_IRQ_LINES; i++)
-		irq_set_chip(i, &ioasic_dma_irq_type);
+		irq_set_chip_and_handler(i, &ioasic_dma_irq_type,
+					 1 << (i - base) & IO_IRQ_DMA_INFO ?
+					 handle_edge_irq : handle_fasteoi_irq);
 
 	ioasic_irq_base = base;
 }
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/dec/ioasic.h
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/include/asm/dec/ioasic.h
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/dec/ioasic.h
@@ -31,8 +31,6 @@ static inline u32 ioasic_read(unsigned i
 	return ioasic_base[reg / 4];
 }
 
-extern void clear_ioasic_dma_irq(unsigned int irq);
-
 extern void init_ioasic_irqs(int base);
 
 extern int dec_ioasic_clocksource_init(void);
Index: linux-mips-3.12.0-rc1-20130917-4maxp/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/drivers/net/ethernet/amd/declance.c
+++ linux-mips-3.12.0-rc1-20130917-4maxp/drivers/net/ethernet/amd/declance.c
@@ -725,7 +725,6 @@ static irqreturn_t lance_dma_merr_int(in
 {
 	struct net_device *dev = dev_id;
 
-	clear_ioasic_dma_irq(irq);
 	printk(KERN_ERR "%s: DMA error\n", dev->name);
 	return IRQ_HANDLED;
 }
@@ -812,7 +811,7 @@ static int lance_open(struct net_device 
 	if (lp->dma_irq >= 0) {
 		unsigned long flags;
 
-		if (request_irq(lp->dma_irq, lance_dma_merr_int, 0,
+		if (request_irq(lp->dma_irq, lance_dma_merr_int, IRQF_ONESHOT,
 				"lance error", dev)) {
 			free_irq(dev->irq, dev);
 			printk("%s: Can't get DMA IRQ %d\n", dev->name,
