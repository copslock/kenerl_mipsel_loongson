Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:14:48 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491915Ab1CWVJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:04 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIZ-0001w0-Cs; Wed, 23 Mar 2011 22:08:59 +0100
Message-Id: <20110323210535.998306613@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:59 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 15/38] mips: gt641: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-gt641.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq-gt641xx.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq-gt641xx.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq-gt641xx.c
+++ linux-mips-next/arch/mips/kernel/irq-gt641xx.c
@@ -29,64 +29,64 @@
 
 static DEFINE_RAW_SPINLOCK(gt641xx_irq_lock);
 
-static void ack_gt641xx_irq(unsigned int irq)
+static void ack_gt641xx_irq(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 cause;
 
 	raw_spin_lock_irqsave(&gt641xx_irq_lock, flags);
 	cause = GT_READ(GT_INTRCAUSE_OFS);
-	cause &= ~GT641XX_IRQ_TO_BIT(irq);
+	cause &= ~GT641XX_IRQ_TO_BIT(d->irq);
 	GT_WRITE(GT_INTRCAUSE_OFS, cause);
 	raw_spin_unlock_irqrestore(&gt641xx_irq_lock, flags);
 }
 
-static void mask_gt641xx_irq(unsigned int irq)
+static void mask_gt641xx_irq(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 mask;
 
 	raw_spin_lock_irqsave(&gt641xx_irq_lock, flags);
 	mask = GT_READ(GT_INTRMASK_OFS);
-	mask &= ~GT641XX_IRQ_TO_BIT(irq);
+	mask &= ~GT641XX_IRQ_TO_BIT(d->irq);
 	GT_WRITE(GT_INTRMASK_OFS, mask);
 	raw_spin_unlock_irqrestore(&gt641xx_irq_lock, flags);
 }
 
-static void mask_ack_gt641xx_irq(unsigned int irq)
+static void mask_ack_gt641xx_irq(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 cause, mask;
 
 	raw_spin_lock_irqsave(&gt641xx_irq_lock, flags);
 	mask = GT_READ(GT_INTRMASK_OFS);
-	mask &= ~GT641XX_IRQ_TO_BIT(irq);
+	mask &= ~GT641XX_IRQ_TO_BIT(d->irq);
 	GT_WRITE(GT_INTRMASK_OFS, mask);
 
 	cause = GT_READ(GT_INTRCAUSE_OFS);
-	cause &= ~GT641XX_IRQ_TO_BIT(irq);
+	cause &= ~GT641XX_IRQ_TO_BIT(d->irq);
 	GT_WRITE(GT_INTRCAUSE_OFS, cause);
 	raw_spin_unlock_irqrestore(&gt641xx_irq_lock, flags);
 }
 
-static void unmask_gt641xx_irq(unsigned int irq)
+static void unmask_gt641xx_irq(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 mask;
 
 	raw_spin_lock_irqsave(&gt641xx_irq_lock, flags);
 	mask = GT_READ(GT_INTRMASK_OFS);
-	mask |= GT641XX_IRQ_TO_BIT(irq);
+	mask |= GT641XX_IRQ_TO_BIT(d->irq);
 	GT_WRITE(GT_INTRMASK_OFS, mask);
 	raw_spin_unlock_irqrestore(&gt641xx_irq_lock, flags);
 }
 
 static struct irq_chip gt641xx_irq_chip = {
 	.name		= "GT641xx",
-	.ack		= ack_gt641xx_irq,
-	.mask		= mask_gt641xx_irq,
-	.mask_ack	= mask_ack_gt641xx_irq,
-	.unmask		= unmask_gt641xx_irq,
+	.irq_ack	= ack_gt641xx_irq,
+	.irq_mask	= mask_gt641xx_irq,
+	.irq_mask_ack	= mask_ack_gt641xx_irq,
+	.irq_unmask	= unmask_gt641xx_irq,
 };
 
 void gt641xx_irq_dispatch(void)
