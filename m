Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 17:20:07 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:57831 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022339AbZFCQS0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 17:18:26 +0100
Received: by fxm23 with SMTP id 23so114397fxm.0
        for <multiple recipients>; Wed, 03 Jun 2009 09:18:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=b3kB7Yn0HfhkyUgfxqj1HL6vyviO5FB0QueBoEZte94=;
        b=Tc7a1T5pkRtzvl8/mtxE0OaDOJt4xvN0JFkebd0HyPoqvqaLH3K+X3/Oh4MRks4oal
         CEBl/o0sh6a/aXl9GKSBAHX2PtDmrdNHEcR2VQIEwIlOQ20pHp5pIRCwp4xqDMPRA9Pg
         EhmemWrp+h8r5CCS1qZGINF9sT3AzJ2PGImCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JFJi8CQf+by2rMIjc3PeabmRaQ9C9CqapkVNWBl/6IqQ6Ddn1SUDEuKZhtBVXGJBCO
         CW0xhROQc8e/2s+icYYZzYkCEQoCkjewwKXRAWkn/2Xyb855wTmgQ27vWzAwpmKNEgbm
         ipwTlfjf1GtRSIkmpdX3M6c0khMlU/aYLIcoo=
Received: by 10.103.231.16 with SMTP id i16mr762531mur.7.1244045899693;
        Wed, 03 Jun 2009 09:18:19 -0700 (PDT)
Received: from localhost.localdomain (p5496DB58.dip.t-dialin.net [84.150.219.88])
        by mx.google.com with ESMTPS id u26sm37723mug.22.2009.06.03.09.18.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 09:18:19 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/5] Alchemy: rewrite GPIO support.
Date:	Wed,  3 Jun 2009 18:18:05 +0200
Message-Id: <1244045888-16259-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244045888-16259-2-git-send-email-manuel.lauss@gmail.com>
References: <1244045888-16259-1-git-send-email-manuel.lauss@gmail.com>
 <1244045888-16259-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The current in-kernel Alchemy GPIO support is far too inflexible for
all my use cases.  To address this, the following changes are made:

* create generic functions which deal with manipulating the on-chip
  GPIO1/2 blocks.  Such functions are universally useful.
* Macros for GPIO2 shared interrupt management and block control.
* support for both built-in CONFIG_GPIOLIB and fast, inlined GPIO macros.

  If CONFIG_GPIOLIB is not enabled, provide linux gpio framework
  compatibility by directly inlining the GPIO1/2 functions.  GPIO access
  is limited to on-chip ones and they can be accessed as documented in
  the datasheets (GPIO0-31 and 200-215).

  If CONFIG_GPIOLIB is selected, two (2) gpio_chip-s, one for GPIO1 and
  one for GPIO2, are registered.  GPIOs can still be accessed by using
  the numberspace established in the databooks.

  However this is not yet flexible enough for my uses:  My Alchemy
  systems have a documented "external" gpio interface (fixed, different
  numberspace) and can support a variety of baseboards, some of which
  are equipped with I2C gpio expanders.  I want to be able to provide
  the default 16 GPIOs of the CPU board numbered as 0..15 and also
  support gpio expanders, if present, starting as gpio16.

  To achieve this, a new Kconfig symbol for Alchemy is introduced,
  CONFIG_ALCHEMY_GPIO_INDIRECT, which boards can enable to signal
  that they don't want the Alchemy numberspace exposed to the outside
  world, but instead want to provide their own.  Boards are now respon-
  sible for providing the linux gpio interface glue code (either in a
  custom gpio.h header (in board include directory) or with gpio_chips).

  To make the board-specific inlined gpio functions work, the MIPS
  Makefile must be changed so that the mach-au1x00/gpio.h header is
  included _after_ the board headers, by moving the inclusion of
  the mach-au1x00/ to the end of the header list.

  see arch/mips/include/asm/mach-au1x00/gpio.h for more info.

