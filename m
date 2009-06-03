Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:04:43 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55032 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022848AbZFCOCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:39 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id EAED41124091; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/8] bcm63xx: register gpiochip in prom
Date:	Wed,  3 Jun 2009 16:02:20 +0200
Message-Id: <1244037747-27144-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

This patch moves the gpiochip registration fro arch_initcall to
prom. This allows GPIO-based runtime board detection to be performed
earlier.

Original patch by Florian, changed to register gpio before calling
board_prom_init callback since we may want to use gpio inside it.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/gpio.c                          |    3 +--
 arch/mips/bcm63xx/prom.c                          |    4 ++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index b78d3fd..997fcaa 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -120,9 +120,8 @@ static struct gpio_chip bcm63xx_gpio_chip = {
 	.ngpio			= BCM63XX_GPIO_COUNT,
 };
 
-static int __init bcm63xx_gpio_init(void)
+int __init bcm63xx_gpio_init(void)
 {
 	printk(KERN_INFO "registering %d GPIOs\n", BCM63XX_GPIO_COUNT);
 	return gpiochip_add(&bcm63xx_gpio_chip);
 }
-arch_initcall(bcm63xx_gpio_init);
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index d97ceed..386cb9a 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -13,6 +13,7 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
+#include <bcm63xx_gpio.h>
 
 void __init prom_init(void)
 {
@@ -38,6 +39,9 @@ void __init prom_init(void)
 	/* assign command line from kernel config */
 	strcpy(arcs_cmdline, CONFIG_CMDLINE);
 
+	/* register gpiochip */
+	bcm63xx_gpio_init();
+
 	/* do low level board init */
 	board_prom_init();
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 72cee75..7f5d8e8 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -1,6 +1,10 @@
 #ifndef BCM63XX_GPIO_H
 #define BCM63XX_GPIO_H
 
+#include <linux/init.h>
+
+int __init bcm63xx_gpio_init(void);
+
 /* all helpers will BUG() if gpio count is >= 37. */
 #define BCM63XX_GPIO_COUNT	37
 
-- 
1.6.0.4
