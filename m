Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 12:27:20 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:7563 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021348AbXHOL1S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Aug 2007 12:27:18 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1ILGyp-00056h-RF; Wed, 15 Aug 2007 13:24:03 +0200
Date:	Wed, 15 Aug 2007 13:24:03 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH -mm][MIPS] Add GPIO support to the BCM947xx platform
Message-ID: <20070815112403.GA17615@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below adds GPIO support to the BCM947xx platform. It will be
used by a GPIO LED driver.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/include/asm-mips/mach-bcm947xx/gpio.h	
+++ b/include/asm-mips/mach-bcm947xx/gpio.h
@@ -0,0 +1,89 @@
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
+#include <linux/ssb/ssb.h>
+#include <linux/ssb/ssb_driver_chipcommon.h>
+#include <linux/ssb/ssb_driver_extif.h>
+#include <asm/mach-bcm947xx/bcm947xx.h>
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
+	if (ssb_bcm947xx.chipco.dev)
+		return ssb_mips_irq(ssb_bcm947xx.chipco.dev) + 2;
+	else if (ssb_bcm947xx.extif.dev)
+		return ssb_mips_irq(ssb_bcm947xx.extif.dev) + 2;
+	else
+		return -EINVAL;
+}
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	if (ssb_bcm947xx.chipco.dev)
+		return ssb_chipco_gpio_in(&ssb_bcm947xx.chipco, 1 << gpio);
+	else if (ssb_bcm947xx.extif.dev)
+		return ssb_extif_gpio_in(&ssb_bcm947xx.extif, 1 << gpio);
+	else
+		return 0;
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
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
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	if (ssb_bcm947xx.chipco.dev)
+		ssb_chipco_gpio_outen(&ssb_bcm947xx.chipco,
+				      1 << gpio, 0);
+	else if (ssb_bcm947xx.extif.dev)
+		ssb_extif_gpio_outen(&ssb_bcm947xx.extif,
+				     1 << gpio, 0);
+	else
+		return -EINVAL;
+	return 0;
+}
+
+static inline int gpio_direction_output(unsigned gpio, int value)
+{
+	gpio_set_value(gpio, value);
+
+	if (ssb_bcm947xx.chipco.dev)
+		ssb_chipco_gpio_outen(&ssb_bcm947xx.chipco,
+				      1 << gpio, 1 << gpio);
+	else if (ssb_bcm947xx.extif.dev)
+		ssb_extif_gpio_outen(&ssb_bcm947xx.extif,
+				     1 << gpio, 1 << gpio);
+	else
+		return -EINVAL;
+	return 0;
+}
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
