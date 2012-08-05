Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Aug 2012 13:13:38 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36877 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903589Ab2HELM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Aug 2012 13:12:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A8E968E1C;
        Sun,  5 Aug 2012 13:12:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WT1oQqWFtsQQ; Sun,  5 Aug 2012 13:12:20 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id AE34F8F61;
        Sun,  5 Aug 2012 13:12:16 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
Date:   Sun,  5 Aug 2012 13:12:03 +0200
Message-Id: <1344165123-4640-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344165123-4640-1-git-send-email-hauke@hauke-m.de>
References: <1344165123-4640-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The original implementation implemented functions like gpio_request()
itself, but it missed some new functions added to the GPIO interface.
This caused compile problems for some drivers using some of the special
request methods which where not implemented. Now it uses gpiolib and
this implements all the request methods needed.

The raw GPIO register access methods like bcm47xx_gpio_in() are
exported, because some special drivers for this target, not yet in
mainline, need them.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig                            |    2 +-
 arch/mips/bcm47xx/gpio.c                     |  208 ++++++++++++++++++++------
 arch/mips/bcm47xx/setup.c                    |    2 +
 arch/mips/bcm47xx/wgt634u.c                  |    7 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    2 +
 arch/mips/include/asm/mach-bcm47xx/gpio.h    |  151 +++----------------
 6 files changed, 197 insertions(+), 175 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 331d574..2f9bba9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -100,6 +100,7 @@ config ATH79
 
 config BCM47XX
 	bool "Broadcom BCM47XX based boards"
+	select ARCH_REQUIRE_GPIOLIB
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
@@ -107,7 +108,6 @@ config BCM47XX
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_GPIO
 	select SYS_HAS_EARLY_PRINTK
 	select CFE
 	help
diff --git a/arch/mips/bcm47xx/gpio.c b/arch/mips/bcm47xx/gpio.c
index 5ebdf62..d927002 100644
--- a/arch/mips/bcm47xx/gpio.c
+++ b/arch/mips/bcm47xx/gpio.c
@@ -4,81 +4,198 @@
  * for more details.
  *
  * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ * Copyright (C) 2012 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Parts of this file are based on Atheros AR71XX/AR724X/AR913X GPIO
  */
 
 #include <linux/export.h>
+#include <linux/gpio.h>
 #include <linux/ssb/ssb.h>
-#include <linux/ssb/ssb_driver_chipcommon.h>
-#include <linux/ssb/ssb_driver_extif.h>
-#include <asm/mach-bcm47xx/bcm47xx.h>
-#include <asm/mach-bcm47xx/gpio.h>
+#include <linux/ssb/ssb_embedded.h>
+#include <linux/bcma/bcma.h>
+#include <linux/bcma/bcma_driver_gpio.h>
+
+#include <bcm47xx.h>
 
-#if (BCM47XX_CHIPCO_GPIO_LINES > BCM47XX_EXTIF_GPIO_LINES)
-static DECLARE_BITMAP(gpio_in_use, BCM47XX_CHIPCO_GPIO_LINES);
-#else
-static DECLARE_BITMAP(gpio_in_use, BCM47XX_EXTIF_GPIO_LINES);
-#endif
 
-int gpio_request(unsigned gpio, const char *tag)
+static unsigned long bcm47xx_gpio_count;
+
+/* low level BCM47xx gpio api */
+u32 bcm47xx_gpio_in(u32 mask)
 {
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		if (ssb_chipco_available(&bcm47xx_bus.ssb.chipco) &&
-		    ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES))
-			return -EINVAL;
-
-		if (ssb_extif_available(&bcm47xx_bus.ssb.extif) &&
-		    ((unsigned)gpio >= BCM47XX_EXTIF_GPIO_LINES))
-			return -EINVAL;
+		return ssb_gpio_in(&bcm47xx_bus.ssb, mask);
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		return bcma_gpio_in(&bcm47xx_bus.bcma.bus, mask);
+#endif
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(bcm47xx_gpio_in);
 
