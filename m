Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:20:37 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47491 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491932Ab1CWVJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:17 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIl-0001wq-I5; Wed, 23 Mar 2011 22:09:12 +0100
Message-Id: <20110323210537.407889905@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:11 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 30/38] mips: sgi-ip22: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-sgi-ip22.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/sgi-ip22/ip22-int.c |   60 ++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

Index: linux-mips-next/arch/mips/sgi-ip22/ip22-int.c
===================================================================
--- linux-mips-next.orig/arch/mips/sgi-ip22/ip22-int.c
+++ linux-mips-next/arch/mips/sgi-ip22/ip22-int.c
@@ -31,88 +31,80 @@ static char lc3msk_to_irqnr[256];
 
 extern int ip22_eisa_init(void);
 
-static void enable_local0_irq(unsigned int irq)
+static void enable_local0_irq(struct irq_data *d)
 {
 	/* don't allow mappable interrupt to be enabled from setup_irq,
 	 * we have our own way to do so */
-	if (irq != SGI_MAP_0_IRQ)
-		sgint->imask0 |= (1 << (irq - SGINT_LOCAL0));
+	if (d->irq != SGI_MAP_0_IRQ)
+		sgint->imask0 |= (1 << (d->irq - SGINT_LOCAL0));
 }
 
-static void disable_local0_irq(unsigned int irq)
+static void disable_local0_irq(struct irq_data *d)
 {
-	sgint->imask0 &= ~(1 << (irq - SGINT_LOCAL0));
+	sgint->imask0 &= ~(1 << (d->irq - SGINT_LOCAL0));
 }
 
 static struct irq_chip ip22_local0_irq_type = {
 	.name		= "IP22 local 0",
-	.ack		= disable_local0_irq,
-	.mask		= disable_local0_irq,
-	.mask_ack	= disable_local0_irq,
-	.unmask		= enable_local0_irq,
+	.irq_mask	= disable_local0_irq,
+	.irq_unmask	= enable_local0_irq,
 };
 
-static void enable_local1_irq(unsigned int irq)
+static void enable_local1_irq(struct irq_data *d)
 {
 	/* don't allow mappable interrupt to be enabled from setup_irq,
 	 * we have our own way to do so */
-	if (irq != SGI_MAP_1_IRQ)
-		sgint->imask1 |= (1 << (irq - SGINT_LOCAL1));
+	if (d->irq != SGI_MAP_1_IRQ)
+		sgint->imask1 |= (1 << (d->irq - SGINT_LOCAL1));
 }
 
-static void disable_local1_irq(unsigned int irq)
+static void disable_local1_irq(struct irq_data *d)
 {
-	sgint->imask1 &= ~(1 << (irq - SGINT_LOCAL1));
+	sgint->imask1 &= ~(1 << (d->irq - SGINT_LOCAL1));
 }
 
 static struct irq_chip ip22_local1_irq_type = {
 	.name		= "IP22 local 1",
-	.ack		= disable_local1_irq,
-	.mask		= disable_local1_irq,
-	.mask_ack	= disable_local1_irq,
-	.unmask		= enable_local1_irq,
+	.irq_mask	= disable_local1_irq,
+	.irq_unmask	= enable_local1_irq,
 };
 
-static void enable_local2_irq(unsigned int irq)
+static void enable_local2_irq(struct irq_data *d)
 {
 	sgint->imask0 |= (1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
-	sgint->cmeimask0 |= (1 << (irq - SGINT_LOCAL2));
+	sgint->cmeimask0 |= (1 << (d->irq - SGINT_LOCAL2));
 }
 
-static void disable_local2_irq(unsigned int irq)
+static void disable_local2_irq(struct irq_data *d)
 {
-	sgint->cmeimask0 &= ~(1 << (irq - SGINT_LOCAL2));
+	sgint->cmeimask0 &= ~(1 << (d->irq - SGINT_LOCAL2));
 	if (!sgint->cmeimask0)
 		sgint->imask0 &= ~(1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
 }
 
 static struct irq_chip ip22_local2_irq_type = {
 	.name		= "IP22 local 2",
-	.ack		= disable_local2_irq,
-	.mask		= disable_local2_irq,
-	.mask_ack	= disable_local2_irq,
-	.unmask		= enable_local2_irq,
+	.irq_mask	= disable_local2_irq,
+	.irq_unmask	= enable_local2_irq,
 };
 
-static void enable_local3_irq(unsigned int irq)
+static void enable_local3_irq(struct irq_data *d)
 {
 	sgint->imask1 |= (1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
-	sgint->cmeimask1 |= (1 << (irq - SGINT_LOCAL3));
+	sgint->cmeimask1 |= (1 << (d->irq - SGINT_LOCAL3));
 }
 
-static void disable_local3_irq(unsigned int irq)
+static void disable_local3_irq(struct irq_data *d)
 {
-	sgint->cmeimask1 &= ~(1 << (irq - SGINT_LOCAL3));
+	sgint->cmeimask1 &= ~(1 << (d->irq - SGINT_LOCAL3));
 	if (!sgint->cmeimask1)
 		sgint->imask1 &= ~(1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
 }
 
 static struct irq_chip ip22_local3_irq_type = {
 	.name		= "IP22 local 3",
-	.ack		= disable_local3_irq,
-	.mask		= disable_local3_irq,
-	.mask_ack	= disable_local3_irq,
-	.unmask		= enable_local3_irq,
+	.irq_mask	= disable_local3_irq,
+	.irq_unmask	= enable_local3_irq,
 };
 
 static void indy_local0_irqdispatch(void)
