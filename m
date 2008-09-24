Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 20:23:14 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:61883 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S29559516AbYIXTW7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 20:22:59 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZww-0003oD-HN; Wed, 24 Sep 2008 21:22:58 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZwv-0005CC-A2; Wed, 24 Sep 2008 21:22:57 +0200
Date:	Wed, 24 Sep 2008 21:22:57 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 4/6] [MIPS] BCM47xx: Use the new SSB GPIO API
Message-ID: <20080924192257.GE18700@volta.aurel32.net>
References: <20080924191840.GA18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080924191840.GA18700@volta.aurel32.net>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch simplifies the BCM47xx GPIO code by using the new SSB GPIO
API, which does a lot things that were implemented directly in the
BCM47xx code.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/Kconfig                    |    1 +
 arch/mips/bcm47xx/gpio.c             |   85 +++++++++++++--------------------
 arch/mips/bcm47xx/setup.c            |    5 +-
 include/asm-mips/mach-bcm47xx/gpio.h |   41 ++++++++--------
 4 files changed, 58 insertions(+), 74 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 49896a2..1503feb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -52,6 +52,7 @@ config BCM47XX
 	select SSB
 	select SSB_DRIVER_MIPS
 	select SSB_DRIVER_EXTIF
+	select SSB_EMBEDDED
 	select SSB_PCICORE_HOSTMODE if PCI
 	select GENERIC_GPIO
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/bcm47xx/gpio.c b/arch/mips/bcm47xx/gpio.c
index f5a53ac..9b79880 100644
--- a/arch/mips/bcm47xx/gpio.c
+++ b/arch/mips/bcm47xx/gpio.c
@@ -12,68 +12,51 @@
 #include <asm/mach-bcm47xx/bcm47xx.h>
 #include <asm/mach-bcm47xx/gpio.h>
 
-int bcm47xx_gpio_to_irq(unsigned gpio)
+#if (BCM47XX_CHIPCO_GPIO_LINES > BCM47XX_EXTIF_GPIO_LINES)
+static DECLARE_BITMAP(gpio_in_use, BCM47XX_CHIPCO_GPIO_LINES);
+#else
+static DECLARE_BITMAP(gpio_in_use, BCM47XX_EXTIF_GPIO_LINES);
+#endif
+
+int gpio_request(unsigned gpio, const char *tag)
 {
-	if (ssb_bcm47xx.chipco.dev)
-		return ssb_mips_irq(ssb_bcm47xx.chipco.dev) + 2;
-	else if (ssb_bcm47xx.extif.dev)
-		return ssb_mips_irq(ssb_bcm47xx.extif.dev) + 2;
-	else
+	if (ssb_chipco_available(&ssb_bcm47xx.chipco) &&
+	    ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES))
 		return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(bcm47xx_gpio_to_irq);
 
-int bcm47xx_gpio_get_value(unsigned gpio)
-{
-	if (ssb_bcm47xx.chipco.dev)
-		return ssb_chipco_gpio_in(&ssb_bcm47xx.chipco, 1 << gpio);
-	else if (ssb_bcm47xx.extif.dev)
-		return ssb_extif_gpio_in(&ssb_bcm47xx.extif, 1 << gpio);
-	else
-		return 0;
-}
-EXPORT_SYMBOL_GPL(bcm47xx_gpio_get_value);
+	if (ssb_extif_available(&ssb_bcm47xx.extif) &&
+	    ((unsigned)gpio >= BCM47XX_EXTIF_GPIO_LINES))
+		return -EINVAL;
 
-void bcm47xx_gpio_set_value(unsigned gpio, int value)
-{
-	if (ssb_bcm47xx.chipco.dev)
-		ssb_chipco_gpio_out(&ssb_bcm47xx.chipco,
-				    1 << gpio,
-				    value ? 1 << gpio : 0);
-	else if (ssb_bcm47xx.extif.dev)
-		ssb_extif_gpio_out(&ssb_bcm47xx.extif,
-				   1 << gpio,
-				   value ? 1 << gpio : 0);
-}
-EXPORT_SYMBOL_GPL(bcm47xx_gpio_set_value);
+	if (test_and_set_bit(gpio, gpio_in_use))
+		return -EBUSY;
 
-int bcm47xx_gpio_direction_input(unsigned gpio)
-{
-	if (ssb_bcm47xx.chipco.dev && (gpio < BCM47XX_CHIPCO_GPIO_LINES))
-		ssb_chipco_gpio_outen(&ssb_bcm47xx.chipco,
-				      1 << gpio, 0);
-	else if (ssb_bcm47xx.extif.dev && (gpio < BCM47XX_EXTIF_GPIO_LINES))
-		ssb_extif_gpio_outen(&ssb_bcm47xx.extif,
-				     1 << gpio, 0);
-	else
-		return -EINVAL;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bcm47xx_gpio_direction_input);
+EXPORT_SYMBOL(gpio_request);
 
-int bcm47xx_gpio_direction_output(unsigned gpio, int value)
+void gpio_free(unsigned gpio)
 {
-	bcm47xx_gpio_set_value(gpio, value);
+	if (ssb_chipco_available(&ssb_bcm47xx.chipco) &&
+	    ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES))
+		return;
+
+	if (ssb_extif_available(&ssb_bcm47xx.extif) &&
+	    ((unsigned)gpio >= BCM47XX_EXTIF_GPIO_LINES))
+		return;
+
+	clear_bit(gpio, gpio_in_use);
+}
+EXPORT_SYMBOL(gpio_free);
 
