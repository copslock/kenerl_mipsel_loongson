Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:19:02 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491928Ab1CWVJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:14 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIi-0001we-CQ; Wed, 23 Mar 2011 22:09:08 +0100
Message-Id: <20110323210537.032118649@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:08 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 26/38] mips: pnx83xx: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-pnx83xx.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/pnx833x/common/interrupts.c |   98 +++++-----------------------------
 1 file changed, 16 insertions(+), 82 deletions(-)

Index: linux-mips-next/arch/mips/pnx833x/common/interrupts.c
===================================================================
--- linux-mips-next.orig/arch/mips/pnx833x/common/interrupts.c
+++ linux-mips-next/arch/mips/pnx833x/common/interrupts.c
@@ -152,10 +152,6 @@ static inline void pnx833x_hard_disable_
 	PNX833X_PIC_INT_REG(irq) = 0;
 }
 
-static int irqflags[PNX833X_PIC_NUM_IRQ];	/* initialized by zeroes */
-#define IRQFLAG_STARTED		1
-#define IRQFLAG_DISABLED	2
-
 static DEFINE_RAW_SPINLOCK(pnx833x_irq_lock);
 
 static unsigned int pnx833x_startup_pic_irq(unsigned int irq)
@@ -164,108 +160,54 @@ static unsigned int pnx833x_startup_pic_
 	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
 
 	raw_spin_lock_irqsave(&pnx833x_irq_lock, flags);
-
-	irqflags[pic_irq] = IRQFLAG_STARTED;	/* started, not disabled */
 	pnx833x_hard_enable_pic_irq(pic_irq);
-
 	raw_spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
 	return 0;
 }
 
-static void pnx833x_shutdown_pic_irq(unsigned int irq)
-{
-	unsigned long flags;
-	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
-
-	raw_spin_lock_irqsave(&pnx833x_irq_lock, flags);
-
-	irqflags[pic_irq] = 0;			/* not started */
-	pnx833x_hard_disable_pic_irq(pic_irq);
-
-	raw_spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
-}
-
-static void pnx833x_enable_pic_irq(unsigned int irq)
+static void pnx833x_enable_pic_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+	unsigned int pic_irq = d->irq - PNX833X_PIC_IRQ_BASE;
 
 	raw_spin_lock_irqsave(&pnx833x_irq_lock, flags);
-
-	irqflags[pic_irq] &= ~IRQFLAG_DISABLED;
-	if (irqflags[pic_irq] == IRQFLAG_STARTED)
-		pnx833x_hard_enable_pic_irq(pic_irq);
-
+	pnx833x_hard_enable_pic_irq(pic_irq);
 	raw_spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
 }
 
-static void pnx833x_disable_pic_irq(unsigned int irq)
+static void pnx833x_disable_pic_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+	unsigned int pic_irq = d->irq - PNX833X_PIC_IRQ_BASE;
 
 	raw_spin_lock_irqsave(&pnx833x_irq_lock, flags);
-
-	irqflags[pic_irq] |= IRQFLAG_DISABLED;
 	pnx833x_hard_disable_pic_irq(pic_irq);
-
 	raw_spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
 }
 
-static void pnx833x_ack_pic_irq(unsigned int irq)
-{
-}
-
-static void pnx833x_end_pic_irq(unsigned int irq)
-{
-}
-
 static DEFINE_RAW_SPINLOCK(pnx833x_gpio_pnx833x_irq_lock);
 
-static unsigned int pnx833x_startup_gpio_irq(unsigned int irq)
-{
-	int pin = irq - PNX833X_GPIO_IRQ_BASE;
-	unsigned long flags;
-	raw_spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
-	pnx833x_gpio_enable_irq(pin);
-	raw_spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
-	return 0;
-}
-
-static void pnx833x_enable_gpio_irq(unsigned int irq)
+static void pnx833x_enable_gpio_irq(struct irq_data *d)
 {
-	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	int pin = d->irq - PNX833X_GPIO_IRQ_BASE;
 	unsigned long flags;
 	raw_spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
 	pnx833x_gpio_enable_irq(pin);
 	raw_spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
 }
 
-static void pnx833x_disable_gpio_irq(unsigned int irq)
+static void pnx833x_disable_gpio_irq(struct irq_data *d)
 {
-	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	int pin = d->irq - PNX833X_GPIO_IRQ_BASE;
 	unsigned long flags;
 	raw_spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
 	pnx833x_gpio_disable_irq(pin);
 	raw_spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
 }
 
-static void pnx833x_ack_gpio_irq(unsigned int irq)
-{
-}
-
-static void pnx833x_end_gpio_irq(unsigned int irq)
-{
-	int pin = irq - PNX833X_GPIO_IRQ_BASE;
-	unsigned long flags;
-	raw_spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
-	pnx833x_gpio_clear_irq(pin);
-	raw_spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
-}
-
-static int pnx833x_set_type_gpio_irq(unsigned int irq, unsigned int flow_type)
+static int pnx833x_set_type_gpio_irq(struct irq_data *d, unsigned int flow_type)
 {
-	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	int pin = d->irq - PNX833X_GPIO_IRQ_BASE;
 	int gpio_mode;
 
 	switch (flow_type) {
@@ -296,23 +238,15 @@ static int pnx833x_set_type_gpio_irq(uns
 
 static struct irq_chip pnx833x_pic_irq_type = {
 	.name = "PNX-PIC",
-	.startup = pnx833x_startup_pic_irq,
-	.shutdown = pnx833x_shutdown_pic_irq,
-	.enable = pnx833x_enable_pic_irq,
-	.disable = pnx833x_disable_pic_irq,
-	.ack = pnx833x_ack_pic_irq,
-	.end = pnx833x_end_pic_irq
+	.irq_enable = pnx833x_enable_pic_irq,
+	.irq_disable = pnx833x_disable_pic_irq,
 };
 
 static struct irq_chip pnx833x_gpio_irq_type = {
 	.name = "PNX-GPIO",
-	.startup = pnx833x_startup_gpio_irq,
-	.shutdown = pnx833x_disable_gpio_irq,
-	.enable = pnx833x_enable_gpio_irq,
-	.disable = pnx833x_disable_gpio_irq,
-	.ack = pnx833x_ack_gpio_irq,
-	.end = pnx833x_end_gpio_irq,
-	.set_type = pnx833x_set_type_gpio_irq
+	.irq_enable = pnx833x_enable_gpio_irq,
+	.irq_disable = pnx833x_disable_gpio_irq,
+	.irq_set_type = pnx833x_set_type_gpio_irq,
 };
 
 void __init arch_init_irq(void)
