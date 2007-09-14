Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 02:29:34 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:3015 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023454AbXINB30 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 02:29:26 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IVzwi-0006jw-NG
	for linux-mips@linux-mips.org; Fri, 14 Sep 2007 03:26:12 +0200
Date:	Fri, 14 Sep 2007 03:26:12 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3][MIPS] Add gpio support to the BCM947xx platform
Message-ID: <20070914012612.GB25633@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Same as the previous patch, submitting it now as I don't want to miss
the 2.6.24 merge window.


Add GPIO support to the BCM947xx platform.  It will be used by a GPIO
LED driver.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/bcm947xx/gpio.c
+++ b/arch/mips/bcm947xx/gpio.c
@@ -0,0 +1,79 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#include <linux/ssb/ssb.h>
+#include <linux/ssb/ssb_driver_chipcommon.h>
+#include <linux/ssb/ssb_driver_extif.h>
+#include <asm/mach-bcm947xx/bcm947xx.h>
+#include <asm/mach-bcm947xx/gpio.h>
+
+int bcm947xx_gpio_to_irq(unsigned gpio)
+{
+	if (ssb_bcm947xx.chipco.dev)
+		return ssb_mips_irq(ssb_bcm947xx.chipco.dev) + 2;
+	else if (ssb_bcm947xx.extif.dev)
+		return ssb_mips_irq(ssb_bcm947xx.extif.dev) + 2;
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL(bcm947xx_gpio_to_irq);
+
+int bcm947xx_gpio_get_value(unsigned gpio)
+{
+	if (ssb_bcm947xx.chipco.dev)
+		return ssb_chipco_gpio_in(&ssb_bcm947xx.chipco, 1 << gpio);
+	else if (ssb_bcm947xx.extif.dev)
+		return ssb_extif_gpio_in(&ssb_bcm947xx.extif, 1 << gpio);
+	else
+		return 0;
+}
+EXPORT_SYMBOL(bcm947xx_gpio_get_value);
+
+void bcm947xx_gpio_set_value(unsigned gpio, int value)
+{
+	if (ssb_bcm947xx.chipco.dev)
+		ssb_chipco_gpio_out(&ssb_bcm947xx.chipco,
+				    1 << gpio,
+				    value ? 1 << gpio : 0);
+	else if (ssb_bcm947xx.extif.dev)
+		ssb_extif_gpio_out(&ssb_bcm947xx.extif,
+				   1 << gpio,
+				   value ? 1 << gpio : 0);
+}
+EXPORT_SYMBOL(bcm947xx_gpio_set_value);
+
+int bcm947xx_gpio_direction_input(unsigned gpio)
+{
+	if (ssb_bcm947xx.chipco.dev && (gpio < BCM947XX_CHIPCO_GPIO_LINES))
+		ssb_chipco_gpio_outen(&ssb_bcm947xx.chipco,
+				      1 << gpio, 0);
+	else if (ssb_bcm947xx.extif.dev && (gpio < BCM947XX_EXTIF_GPIO_LINES))
+		ssb_extif_gpio_outen(&ssb_bcm947xx.extif,
+				     1 << gpio, 0);
+	else
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(bcm947xx_gpio_direction_input);
+
+int bcm947xx_gpio_direction_output(unsigned gpio, int value)
+{
+	bcm947xx_gpio_set_value(gpio, value);
+
+	if (ssb_bcm947xx.chipco.dev && (gpio < BCM947XX_CHIPCO_GPIO_LINES))
+		ssb_chipco_gpio_outen(&ssb_bcm947xx.chipco,
+				      1 << gpio, 1 << gpio);
+	else if (ssb_bcm947xx.extif.dev && (gpio < BCM947XX_EXTIF_GPIO_LINES))
+		ssb_extif_gpio_outen(&ssb_bcm947xx.extif,
+				     1 << gpio, 1 << gpio);
+	else
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(bcm947xx_gpio_direction_output);
+
--- a/arch/mips/bcm947xx/Makefile
+++ b/arch/mips/bcm947xx/Makefile
@@ -3,4 +3,4 @@
 # under Linux.
 #
 
-obj-y := irq.o prom.o serial.o setup.o time.o
+obj-y := gpio.o irq.o prom.o serial.o setup.o time.o
--- a/include/asm-mips/mach-bcm947xx/gpio.h
+++ b/include/asm-mips/mach-bcm947xx/gpio.h
@@ -0,0 +1,59 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#ifndef __BCM947XX_GPIO_H
+#define __BCM947XX_GPIO_H
+
+#define BCM947XX_EXTIF_GPIO_LINES	5
+#define BCM947XX_CHIPCO_GPIO_LINES	16
+
+extern int bcm947xx_gpio_to_irq(unsigned gpio);
+extern int bcm947xx_gpio_get_value(unsigned gpio);
+extern void bcm947xx_gpio_set_value(unsigned gpio, int value);
+extern int bcm947xx_gpio_direction_input(unsigned gpio);
+extern int bcm947xx_gpio_direction_output(unsigned gpio, int value);
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+       return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return bcm947xx_gpio_to_irq(gpio);
+}
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return bcm947xx_gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	bcm947xx_gpio_set_value(gpio, value);
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	return bcm947xx_gpio_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(unsigned gpio, int value)
+{
+	return bcm947xx_gpio_direction_output(gpio, value);
+}
+
+
+/* cansleep wrappers */
+#include <asm-generic/gpio.h>
+
+#endif /* __BCM947XX_GPIO_H */


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
