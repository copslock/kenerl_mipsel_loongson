Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2016 20:16:47 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35353 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992612AbcH0SQDzFYGj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Aug 2016 20:16:03 +0200
Received: by mail-pf0-f194.google.com with SMTP id h186so6672656pfg.2;
        Sat, 27 Aug 2016 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1pcSAg6vhd5pS/9MLhnRodOt0xtOnry2ixlnAn5aCnQ=;
        b=pHOSCs2Fr1TA43JtySNxGJcru6or2rAOGChDylOz7Ratcka0Tp70sH/v5nts+0cL35
         FG91aedXkkgJMbYYsM0piW6uPlinJdkOqXAlzh3XfX5oxChVNf1euArlZ0tsPZNxvCg5
         +0HFW9OXB1l5wcmUcZO3/Vzl8mT0a0W3j26nMJbHmQxM5nVpvknl7aJJ+9oLdqrBHoKP
         uX8he8YVpddQYx3kltL6fGXX/S4X9GqzoM7TMHrbRAjXZ6ROeFHZx9TKz2/elprD4U/n
         kzBtA/BGA/6gkDsav0fUeW+E1jWmSw9SyhZa6kBwEN3zEE6iFxPIbfKLsuzMJrtD6OQ5
         gszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1pcSAg6vhd5pS/9MLhnRodOt0xtOnry2ixlnAn5aCnQ=;
        b=ELZIz0eaLBBJiKbAoNk+MV1UZzvsKGKrvLMfqV0e48PnhIRla1X2pGi7UbXnCTlwIA
         yySdwfV8Fwr0vEYNDyUQCnz0/sPSKGtmYFxJ6hqQRPDEXU81AaSBAm3j1H8iEVtYFoOq
         xyvlRbOjKHLVZgeJj3pJZ9vdAjPV3bUZsU2ML7OZUOHkYYueUvFMlpbbeeuRU3fxwgBW
         KOE1Pg4K0+CLZidCLXNdV5IOuZ8FXJFYWRewRljrYZLnjxRoUodhKSwxZJarVcObRzV6
         9kGipDsF+eIO5qWV/++MDP7Ie56IT28qiAgJh2YERbiJRWiPIsRTY6Vnwh/P459zEhnO
         X3yQ==
X-Gm-Message-State: AE9vXwN4Wl5GpRutSkJ84nRT5aof8iN9P6aMypyWX0EqK38w9BTBp4yRuyfZMGxWM0nHXw==
X-Received: by 10.98.80.29 with SMTP id e29mr17165233pfb.76.1472321758034;
        Sat, 27 Aug 2016 11:15:58 -0700 (PDT)
Received: from localhost.localdomain ([1.22.68.54])
        by smtp.gmail.com with ESMTPSA id y6sm37747529pav.1.2016.08.27.11.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:15:57 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org,
        gregkh@linuxfoundation.org, boris.brezillon@free-electrons.com,
        harvey.hunt@imgtec.com, prarit@redhat.com, f.fainelli@gmail.com,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 2/4] hw_random: jz4780-rng: Add Ingenic JZ4780 hardware RNG driver
Date:   Sat, 27 Aug 2016 23:44:55 +0530
Message-Id: <1472321697-3094-3-git-send-email-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

JZ4780 SoC random number generator driver.

Changes since v1:
* Use devm_ioremap_resource and devm_hwrng_register
* Add delay after enabling RNG, before reading data
* Disable RNG after reading data as per Ingenic JZ4780 PM
* Move Makefile and Kconfig entries to the bottom
* Arrange includes in alphabetical order

Adding a delay before reading RNG data and disabling RNG after reading
data was suggested by Jeffery Walton.

Suggested-by: Jeffrey Walton <noloader@gmail.com>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 MAINTAINERS                         |   5 ++
 drivers/char/hw_random/Kconfig      |  14 +++++
 drivers/char/hw_random/Makefile     |   1 +
 drivers/char/hw_random/jz4780-rng.c | 101 ++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 drivers/char/hw_random/jz4780-rng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 320cce8..87a7505 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6008,6 +6008,11 @@ M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
 S:	Maintained
 F:	drivers/dma/dma-jz4780.c
 
