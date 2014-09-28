Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:34:01 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:58222 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010016AbaI1SbZe1sCW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:25 +0200
Received: by mail-la0-f41.google.com with SMTP id pn19so1497893lab.28
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jo6H2SCEoj3LKOGbA/3vCXFJYd8gjpqcAjqcPw3Z+SE=;
        b=zzZYLe/8VEdu7bXlcusvoVuquEXjKszXv+0SDm/+nqr7ThzWwmNeVkgXJEmFuhYn6x
         7wRhNrwJwkjEe9Tw7BiLD9kBf3y0q8Q/930jGlygtUIn7tKJyNL09M2pUbvGPTdOiin2
         0aCfs4lImxTUeyUJFFWkE8UVVSPovRGnV2pvyuF0R2GQ7iO8ALwBMZebaQNhx3EkOWSp
         4Xsj9KYjQ/7zNrg3WHSPUlMPMBIZTZOwNcousOVThaCSGl+ojXDSEm0O30a1V1kmmK1Q
         9hVBubcYJgzngRZGl+UCofNsVG6IKBAnyE1C596aS7j2qLEluAzBZuGn3peaGsMeE+36
         sy8A==
X-Received: by 10.112.218.70 with SMTP id pe6mr30947886lbc.65.1411929080198;
        Sun, 28 Sep 2014 11:31:20 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:19 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 10/16] gpio: add driver for Atheros AR2315 SoC GPIO controller
Date:   Sun, 28 Sep 2014 22:33:09 +0400
Message-Id: <1411929195-23775-11-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42861
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

Atheros AR2315 SoC have a builtin GPIO controller, which could be
accessed via memory mapped registers. This patch adds new driver
for them.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org
---

Changes since RFC:
  - fix chip name, this patch adds AR2315 GPIO controller driver
  - use dynamic IRQ numbers allocation
  - move device registration to separate patch

 drivers/gpio/Kconfig       |   7 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-ar2315.c | 232 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/gpio/gpio-ar2315.c

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
index 0000000..2a6caaf
--- /dev/null
+++ b/drivers/gpio/gpio-ar2315.c
@@ -0,0 +1,232 @@
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
+	ret = irq_alloc_descs(-1, 0, AR2315_GPIO_NUM, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to allocate IRQ numbers\n");
+		return ret;
+	}
+	ar2315_gpio_irq_base = ret;
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
1.8.5.5
