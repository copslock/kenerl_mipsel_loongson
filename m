Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:42:27 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:34462 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023110AbXIYNmO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 14:42:14 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IaAfx-0003nH-6V; Tue, 25 Sep 2007 15:42:09 +0200
Date:	Tue, 25 Sep 2007 15:42:09 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/4][MIPS] Add gpio support to the BCM47XX platform
Message-ID: <20070925134209.GD14227@hall.aurel32.net>
References: <20070925133847.GA14227@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070925133847.GA14227@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch replaces commit 67fc54603bff71e54001d61b54f448293b76f48a in
order to replace BCM947XX into BCM47XX.


    [MIPS] Add gpio support to the BCM47XX platform
    
    Add GPIO support to the BCM47XX platform.  It will be used by a GPIO
    LED driver.
    
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,4 +3,4 @@
 # under Linux.
 #
 
-obj-y := irq.o prom.o serial.o setup.o time.o
+obj-y := gpio.o irq.o prom.o serial.o setup.o time.o
--- /dev/null
+++ b/arch/mips/bcm47xx/gpio.c
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
+#include <asm/mach-bcm47xx/bcm47xx.h>
+#include <asm/mach-bcm47xx/gpio.h>
+
+int bcm47xx_gpio_to_irq(unsigned gpio)
+{
+	if (ssb_bcm47xx.chipco.dev)
+		return ssb_mips_irq(ssb_bcm47xx.chipco.dev) + 2;
+	else if (ssb_bcm47xx.extif.dev)
+		return ssb_mips_irq(ssb_bcm47xx.extif.dev) + 2;
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(bcm47xx_gpio_to_irq);
+
+int bcm47xx_gpio_get_value(unsigned gpio)
+{
+	if (ssb_bcm47xx.chipco.dev)
+		return ssb_chipco_gpio_in(&ssb_bcm47xx.chipco, 1 << gpio);
+	else if (ssb_bcm47xx.extif.dev)
+		return ssb_extif_gpio_in(&ssb_bcm47xx.extif, 1 << gpio);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(bcm47xx_gpio_get_value);
+
+void bcm47xx_gpio_set_value(unsigned gpio, int value)
+{
+	if (ssb_bcm47xx.chipco.dev)
+		ssb_chipco_gpio_out(&ssb_bcm47xx.chipco,
+				    1 << gpio,
+				    value ? 1 << gpio : 0);
+	else if (ssb_bcm47xx.extif.dev)
+		ssb_extif_gpio_out(&ssb_bcm47xx.extif,
+				   1 << gpio,
+				   value ? 1 << gpio : 0);
+}
+EXPORT_SYMBOL_GPL(bcm47xx_gpio_set_value);
+
+int bcm47xx_gpio_direction_input(unsigned gpio)
+{
+	if (ssb_bcm47xx.chipco.dev && (gpio < BCM47XX_CHIPCO_GPIO_LINES))
+		ssb_chipco_gpio_outen(&ssb_bcm47xx.chipco,
+				      1 << gpio, 0);
+	else if (ssb_bcm47xx.extif.dev && (gpio < BCM47XX_EXTIF_GPIO_LINES))
+		ssb_extif_gpio_outen(&ssb_bcm47xx.extif,
+				     1 << gpio, 0);
+	else
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bcm47xx_gpio_direction_input);
+
+int bcm47xx_gpio_direction_output(unsigned gpio, int value)
+{
+	bcm47xx_gpio_set_value(gpio, value);
+
+	if (ssb_bcm47xx.chipco.dev && (gpio < BCM47XX_CHIPCO_GPIO_LINES))
+		ssb_chipco_gpio_outen(&ssb_bcm47xx.chipco,
+				      1 << gpio, 1 << gpio);
+	else if (ssb_bcm47xx.extif.dev && (gpio < BCM47XX_EXTIF_GPIO_LINES))
+		ssb_extif_gpio_outen(&ssb_bcm47xx.extif,
+				     1 << gpio, 1 << gpio);
+	else
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bcm47xx_gpio_direction_output);
+
--- /dev/null
+++ b/include/asm-mips/mach-bcm47xx/gpio.h
@@ -0,0 +1,59 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#ifndef __BCM47XX_GPIO_H
+#define __BCM47XX_GPIO_H
+
+#define BCM47XX_EXTIF_GPIO_LINES	5
+#define BCM47XX_CHIPCO_GPIO_LINES	16
+
+extern int bcm47xx_gpio_to_irq(unsigned gpio);
+extern int bcm47xx_gpio_get_value(unsigned gpio);
+extern void bcm47xx_gpio_set_value(unsigned gpio, int value);
+extern int bcm47xx_gpio_direction_input(unsigned gpio);
+extern int bcm47xx_gpio_direction_output(unsigned gpio, int value);
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
+	return bcm47xx_gpio_to_irq(gpio);
+}
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return bcm47xx_gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	bcm47xx_gpio_set_value(gpio, value);
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	return bcm47xx_gpio_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(unsigned gpio, int value)
+{
+	return bcm47xx_gpio_direction_output(gpio, value);
+}
+
+
+/* cansleep wrappers */
+#include <asm-generic/gpio.h>
+
+#endif /* __BCM47XX_GPIO_H */

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