-		if (test_and_set_bit(gpio, gpio_in_use))
-			return -EBUSY;
+u32 bcm47xx_gpio_out(u32 mask, u32 value)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		return ssb_gpio_out(&bcm47xx_bus.ssb, mask, value);
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		return bcma_gpio_out(&bcm47xx_bus.bcma.bus, mask, value);
+#endif
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(bcm47xx_gpio_out);
 
-		return 0;
+u32 bcm47xx_gpio_outen(u32 mask, u32 value)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		return ssb_gpio_outen(&bcm47xx_bus.ssb, mask, value);
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
-		if (gpio >= BCM47XX_CHIPCO_GPIO_LINES)
-			return -EINVAL;
+		return bcma_gpio_outen(&bcm47xx_bus.bcma.bus, mask, value);
+#endif
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(bcm47xx_gpio_outen);
 
-		if (test_and_set_bit(gpio, gpio_in_use))
-			return -EBUSY;
+u32 bcm47xx_gpio_control(u32 mask, u32 value)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		return ssb_gpio_control(&bcm47xx_bus.ssb, mask, value);
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		return bcma_gpio_control(&bcm47xx_bus.bcma.bus, mask, value);
+#endif
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(bcm47xx_gpio_control);
 
-		return 0;
+u32 bcm47xx_gpio_intmask(u32 mask, u32 value)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		return ssb_gpio_intmask(&bcm47xx_bus.ssb, mask, value);
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		return bcma_gpio_intmask(&bcm47xx_bus.bcma.bus, mask, value);
 #endif
 	}
 	return -EINVAL;
 }
-EXPORT_SYMBOL(gpio_request);
+EXPORT_SYMBOL(bcm47xx_gpio_intmask);
 
-void gpio_free(unsigned gpio)
+u32 bcm47xx_gpio_polarity(u32 mask, u32 value)
 {
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		if (ssb_chipco_available(&bcm47xx_bus.ssb.chipco) &&
-		    ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES))
-			return;
+		return ssb_gpio_polarity(&bcm47xx_bus.ssb, mask, value);
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		return bcma_gpio_polarity(&bcm47xx_bus.bcma.bus, mask, value);
+#endif
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(bcm47xx_gpio_polarity);
+
+
+
+static int bcm47xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
+{
+	return bcm47xx_gpio_in(1 << gpio);
+}
+
+static void bcm47xx_gpio_set_value(struct gpio_chip *chip,
+				   unsigned gpio, int value)
+{
+	bcm47xx_gpio_out(1 << gpio, value ? 1 << gpio : 0);
+}
+
+static int bcm47xx_gpio_direction_input(struct gpio_chip *chip,
+					unsigned gpio)
+{
+	bcm47xx_gpio_outen(1 << gpio, 0);
+	return 0;
+}
+
+static int bcm47xx_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned gpio, int value)
+{
+	/* first set the gpio out value */
+	bcm47xx_gpio_out(1 << gpio, value ? 1 << gpio : 0);
+	/* then set the gpio mode */
+	bcm47xx_gpio_outen(1 << gpio, 1 << gpio);
+	return 0;
+}
+
+static struct gpio_chip bcm47xx_gpio_chip = {
+	.label			= "bcm47xx",
+	.get			= bcm47xx_gpio_get_value,
+	.set			= bcm47xx_gpio_set_value,
+	.direction_input	= bcm47xx_gpio_direction_input,
+	.direction_output	= bcm47xx_gpio_direction_output,
+	.base			= 0,
+};
 
-		if (ssb_extif_available(&bcm47xx_bus.ssb.extif) &&
-		    ((unsigned)gpio >= BCM47XX_EXTIF_GPIO_LINES))
-			return;
+void __init bcm47xx_gpio_init(void)
+{
+	int err;
 
-		clear_bit(gpio, gpio_in_use);
-		return;
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		bcm47xx_gpio_count = ssb_gpio_count(&bcm47xx_bus.ssb);
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
-		if (gpio >= BCM47XX_CHIPCO_GPIO_LINES)
-			return;
-
-		clear_bit(gpio, gpio_in_use);
-		return;
+		bcm47xx_gpio_count = bcma_gpio_count(&bcm47xx_bus.bcma.bus);
 #endif
 	}
