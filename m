Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:11:41 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47420 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491905Ab1CWVI6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:58 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIS-0001va-AO; Wed, 23 Mar 2011 22:08:52 +0100
Message-Id: <20110323210535.242147087@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 07/38] mips: emma: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-emma.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/emma/markeins/irq.c |   67 ++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

Index: linux-mips-next/arch/mips/emma/markeins/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/emma/markeins/irq.c
+++ linux-mips-next/arch/mips/emma/markeins/irq.c
@@ -34,13 +34,10 @@
 
 #include <asm/emma/emma2rh.h>
 
-static void emma2rh_irq_enable(unsigned int irq)
+static void emma2rh_irq_enable(struct irq_data *d)
 {
-	u32 reg_value;
-	u32 reg_bitmask;
-	u32 reg_index;
-
-	irq -= EMMA2RH_IRQ_BASE;
+	unsigned int irq = d->irq - EMMA2RH_IRQ_BASE;
+	u32 reg_value, reg_bitmask, reg_index;
 
 	reg_index = EMMA2RH_BHIF_INT_EN_0 +
 		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) * (irq / 32);
@@ -49,13 +46,10 @@ static void emma2rh_irq_enable(unsigned 
 	emma2rh_out32(reg_index, reg_value | reg_bitmask);
 }
 
-static void emma2rh_irq_disable(unsigned int irq)
+static void emma2rh_irq_disable(struct irq_data *d)
 {
-	u32 reg_value;
-	u32 reg_bitmask;
-	u32 reg_index;
-
-	irq -= EMMA2RH_IRQ_BASE;
+	unsigned int irq = d->irq - EMMA2RH_IRQ_BASE;
+	u32 reg_value, reg_bitmask, reg_index;
 
 	reg_index = EMMA2RH_BHIF_INT_EN_0 +
 		    (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0) * (irq / 32);
@@ -66,10 +60,8 @@ static void emma2rh_irq_disable(unsigned
 
 struct irq_chip emma2rh_irq_controller = {
 	.name = "emma2rh_irq",
-	.ack = emma2rh_irq_disable,
-	.mask = emma2rh_irq_disable,
-	.mask_ack = emma2rh_irq_disable,
-	.unmask = emma2rh_irq_enable,
+	.irq_mask = emma2rh_irq_disable,
+	.irq_unmask = emma2rh_irq_enable,
 };
 
 void emma2rh_irq_init(void)
@@ -82,23 +74,21 @@ void emma2rh_irq_init(void)
 					      handle_level_irq, "level");
 }
 
-static void emma2rh_sw_irq_enable(unsigned int irq)
+static void emma2rh_sw_irq_enable(struct irq_data *d)
 {
+	unsigned int irq = d->irq - EMMA2RH_SW_IRQ_BASE;
 	u32 reg;
 
-	irq -= EMMA2RH_SW_IRQ_BASE;
-
 	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
 	reg |= 1 << irq;
 	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
 }
 
-static void emma2rh_sw_irq_disable(unsigned int irq)
+static void emma2rh_sw_irq_disable(struct irq_data *d)
 {
+	unsigned int irq = d->irq - EMMA2RH_SW_IRQ_BASE;
 	u32 reg;
 
-	irq -= EMMA2RH_SW_IRQ_BASE;
-
 	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
 	reg &= ~(1 << irq);
 	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
@@ -106,10 +96,8 @@ static void emma2rh_sw_irq_disable(unsig
 
 struct irq_chip emma2rh_sw_irq_controller = {
 	.name = "emma2rh_sw_irq",
-	.ack = emma2rh_sw_irq_disable,
-	.mask = emma2rh_sw_irq_disable,
-	.mask_ack = emma2rh_sw_irq_disable,
-	.unmask = emma2rh_sw_irq_enable,
+	.irq_mask = emma2rh_sw_irq_disable,
+	.irq_unmask = emma2rh_sw_irq_enable,
 };
 
 void emma2rh_sw_irq_init(void)
@@ -122,39 +110,38 @@ void emma2rh_sw_irq_init(void)
 					      handle_level_irq, "level");
 }
 
-static void emma2rh_gpio_irq_enable(unsigned int irq)
+static void emma2rh_gpio_irq_enable(struct irq_data *d)
 {
+	unsigned int irq = d->irq - EMMA2RH_GPIO_IRQ_BASE;
 	u32 reg;
 
-	irq -= EMMA2RH_GPIO_IRQ_BASE;
-
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
 	reg |= 1 << irq;
 	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
-static void emma2rh_gpio_irq_disable(unsigned int irq)
+static void emma2rh_gpio_irq_disable(struct irq_data *d)
 {
+	unsigned int irq = d->irq - EMMA2RH_GPIO_IRQ_BASE;
 	u32 reg;
 
-	irq -= EMMA2RH_GPIO_IRQ_BASE;
-
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
 	reg &= ~(1 << irq);
 	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
 }
 
-static void emma2rh_gpio_irq_ack(unsigned int irq)
+static void emma2rh_gpio_irq_ack(struct irq_data *d)
 {
-	irq -= EMMA2RH_GPIO_IRQ_BASE;
+	unsigned int irq = d->irq - EMMA2RH_GPIO_IRQ_BASE;
+
 	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
 }
 
-static void emma2rh_gpio_irq_mask_ack(unsigned int irq)
+static void emma2rh_gpio_irq_mask_ack(struct irq_data *d)
 {
+	unsigned int irq = d->irq - EMMA2RH_GPIO_IRQ_BASE;
 	u32 reg;
 
-	irq -= EMMA2RH_GPIO_IRQ_BASE;
 	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
 
 	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
@@ -164,10 +151,10 @@ static void emma2rh_gpio_irq_mask_ack(un
 
 struct irq_chip emma2rh_gpio_irq_controller = {
 	.name = "emma2rh_gpio_irq",
-	.ack = emma2rh_gpio_irq_ack,
-	.mask = emma2rh_gpio_irq_disable,
-	.mask_ack = emma2rh_gpio_irq_mask_ack,
-	.unmask = emma2rh_gpio_irq_enable,
+	.irq_ack = emma2rh_gpio_irq_ack,
+	.irq_mask = emma2rh_gpio_irq_disable,
+	.irq_mask_ack = emma2rh_gpio_irq_mask_ack,
+	.irq_unmask = emma2rh_gpio_irq_enable,
 };
 
 void emma2rh_gpio_irq_init(void)
