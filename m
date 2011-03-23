Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:10:05 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47408 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491895Ab1CWVIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:52 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIN-0001vO-CA; Wed, 23 Mar 2011 22:08:47 +0100
Message-Id: <20110323210534.857562090@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:47 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 03/38] mips: ath79: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-ath79.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/ath79/irq.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

Index: linux-mips-next/arch/mips/ath79/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/ath79/irq.c
+++ linux-mips-next/arch/mips/ath79/irq.c
@@ -62,13 +62,12 @@ static void ath79_misc_irq_handler(unsig
 		spurious_interrupt();
 }
 
-static void ar71xx_misc_irq_unmask(unsigned int irq)
+static void ar71xx_misc_irq_unmask(struct irq_data *d)
 {
+	unsigned int irq = d->irq - ATH79_MISC_IRQ_BASE;
 	void __iomem *base = ath79_reset_base;
 	u32 t;
 
-	irq -= ATH79_MISC_IRQ_BASE;
-
 	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 	__raw_writel(t | (1 << irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 
@@ -76,13 +75,12 @@ static void ar71xx_misc_irq_unmask(unsig
 	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 }
 
-static void ar71xx_misc_irq_mask(unsigned int irq)
+static void ar71xx_misc_irq_mask(struct irq_data *d)
 {
+	unsigned int irq = d->irq - ATH79_MISC_IRQ_BASE;
 	void __iomem *base = ath79_reset_base;
 	u32 t;
 
-	irq -= ATH79_MISC_IRQ_BASE;
-
 	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 
@@ -90,13 +88,12 @@ static void ar71xx_misc_irq_mask(unsigne
 	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 }
 
-static void ar724x_misc_irq_ack(unsigned int irq)
+static void ar724x_misc_irq_ack(struct irq_data *d)
 {
+	unsigned int irq = d->irq - ATH79_MISC_IRQ_BASE;
 	void __iomem *base = ath79_reset_base;
 	u32 t;
 
-	irq -= ATH79_MISC_IRQ_BASE;
-
 	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
 	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_MISC_INT_STATUS);
 
@@ -106,8 +103,8 @@ static void ar724x_misc_irq_ack(unsigned
 
 static struct irq_chip ath79_misc_irq_chip = {
 	.name		= "MISC",
-	.unmask		= ar71xx_misc_irq_unmask,
-	.mask		= ar71xx_misc_irq_mask,
+	.irq_unmask	= ar71xx_misc_irq_unmask,
+	.irq_mask	= ar71xx_misc_irq_mask,
 };
 
 static void __init ath79_misc_irq_init(void)
@@ -119,9 +116,9 @@ static void __init ath79_misc_irq_init(v
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
 
 	if (soc_is_ar71xx() || soc_is_ar913x())
-		ath79_misc_irq_chip.mask_ack = ar71xx_misc_irq_mask;
+		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
 	else if (soc_is_ar724x())
-		ath79_misc_irq_chip.ack = ar724x_misc_irq_ack;
+		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
 	else
 		BUG();
 
