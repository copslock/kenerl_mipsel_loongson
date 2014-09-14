Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:34:28 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:39922 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008893AbaINTcA0UAwu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:32:00 +0200
Received: by mail-la0-f49.google.com with SMTP id pv20so3501569lab.36
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mafqBt/yLhu8R4e/hbFjwJE/Dv9EF0wW8kL3Uyk0BiQ=;
        b=yk7A17bA3mNWI+xoa95MSqBat2+6zPhvIaNB/trqbl+qXBXEiXkgpzRzNOmGnperGS
         vjqq6jvgIVZa1kFEZZZSLU2fUJ92B2z4Q6UnwcSzbr/MoigxzyX1syr/JU8+wr/M/06+
         VbG/TYSyUgZFtLmQDE+kRHGCaVRs6gCuNn7G/VX+vPK3XrVMQbqc4P5jNWoDvbumsWSN
         Q1RI53lebsFxy2lqQ5JLR7SH5ua3GklzpuGWwQsuHTbYLFZN5aPFMwR4qdCWtJ/ZvE+S
         LRng7Vy0mvSn/0lWWMBMkPdN4TJl1AbXuaRN613eQmRGa0EjZCKnCuuHevezgTYL2OfE
         sRFA==
X-Received: by 10.112.138.226 with SMTP id qt2mr4254402lbb.14.1410723114977;
        Sun, 14 Sep 2014 12:31:54 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:54 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org
Subject: [RFC 09/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
Date:   Sun, 14 Sep 2014 23:33:24 +0400
Message-Id: <1410723213-22440-10-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42552
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

Atheros AR5312 SoC have a builtin GPIO controller, which could be
accessed via memory mapped registers. This patch adds new driver
for them.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org
---
 arch/mips/ar231x/Kconfig                        |   1 +
 arch/mips/ar231x/ar2315.c                       |  49 ++++-
 arch/mips/include/asm/mach-ar231x/ar2315_regs.h |   5 +
 arch/mips/include/asm/mach-ar231x/ar231x.h      |   1 +
 drivers/gpio/Kconfig                            |   7 +
 drivers/gpio/Makefile                           |   1 +
 drivers/gpio/gpio-ar2315.c                      | 233 ++++++++++++++++++++++++
 7 files changed, 294 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpio/gpio-ar2315.c

diff --git a/arch/mips/ar231x/Kconfig b/arch/mips/ar231x/Kconfig
index 378a6e1..88ca061 100644
--- a/arch/mips/ar231x/Kconfig
+++ b/arch/mips/ar231x/Kconfig
@@ -7,4 +7,5 @@ config SOC_AR5312
 config SOC_AR2315
 	bool "Atheros AR2315+ SoC support"
 	depends on AR231X
+	select GPIO_AR2315
 	default y
diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index a766b0d..06074cb 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -16,7 +16,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
@@ -53,7 +56,10 @@ static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
 		generic_handle_irq(AR2315_MISC_IRQ_TIMER);
 	else if (pending & AR2315_ISR_AHB)
 		generic_handle_irq(AR2315_MISC_IRQ_AHB);
-	else if (pending & AR2315_ISR_UART0)
+	else if (pending & AR2315_ISR_GPIO) {
+		ar231x_write_reg(AR2315_ISR, AR2315_ISR_GPIO);
+		generic_handle_irq(AR2315_MISC_IRQ_GPIO);
+	} else if (pending & AR2315_ISR_UART0)
 		generic_handle_irq(AR2315_MISC_IRQ_UART0);
 	else
 		spurious_interrupt();
@@ -119,6 +125,34 @@ void __init ar2315_arch_init_irq(void)
 	irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
 }
 
