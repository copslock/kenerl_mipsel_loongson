Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:13:38 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47437 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491910Ab1CWVJC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:02 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIW-0001vr-TQ; Wed, 23 Mar 2011 22:08:57 +0100
Message-Id: <20110323210535.715281237@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:56 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 12/38] misp: lasat: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=misp-lasat.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/lasat/interrupt.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-mips-next/arch/mips/lasat/interrupt.c
===================================================================
--- linux-mips-next.orig/arch/mips/lasat/interrupt.c
+++ linux-mips-next/arch/mips/lasat/interrupt.c
@@ -32,24 +32,24 @@ static volatile int *lasat_int_status;
 static volatile int *lasat_int_mask;
 static volatile int lasat_int_mask_shift;
 
-void disable_lasat_irq(unsigned int irq_nr)
+void disable_lasat_irq(struct irq_data *d)
 {
-	irq_nr -= LASAT_IRQ_BASE;
+	unsigned int irq_nr = d->irq - LASAT_IRQ_BASE;
+
 	*lasat_int_mask &= ~(1 << irq_nr) << lasat_int_mask_shift;
 }
 
-void enable_lasat_irq(unsigned int irq_nr)
+void enable_lasat_irq(struct irq_data *d)
 {
-	irq_nr -= LASAT_IRQ_BASE;
+	unsigned int irq_nr = d->irq - LASAT_IRQ_BASE;
+
 	*lasat_int_mask |= (1 << irq_nr) << lasat_int_mask_shift;
 }
 
 static struct irq_chip lasat_irq_type = {
 	.name = "Lasat",
-	.ack = disable_lasat_irq,
-	.mask = disable_lasat_irq,
-	.mask_ack = disable_lasat_irq,
-	.unmask = enable_lasat_irq,
+	.irq_mask = disable_lasat_irq,
+	.irq_unmask = enable_lasat_irq,
 };
 
 static inline int ls1bit32(unsigned int x)
