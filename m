Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:11:18 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491904Ab1CWVI5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:57 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIR-0001vX-DM; Wed, 23 Mar 2011 22:08:51 +0100
Message-Id: <20110323210535.149703003@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 06/38] mips: dec: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-dec.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/dec/ioasic-irq.c |   60 ++++++++++-----------------------------------
 arch/mips/dec/kn02-irq.c   |   23 +++++++----------
 2 files changed, 24 insertions(+), 59 deletions(-)

Index: linux-mips-next/arch/mips/dec/ioasic-irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/dec/ioasic-irq.c
+++ linux-mips-next/arch/mips/dec/ioasic-irq.c
@@ -17,80 +17,48 @@
 #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/ioasic_ints.h>
 
-
 static int ioasic_irq_base;
 
-
-static inline void unmask_ioasic_irq(unsigned int irq)
+static void unmask_ioasic_irq(struct irq_data *d)
 {
 	u32 simr;
 
 	simr = ioasic_read(IO_REG_SIMR);
-	simr |= (1 << (irq - ioasic_irq_base));
+	simr |= (1 << (d->irq - ioasic_irq_base));
 	ioasic_write(IO_REG_SIMR, simr);
 }
 
-static inline void mask_ioasic_irq(unsigned int irq)
+static void mask_ioasic_irq(struct irq_data *d)
 {
 	u32 simr;
 
 	simr = ioasic_read(IO_REG_SIMR);
-	simr &= ~(1 << (irq - ioasic_irq_base));
+	simr &= ~(1 << (d->irq - ioasic_irq_base));
 	ioasic_write(IO_REG_SIMR, simr);
 }
 
-static inline void clear_ioasic_irq(unsigned int irq)
+static void ack_ioasic_irq(struct irq_data *d)
 {
-	u32 sir;
-
-	sir = ~(1 << (irq - ioasic_irq_base));
-	ioasic_write(IO_REG_SIR, sir);
-}
-
-static inline void ack_ioasic_irq(unsigned int irq)
-{
-	mask_ioasic_irq(irq);
+	mask_ioasic_irq(d);
 	fast_iob();
 }
 
-static inline void end_ioasic_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_ioasic_irq(irq);
-}
-
 static struct irq_chip ioasic_irq_type = {
 	.name = "IO-ASIC",
-	.ack = ack_ioasic_irq,
-	.mask = mask_ioasic_irq,
-	.mask_ack = ack_ioasic_irq,
-	.unmask = unmask_ioasic_irq,
+	.irq_ack = ack_ioasic_irq,
+	.irq_mask = mask_ioasic_irq,
+	.irq_mask_ack = ack_ioasic_irq,
+	.irq_unmask = unmask_ioasic_irq,
 };
 
-
-#define unmask_ioasic_dma_irq unmask_ioasic_irq
-
-#define mask_ioasic_dma_irq mask_ioasic_irq
-
-#define ack_ioasic_dma_irq ack_ioasic_irq
-
-static inline void end_ioasic_dma_irq(unsigned int irq)
-{
-	clear_ioasic_irq(irq);
-	fast_iob();
-	end_ioasic_irq(irq);
-}
-
 static struct irq_chip ioasic_dma_irq_type = {
 	.name = "IO-ASIC-DMA",
-	.ack = ack_ioasic_dma_irq,
-	.mask = mask_ioasic_dma_irq,
-	.mask_ack = ack_ioasic_dma_irq,
-	.unmask = unmask_ioasic_dma_irq,
-	.end = end_ioasic_dma_irq,
+	.irq_ack = ack_ioasic_irq,
+	.irq_mask = mask_ioasic_irq,
+	.irq_mask_ack = ack_ioasic_irq,
+	.irq_unmask = unmask_ioasic_irq,
 };
 
-
 void __init init_ioasic_irqs(int base)
 {
 	int i;
Index: linux-mips-next/arch/mips/dec/kn02-irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/dec/kn02-irq.c
+++ linux-mips-next/arch/mips/dec/kn02-irq.c
@@ -27,43 +27,40 @@
  */
 u32 cached_kn02_csr;
 
-
 static int kn02_irq_base;
 
-
-static inline void unmask_kn02_irq(unsigned int irq)
+static void unmask_kn02_irq(struct irq_data *d)
 {
 	volatile u32 *csr = (volatile u32 *)CKSEG1ADDR(KN02_SLOT_BASE +
 						       KN02_CSR);
 
-	cached_kn02_csr |= (1 << (irq - kn02_irq_base + 16));
+	cached_kn02_csr |= (1 << (d->irq - kn02_irq_base + 16));
 	*csr = cached_kn02_csr;
 }
 
-static inline void mask_kn02_irq(unsigned int irq)
+static void mask_kn02_irq(struct irq_data *d)
 {
 	volatile u32 *csr = (volatile u32 *)CKSEG1ADDR(KN02_SLOT_BASE +
 						       KN02_CSR);
 
-	cached_kn02_csr &= ~(1 << (irq - kn02_irq_base + 16));
+	cached_kn02_csr &= ~(1 << (d->irq - kn02_irq_base + 16));
 	*csr = cached_kn02_csr;
 }
 
-static void ack_kn02_irq(unsigned int irq)
+static void ack_kn02_irq(struct irq_data *d)
 {
-	mask_kn02_irq(irq);
+	mask_kn02_irq(d);
 	iob();
 }
 
 static struct irq_chip kn02_irq_type = {
 	.name = "KN02-CSR",
-	.ack = ack_kn02_irq,
-	.mask = mask_kn02_irq,
-	.mask_ack = ack_kn02_irq,
-	.unmask = unmask_kn02_irq,
+	.irq_ack = ack_kn02_irq,
+	.irq_mask = mask_kn02_irq,
+	.irq_mask_ack = ack_kn02_irq,
+	.irq_unmask = unmask_kn02_irq,
 };
 
-
 void __init init_kn02_irqs(int base)
 {
 	volatile u32 *csr = (volatile u32 *)CKSEG1ADDR(KN02_SLOT_BASE +
