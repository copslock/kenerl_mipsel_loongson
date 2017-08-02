Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 01:04:43 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:56801 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994864AbdHBW7TnOJrW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Aug 2017 00:59:19 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 27A3546152;
        Thu,  3 Aug 2017 00:59:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 0q-5cWvazAax; Thu,  3 Aug 2017 00:59:02 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v8 10/16] reset: Add a reset controller driver for the Lantiq XWAY based SoCs
Date:   Thu,  3 Aug 2017 00:57:11 +0200
Message-Id: <20170802225717.24408-11-hauke@hauke-m.de>
In-Reply-To: <20170802225717.24408-1-hauke@hauke-m.de>
References: <20170802225717.24408-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The reset controllers (on xRX200 and newer SoCs have two of them) are
provided by the RCU module. This was initially implemented as a simple
reset controller. However, the RCU module provides more functionality
(ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
The old reset controller driver implementation from
arch/mips/lantiq/xway/reset.c did not honor this fact.

For some devices the request and the status bits are different.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 .../devicetree/bindings/reset/lantiq,reset.txt     |  30 +++
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq.c                       | 224 +++++++++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
 create mode 100644 drivers/reset/reset-lantiq.c

diff --git a/Documentation/devicetree/bindings/reset/lantiq,reset.txt b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
new file mode 100644
index 000000000000..c1c48aa099b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
@@ -0,0 +1,30 @@
+Lantiq XWAY SoC RCU reset controller binding
+============================================
+
+This binding describes a reset-controller found on the RCU module on Lantiq
+XWAY SoCs.
+
+This driver has to be a sub node of the Lantiq RCU block.
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible		: Should be one of
+				"lantiq,danube-reset"
+				"lantiq,xrx200-reset"
+- reg			: Defines the following sets of registers in the parent
+			  syscon device
+			- Offset of the reset set register
+			- Offset of the reset status register
+- #reset-cells		: Specifies the number of cells needed to encode the
+			  reset line, should be 2.
+			  The first cell takes the reset set bit and the
+			  second cell takes the status bit.
+
+-------------------------------------------------------------------------------
+Example for the reset-controllers on the xRX200 SoCs:
+	reset0: reset-controller@0 {
+		compatible = "lantiq,xrx200-reset";
+		reg <0x10 0x04>, <0x14 0x04>;
+
+		#reset-cells = <2>;
+	};
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 608c071e4bbf..4172ea1827f8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -48,6 +48,12 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_LANTIQ
+	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
+	default SOC_TYPE_XWAY
+	help
+	  This enables the reset controller driver for Lantiq / Intel XWAY SoCs.
+
 config RESET_LPC18XX
 	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
 	default ARCH_LPC18XX
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 7081f9da2599..54d8b3f703f2 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_GEMINI) += reset-gemini.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
+obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
new file mode 100644
index 000000000000..b84c45e7e6b8
--- /dev/null
+++ b/drivers/reset/reset-lantiq.c
@@ -0,0 +1,224 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@phrozen.org>
+ *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
+ *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define LANTIQ_RCU_RESET_TIMEOUT	10000
+
+struct lantiq_rcu_reset_priv {
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	struct regmap *regmap;
+	u32 reset_offset;
+	u32 status_offset;
+};
+
+static struct lantiq_rcu_reset_priv *to_lantiq_rcu_reset_priv(
+	struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct lantiq_rcu_reset_priv, rcdev);
+}
+
+static int lantiq_rcu_reset_status(struct reset_controller_dev *rcdev,
+				   unsigned long id)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	unsigned int status = (id >> 8) & 0x1f;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, priv->status_offset, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(status));
+}
+
+static int lantiq_rcu_reset_status_timeout(struct reset_controller_dev *rcdev,
+					   unsigned long id, bool assert)
+{
+	int ret;
+	int retry = LANTIQ_RCU_RESET_TIMEOUT;
+
+	do {
+		ret = lantiq_rcu_reset_status(rcdev, id);
+		if (ret < 0)
+			return ret;
+		if (ret == assert)
+			return 0;
+		usleep_range(20, 40);
+	} while (--retry);
+
+	return -ETIMEDOUT;
+}
+
+static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
+				   unsigned long id, bool assert)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	unsigned int set = id & 0x1f;
+	u32 val = assert ? BIT(set) : 0;
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
+				 val);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
+		return ret;
+	}
+
+
+	ret = lantiq_rcu_reset_status_timeout(rcdev, id, assert);
+	if (ret)
+		dev_err(priv->dev, "Failed to %s bit %u\n",
+			assert ? "assert" : "deassert", set);
+
+	return ret;
+}
+
+static int lantiq_rcu_reset_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	return lantiq_rcu_reset_update(rcdev, id, true);
+}
+
+static int lantiq_rcu_reset_deassert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return lantiq_rcu_reset_update(rcdev, id, false);
+}
+
+static int lantiq_rcu_reset_reset(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	int ret;
+
+	ret = lantiq_rcu_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return lantiq_rcu_reset_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops lantiq_rcu_reset_ops = {
+	.assert = lantiq_rcu_reset_assert,
+	.deassert = lantiq_rcu_reset_deassert,
+	.status = lantiq_rcu_reset_status,
+	.reset	= lantiq_rcu_reset_reset,
+};
+
+static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
+			       struct lantiq_rcu_reset_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct resource res_parent;
+	int ret;
+
+	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	ret = of_address_to_resource(dev->of_node->parent, 0, &res_parent);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
+		return ret;
+	}
+
+	if (res->start < res_parent.start)
+		return -ENOENT;
+	priv->reset_offset = res->start - res_parent.start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
+		return ret;
+	}
+
+	if (res->start < res_parent.start)
+		return -ENOENT;
+	priv->status_offset = res->start - res_parent.start;
+
+	return 0;
+}
+
+static int lantiq_rcu_reset_xlate(struct reset_controller_dev *rcdev,
+				  const struct of_phandle_args *reset_spec)
+{
+	unsigned int status, set;
+
+	set = reset_spec->args[0];
+	status = reset_spec->args[1];
+
+	if (set >= rcdev->nr_resets || status >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return (status << 8) | set;
+}
+
+static int lantiq_rcu_reset_probe(struct platform_device *pdev)
+{
+	struct lantiq_rcu_reset_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	err = lantiq_rcu_reset_of_probe(pdev, priv);
+	if (err)
+		return err;
+
+	priv->rcdev.ops = &lantiq_rcu_reset_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.nr_resets = 32;
+	priv->rcdev.of_xlate = lantiq_rcu_reset_xlate;
+	priv->rcdev.of_reset_n_cells = 2;
+
+	return reset_controller_register(&priv->rcdev);
+}
+
+static const struct of_device_id lantiq_rcu_reset_dt_ids[] = {
+	{ .compatible = "lantiq,danube-reset", },
+	{ .compatible = "lantiq,xrx200-reset", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lantiq_rcu_reset_dt_ids);
+
+static struct platform_driver lantiq_rcu_reset_driver = {
+	.probe	= lantiq_rcu_reset_probe,
+	.driver = {
+		.name		= "lantiq-reset",
+		.of_match_table	= lantiq_rcu_reset_dt_ids,
+	},
+};
+module_platform_driver(lantiq_rcu_reset_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0
