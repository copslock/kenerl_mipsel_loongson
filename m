Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:55:05 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45013 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491757Ab1HBRvb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:31 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so73262fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4rlGmGcooaIVihjRsHy7wzWQJtNXsZSKdQA4ogEbyjQ=;
        b=c+7JCFwnLsR2Wfzz5FVkzwmzCwIQkbgjCF4KmoIE8tngasK01UbE1p/XZFlZuBgJ0v
         /LaS3GDXwzs016DkkewR562qUl/yeOBeoH8AzO3GVs04luwmJm++1GRPObGGP6reo2ct
         6iuFg+fP62kT2VD8nm3MsD/eMj5c90+mAdt04=
Received: by 10.223.9.217 with SMTP id m25mr826525fam.122.1312307490892;
        Tue, 02 Aug 2011 10:51:30 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:30 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 08/15] MIPS: Alchemy: support multiple GPIO styles in one kernel
Date:   Tue,  2 Aug 2011 19:51:03 +0200
Message-Id: <1312307470-6841-9-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1619

For GPIOLIB=y decide at runtime which gpiochips to register;
in the GPIOLIB=n case, the gpio headers need to be reshuffled
a bit to make multiple implementations coexist peacefully.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/Makefile               |    4 +-
 arch/mips/alchemy/common/gpiolib-au1000.c       |  126 ---------------------
 arch/mips/alchemy/common/gpiolib.c              |  133 +++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   31 +-----
 arch/mips/include/asm/mach-au1x00/gpio.h        |   79 +++++++++++++-
 5 files changed, 212 insertions(+), 161 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/gpiolib-au1000.c
 create mode 100644 arch/mips/alchemy/common/gpiolib.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 575db47..31728e0 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -12,9 +12,7 @@ obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
 
 # optional gpiolib support
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
- ifeq ($(CONFIG_GPIOLIB),y)
-  obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += gpiolib-au1000.o
- endif
+ obj-$(CONFIG_GPIOLIB) += gpiolib.o
 endif
 
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/mips/alchemy/common/gpiolib-au1000.c b/arch/mips/alchemy/common/gpiolib-au1000.c
deleted file mode 100644
index c8e1a94..0000000
--- a/arch/mips/alchemy/common/gpiolib-au1000.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
- *  	GPIOLIB support for Au1000, Au1500, Au1100, Au1550 and Au12x0.
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *  Notes :
- * 	au1000 SoC have only one GPIO block : GPIO1
- * 	Au1100, Au15x0, Au12x0 have a second one : GPIO2
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/gpio.h>
-
-static int gpio2_get(struct gpio_chip *chip, unsigned offset)
-{
-	return alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
-}
-
-static void gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	alchemy_gpio2_set_value(offset + ALCHEMY_GPIO2_BASE, value);
-}
-
-static int gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	return alchemy_gpio2_direction_input(offset + ALCHEMY_GPIO2_BASE);
-}
-
-static int gpio2_direction_output(struct gpio_chip *chip, unsigned offset,
-				  int value)
-{
-	return alchemy_gpio2_direction_output(offset + ALCHEMY_GPIO2_BASE,
-						value);
-}
-
-static int gpio2_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	return alchemy_gpio2_to_irq(offset + ALCHEMY_GPIO2_BASE);
-}
-
-
-static int gpio1_get(struct gpio_chip *chip, unsigned offset)
-{
-	return alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
-}
-
-static void gpio1_set(struct gpio_chip *chip,
-				unsigned offset, int value)
-{
-	alchemy_gpio1_set_value(offset + ALCHEMY_GPIO1_BASE, value);
-}
-
-static int gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	return alchemy_gpio1_direction_input(offset + ALCHEMY_GPIO1_BASE);
-}
-
-static int gpio1_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	return alchemy_gpio1_direction_output(offset + ALCHEMY_GPIO1_BASE,
-					     value);
-}
-
-static int gpio1_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	return alchemy_gpio1_to_irq(offset + ALCHEMY_GPIO1_BASE);
-}
-
-struct gpio_chip alchemy_gpio_chip[] = {
-	[0] = {
-		.label			= "alchemy-gpio1",
-		.direction_input	= gpio1_direction_input,
-		.direction_output	= gpio1_direction_output,
-		.get			= gpio1_get,
-		.set			= gpio1_set,
-		.to_irq			= gpio1_to_irq,
-		.base			= ALCHEMY_GPIO1_BASE,
-		.ngpio			= ALCHEMY_GPIO1_NUM,
-	},
-	[1] = {
-		.label                  = "alchemy-gpio2",
-		.direction_input        = gpio2_direction_input,
-		.direction_output       = gpio2_direction_output,
-		.get                    = gpio2_get,
-		.set                    = gpio2_set,
-		.to_irq			= gpio2_to_irq,
-		.base                   = ALCHEMY_GPIO2_BASE,
-		.ngpio                  = ALCHEMY_GPIO2_NUM,
-	},
-};
-
-static int __init alchemy_gpiolib_init(void)
-{
-	gpiochip_add(&alchemy_gpio_chip[0]);
-	if (alchemy_get_cputype() != ALCHEMY_CPU_AU1000)
-		gpiochip_add(&alchemy_gpio_chip[1]);
-
-	return 0;
-}
-arch_initcall(alchemy_gpiolib_init);
diff --git a/arch/mips/alchemy/common/gpiolib.c b/arch/mips/alchemy/common/gpiolib.c
new file mode 100644
index 0000000..91fb4d9
--- /dev/null
+++ b/arch/mips/alchemy/common/gpiolib.c
@@ -0,0 +1,133 @@
+/*
+ *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *	GPIOLIB support for Alchemy chips.
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
+ *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
+ *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Notes :
+ *	This file must ONLY be built when CONFIG_GPIOLIB=y and
+ *	 CONFIG_ALCHEMY_GPIO_INDIRECT=n, otherwise compilation will fail!
+ *	au1000 SoC have only one GPIO block : GPIO1
+ *	Au1100, Au15x0, Au12x0 have a second one : GPIO2
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/gpio.h>
+#include <asm/mach-au1x00/gpio-au1000.h>
+
+static int gpio2_get(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
+}
+
+static void gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	alchemy_gpio2_set_value(offset + ALCHEMY_GPIO2_BASE, value);
+}
+
+static int gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio2_direction_input(offset + ALCHEMY_GPIO2_BASE);
+}
+
+static int gpio2_direction_output(struct gpio_chip *chip, unsigned offset,
+				  int value)
+{
+	return alchemy_gpio2_direction_output(offset + ALCHEMY_GPIO2_BASE,
+						value);
+}
+
+static int gpio2_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio2_to_irq(offset + ALCHEMY_GPIO2_BASE);
+}
+
+
+static int gpio1_get(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
+}
+
+static void gpio1_set(struct gpio_chip *chip,
+				unsigned offset, int value)
+{
+	alchemy_gpio1_set_value(offset + ALCHEMY_GPIO1_BASE, value);
+}
+
+static int gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio1_direction_input(offset + ALCHEMY_GPIO1_BASE);
+}
+
+static int gpio1_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	return alchemy_gpio1_direction_output(offset + ALCHEMY_GPIO1_BASE,
+					     value);
+}
+
+static int gpio1_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio1_to_irq(offset + ALCHEMY_GPIO1_BASE);
+}
+
+struct gpio_chip alchemy_gpio_chip[] = {
+	[0] = {
+		.label			= "alchemy-gpio1",
+		.direction_input	= gpio1_direction_input,
+		.direction_output	= gpio1_direction_output,
+		.get			= gpio1_get,
+		.set			= gpio1_set,
+		.to_irq			= gpio1_to_irq,
+		.base			= ALCHEMY_GPIO1_BASE,
+		.ngpio			= ALCHEMY_GPIO1_NUM,
+	},
+	[1] = {
+		.label                  = "alchemy-gpio2",
+		.direction_input        = gpio2_direction_input,
+		.direction_output       = gpio2_direction_output,
+		.get                    = gpio2_get,
+		.set                    = gpio2_set,
+		.to_irq			= gpio2_to_irq,
+		.base                   = ALCHEMY_GPIO2_BASE,
+		.ngpio                  = ALCHEMY_GPIO2_NUM,
+	},
+};
+
+static int __init alchemy_gpiochip_init(void)
+{
+	int ret = 0;
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+		ret = gpiochip_add(&alchemy_gpio_chip[0]);
+		break;
+	case ALCHEMY_CPU_AU1500...ALCHEMY_CPU_AU1200:
+		ret = gpiochip_add(&alchemy_gpio_chip[0]);
+		ret |= gpiochip_add(&alchemy_gpio_chip[1]);
+		break;
+	}
+	return ret;
+}
+arch_initcall(alchemy_gpiochip_init);
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 1f41a52..73853b5 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -347,17 +347,6 @@ static inline int alchemy_gpio2_to_irq(int gpio)
 
 /**********************************************************************/
 
