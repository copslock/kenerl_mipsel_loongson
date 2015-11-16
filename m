Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 22:23:24 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:55727 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013951AbbKPVXBvlOqF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 22:23:01 +0100
Received: from localhost.localdomain (unknown [78.54.254.43])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 86CE3A6245;
        Mon, 16 Nov 2015 22:22:45 +0100 (CET)
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
Subject: [PATCH v2 3/5] phy: Add a driver for the ATH79 USB phy
Date:   Mon, 16 Nov 2015 22:22:02 +0100
Message-Id: <1447708924-15076-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447708924-15076-1-git-send-email-albeu@free.fr>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49953
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

The ATH79 USB phy is very simple, it only have a reset. On some SoC a
second reset is used to force the phy in suspend mode regardless of the
USB controller status.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Rebased on the simple PHY driver
    * Added myself as maintainer of the driver
---
 MAINTAINERS                 |   8 +++
 drivers/phy/Kconfig         |   8 +++
 drivers/phy/Makefile        |   1 +
 drivers/phy/phy-ath79-usb.c | 116 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 drivers/phy/phy-ath79-usb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..310ff8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1823,6 +1823,14 @@ S:	Maintained
 F:	drivers/gpio/gpio-ath79.c
 F:	Documentation/devicetree/bindings/gpio/gpio-ath79.txt
 
+ATHEROS 71XX/9XXX USB PHY DRIVER
+M:	Alban Bedel <albeu@free.fr>
+W:	https://github.com/AlbanBedel/linux
+T:	git git://github.com/AlbanBedel/linux
+S:	Maintained
+F:	drivers/phy/phy-ath79-usb.c
+F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
+
 ATHEROS ATH GENERIC UTILITIES
 M:	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 028fb16..c8f58ae 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -15,6 +15,14 @@ config GENERIC_PHY
 	  phy users can obtain reference to the PHY. All the users of this
 	  framework should select this config.
 
+config PHY_ATH79_USB
+	tristate "Atheros AR71XX/9XXX USB PHY driver"
+	depends on ATH79 || COMPILE_TEST
+	default y if USB_EHCI_HCD_PLATFORM
+	select PHY_SIMPLE
+	help
+	  Enable this to support the USB PHY on Atheros AR71XX/9XXX SoCs.
+
 config PHY_BERLIN_USB
 	tristate "Marvell Berlin USB PHY Driver"
 	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 1a44362..9ff8550 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_PHY_ATH79_USB)		+= phy-ath79-usb.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
 obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
diff --git a/drivers/phy/phy-ath79-usb.c b/drivers/phy/phy-ath79-usb.c
new file mode 100644
index 0000000..ff49356
--- /dev/null
+++ b/drivers/phy/phy-ath79-usb.c
@@ -0,0 +1,116 @@
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
+#include <linux/platform_device.h>
+#include <linux/phy/simple.h>
+#include <linux/reset.h>
+
+struct ath79_usb_phy {
+	struct simple_phy sphy;
+	struct reset_control *suspend_override;
+};
+
+static int ath79_usb_phy_power_on(struct phy *phy)
+{
+	struct ath79_usb_phy *priv = container_of(
+		phy_get_drvdata(phy), struct ath79_usb_phy, sphy);
+	int err;
+
+	err = simple_phy_power_on(phy);
+	if (err)
+		return err;
+
+	if (priv->suspend_override) {
+		err = reset_control_assert(priv->suspend_override);
+		if (err) {
+			simple_phy_power_off(phy);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int ath79_usb_phy_power_off(struct phy *phy)
+{
+	struct ath79_usb_phy *priv = container_of(
+		phy_get_drvdata(phy), struct ath79_usb_phy, sphy);
+	int err;
+
+	if (priv->suspend_override) {
+		err = reset_control_deassert(priv->suspend_override);
+		if (err)
+			return err;
+	}
+
+	err = simple_phy_power_off(phy);
+	if (err && priv->suspend_override)
+		reset_control_assert(priv->suspend_override);
+
+	return err;
+}
+
+static const struct phy_ops ath79_usb_phy_ops = {
+	.power_on	= ath79_usb_phy_power_on,
+	.power_off	= ath79_usb_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static const struct simple_phy_desc ath79_usb_phy_desc = {
+	.ops = &ath79_usb_phy_ops,
+	.reset = "usb-phy",
+	.clk = (void *)-ENOENT,
+};
+
+static int ath79_usb_phy_probe(struct platform_device *pdev)
+{
+	struct ath79_usb_phy *priv;
+	struct phy *phy;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->suspend_override = devm_reset_control_get_optional(
+		&pdev->dev, "usb-suspend-override");
+	if (IS_ERR(priv->suspend_override)) {
+		if (PTR_ERR(priv->suspend_override) == -ENOENT)
+			priv->suspend_override = NULL;
+		else
+			return PTR_ERR(priv->suspend_override);
+	}
+
+	phy = devm_simple_phy_create(&pdev->dev,
+				&ath79_usb_phy_desc, &priv->sphy);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	return PTR_ERR_OR_ZERO(devm_of_phy_provider_register(
+				&pdev->dev, of_phy_simple_xlate));
+}
+
+static const struct of_device_id ath79_usb_phy_of_match[] = {
+	{ .compatible = "qca,ar7100-usb-phy" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ath79_usb_phy_of_match);
+
+static struct platform_driver ath79_usb_phy_driver = {
+	.probe	= ath79_usb_phy_probe,
+	.driver = {
+		.of_match_table	= ath79_usb_phy_of_match,
+		.name		= "ath79-usb-phy",
+	}
+};
+module_platform_driver(ath79_usb_phy_driver);
+
+MODULE_DESCRIPTION("ATH79 USB PHY driver");
+MODULE_AUTHOR("Alban Bedel <albeu@free.fr>");
+MODULE_LICENSE("GPL");
-- 
2.0.0
