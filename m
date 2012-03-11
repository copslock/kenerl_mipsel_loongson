Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2012 21:11:48 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42581 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903723Ab2CKUJf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Mar 2012 21:09:35 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B1B318F61;
        Sun, 11 Mar 2012 21:09:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c8716hg2WYLU; Sun, 11 Mar 2012 21:09:17 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id B3CDF8F67;
        Sun, 11 Mar 2012 21:08:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Gabor Juhos <juhosg@openwrt.org>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: [PATCH 7/7] USB: use generic platform driver on ath79
Date:   Sun, 11 Mar 2012 21:08:25 +0100
Message-Id: <1331496505-18697-8-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The ath79 usb driver doesn't do anything special and is now converted
to the generic ehci and ohci driver.
This was tested on a TP-Link TL-WR1043ND (AR9132)

CC: Gabor Juhos <juhosg@openwrt.org>
CC: Imre Kaloz <kaloz@openwrt.org>
CC: linux-mips@linux-mips.org
CC: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/ath79/dev-usb.c     |   31 +++++-
 drivers/usb/host/Kconfig      |   17 ----
 drivers/usb/host/ehci-ath79.c |  208 -----------------------------------------
 drivers/usb/host/ehci-hcd.c   |    5 -
 drivers/usb/host/ohci-ath79.c |  151 -----------------------------
 drivers/usb/host/ohci-hcd.c   |    5 -
 6 files changed, 25 insertions(+), 392 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-ath79.c
 delete mode 100644 drivers/usb/host/ohci-ath79.c

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 002d6d2..36e9570 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -17,6 +17,8 @@
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
@@ -36,14 +38,19 @@ static struct resource ath79_ohci_resources[] = {
 };
 
 static u64 ath79_ohci_dmamask = DMA_BIT_MASK(32);
+
+static struct usb_ohci_pdata ath79_ohci_pdata = {
+};
+
 static struct platform_device ath79_ohci_device = {
-	.name		= "ath79-ohci",
+	.name		= "ohci-platform",
 	.id		= -1,
 	.resource	= ath79_ohci_resources,
 	.num_resources	= ARRAY_SIZE(ath79_ohci_resources),
 	.dev = {
 		.dma_mask		= &ath79_ohci_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &ath79_ohci_pdata,
 	},
 };
 
@@ -60,8 +67,20 @@ static struct resource ath79_ehci_resources[] = {
 };
 
 static u64 ath79_ehci_dmamask = DMA_BIT_MASK(32);
+
+static struct usb_ehci_pdata ath79_ehci_pdata_v1 = {
+	.has_synopsys_hc_bug	= 1,
+	.port_power_off		= 1,
+};
+
+static struct usb_ehci_pdata ath79_ehci_pdata_v2 = {
+	.caps_offset		= 0x100,
+	.has_tt			= 1,
+	.port_power_off		= 1,
+};
+
 static struct platform_device ath79_ehci_device = {
-	.name		= "ath79-ehci",
+	.name		= "ehci-platform",
 	.id		= -1,
 	.resource	= ath79_ehci_resources,
 	.num_resources	= ARRAY_SIZE(ath79_ehci_resources),
@@ -101,7 +120,7 @@ static void __init ath79_usb_setup(void)
 
 	ath79_ehci_resources[0].start = AR71XX_EHCI_BASE;
 	ath79_ehci_resources[0].end = AR71XX_EHCI_BASE + AR71XX_EHCI_SIZE - 1;
-	ath79_ehci_device.name = "ar71xx-ehci";
+	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v1;
 	platform_device_register(&ath79_ehci_device);
 }
 
@@ -142,7 +161,7 @@ static void __init ar724x_usb_setup(void)
 
 	ath79_ehci_resources[0].start = AR724X_EHCI_BASE;
 	ath79_ehci_resources[0].end = AR724X_EHCI_BASE + AR724X_EHCI_SIZE - 1;
-	ath79_ehci_device.name = "ar724x-ehci";
+	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
 
@@ -159,7 +178,7 @@ static void __init ar913x_usb_setup(void)
 
 	ath79_ehci_resources[0].start = AR913X_EHCI_BASE;
 	ath79_ehci_resources[0].end = AR913X_EHCI_BASE + AR913X_EHCI_SIZE - 1;
-	ath79_ehci_device.name = "ar913x-ehci";
+	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
 
@@ -176,7 +195,7 @@ static void __init ar933x_usb_setup(void)
 
 	ath79_ehci_resources[0].start = AR933X_EHCI_BASE;
 	ath79_ehci_resources[0].end = AR933X_EHCI_BASE + AR933X_EHCI_SIZE - 1;
-	ath79_ehci_device.name = "ar933x-ehci";
+	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
 
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 665fb89..41c38e8 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -217,15 +217,6 @@ config USB_CNS3XXX_EHCI
 	  It is needed for high-speed (480Mbit/sec) USB 2.0 device
 	  support.
 
