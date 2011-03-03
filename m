Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 11:17:03 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:49391 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491907Ab1CCKQw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Mar 2011 11:16:52 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V3 10/10] MIPS: lantiq: add more gpio drivers
Date:   Thu,  3 Mar 2011 11:03:46 +0100
Message-Id: <1299146626-17428-11-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299146626-17428-1-git-send-email-blogic@openwrt.org>
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

The XWAY family allows to extend the number of gpios by using shift registers or latches. This patch adds the 2 drivers needed for this. The extended gpios are output only.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
Added in V2

Changes in V3
* whitespace
* change __iomem void to void __iomem
* multiline comments
* use pr_* macros instead of printk

 arch/mips/lantiq/xway/Makefile   |    2 +-
 arch/mips/lantiq/xway/gpio_ebu.c |  126 ++++++++++++++++++++++++++++++
 arch/mips/lantiq/xway/gpio_stp.c |  158 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/lantiq/xway/gpio_ebu.c
 create mode 100644 arch/mips/lantiq/xway/gpio_stp.c

diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 08dcc10..a021def 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,4 +1,4 @@
-obj-y := pmu.o ebu.o reset.o gpio.o devices.o
+obj-y := pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o
 
 obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
 obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
diff --git a/arch/mips/lantiq/xway/gpio_ebu.c b/arch/mips/lantiq/xway/gpio_ebu.c
new file mode 100644
index 0000000..a3ae6b8
--- /dev/null
+++ b/arch/mips/lantiq/xway/gpio_ebu.c
@@ -0,0 +1,126 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <lantiq_soc.h>
+
+/* By attaching hardware latches to the EBU it is possible to create output
+ * only gpios. This driver configures a special memory address, which when
+ * written to outputs 16 bit to the latches.
+ */
+
+#define LTQ_EBU_BUSCON	0x1e7ff		/* 16 bit access, slowest timing */
+#define LTQ_EBU_WP	0x80000000	/* write protect bit */
+
+/* we keep a ltq_ebu_gpio_shadow value of the last value written to the ebu */
+static int ltq_ebu_gpio_shadow = 0x0;
+static void __iomem *ltq_ebu_gpio_membase;
+
+static void
+ltq_ebu_apply(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ebu_lock, flags);
+	ltq_ebu_w32(LTQ_EBU_BUSCON, LTQ_EBU_BUSCON1);
+	*((__u16 *)ltq_ebu_gpio_membase) = ltq_ebu_gpio_shadow;
+	ltq_ebu_w32(LTQ_EBU_BUSCON | LTQ_EBU_WP, LTQ_EBU_BUSCON1);
+	spin_unlock_irqrestore(&ebu_lock, flags);
+}
+
+static void
+ltq_ebu_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	if (value)
+		ltq_ebu_gpio_shadow |= (1 << offset);
+	else
+		ltq_ebu_gpio_shadow &= ~(1 << offset);
+	ltq_ebu_apply();
+}
+
+static int
+ltq_ebu_direction_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	ltq_ebu_set(chip, offset, value);
+	return 0;
+}
+
+static struct gpio_chip
+ltq_ebu_chip = {
+	.label = "ltq_ebu",
+	.direction_output = ltq_ebu_direction_output,
+	.set = ltq_ebu_set,
+	.base = 72,
+	.ngpio = 16,
+	.can_sleep = 1,
+	.owner = THIS_MODULE,
+};
+
+static int __devinit
+ltq_ebu_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get memory resource\n");
+		return -ENOENT;
+	}
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+		resource_size(res), dev_name(&pdev->dev));
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request memory resource\n");
+		return -EBUSY;
+	}
+
+	ltq_ebu_gpio_membase = devm_ioremap_nocache(&pdev->dev, res->start,
+		resource_size(res));
+	if (!ltq_ebu_gpio_membase) {
+		dev_err(&pdev->dev, "Failed to ioremap mem region\n");
+		return -ENOMEM;
+	}
+
+	/* grab the default shadow value passed form the platform code */
+	ltq_ebu_gpio_shadow = (unsigned int) pdev->dev.platform_data;
+
+	/* tell the ebu controller which mem addr we will be using */
+	ltq_ebu_w32(pdev->resource->start | 0x1, LTQ_EBU_ADDRSEL1);
+
+	/* write protect the region */
+	ltq_ebu_w32(LTQ_EBU_BUSCON | LTQ_EBU_WP, LTQ_EBU_BUSCON1);
+
+	ret = gpiochip_add(&ltq_ebu_chip);
+	if (!ret)
+		ltq_ebu_apply();
+	return ret;
+}
+
+static struct platform_driver
+ltq_ebu_driver = {
+	.probe = ltq_ebu_probe,
+	.driver = {
+		.name = "ltq_ebu",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init
+ltq_ebu_init(void)
+{
+	return platform_driver_register(&ltq_ebu_driver);
+}
+
+postcore_initcall(ltq_ebu_init);
diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
new file mode 100644
index 0000000..f0f4e68
--- /dev/null
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -0,0 +1,158 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2007 John Crispin <blogic@openwrt.org>
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <lantiq_soc.h>
+
+#define LTQ_STP_CON0		0x00
+#define LTQ_STP_CON1		0x04
+#define LTQ_STP_CPU0		0x08
+#define LTQ_STP_CPU1		0x0C
+#define LTQ_STP_AR		0x10
+
+#define STP_CON0_SWU		(1 << 31)
+#define LTQ_STP_2HZ		(0)
+#define LTQ_STP_4HZ		(1 << 23)
+#define LTQ_STP_8HZ		(2 << 23)
+#define LTQ_STP_10HZ		(3 << 23)
+#define LTQ_STP_MASK		(0xf << 23)
+#define LTQ_STP_UPD_SRC_FPI	(1 << 31)
+#define LTQ_STP_UPD_MASK	(3 << 30)
+#define LTQ_STP_ADSL_SRC	(3 << 24)
+
+#define LTQ_STP_GROUP0		(1 << 0)
+
+#define LTQ_STP_RISING		0
+#define LTQ_STP_FALLING		(1 << 26)
+#define LTQ_STP_EDGE_MASK	(1 << 26)
+
+#define ltq_stp_r32(reg)	__raw_readl(ltq_stp_membase + reg)
+#define ltq_stp_w32(val, reg)	__raw_writel(val, ltq_stp_membase + reg)
+#define ltq_stp_w32_mask(clear, set, reg) \
+	ltq_w32((ltq_r32(ltq_stp_membase + reg) & ~(clear)) | (set), \
+	ltq_stp_membase + (reg))
+
+static int ltq_stp_shadow = 0xffff;
+static void __iomem *ltq_stp_membase;
+
+static void
+ltq_stp_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	if (value)
+		ltq_stp_shadow |= (1 << offset);
+	else
+		ltq_stp_shadow &= ~(1 << offset);
+	ltq_stp_w32(ltq_stp_shadow, LTQ_STP_CPU0);
+}
+
+static int
+ltq_stp_direction_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	ltq_stp_set(chip, offset, value);
+	return 0;
+}
+
+static struct gpio_chip ltq_stp_chip = {
+	.label = "ltq_stp",
+	.direction_output = ltq_stp_direction_output,
+	.set = ltq_stp_set,
+	.base = 48,
+	.ngpio = 24,
+	.can_sleep = 1,
+	.owner = THIS_MODULE,
+};
+
+static int
+ltq_stp_hw_init(void)
+{
+	/* the 3 pins used to control the external stp */
+	ltq_gpio_request(4, 1, 0, 1, "stp-st");
+	ltq_gpio_request(5, 1, 0, 1, "stp-d");
+	ltq_gpio_request(6, 1, 0, 1, "stp-sh");
+
+	/* sane defaults */
+	ltq_stp_w32(0, LTQ_STP_AR);
+	ltq_stp_w32(0, LTQ_STP_CPU0);
+	ltq_stp_w32(0, LTQ_STP_CPU1);
+	ltq_stp_w32(STP_CON0_SWU, LTQ_STP_CON0);
+	ltq_stp_w32(0, LTQ_STP_CON1);
+
+	/* rising or falling edge */
+	ltq_stp_w32_mask(LTQ_STP_EDGE_MASK, LTQ_STP_FALLING, LTQ_STP_CON0);
+
+	/* per default stp 15-0 are set */
+	ltq_stp_w32_mask(0, LTQ_STP_GROUP0, LTQ_STP_CON1);
+
+	/* stp are update periodically by the FPID */
+	ltq_stp_w32_mask(LTQ_STP_UPD_MASK, LTQ_STP_UPD_SRC_FPI, LTQ_STP_CON1);
+
+	/* set stp update speed */
+	ltq_stp_w32_mask(LTQ_STP_MASK, LTQ_STP_8HZ, LTQ_STP_CON1);
+
+	/* adsl 0 and 1 stp are updated by the arc */
+	ltq_stp_w32_mask(0, LTQ_STP_ADSL_SRC, LTQ_STP_CON0);
+
+	ltq_pmu_enable(PMU_LED);
+	return 0;
+}
+
+static int
+ltq_stp_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret = 0;
+
+	if (!res)
+		return -ENOENT;
+	res = devm_request_mem_region(&pdev->dev, res->start,
+		resource_size(res), dev_name(&pdev->dev));
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request STP memory\n");
+		return -EBUSY;
+	}
+	ltq_stp_membase = devm_ioremap_nocache(&pdev->dev, res->start,
+		resource_size(res));
+	if (!ltq_stp_membase) {
+		dev_err(&pdev->dev, "failed to remap STP memory\n");
+		return -ENOMEM;
+	}
+	ret = gpiochip_add(&ltq_stp_chip);
+	if (!ret)
+		ret = ltq_stp_hw_init();
+
+	return ret;
+}
+
+static struct platform_driver ltq_stp_driver = {
+	.probe = ltq_stp_probe,
+	.driver = {
+		.name = "ltq_stp",
+		.owner = THIS_MODULE,
+	},
+};
+
+int __init
+ltq_stp_init(void)
+{
+	int ret = platform_driver_register(&ltq_stp_driver);
+
+	if (ret)
+		pr_info("ltq_stp: error registering platfom driver");
+	return ret;
+}
+
+postcore_initcall(ltq_stp_init);
-- 
1.7.2.3
