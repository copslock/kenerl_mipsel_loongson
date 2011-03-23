Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:12:05 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491906Ab1CWVI6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:58 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIT-0001vd-8I; Wed, 23 Mar 2011 22:08:53 +0100
Message-Id: <20110323210535.337667161@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:52 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 08/38] mips: jazz: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-jazz.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/jazz/irq.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-mips-next/arch/mips/jazz/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/jazz/irq.c
+++ linux-mips-next/arch/mips/jazz/irq.c
@@ -23,9 +23,9 @@
 
 static DEFINE_RAW_SPINLOCK(r4030_lock);
 
-static void enable_r4030_irq(unsigned int irq)
+static void enable_r4030_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq - JAZZ_IRQ_START);
+	unsigned int mask = 1 << (d->irq - JAZZ_IRQ_START);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&r4030_lock, flags);
@@ -34,9 +34,9 @@ static void enable_r4030_irq(unsigned in
 	raw_spin_unlock_irqrestore(&r4030_lock, flags);
 }
 
-void disable_r4030_irq(unsigned int irq)
+void disable_r4030_irq(struct irq_data *d)
 {
-	unsigned int mask = ~(1 << (irq - JAZZ_IRQ_START));
+	unsigned int mask = ~(1 << (d->irq - JAZZ_IRQ_START));
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&r4030_lock, flags);
@@ -47,10 +47,8 @@ void disable_r4030_irq(unsigned int irq)
 
 static struct irq_chip r4030_irq_type = {
 	.name = "R4030",
-	.ack = disable_r4030_irq,
-	.mask = disable_r4030_irq,
-	.mask_ack = disable_r4030_irq,
-	.unmask = enable_r4030_irq,
+	.irq_mask = disable_r4030_irq,
+	.irq_unmask = enable_r4030_irq,
 };
 
 void __init init_r4030_ints(void)
