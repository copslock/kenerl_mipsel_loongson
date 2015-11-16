Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 22:22:46 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:54545 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012828AbbKPVWgynt5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 22:22:36 +0100
Received: from localhost.localdomain (unknown [78.54.254.43])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 5A06DA6233;
        Mon, 16 Nov 2015 22:22:21 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 1/5] phy: Add a driver for simple phy
Date:   Mon, 16 Nov 2015 22:22:00 +0100
Message-Id: <1447708924-15076-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447708924-15076-1-git-send-email-albeu@free.fr>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

This driver is meant to take care of all trivial phys that don't need
any special configuration, it just enable a regulator, a clock and
deassert a reset. A public API is also included to allow re-using the
code in other drivers.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/phy/Kconfig        |  12 +++
 drivers/phy/Makefile       |   1 +
 drivers/phy/phy-simple.c   | 204 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/simple.h |  39 +++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/phy/phy-simple.c
 create mode 100644 include/linux/phy/simple.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 7eb5859d..028fb16 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -118,6 +118,18 @@ config PHY_RCAR_GEN2
 	help
 	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
 
+config PHY_SIMPLE
+	tristate
+	select GENERIC_PHY
+	help
+
+config PHY_SIMPLE_PDEV
+	tristate "Simple PHY driver"
+	select PHY_SIMPLE
+	help
+	  A PHY driver for simple devices that only need a regulator, clock
+	  and reset for power up and shutdown.
+
 config OMAP_CONTROL_PHY
 	tristate "OMAP CONTROL PHY Driver"
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 075db1a..1a44362 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
 obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
 obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
+obj-$(CONFIG_PHY_SIMPLE)		+= phy-simple.o
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
 obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
