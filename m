Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:34:09 +0200 (CEST)
Received: from mail-la0-f48.google.com ([209.85.215.48]:62113 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008892AbaINTb6ouoeF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:31:58 +0200
Received: by mail-la0-f48.google.com with SMTP id ty20so3576167lab.35
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c6uR9pYPT2L0gqkRkgfohj/jRWPmqcNQXkCSmMsKrXA=;
        b=xfwXW0rWF08aADPhMWhRJQ4uAzyjlRkCFczjkxMXUXrtF3h8BpPYjRdQudOqR8HIoV
         pxnHAZ3i5d03TDxZ+wBQmlTXaQgsh5smOxne6Kf6YOswkkG3XX4bxyW2EyZdjhP535Gt
         cavO2X2g6jkCEbtTcKWiu6vmLYxorhBPfzKK3wbyu/z5m20dsJEDqubJV1AJFiAu7Ktx
         hHrpr2P9KjG6grj1WsFcw06jTGUhygNfkuCOAjrCFEJKHUmCFIb9eCkXK326GW5zIpk1
         kjz0o+DlGp1UTdbmqlu34E9fCTbJn+/L3q3O34C4/oFcFgr1+1nI0PCraZKq6HRgs30C
         hBMg==
X-Received: by 10.112.24.104 with SMTP id t8mr22443818lbf.46.1410723113381;
        Sun, 14 Sep 2014 12:31:53 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:52 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org
Subject: [RFC 08/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
Date:   Sun, 14 Sep 2014 23:33:23 +0400
Message-Id: <1410723213-22440-9-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Atheros AR5312 SoC have a builtin GPIO controller, which could be accessed
via memory mapped registers. This patch adds new driver for them.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org
---
 arch/mips/ar231x/Kconfig                        |   1 +
 arch/mips/ar231x/ar5312.c                       |  19 ++++
 arch/mips/include/asm/mach-ar231x/ar5312_regs.h |   2 +
 drivers/gpio/Kconfig                            |   7 ++
 drivers/gpio/Makefile                           |   1 +
 drivers/gpio/gpio-ar5312.c                      | 121 ++++++++++++++++++++++++
 6 files changed, 151 insertions(+)
 create mode 100644 drivers/gpio/gpio-ar5312.c

diff --git a/arch/mips/ar231x/Kconfig b/arch/mips/ar231x/Kconfig
index aa0fceb..378a6e1 100644
--- a/arch/mips/ar231x/Kconfig
+++ b/arch/mips/ar231x/Kconfig
@@ -1,6 +1,7 @@
 config SOC_AR5312
 	bool "Atheros AR5312/AR2312+ SoC support"
 	depends on AR231X
+	select GPIO_AR5312
 	default y
 
 config SOC_AR2315
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 56cb0d7..8683eb6 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -118,6 +119,22 @@ void __init ar5312_arch_init_irq(void)
 	irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
 }
 
+static struct resource ar5312_gpio_res[] = {
+	{
+		.name = "ar5312-gpio",
+		.flags = IORESOURCE_MEM,
+		.start = AR5312_GPIO,
+		.end = AR5312_GPIO + 0x0c - 1,
+	},
+};
+
+static struct platform_device ar5312_gpio = {
+	.name = "ar5312-gpio",
+	.id = -1,
+	.resource = ar5312_gpio_res,
+	.num_resources = ARRAY_SIZE(ar5312_gpio_res),
+};
+
 static void __init ar5312_flash_init(void)
 {
 	u32 ctl;
@@ -157,6 +174,8 @@ void __init ar5312_init_devices(void)
 
 	/* Locate board/radio config data */
 	ar231x_find_config(ar5312_flash_limit);
+
+	platform_device_register(&ar5312_gpio);
 }
 
 static void ar5312_restart(char *command)
diff --git a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
index 0b4cee8..104c558 100644
--- a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
+++ b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
@@ -210,4 +210,6 @@
 #define AR5312_MEM_CFG1_AC1_M	0x00007000	/* bank 1: SDRAM addr check */
 #define AR5312_MEM_CFG1_AC1_S	12
 
+#define AR5312_GPIO		(AR5312_APBBASE  + 0x2000)
+
 #endif	/* __ASM_MACH_AR231X_AR5312_REGS_H */
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9de1515..7ce411b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -112,6 +112,13 @@ config GPIO_MAX730X
 
 comment "Memory mapped GPIO drivers:"
 
+config GPIO_AR5312
+	bool "AR5312 SoC GPIO support"
+	default y if SOC_AR5312
+	depends on SOC_AR5312
+	help
+	  Say yes here to enable GPIO support for Atheros AR5312/AR2312+ SoCs.
+
 config GPIO_CLPS711X
 	tristate "CLPS711X GPIO support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 5d024e3..fae00f4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_GPIO_ADNP)		+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)	+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
+obj-$(CONFIG_GPIO_AR5312)	+= gpio-ar5312.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
diff --git a/drivers/gpio/gpio-ar5312.c b/drivers/gpio/gpio-ar5312.c
new file mode 100644
index 0000000..27adb61
--- /dev/null
+++ b/drivers/gpio/gpio-ar5312.c
@@ -0,0 +1,121 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2012 Alexandros C. Couloumbis <alex@ozo.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#define DRIVER_NAME	"ar5312-gpio"
+
+#define AR5312_GPIO_DO		0x00		/* output register */
+#define AR5312_GPIO_DI		0x04		/* intput register */
+#define AR5312_GPIO_CR		0x08		/* control register */
+
+#define AR5312_GPIO_CR_M(x)	(1 << (x))	/* mask for i/o */
+#define AR5312_GPIO_CR_O(x)	(0 << (x))	/* mask for output */
+#define AR5312_GPIO_CR_I(x)	(1 << (x))	/* mask for input */
+#define AR5312_GPIO_CR_INT(x)	(1 << ((x)+8))	/* mask for interrupt */
+#define AR5312_GPIO_CR_UART(x)	(1 << ((x)+16))	/* uart multiplex */
+
+#define AR5312_GPIO_NUM		8
+
+static void __iomem *ar5312_mem;
+
+static inline u32 ar5312_gpio_reg_read(unsigned reg)
+{
+	return __raw_readl(ar5312_mem + reg);
+}
+
+static inline void ar5312_gpio_reg_write(unsigned reg, u32 val)
+{
+	__raw_writel(val, ar5312_mem + reg);
+}
+
+static inline void ar5312_gpio_reg_mask(unsigned reg, u32 mask, u32 val)
+{
+	ar5312_gpio_reg_write(reg, (ar5312_gpio_reg_read(reg) & ~mask) | val);
+}
+
+static int ar5312_gpio_get_val(struct gpio_chip *chip, unsigned gpio)
+{
+	return (ar5312_gpio_reg_read(AR5312_GPIO_DI) >> gpio) & 1;
+}
+
+static void ar5312_gpio_set_val(struct gpio_chip *chip, unsigned gpio, int val)
+{
+	u32 reg = ar5312_gpio_reg_read(AR5312_GPIO_DO);
+
+	reg = val ? reg | (1 << gpio) : reg & ~(1 << gpio);
+	ar5312_gpio_reg_write(AR5312_GPIO_DO, reg);
+}
+
+static int ar5312_gpio_dir_in(struct gpio_chip *chip, unsigned gpio)
+{
+	ar5312_gpio_reg_mask(AR5312_GPIO_CR, 0, 1 << gpio);
+	return 0;
+}
+
+static int ar5312_gpio_dir_out(struct gpio_chip *chip, unsigned gpio, int val)
+{
+	ar5312_gpio_reg_mask(AR5312_GPIO_CR, 1 << gpio, 0);
+	ar5312_gpio_set_val(chip, gpio, val);
+	return 0;
+}
+
+static struct gpio_chip ar5312_gpio_chip = {
+	.label			= DRIVER_NAME,
+	.direction_input	= ar5312_gpio_dir_in,
+	.direction_output	= ar5312_gpio_dir_out,
+	.set			= ar5312_gpio_set_val,
+	.get			= ar5312_gpio_get_val,
+	.base			= 0,
+	.ngpio			= AR5312_GPIO_NUM,
+};
+
+static int ar5312_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	if (ar5312_mem)
+		return -EBUSY;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ar5312_mem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ar5312_mem))
+		return PTR_ERR(ar5312_mem);
+
+	ar5312_gpio_chip.dev = dev;
+	ret = gpiochip_add(&ar5312_gpio_chip);
+	if (ret) {
+		dev_err(dev, "failed to add gpiochip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver ar5312_gpio_driver = {
+	.probe = ar5312_gpio_probe,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	}
+};
+
+static int __init ar5312_gpio_init(void)
+{
+	return platform_driver_register(&ar5312_gpio_driver);
+}
+subsys_initcall(ar5312_gpio_init);
-- 
1.8.1.5
