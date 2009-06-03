Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:05:08 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55035 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022864AbZFCOCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:39 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id E8243112408F; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/8] bcm63xx: register correct number of gpio for 6358.
Date:	Wed,  3 Jun 2009 16:02:21 +0200
Message-Id: <1244037747-27144-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

6358 has 40 gpio whereas 6348 has 37, so set the maximum number of
gpio at runtime.

Also remove NR_BUILTIN_GPIO which does not seem to be used anymore.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/gpio.c                          |    4 ++--
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |   12 ++++++++++--
 arch/mips/include/asm/mach-bcm63xx/gpio.h         |    2 --
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 997fcaa..97e3730 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -117,11 +117,11 @@ static struct gpio_chip bcm63xx_gpio_chip = {
 	.get			= bcm63xx_gpio_get,
 	.set			= bcm63xx_gpio_set,
 	.base			= 0,
-	.ngpio			= BCM63XX_GPIO_COUNT,
 };
 
 int __init bcm63xx_gpio_init(void)
 {
-	printk(KERN_INFO "registering %d GPIOs\n", BCM63XX_GPIO_COUNT);
+	bcm63xx_gpio_chip.ngpio = bcm63xx_gpio_count();
+	printk(KERN_INFO "registering %d GPIOs\n", bcm63xx_gpio_chip.ngpio);
 	return gpiochip_add(&bcm63xx_gpio_chip);
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 7f5d8e8..76a0b72 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -5,8 +5,16 @@
 
 int __init bcm63xx_gpio_init(void);
 
-/* all helpers will BUG() if gpio count is >= 37. */
-#define BCM63XX_GPIO_COUNT	37
+static inline unsigned long bcm63xx_gpio_count(void)
+{
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6358_CPU_ID:
+		return 40;
+	case BCM6348_CPU_ID:
+	default:
+		return 37;
+	}
+}
 
 #define GPIO_DIR_OUT	0x0
 #define GPIO_DIR_IN	0x1
diff --git a/arch/mips/include/asm/mach-bcm63xx/gpio.h b/arch/mips/include/asm/mach-bcm63xx/gpio.h
index 033c997..7cda8c0 100644
--- a/arch/mips/include/asm/mach-bcm63xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/gpio.h
@@ -3,8 +3,6 @@
 
 #include <bcm63xx_gpio.h>
 
-#define NR_BUILTIN_GPIO		BCM63XX_GPIO_COUNT
-
 #define gpio_to_irq(gpio)	NULL
 
 #define gpio_get_value __gpio_get_value
-- 
1.6.0.4