Acked-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/Makefile                              |    5 +-
 arch/mips/alchemy/Kconfig                       |   19 +-
 arch/mips/alchemy/common/Makefile               |   11 +-
 arch/mips/alchemy/common/gpio-au1000.c          |  130 +++++
 arch/mips/alchemy/common/gpio.c                 |  201 --------
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |  604 +++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h        |   35 +--
 7 files changed, 772 insertions(+), 233 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpio-au1000.c
 delete mode 100644 arch/mips/alchemy/common/gpio.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1000.h

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c4cae9e..c7ddef1 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -184,7 +184,6 @@ load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 # Common Alchemy Au1x00 stuff
 #
 core-$(CONFIG_SOC_AU1X00)	+= arch/mips/alchemy/common/
-cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
 
 #
 # AMD Alchemy Pb1000 eval board
@@ -282,6 +281,10 @@ load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
 libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
 load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
 
+# must be last for Alchemy systems for GPIO to work properly
+cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
+
+
 #
 # Cobalt Server
 #
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 8128aeb..00b498e 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -1,3 +1,14 @@
+# au1000-style gpio
+config ALCHEMY_GPIO_AU1000
+	bool
+
+# select this in your board config if you don't want to use the gpio
+# namespace as documented in the manuals.  In this case however you need
+# to create the necessary gpio_* functions in your board code/headers!
+# see arch/mips/include/asm/mach-au1x00/gpio.h   for more information.
+config ALCHEMY_GPIO_INDIRECT
+	def_bool n
+
 choice
 	prompt "Machine type"
 	depends on MACH_ALCHEMY
@@ -108,22 +119,27 @@ endchoice
 config SOC_AU1000
 	bool
 	select SOC_AU1X00
+	select ALCHEMY_GPIO_AU1000
 
 config SOC_AU1100
 	bool
 	select SOC_AU1X00
+	select ALCHEMY_GPIO_AU1000
 
 config SOC_AU1500
 	bool
 	select SOC_AU1X00
+	select ALCHEMY_GPIO_AU1000
 
 config SOC_AU1550
 	bool
 	select SOC_AU1X00
+	select ALCHEMY_GPIO_AU1000
 
 config SOC_AU1200
 	bool
 	select SOC_AU1X00
+	select ALCHEMY_GPIO_AU1000
 
 config SOC_AU1X00
 	bool
@@ -134,4 +150,5 @@ config SOC_AU1X00
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
-	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
+	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index d50d476..36895c4 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -7,7 +7,16 @@
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
 	clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o gpio.o
+	sleeper.o dma.o dbdma.o
+
+ifeq (CONFIG_ALCHEMY_GPIO_INDIRECT,)
+ifeq (CONFIG_ALCHEMY_GPIO_AU1000,y)
+
+# Build default gpiolib for au1000-style gpio
+obj-y += gpio-au1000.o
+
+endif
+endif
 
 obj-$(CONFIG_PCI)		+= pci.o
 
