Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2012 02:11:58 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58016 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903725Ab2DMAKh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2012 02:10:37 +0200
Received: by obhx4 with SMTP id x4so4183580obh.36
        for <multiple recipients>; Thu, 12 Apr 2012 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=J6d3CZ25j2pnbxc+sKEhtxZNn6Ie9kRlwy/SY5Kf6EY=;
        b=iI2umEGvXE6T+EuGqQlratkZ3YsZnhMcDEHis6/OR24Hd1shgODJsw/nDohDhhDACL
         zNAlDEpldEUyn2f354pTqhcDmzeZsTZxV8GJaRD2joAN0wpa/S/KaRqj6YfIDbTB3OyN
         ISkbhfThU4GjHK23mF22htqiF8ZFavseatBDtt/nqax8/TcWWk5ajoquka9wLBmvA+SE
         dvD7RQo6nOP/ZdTXIm0xlwM522/xKIuoq3xIy0oKMQESwHyrSzc7IdksFZhxSFseiotb
         OB6GGYSSV/svIegPKaFQsrb9TyBtP852kCtNydgbD15VBxE1nVI/+/Qo1Vek8SJAbv9y
         vUtw==
Received: by 10.60.3.6 with SMTP id 6mr213750oey.35.1334275831241;
        Thu, 12 Apr 2012 17:10:31 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b6sm8487559obe.12.2012.04.12.17.10.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 17:10:29 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3D0ARpb007832;
        Thu, 12 Apr 2012 17:10:27 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3D0ARlS007831;
        Thu, 12 Apr 2012 17:10:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] gpio/MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.
Date:   Thu, 12 Apr 2012 17:10:20 -0700
Message-Id: <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
GPIO pins, this driver handles them all.  Configuring the pins as
interrupt sources is handled elsewhere (OCTEON's irq handling code).

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/gpio/Kconfig       |    8 ++
 drivers/gpio/Makefile      |    1 +
 drivers/gpio/gpio-octeon.c |  166 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/gpio-octeon.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index edadbda..d9d924c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -136,6 +136,14 @@ config GPIO_MXS
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
+config GPIO_OCTEON
+	tristate "Cavium OCTEON GPIO"
+	depends on GPIOLIB && CPU_CAVIUM_OCTEON
+	default y
+	help
+	  Say yes here to support the on-chip GPIO lines on the OCTEON
+	  family of SOCs.
+
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
 	depends on ARM_AMBA
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 007f54b..ce0348c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
 obj-$(CONFIG_PLAT_NOMADIK)	+= gpio-nomadik.o
+obj-$(CONFIG_GPIO_OCTEON)	+= gpio-octeon.o
 obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
 obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
new file mode 100644
index 0000000..e679b44
--- /dev/null
+++ b/drivers/gpio/gpio-octeon.c
@@ -0,0 +1,166 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011,2012 Cavium Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-gpio-defs.h>
+
+#define DRV_VERSION "1.0"
+#define DRV_DESCRIPTION "Cavium Inc. OCTEON GPIO Driver"
+
+#define RX_DAT 0x80
+#define TX_SET 0x88
+#define TX_CLEAR 0x90
+/*
+ * The address offset of the GPIO configuration register for a given
+ * line.
+ */
+static unsigned int bit_cfg_reg(unsigned int gpio)
+{
+	if (gpio < 16)
+		return 8 * gpio;
+	else
+		return 8 * (gpio - 16) + 0x100;
+}
+
+struct octeon_gpio {
+	struct gpio_chip chip;
+	u64 register_base;
+};
+
+static int octeon_gpio_dir_in(struct gpio_chip *chip, unsigned offset)
+{
+	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
+
+	cvmx_write_csr(gpio->register_base + bit_cfg_reg(offset), 0);
+	return 0;
+}
+
+static void octeon_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
+	u64 mask = 1ull << offset;
+	u64 reg = gpio->register_base + (value ? TX_SET : TX_CLEAR);
+	cvmx_write_csr(reg, mask);
+}
+
+static int octeon_gpio_dir_out(struct gpio_chip *chip, unsigned offset,
+			       int value)
+{
+	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
+	union cvmx_gpio_bit_cfgx cfgx;
+
+
+	octeon_gpio_set(chip, offset, value);
+
+	cfgx.u64 = 0;
+	cfgx.s.tx_oe = 1;
+
+	cvmx_write_csr(gpio->register_base + bit_cfg_reg(offset), cfgx.u64);
+	return 0;
+}
+
+static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
+	u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
+
+	return ((1ull << offset) & read_bits) != 0;
+}
+
+static int __init octeon_gpio_probe(struct platform_device *pdev)
+{
+	struct octeon_gpio *gpio;
+	struct gpio_chip *chip;
+	struct resource *res_mem;
+	int err = 0;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+	chip = &gpio->chip;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem == NULL) {
+		dev_err(&pdev->dev, "found no memory resource\n");
+		err = -ENXIO;
+		goto out;
+	}
+	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
+					resource_size(res_mem),
+				     res_mem->name)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		err = -ENXIO;
+		goto out;
+	}
+	gpio->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
+						resource_size(res_mem));
+
+
+	pdev->dev.platform_data = chip;
+	chip->label = "octeon-gpio";
+	chip->dev = &pdev->dev;
+	chip->owner = THIS_MODULE;
+	chip->base = 0;
+	chip->can_sleep = 0;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN66XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN61XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CNF71XX))
+		chip->ngpio = 20;
+	else
+		chip->ngpio = 16;
+
+	chip->direction_input = octeon_gpio_dir_in;
+	chip->get = octeon_gpio_get;
+	chip->direction_output = octeon_gpio_dir_out;
+	chip->set = octeon_gpio_set;
+	err = gpiochip_add(chip);
+	if (err)
+		goto out;
+
+	dev_info(&pdev->dev, "version: " DRV_VERSION "\n");
+out:
+	return err;
+}
+
+static int __exit octeon_gpio_remove(struct platform_device *pdev)
+{
+	struct gpio_chip *chip = pdev->dev.platform_data;
+	return gpiochip_remove(chip);
+}
+
+static struct of_device_id octeon_gpio_match[] = {
+	{
+		.compatible = "cavium,octeon-3860-gpio",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mgmt_match);
+
+static struct platform_driver octeon_gpio_driver = {
+	.driver = {
+		.name		= "octeon_gpio",
+		.owner		= THIS_MODULE,
+		.of_match_table = octeon_gpio_match,
+	},
+	.probe		= octeon_gpio_probe,
+	.remove		= __exit_p(octeon_gpio_remove),
+};
+
+module_platform_driver(octeon_gpio_driver);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
-- 
1.7.2.3
