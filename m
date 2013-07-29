Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 23:30:28 +0200 (CEST)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:41016 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831319Ab3G2V30nbdW- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jul 2013 23:29:26 +0200
Received: by mail-pb0-f44.google.com with SMTP id wy7so5167527pbc.17
        for <multiple recipients>; Mon, 29 Jul 2013 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8ZGogrVEn8uNymVdC8gZlun1T1ISViSbjIX1h0p/gss=;
        b=ZV81zivzSsI3J3B2E9N8R8ijVHv80oq3auTtuYqnKuMU1ystw7m+luuHnhDQ4yVQZJ
         NCIq3IZDjxrq5P+qGQ2v2MO0CN1euS5zSbIFRWbRPTvU9yc91rWGox7kAHiUilbv+zkL
         ZglrKQAkGivT9R9tl4DDVOAX5mHXpXnNKMFYCsJ5g/XmVSc0ImjIXmqh/paVyxfOj+7l
         sF6VYy23Fb8JOhBnfoGjk+AxdNHBHJ1RYxPzUymjsrDxEnqRkA8KJ7vwwwfHaTzcZcG0
         IUQX5QEBSDDFf0AsinqizpHHvHCHVC982go4cRzvFNCg6a0eJF6MtdpmAfAX+1rhigVc
         +QnA==
X-Received: by 10.66.135.146 with SMTP id ps18mr70347143pab.172.1375133359746;
        Mon, 29 Jul 2013 14:29:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id a5sm8365228pbw.4.2013.07.29.14.29.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 14:29:18 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TLTGDm018871;
        Mon, 29 Jul 2013 14:29:16 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TLTGeq018870;
        Mon, 29 Jul 2013 14:29:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/2] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.
Date:   Mon, 29 Jul 2013 14:29:10 -0700
Message-Id: <1375133350-18828-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
GPIO pins, this driver handles them all.  Configuring the pins as
interrupt sources is handled elsewhere (OCTEON's irq handling code).

Signed-off-by: David Daney <david.daney@cavium.com>
---

Device tree binding defintions already exist for this device in
Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt


 drivers/gpio/Kconfig       |   8 +++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-octeon.c | 157 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/gpio/gpio-octeon.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b2450ba..b21b7a2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -193,6 +193,14 @@ config GPIO_MXS
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
+config GPIO_OCTEON
+	tristate "Cavium OCTEON GPIO"
+	depends on GPIOLIB && CAVIUM_OCTEON_SOC
+	default y
+	help
+	  Say yes here to support the on-chip GPIO lines on the OCTEON
+	  family of SOCs.
+
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
 	depends on ARM && ARM_AMBA
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ef3e983..e7fd980 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
 obj-$(CONFIG_GPIO_MVEBU)        += gpio-mvebu.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
+obj-$(CONFIG_GPIO_OCTEON)	+= gpio-octeon.o
 obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
 obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
new file mode 100644
index 0000000..71a4a31
--- /dev/null
+++ b/drivers/gpio/gpio-octeon.c
@@ -0,0 +1,157 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011, 2012 Cavium Inc.
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
+#define RX_DAT 0x80
+#define TX_SET 0x88
+#define TX_CLEAR 0x90
+/*
+ * The address offset of the GPIO configuration register for a given
+ * line.
+ */
+static unsigned int bit_cfg_reg(unsigned int offset)
+{
+	/*
+	 * The register stride is 8, with a discontinuity after the
+	 * first 16.
+	 */
+	if (offset < 16)
+		return 8 * offset;
+	else
+		return 8 * (offset - 16) + 0x100;
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
+static int octeon_gpio_probe(struct platform_device *pdev)
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
+	pdev->dev.platform_data = chip;
+	chip->label = "octeon-gpio";
+	chip->dev = &pdev->dev;
+	chip->owner = THIS_MODULE;
+	chip->base = 0;
+	chip->can_sleep = 0;
+	chip->ngpio = 20;
+	chip->direction_input = octeon_gpio_dir_in;
+	chip->get = octeon_gpio_get;
+	chip->direction_output = octeon_gpio_dir_out;
+	chip->set = octeon_gpio_set;
+	err = gpiochip_add(chip);
+	if (err)
+		goto out;
+
+	dev_info(&pdev->dev, "OCTEON GPIO driver probed.\n");
+out:
+	return err;
+}
+
+static int octeon_gpio_remove(struct platform_device *pdev)
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
+MODULE_DEVICE_TABLE(of, octeon_gpio_match);
+
+static struct platform_driver octeon_gpio_driver = {
+	.driver = {
+		.name		= "octeon_gpio",
+		.owner		= THIS_MODULE,
+		.of_match_table = octeon_gpio_match,
+	},
+	.probe		= octeon_gpio_probe,
+	.remove		= octeon_gpio_remove,
+};
+
+module_platform_driver(octeon_gpio_driver);
+
+MODULE_DESCRIPTION("Cavium Inc. OCTEON GPIO Driver");
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
-- 
1.7.11.7
