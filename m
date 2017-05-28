Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2017 20:47:37 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:40305 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993995AbdE1Sknia7A8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2017 20:40:43 +0200
Received: from hauke-desktop.lan (p2003008628351B0030562F5E961CEEA9.dip0.t-ipconnect.de [IPv6:2003:86:2835:1b00:3056:2f5e:961c:eea9])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 3654110033B;
        Sun, 28 May 2017 20:40:37 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 14/16] phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
Date:   Sun, 28 May 2017 20:40:04 +0200
Message-Id: <20170528184006.31668-15-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170528184006.31668-1-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58055
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

This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
the PHY interfaces for each core. The phy instances can be passed to the
dwc2 driver, which already supports the generic phy interface.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
 arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
 5 files changed, 338 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
 create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c

diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
new file mode 100644
index 000000000000..7bdde5051c2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
@@ -0,0 +1,42 @@
+Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
+===========================================
+
+This binding describes the USB PHY hardware provided by the RCU module on the
+Lantiq XWAY SoCs.
+
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible	: Should be one of
+			"lantiq,ase-rcu-usb2-phy"
+			"lantiq,danube-rcu-usb2-phy"
+			"lantiq,xrx100-rcu-usb2-phy"
+			"lantiq,xrx200-rcu-usb2-phy"
+			"lantiq,xrx300-rcu-usb2-phy"
+- regmap	: A phandle to the RCU module
+- offset-phy	: Offset of the USB PHY configuration register
+- offset-ana	: Offset of the USB Analog configuration register
+- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
+- clock-names	: Must be one of the following:
+			"ctrl"
+			"phy"
+- resets	: References to the RCU USB configuration reset bits.
+- reset-names	: Must be one of the following:
+			"phy" (optional)
+			"ctrl" (shared)
+
+-------------------------------------------------------------------------------
+Example for the USB PHYs on an xRX200 SoC:
+	usb_phy0: usb2-phy@0 {
+		compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+		regmap = <&rcu0>;
+		offset-phy = <0x18>;
+		offset-ana = <0x38>;
+		clocks = <&pmu PMU_GATE_USB0_CTRL>,
+			 <&pmu PMU_GATE_USB0_PHY>;
+		clock-names = "ctrl", "phy";
+		resets = <&reset1 4 4>, <&reset0 4 4>;
+		reset-names = "phy", "ctrl";
+		#phy-cells = <0>;
+	};
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 0789c48ef779..4f45bef613f7 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
 
 	if (of_machine_is_compatible("lantiq,grx390") ||
 	    of_machine_is_compatible("lantiq,ar10")) {
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 2, PMU_ANALOG_USB0_P);
-		clkdev_add_pmu("1e106000.usb", "phy", 1, 2, PMU_ANALOG_USB1_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "phy", 1, 2, PMU_ANALOG_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@1", "phy", 1, 2, PMU_ANALOG_USB1_P);
 		/* rc 0 */
 		clkdev_add_pmu("1d900000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE0_P);
 		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
@@ -490,8 +490,8 @@ void __init ltq_soc_init(void)
 		else
 			clkdev_add_static(CLOCK_133M, CLOCK_133M,
 						CLOCK_133M, CLOCK_133M);
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
 		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
 		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
@@ -526,10 +526,10 @@ void __init ltq_soc_init(void)
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
 				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0 | PMU_AHBM);
-		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
-		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1 | PMU_AHBM);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "ctrl", 1, 0, PMU_USB0 | PMU_AHBM);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@1", "phy", 1, 0, PMU_USB1_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@1", "ctrl", 1, 0, PMU_USB1 | PMU_AHBM);
 		clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
 		clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
 		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
@@ -550,8 +550,8 @@ void __init ltq_soc_init(void)
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
 		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
@@ -562,8 +562,8 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index afaf7b643eeb..f7f6bfca20fc 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -507,6 +507,14 @@ config PHY_CYGNUS_PCIE
 	  Enable this to support the Broadcom Cygnus PCIe PHY.
 	  If unsure, say N.
 
+config PHY_LANTIQ_RCU_USB2
+	tristate "Lantiq XWAY SoC RCU based USB PHY"
+	depends on SOC_TYPE_XWAY
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Support for the USB PHY(s) on the Lantiq XWAY family SoCs.
+
 source "drivers/phy/tegra/Kconfig"
 
 config PHY_NS2_PCIE
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f8047b4639fa..d6ba19233001 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
 obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
 obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
