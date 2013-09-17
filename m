Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 17:40:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46889 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860908Ab3IQPkjoGDbQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 17:40:39 +0200
Date:   Tue, 17 Sep 2013 16:40:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: DECstation I/O ASIC DMA interrupt handling fix
Message-ID: <alpine.LFD.2.03.1309171613160.5967@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37832
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

This change complements commit d0da7c002f7b2a93582187a9e3f73891a01d8ee4 
and brings clear_ioasic_irq back, renaming it to clear_ioasic_dma_irq at 
the same time, to make I/O ASIC DMA interrupts functional.

Unlike ordinary I/O ASIC interrupts DMA interrupts need to be deasserted 
by software by writing 0 to the respective bit in I/O ASIC's System 
Interrupt Register (SIR), similarly to how CP0.Cause.IP0 and CP0.Cause.IP1 
bits are handled in the CPU (the difference is SIR DMA interrupt bits are 
R/W0C so there's no need for an RMW cycle).  Otherwise the handler is 
reentered over and over again.

The only current user is the DEC LANCE Ethernet driver and its extremely 
uncommon DMA memory error handler that has never cared when exactly the 
interrupt is cleared (it has to be investigated whether this is actually 
the correct approach though).  Anticipating the use of DMA interrupts by 
the Zilog SCC driver this change however implements handling for the two 
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

Previously these interrupts were cleared in the .end handler of the 
`irq_chip' structure, before it was removed.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 I see you have applied the original change after all; I'd prefer it to be 
dropped to avoid cluttering the history, but please let me know if you 
need an incremental change instead.

 This change was tested at run time, however the LANCE does not work quite 
right -- while data is exchanged so that multi-user login can be reached 
NFS-rooted, link keeps being dropped all the time.  This is not a hardware 
problem, because net-booting using the firmware does not exhibit this 
behaviour.  So interestingly enough FDDI is currently the only reliable 
network connection for the DECstation.  Well, reliability was the primary 
goal FDDI was designed with. ;)

  Maciej

linux-dec-ioasic-dma-irq.patch
Index: linux/arch/mips/dec/ioasic-irq.c
===================================================================
--- linux.orig/arch/mips/dec/ioasic-irq.c
+++ linux/arch/mips/dec/ioasic-irq.c
@@ -1,7 +1,7 @@
 /*
  *	DEC I/O ASIC interrupts.
  *
- *	Copyright (c) 2002, 2003  Maciej W. Rozycki
+ *	Copyright (c) 2002, 2003, 2013  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -51,14 +51,51 @@ static struct irq_chip ioasic_irq_type =
 	.irq_unmask = unmask_ioasic_irq,
 };
 
+static void clear_ioasic_dma_irq(struct irq_data *d)
+{
+	u32 sir;
+
+	sir = ~(1 << (d->irq - ioasic_irq_base));
+	ioasic_write(IO_REG_SIR, sir);
+	fast_iob();
+}
+
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
@@ -71,7 +108,9 @@ void __init init_ioasic_irqs(int base)
 		irq_set_chip_and_handler(i, &ioasic_irq_type,
 					 handle_level_irq);
 	for (; i < base + IO_IRQ_LINES; i++)
-		irq_set_chip(i, &ioasic_dma_irq_type);
+		irq_set_chip_and_handler(i, &ioasic_dma_irq_type,
+					 1 << (i - base) & IO_IRQ_DMA_INFO ?
+					 handle_edge_irq : handle_fasteoi_irq);
 
 	ioasic_irq_base = base;
 }
Index: linux/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux.orig/drivers/net/ethernet/amd/declance.c
+++ linux/drivers/net/ethernet/amd/declance.c
@@ -811,7 +811,7 @@ static int lance_open(struct net_device 
 	if (lp->dma_irq >= 0) {
 		unsigned long flags;
 
-		if (request_irq(lp->dma_irq, lance_dma_merr_int, 0,
+		if (request_irq(lp->dma_irq, lance_dma_merr_int, IRQF_ONESHOT,
 				"lance error", dev)) {
 			free_irq(dev->irq, dev);
 			printk("%s: Can't get DMA IRQ %d\n", dev->name,
