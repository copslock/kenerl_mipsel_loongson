Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Mar 2013 23:19:43 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60881 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827501Ab3CAWTXdAhAv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Mar 2013 23:19:23 +0100
Received: by mail-ee0-f49.google.com with SMTP id d41so2681116eek.8
        for <linux-mips@linux-mips.org>; Fri, 01 Mar 2013 14:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=l4S3qeEe8NukF2GXSFCN6MVTgxK42JeKxcHRARsHuxI=;
        b=eT4DMOt/1kJ1N6BKTwRU09npvtAHxdiiS18GVD40OdfMoHiiF9+tGyjz32+U/GU8v/
         0c/isbhd7S66wfwt4J/UGuSbmsZeyKJUz7uWneCtDwSeHDLL7vgbBySDr3QcBZj/PlMK
         LmrEh1AaEMstP+0ohvZYUR1FBSgc0ydQbeahGWGpGd76Rs8lYTv+DkILmITasrr0/eX2
         XRjqsZYyetD2w2PFB7oDjSrOCqPSukIltdLH1Wuwj27lSsAR7sc4hIBZs8MEzYgjEDzz
         lTAq7A/4v095J1rCgXtbO+O+py1u0tIr2vlm4qa6xIGziU/d8nkLE74vimeKL1D+ay5O
         0X/w==
X-Received: by 10.15.23.193 with SMTP id h41mr32220943eeu.17.1362176356990;
        Fri, 01 Mar 2013 14:19:16 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id m46sm19282356eeo.16.2013.03.01.14.19.15
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Mar 2013 14:19:16 -0800 (PST)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH v2 2/2] usb: chipidea: AR933x platform support for the chipidea driver
Date:   Sat,  2 Mar 2013 00:17:37 +0200
Message-Id: <1362176257-2328-3-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362176257-2328-1-git-send-email-svetoslav@neykov.name>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQlSG/tsaV8vOBAHCd8zSjAVKA+bGmTy9OAcg5r9WhYdaMx4Rau+H9llvFUaR2AFQjJjYV+t
X-archive-position: 35832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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

Support host and device usb modes for the chipidea controller in AR933x.

Changes since last version of the patch:
	* conditionally include ci13xxx_ar933x.c for compilation
	* removed __devinit/__devexit/__devexit_p()
	* use a dynamically allocated structure for ci13xxx_platform_data
	* move controller mode check to platform usb registration
	* pick a different name for the ar933x chipidea driver
	* use a correct MODE_ALIAS name
	* use the dr_mode changes in "[PATCH 0/3] otg-for-v3.10-v2:
	  separate phy code and add DT helper"

Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
---
 arch/mips/ath79/dev-usb.c                          |   50 +++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |    3 +
 .../asm/mach-ath79/ar933x_chipidea_platform.h      |   18 +++++
 drivers/usb/chipidea/Makefile                      |    5 ++
 drivers/usb/chipidea/ci13xxx_ar933x.c              |   75 ++++++++++++++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
 create mode 100644 drivers/usb/chipidea/ci13xxx_ar933x.c

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index bd2bc10..0c285d9 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -19,9 +19,11 @@
 #include <linux/platform_device.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <linux/usb/otg.h>
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ar933x_chipidea_platform.h>
 #include "common.h"
 #include "dev-usb.h"
 
@@ -68,6 +70,22 @@ static struct platform_device ath79_ehci_device = {
 	},
 };
 
