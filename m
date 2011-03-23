Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:22:11 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47504 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491936Ab1CWVJV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:21 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIp-0001x4-Kj; Wed, 23 Mar 2011 22:09:16 +0100
Message-Id: <20110323210537.785661392@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:15 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 34/38] mips: sni: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-sni.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/sni/a20r.c  |   23 ++++++-----------------
 arch/mips/sni/pcimt.c |   21 ++++++---------------
 arch/mips/sni/pcit.c  |   21 ++++++---------------
 arch/mips/sni/rm200.c |   42 +++++++++++++++---------------------------
 4 files changed, 33 insertions(+), 74 deletions(-)

Index: linux-mips-next/arch/mips/sni/a20r.c
===================================================================
--- linux-mips-next.orig/arch/mips/sni/a20r.c
+++ linux-mips-next/arch/mips/sni/a20r.c
@@ -168,33 +168,22 @@ static u32 a20r_ack_hwint(void)
 	return status;
 }
 
-static inline void unmask_a20r_irq(unsigned int irq)
+static inline void unmask_a20r_irq(struct irq_data *d)
 {
-	set_c0_status(0x100 << (irq - SNI_A20R_IRQ_BASE));
+	set_c0_status(0x100 << (d->irq - SNI_A20R_IRQ_BASE));
 	irq_enable_hazard();
 }
 
-static inline void mask_a20r_irq(unsigned int irq)
+static inline void mask_a20r_irq(struct irq_data *d)
 {
-	clear_c0_status(0x100 << (irq - SNI_A20R_IRQ_BASE));
+	clear_c0_status(0x100 << (d->irq - SNI_A20R_IRQ_BASE));
 	irq_disable_hazard();
 }
 
-static void end_a20r_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		a20r_ack_hwint();
-		unmask_a20r_irq(irq);
-	}
-}
-
 static struct irq_chip a20r_irq_type = {
 	.name		= "A20R",
-	.ack		= mask_a20r_irq,
-	.mask		= mask_a20r_irq,
-	.mask_ack	= mask_a20r_irq,
-	.unmask		= unmask_a20r_irq,
-	.end		= end_a20r_irq,
+	.irq_mask	= mask_a20r_irq,
+	.irq_unmask	= unmask_a20r_irq,
 };
 
 /*
Index: linux-mips-next/arch/mips/sni/pcimt.c
===================================================================
--- linux-mips-next.orig/arch/mips/sni/pcimt.c
+++ linux-mips-next/arch/mips/sni/pcimt.c
@@ -194,33 +194,24 @@ static struct pci_controller sni_control
 	.io_map_base    = SNI_PORT_BASE
 };
 
-static void enable_pcimt_irq(unsigned int irq)
+static void enable_pcimt_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq - PCIMT_IRQ_INT2);
+	unsigned int mask = 1 << (d->irq - PCIMT_IRQ_INT2);
 
 	*(volatile u8 *) PCIMT_IRQSEL |= mask;
 }
 
-void disable_pcimt_irq(unsigned int irq)
+void disable_pcimt_irq(struct irq_data *d)
 {
-	unsigned int mask = ~(1 << (irq - PCIMT_IRQ_INT2));
+	unsigned int mask = ~(1 << (d->irq - PCIMT_IRQ_INT2));
 
 	*(volatile u8 *) PCIMT_IRQSEL &= mask;
 }
 
-static void end_pcimt_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_pcimt_irq(irq);
-}
-
 static struct irq_chip pcimt_irq_type = {
 	.name = "PCIMT",
-	.ack = disable_pcimt_irq,
-	.mask = disable_pcimt_irq,
-	.mask_ack = disable_pcimt_irq,
-	.unmask = enable_pcimt_irq,
-	.end = end_pcimt_irq,
+	.irq_mask = disable_pcimt_irq,
+	.irq_unmask = enable_pcimt_irq,
 };
 
 /*
Index: linux-mips-next/arch/mips/sni/pcit.c
===================================================================
--- linux-mips-next.orig/arch/mips/sni/pcit.c
+++ linux-mips-next/arch/mips/sni/pcit.c
@@ -156,33 +156,24 @@ static struct pci_controller sni_pcit_co
 	.io_map_base    = SNI_PORT_BASE
 };
 
-static void enable_pcit_irq(unsigned int irq)
+static void enable_pcit_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (irq - SNI_PCIT_INT_START + 24);
+	u32 mask = 1 << (d->irq - SNI_PCIT_INT_START + 24);
 
 	*(volatile u32 *)SNI_PCIT_INT_REG |= mask;
 }
 
-void disable_pcit_irq(unsigned int irq)
+void disable_pcit_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (irq - SNI_PCIT_INT_START + 24);
+	u32 mask = 1 << (d->irq - SNI_PCIT_INT_START + 24);
 
 	*(volatile u32 *)SNI_PCIT_INT_REG &= ~mask;
 }
 
-void end_pcit_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_pcit_irq(irq);
-}
-
 static struct irq_chip pcit_irq_type = {
 	.name = "PCIT",
-	.ack = disable_pcit_irq,
-	.mask = disable_pcit_irq,
-	.mask_ack = disable_pcit_irq,
-	.unmask = enable_pcit_irq,
-	.end = end_pcit_irq,
+	.irq_mask = disable_pcit_irq,
+	.irq_unmask = enable_pcit_irq,
 };
 
 static void pcit_hwint1(void)
Index: linux-mips-next/arch/mips/sni/rm200.c
===================================================================
--- linux-mips-next.orig/arch/mips/sni/rm200.c
+++ linux-mips-next/arch/mips/sni/rm200.c
@@ -155,12 +155,11 @@ static __iomem u8 *rm200_pic_slave;
 #define cached_master_mask	(rm200_cached_irq_mask)
 #define cached_slave_mask	(rm200_cached_irq_mask >> 8)
 
-static void sni_rm200_disable_8259A_irq(unsigned int irq)
+static void sni_rm200_disable_8259A_irq(struct irq_data *d)
 {
-	unsigned int mask;
+	unsigned int mask, irq = d->irq - RM200_I8259A_IRQ_BASE;
 	unsigned long flags;
 
-	irq -= RM200_I8259A_IRQ_BASE;
 	mask = 1 << irq;
 	raw_spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
 	rm200_cached_irq_mask |= mask;
@@ -171,12 +170,11 @@ static void sni_rm200_disable_8259A_irq(
 	raw_spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
 }
 
-static void sni_rm200_enable_8259A_irq(unsigned int irq)
+static void sni_rm200_enable_8259A_irq(struct irq_data *d)
 {
-	unsigned int mask;
+	unsigned int mask, irq = d->irq - RM200_I8259A_IRQ_BASE;
 	unsigned long flags;
 
-	irq -= RM200_I8259A_IRQ_BASE;
 	mask = ~(1 << irq);
 	raw_spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
 	rm200_cached_irq_mask &= mask;
@@ -210,12 +208,11 @@ static inline int sni_rm200_i8259A_irq_r
  * first, _then_ send the EOI, and the order of EOI
  * to the two 8259s is important!
  */