+
+	bcm47xx_gpio_chip.ngpio = bcm47xx_gpio_count;
+
+	err = gpiochip_add(&bcm47xx_gpio_chip);
+	if (err)
+		panic("cannot add BCM47xx GPIO chip, error=%d", err);
 }
-EXPORT_SYMBOL(gpio_free);
+
+int gpio_get_value(unsigned gpio)
+{
+	if (gpio < bcm47xx_gpio_count)
+		return bcm47xx_gpio_in(1 << gpio);
+
+	return __gpio_get_value(gpio);
+}
+EXPORT_SYMBOL(gpio_get_value);
+
+void gpio_set_value(unsigned gpio, int value)
+{
+	if (gpio < bcm47xx_gpio_count)
+		bcm47xx_gpio_out(1 << gpio, value ? 1 << gpio : 0);
+	else
+		__gpio_set_value(gpio, value);
+}
+EXPORT_SYMBOL(gpio_set_value);
 
 int gpio_to_irq(unsigned gpio)
 {
@@ -99,4 +216,11 @@ int gpio_to_irq(unsigned gpio)
 	}
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(gpio_to_irq);
+EXPORT_SYMBOL(gpio_to_irq);
+
+int irq_to_gpio(unsigned irq)
+{
+	/* FIXME */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(irq_to_gpio);
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 95bf4d7..2936532 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -220,6 +220,8 @@ void __init plat_mem_setup(void)
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
 	pm_power_off = bcm47xx_machine_halt;
+
+	bcm47xx_gpio_init();
 }
 
 static int __init bcm47xx_register_bus_complete(void)
diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
index e9f9ec8..fd1066e 100644
--- a/arch/mips/bcm47xx/wgt634u.c
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -133,6 +133,7 @@ static int __init wgt634u_init(void)
 	 * been allocated ranges 00:09:5b:xx:xx:xx and 00:0f:b5:xx:xx:xx.
 	 */
 	u8 *et0mac;
+	int err;
 
 	if (bcm47xx_bus_type != BCM47XX_BUS_TYPE_SSB)
 		return -ENODEV;
@@ -146,6 +147,12 @@ static int __init wgt634u_init(void)
 
 		printk(KERN_INFO "WGT634U machine detected.\n");
 
+		err = gpio_request(WGT634U_GPIO_RESET, "reset-buton");
+		if (err) {
+			printk(KERN_INFO "Can not register gpio for reset button\n");
+			return 0;
+		}
+
 		if (!request_irq(gpio_to_irq(WGT634U_GPIO_RESET),
 				 gpio_interrupt, IRQF_SHARED,
 				 "WGT634U GPIO", &bcm47xx_bus.ssb.chipco)) {
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 26fdaf4..1bd5560 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -56,4 +56,6 @@ void bcm47xx_fill_bcma_boardinfo(struct bcma_boardinfo *boardinfo,
 				 const char *prefix);
 #endif
 
+void bcm47xx_gpio_init(void);
+
 #endif /* __ASM_BCM47XX_H */
diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
index 2ef17e8..9133b93 100644
--- a/arch/mips/include/asm/mach-bcm47xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm47xx/gpio.h
@@ -4,152 +4,39 @@
  * for more details.
  *
  * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ * Copyright (C) 2012 Hauke Mehrtens <hauke@hauke-m.de>
  */
 
 #ifndef __BCM47XX_GPIO_H
 #define __BCM47XX_GPIO_H
 
-#include <linux/ssb/ssb_embedded.h>
-#include <linux/bcma/bcma.h>
-#include <asm/mach-bcm47xx/bcm47xx.h>
+#define ARCH_NR_GPIOS	64
+#include <asm-generic/gpio.h>
 
-#define BCM47XX_EXTIF_GPIO_LINES	5
-#define BCM47XX_CHIPCO_GPIO_LINES	16
+/* low level BCM47xx gpio api */
+u32 bcm47xx_gpio_in(u32 mask);
+u32 bcm47xx_gpio_out(u32 mask, u32 value);
+u32 bcm47xx_gpio_outen(u32 mask, u32 value);
+u32 bcm47xx_gpio_control(u32 mask, u32 value);
+u32 bcm47xx_gpio_intmask(u32 mask, u32 value);
+u32 bcm47xx_gpio_polarity(u32 mask, u32 value);
 
-extern int gpio_request(unsigned gpio, const char *label);
-extern void gpio_free(unsigned gpio);
-extern int gpio_to_irq(unsigned gpio);
+int gpio_to_irq(unsigned gpio);
+int irq_to_gpio(unsigned irq);
+int gpio_get_value(unsigned gpio);
+void gpio_set_value(unsigned gpio, int value);
 
-static inline int gpio_get_value(unsigned gpio)
+static inline void gpio_intmask(unsigned gpio, int value)
 {
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		return ssb_gpio_in(&bcm47xx_bus.ssb, 1 << gpio);
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		return bcma_chipco_gpio_in(&bcm47xx_bus.bcma.bus.drv_cc,
-					   1 << gpio);
-#endif
-	}
-	return -EINVAL;
+	bcm47xx_gpio_intmask(1 << gpio, value ? 1 << gpio : 0);
 }
 
