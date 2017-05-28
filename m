Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2017 20:43:28 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:60161 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993954AbdE1Skct2w48 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 May 2017 20:40:32 +0200
Received: from hauke-desktop.lan (p2003008628351B0030562F5E961CEEA9.dip0.t-ipconnect.de [IPv6:2003:86:2835:1b00:3056:2f5e:961c:eea9])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 686DF100254;
        Sun, 28 May 2017 20:40:31 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a platform_driver
Date:   Sun, 28 May 2017 20:39:58 +0200
Message-Id: <20170528184006.31668-9-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170528184006.31668-1-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58046
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

Instead of hacking the configuration of the FPI bus into the arch code
add an own bus driver for this internal bus. The FPI bus is the main
bus of the SoC. This bus driver makes sure the bus is configured
correctly before the child drivers are getting initialized. This driver
will probably also be used on different SoC later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 33 ++++++++
 MAINTAINERS                                        |  1 +
 arch/mips/lantiq/xway/reset.c                      |  4 -
 arch/mips/lantiq/xway/sysctrl.c                    | 41 ----------
 drivers/soc/Makefile                               |  1 +
 drivers/soc/lantiq/Makefile                        |  1 +
 drivers/soc/lantiq/fpi-bus.c                       | 91 ++++++++++++++++++++++
 7 files changed, 127 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
 create mode 100644 drivers/soc/lantiq/Makefile
 create mode 100644 drivers/soc/lantiq/fpi-bus.c

diff --git a/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
new file mode 100644
index 000000000000..52d4bb9d2ffa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
@@ -0,0 +1,33 @@
+Lantiq XWAY SoC FPI BUS binding
+============================
+
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible	: Should be one of
+				"lantiq,fpi-xrx200"
+- reg		: The address and length of the XBAR configuration register.
+		  Address and length of the FPI bus itself
+
+Optional properties:
+- regmap		: A phandle to the RCU syscon
+- offset-endianness	: Offset of the endianness configuration register
+
+
+-------------------------------------------------------------------------------
+Example for the FPI on the xrx200 SoCs:
+	fpi@10000000 {
+		compatible = "lantiq,fpi-xrx200", "simple-bus";
+		ranges = <0x0 0x10000000 0xF000000>;
+		reg =	<0x1F400000 0x1000>,
+			<0x10000000 0xF000000>;
+		regmap = <&rcu0>;
+		offset-endianness = <0x4c>;
+		big-endian;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		gptu@E100A00 {
+			......
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e984645c4b0..f2c2acd6f73f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7441,6 +7441,7 @@ M:	John Crispin <john@phrozen.org>
 L:	linux-mips@linux-mips.org
 S:	Maintained
 F:	arch/mips/lantiq
+F:	drivers/soc/lantiq
 
 LAPB module
 L:	linux-x25@vger.kernel.org
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 83fd65d76e81..b6752c95a600 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -373,10 +373,6 @@ static int __init mips_reboot_setup(void)
 	    of_machine_is_compatible("lantiq,vr9"))
 		ltq_usb_init();
 
-	if (of_machine_is_compatible("lantiq,vr9"))
-		ltq_rcu_w32(ltq_rcu_r32(RCU_AHB_ENDIAN) | RCU_VR9_BE_AHB1S,
-			    RCU_AHB_ENDIAN);
-
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
 	pm_power_off = ltq_machine_power_off;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 95bec460b651..706639a343bc 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -145,15 +145,7 @@ static u32 pmu_clk_cr_b[] = {
 #define pmu_w32(x, y)	ltq_w32((x), pmu_membase + (y))
 #define pmu_r32(x)	ltq_r32(pmu_membase + (x))
 
-#define XBAR_ALWAYS_LAST	0x430
-#define XBAR_FPI_BURST_EN	BIT(1)
-#define XBAR_AHB_BURST_EN	BIT(2)
-
-#define xbar_w32(x, y)	ltq_w32((x), ltq_xbar_membase + (y))
-#define xbar_r32(x)	ltq_r32(ltq_xbar_membase + (x))
-
 static void __iomem *pmu_membase;
-static void __iomem *ltq_xbar_membase;
 void __iomem *ltq_cgu_membase;
 void __iomem *ltq_ebu_membase;
 
@@ -293,16 +285,6 @@ static void pci_ext_disable(struct clk *clk)
 	ltq_cgu_w32((1 << 31) | (1 << 30), pcicr);
 }
 
-static void xbar_fpi_burst_disable(void)
-{
-	u32 reg;
-
-	/* bit 1 as 1 --burst; bit 1 as 0 -- single */
-	reg = xbar_r32(XBAR_ALWAYS_LAST);
-	reg &= ~XBAR_FPI_BURST_EN;
-	xbar_w32(reg, XBAR_ALWAYS_LAST);
-}
-
 /* enable a clockout source */
 static int clkout_enable(struct clk *clk)
 {
@@ -459,26 +441,6 @@ void __init ltq_soc_init(void)
 	if (!pmu_membase || !ltq_cgu_membase || !ltq_ebu_membase)
 		panic("Failed to remap core resources");
 
-	if (of_machine_is_compatible("lantiq,vr9")) {
-		struct resource res_xbar;
-		struct device_node *np_xbar =
-				of_find_compatible_node(NULL, NULL,
-							"lantiq,xbar-xway");
-
-		if (!np_xbar)
-			panic("Failed to load xbar nodes from devicetree");
-		if (of_address_to_resource(np_xbar, 0, &res_xbar))
-			panic("Failed to get xbar resources");
-		if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
-			res_xbar.name))
-			panic("Failed to get xbar resources");
-
-		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
-						   resource_size(&res_xbar));
-		if (!ltq_xbar_membase)
-			panic("Failed to remap xbar resources");
-	}
-
 	/* make sure to unprotect the memory region where flash is located */
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
 
