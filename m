Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 22:17:18 +0200 (CEST)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:34455 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014986AbbDAUQnetKG- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 22:16:43 +0200
Received: by obcuy5 with SMTP id uy5so6962875obc.1
        for <linux-mips@linux-mips.org>; Wed, 01 Apr 2015 13:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QqpZ8f2vJ/2OpTvwCL9TOLdDqN98nbrBUTsT32mI16Q=;
        b=WBRogu6NI6/nz4e2lIV8BG8ZKDwB6e+V1UViBd+ySv7hzIHvZMljXNJj+MVpQmrl2b
         XbJACBVGZQlc+TKp8ESwRHHHJEhJSoEj1M7Xaml6/xVtXaKWzaaSSDPIIKuD7X0xRrqG
         DwwcnRVDDWNoseK2r7DqdjQD622Vjd7hGizVtRAUAZt82DyQQRJHccfULDyJe5vJ7L/f
         mLa7zTCX1o67EK0rIz3KjrsSh42bRRXQ8teV3t1yOvPjQ02vegaADJM75VMIoElluDAz
         RD70NHYake7NXVN5JW7WupNaUMN7qpfpNI+dl0VUXZj0hh1xW5d022UER9bl8Lgm7Hvv
         2KQw==
X-Gm-Message-State: ALoCoQkgJ2yJYhKcV/MhN4VxU0PebRjthpm1DAfCBI5Y56r2ktbp3FqO9G0RGa4keK6aWcaVSvRg
X-Received: by 10.182.248.227 with SMTP id yp3mr55168585obc.22.1427919398679;
        Wed, 01 Apr 2015 13:16:38 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id a76si133067yha.0.2015.04.01.13.16.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 13:16:38 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id GKXMlHIl.1; Wed, 01 Apr 2015 13:16:38 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 9B4AD220636; Wed,  1 Apr 2015 13:16:37 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 2/2] phy: Add driver for Pistachio USB2.0 PHY
Date:   Wed,  1 Apr 2015 13:16:34 -0700
Message-Id: <1427919394-3580-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1427919394-3580-1-git-send-email-abrestic@chromium.org>
References: <1427919394-3580-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add a driver for the USB2.0 PHY found on the IMG Pistachio SoC.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/phy/Kconfig             |   7 ++
 drivers/phy/Makefile            |   1 +
 drivers/phy/phy-pistachio-usb.c | 206 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/phy/phy-pistachio-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2962de2..717f30d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -225,6 +225,13 @@ config PHY_EXYNOS5_USBDRD
 	  This driver provides PHY interface for USB 3.0 DRD controller
 	  present on Exynos5 SoC series.
 
