Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:15:10 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47449 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491916Ab1CWVJF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:05 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIa-0001w3-5l; Wed, 23 Mar 2011 22:09:00 +0100
Message-Id: <20110323210536.091664725@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:59 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 16/38] mips: msc01: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-msc01.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq-msc01.c |   51 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq-msc01.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq-msc01.c
+++ linux-mips-next/arch/mips/kernel/irq-msc01.c
@@ -28,8 +28,10 @@ static unsigned long _icctrl_msc;
 static unsigned int irq_base;
 
 /* mask off an interrupt */
-static inline void mask_msc_irq(unsigned int irq)
+static inline void mask_msc_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	if (irq < (irq_base + 32))
 		MSCIC_WRITE(MSC01_IC_DISL, 1<<(irq - irq_base));
 	else
@@ -37,8 +39,10 @@ static inline void mask_msc_irq(unsigned
 }
 
 /* unmask an interrupt */
-static inline void unmask_msc_irq(unsigned int irq)
+static inline void unmask_msc_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	if (irq < (irq_base + 32))
 		MSCIC_WRITE(MSC01_IC_ENAL, 1<<(irq - irq_base));
 	else
@@ -48,9 +52,11 @@ static inline void unmask_msc_irq(unsign
 /*
  * Masks and ACKs an IRQ
  */
-static void level_mask_and_ack_msc_irq(unsigned int irq)
+static void level_mask_and_ack_msc_irq(struct irq_data *d)
 {
-	mask_msc_irq(irq);
+	unsigned int irq = d->irq;
+
+	mask_msc_irq(d);
 	if (!cpu_has_veic)
 		MSCIC_WRITE(MSC01_IC_EOI, 0);
 	/* This actually needs to be a call into platform code */
@@ -60,9 +66,11 @@ static void level_mask_and_ack_msc_irq(u
 /*
  * Masks and ACKs an IRQ
  */
-static void edge_mask_and_ack_msc_irq(unsigned int irq)
+static void edge_mask_and_ack_msc_irq(struct irq_data *d)
 {
-	mask_msc_irq(irq);
+	unsigned int irq = d->irq;
+
+	mask_msc_irq(d);
 	if (!cpu_has_veic)
 		MSCIC_WRITE(MSC01_IC_EOI, 0);
 	else {
@@ -75,15 +83,6 @@ static void edge_mask_and_ack_msc_irq(un
 }
 
 /*
- * End IRQ processing
- */
-static void end_msc_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		unmask_msc_irq(irq);
-}
-
-/*
  * Interrupt handler for interrupts coming from SOC-it.
  */
 void ll_msc_irq(void)
@@ -107,22 +106,20 @@ static void msc_bind_eic_interrupt(int i
 
 static struct irq_chip msc_levelirq_type = {
 	.name = "SOC-it-Level",
-	.ack = level_mask_and_ack_msc_irq,
-	.mask = mask_msc_irq,
-	.mask_ack = level_mask_and_ack_msc_irq,
-	.unmask = unmask_msc_irq,
-	.eoi = unmask_msc_irq,
-	.end = end_msc_irq,
+	.irq_ack = level_mask_and_ack_msc_irq,
+	.irq_mask = mask_msc_irq,
+	.irq_mask_ack = level_mask_and_ack_msc_irq,
+	.irq_unmask = unmask_msc_irq,
+	.irq_eoi = unmask_msc_irq,
 };
 
 static struct irq_chip msc_edgeirq_type = {
 	.name = "SOC-it-Edge",
-	.ack = edge_mask_and_ack_msc_irq,
-	.mask = mask_msc_irq,
-	.mask_ack = edge_mask_and_ack_msc_irq,
-	.unmask = unmask_msc_irq,
-	.eoi = unmask_msc_irq,
-	.end = end_msc_irq,
+	.irq_ack = edge_mask_and_ack_msc_irq,
+	.irq_mask = mask_msc_irq,
+	.irq_mask_ack = edge_mask_and_ack_msc_irq,
+	.irq_unmask = unmask_msc_irq,
+	.irq_eoi = unmask_msc_irq,
 };
 
 