-#define gpio_get_value_cansleep	gpio_get_value
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		ssb_gpio_out(&bcm47xx_bus.ssb, 1 << gpio,
-			     value ? 1 << gpio : 0);
-		return;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_gpio_out(&bcm47xx_bus.bcma.bus.drv_cc, 1 << gpio,
-				     value ? 1 << gpio : 0);
-		return;
-#endif
-	}
-}
-
-#define gpio_set_value_cansleep gpio_set_value
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return 0;
-}
-
-static inline int gpio_is_valid(unsigned gpio)
-{
-	return gpio < (BCM47XX_EXTIF_GPIO_LINES + BCM47XX_CHIPCO_GPIO_LINES);
-}
-
-
-static inline int gpio_direction_input(unsigned gpio)
-{
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		ssb_gpio_outen(&bcm47xx_bus.ssb, 1 << gpio, 0);
-		return 0;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_gpio_outen(&bcm47xx_bus.bcma.bus.drv_cc, 1 << gpio,
-				       0);
-		return 0;
-#endif
-	}
-	return -EINVAL;
-}
-
-static inline int gpio_direction_output(unsigned gpio, int value)
+static inline void gpio_polarity(unsigned gpio, int value)
 {
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		/* first set the gpio out value */
-		ssb_gpio_out(&bcm47xx_bus.ssb, 1 << gpio,
-			     value ? 1 << gpio : 0);
-		/* then set the gpio mode */
-		ssb_gpio_outen(&bcm47xx_bus.ssb, 1 << gpio, 1 << gpio);
-		return 0;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		/* first set the gpio out value */
-		bcma_chipco_gpio_out(&bcm47xx_bus.bcma.bus.drv_cc, 1 << gpio,
-				     value ? 1 << gpio : 0);
-		/* then set the gpio mode */
-		bcma_chipco_gpio_outen(&bcm47xx_bus.bcma.bus.drv_cc, 1 << gpio,
-				       1 << gpio);
-		return 0;
-#endif
-	}
-	return -EINVAL;
+	bcm47xx_gpio_polarity(1 << gpio, value ? 1 << gpio : 0);
 }
 
-static inline int gpio_intmask(unsigned gpio, int value)
-{
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		ssb_gpio_intmask(&bcm47xx_bus.ssb, 1 << gpio,
-				 value ? 1 << gpio : 0);
-		return 0;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_gpio_intmask(&bcm47xx_bus.bcma.bus.drv_cc,
-					 1 << gpio, value ? 1 << gpio : 0);
-		return 0;
-#endif
-	}
-	return -EINVAL;
-}
-
-static inline int gpio_polarity(unsigned gpio, int value)
-{
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		ssb_gpio_polarity(&bcm47xx_bus.ssb, 1 << gpio,
-				  value ? 1 << gpio : 0);
-		return 0;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_gpio_polarity(&bcm47xx_bus.bcma.bus.drv_cc,
-					  1 << gpio, value ? 1 << gpio : 0);
-		return 0;
-#endif
-	}
-	return -EINVAL;
-}
 
+#define gpio_cansleep	__gpio_cansleep
 
 #endif /* __BCM47XX_GPIO_H */
-- 
1.7.9.5