-/* On Au1000, Au1500 and Au1100 GPIOs won't work as inputs before
- * SYS_PININPUTEN is written to at least once.  On Au1550/Au1200 this
- * register enables use of GPIOs as wake source.
- */
-static inline void alchemy_gpio1_input_enable(void)
-{
-	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
-	__raw_writel(0, base + SYS_PININPUTEN);	/* the write op is key */
-	wmb();
-}
-
 /* GPIO2 shared interrupts and control */
 
 static inline void __alchemy_gpio2_mod_int(int gpio2, int en)
@@ -561,6 +550,7 @@ static inline int alchemy_irq_to_gpio(int irq)
 
 #ifndef CONFIG_GPIOLIB
 
+#ifdef CONFIG_ALCHEMY_GPIOINT_AU1000
 
 #ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (4) */
 
@@ -665,24 +655,7 @@ static inline void gpio_unexport(unsigned gpio)
 
 #endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
 
-
-#else	/* CONFIG GPIOLIB */
-
-
- /* using gpiolib to provide up to 2 gpio_chips for on-chip gpios */
-#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (2) */
-
-/* get everything through gpiolib */
-#define gpio_to_irq	__gpio_to_irq
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
-#define irq_to_gpio	alchemy_irq_to_gpio
-
-#include <asm-generic/gpio.h>
-
-#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
-
+#endif	/* CONFIG_ALCHEMY_GPIOINT_AU1000 */
 
 #endif	/* !CONFIG_GPIOLIB */
 
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index c3f60cd..fcdc8c4 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -1,10 +1,83 @@
+/*
+ * Alchemy GPIO support.
+ *
+ * With CONFIG_GPIOLIB=y different types of on-chip GPIO can be supported within
+ *  the same kernel image.
+ * With CONFIG_GPIOLIB=n, your board must select ALCHEMY_GPIOINT_AU1XXX for the
+ *  appropriate CPU type (AU1000 currently).
+ */
+
 #ifndef _ALCHEMY_GPIO_H_
 #define _ALCHEMY_GPIO_H_
 
