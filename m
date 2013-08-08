Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:15:04 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50037 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822308Ab3HHJOdfu6jw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:14:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/4] MIPS: lantiq: adds minimal dcdc driver
Date:   Thu,  8 Aug 2013 11:07:24 +0200
Message-Id: <1375952846-25812-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37445
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

This driver so far only reads the core voltage.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/Makefile |    2 +-
 arch/mips/lantiq/xway/dcdc.c   |   75 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/lantiq/xway/dcdc.c

diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 7a13660..087497d 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,3 +1,3 @@
-obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o
+obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o dcdc.o
 
 obj-$(CONFIG_XRX200_PHY_FW) += xrx200_phy_fw.o
diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
new file mode 100644
index 0000000..6361c30
--- /dev/null
+++ b/arch/mips/lantiq/xway/dcdc.c
@@ -0,0 +1,75 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 Sameer Ahmad, Lantiq GmbH
+ */
+
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+
+#include <lantiq_soc.h>
+
+/* Bias and regulator Setup Register */
+#define DCDC_BIAS_VREG0	0xa
+/* Bias and regulator Setup Register */
+#define DCDC_BIAS_VREG1	0xb
+
+#define dcdc_w8(x, y)	ltq_w8((x), dcdc_membase + (y))
+#define dcdc_r8(x)	ltq_r8(dcdc_membase + (x))
+
+static void __iomem *dcdc_membase;
+
+static int dcdc_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource\n");
+		return -ENOMEM;
+	}
+
+	/* remap dcdc register range */
+	dcdc_membase = devm_request_and_ioremap(&pdev->dev, res);
+	if (!dcdc_membase) {
+		dev_err(&pdev->dev, "Failed to remap resource\n");
+		return -ENOMEM;
+	}
+
+	dev_info(&pdev->dev, "Core Voltage : %d mV\n",
+		dcdc_r8(DCDC_BIAS_VREG1) * 8);
+
+	return 0;
+}
+
+static const struct of_device_id dcdc_match[] = {
+	{ .compatible = "lantiq,dcdc-xrx200" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dcdc_match);
+
+static struct platform_driver dcdc_driver = {
+	.probe = dcdc_probe,
+	.driver = {
+		.name = "dcdc-xrx200",
+		.owner = THIS_MODULE,
+		.of_match_table = dcdc_match,
+	},
+};
+
+int __init dcdc_init(void)
+{
+	int ret = platform_driver_register(&dcdc_driver);
+
+	if (ret)
+		pr_info("dcdc: Error registering platform driver\n");
+	return ret;
+}
+
+arch_initcall(dcdc_init);
-- 
1.7.10.4
