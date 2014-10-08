Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:09:31 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53910
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010962AbaJIPIHVkwU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:07 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 05/10] MIPS: ralink: add illegal access driver
Date:   Thu,  9 Oct 2014 01:53:00 +0200
Message-Id: <1412812385-64820-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

These SoCs have a special irq that fires upon an illegal memmory access.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Makefile  |    2 +
 arch/mips/ralink/ill_acc.c |   87 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 arch/mips/ralink/ill_acc.c

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 584a8d9..fc57c16 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -10,6 +10,8 @@ obj-y := prom.o of.o reset.o clk.o irq.o timer.o
 
 obj-$(CONFIG_CLKEVT_RT3352) += cevt-rt3352.o
 
+obj-$(CONFIG_RALINK_ILL_ACC) += ill_acc.o
+
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
new file mode 100644
index 0000000..e20b02e
--- /dev/null
+++ b/arch/mips/ralink/ill_acc.c
@@ -0,0 +1,87 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#define REG_ILL_ACC_ADDR	0x10
+#define REG_ILL_ACC_TYPE	0x14
+
+#define ILL_INT_STATUS		BIT(31)
+#define ILL_ACC_WRITE		BIT(30)
+#define ILL_ACC_LEN_M		0xff
+#define ILL_ACC_OFF_M		0xf
+#define ILL_ACC_OFF_S		16
+#define ILL_ACC_ID_M		0x7
+#define ILL_ACC_ID_S		8
+
+#define	DRV_NAME		"ill_acc"
+
+static const char * const ill_acc_ids[] = {
+	"cpu", "dma", "ppe", "pdma rx", "pdma tx", "pci/e", "wmac", "usb",
+};
+
+static irqreturn_t ill_acc_irq_handler(int irq, void *_priv)
+{
+	struct device *dev = (struct device *) _priv;
+	u32 addr = rt_memc_r32(REG_ILL_ACC_ADDR);
+	u32 type = rt_memc_r32(REG_ILL_ACC_TYPE);
+
+	dev_err(dev, "illegal %s access from %s - addr:0x%08x offset:%d len:%d\n",
+		(type & ILL_ACC_WRITE) ? ("write") : ("read"),
+		ill_acc_ids[(type >> ILL_ACC_ID_S) & ILL_ACC_ID_M],
+		addr, (type >> ILL_ACC_OFF_S) & ILL_ACC_OFF_M,
+		type & ILL_ACC_LEN_M);
+
+	rt_memc_w32(REG_ILL_ACC_TYPE, REG_ILL_ACC_TYPE);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ill_acc_of_setup(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	int irq;
+
+	/* somehow this driver breaks on RT5350 */
+	if (of_machine_is_compatible("ralink,rt5350-soc"))
+		return -EINVAL;
+
+	np = of_find_compatible_node(NULL, NULL, "ralink,rt3050-memc");
+	if (!np)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("%s: failed to lookup pdev\n", np->name);
+		return -EINVAL;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -EINVAL;
+	}
+
+	if (request_irq(irq, ill_acc_irq_handler, 0, "ill_acc", &pdev->dev)) {
+		dev_err(&pdev->dev, "failed to request irq\n");
+		return -EINVAL;
+	}
+
+	rt_memc_w32(ILL_INT_STATUS, REG_ILL_ACC_TYPE);
+
+	dev_info(&pdev->dev, "irq registered\n");
+
+	return 0;
+}
+
+arch_initcall(ill_acc_of_setup);
-- 
1.7.10.4