-#if defined(CONFIG_ALCHEMY_GPIOINT_AU1000)
-
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/gpio-au1000.h>
 
-#endif
+/* On Au1000, Au1500 and Au1100 GPIOs won't work as inputs before
+ * SYS_PININPUTEN is written to at least once.  On Au1550/Au1200/Au1300 this
+ * register enables use of GPIOs as wake source.
+ */
+static inline void alchemy_gpio1_input_enable(void)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
+	__raw_writel(0, base + 0x110);		/* the write op is key */
+	wmb();
+}
+
+
+/* Linux gpio framework integration.
+*
+* 4 use cases of Alchemy GPIOS:
+*(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
+*	Board must register gpiochips.
+*(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
+*	A gpiochip for the 75 GPIOs is registered.
+*
+*(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
+*	the boards' gpio.h must provide	the linux gpio wrapper functions,
+*
+*(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
+*	inlinable gpio functions are provided which enable access to the
+*	Au1300 gpios only by using the numbers straight out of the data-
+*	sheets.
+
+* Cases 1 and 3 are intended for boards which want to provide their own
+* GPIO namespace and -operations (i.e. for example you have 8 GPIOs
+* which are in part provided by spare Au1300 GPIO pins and in part by
+* an external FPGA but you still want them to be accssible in linux
+* as gpio0-7. The board can of course use the alchemy_gpioX_* functions
+* as required).
+*/
+
+#ifdef CONFIG_GPIOLIB
+
+/* wraps the cpu-dependent irq_to_gpio functions */
+/* FIXME: gpiolib needs an irq_to_gpio hook */
+static inline int __au_irq_to_gpio(unsigned int irq)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000...ALCHEMY_CPU_AU1200:
+		return alchemy_irq_to_gpio(irq);
+	}
+	return -EINVAL;
+}
+
+
+/* using gpiolib to provide up to 2 gpio_chips for on-chip gpios */
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (2) */
+
+/* get everything through gpiolib */
+#define gpio_to_irq	__gpio_to_irq
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define irq_to_gpio	__au_irq_to_gpio
+
+#include <asm-generic/gpio.h>
+
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#endif	/* CONFIG_GPIOLIB */
 
 #endif	/* _ALCHEMY_GPIO_H_ */
-- 
1.7.6