-config USB_EHCI_ATH79
-	bool "EHCI support for AR7XXX/AR9XXX SoCs"
-	depends on USB_EHCI_HCD && (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X)
-	select USB_EHCI_ROOT_HUB_TT
-	default y
-	---help---
-	  Enables support for the built-in EHCI controller present
-	  on the Atheros AR7XXX/AR9XXX SoCs.
-
 config USB_OXU210HP_HCD
 	tristate "OXU210HP HCD support"
 	depends on USB
@@ -311,14 +302,6 @@ config USB_OHCI_HCD_OMAP3
 	  Enables support for the on-chip OHCI controller on
 	  OMAP3 and later chips.
 
-config USB_OHCI_ATH79
-	bool "USB OHCI support for the Atheros AR71XX/AR7240 SoCs"
-	depends on USB_OHCI_HCD && (SOC_AR71XX || SOC_AR724X)
-	default y
-	help
-	  Enables support for the built-in OHCI controller present on the
-	  Atheros AR71XX/AR7240 SoCs.
-
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
 	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
diff --git a/drivers/usb/host/ehci-ath79.c b/drivers/usb/host/ehci-ath79.c
deleted file mode 100644
index f1424f9..0000000
--- a/drivers/usb/host/ehci-ath79.c
+++ /dev/null
@@ -1,208 +0,0 @@
-/*
- *  Bus Glue for Atheros AR7XXX/AR9XXX built-in EHCI controller.
- *
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
- *	Copyright (C) 2007 Atheros Communications, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-
-enum {
-	EHCI_ATH79_IP_V1 = 0,
-	EHCI_ATH79_IP_V2,
-};
-
-static const struct platform_device_id ehci_ath79_id_table[] = {
-	{
-		.name		= "ar71xx-ehci",
-		.driver_data	= EHCI_ATH79_IP_V1,
-	},
-	{
-		.name		= "ar724x-ehci",
-		.driver_data	= EHCI_ATH79_IP_V2,
-	},
-	{
-		.name		= "ar913x-ehci",
-		.driver_data	= EHCI_ATH79_IP_V2,
-	},
-	{
-		.name		= "ar933x-ehci",
-		.driver_data	= EHCI_ATH79_IP_V2,
-	},
-	{
-		/* terminating entry */
-	},
-};
-
-MODULE_DEVICE_TABLE(platform, ehci_ath79_id_table);
-
-static int ehci_ath79_init(struct usb_hcd *hcd)
-{
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-	struct platform_device *pdev = to_platform_device(hcd->self.controller);
-	const struct platform_device_id *id;
-	int ret;
-
-	id = platform_get_device_id(pdev);
-	if (!id) {
-		dev_err(hcd->self.controller, "missing device id\n");
-		return -EINVAL;
-	}
-
-	switch (id->driver_data) {
-	case EHCI_ATH79_IP_V1:
-		ehci->has_synopsys_hc_bug = 1;
-
-		ehci->caps = hcd->regs;
-		ehci->regs = hcd->regs +
-			HC_LENGTH(ehci,
-				  ehci_readl(ehci, &ehci->caps->hc_capbase));
-		break;
-
-	case EHCI_ATH79_IP_V2:
-		hcd->has_tt = 1;
-
-		ehci->caps = hcd->regs + 0x100;
-		ehci->regs = hcd->regs + 0x100 +
-			HC_LENGTH(ehci,
-				  ehci_readl(ehci, &ehci->caps->hc_capbase));
-		break;
-
-	default:
-		BUG();
-	}
-
-	dbg_hcs_params(ehci, "reset");
-	dbg_hcc_params(ehci, "reset");
-	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
-	ehci->sbrn = 0x20;
-
-	ehci_reset(ehci);
-
-	ret = ehci_init(hcd);
-	if (ret)
-		return ret;
-
-	ehci_port_power(ehci, 0);
-
-	return 0;
-}
-
-static const struct hc_driver ehci_ath79_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "Atheros built-in EHCI controller",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
-
-	.reset			= ehci_ath79_init,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
-
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
-
-	.get_frame_number	= ehci_get_frame,
-
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-
-	.relinquish_port	= ehci_relinquish_port,
-	.port_handed_over	= ehci_port_handed_over,
-
-	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
-};
-
-static int ehci_ath79_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct resource *res;
-	int irq;
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_dbg(&pdev->dev, "no IRQ specified\n");
-		return -ENODEV;
-	}
-	irq = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_dbg(&pdev->dev, "no base address specified\n");
-		return -ENODEV;
-	}
-
-	hcd = usb_create_hcd(&ehci_ath79_hc_driver, &pdev->dev,
-			     dev_name(&pdev->dev));
-	if (!hcd)
-		return -ENOMEM;
-
-	hcd->rsrc_start	= res->start;
-	hcd->rsrc_len	= resource_size(res);
-
-	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
-		dev_dbg(&pdev->dev, "controller already in use\n");
-		ret = -EBUSY;
-		goto err_put_hcd;
-	}
-
-	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
-	if (!hcd->regs) {
-		dev_dbg(&pdev->dev, "error mapping memory\n");
-		ret = -EFAULT;
-		goto err_release_region;
-	}
-
-	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
-	if (ret)
-		goto err_iounmap;
-
-	return 0;
-
-err_iounmap:
-	iounmap(hcd->regs);
-
-err_release_region:
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-err_put_hcd:
-	usb_put_hcd(hcd);
-	return ret;
-}
-
-static int ehci_ath79_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-	iounmap(hcd->regs);
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-static struct platform_driver ehci_ath79_driver = {
-	.probe		= ehci_ath79_probe,
-	.remove		= ehci_ath79_remove,
-	.id_table	= ehci_ath79_id_table,
-	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= "ath79-ehci",
-	}
-};
-
-MODULE_ALIAS(PLATFORM_MODULE_PREFIX "ath79-ehci");
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index afe0984..b417926 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1351,11 +1351,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		s5p_ehci_driver
 #endif
 