+INGENIC JZ4780 HW RNG Driver
+M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+S:	Maintained
+F:	drivers/char/hw_random/jz4780-rng.c
+
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 56ad5a59..662e415 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -410,6 +410,20 @@ config HW_RANDOM_MESON
 
 	  If unsure, say Y.
 
+config HW_RANDOM_JZ4780
+	tristate "JZ4780 HW random number generator support"
+	depends on MACH_INGENIC
+	depends on HAS_IOMEM
+	default HW_RANDOM
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on JZ4780 SOCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called jz4780-rng.
+
+	  If unsure, say Y.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 04bb0b0..df1dbf6 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_HW_RANDOM_XGENE) += xgene-rng.o
 obj-$(CONFIG_HW_RANDOM_STM32) += stm32-rng.o
 obj-$(CONFIG_HW_RANDOM_PIC32) += pic32-rng.o
 obj-$(CONFIG_HW_RANDOM_MESON) += meson-rng.o
+obj-$(CONFIG_HW_RANDOM_JZ4780) += jz4780-rng.o
diff --git a/drivers/char/hw_random/jz4780-rng.c b/drivers/char/hw_random/jz4780-rng.c
new file mode 100644
index 0000000..1c85ed0
--- /dev/null
+++ b/drivers/char/hw_random/jz4780-rng.c
@@ -0,0 +1,101 @@
+/*
+ * jz4780-rng.c - Random Number Generator driver for J4780
+ *
+ * Copyright 2016 (C) PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define REG_RNG_CTRL	0x0
+#define REG_RNG_DATA	0x4
+
+struct jz4780_rng {
+	struct device *dev;
+	struct hwrng rng;
+	void __iomem *mem;
+};
+
+static u32 jz4780_rng_readl(struct jz4780_rng *rng, u32 offset)
+{
+	return readl(rng->mem + offset);
+}
+
+static void jz4780_rng_writel(struct jz4780_rng *rng, u32 val, u32 offset)
+{
+	writel(val, rng->mem + offset);
+}
+
+static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
+							rng);
+	u32 *data = buf;
+	/*
+	 * JZ4780 Programmers manual says the RNG should not run continuously
+	 * for more than 1s. So enable RNG, read data and disable it.
+	 * NOTE: No issue was observed with MIPS creator CI20 board even when
+	 * RNG ran continuously for longer periods. This is just a precaution.
+	 *
+	 * A delay is required so that the current RNG data is not bit shifted
+	 * version of previous RNG data which could happen if random data is
+	 * read continuously from this device.
+	 */
+	jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
+	/* As the delay is small add it even if wait is false */
+	udelay(20);
+	*data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
+	jz4780_rng_writel(jz4780_rng, 0, REG_RNG_CTRL);
+
+	return 4;
+}
+
+static int jz4780_rng_probe(struct platform_device *pdev)
+{
+	struct jz4780_rng *jz4780_rng;
+	struct resource *res;
+
+	jz4780_rng = devm_kzalloc(&pdev->dev, sizeof(*jz4780_rng), GFP_KERNEL);
+	if (!jz4780_rng)
+		return -ENOMEM;
+
+	jz4780_rng->dev = &pdev->dev;
+	jz4780_rng->rng.name = "jz4780";
+	jz4780_rng->rng.read = jz4780_rng_read;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	jz4780_rng->mem = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(jz4780_rng->mem))
+		return PTR_ERR(jz4780_rng->mem);
+
+	return devm_hwrng_register(&pdev->dev, &jz4780_rng->rng);
+}
+
+static const struct of_device_id jz4780_rng_dt_match[] = {
+	{ .compatible = "ingenic,jz4780-rng", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, jz4780_rng_dt_match);
+
+static struct platform_driver jz4780_rng_driver = {
+	.driver		= {
+		.name	= "jz4780-rng",
+		.of_match_table = jz4780_rng_dt_match,
+	},
+	.probe		= jz4780_rng_probe,
+};
+module_platform_driver(jz4780_rng_driver);
+
+MODULE_DESCRIPTION("Ingenic JZ4780 H/W Random Number Generator driver");
+MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.5.0
