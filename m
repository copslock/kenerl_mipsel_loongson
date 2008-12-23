Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2008 19:59:32 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:65471 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24207993AbYLWT7a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Dec 2008 19:59:30 +0000
Received: (qmail 24690 invoked from network); 23 Dec 2008 20:59:29 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 23 Dec 2008 20:59:29 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH v2] Alchemy: fix gpio_to_irq().
Date:	Tue, 23 Dec 2008 20:59:24 +0100
Message-Id: <1230062364-24788-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

It's not as easy as it is currently implemented:  Not all GPIOs are
irq-capable and every CPU model has them wired up differently.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
This update removes all but one EINVAL.

 arch/mips/alchemy/common/gpio.c          |   88 +++++++++++++++++++++++++++---
 arch/mips/include/asm/mach-au1x00/gpio.h |    7 ++-
 2 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/arch/mips/alchemy/common/gpio.c b/arch/mips/alchemy/common/gpio.c
index e660ddd..7bac8f7 100644
--- a/arch/mips/alchemy/common/gpio.c
+++ b/arch/mips/alchemy/common/gpio.c
@@ -40,27 +40,27 @@ static struct au1x00_gpio2 *const gpio2 = (struct au1x00_gpio2 *) GPIO2_BASE;
 
 static int au1xxx_gpio2_read(unsigned gpio)
 {
-	gpio -= AU1XXX_GPIO_BASE;
+	gpio -= AU1XXX_GPIO2_BASE;
 	return ((gpio2->pinstate >> gpio) & 0x01);
 }
 
 static void au1xxx_gpio2_write(unsigned gpio, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
+	gpio -= AU1XXX_GPIO2_BASE;
 
 	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
 }
 
 static int au1xxx_gpio2_direction_input(unsigned gpio)
 {
-	gpio -= AU1XXX_GPIO_BASE;
+	gpio -= AU1XXX_GPIO2_BASE;
 	gpio2->dir &= ~(0x01 << gpio);
 	return 0;
 }
 
 static int au1xxx_gpio2_direction_output(unsigned gpio, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
+	gpio -= AU1XXX_GPIO2_BASE;
 	gpio2->dir |= 0x01 << gpio;
 	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
 	return 0;
@@ -97,7 +97,7 @@ static int au1xxx_gpio1_direction_output(unsigned gpio, int value)
 
 int au1xxx_gpio_get_value(unsigned gpio)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
+	if (gpio >= AU1XXX_GPIO2_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		return 0;
 #else
@@ -110,7 +110,7 @@ EXPORT_SYMBOL(au1xxx_gpio_get_value);
 
 void au1xxx_gpio_set_value(unsigned gpio, int value)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
+	if (gpio >= AU1XXX_GPIO2_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		;
 #else
@@ -123,7 +123,7 @@ EXPORT_SYMBOL(au1xxx_gpio_set_value);
 
 int au1xxx_gpio_direction_input(unsigned gpio)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
+	if (gpio >= AU1XXX_GPIO2_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		return -ENODEV;
 #else
@@ -136,7 +136,7 @@ EXPORT_SYMBOL(au1xxx_gpio_direction_input);
 
 int au1xxx_gpio_direction_output(unsigned gpio, int value)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
+	if (gpio >= AU1XXX_GPIO2_BASE)
 #if defined(CONFIG_SOC_AU1000)
 		return -ENODEV;
 #else
@@ -146,3 +146,75 @@ int au1xxx_gpio_direction_output(unsigned gpio, int value)
 	return au1xxx_gpio1_direction_output(gpio, value);
 }
 EXPORT_SYMBOL(au1xxx_gpio_direction_output);
+
+#define GPIO2(x)		(AU1XXX_GPIO2_BASE + (x))
+#define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
+#define MAKE_GPIO2_IRQ(intc, base, gpio)	\
+		MAKE_IRQ(intc, (base) + (gpio) - AU1XXX_GPIO2_BASE)
+
+int au1xxx_gpio_to_irq(unsigned int gpio)
+{
+#ifdef CONFIG_SOC_AU1000
+
+	if ((gpio >= 0) && (gpio <= 31))
+		return MAKE_IRQ(1, gpio);
+
+#elif defined(CONFIG_SOC_AU1100)
+
+	if (gpio >= AU1XXX_GPIO2_BASE) {
+		if ((gpio >= GPIO2(8)) && (gpio <= GPIO2(15)))
+			return MAKE_IRQ(0, 29);
+	} else
+		return MAKE_IRQ(1, gpio);
+
+#elif defined(CONFIG_SOC_AU1500)
+
+	if (gpio >= AU1XXX_GPIO2_BASE) {
+		if ((gpio >= GPIO2(0)) && (gpio <= GPIO2(3)))
+			return MAKE_GPIO2_IRQ(1, 16, gpio);
+		else if ((gpio >= GPIO2(4)) && (gpio <= GPIO2(5)))
+			return MAKE_GPIO2_IRQ(1, 21, gpio - 4);
+		else if ((gpio >= GPIO2(6)) && (gpio <= GPIO2(7)))
+			return MAKE_GPIO2_IRQ(1, 29, gpio - 6);
+	} else {
+		if (((gpio >= 0) && (gpio <= 15)) || (gpio == 20) ||
+		    ((gpio >= 23) && (gpio <= 28)))
+			return MAKE_IRQ(1, gpio);
+	}
+
+#elif defined(CONFIG_SOC_AU1550)
+
+	if (gpio >= AU1XXX_GPIO2_BASE) {
+		if (gpio == GPIO2(0))
+			return MAKE_IRQ(1, 16);
+		else if ((gpio >= GPIO2(1)) && (gpio <= GPIO2(5)))
+			return MAKE_IRQ(1, 17);
+		else if ((gpio >= GPIO2(6)) && (gpio <= GPIO2(7)))
+			return MAKE_GPIO2_IRQ(1, 29, gpio - 6);
+		else if ((gpio >= GPIO2(8)) && (gpio <= GPIO2(15)))
+			return MAKE_IRQ(1, 31)
+	} else {
+		if (((gpio >= 0) && (gpio <= 15)) ||
+		    ((gpio >= 20) && (gpio <= 28)))
+			return MAKE_IRQ(1, gpio);
+		else if ((gpio >= 16) && (gpio <= 17))
+			return MAKE_IRQ(1, gpio + 2);
+	}
+
+#elif defined(CONFIG_SOC_AU1200)
+
+	if (gpio >= AU1XXX_GPIO2_BASE) {
+		if ((gpio >= GPIO2(0)) && (gpio <= GPIO2(2)))
+			return MAKE_GPIO2_IRQ(0, 5, gpio);
+		else if (gpio == GPIO2(3))
+			return MAKE_IRQ(0, 22);
+		else if ((gpio >= GPIO2(4)) && (gpio <= GPIO2(7)))
+			return MAKE_GPIO2_IRQ(0, 24, gpio - 4);
+		else if ((gpio >= GPIO2(8)) && (gpio <= GPIO2(15)))
+			return MAKE_IRQ(0, 28);
+	} else
+		return MAKE_IRQ(1, gpio);
+#endif
+	return -EINVAL;
+}
+EXPORT_SYMBOL(au1xxx_gpio_to_irq);
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index 2dc61e0..08060ab 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -3,7 +3,7 @@
 
 #include <linux/types.h>
 
-#define AU1XXX_GPIO_BASE	200
+#define AU1XXX_GPIO2_BASE	200
 
 struct au1x00_gpio2 {
 	u32	dir;
@@ -18,6 +18,7 @@ extern int au1xxx_gpio_get_value(unsigned gpio);
 extern void au1xxx_gpio_set_value(unsigned gpio, int value);
 extern int au1xxx_gpio_direction_input(unsigned gpio);
 extern int au1xxx_gpio_direction_output(unsigned gpio, int value);
+extern int au1xxx_gpio_to_irq(unsigned int gpio);
 
 
 /* Wrappers for the arch-neutral GPIO API */
@@ -55,12 +56,12 @@ static inline void gpio_set_value(unsigned gpio, int value)
 
 static inline int gpio_to_irq(unsigned gpio)
 {
-	return gpio;
+	return au1xxx_gpio_to_irq(gpio);
 }
 
 static inline int irq_to_gpio(unsigned irq)
 {
-	return irq;
+	return -EINVAL;
 }
 
 /* For cansleep */
-- 
1.6.0.4
