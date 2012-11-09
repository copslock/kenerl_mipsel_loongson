Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 19:39:01 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42447 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826543Ab2KIShbwoypw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 19:37:31 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 6/6] MIPS: lantiq: adds GPHY firmware loader
Date:   Fri,  9 Nov 2012 19:36:23 +0100
Message-Id: <1352486183-22576-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
References: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34927
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The internal GPHYs need a firmware blob to function properly. This patch adds
the code needed to request the blob and load it to the PHY.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/Kconfig              |    4 ++
 arch/mips/lantiq/xway/Makefile        |    2 +
 arch/mips/lantiq/xway/xrx200_phy_fw.c |   97 +++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index d84f361..c002191 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -36,4 +36,8 @@ config PCI_LANTIQ
 	bool "PCI Support"
 	depends on SOC_XWAY && PCI
 
+config XRX200_PHY_FW
+	bool "XRX200 PHY firmware loader"
+	depends on SOC_XWAY
+
 endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 70a58c7..7a13660 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1 +1,3 @@
 obj-y := prom.o sysctrl.o clk.o reset.o dma.o gptu.o
+
+obj-$(CONFIG_XRX200_PHY_FW) += xrx200_phy_fw.o
diff --git a/arch/mips/lantiq/xway/xrx200_phy_fw.c b/arch/mips/lantiq/xway/xrx200_phy_fw.c
new file mode 100644
index 0000000..fe808bf
--- /dev/null
+++ b/arch/mips/lantiq/xway/xrx200_phy_fw.c
@@ -0,0 +1,97 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/of_platform.h>
+
+#include <lantiq_soc.h>
+
+#define XRX200_GPHY_FW_ALIGN	(16 * 1024)
+
+static dma_addr_t xway_gphy_load(struct platform_device *pdev)
+{
+	const struct firmware *fw;
+	dma_addr_t dev_addr = 0;
+	const char *fw_name;
+	void *fw_addr;
+	size_t size;
+
+	if (of_property_read_string(pdev->dev.of_node, "firmware", &fw_name)) {
+		dev_err(&pdev->dev, "failed to load firmware filename\n");
+		return 0;
+	}
+
+	dev_info(&pdev->dev, "requesting %s\n", fw_name);
+	if (request_firmware(&fw, fw_name, &pdev->dev)) {
+		dev_err(&pdev->dev, "failed to load firmware: %s\n", fw_name);
+		return 0;
+	}
+
+	/*
+	 * GPHY cores need the firmware code in a persistent and contiguous
+	 * memory area with a 16 kB boundary aligned start address
+	 */
+	size = fw->size + XRX200_GPHY_FW_ALIGN;
+
+	fw_addr = dma_alloc_coherent(&pdev->dev, size, &dev_addr, GFP_KERNEL);
+	if (fw_addr) {
+		fw_addr = PTR_ALIGN(fw_addr, XRX200_GPHY_FW_ALIGN);
+		dev_addr = ALIGN(dev_addr, XRX200_GPHY_FW_ALIGN);
+		memcpy(fw_addr, fw->data, fw->size);
+	} else {
+		dev_err(&pdev->dev, "failed to alloc firmware memory\n");
+	}
+
+	release_firmware(fw);
+	return dev_addr;
+}
+
+static int __devinit xway_phy_fw_probe(struct platform_device *pdev)
+{
+	dma_addr_t fw_addr;
+	struct property *pp;
+	unsigned char *phyids;
+	int i, ret = 0;
+
+	fw_addr = xway_gphy_load(pdev);
+	if (!fw_addr)
+		return -EINVAL;
+	pp = of_find_property(pdev->dev.of_node, "phys", NULL);
+	if (!pp)
+		return -ENOENT;
+	phyids = pp->value;
+	for (i = 0; i < pp->length && !ret; i++)
+		ret = xrx200_gphy_boot(&pdev->dev, phyids[i], fw_addr);
+	if (!ret)
+		mdelay(100);
+	return ret;
+}
+
+static const struct of_device_id xway_phy_match[] = {
+	{ .compatible = "lantiq,phy-xrx200" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xway_phy_match);
+
+static struct platform_driver xway_phy_driver = {
+	.probe = xway_phy_fw_probe,
+	.driver = {
+		.name = "phy-xrx200",
+		.owner = THIS_MODULE,
+		.of_match_table = xway_phy_match,
+	},
+};
+
+module_platform_driver(xway_phy_driver);
+
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("Lantiq XRX200 PHY Firmware Loader");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4
