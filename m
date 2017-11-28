Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:30:55 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:39359 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdK1P17gyZ2Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:27:59 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 5B5A520742; Tue, 28 Nov 2017 16:27:53 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 29CAA2074D;
        Tue, 28 Nov 2017 16:27:43 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 07/13] power: reset: Add a driver for the Microsemi Ocelot reset
Date:   Tue, 28 Nov 2017 16:26:37 +0100
Message-Id: <20171128152643.20463-8-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

The Microsemi Ocelot SoC has a register allowing to reset the MIPS core.
Unfortunately, the syscon-reboot driver can't be used directly (but almost)
as the reset control may be disabled using another register.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

 drivers/power/reset/Kconfig        |  7 +++
 drivers/power/reset/Makefile       |  1 +
 drivers/power/reset/ocelot-reset.c | 87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/power/reset/ocelot-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca0de1a78e85..2372f8e1040d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -113,6 +113,13 @@ config POWER_RESET_MSM
 	help
 	  Power off and restart support for Qualcomm boards.
 
+config POWER_RESET_OCELOT_RESET
+	bool "Microsemi Ocelot reset driver"
+	depends on MSCC_OCELOT || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  This driver supports restart for Microsemi Ocelot SoC.
+
 config POWER_RESET_PIIX4_POWEROFF
 	tristate "Intel PIIX4 power-off driver"
 	depends on PCI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index aeb65edb17b7..df9d92291c67 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
new file mode 100644
index 000000000000..d27e3d51f6a4
--- /dev/null
+++ b/drivers/power/reset/ocelot-reset.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi MIPS SoC reset driver
+ *
+ * License: Dual MIT/GPL
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/notifier.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+struct ocelot_reset_context {
+	struct regmap *chip_regs;
+	struct regmap *cpu_ctrl;
+	struct notifier_block restart_handler;
+};
+
+#define ICPU_CFG_CPU_SYSTEM_CTRL_RESET 0x20
+#define CORE_RST_PROTECT BIT(2)
+
+#define CHIP_REGS_SOFT_RST 0x8
+#define SOFT_CHIP_RST BIT(0)
+
+static int ocelot_restart_handle(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	struct ocelot_reset_context *ctx = container_of(this, struct
+							ocelot_reset_context,
+							restart_handler);
+
+	/* Make sure the core is not protected from reset */
+	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
+			   CORE_RST_PROTECT, 0);
+
+	regmap_write(ctx->chip_regs, CHIP_REGS_SOFT_RST, SOFT_CHIP_RST);
+
+	pr_emerg("Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
+static int ocelot_reset_probe(struct platform_device *pdev)
+{
+	struct ocelot_reset_context *ctx;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->chip_regs = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(ctx->chip_regs))
+		return PTR_ERR(ctx->chip_regs);
+
+	ctx->cpu_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
+							"mscc,cpucontrol");
+	if (IS_ERR(ctx->cpu_ctrl))
+		return PTR_ERR(ctx->cpu_ctrl);
+
+	ctx->restart_handler.notifier_call = ocelot_restart_handle;
+	ctx->restart_handler.priority = 192;
+	err = register_restart_handler(&ctx->restart_handler);
+	if (err)
+		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
+
+	return err;
+}
+
+static const struct of_device_id ocelot_reset_of_match[] = {
+	{ .compatible = "mscc,ocelot-chip-reset" },
+	{}
+};
+
+static struct platform_driver ocelot_reset_driver = {
+	.probe = ocelot_reset_probe,
+	.driver = {
+		.name = "ocelot-chip-reset",
+		.of_match_table = ocelot_reset_of_match,
+	},
+};
+builtin_platform_driver(ocelot_reset_driver);
-- 
2.15.0