+static struct resource ar933x_chipidea_resources[2];
+
+static struct ar933x_chipidea_platform_data ar933x_chipidea_data = {
+};
+
+static struct platform_device ar933x_chipidea_device = {
+	.name		= "ar933x-chipidea",
+	.id		= -1,
+	.resource	= ar933x_chipidea_resources,
+	.num_resources	= ARRAY_SIZE(ar933x_chipidea_resources),
+	.dev = {
+		.dma_mask		= &ath79_ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
 static void __init ath79_usb_init_resource(struct resource res[2],
 					   unsigned long base,
 					   unsigned long size,
@@ -174,8 +192,32 @@ static void __init ar913x_usb_setup(void)
 	platform_device_register(&ath79_ehci_device);
 }
 
+static void __init ar933x_usb_setup_ctrl_config(void)
+{
+	void __iomem *usb_ctrl_base, *usb_config_reg;
+	u32 usb_config;
+
+	usb_ctrl_base = ioremap(AR71XX_USB_CTRL_BASE, AR71XX_USB_CTRL_SIZE);
+	usb_config_reg = usb_ctrl_base + AR71XX_USB_CTRL_REG_CONFIG;
+	usb_config = __raw_readl(usb_config_reg);
+	usb_config &= ~AR933X_USB_CONFIG_HOST_ONLY;
+	__raw_writel(usb_config, usb_config_reg);
+	iounmap(usb_ctrl_base);
+}
+
 static void __init ar933x_usb_setup(void)
 {
+	u32 bootstrap;
+	enum usb_dr_mode dr_mode;
+
+	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST) {
+		dr_mode = USB_DR_MODE_HOST;
+	} else {
+		dr_mode = USB_DR_MODE_PERIPHERAL;
+		ar933x_usb_setup_ctrl_config();
+	}
+
 	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
 	mdelay(10);
 
@@ -187,8 +229,16 @@ static void __init ar933x_usb_setup(void)
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR933X_EHCI_BASE,
 				AR933X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
+
+	ath79_usb_init_resource(ar933x_chipidea_resources, AR933X_EHCI_BASE,
+				AR933X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+
+	ar933x_chipidea_data.dr_mode = dr_mode;
+	ar933x_chipidea_device.dev.platform_data = &ar933x_chipidea_data;
+	platform_device_register(&ar933x_chipidea_device);
 }
 
 static void __init ar934x_usb_setup(void)
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index a5e0f17..13eb2d9 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -297,6 +297,7 @@
 #define AR934X_RESET_USB_PHY		BIT(4)
 #define AR934X_RESET_USBSUS_OVERRIDE	BIT(3)
 
+#define AR933X_BOOTSTRAP_USB_MODE_HOST	BIT(3)
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
 #define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
@@ -315,6 +316,8 @@
 #define AR934X_BOOTSTRAP_SDRAM_DISABLED	BIT(1)
 #define AR934X_BOOTSTRAP_DDR1		BIT(0)
 
+#define AR933X_USB_CONFIG_HOST_ONLY	BIT(8)
+
 #define AR934X_PCIE_WMAC_INT_WMAC_MISC		BIT(0)
 #define AR934X_PCIE_WMAC_INT_WMAC_TX		BIT(1)
 #define AR934X_PCIE_WMAC_INT_WMAC_RXLP		BIT(2)
diff --git a/arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h b/arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
new file mode 100644
index 0000000..2b0ee30
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
@@ -0,0 +1,18 @@
+/*
+ *  Platform data definition for Atheros AR933X Chipidea USB controller
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _AR933X_CHIPIDEA_PLATFORM_H
+#define _AR933X_CHIPIDEA_PLATFORM_H
+
+#include <linux/usb/otg.h>
+
+struct ar933x_chipidea_platform_data {
+	enum usb_dr_mode dr_mode;
+};
+
+#endif /* _AR933X_UART_PLATFORM_H */
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 146ecd7..aae70a4 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -19,3 +19,8 @@ endif
 ifneq ($(CONFIG_OF_DEVICE),)
 	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx.o
 endif
+
+ifneq ($(CONFIG_SOC_AR933X),)
+	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_ar933x.o
+endif
+
diff --git a/drivers/usb/chipidea/ci13xxx_ar933x.c b/drivers/usb/chipidea/ci13xxx_ar933x.c
new file mode 100644
index 0000000..4ba977a
--- /dev/null
+++ b/drivers/usb/chipidea/ci13xxx_ar933x.c
@@ -0,0 +1,75 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/ulpi.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/chipidea.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ar933x_chipidea_platform.h>
+
+#include "ci.h"
+
+static int ci13xxx_ar933x_probe(struct platform_device *pdev)
+{
+	u32 bootstrap;
+	struct ar933x_chipidea_platform_data *ar933x_chipidea_data;
+	struct ci13xxx_platform_data *pdata;
+	struct platform_device *plat_ci;
+
+	dev_dbg(&pdev->dev, "ci13xxx_ar933x_probe\n");
+
+	ar933x_chipidea_data = pdev->dev.platform_data;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(&pdev->dev, "Failed to allocate ci13xxx-ar933x pdata!\n");
+		return -ENOMEM;
+	}
+
+	pdata->name = "ci13xxx_ar933x";
+	pdata->capoffset = DEF_CAPOFFSET;
+	pdata->dr_mode = ar933x_chipidea_data->dr_mode;
+	plat_ci = ci13xxx_add_device(&pdev->dev,
+				pdev->resource, pdev->num_resources,
+				pdata);
+	if (IS_ERR(plat_ci)) {
+		dev_err(&pdev->dev, "ci13xxx_add_device failed!\n");
+		return PTR_ERR(plat_ci);
+	}
+
+	platform_set_drvdata(pdev, plat_ci);
+
+	pm_runtime_no_callbacks(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+static int ci13xxx_ar933x_remove(struct platform_device *pdev)
+{
+	struct platform_device *plat_ci = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	ci13xxx_remove_device(plat_ci);
+
+	return 0;
+}
+
+static struct platform_driver ci13xxx_ar933x_driver = {
+	.probe = ci13xxx_ar933x_probe,
+	.remove = ci13xxx_ar933x_remove,
+	.driver = { .name = "ar933x-chipidea", },
+};
+
+module_platform_driver(ci13xxx_ar933x_driver);
+
+MODULE_ALIAS("platform:ci13xxx_ar933x_driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
