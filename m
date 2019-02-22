Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE2EC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592D520700
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 20:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfBVUOM (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:14:12 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:9836 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBVUOM (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Feb 2019 15:14:12 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 90582A1137;
        Fri, 22 Feb 2019 21:14:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id FXTgrgaF3uua; Fri, 22 Feb 2019 21:13:58 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     paul.burton@mips.com
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        john@phrozen.org, martin.blumenstingl@googlemail.com,
        netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: lantiq: Remove separate GPHY Firmware loader
Date:   Fri, 22 Feb 2019 21:13:47 +0100
Message-Id: <20190222201347.29242-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The separate GPHY Firmware loader driver is not used any more, the GPHY
firmware is now loaded by the GSWIP switch driver which also makes use
of the GPHY.
Remove the old unused GPHY firmware loader driver.

The GPHY firmware is useless without an Ethernet and switch driver, it
should not harm if loading this does not work for system using an old
device tree.
I am not aware of any vendor separating the device tree from the kernel
binary, it should be ok to remove this.

The code and the functionality form this separate GPHY firmware loader
was added to the gswip driver in commit 14fceff4771e ("net: dsa: Add
Lantiq / Intel DSA driver for vrx200")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This should go through the MIPS tree, but any other tree should also be 
fine, I am not expecting any merge conflicts.

 .../bindings/mips/lantiq/rcu-gphy.txt         |  36 ---
 .../devicetree/bindings/mips/lantiq/rcu.txt   |  18 --
 arch/mips/configs/xway_defconfig              |   1 -
 arch/mips/lantiq/Kconfig                      |   4 -
 drivers/soc/lantiq/Makefile                   |   1 -
 drivers/soc/lantiq/gphy.c                     | 224 ------------------
 6 files changed, 284 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
 delete mode 100644 drivers/soc/lantiq/gphy.c

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
deleted file mode 100644
index a0c19bd1ce66..000000000000
--- a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Lantiq XWAY SoC GPHY binding
-============================
-
-This binding describes a software-defined ethernet PHY, provided by the RCU
-module on newer Lantiq XWAY SoCs (xRX200 and newer).
-
--------------------------------------------------------------------------------
-Required properties:
-- compatible		: Should be one of
-				"lantiq,xrx200a1x-gphy"
-				"lantiq,xrx200a2x-gphy"
-				"lantiq,xrx300-gphy"
-				"lantiq,xrx330-gphy"
-- reg			: Addrress of the GPHY FW load address register
-- resets		: Must reference the RCU GPHY reset bit
-- reset-names		: One entry, value must be "gphy" or optional "gphy2"
-- clocks		: A reference to the (PMU) GPHY clock gate
-
-Optional properties:
-- lantiq,gphy-mode	: GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
-			  <dt-bindings/mips/lantiq_xway_gphy.h>
-
-
--------------------------------------------------------------------------------
-Example for the GPHys on the xRX200 SoCs:
-
-#include <dt-bindings/mips/lantiq_rcu_gphy.h>
-	gphy0: gphy@20 {
-		compatible = "lantiq,xrx200a2x-gphy";
-		reg = <0x20 0x4>;
-
-		resets = <&reset0 31 30>, <&reset1 7 7>;
-		reset-names = "gphy", "gphy2";
-		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
-		lantiq,gphy-mode = <GPHY_MODE_GE>;
-	};
diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
index 7f0822b4beae..58d51f480c9e 100644
--- a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -26,24 +26,6 @@ Example of the RCU bindings on a xRX200 SoC:
 		ranges = <0x0 0x203000 0x100>;
 		big-endian;
 
-		gphy0: gphy@20 {
-			compatible = "lantiq,xrx200a2x-gphy";
-			reg = <0x20 0x4>;
-
-			resets = <&reset0 31 30>, <&reset1 7 7>;
-			reset-names = "gphy", "gphy2";
-			lantiq,gphy-mode = <GPHY_MODE_GE>;
-		};
-
-		gphy1: gphy@68 {
-			compatible = "lantiq,xrx200a2x-gphy";
-			reg = <0x68 0x4>;
-
-			resets = <&reset0 29 28>, <&reset1 6 6>;
-			reset-names = "gphy", "gphy2";
-			lantiq,gphy-mode = <GPHY_MODE_GE>;
-		};
-
 		reset0: reset-controller@10 {
 			compatible = "lantiq,xrx200-reset";
 			reg = <0x10 4>, <0x14 4>;
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index c3cac29e8414..2bb02ea9fb4e 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -13,7 +13,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_LANTIQ=y
 CONFIG_PCI_LANTIQ=y
-CONFIG_XRX200_PHY_FW=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_MIPS_VPE_LOADER=y
 CONFIG_NR_CPUS=2
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 188de95d6dbd..6c6802e482c9 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -52,8 +52,4 @@ config PCI_LANTIQ
 	bool "PCI Support"
 	depends on SOC_XWAY && PCI
 
-config XRX200_PHY_FW
-	bool "XRX200 PHY firmware loader"
-	depends on SOC_XWAY
-
 endif
diff --git a/drivers/soc/lantiq/Makefile b/drivers/soc/lantiq/Makefile
index be9e866d53e5..35aa86bd1023 100644
--- a/drivers/soc/lantiq/Makefile
+++ b/drivers/soc/lantiq/Makefile
@@ -1,2 +1 @@
 obj-y				+= fpi-bus.o
-obj-$(CONFIG_XRX200_PHY_FW)	+= gphy.o
diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
deleted file mode 100644
index feeb17cebc25..000000000000
--- a/drivers/soc/lantiq/gphy.c
+++ /dev/null
@@ -1,224 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2012 John Crispin <blogic@phrozen.org>
- *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
- */
-
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/firmware.h>
-#include <linux/mfd/syscon.h>
-#include <linux/module.h>
-#include <linux/reboot.h>
-#include <linux/regmap.h>
-#include <linux/reset.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/property.h>
-#include <dt-bindings/mips/lantiq_rcu_gphy.h>
-
-#include <lantiq_soc.h>
-
-#define XRX200_GPHY_FW_ALIGN	(16 * 1024)
-
-struct xway_gphy_priv {
-	struct clk *gphy_clk_gate;
-	struct reset_control *gphy_reset;
-	struct reset_control *gphy_reset2;
-	void __iomem *membase;
-	char *fw_name;
-};
-
-struct xway_gphy_match_data {
-	char *fe_firmware_name;
-	char *ge_firmware_name;
-};
-
-static const struct xway_gphy_match_data xrx200a1x_gphy_data = {
-	.fe_firmware_name = "lantiq/xrx200_phy22f_a14.bin",
-	.ge_firmware_name = "lantiq/xrx200_phy11g_a14.bin",
-};
-
-static const struct xway_gphy_match_data xrx200a2x_gphy_data = {
-	.fe_firmware_name = "lantiq/xrx200_phy22f_a22.bin",
-	.ge_firmware_name = "lantiq/xrx200_phy11g_a22.bin",
-};
-
-static const struct xway_gphy_match_data xrx300_gphy_data = {
-	.fe_firmware_name = "lantiq/xrx300_phy22f_a21.bin",
-	.ge_firmware_name = "lantiq/xrx300_phy11g_a21.bin",
-};
-
-static const struct of_device_id xway_gphy_match[] = {
-	{ .compatible = "lantiq,xrx200a1x-gphy", .data = &xrx200a1x_gphy_data },
-	{ .compatible = "lantiq,xrx200a2x-gphy", .data = &xrx200a2x_gphy_data },
-	{ .compatible = "lantiq,xrx300-gphy", .data = &xrx300_gphy_data },
-	{ .compatible = "lantiq,xrx330-gphy", .data = &xrx300_gphy_data },
-	{},
-};
-MODULE_DEVICE_TABLE(of, xway_gphy_match);
-
-static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
-			  dma_addr_t *dev_addr)
-{
-	const struct firmware *fw;
-	void *fw_addr;
-	dma_addr_t dma_addr;
-	size_t size;
-	int ret;
-
-	ret = request_firmware(&fw, priv->fw_name, dev);
-	if (ret) {
-		dev_err(dev, "failed to load firmware: %s, error: %i\n",
-			priv->fw_name, ret);
-		return ret;
-	}
-
-	/*
-	 * GPHY cores need the firmware code in a persistent and contiguous
-	 * memory area with a 16 kB boundary aligned start address.
-	 */
-	size = fw->size + XRX200_GPHY_FW_ALIGN;
-
-	fw_addr = dmam_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
-	if (fw_addr) {
-		fw_addr = PTR_ALIGN(fw_addr, XRX200_GPHY_FW_ALIGN);
-		*dev_addr = ALIGN(dma_addr, XRX200_GPHY_FW_ALIGN);
-		memcpy(fw_addr, fw->data, fw->size);
-	} else {
-		dev_err(dev, "failed to alloc firmware memory\n");
-		ret = -ENOMEM;
-	}
-
-	release_firmware(fw);
-
-	return ret;
-}
-
-static int xway_gphy_of_probe(struct platform_device *pdev,
-			      struct xway_gphy_priv *priv)
-{
-	struct device *dev = &pdev->dev;
-	const struct xway_gphy_match_data *gphy_fw_name_cfg;
-	u32 gphy_mode;
-	int ret;
-	struct resource *res_gphy;
-
-	gphy_fw_name_cfg = of_device_get_match_data(dev);
-
-	priv->gphy_clk_gate = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->gphy_clk_gate)) {
-		dev_err(dev, "Failed to lookup gate clock\n");
-		return PTR_ERR(priv->gphy_clk_gate);
-	}
-
-	res_gphy = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->membase = devm_ioremap_resource(dev, res_gphy);
-	if (IS_ERR(priv->membase))
-		return PTR_ERR(priv->membase);
-
-	priv->gphy_reset = devm_reset_control_get(dev, "gphy");
-	if (IS_ERR(priv->gphy_reset)) {
-		if (PTR_ERR(priv->gphy_reset) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to lookup gphy reset\n");
-		return PTR_ERR(priv->gphy_reset);
-	}
-
-	priv->gphy_reset2 = devm_reset_control_get_optional(dev, "gphy2");
-	if (IS_ERR(priv->gphy_reset2))
-		return PTR_ERR(priv->gphy_reset2);
-
-	ret = device_property_read_u32(dev, "lantiq,gphy-mode", &gphy_mode);
-	/* Default to GE mode */
-	if (ret)
-		gphy_mode = GPHY_MODE_GE;
-
-	switch (gphy_mode) {
-	case GPHY_MODE_FE:
-		priv->fw_name = gphy_fw_name_cfg->fe_firmware_name;
-		break;
-	case GPHY_MODE_GE:
-		priv->fw_name = gphy_fw_name_cfg->ge_firmware_name;
-		break;
-	default:
-		dev_err(dev, "Unknown GPHY mode %d\n", gphy_mode);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int xway_gphy_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct xway_gphy_priv *priv;
-	dma_addr_t fw_addr = 0;
-	int ret;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	ret = xway_gphy_of_probe(pdev, priv);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(priv->gphy_clk_gate);
-	if (ret)
-		return ret;
-
-	ret = xway_gphy_load(dev, priv, &fw_addr);
-	if (ret) {
-		clk_disable_unprepare(priv->gphy_clk_gate);
-		return ret;
-	}
-
-	reset_control_assert(priv->gphy_reset);
-	reset_control_assert(priv->gphy_reset2);
-
-	iowrite32be(fw_addr, priv->membase);
-
-	reset_control_deassert(priv->gphy_reset);
-	reset_control_deassert(priv->gphy_reset2);
-
-	platform_set_drvdata(pdev, priv);
-
-	return ret;
-}
-
-static int xway_gphy_remove(struct platform_device *pdev)
-{
-	struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
-
-	iowrite32be(0, priv->membase);
-
-	clk_disable_unprepare(priv->gphy_clk_gate);
-
-	return 0;
-}
-
-static struct platform_driver xway_gphy_driver = {
-	.probe = xway_gphy_probe,
-	.remove = xway_gphy_remove,
-	.driver = {
-		.name = "xway-rcu-gphy",
-		.of_match_table = xway_gphy_match,
-	},
-};
-
-module_platform_driver(xway_gphy_driver);
-
-MODULE_FIRMWARE("lantiq/xrx300_phy11g_a21.bin");
-MODULE_FIRMWARE("lantiq/xrx300_phy22f_a21.bin");
-MODULE_FIRMWARE("lantiq/xrx200_phy11g_a14.bin");
-MODULE_FIRMWARE("lantiq/xrx200_phy11g_a22.bin");
-MODULE_FIRMWARE("lantiq/xrx200_phy22f_a14.bin");
-MODULE_FIRMWARE("lantiq/xrx200_phy22f_a22.bin");
-MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Lantiq XWAY GPHY Firmware Loader");
-MODULE_LICENSE("GPL");
-- 
2.20.1