+static struct resource ar2315_gpio_res[] = {
+	{
+		.name = "ar2315-gpio",
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_GPIO,
+		.end = AR2315_GPIO + 0x10 - 1,
+	},
+	{
+		.name = "ar2315-gpio",
+		.flags = IORESOURCE_IRQ,
+		.start = AR2315_MISC_IRQ_GPIO,
+		.end = AR2315_MISC_IRQ_GPIO,
+	},
+	{
+		.name = "ar2315-gpio-irq-base",
+		.flags = IORESOURCE_IRQ,
+		.start = AR231X_GPIO_IRQ_BASE,
+		.end = AR231X_GPIO_IRQ_BASE,
+	}
+};
+
+static struct platform_device ar2315_gpio = {
+	.id = -1,
+	.name = "ar2315-gpio",
+	.resource = ar2315_gpio_res,
+	.num_resources = ARRAY_SIZE(ar2315_gpio_res)
+};
+
 /*
  * NB: We use mapping size that is larger than the actual flash size,
  * but this shouldn't be a problem here, because the flash will simply
@@ -134,6 +168,8 @@ void __init ar2315_init_devices(void)
 
 	/* Find board configuration */
 	ar231x_find_config(ar2315_flash_limit);
+
+	platform_device_register(&ar2315_gpio);
 }
 
 static void ar2315_restart(char *command)
@@ -145,8 +181,15 @@ static void ar2315_restart(char *command)
 	/* try reset the system via reset control */
 	ar231x_write_reg(AR2315_COLD_RESET, AR2317_RESET_SYSTEM);
 
-	/* Attempt to jump to the mips reset location - the boot loader
-	 * itself might be able to recover the system */
+	/* Cold reset does not work on the AR2315/6, use the GPIO reset bits
+	 * a workaround. Give it some time to attempt a gpio based hardware
+	 * reset (atheros reference design workaround) */
+	gpio_request_one(AR2315_RESET_GPIO, GPIOF_OUT_INIT_LOW, "Reset");
+	mdelay(100);
+
+	/* Some boards (e.g. Senao EOC-2610) don't implement the reset logic
+	 * workaround. Attempt to jump to the mips reset location -
+	 * the boot loader itself might be able to recover the system */
 	mips_reset_vec();
 }
 
diff --git a/arch/mips/include/asm/mach-ar231x/ar2315_regs.h b/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
index 27f5490..dd7df42 100644
--- a/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
+++ b/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
@@ -283,6 +283,11 @@
 #define AR2315_AMBACLK_CLK_DIV_M	0x0000000c
 #define AR2315_AMBACLK_CLK_DIV_S	2
 
+/* GPIO MMR base address */
+#define AR2315_GPIO			(AR2315_DSLBASE + 0x0088)
+
+#define AR2315_RESET_GPIO	5
+
 /*
  *  PCI Clock Control
  */
diff --git a/arch/mips/include/asm/mach-ar231x/ar231x.h b/arch/mips/include/asm/mach-ar231x/ar231x.h
index 69702b2..259001d 100644
--- a/arch/mips/include/asm/mach-ar231x/ar231x.h
+++ b/arch/mips/include/asm/mach-ar231x/ar231x.h
@@ -4,6 +4,7 @@
 #include <linux/io.h>
 
 #define AR231X_MISC_IRQ_BASE		0x20
+#define AR231X_GPIO_IRQ_BASE		0x30
 
 #define AR231X_IRQ_CPU_CLOCK	(MIPS_CPU_IRQ_BASE + 7)	/* C0_CAUSE: 0x8000 */
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7ce411b..0ceb4ba 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -112,6 +112,13 @@ config GPIO_MAX730X
 
 comment "Memory mapped GPIO drivers:"
 
+config GPIO_AR2315
+	bool "AR2315 SoC GPIO support"
+	default y if SOC_AR2315
+	depends on SOC_AR2315
+	help
+	  Say yes here to enable GPIO support for Atheros AR2315+ SoCs.
+
 config GPIO_AR5312
 	bool "AR5312 SoC GPIO support"
 	default y if SOC_AR5312
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fae00f4..9a3a136 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_GPIO_ADNP)		+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)	+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
+obj-$(CONFIG_GPIO_AR2315)	+= gpio-ar2315.o
 obj-$(CONFIG_GPIO_AR5312)	+= gpio-ar5312.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