diff --git a/arch/mips/alchemy/common/gpio-au1000.c b/arch/mips/alchemy/common/gpio-au1000.c
new file mode 100644
index 0000000..3e7212e
--- /dev/null
+++ b/arch/mips/alchemy/common/gpio-au1000.c
@@ -0,0 +1,130 @@
+/*
+ *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *  	GPIO support for Au1000, Au1500, Au1100, Au1550 and Au12x0.
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
+ * 	au1000 SoC have only one GPIO block : GPIO1
+ * 	Au1100, Au15x0, Au12x0 have a second one : GPIO2
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio.h>
+
+#if !defined(CONFIG_SOC_AU1000)
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
+#endif /* !defined(CONFIG_SOC_AU1000) */
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
+#if !defined(CONFIG_SOC_AU1000)
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
+#endif
+};
+
+static int __init alchemy_gpio_init(void)
+{
+	gpiochip_add(&alchemy_gpio_chip[0]);
+#if !defined(CONFIG_SOC_AU1000)
+	gpiochip_add(&alchemy_gpio_chip[1]);
+#endif
+
+	return 0;
+}
+arch_initcall(alchemy_gpio_init);
diff --git a/arch/mips/alchemy/common/gpio.c b/arch/mips/alchemy/common/gpio.c
deleted file mode 100644
index 91a9c44..0000000
--- a/arch/mips/alchemy/common/gpio.c
+++ /dev/null
@@ -1,201 +0,0 @@
-/*
- *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
- *  	Architecture specific GPIO support
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
- * 	au1000 SoC have only one GPIO line : GPIO1
- * 	others have a second one : GPIO2
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/gpio.h>
-
-struct au1000_gpio_chip {
-	struct gpio_chip	chip;
-	void __iomem		*regbase;
-};
-
-#if !defined(CONFIG_SOC_AU1000)
-static int au1000_gpio2_get(struct gpio_chip *chip, unsigned offset)
-{
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
-}
-
-static void au1000_gpio2_set(struct gpio_chip *chip,
-				unsigned offset, int value)
-{
-	u32 mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	local_irq_save(flags);
-	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
-	local_irq_restore(flags);
-}
-
-static int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	u32 mask = 1 << offset;
-	u32 tmp;
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	local_irq_save(flags);
-	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
-	tmp &= ~mask;
-	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static int au1000_gpio2_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	u32 mask = 1 << offset;
-	u32 out_mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
-	u32 tmp;
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	local_irq_save(flags);
-	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
-	tmp |= mask;
-	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
-	writel(out_mask, gpch->regbase + AU1000_GPIO2_OUT);
-	local_irq_restore(flags);
-
-	return 0;
-}
-#endif /* !defined(CONFIG_SOC_AU1000) */
-
-static int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
-{
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	return readl(gpch->regbase + AU1000_GPIO1_ST) & mask;
-}
-
-static void au1000_gpio1_set(struct gpio_chip *chip,
-				unsigned offset, int value)
-{
-	u32 mask = 1 << offset;
-	u32 reg_offset;
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	if (value)
-		reg_offset = AU1000_GPIO1_OUT;
-	else
-		reg_offset = AU1000_GPIO1_CLR;
-
-	local_irq_save(flags);
-	writel(mask, gpch->regbase + reg_offset);
-	local_irq_restore(flags);
-}
-
-static int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	writel(mask, gpch->regbase + AU1000_GPIO1_ST);
-
-	return 0;
-}
-
-static int au1000_gpio1_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	writel(mask, gpch->regbase + AU1000_GPIO1_TRI_OUT);
-	au1000_gpio1_set(chip, offset, value);
-
-	return 0;
-}
-
-struct au1000_gpio_chip au1000_gpio_chip[] = {
-	[0] = {
-		.regbase			= (void __iomem *)SYS_BASE,
-		.chip = {
-			.label			= "au1000-gpio1",
-			.direction_input	= au1000_gpio1_direction_input,
-			.direction_output	= au1000_gpio1_direction_output,
-			.get			= au1000_gpio1_get,
-			.set			= au1000_gpio1_set,
-			.base			= 0,
-			.ngpio			= 32,
-		},
-	},
-#if !defined(CONFIG_SOC_AU1000)
-	[1] = {
-		.regbase                        = (void __iomem *)GPIO2_BASE,
-		.chip = {
-			.label                  = "au1000-gpio2",
-			.direction_input        = au1000_gpio2_direction_input,
-			.direction_output       = au1000_gpio2_direction_output,
-			.get                    = au1000_gpio2_get,
-			.set                    = au1000_gpio2_set,
-			.base                   = AU1XXX_GPIO_BASE,
-			.ngpio                  = 32,
-		},
-	},
-#endif
-};
-
-static int __init au1000_gpio_init(void)
-{
-	gpiochip_add(&au1000_gpio_chip[0].chip);
-#if !defined(CONFIG_SOC_AU1000)
-	gpiochip_add(&au1000_gpio_chip[1].chip);
-#endif
-
-	return 0;
-}
-arch_initcall(au1000_gpio_init);
-
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
new file mode 100644
index 0000000..127d4ed
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -0,0 +1,604 @@
+/*
+ * GPIO functions for Au1000, Au1500, Au1100, Au1550, Au1200
+ *
+ * Copyright (c) 2009 Manuel Lauss.
+ *
+ * Licensed under the terms outlined in the file COPYING.
+ */
+
+#ifndef _ALCHEMY_GPIO_AU1000_H_
+#define _ALCHEMY_GPIO_AU1000_H_
+
+#include <asm/mach-au1x00/au1000.h>
+
+/* The default GPIO numberspace as documented in the Alchemy manuals.
+ * GPIO0-31 from GPIO1 block,   GPIO200-215 from GPIO2 block.
+ */
+#define ALCHEMY_GPIO1_BASE	0
+#define ALCHEMY_GPIO2_BASE	200
+
+#define ALCHEMY_GPIO1_NUM	32
+#define ALCHEMY_GPIO2_NUM	16
+#define ALCHEMY_GPIO1_MAX 	(ALCHEMY_GPIO1_BASE + ALCHEMY_GPIO1_NUM - 1)
+#define ALCHEMY_GPIO2_MAX	(ALCHEMY_GPIO2_BASE + ALCHEMY_GPIO2_NUM - 1)
+
+#define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
+
+
+static inline int au1000_gpio1_to_irq(int gpio)
+{
+	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
+}
+
+static inline int au1000_gpio2_to_irq(int gpio)
+{
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1000
+static inline int au1000_irq_to_gpio(int irq)
+{
+	if ((irq >= AU1000_GPIO_0) && (irq <= AU1000_GPIO_31))
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+
+	return -ENXIO;
+}
+#endif
+
+static inline int au1500_gpio1_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO1_BASE;
+
+	switch (gpio) {
+	case 0 ... 15:
+	case 20:
+	case 23 ... 28:	return MAKE_IRQ(1, gpio);
+	}
+
+	return -ENXIO;
+}
+
+static inline int au1500_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	switch (gpio) {
+	case 0 ... 3:	return MAKE_IRQ(1, 16 + gpio - 0);
+	case 4 ... 5:	return MAKE_IRQ(1, 21 + gpio - 4);
+	case 6 ... 7:	return MAKE_IRQ(1, 29 + gpio - 6);
+	}
+
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1500
+static inline int au1500_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0 ... AU1000_GPIO_15:
+	case AU1500_GPIO_20:
+	case AU1500_GPIO_23 ... AU1500_GPIO_28:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1500_GPIO_200 ... AU1500_GPIO_203:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_200) + 0;
+	case AU1500_GPIO_204 ... AU1500_GPIO_205:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_204) + 4;
+	case AU1500_GPIO_206 ... AU1500_GPIO_207:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
+	case AU1500_GPIO_208_215:
+		return ALCHEMY_GPIO2_BASE + 8;
+	}
+
+	return -ENXIO;
+}
+#endif
+
+static inline int au1100_gpio1_to_irq(int gpio)
+{
+	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
+}
+
+static inline int au1100_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	if ((gpio >= 8) && (gpio <= 15))
+		return MAKE_IRQ(0, 29);		/* shared GPIO208_215 */
+}
+
+#ifdef CONFIG_SOC_AU1100
+static inline int au1100_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0 ... AU1000_GPIO_31:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1100_GPIO_208_215:
+		return ALCHEMY_GPIO2_BASE + 8;
+	}
+
+	return -ENXIO;
+}
+#endif
+
+static inline int au1550_gpio1_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO1_BASE;
+
+	switch (gpio) {
+	case 0 ... 15:
+	case 20 ... 28:	return MAKE_IRQ(1, gpio);
+	case 16 ... 17:	return MAKE_IRQ(1, 18 + gpio - 16);
+	}
+
+	return -ENXIO;
+}
+
+static inline int au1550_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	switch (gpio) {
+	case 0:		return MAKE_IRQ(1, 16);
+	case 1 ... 5:	return MAKE_IRQ(1, 17);	/* shared GPIO201_205 */
+	case 6 ... 7:	return MAKE_IRQ(1, 29 + gpio - 6);
+	case 8 ... 15:	return MAKE_IRQ(1, 31);	/* shared GPIO208_215 */
+	}
+
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1550
+static inline int au1550_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0 ... AU1000_GPIO_15:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1550_GPIO_200:
+	case AU1500_GPIO_201_205:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1550_GPIO_200) + 0;
+	case AU1500_GPIO_16 ... AU1500_GPIO_28:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1500_GPIO_16) + 16;
+	case AU1500_GPIO_206 ... AU1500_GPIO_208_218:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
+	}
+
+	return -ENXIO;
+}
+#endif
+
+static inline int au1200_gpio1_to_irq(int gpio)
+{
+	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
+}
+
+static inline int au1200_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	switch (gpio) {
+	case 0 ... 2:	return MAKE_IRQ(0, 5 + gpio - 0);
+	case 3:		return MAKE_IRQ(0, 22);
+	case 4 ... 7:	return MAKE_IRQ(0, 24 + gpio - 4);
+	case 8 ... 15:	return MAKE_IRQ(0, 28);	/* shared GPIO208_215 */
+	}
+
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1200
+static inline int au1200_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0 ... AU1000_GPIO_31:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1200_GPIO_200 ... AU1200_GPIO_202:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_200) + 0;
+	case AU1200_GPIO_203:
+		return ALCHEMY_GPIO2_BASE + 3;
+	case AU1200_GPIO_204 ... AU1200_GPIO_208_215:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_204) + 4;
+	}
+
+	return -ENXIO;
+}
+#endif
+
+/*
+ * GPIO1 block macros for common linux gpio functions.
+ */
+static inline void alchemy_gpio1_set_value(int gpio, int v)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
+	unsigned long r = v ? SYS_OUTPUTSET : SYS_OUTPUTCLR;
+	au_writel(mask, r);
+	au_sync();
+}
+
+static inline int alchemy_gpio1_get_value(int gpio)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
+	return au_readl(SYS_PINSTATERD) & mask;
+}
+
+static inline int alchemy_gpio1_direction_input(int gpio)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
+	au_writel(mask, SYS_TRIOUTCLR);
+	au_sync();
+	return 0;
+}
+
+static inline int alchemy_gpio1_direction_output(int gpio, int v)
+{
+	/* hardware switches to "output" mode when one of the two
+	 * "set_value" registers is accessed.
+	 */
+	alchemy_gpio1_set_value(gpio, v);
+	return 0;
+}
+
+static inline int alchemy_gpio1_is_valid(int gpio)
+{
+	return ((gpio >= ALCHEMY_GPIO1_BASE) && (gpio <= ALCHEMY_GPIO1_MAX));
+}
+
+static inline int alchemy_gpio1_to_irq(int gpio)
+{
+#if defined(CONFIG_SOC_AU1000)
+	return au1000_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1100)
+	return au1100_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1500)
+	return au1500_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1550)
+	return au1550_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1200)
+	return au1200_gpio1_to_irq(gpio);
+#else
+	return -ENXIO;
+#endif
+}
+
+/*
+ * GPIO2 block macros for common linux GPIO functions. The 'gpio'
+ * parameter must be in range of ALCHEMY_GPIO2_BASE..ALCHEMY_GPIO2_MAX.
+ */
+static inline void __alchemy_gpio2_mod_dir(int gpio, int to_out)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
+	unsigned long d = au_readl(GPIO2_DIR);
+	if (to_out)
+		d |= mask;
+	else
+		d &= ~mask;
+	au_writel(d, GPIO2_DIR);
+	au_sync();
+}
+
+static inline void alchemy_gpio2_set_value(int gpio, int v)
+{
+	unsigned long mask;
+	mask = ((v) ? 0x00010001 : 0x00010000) << (gpio - ALCHEMY_GPIO2_BASE);
+	au_writel(mask, GPIO2_OUTPUT);
+	au_sync();
+}
+
+static inline int alchemy_gpio2_get_value(int gpio)
+{
+	return au_readl(GPIO2_PINSTATE) & (1 << (gpio - ALCHEMY_GPIO2_BASE));
+}
+
+static inline int alchemy_gpio2_direction_input(int gpio)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	__alchemy_gpio2_mod_dir(gpio, 0);
+	local_irq_restore(flags);
+	return 0;
+}
+
+static inline int alchemy_gpio2_direction_output(int gpio, int v)
+{
+	unsigned long flags;
+	alchemy_gpio2_set_value(gpio, v);
+	local_irq_save(flags);
+	__alchemy_gpio2_mod_dir(gpio, 1);
+	local_irq_restore(flags);
+	return 0;
+}
+
+static inline int alchemy_gpio2_is_valid(int gpio)
+{
+	return ((gpio >= ALCHEMY_GPIO2_BASE) && (gpio <= ALCHEMY_GPIO2_MAX));
+}
+
+static inline int alchemy_gpio2_to_irq(int gpio)
+{
+#if defined(CONFIG_SOC_AU1000)
+	return au1000_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1100)
+	return au1100_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1500)
+	return au1500_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1550)
+	return au1550_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1200)
+	return au1200_gpio2_to_irq(gpio);
+#else
+	return -ENXIO;
+#endif
+}
+
+/**********************************************************************/
+
+/* On Au1000, Au1500 and Au1100 GPIOs won't work as inputs before
+ * SYS_PININPUTEN is written to at least once.  On Au1550/Au1200 this
+ * register enables use of GPIOs as wake source.
+ */
+static inline void alchemy_gpio1_input_enable(void)
+{
+	au_writel(0, SYS_PININPUTEN);	/* the write op is key */
+	au_sync();
+}
+
+/* GPIO2 shared interrupts and control */
+
+static inline void __alchemy_gpio2_mod_int(int gpio2, int en)
+{
+	unsigned long r = au_readl(GPIO2_INTENABLE);
+	if (en)
+		r |= 1 << gpio2;
+	else
+		r &= ~(1 << gpio2);
+	au_writel(r, GPIO2_INTENABLE);
+	au_sync();
+}
+
+/**
+ * alchemy_gpio2_enable_int - Enable a GPIO2 pins' shared irq contribution.
+ * @gpio2:	The GPIO2 pin to activate (200...215).
+ *
+ * GPIO208-215 have one shared interrupt line to the INTC.  They are
+ * and'ed with a per-pin enable bit and finally or'ed together to form
+ * a single irq request (useful for active-high sources).
+ * With this function, a pins' individual contribution to the int request
+ * can be enabled.  As with all other GPIO-based interrupts, the INTC
+ * must be programmed to accept the GPIO208_215 interrupt as well.
+ *
+ * NOTE: Calling this macro is only necessary for GPIO208-215; all other
+ * GPIO2-based interrupts have their own request to the INTC.  Please
+ * consult your Alchemy databook for more information!
+ *
+ * NOTE: On the Au1550, GPIOs 201-205 also have a shared interrupt request
+ * line to the INTC, GPIO201_205.  This function can be used for those
+ * as well.
+ *
+ * NOTE: 'gpio2' parameter must be in range of the GPIO2 numberspace
+ * (200-215 by default). No sanity checks are made,
+ */
+static inline void alchemy_gpio2_enable_int(int gpio2)
+{
+	unsigned long flags;
+
+	gpio2 -= ALCHEMY_GPIO2_BASE;
+
+#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
+	/* Au1100/Au1500 have GPIO208-215 enable bits at 0..7 */
+	gpio2 -= 8;
+#endif
+	local_irq_save(flags);
+	__alchemy_gpio2_mod_int(gpio2, 1);
+	local_irq_restore(flags);
+}
+
+/**
+ * alchemy_gpio2_disable_int - Disable a GPIO2 pins' shared irq contribution.
+ * @gpio2:	The GPIO2 pin to activate (200...215).
+ *
+ * see function alchemy_gpio2_enable_int() for more information.
+ */
+static inline void alchemy_gpio2_disable_int(int gpio2)
+{
+	unsigned long flags;
+
+	gpio2 -= ALCHEMY_GPIO2_BASE;
+
+#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
+	/* Au1100/Au1500 have GPIO208-215 enable bits at 0..7 */
+	gpio2 -= 8;
+#endif
+	local_irq_save(flags);
+	__alchemy_gpio2_mod_int(gpio2, 0);
+	local_irq_restore(flags);
+}
+
+/**
+ * alchemy_gpio2_enable -  Activate GPIO2 block.
+ *
+ * The GPIO2 block must be enabled excplicitly to work.  On systems
+ * where this isn't done by the bootloader, this macro can be used.
+ */
+static inline void alchemy_gpio2_enable(void)
+{
+	au_writel(3, GPIO2_ENABLE);	/* reset, clock enabled */
+	au_sync();
+	au_writel(1, GPIO2_ENABLE);	/* clock enabled */
+	au_sync();
+}
+
+/**
+ * alchemy_gpio2_disable - disable GPIO2 block.
+ *
+ * Disable and put GPIO2 block in low-power mode.
+ */
+static inline void alchemy_gpio2_disable(void)
+{
+	au_writel(2, GPIO2_ENABLE);	/* reset, clock disabled */
+	au_sync();
+}
+
+/**********************************************************************/
+
+/* wrappers for on-chip gpios; can be used before gpio chips have been
+ * registered with gpiolib.
+ */
+static inline int alchemy_gpio_direction_input(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_direction_input(gpio) :
+		alchemy_gpio1_direction_input(gpio);
+}
+
+static inline int alchemy_gpio_direction_output(int gpio, int v)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_direction_output(gpio, v) :
+		alchemy_gpio1_direction_output(gpio, v);
+}
+
+static inline int alchemy_gpio_get_value(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_get_value(gpio) :
+		alchemy_gpio1_get_value(gpio);
+}
+
+static inline void alchemy_gpio_set_value(int gpio, int v)
+{
+	if (gpio >= ALCHEMY_GPIO2_BASE)
+		alchemy_gpio2_set_value(gpio, v);
+	else
+		alchemy_gpio1_set_value(gpio, v);
+}
+
+static inline int alchemy_gpio_is_valid(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_is_valid(gpio) :
+		alchemy_gpio1_is_valid(gpio);
+}
+
+static inline int alchemy_gpio_cansleep(int gpio)
+{
+	return 0;	/* Alchemy never gets tired */
+}
+
+static inline int alchemy_gpio_to_irq(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_to_irq(gpio) :
+		alchemy_gpio1_to_irq(gpio);
+}
+
+static inline int alchemy_irq_to_gpio(int irq)
+{
+#if defined(CONFIG_SOC_AU1000)
+	return au1000_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1100)
+	return au1100_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1500)
+	return au1500_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1550)
+	return au1550_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1200)
+	return au1200_irq_to_gpio(irq);
+#else
+	return -ENXIO;
+#endif
+}
+
+/**********************************************************************/
+
+/* Linux gpio framework integration.
+ *
+ * 4 use cases of Au1000-Au1200 GPIOS:
+ *(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
+ *	Board must register gpiochips.
+ *(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
+ *	2 (1 for Au1000) gpio_chips are registered.
+ *
+ *(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
+ *	the boards' gpio.h must provide	the linux gpio wrapper functions,
+ *
+ *(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
+ *	inlinable gpio functions are provided which enable access to the
+ *	Au1000 gpios only by using the numbers straight out of the data-
+ *	sheets.
+
+ * Cases 1 and 3 are intended for boards which want to provide their own
+ * GPIO namespace and -operations (i.e. for example you have 8 GPIOs
+ * which are in part provided by spare Au1000 GPIO pins and in part by
+ * an external FPGA but you still want them to be accssible in linux
+ * as gpio0-7. The board can of course use the alchemy_gpioX_* functions
+ * as required).
+ */
+
+#ifndef CONFIG_GPIOLIB
+
+
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (4) */
+
+static inline int gpio_direction_input(int gpio)
+{
+	return alchemy_gpio_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(int gpio, int v)
+{
+	return alchemy_gpio_direction_output(gpio, v);
+}
+
+static inline int gpio_get_value(int gpio)
+{
+	return alchemy_gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(int gpio, int v)
+{
+	alchemy_gpio_set_value(gpio, v);
+}
+
+static inline int gpio_is_valid(int gpio)
+{
+	return alchemy_gpio_is_valid(gpio);
+}
+
+static inline int gpio_cansleep(int gpio)
+{
+	return alchemy_gpio_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(int gpio)
+{
+	return alchemy_gpio_to_irq(gpio);
+}
+
+static inline int irq_to_gpio(int irq)
+{
+	return alchemy_irq_to_gpio(irq);
+}
+
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#else	/* CONFIG GPIOLIB */
+
+
+ /* using gpiolib to provide up to 2 gpio_chips for on-chip gpios */
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (2) */
+
+/* get everything through gpiolib */
+#define gpio_to_irq	__gpio_to_irq
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define irq_to_gpio	alchemy_irq_to_gpio
+
+#include <asm-generic/gpio.h>
+
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#endif	/* !CONFIG_GPIOLIB */
+
+#endif /* _ALCHEMY_GPIO_AU1000_H_ */
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index 34d9b72..f9b7d41 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -1,33 +1,10 @@
-#ifndef _AU1XXX_GPIO_H_
-#define _AU1XXX_GPIO_H_
+#ifndef _ALCHEMY_GPIO_H_
+#define _ALCHEMY_GPIO_H_
 
-#include <linux/types.h>
+#if defined(CONFIG_ALCHEMY_GPIO_AU1000)
 
-#define AU1XXX_GPIO_BASE	200
+#include <asm/mach-au1x00/gpio-au1000.h>
 
-/* GPIO bank 1 offsets */
-#define AU1000_GPIO1_TRI_OUT	0x0100
-#define AU1000_GPIO1_OUT	0x0108
-#define AU1000_GPIO1_ST		0x0110
-#define AU1000_GPIO1_CLR	0x010C
+#endif
 
-/* GPIO bank 2 offsets */
-#define AU1000_GPIO2_DIR	0x00
-#define AU1000_GPIO2_RSVD	0x04
-#define AU1000_GPIO2_OUT	0x08
-#define AU1000_GPIO2_ST		0x0C
-#define AU1000_GPIO2_INT	0x10
-#define AU1000_GPIO2_EN		0x14
-
-#define GPIO2_OUT_EN_MASK	0x00010000
-
-#define gpio_to_irq(gpio)	NULL
-
-#define gpio_get_value __gpio_get_value
-#define gpio_set_value __gpio_set_value
-
-#define gpio_cansleep __gpio_cansleep
-
-#include <asm-generic/gpio.h>
-
-#endif /* _AU1XXX_GPIO_H_ */
+#endif	/* _ALCHEMY_GPIO_H_ */
-- 
1.6.3.1
