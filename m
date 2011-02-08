Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2011 03:33:26 +0100 (CET)
Received: from smtp-out-214.synserver.de ([212.40.185.214]:1082 "HELO
        smtp-out-214.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492000Ab1BHCdU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Feb 2011 03:33:20 +0100
Received: (qmail 4974 invoked by uid 0); 8 Feb 2011 02:33:18 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 4605
Received: from e177158163.adsl.alicedsl.de (HELO lars-laptop.nons.lan) [85.177.158.163]
  by 217.119.54.81 with SMTP; 8 Feb 2011 02:33:18 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] MIPS: JZ4740: GPIO: Use shared irq chip for all gpios
Date:   Tue,  8 Feb 2011 03:34:18 +0100
Message-Id: <1297132458-16883-2-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1297132458-16883-1-git-send-email-lars@metafoo.de>
References: <1297132458-16883-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Currently there is one irq_chip per gpio_chip with the only difference being the
name.
Since the information whether the irq belong to GPIO bank A, B, C or D is not
that important rewrite the code to simply use a single irq_chip for all
gpio_chips.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/gpio.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 1e28b75..9bb0770 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -86,7 +86,6 @@ struct jz_gpio_chip {
 	spinlock_t lock;
 
 	struct gpio_chip gpio_chip;
-	struct irq_chip irq_chip;
 	struct sys_device sysdev;
 };
 
@@ -435,6 +434,17 @@ static int jz_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
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
@@ -453,16 +463,6 @@ static struct lock_class_key gpio_lock_class;
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
@@ -529,7 +529,8 @@ static int jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
 	for (irq = chip->irq_base; irq < chip->irq_base + chip->gpio_chip.ngpio; ++irq) {
 		lockdep_set_class(&irq_desc[irq].lock, &gpio_lock_class);
 		set_irq_chip_data(irq, chip);
-		set_irq_chip_and_handler(irq, &chip->irq_chip, handle_level_irq);
+		set_irq_chip_and_handler(irq, &jz_gpio_irq_chip,
+			handle_level_irq);
 	}
 
 	return 0;
-- 
1.7.2.3