+config PHY_PISTACHIO_USB
+	tristate "IMG Pistachio USB2.0 PHY driver"
+	depends on MACH_PISTACHIO
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB2.0 PHY on the IMG Pistachio SoC.
+
 config PHY_QCOM_APQ8064_SATA
 	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
 	depends on ARCH_QCOM
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f080e1b..e561708 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_PHY_STIH41X_USB)		+= phy-stih41x-usb.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
+obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
diff --git a/drivers/phy/phy-pistachio-usb.c b/drivers/phy/phy-pistachio-usb.c
new file mode 100644
index 0000000..84cb760
--- /dev/null
+++ b/drivers/phy/phy-pistachio-usb.c
@@ -0,0 +1,206 @@
+/*
+ * IMG Pistachio USB PHY driver
+ *
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/phy/phy-pistachio-usb.h>
+
+#define USB_PHY_CONTROL1				0x04
+#define USB_PHY_CONTROL1_FSEL_SHIFT			2
+#define USB_PHY_CONTROL1_FSEL_MASK			0x7
+
+#define USB_PHY_STRAP_CONTROL				0x10
+#define USB_PHY_STRAP_CONTROL_REFCLK_SHIFT		4
+#define USB_PHY_STRAP_CONTROL_REFCLK_MASK		0x3
+
+#define USB_PHY_STATUS					0x14
+#define USB_PHY_STATUS_RX_PHY_CLK			BIT(9)
+#define USB_PHY_STATUS_RX_UTMI_CLK			BIT(8)
+#define USB_PHY_STATUS_VBUS_FAULT			BIT(7)
+
+struct pistachio_usb_phy {
+	struct device *dev;
+	struct regmap *cr_top;
+	struct clk *phy_clk;
+	unsigned int refclk;
+};
+
+static const unsigned long fsel_rate_map[] = {
+	9600000,
+	10000000,
+	12000000,
+	19200000,
+	20000000,
+	24000000,
+	0,
+	50000000,
+};
+
+static int pistachio_usb_phy_power_on(struct phy *phy)
+{
+	struct pistachio_usb_phy *p_phy = phy_get_drvdata(phy);
+	unsigned long timeout, rate;
+	unsigned int i;
+	int ret;
+
+	ret = clk_prepare_enable(p_phy->phy_clk);
+	if (ret < 0) {
+		dev_err(p_phy->dev, "Failed to enable PHY clock: %d\n", ret);
+		return ret;
+	}
+
+	regmap_update_bits(p_phy->cr_top, USB_PHY_STRAP_CONTROL,
+			   USB_PHY_STRAP_CONTROL_REFCLK_MASK <<
+			   USB_PHY_STRAP_CONTROL_REFCLK_SHIFT,
+			   p_phy->refclk << USB_PHY_STRAP_CONTROL_REFCLK_SHIFT);
+
+	rate = clk_get_rate(p_phy->phy_clk);
+	if (p_phy->refclk == REFCLK_XO_CRYSTAL && rate != 12000000) {
+		dev_err(p_phy->dev, "Unspported rate for XO crystal: %ld\n",
+			rate);
+		ret = -EINVAL;
+		goto disable_clk;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(fsel_rate_map); i++) {
+		if (rate == fsel_rate_map[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(fsel_rate_map)) {
+		dev_err(p_phy->dev, "Unspported clock rate: %lu\n", rate);
+		ret = -EINVAL;
+		goto disable_clk;
+	}
+
+	regmap_update_bits(p_phy->cr_top, USB_PHY_CONTROL1,
+			   USB_PHY_CONTROL1_FSEL_MASK <<
+			   USB_PHY_CONTROL1_FSEL_SHIFT,
+			   i << USB_PHY_CONTROL1_FSEL_SHIFT);
+
+	timeout = jiffies + msecs_to_jiffies(200);
+	while (time_before(jiffies, timeout)) {
+		unsigned int val;
+
+		regmap_read(p_phy->cr_top, USB_PHY_STATUS, &val);
+		if (val & USB_PHY_STATUS_VBUS_FAULT) {
+			dev_err(p_phy->dev, "VBUS fault detected\n");
+			ret = -EIO;
+			goto disable_clk;
+		}
+		if ((val & USB_PHY_STATUS_RX_PHY_CLK) &&
+		    (val & USB_PHY_STATUS_RX_UTMI_CLK))
+			return 0;
+		usleep_range(1000, 1500);
+	}
+
+	dev_err(p_phy->dev, "Timed out waiting for PHY to power on\n");
+	ret = -ETIMEDOUT;
+
+disable_clk:
+	clk_disable_unprepare(p_phy->phy_clk);
+	return ret;
+}
+
+static int pistachio_usb_phy_power_off(struct phy *phy)
+{
+	struct pistachio_usb_phy *p_phy = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(p_phy->phy_clk);
+
+	return 0;
+}
+
+static const struct phy_ops pistachio_usb_phy_ops = {
+	.power_on = pistachio_usb_phy_power_on,
+	.power_off = pistachio_usb_phy_power_off,
+	.owner = THIS_MODULE,
+};
+
+static int pistachio_usb_phy_probe(struct platform_device *pdev)
+{
+	struct pistachio_usb_phy *p_phy;
+	struct phy_provider *provider;
+	struct phy *phy;
+	int ret;
+
+	p_phy = devm_kzalloc(&pdev->dev, sizeof(*p_phy), GFP_KERNEL);
+	if (!p_phy)
+		return -ENOMEM;
+	p_phy->dev = &pdev->dev;
+	platform_set_drvdata(pdev, p_phy);
+
+	p_phy->cr_top = syscon_regmap_lookup_by_phandle(p_phy->dev->of_node,
+							"img,cr-top");
+	if (IS_ERR(p_phy->cr_top)) {
+		dev_err(p_phy->dev, "Failed to get CR_TOP registers: %ld\n",
+			PTR_ERR(p_phy->cr_top));
+		return PTR_ERR(p_phy->cr_top);
+	}
+
+	p_phy->phy_clk = devm_clk_get(p_phy->dev, "usb_phy");
+	if (IS_ERR(p_phy->phy_clk)) {
+		dev_err(p_phy->dev, "Failed to get usb_phy clock: %ld\n",
+			PTR_ERR(p_phy->phy_clk));
+		return PTR_ERR(p_phy->phy_clk);
+	}
+
+	ret = of_property_read_u32(p_phy->dev->of_node, "img,refclk",
+				   &p_phy->refclk);
+	if (ret < 0) {
+		dev_err(p_phy->dev, "No reference clock selector specified\n");
+		return ret;
+	}
+
+	phy = devm_phy_create(p_phy->dev, NULL, &pistachio_usb_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(p_phy->dev, "Failed to create PHY: %ld\n",
+			PTR_ERR(phy));
+		return PTR_ERR(phy);
+	}
+	phy_set_drvdata(phy, p_phy);
+
+	provider = devm_of_phy_provider_register(p_phy->dev,
+						 of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(p_phy->dev, "Failed to register PHY provider: %ld\n",
+			PTR_ERR(provider));
+		return PTR_ERR(provider);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pistachio_usb_phy_of_match[] = {
+	{ .compatible = "img,pistachio-usb-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pistachio_usb_phy_of_match);
+
+static struct platform_driver pistachio_usb_phy_driver = {
+	.probe		= pistachio_usb_phy_probe,
+	.driver		= {
+		.name	= "pistachio-usb-phy",
+		.of_match_table = pistachio_usb_phy_of_match,
+	},
+};
+module_platform_driver(pistachio_usb_phy_driver);
+
+MODULE_AUTHOR("Andrew Bresticker <abrestic@chromium.org>");
+MODULE_DESCRIPTION("IMG Pistachio USB2.0 PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.2.0.rc0.207.ga3a616c