-#ifdef CONFIG_USB_EHCI_ATH79
-#include "ehci-ath79.c"
-#define PLATFORM_DRIVER		ehci_ath79_driver
-#endif
-
 #ifdef CONFIG_SPARC_LEON
 #include "ehci-grlib.c"
 #define PLATFORM_DRIVER		ehci_grlib_driver
diff --git a/drivers/usb/host/ohci-ath79.c b/drivers/usb/host/ohci-ath79.c
deleted file mode 100644
index 18d574d..0000000
--- a/drivers/usb/host/ohci-ath79.c
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- *  OHCI HCD (Host Controller Driver) for USB.
- *
- *  Bus Glue for Atheros AR71XX/AR724X built-in OHCI controller.
- *
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
- *	Copyright (C) 2007 Atheros Communications, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-
-static int __devinit ohci_ath79_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	ret = ohci_init(ohci);
-	if (ret < 0)
-		return ret;
-
-	ret = ohci_run(ohci);
-	if (ret < 0)
-		goto err;
-
-	return 0;
-
-err:
-	ohci_stop(hcd);
-	return ret;
-}
-
-static const struct hc_driver ohci_ath79_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "Atheros built-in OHCI controller",
-	.hcd_priv_size		= sizeof(struct ohci_hcd),
-
-	.irq			= ohci_irq,
-	.flags			= HCD_USB11 | HCD_MEMORY,
-
-	.start			= ohci_ath79_start,
-	.stop			= ohci_stop,
-	.shutdown		= ohci_shutdown,
-
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ohci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ohci_hub_status_data,
-	.hub_control		= ohci_hub_control,
-	.start_port_reset	= ohci_start_port_reset,
-};
-
-static int ohci_ath79_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct resource *res;
-	int irq;
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_dbg(&pdev->dev, "no IRQ specified\n");
-		return -ENODEV;
-	}
-	irq = res->start;
-
-	hcd = usb_create_hcd(&ohci_ath79_hc_driver, &pdev->dev,
-			     dev_name(&pdev->dev));
-	if (!hcd)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_dbg(&pdev->dev, "no base address specified\n");
-		ret = -ENODEV;
-		goto err_put_hcd;
-	}
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
-
-	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
-		dev_dbg(&pdev->dev, "controller already in use\n");
-		ret = -EBUSY;
-		goto err_put_hcd;
-	}
-
-	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
-	if (!hcd->regs) {
-		dev_dbg(&pdev->dev, "error mapping memory\n");
-		ret = -EFAULT;
-		goto err_release_region;
-	}
-
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
-	ret = usb_add_hcd(hcd, irq, 0);
-	if (ret)
-		goto err_stop_hcd;
-
-	return 0;
-
-err_stop_hcd:
-	iounmap(hcd->regs);
-err_release_region:
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-err_put_hcd:
-	usb_put_hcd(hcd);
-	return ret;
-}
-
-static int ohci_ath79_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-	iounmap(hcd->regs);
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-static struct platform_driver ohci_hcd_ath79_driver = {
-	.probe		= ohci_ath79_probe,
-	.remove		= ohci_ath79_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver		= {
-		.name	= "ath79-ohci",
-		.owner	= THIS_MODULE,
-	},
-};
-
-MODULE_ALIAS(PLATFORM_MODULE_PREFIX "ath79-ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index a2f4d4e..813714d 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1106,11 +1106,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_cns3xxx_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_ATH79
-#include "ohci-ath79.c"
-#define PLATFORM_DRIVER		ohci_hcd_ath79_driver
-#endif
-
 #ifdef CONFIG_CPU_XLR
 #include "ohci-xls.c"
 #define PLATFORM_DRIVER		ohci_xls_driver
-- 
1.7.5.4
