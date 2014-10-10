Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:29:32 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36768
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011008AbaJJW3PXrDLx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:15 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 01/10] MIPS: lantiq: handle vmmc memory reservation
Date:   Sat, 11 Oct 2014 00:02:25 +0200
Message-Id: <1412978554-31344-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43226
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

The Lantiq SoCs have a 2nd mips core called "voice mips macro core (vmmc)"
which is used to run the voice firmware. This driver allows us to register
a chunk of memory that the voice driver can later use for the 2nd core.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/Makefile |    2 ++
 arch/mips/lantiq/xway/vmmc.c   |   69 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/mips/lantiq/xway/vmmc.c

diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 087497d..a2edc53 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,3 +1,5 @@
 obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o dcdc.o
 
+obj-y += vmmc.o
+
 obj-$(CONFIG_XRX200_PHY_FW) += xrx200_phy_fw.o
diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
new file mode 100644
index 0000000..696cd57
--- /dev/null
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -0,0 +1,69 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/dma-mapping.h>
+
+#include <lantiq_soc.h>
+
+static unsigned int *cp1_base;
+
+unsigned int *ltq_get_cp1_base(void)
+{
+	if (!cp1_base)
+		panic("no cp1 base was set\n");
+
+	return cp1_base;
+}
+EXPORT_SYMBOL(ltq_get_cp1_base);
+
+static int vmmc_probe(struct platform_device *pdev)
+{
+#define CP1_SIZE       (1 << 20)
+	int gpio_count;
+	dma_addr_t dma;
+
+	cp1_base =
+		(void *) CPHYSADDR(dma_alloc_coherent(NULL, CP1_SIZE,
+						    &dma, GFP_ATOMIC));
+
+	gpio_count = of_gpio_count(pdev->dev.of_node);
+	while (gpio_count > 0) {
+		enum of_gpio_flags flags;
+		int gpio = of_get_gpio_flags(pdev->dev.of_node,
+					     --gpio_count, &flags);
+		if (gpio_request(gpio, "vmmc-relay"))
+			continue;
+		dev_info(&pdev->dev, "requested GPIO %d\n", gpio);
+		gpio_direction_output(gpio,
+				      (flags & OF_GPIO_ACTIVE_LOW) ? (0) : (1));
+	}
+
+	dev_info(&pdev->dev, "reserved %dMB at 0x%p", CP1_SIZE >> 20, cp1_base);
+
+	return 0;
+}
+
+static const struct of_device_id vmmc_match[] = {
+	{ .compatible = "lantiq,vmmc-xway" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, vmmc_match);
+
+static struct platform_driver vmmc_driver = {
+	.probe = vmmc_probe,
+	.driver = {
+		.name = "lantiq,vmmc",
+		.owner = THIS_MODULE,
+		.of_match_table = vmmc_match,
+	},
+};
+
+module_platform_driver(vmmc_driver);
-- 
1.7.10.4