+obj-$(CONFIG_PHY_LANTIQ_RCU_USB2)	+= phy-lantiq-rcu-usb2.o
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
 obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
diff --git a/drivers/phy/phy-lantiq-rcu-usb2.c b/drivers/phy/phy-lantiq-rcu-usb2.c
new file mode 100644
index 000000000000..d7a456403f8f
--- /dev/null
+++ b/drivers/phy/phy-lantiq-rcu-usb2.c
@@ -0,0 +1,275 @@
+/*
+ * Lantiq XWAY SoC RCU module based USB 1.1/2.0 PHY driver
+ *
+ * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+/* Transmitter HS Pre-Emphasis Enable */
+#define RCU_CFG1_TX_PEE		BIT(0)
+/* Disconnect Threshold */
+#define RCU_CFG1_DIS_THR_MASK	0x00038000
+#define RCU_CFG1_DIS_THR_SHIFT	15
+
+struct ltq_rcu_usb2_bits {
+	u8 hostmode;
+	u8 slave_endianness;
+	u8 host_endianness;
+	bool have_ana_cfg;
+};
+
+struct ltq_rcu_usb2_priv {
+	struct regmap			*regmap;
+	u32				phy_reg_offset;
+	u32				ana_cfg1_reg_offset;
+	const struct ltq_rcu_usb2_bits	*reg_bits;
+	struct device			*dev;
+	struct phy			*phy;
+	struct clk			*ctrl_gate_clk;
+	struct clk			*phy_gate_clk;
+	struct reset_control		*ctrl_reset;
+	struct reset_control		*phy_reset;
+};
+
+static const struct ltq_rcu_usb2_bits xway_rcu_usb2_reg_bits = {
+	.hostmode = 11,
+	.slave_endianness = 9,
+	.host_endianness = 10,
+	.have_ana_cfg = false,
+};
+
+static const struct ltq_rcu_usb2_bits xrx100_rcu_usb2_reg_bits = {
+	.hostmode = 11,
+	.slave_endianness = 17,
+	.host_endianness = 10,
+	.have_ana_cfg = false,
+};
+
+static const struct ltq_rcu_usb2_bits xrx200_rcu_usb2_reg_bits = {
+	.hostmode = 11,
+	.slave_endianness = 9,
+	.host_endianness = 10,
+	.have_ana_cfg = true,
+};
+
+static const struct of_device_id ltq_rcu_usb2_phy_of_match[] = {
+	{
+		.compatible = "lantiq,ase-rcu-usb2-phy",
+		.data = &xway_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,danube-rcu-usb2-phy",
+		.data = &xway_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,xrx100-rcu-usb2-phy",
+		.data = &xrx100_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,xrx200-rcu-usb2-phy",
+		.data = &xrx200_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,xrx300-rcu-usb2-phy",
+		.data = &xrx200_rcu_usb2_reg_bits,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltq_rcu_usb2_phy_of_match);
+
+
+static int ltq_rcu_usb2_phy_power_on(struct phy *phy)
+{
+	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
+
+	reset_control_deassert(priv->phy_reset);
+
+	return 0;
+}
+
+static int ltq_rcu_usb2_phy_power_off(struct phy *phy)
+{
+	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
+
+	reset_control_assert(priv->phy_reset);
+
+	return 0;
+}
+
+static struct phy_ops ltq_rcu_usb2_phy_ops = {
+	.power_on	= ltq_rcu_usb2_phy_power_on,
+	.power_off	= ltq_rcu_usb2_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static void ltq_rcu_usb2_start_cores(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ltq_rcu_usb2_priv *priv = dev_get_drvdata(dev);
+
+	/* Power on the USB core. */
+	if (clk_prepare_enable(priv->ctrl_gate_clk)) {
+		dev_err(dev, "failed to enable CTRL gate\n");
+		return;
+	}
+
+	/*
+	 * Power on the USB PHY. We have to do it early because
+	 * otherwise the second core won't turn on properly.
+	 */
+	if (clk_prepare_enable(priv->phy_gate_clk)) {
+		dev_err(dev, "failed to enable PHY gate\n");
+		return;
+	}
+
+	if (priv->reg_bits->have_ana_cfg) {
+		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
+			RCU_CFG1_TX_PEE, RCU_CFG1_TX_PEE);
+		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
+			RCU_CFG1_DIS_THR_MASK, 7 << RCU_CFG1_DIS_THR_SHIFT);
+	}
+
+	/* Configure core to host mode */
+	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
+			   BIT(priv->reg_bits->hostmode), 0);
+
+	/* Select DMA endianness (Host-endian: big-endian) */
+	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
+		BIT(priv->reg_bits->slave_endianness), 0);
+	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
+		BIT(priv->reg_bits->host_endianness),
+		BIT(priv->reg_bits->host_endianness));
+
+	/* Reset USB core throgh reset controller */
+	reset_control_deassert(priv->ctrl_reset);
+
+	reset_control_assert(priv->phy_reset);
+}
+
+static int ltq_rcu_usb2_of_probe(struct device_node *phynode,
+				    struct ltq_rcu_usb2_priv *priv)
+{
+	struct device *dev = priv->dev;
+	const struct of_device_id *match =
+		of_match_node(ltq_rcu_usb2_phy_of_match, phynode);
+	int ret;
+
+	if (!match) {
+		dev_err(dev, "Not a compatible Lantiq RCU USB PHY\n");
+		return -EINVAL;
+	}
+
+	priv->reg_bits = match->data;
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(phynode, "regmap");
+	if (IS_ERR(priv->regmap)) {
+		dev_err(dev, "Failed to lookup RCU regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->ctrl_gate_clk = devm_clk_get(dev, "ctrl");
+	if (IS_ERR(priv->ctrl_gate_clk)) {
+		dev_err(dev, "Unable to get USB ctrl gate clk\n");
+		return PTR_ERR(priv->ctrl_gate_clk);
+	}
+
+	priv->phy_gate_clk = devm_clk_get(dev, "phy");
+	if (IS_ERR(priv->phy_gate_clk)) {
+		dev_err(dev, "Unable to get USB phy gate clk\n");
+		return PTR_ERR(priv->phy_gate_clk);
+	}
+
+	priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
+	if (IS_ERR(priv->ctrl_reset)) {
+		if (PTR_ERR(priv->ctrl_reset) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get 'ctrl' reset\n");
+		return PTR_ERR(priv->ctrl_reset);
+	}
+
+	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");
+	if (IS_ERR(priv->phy_reset))
+		return PTR_ERR(priv->phy_reset);
+
+	ret = device_property_read_u32(dev, "offset-phy",
+				       &priv->phy_reg_offset);
+	if (ret) {
+		dev_err(dev, "Failed to get RCU PHY reg offset\n");
+		return ret;
+	}
+
+	if (priv->reg_bits->have_ana_cfg) {
+		ret = device_property_read_u32(dev, "offset-ana",
+					       &priv->ana_cfg1_reg_offset);
+		if (ret) {
+			dev_dbg(dev, "Failed to get RCU ANA CFG1 reg offset\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ltq_rcu_usb2_phy_probe(struct platform_device *pdev)
+{
+	struct device_node *child, *np = pdev->dev.of_node;
+	struct ltq_rcu_usb2_priv *priv;
+	struct phy_provider *provider;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv),
+				       GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	dev_set_drvdata(priv->dev, priv);
+
+	ret = ltq_rcu_usb2_of_probe(np, priv);
+	if (ret)
+		return ret;
+
+	priv->phy = devm_phy_create(&pdev->dev, child,
+					 &ltq_rcu_usb2_phy_ops);
+	if (IS_ERR(priv->phy)) {
+		dev_err(&pdev->dev, "failed to create PHY\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	phy_set_drvdata(priv->phy, priv);
+
+	ltq_rcu_usb2_start_cores(pdev);
+
+	provider = devm_of_phy_provider_register(&pdev->dev,
+						 of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static struct platform_driver ltq_rcu_usb2_phy_driver = {
+	.probe	= ltq_rcu_usb2_phy_probe,
+	.driver = {
+		.name	= "lantiq-rcu-usb2-phy",
+		.of_match_table	= ltq_rcu_usb2_phy_of_match,
+	}
+};
+module_platform_driver(ltq_rcu_usb2_phy_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Lantiq XWAY USB2 PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