diff --git a/drivers/phy/phy-simple.c b/drivers/phy/phy-simple.c
new file mode 100644
index 0000000..013f846
--- /dev/null
+++ b/drivers/phy/phy-simple.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/simple.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+int simple_phy_power_on(struct phy *phy)
+{
+	struct simple_phy *sphy = phy_get_drvdata(phy);
+	int err;
+
+	if (sphy->regulator) {
+		err = regulator_enable(sphy->regulator);
+		if (err)
+			return err;
+	}
+
+	if (sphy->clk) {
+		err = clk_prepare_enable(sphy->clk);
+		if (err)
+			goto regulator_disable;
+	}
+
+	if (sphy->reset) {
+		err = reset_control_deassert(sphy->reset);
+		if (err)
+			goto clock_disable;
+	}
+
+	return 0;
+
+clock_disable:
+	if (sphy->clk)
+		clk_disable_unprepare(sphy->clk);
+regulator_disable:
+	if (sphy->regulator)
+		WARN_ON(regulator_disable(sphy->regulator));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(simple_phy_power_on);
+
+int simple_phy_power_off(struct phy *phy)
+{
+	struct simple_phy *sphy = phy_get_drvdata(phy);
+	int err;
+
+	if (sphy->reset) {
+		err = reset_control_assert(sphy->reset);
+		if (err)
+			return err;
+	}
+
+	if (sphy->clk)
+		clk_disable_unprepare(sphy->clk);
+
+	if (sphy->regulator) {
+		err = regulator_disable(sphy->regulator);
+		if (err)
+			goto clock_enable;
+	}
+
+	return 0;
+
+clock_enable:
+	if (sphy->clk)
+		WARN_ON(clk_prepare_enable(sphy->clk));
+	if (sphy->reset)
+		WARN_ON(reset_control_deassert(sphy->reset));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(simple_phy_power_off);
+
+static const struct phy_ops simple_phy_ops = {
+	.power_on	= simple_phy_power_on,
+	.power_off	= simple_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+struct phy *devm_simple_phy_create(struct device *dev,
+				const struct simple_phy_desc *desc,
+				struct simple_phy *sphy)
+{
+	struct phy *phy;
+
+	if (!dev || !desc)
+		return ERR_PTR(-EINVAL);
+
+	if (!sphy) {
+		sphy = devm_kzalloc(dev, sizeof(*sphy), GFP_KERNEL);
+		if (!sphy)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	if (!IS_ERR_OR_NULL(desc->regulator)) {
+		sphy->regulator = devm_regulator_get(dev, desc->regulator);
+		if (IS_ERR(sphy->regulator)) {
+			if (PTR_ERR(sphy->regulator) == -ENOENT)
+				sphy->regulator = NULL;
+			else
+				return ERR_PTR(PTR_ERR(sphy->regulator));
+		}
+	}
+
+	if (!IS_ERR(desc->clk)) {
+		sphy->clk = devm_clk_get(dev, desc->clk);
+		if (IS_ERR(sphy->clk)) {
+			if (PTR_ERR(sphy->clk) == -ENOENT)
+				sphy->clk = NULL;
+			else
+				return ERR_PTR(PTR_ERR(sphy->clk));
+		}
+	}
+
+	if (!IS_ERR(desc->reset)) {
+		sphy->reset = devm_reset_control_get(dev, desc->reset);
+		if (IS_ERR(sphy->reset)) {
+			int err = PTR_ERR(sphy->reset);
+
+			if (err == -ENOENT || err == -ENOTSUPP)
+				sphy->reset = NULL;
+			else
+				return ERR_PTR(err);
+		}
+	}
+
+	phy = devm_phy_create(dev, NULL, desc->ops ?: &simple_phy_ops);
+	if (IS_ERR(phy))
+		return ERR_PTR(PTR_ERR(phy));
+
+	phy_set_drvdata(phy, sphy);
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_simple_phy_create);
+
+#ifdef CONFIG_PHY_SIMPLE_PDEV
+#ifdef CONFIG_OF
+/* Default config, no regulator, default clock and reset if any */
+static const struct simple_phy_desc simple_phy_default_desc = {};
+
+static const struct of_device_id simple_phy_of_match[] = {
+	{ .compatible = "simple-phy", .data = &simple_phy_default_desc },
+	{}
+};
+MODULE_DEVICE_TABLE(of, simple_phy_of_match);
+
+const struct simple_phy_desc *simple_phy_get_of_desc(struct device *dev)
+{
+	const struct of_device_id *match;
+
+	match = of_match_device(simple_phy_of_match, dev);
+
+	return match ? match->data : NULL;
+}
+#else
+const struct simple_phy_desc *simple_phy_get_of_desc(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
+static int simple_phy_probe(struct platform_device *pdev)
+{
+	const struct simple_phy_desc *desc = pdev->dev.platform_data;
+	struct phy *phy;
+
+	if (!desc)
+		desc = simple_phy_get_of_desc(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	phy = devm_simple_phy_create(&pdev->dev, desc, NULL);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	return PTR_ERR_OR_ZERO(devm_of_phy_provider_register(
+				&pdev->dev, of_phy_simple_xlate));
+}
+
+static struct platform_driver simple_phy_driver = {
+	.probe	= simple_phy_probe,
+	.driver = {
+		.of_match_table	= of_match_ptr(simple_phy_of_match),
+		.name		= "phy-simple",
+	}
+};
+module_platform_driver(simple_phy_driver);
+
+#endif /* CONFIG_PHY_SIMPLE_PDEV */
+
+MODULE_DESCRIPTION("Simple PHY driver");
+MODULE_AUTHOR("Alban Bedel <albeu@free.fr>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/phy/simple.h b/include/linux/phy/simple.h
new file mode 100644
index 0000000..f368b57
--- /dev/null
+++ b/include/linux/phy/simple.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_PHY_SIMPLE__
+#define __LINUX_PHY_SIMPLE__
+
+#include <linux/phy/phy.h>
+
+struct reset_control;
+struct clk;
+
+struct simple_phy {
+	struct regulator *regulator;
+	struct reset_control *reset;
+	struct clk *clk;
+};
+
+struct simple_phy_desc {
+	const struct phy_ops *ops;
+	const char *regulator;
+	const char *reset;
+	const char *clk;
+};
+
+struct phy *devm_simple_phy_create(struct device *dev,
+				const struct simple_phy_desc *desc,
+				struct simple_phy *sphy);
+
+int simple_phy_power_on(struct phy *phy);
+
+int simple_phy_power_off(struct phy *phy);
+
+#endif /* __LINUX_PHY_SIMPLE__ */
-- 
2.0.0
