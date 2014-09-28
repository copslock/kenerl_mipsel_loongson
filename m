Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:33:44 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35387 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010003AbaI1SbYrEdiv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:24 +0200
Received: by mail-lb0-f169.google.com with SMTP id u10so3436388lbd.28
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WOtVB4L5uf8UnbfPkcVU89PVkkHPMkPGG1qfk9OTMfc=;
        b=fx82WYdpM/IOQbVXfQ2/WSCZ+YUv7ylR9h42HtNjijmb8WWns1xm6TUnJid5WBEBgx
         jGbcR75loAjlOnOMi1rSUfH0gT5WwvnlrTv7y6q76mVXR/SBtCB0pLNMUSBw615SkTvi
         qXN6FhH126/HMQRKanYTcEvgWATxw7vVvsdgrkX/x/kVRLSrsmN49sJBjqlaRxVEfR3r
         TKPwNP9j01ivr3R+voz5KUzIEpsV51JVwHeNNKICrjsXBqRTvkquzmyrsOQ6Ne/aB6n+
         GLiznlw5o5KYazV6OYQ4pI8NDrRScAhXIoZ4UM7787Y9W+Fcfut0Y2glxqZPhE4sDXUr
         /6fw==
X-Received: by 10.112.55.102 with SMTP id r6mr32108738lbp.23.1411929078202;
        Sun, 28 Sep 2014 11:31:18 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:17 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 09/16] gpio: add driver for Atheros AR5312 SoC GPIO controller
Date:   Sun, 28 Sep 2014 22:33:08 +0400
Message-Id: <1411929195-23775-10-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42860
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

Changes since RFC:
  - move device registration to separate patch

 drivers/gpio/Kconfig       |   7 +++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-ar5312.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/gpio/gpio-ar5312.c

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
1.8.5.5
