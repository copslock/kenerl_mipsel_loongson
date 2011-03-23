Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:19:28 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47482 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491929Ab1CWVJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:14 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIj-0001wh-Cq; Wed, 23 Mar 2011 22:09:09 +0100
Message-Id: <20110323210537.126033119@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:09 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 27/38] mips: pnx855: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-pnx855.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/pnx8550/common/int.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-mips-next/arch/mips/pnx8550/common/int.c
===================================================================
--- linux-mips-next.orig/arch/mips/pnx8550/common/int.c
+++ linux-mips-next/arch/mips/pnx8550/common/int.c
@@ -114,8 +114,10 @@ static inline void unmask_gic_int(unsign
 	PNX8550_GIC_REQ(irq_nr) = (1<<26 | 1<<16) | (1<<28) | gic_prio[irq_nr];
 }
 
-static inline void mask_irq(unsigned int irq_nr)
+static inline void mask_irq(struct irq_data *d)
 {
+	unsigned int irq_nr = d->irq;
+
 	if ((PNX8550_INT_CP0_MIN <= irq_nr) && (irq_nr <= PNX8550_INT_CP0_MAX)) {
 		modify_cp0_intmask(1 << irq_nr, 0);
 	} else if ((PNX8550_INT_GIC_MIN <= irq_nr) &&
@@ -129,8 +131,10 @@ static inline void mask_irq(unsigned int
 	}
 }
 
-static inline void unmask_irq(unsigned int irq_nr)
+static inline void unmask_irq(struct irq_data *d)
 {
+	unsigned int irq_nr = d->irq;
+
 	if ((PNX8550_INT_CP0_MIN <= irq_nr) && (irq_nr <= PNX8550_INT_CP0_MAX)) {
 		modify_cp0_intmask(0, 1 << irq_nr);
 	} else if ((PNX8550_INT_GIC_MIN <= irq_nr) &&
@@ -157,10 +161,8 @@ int pnx8550_set_gic_priority(int irq, in
 
 static struct irq_chip level_irq_type = {
 	.name =		"PNX Level IRQ",
-	.ack =		mask_irq,
-	.mask =		mask_irq,
-	.mask_ack =	mask_irq,
-	.unmask =	unmask_irq,
+	.irq_mask =	mask_irq,
+	.irq_unmask =	unmask_irq,
 };
 
 static struct irqaction gic_action = {
@@ -180,10 +182,8 @@ void __init arch_init_irq(void)
 	int i;
 	int configPR;
 
-	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++) {
+	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++)
 		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
-		mask_irq(i);	/* mask the irq just in case  */
-	}
 
 	/* init of GIC/IPC interrupts */
 	/* should be done before cp0 since cp0 init enables the GIC int */