-void sni_rm200_mask_and_ack_8259A(unsigned int irq)
+void sni_rm200_mask_and_ack_8259A(struct irq_data *d)
 {
-	unsigned int irqmask;
+	unsigned int irqmask, irq = d->irq - RM200_I8259A_IRQ_BASE;
 	unsigned long flags;
 
-	irq -= RM200_I8259A_IRQ_BASE;
 	irqmask = 1 << irq;
 	raw_spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
 	/*
@@ -285,9 +282,9 @@ spurious_8259A_irq:
 
 static struct irq_chip sni_rm200_i8259A_chip = {
 	.name		= "RM200-XT-PIC",
-	.mask		= sni_rm200_disable_8259A_irq,
-	.unmask		= sni_rm200_enable_8259A_irq,
-	.mask_ack	= sni_rm200_mask_and_ack_8259A,
+	.irq_mask	= sni_rm200_disable_8259A_irq,
+	.irq_unmask	= sni_rm200_enable_8259A_irq,
+	.irq_mask_ack	= sni_rm200_mask_and_ack_8259A,
 };
 
 /*
@@ -429,33 +426,24 @@ void __init sni_rm200_i8259_irqs(void)
 #define SNI_RM200_INT_START  24
 #define SNI_RM200_INT_END    28
 
-static void enable_rm200_irq(unsigned int irq)
+static void enable_rm200_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq - SNI_RM200_INT_START);
+	unsigned int mask = 1 << (d->irq - SNI_RM200_INT_START);
 
 	*(volatile u8 *)SNI_RM200_INT_ENA_REG &= ~mask;
 }
 
-void disable_rm200_irq(unsigned int irq)
+void disable_rm200_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq - SNI_RM200_INT_START);
+	unsigned int mask = 1 << (d->irq - SNI_RM200_INT_START);
 
 	*(volatile u8 *)SNI_RM200_INT_ENA_REG |= mask;
 }
 
-void end_rm200_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_rm200_irq(irq);
-}
-
 static struct irq_chip rm200_irq_type = {
 	.name = "RM200",
-	.ack = disable_rm200_irq,
-	.mask = disable_rm200_irq,
-	.mask_ack = disable_rm200_irq,
-	.unmask = enable_rm200_irq,
-	.end = end_rm200_irq,
+	.irq_mask = disable_rm200_irq,
+	.irq_unmask = enable_rm200_irq,
 };
 
 static void sni_rm200_hwint(void)
