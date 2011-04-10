Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2011 22:06:07 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43749 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491191Ab1DJUFP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Apr 2011 22:05:15 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 200CA140138;
        Sun, 10 Apr 2011 22:05:10 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 81F59140035;
        Sun, 10 Apr 2011 22:05:09 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/3] USB: ohci: add bus glue for the Atheros AR71XX/AR7240 SoCs
Date:   Sun, 10 Apr 2011 22:05:00 +0200
Message-Id: <1302465900-16814-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1302465900-16814-1-git-send-email-juhosg@openwrt.org>
References: <1302465900-16814-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A17FBAD2CCF | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

The Atheros AR71XX/AR7240 SoCs have a built-in OHCI controller.
This patch adds the necessary glue code to make the generic OHCI
driver usable for them.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
---
 arch/mips/ath79/Kconfig       |    2 +
 drivers/usb/host/Kconfig      |    8 ++
 drivers/usb/host/ohci-ath79.c |  151 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c   |    5 ++
 4 files changed, 166 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ohci-ath79.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 649a2a3..4770741 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -27,10 +27,12 @@ endmenu
 
 config SOC_AR71XX
 	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_OHCI
 	def_bool n
 
 config SOC_AR724X
 	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_OHCI
 	def_bool n
 
 config SOC_AR913X
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 9970c86..9a6751e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -295,6 +295,14 @@ config USB_OHCI_HCD_OMAP3
 	  Enables support for the on-chip OHCI controller on
 	  OMAP3 and later chips.
 
+config USB_OHCI_ATH79
+	bool "USB OHCI support for the Atheros AR71XX/AR7240 SoCs"
+	depends on USB_OHCI_HCD && (SOC_AR71XX || SOC_AR724X)
+	default y
+	help
+	  Enables support for the built-in OHCI controller present on the
+	  Atheros AR71XX/AR7240 SoCs.
+
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
 	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
diff --git a/drivers/usb/host/ohci-ath79.c b/drivers/usb/host/ohci-ath79.c
new file mode 100644
index 0000000..ffea3e7
--- /dev/null
+++ b/drivers/usb/host/ohci-ath79.c
@@ -0,0 +1,151 @@
+/*
+ *  OHCI HCD (Host Controller Driver) for USB.
+ *
+ *  Bus Glue for Atheros AR71XX/AR724X built-in OHCI controller.
+ *
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *	Copyright (C) 2007 Atheros Communications, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+
+static int __devinit ohci_ath79_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int ret;
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+
+	ret = ohci_run(ohci);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	ohci_stop(hcd);
+	return ret;
+}
+
+static const struct hc_driver ohci_ath79_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "Atheros built-in OHCI controller",
+	.hcd_priv_size		= sizeof(struct ohci_hcd),
+
+	.irq			= ohci_irq,
+	.flags			= HCD_USB11 | HCD_MEMORY,
+
+	.start			= ohci_ath79_start,
+	.stop			= ohci_stop,
+	.shutdown		= ohci_shutdown,
+
+	.urb_enqueue		= ohci_urb_enqueue,
+	.urb_dequeue		= ohci_urb_dequeue,
+	.endpoint_disable	= ohci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number	= ohci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data	= ohci_hub_status_data,
+	.hub_control		= ohci_hub_control,
+	.start_port_reset	= ohci_start_port_reset,
+};
+
+static int ohci_ath79_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res;
+	int irq;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no IRQ specified\n");
+		return -ENODEV;
+	}
+	irq = res->start;
+
+	hcd = usb_create_hcd(&ohci_ath79_hc_driver, &pdev->dev,
+			     dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no base address specified\n");
+		ret = -ENODEV;
+		goto err_put_hcd;
+	}
+	hcd->rsrc_start	= res->start;
+	hcd->rsrc_len	= res->end - res->start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		dev_dbg(&pdev->dev, "controller already in use\n");
+		ret = -EBUSY;
+		goto err_put_hcd;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		dev_dbg(&pdev->dev, "error mapping memory\n");
+		ret = -EFAULT;
+		goto err_release_region;
+	}
+
+	ohci_hcd_init(hcd_to_ohci(hcd));
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
+	if (ret)
+		goto err_stop_hcd;
+
+	return 0;
+
+err_stop_hcd:
+	iounmap(hcd->regs);
+err_release_region:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_put_hcd:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ohci_ath79_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+static struct platform_driver ohci_hcd_ath79_driver = {
+	.probe		= ohci_ath79_probe,
+	.remove		= ohci_ath79_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name	= "ath79-ohci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS(PLATFORM_MODULE_PREFIX "ath79-ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index e728863..8aec65f 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1105,6 +1105,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_cns3xxx_driver
 #endif
 
+#ifdef CONFIG_USB_OHCI_ATH79
+#include "ohci-ath79.c"
+#define PLATFORM_DRIVER		ohci_hcd_ath79_driver
+#endif
+
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
-- 
1.7.2.1
