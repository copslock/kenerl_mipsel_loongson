Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:13:15 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47434 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491909Ab1CWVJB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:01 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIW-0001vo-4Q; Wed, 23 Mar 2011 22:08:56 +0100
Message-Id: <20110323210535.621435051@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:55 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 11/38] mips: jz4740: Cleanup the mechanical irq_chip
        conversion 
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-jz4740-sigh.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

The conversion did not make use of the new chip flag which signals the
core code to mask the chip before calling the set_type callback. Sigh.
Use the new lockdep helper as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/jz4740/gpio.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

Index: linux-mips-next/arch/mips/jz4740/gpio.c
===================================================================
--- linux-mips-next.orig/arch/mips/jz4740/gpio.c
+++ linux-mips-next/arch/mips/jz4740/gpio.c
@@ -347,22 +347,14 @@ static void jz_gpio_irq_unmask(struct ir
 /* TODO: Check if function is gpio */
 static unsigned int jz_gpio_irq_startup(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-
 	jz_gpio_set_irq_bit(data, JZ_REG_GPIO_SELECT_SET);
-
-	desc->status &= ~IRQ_MASKED;
 	jz_gpio_irq_unmask(data);
-
 	return 0;
 }
 
 static void jz_gpio_irq_shutdown(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-
 	jz_gpio_irq_mask(data);
-	desc->status |= IRQ_MASKED;
 
 	/* Set direction to input */
 	jz_gpio_set_irq_bit(data, JZ_REG_GPIO_DIRECTION_CLEAR);
@@ -377,11 +369,8 @@ static void jz_gpio_irq_ack(struct irq_d
 static int jz_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 {
 	struct jz_gpio_chip *chip = irq_to_jz_gpio_chip(data);
-	struct irq_desc *desc = irq_to_desc(data->irq);
 	unsigned int irq = data->irq;
 
-	jz_gpio_irq_mask(data);
-
 	if (flow_type == IRQ_TYPE_EDGE_BOTH) {
 		uint32_t value = readl(chip->base + JZ_REG_GPIO_PIN);
 		if (value & IRQ_TO_BIT(irq))
@@ -414,9 +403,6 @@ static int jz_gpio_irq_set_type(struct i
 		return -EINVAL;
 	}
 
-	if (!(desc->status & IRQ_MASKED))
-		jz_gpio_irq_unmask(data);
-
 	return 0;
 }
 
@@ -443,6 +429,7 @@ static struct irq_chip jz_gpio_irq_chip 
 	.irq_shutdown = jz_gpio_irq_shutdown,
 	.irq_set_type = jz_gpio_irq_set_type,
 	.irq_set_wake = jz_gpio_irq_set_wake,
+	.flags = IRQCHIP_SET_TYPE_MASKED,
 };
 
 /*
@@ -527,7 +514,7 @@ static int jz4740_gpio_chip_init(struct 
 	set_irq_chained_handler(chip->irq, jz_gpio_irq_demux_handler);
 
 	for (irq = chip->irq_base; irq < chip->irq_base + chip->gpio_chip.ngpio; ++irq) {
-		lockdep_set_class(&irq_desc[irq].lock, &gpio_lock_class);
+		irq_set_lockdep_class(irq, &gpio_lock_class);
 		set_irq_chip_data(irq, chip);
 		set_irq_chip_and_handler(irq, &jz_gpio_irq_chip,
 			handle_level_irq);
