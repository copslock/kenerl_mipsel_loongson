Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 19:25:18 +0200 (CEST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:35595 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012009AbbHCRZIQ4D9d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 19:25:08 +0200
Received: from localhost.localdomain (unknown [176.4.89.174])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 2A568A620B;
        Mon,  3 Aug 2015 19:24:54 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/3] reset: Add a driver for the reset controller on the AR71XX/AR9XXX
Date:   Mon,  3 Aug 2015 19:23:52 +0200
Message-Id: <1438622633-9407-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1438622633-9407-1-git-send-email-albeu@free.fr>
References: <1438622633-9407-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48555
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

The AR71XX/AR9XXX SoC have a simple reset controller with one bit per
reset line.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig           |   1 +
 drivers/reset/Makefile      |   1 +
 drivers/reset/reset-ath79.c | 128 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/reset/reset-ath79.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cee5f93..d896ffb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -118,6 +118,7 @@ config ATH25
 
 config ATH79
 	bool "Atheros AR71XX/AR724X/AR913X based boards"
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select BOOT_RAW
 	select CEVT_R4K
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 157d421..f8db9b7 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
+obj-$(CONFIG_ATH79) += reset-ath79.o
diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
new file mode 100644
index 0000000..d2d2904
--- /dev/null
+++ b/drivers/reset/reset-ath79.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+struct ath79_reset {
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+	spinlock_t lock;
+};
+
+static int ath79_reset_update(struct reset_controller_dev *rcdev,
+			unsigned long id, bool assert)
+{
+	struct ath79_reset *ath79_reset =
+		container_of(rcdev, struct ath79_reset, rcdev);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&ath79_reset->lock, flags);
+	val = readl(ath79_reset->base);
+	if (assert)
+		val |= BIT(id);
+	else
+		val &= ~BIT(id);
+	writel(val, ath79_reset->base);
+	spin_unlock_irqrestore(&ath79_reset->lock, flags);
+
+	return 0;
+}
+
+static int ath79_reset_assert(struct reset_controller_dev *rcdev,
+			unsigned long id)
+{
+	return ath79_reset_update(rcdev, id, true);
+}
+
+static int ath79_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return ath79_reset_update(rcdev, id, false);
+}
+
+static int ath79_reset_status(struct reset_controller_dev *rcdev,
+			unsigned long id)
+{
+	struct ath79_reset *ath79_reset =
+		container_of(rcdev, struct ath79_reset, rcdev);
+	u32 val;
+
+	val = readl(ath79_reset->base);
+
+	return !!(val & BIT(id));
+}
+
+static struct reset_control_ops ath79_reset_ops = {
+	.assert = ath79_reset_assert,
+	.deassert = ath79_reset_deassert,
+	.status = ath79_reset_status,
+};
+
+static int ath79_reset_probe(struct platform_device *pdev)
+{
+	struct ath79_reset *ath79_reset;
+	struct resource *res;
+
+	ath79_reset = devm_kzalloc(&pdev->dev,
+				sizeof(*ath79_reset), GFP_KERNEL);
+	if (!ath79_reset)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ath79_reset);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ath79_reset->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ath79_reset->base))
+		return PTR_ERR(ath79_reset->base);
+
+	ath79_reset->rcdev.ops = &ath79_reset_ops;
+	ath79_reset->rcdev.owner = THIS_MODULE;
+	ath79_reset->rcdev.of_node = pdev->dev.of_node;
+	ath79_reset->rcdev.of_reset_n_cells = 1;
+	ath79_reset->rcdev.nr_resets = 32;
+
+	return reset_controller_register(&ath79_reset->rcdev);
+}
+
+static int ath79_reset_remove(struct platform_device *pdev)
+{
+	struct ath79_reset *ath79_reset = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&ath79_reset->rcdev);
+
+	return 0;
+}
+
+static const struct of_device_id ath79_reset_dt_ids[] = {
+	{ .compatible = "qca,ar7100-reset", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ath79_reset_dt_ids);
+
+static struct platform_driver ath79_reset_driver = {
+	.probe	= ath79_reset_probe,
+	.remove = ath79_reset_remove,
+	.driver = {
+		.name		= "ath79-reset",
+		.of_match_table	= ath79_reset_dt_ids,
+	},
+};
+module_platform_driver(ath79_reset_driver);
+
+MODULE_AUTHOR("Alban Bedel <albeu@free.fr>");
+MODULE_DESCRIPTION("AR71xx Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.0.0
