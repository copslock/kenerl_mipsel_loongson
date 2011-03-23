Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:09:41 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491894Ab1CWVIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:52 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIM-0001vL-J5; Wed, 23 Mar 2011 22:08:46 +0100
Message-Id: <20110323210534.763405783@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:46 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 02/38] mips: ar7: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mipsar7.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/ar7/irq.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

Index: linux-mips-next/arch/mips/ar7/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/ar7/irq.c
+++ linux-mips-next/arch/mips/ar7/irq.c
@@ -49,51 +49,51 @@
 
 static int ar7_irq_base;
 
-static void ar7_unmask_irq(unsigned int irq)
+static void ar7_unmask_irq(struct irq_data *d)
 {
-	writel(1 << ((irq - ar7_irq_base) % 32),
-	       REG(ESR_OFFSET(irq - ar7_irq_base)));
+	writel(1 << ((d->irq - ar7_irq_base) % 32),
+	       REG(ESR_OFFSET(d->irq - ar7_irq_base)));
 }
 
-static void ar7_mask_irq(unsigned int irq)
+static void ar7_mask_irq(struct irq_data *d)
 {
-	writel(1 << ((irq - ar7_irq_base) % 32),
-	       REG(ECR_OFFSET(irq - ar7_irq_base)));
+	writel(1 << ((d->irq - ar7_irq_base) % 32),
+	       REG(ECR_OFFSET(d->irq - ar7_irq_base)));
 }
 
-static void ar7_ack_irq(unsigned int irq)
+static void ar7_ack_irq(struct irq_data *d)
 {
-	writel(1 << ((irq - ar7_irq_base) % 32),
-	       REG(CR_OFFSET(irq - ar7_irq_base)));
+	writel(1 << ((d->irq - ar7_irq_base) % 32),
+	       REG(CR_OFFSET(d->irq - ar7_irq_base)));
 }
 
-static void ar7_unmask_sec_irq(unsigned int irq)
+static void ar7_unmask_sec_irq(struct irq_data *d)
 {
-	writel(1 << (irq - ar7_irq_base - 40), REG(SEC_ESR_OFFSET));
+	writel(1 << (d->irq - ar7_irq_base - 40), REG(SEC_ESR_OFFSET));
 }
 
-static void ar7_mask_sec_irq(unsigned int irq)
+static void ar7_mask_sec_irq(struct irq_data *d)
 {
-	writel(1 << (irq - ar7_irq_base - 40), REG(SEC_ECR_OFFSET));
+	writel(1 << (d->irq - ar7_irq_base - 40), REG(SEC_ECR_OFFSET));
 }
 
-static void ar7_ack_sec_irq(unsigned int irq)
+static void ar7_ack_sec_irq(struct irq_data *d)
 {
-	writel(1 << (irq - ar7_irq_base - 40), REG(SEC_CR_OFFSET));
+	writel(1 << (d->irq - ar7_irq_base - 40), REG(SEC_CR_OFFSET));
 }
 
 static struct irq_chip ar7_irq_type = {
 	.name = "AR7",
-	.unmask = ar7_unmask_irq,
-	.mask = ar7_mask_irq,
-	.ack = ar7_ack_irq
+	.irq_unmask = ar7_unmask_irq,
+	.irq_mask = ar7_mask_irq,
+	.irq_ack = ar7_ack_irq
 };
 
 static struct irq_chip ar7_sec_irq_type = {
 	.name = "AR7",
-	.unmask = ar7_unmask_sec_irq,
-	.mask = ar7_mask_sec_irq,
-	.ack = ar7_ack_sec_irq,
+	.irq_unmask = ar7_unmask_sec_irq,
+	.irq_mask = ar7_mask_sec_irq,
+	.irq_ack = ar7_ack_sec_irq,
 };
 
 static struct irqaction ar7_cascade_action = {
