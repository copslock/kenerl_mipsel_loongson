Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:12:52 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491908Ab1CWVJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:00 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIV-0001vk-BA; Wed, 23 Mar 2011 22:08:55 +0100
Message-Id: <20110323210535.525705907@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:54 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [patch 10/38] MIPS: JZ4740: GPIO: Use shared irq chip for all gpios
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline;
        filename=2-2-MIPS-JZ4740-GPIO-Use-shared-irq-chip-for-all-gpios.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Currently there is one irq_chip per gpio_chip with the only difference
being the name. Since the information whether the irq belong to GPIO
bank A, B, C or D is not that important rewrite the code to simply use
a single irq_chip for all gpio_chips.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
arch/mips/jz4740/gpio.c |   25 +++++++++++++------------
 arch/mips/jz4740/gpio.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

Index: linux-mips-next/arch/mips/jz4740/gpio.c
===================================================================
--- linux-mips-next.orig/arch/mips/jz4740/gpio.c
+++ linux-mips-next/arch/mips/jz4740/gpio.c
@@ -86,7 +86,6 @@ struct jz_gpio_chip {
 	spinlock_t lock;
 
 	struct gpio_chip gpio_chip;
-	struct irq_chip irq_chip;
 	struct sys_device sysdev;
 };
 
@@ -435,6 +434,17 @@ static int jz_gpio_irq_set_wake(struct i
 	return 0;
 }
 
+static struct irq_chip jz_gpio_irq_chip = {
+	.name = "GPIO",
+	.irq_mask = jz_gpio_irq_mask,
+	.irq_unmask = jz_gpio_irq_unmask,
+	.irq_ack = jz_gpio_irq_ack,
+	.irq_startup = jz_gpio_irq_startup,
+	.irq_shutdown = jz_gpio_irq_shutdown,
+	.irq_set_type = jz_gpio_irq_set_type,
+	.irq_set_wake = jz_gpio_irq_set_wake,
+};
+
 /*
  * This lock class tells lockdep that GPIO irqs are in a different
  * category than their parents, so it won't report false recursion.
@@ -453,16 +463,6 @@ static struct lock_class_key gpio_lock_c
 		.base = JZ4740_GPIO_BASE_ ## _bank, \
 		.ngpio = JZ4740_GPIO_NUM_ ## _bank, \
 	}, \
-	.irq_chip =  { \
-		.name = "GPIO Bank " # _bank, \
-		.irq_mask = jz_gpio_irq_mask, \
-		.irq_unmask = jz_gpio_irq_unmask, \
-		.irq_ack = jz_gpio_irq_ack, \
-		.irq_startup = jz_gpio_irq_startup, \
-		.irq_shutdown = jz_gpio_irq_shutdown, \
-		.irq_set_type = jz_gpio_irq_set_type, \
-		.irq_set_wake = jz_gpio_irq_set_wake, \
-	}, \
 }
 
 static struct jz_gpio_chip jz4740_gpio_chips[] = {
@@ -529,7 +529,8 @@ static int jz4740_gpio_chip_init(struct 
 	for (irq = chip->irq_base; irq < chip->irq_base + chip->gpio_chip.ngpio; ++irq) {
 		lockdep_set_class(&irq_desc[irq].lock, &gpio_lock_class);
 		set_irq_chip_data(irq, chip);
-		set_irq_chip_and_handler(irq, &chip->irq_chip, handle_level_irq);
+		set_irq_chip_and_handler(irq, &jz_gpio_irq_chip,
+			handle_level_irq);
 	}
 
 	return 0;