diff --git a/drivers/gpio/gpio-ar2315.c b/drivers/gpio/gpio-ar2315.c
new file mode 100644
index 0000000..00e3101
--- /dev/null
+++ b/drivers/gpio/gpio-ar2315.c
@@ -0,0 +1,233 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2012 Alexandros C. Couloumbis <alex@ozo.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+
+#define DRIVER_NAME	"ar2315-gpio"
+
+#define AR2315_GPIO_DI			0x0000
+#define AR2315_GPIO_DO			0x0008
+#define AR2315_GPIO_DIR			0x0010
+#define AR2315_GPIO_INT			0x0018
+
+#define AR2315_GPIO_DIR_M(x)		(1 << (x))	/* mask for i/o */
+#define AR2315_GPIO_DIR_O(x)		(1 << (x))	/* output */
+#define AR2315_GPIO_DIR_I(x)		(0)		/* input */
+
+#define AR2315_GPIO_INT_NUM_M		0x3F		/* mask for GPIO num */
+#define AR2315_GPIO_INT_TRIG(x)		((x) << 6)	/* interrupt trigger */
+#define AR2315_GPIO_INT_TRIG_M		(0x3 << 6)	/* mask for int trig */
+
+#define AR2315_GPIO_INT_TRIG_OFF	0	/* Triggerring off */
+#define AR2315_GPIO_INT_TRIG_LOW	1	/* Low Level Triggered */
+#define AR2315_GPIO_INT_TRIG_HIGH	2	/* High Level Triggered */
+#define AR2315_GPIO_INT_TRIG_EDGE	3	/* Edge Triggered */
+
+#define AR2315_GPIO_NUM		22
+
+static u32 ar2315_gpio_intmask;
+static u32 ar2315_gpio_intval;
+static unsigned ar2315_gpio_irq_base;
+static void __iomem *ar2315_mem;
+
+static inline u32 ar2315_gpio_reg_read(unsigned reg)
+{
+	return __raw_readl(ar2315_mem + reg);
+}
+
+static inline void ar2315_gpio_reg_write(unsigned reg, u32 val)
+{
+	__raw_writel(val, ar2315_mem + reg);
+}
+
+static inline void ar2315_gpio_reg_mask(unsigned reg, u32 mask, u32 val)
+{
+	ar2315_gpio_reg_write(reg, (ar2315_gpio_reg_read(reg) & ~mask) | val);
+}
+
+static void ar2315_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	u32 pend;
+	int bit = -1;
+
+	/* only do one gpio interrupt at a time */
+	pend = ar2315_gpio_reg_read(AR2315_GPIO_DI);
+	pend ^= ar2315_gpio_intval;
+	pend &= ar2315_gpio_intmask;
+
+	if (pend) {
+		bit = fls(pend) - 1;
+		pend &= ~(1 << bit);
+		ar2315_gpio_intval ^= (1 << bit);
+	}
+
+	/* Enable interrupt with edge detection */
+	if ((ar2315_gpio_reg_read(AR2315_GPIO_DIR) & AR2315_GPIO_DIR_M(bit)) !=
+	    AR2315_GPIO_DIR_I(bit))
+		return;
+
+	if (bit >= 0)
+		generic_handle_irq(ar2315_gpio_irq_base + bit);
+}
+
+static void ar2315_gpio_int_setup(unsigned gpio, int trig)
+{
+	u32 reg = ar2315_gpio_reg_read(AR2315_GPIO_INT);
+
+	reg &= ~(AR2315_GPIO_INT_NUM_M | AR2315_GPIO_INT_TRIG_M);
+	reg |= gpio | AR2315_GPIO_INT_TRIG(trig);
+	ar2315_gpio_reg_write(AR2315_GPIO_INT, reg);
+}
+
+static void ar2315_gpio_irq_unmask(struct irq_data *d)
+{
+	unsigned gpio = d->irq - ar2315_gpio_irq_base;
+	u32 dir = ar2315_gpio_reg_read(AR2315_GPIO_DIR);
+
+	/* Enable interrupt with edge detection */
+	if ((dir & AR2315_GPIO_DIR_M(gpio)) != AR2315_GPIO_DIR_I(gpio))
+		return;
+
+	ar2315_gpio_intmask |= (1 << gpio);
+	ar2315_gpio_int_setup(gpio, AR2315_GPIO_INT_TRIG_EDGE);
+}
+
+static void ar2315_gpio_irq_mask(struct irq_data *d)
+{
+	unsigned gpio = d->irq - ar2315_gpio_irq_base;
+
+	/* Disable interrupt */
+	ar2315_gpio_intmask &= ~(1 << gpio);
+	ar2315_gpio_int_setup(gpio, AR2315_GPIO_INT_TRIG_OFF);
+}
+
+static struct irq_chip ar2315_gpio_irq_chip = {
+	.name		= DRIVER_NAME,
+	.irq_unmask	= ar2315_gpio_irq_unmask,
+	.irq_mask	= ar2315_gpio_irq_mask,
+};
+
+static void ar2315_gpio_irq_init(unsigned irq)
+{
+	unsigned i;
+
+	ar2315_gpio_intval = ar2315_gpio_reg_read(AR2315_GPIO_DI);
+	for (i = 0; i < AR2315_GPIO_NUM; i++) {
+		unsigned _irq = ar2315_gpio_irq_base + i;
+
+		irq_set_chip_and_handler(_irq, &ar2315_gpio_irq_chip,
+					 handle_level_irq);
+	}
+	irq_set_chained_handler(irq, ar2315_gpio_irq_handler);
+}
+
+static int ar2315_gpio_get_val(struct gpio_chip *chip, unsigned gpio)
+{
+	return (ar2315_gpio_reg_read(AR2315_GPIO_DI) >> gpio) & 1;
+}
+
+static void ar2315_gpio_set_val(struct gpio_chip *chip, unsigned gpio, int val)
+{
+	u32 reg = ar2315_gpio_reg_read(AR2315_GPIO_DO);
+
+	reg = val ? reg | (1 << gpio) : reg & ~(1 << gpio);
+	ar2315_gpio_reg_write(AR2315_GPIO_DO, reg);
+}
+
+static int ar2315_gpio_dir_in(struct gpio_chip *chip, unsigned gpio)
+{
+	ar2315_gpio_reg_mask(AR2315_GPIO_DIR, 1 << gpio, 0);
+	return 0;
+}
+
+static int ar2315_gpio_dir_out(struct gpio_chip *chip, unsigned gpio, int val)
+{
+	ar2315_gpio_reg_mask(AR2315_GPIO_DIR, 0, 1 << gpio);
+	ar2315_gpio_set_val(chip, gpio, val);
+	return 0;
+}
+
+static int ar2315_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
+{
+	return ar2315_gpio_irq_base + gpio;
+}
+
+static struct gpio_chip ar2315_gpio_chip = {
+	.label			= DRIVER_NAME,
+	.direction_input	= ar2315_gpio_dir_in,
+	.direction_output	= ar2315_gpio_dir_out,
+	.set			= ar2315_gpio_set_val,
+	.get			= ar2315_gpio_get_val,
+	.to_irq			= ar2315_gpio_to_irq,
+	.base			= 0,
+	.ngpio			= AR2315_GPIO_NUM,
+};
+
+static int ar2315_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	unsigned irq;
+	int ret;
+
+	if (ar2315_mem)
+		return -EBUSY;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					   "ar2315-gpio-irq-base");
+	if (!res) {
+		dev_err(dev, "not found GPIO IRQ base\n");
+		return -ENXIO;
+	}
+	ar2315_gpio_irq_base = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, DRIVER_NAME);
+	if (!res) {
+		dev_err(dev, "not found IRQ number\n");
+		return -ENXIO;
+	}
+	irq = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, DRIVER_NAME);
+	ar2315_mem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ar2315_mem))
+		return PTR_ERR(ar2315_mem);
+
+	ar2315_gpio_chip.dev = dev;
+	ret = gpiochip_add(&ar2315_gpio_chip);
+	if (ret) {
+		dev_err(dev, "failed to add gpiochip\n");
+		return ret;
+	}
+
+	ar2315_gpio_irq_init(irq);
+
+	return 0;
+}
+
+static struct platform_driver ar2315_gpio_driver = {
+	.probe = ar2315_gpio_probe,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	}
+};
+
+static int __init ar2315_gpio_init(void)
+{
+	return platform_driver_register(&ar2315_gpio_driver);
+}
+subsys_initcall(ar2315_gpio_init);
-- 
1.8.1.5