@@ -605,7 +567,4 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 		clkdev_add_pmu("1e100400.serial", NULL, 1, 0, PMU_ASC0);
 	}
-
-	if (of_machine_is_compatible("lantiq,vr9"))
-		xbar_fpi_burst_disable();
 }
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 824b44281efa..009b5de74a24 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
+obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
diff --git a/drivers/soc/lantiq/Makefile b/drivers/soc/lantiq/Makefile
new file mode 100644
index 000000000000..35aa86bd1023
--- /dev/null
+++ b/drivers/soc/lantiq/Makefile
@@ -0,0 +1 @@
+obj-y				+= fpi-bus.o
diff --git a/drivers/soc/lantiq/fpi-bus.c b/drivers/soc/lantiq/fpi-bus.c
new file mode 100644
index 000000000000..71b13c6c2553
--- /dev/null
+++ b/drivers/soc/lantiq/fpi-bus.c
@@ -0,0 +1,91 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011-2015 John Crispin <blogic@phrozen.org>
+ *  Copyright (C) 2015 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include <lantiq_soc.h>
+
+#define XBAR_ALWAYS_LAST	0x430
+#define XBAR_FPI_BURST_EN	BIT(1)
+#define XBAR_AHB_BURST_EN	BIT(2)
+
+#define RCU_VR9_BE_AHB1S	0x00000008
+
+static int ltq_fpi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res_xbar;
+	struct regmap *rcu_regmap;
+	void __iomem *xbar_membase;
+	u32 rcu_ahb_endianness_reg_offset;
+	u32 rcu_ahb_endianness_val;
+	int ret;
+
+	res_xbar = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xbar_membase = devm_ioremap_resource(dev, res_xbar);
+	if (IS_ERR(xbar_membase))
+		return PTR_ERR(xbar_membase);
+
+	/* RCU configuration is optional */
+	rcu_regmap = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (!IS_ERR_OR_NULL(rcu_regmap)) {
+		ret = device_property_read_u32(dev, "offset-endianness",
+					   &rcu_ahb_endianness_reg_offset);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+			return -EINVAL;
+		}
+
+		if (of_device_is_big_endian(np))
+			rcu_ahb_endianness_val = RCU_VR9_BE_AHB1S;
+		else
+			rcu_ahb_endianness_val = 0;
+
+		if (regmap_update_bits(rcu_regmap,
+					rcu_ahb_endianness_reg_offset,
+					RCU_VR9_BE_AHB1S,
+					rcu_ahb_endianness_val))
+			dev_warn(&pdev->dev,
+				"Failed to configure RCU AHB endianness\n");
+	}
+
+	/* disable fpi burst */
+	ltq_w32_mask(XBAR_FPI_BURST_EN, 0, xbar_membase + XBAR_ALWAYS_LAST);
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static const struct of_device_id ltq_fpi_match[] = {
+	{ .compatible = "lantiq,fpi-xrx200" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltq_fpi_match);
+
+static struct platform_driver ltq_fpi_driver = {
+	.probe = ltq_fpi_probe,
+	.driver = {
+		.name = "fpi-xway",
+		.of_match_table = ltq_fpi_match,
+	},
+};
+
+module_platform_driver(ltq_fpi_driver);
+
+MODULE_DESCRIPTION("Lantiq FPI bus driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0