-	if (ssb_bcm47xx.chipco.dev && (gpio < BCM47XX_CHIPCO_GPIO_LINES))
-		ssb_chipco_gpio_outen(&ssb_bcm47xx.chipco,
-				      1 << gpio, 1 << gpio);
-	else if (ssb_bcm47xx.extif.dev && (gpio < BCM47XX_EXTIF_GPIO_LINES))
-		ssb_extif_gpio_outen(&ssb_bcm47xx.extif,
-				     1 << gpio, 1 << gpio);
+int gpio_to_irq(unsigned gpio)
+{
+	if (ssb_chipco_available(&ssb_bcm47xx.chipco))
+		return ssb_mips_irq(ssb_bcm47xx.chipco.dev) + 2;
+	else if (ssb_extif_available(&ssb_bcm47xx.extif))
+		return ssb_mips_irq(ssb_bcm47xx.extif.dev) + 2;
 	else
 		return -EINVAL;
-	return 0;
 }
-EXPORT_SYMBOL_GPL(bcm47xx_gpio_direction_output);
+EXPORT_SYMBOL_GPL(gpio_to_irq);
 
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 8d36f18..2f580fa 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -27,6 +27,7 @@
 
 #include <linux/types.h>
 #include <linux/ssb/ssb.h>
+#include <linux/ssb/ssb_embedded.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
@@ -41,7 +42,7 @@ static void bcm47xx_machine_restart(char *command)
 	printk(KERN_ALERT "Please stand by while rebooting the system...\n");
 	local_irq_disable();
 	/* Set the watchdog timer to reset immediately */
-	ssb_chipco_watchdog_timer_set(&ssb_bcm47xx.chipco, 1);
+	ssb_watchdog_timer_set(&ssb_bcm47xx, 1);
 	while (1)
 		cpu_relax();
 }
@@ -50,7 +51,7 @@ static void bcm47xx_machine_halt(void)
 {
 	/* Disable interrupts and watchdog and spin forever */
 	local_irq_disable();
-	ssb_chipco_watchdog_timer_set(&ssb_bcm47xx.chipco, 0);
+	ssb_watchdog_timer_set(&ssb_bcm47xx, 0);
 	while (1)
 		cpu_relax();
 }
diff --git a/include/asm-mips/mach-bcm47xx/gpio.h b/include/asm-mips/mach-bcm47xx/gpio.h
index cfc8f4d..d8ff4cd 100644
--- a/include/asm-mips/mach-bcm47xx/gpio.h
+++ b/include/asm-mips/mach-bcm47xx/gpio.h
@@ -9,47 +9,46 @@
 #ifndef __BCM47XX_GPIO_H
 #define __BCM47XX_GPIO_H
 
+#include <linux/ssb/ssb_embedded.h>
+#include <asm/mach-bcm47xx/bcm47xx.h>
+
 #define BCM47XX_EXTIF_GPIO_LINES	5
 #define BCM47XX_CHIPCO_GPIO_LINES	16
 
-extern int bcm47xx_gpio_to_irq(unsigned gpio);
-extern int bcm47xx_gpio_get_value(unsigned gpio);
-extern void bcm47xx_gpio_set_value(unsigned gpio, int value);
-extern int bcm47xx_gpio_direction_input(unsigned gpio);
-extern int bcm47xx_gpio_direction_output(unsigned gpio, int value);
-
-static inline int gpio_request(unsigned gpio, const char *label)
-{
-       return 0;
-}
+extern int gpio_request(unsigned gpio, const char *label);
+extern void gpio_free(unsigned gpio);
+extern int gpio_to_irq(unsigned gpio);
 
-static inline void gpio_free(unsigned gpio)
+static inline int gpio_get_value(unsigned gpio)
 {
+	return ssb_gpio_in(&ssb_bcm47xx, 1 << gpio);
 }
 
-static inline int gpio_to_irq(unsigned gpio)
+static inline void gpio_set_value(unsigned gpio, int value)
 {
-	return bcm47xx_gpio_to_irq(gpio);
+	ssb_gpio_out(&ssb_bcm47xx, 1 << gpio, value ? 1 << gpio : 0);
 }
 
-static inline int gpio_get_value(unsigned gpio)
+static inline int gpio_direction_input(unsigned gpio)
 {
-	return bcm47xx_gpio_get_value(gpio);
+	return ssb_gpio_outen(&ssb_bcm47xx, 1 << gpio, 0);
 }
 
-static inline void gpio_set_value(unsigned gpio, int value)
+static inline int gpio_direction_output(unsigned gpio, int value)
 {
-	bcm47xx_gpio_set_value(gpio, value);
+	return ssb_gpio_outen(&ssb_bcm47xx, 1 << gpio, 1 << gpio);
 }
 
-static inline int gpio_direction_input(unsigned gpio)
+static int gpio_intmask(unsigned gpio, int value)
 {
-	return bcm47xx_gpio_direction_input(gpio);
+	return ssb_gpio_intmask(&ssb_bcm47xx, 1 << gpio,
+				value ? 1 << gpio : 0);
 }
 
-static inline int gpio_direction_output(unsigned gpio, int value)
+static int gpio_polarity(unsigned gpio, int value)
 {
-	return bcm47xx_gpio_direction_output(gpio, value);
+	return ssb_gpio_polarity(&ssb_bcm47xx, 1 << gpio,
+				 value ? 1 << gpio : 0);
 }
 
 
-- 
1.5.6.5


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
