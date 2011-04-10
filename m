Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2011 22:05:20 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43737 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491189Ab1DJUFO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Apr 2011 22:05:14 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 9353D14013D;
        Sun, 10 Apr 2011 22:05:09 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 1ADF7140035;
        Sun, 10 Apr 2011 22:05:09 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/3] USB: ehci: add bus glue for the Atheros AR7XXX/AR9XXX SoCs
Date:   Sun, 10 Apr 2011 22:04:58 +0200
Message-Id: <1302465900-16814-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-VBMS: A17F9B4D533 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

The Atheros AR71XX/AR9XXX SoCs have a built-in EHCI controller.
This patch adds the necessary glue code to make the generic EHCI
driver usable for them.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
---
 arch/mips/ath79/Kconfig       |    3 +
 drivers/usb/host/Kconfig      |    8 ++
 drivers/usb/host/ehci-ath79.c |  200 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c   |    5 +
 4 files changed, 216 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-ath79.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index b058282..649a2a3 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -26,12 +26,15 @@ config ATH79_MACH_PB44
 endmenu
 
 config SOC_AR71XX
+	select USB_ARCH_HAS_EHCI
 	def_bool n
 
 config SOC_AR724X
+	select USB_ARCH_HAS_EHCI
 	def_bool n
 
 config SOC_AR913X
+	select USB_ARCH_HAS_EHCI
 	def_bool n
 
 config ATH79_DEV_AR913X_WMAC
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 9483acd..9970c86 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -202,6 +202,14 @@ config USB_CNS3XXX_EHCI
 	  It is needed for high-speed (480Mbit/sec) USB 2.0 device
 	  support.
 
+config USB_EHCI_ATH79
+	bool "EHCI support for AR7XX/AR9XXX SoCs"
+	depends on USB_EHCI_HCD && ATH79
+	select USB_EHCI_ROOT_HUB_TT
+	---help---
+	  Enables support for the built-in EHCI controller present
+	  on the Atheros AR7XXX/AR9XXX SoCs.
+
 config USB_OXU210HP_HCD
 	tristate "OXU210HP HCD support"
 	depends on USB
diff --git a/drivers/usb/host/ehci-ath79.c b/drivers/usb/host/ehci-ath79.c
new file mode 100644
index 0000000..74325b8
--- /dev/null
+++ b/drivers/usb/host/ehci-ath79.c
@@ -0,0 +1,200 @@
+/*
+ *  Bus Glue for Atheros AR7XXX/AR9XXX built-in EHCI controller.
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
+enum {
+	EHCI_ATH79_IP_V1 = 0,
+	EHCI_ATH79_IP_V2,
+};
+
+static const struct platform_device_id ehci_ath79_id_table[] = {
+	{
+		.name		= "ar71xx-ehci",
+		.driver_data	= EHCI_ATH79_IP_V1,
+	},
+	{
+		.name		= "ar724x-ehci",
+		.driver_data	= EHCI_ATH79_IP_V2,
+	},
+	{
+		.name		= "ar913x-ehci",
+		.driver_data	= EHCI_ATH79_IP_V2,
+	},
+	{
+		/* terminating entry */
+	},
+};
+
+MODULE_DEVICE_TABLE(platform, ehci_ath79_id_table);
+
+static int ehci_ath79_init(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct platform_device *pdev = to_platform_device(hcd->self.controller);
+	const struct platform_device_id *id;
+	int ret;
+
+	id = platform_get_device_id(pdev);
+	if (!id) {
+		dev_err(hcd->self.controller, "missing device id\n");
+		return -EINVAL;
+	}
+
+	switch (id->driver_data) {
+	case EHCI_ATH79_IP_V1:
+		ehci->caps = hcd->regs;
+		ehci->regs = hcd->regs +
+			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+		break;
+
+	case EHCI_ATH79_IP_V2:
+		hcd->has_tt = 1;
+
+		ehci->caps = hcd->regs + 0x100;
+		ehci->regs = hcd->regs + 0x100 +
+			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+		break;
+
+	default:
+		BUG();
+	}
+
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+	ehci->sbrn = 0x20;
+
+	ehci_reset(ehci);
+
+	ret = ehci_init(hcd);
+	if (ret)
+		return ret;
+
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+static const struct hc_driver ehci_ath79_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "Atheros built-in EHCI controller",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	.reset			= ehci_ath79_init,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
+
+	.get_frame_number	= ehci_get_frame,
+
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_ath79_probe(struct platform_device *pdev)
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no base address specified\n");
+		return -ENODEV;
+	}
+
+	hcd = usb_create_hcd(&ehci_ath79_hc_driver, &pdev->dev,
+			     dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
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
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (ret)
+		goto err_iounmap;
+
+	return 0;
+
+err_iounmap:
+	iounmap(hcd->regs);
+
+err_release_region:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_put_hcd:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ehci_ath79_remove(struct platform_device *pdev)
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
+static struct platform_driver ehci_ath79_driver = {
+	.probe		= ehci_ath79_probe,
+	.remove		= ehci_ath79_remove,
+	.id_table	= ehci_ath79_id_table,
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "ath79-ehci",
+	}
+};
+
+MODULE_ALIAS(PLATFORM_MODULE_PREFIX "ath79-ehci");
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 78561d1..a29527d 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1265,6 +1265,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		tegra_ehci_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_ATH79
+#include "ehci-ath79.c"
+#define PLATFORM_DRIVER		ehci_ath79_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
-- 
1.7.2.1
