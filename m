Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:20:14 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491931Ab1CWVJQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:16 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIk-0001wn-Q6; Wed, 23 Mar 2011 22:09:11 +0100
Message-Id: <20110323210537.314501714@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:10 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 29/38] mips: rb532: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-rb532.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/rb532/irq.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Index: linux-mips-next/arch/mips/rb532/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/rb532/irq.c
+++ linux-mips-next/arch/mips/rb532/irq.c
@@ -111,10 +111,10 @@ static inline void ack_local_irq(unsigne
 	clear_c0_cause(ipnum);
 }
 
-static void rb532_enable_irq(unsigned int irq_nr)
+static void rb532_enable_irq(struct irq_data *d)
 {
+	unsigned int group, intr_bit, irq_nr = d->irq;
 	int ip = irq_nr - GROUP0_IRQ_BASE;
-	unsigned int group, intr_bit;
 	volatile unsigned int *addr;
 
 	if (ip < 0)
@@ -132,10 +132,10 @@ static void rb532_enable_irq(unsigned in
 	}
 }
 
-static void rb532_disable_irq(unsigned int irq_nr)
+static void rb532_disable_irq(struct irq_data *d)
 {
+	unsigned int group, intr_bit, mask, irq_nr = d->irq;
 	int ip = irq_nr - GROUP0_IRQ_BASE;
-	unsigned int group, intr_bit, mask;
 	volatile unsigned int *addr;
 
 	if (ip < 0) {
@@ -163,18 +163,18 @@ static void rb532_disable_irq(unsigned i
 	}
 }
 
-static void rb532_mask_and_ack_irq(unsigned int irq_nr)
+static void rb532_mask_and_ack_irq(struct irq_data *d)
 {
-	rb532_disable_irq(irq_nr);
-	ack_local_irq(group_to_ip(irq_to_group(irq_nr)));
+	rb532_disable_irq(d);
+	ack_local_irq(group_to_ip(irq_to_group(d->irq)));
 }
 
-static int rb532_set_type(unsigned int irq_nr, unsigned type)
+static int rb532_set_type(struct irq_data *d,  unsigned type)
 {
-	int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
-	int group = irq_to_group(irq_nr);
+	int gpio = d->irq - GPIO_MAPPED_IRQ_BASE;
+	int group = irq_to_group(d->irq);
 
-	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr > (GROUP4_IRQ_BASE + 13))
+	if (group != GPIO_MAPPED_IRQ_GROUP || d->irq > (GROUP4_IRQ_BASE + 13))
 		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
 
 	switch (type) {
@@ -193,11 +193,11 @@ static int rb532_set_type(unsigned int i
 
 static struct irq_chip rc32434_irq_type = {
 	.name		= "RB532",
-	.ack		= rb532_disable_irq,
-	.mask		= rb532_disable_irq,
-	.mask_ack	= rb532_mask_and_ack_irq,
-	.unmask		= rb532_enable_irq,
-	.set_type	= rb532_set_type,
+	.irq_ack	= rb532_disable_irq,
+	.irq_mask	= rb532_disable_irq,
+	.irq_mask_ack	= rb532_mask_and_ack_irq,
+	.irq_unmask	= rb532_enable_irq,
+	.irq_set_type	= rb532_set_type,
 };
 
 void __init arch_init_irq(void)
