Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:18:14 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47473 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491927Ab1CWVJL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:11 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIg-0001wY-D4; Wed, 23 Mar 2011 22:09:06 +0100
Message-Id: <20110323210536.844422938@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:06 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 24/38] mips: loongson: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-loongson.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/loongson/common/bonito-irq.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-mips-next/arch/mips/loongson/common/bonito-irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/loongson/common/bonito-irq.c
+++ linux-mips-next/arch/mips/loongson/common/bonito-irq.c
@@ -16,24 +16,22 @@
 
 #include <loongson.h>
 
-static inline void bonito_irq_enable(unsigned int irq)
+static inline void bonito_irq_enable(struct irq_data *d)
 {
-	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
+	LOONGSON_INTENSET = (1 << (d->irq - LOONGSON_IRQ_BASE));
 	mmiowb();
 }
 
-static inline void bonito_irq_disable(unsigned int irq)
+static inline void bonito_irq_disable(struct irq_data *d)
 {
-	LOONGSON_INTENCLR = (1 << (irq - LOONGSON_IRQ_BASE));
+	LOONGSON_INTENCLR = (1 << (d->irq - LOONGSON_IRQ_BASE));
 	mmiowb();
 }
 
 static struct irq_chip bonito_irq_type = {
-	.name	= "bonito_irq",
-	.ack	= bonito_irq_disable,
-	.mask	= bonito_irq_disable,
-	.mask_ack = bonito_irq_disable,
-	.unmask	= bonito_irq_enable,
+	.name		= "bonito_irq",
+	.irq_mask	= bonito_irq_disable,
+	.irq_unmask	= bonito_irq_enable,
 };
 
 static struct irqaction __maybe_unused dma_timeout_irqaction = {
