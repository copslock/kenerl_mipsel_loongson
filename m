Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:22:59 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491943Ab1CWVJX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:23 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIs-0001xE-6M; Wed, 23 Mar 2011 22:09:18 +0100
Message-Id: <20110323210537.974509447@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:17 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 36/38] mips: vr41: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-vr41.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/vr41xx/common/icu.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

Index: linux-mips-next/arch/mips/vr41xx/common/icu.c
===================================================================
--- linux-mips-next.orig/arch/mips/vr41xx/common/icu.c
+++ linux-mips-next/arch/mips/vr41xx/common/icu.c
@@ -442,40 +442,36 @@ void vr41xx_disable_bcuint(void)
 
 EXPORT_SYMBOL(vr41xx_disable_bcuint);
 
-static void disable_sysint1_irq(unsigned int irq)
+static void disable_sysint1_irq(struct irq_data *d)
 {
-	icu1_clear(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_clear(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(d->irq));
 }
 
-static void enable_sysint1_irq(unsigned int irq)
+static void enable_sysint1_irq(struct irq_data *d)
 {
-	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(d->irq));
 }
 
 static struct irq_chip sysint1_irq_type = {
 	.name		= "SYSINT1",
-	.ack		= disable_sysint1_irq,
-	.mask		= disable_sysint1_irq,
-	.mask_ack	= disable_sysint1_irq,
-	.unmask		= enable_sysint1_irq,
+	.irq_mask	= disable_sysint1_irq,
+	.irq_unmask	= enable_sysint1_irq,
 };
 
-static void disable_sysint2_irq(unsigned int irq)
+static void disable_sysint2_irq(struct irq_data *d)
 {
-	icu2_clear(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_clear(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(d->irq));
 }
 
-static void enable_sysint2_irq(unsigned int irq)
+static void enable_sysint2_irq(struct irq_data *d)
 {
-	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(d->irq));
 }
 
 static struct irq_chip sysint2_irq_type = {
 	.name		= "SYSINT2",
-	.ack		= disable_sysint2_irq,
-	.mask		= disable_sysint2_irq,
-	.mask_ack	= disable_sysint2_irq,
-	.unmask		= enable_sysint2_irq,
+	.irq_mask	= disable_sysint2_irq,
+	.irq_unmask	= enable_sysint2_irq,
 };
 
 static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
