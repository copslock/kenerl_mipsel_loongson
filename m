Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:58:46 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:57019 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492174Ab0KLVwA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:52:00 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 1AA9A41C00F;
        Fri, 12 Nov 2010 22:51:53 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 54BE5270002;
        Fri, 12 Nov 2010 22:51:52 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        David Brownell <dbrownell@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: [RFC 14/18] USB: ehci: add bus glue for the Atheros AR71XX/AR724X/AR913X SoCs
Date:   Fri, 12 Nov 2010 22:51:20 +0100
Message-Id: <1289598684-30624-15-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A122A696A1A | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

The Atheros AR71XX/AR724X/AR913X SoCs have a built-in EHCI controller.
This patch adds the necessary glue code to make the generic EHCI driver
usable for them.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org
---
Sorry for sending this twice, i forgot to add some CCs in the first round.
 drivers/usb/Kconfig           |    3 +
 drivers/usb/host/Kconfig      |    8 ++
 drivers/usb/host/ehci-ath79.c |  176 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c   |    5 +
 4 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-ath79.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 67eb377..a4d06bb 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -60,6 +60,9 @@ config USB_ARCH_HAS_EHCI
 	boolean
 	default y if PPC_83xx
 	default y if PPC_MPC512x
+	default y if SOC_AR71XX
+	default y if SOC_AR724X
+	default y if SOC_AR913X
 	default y if SOC_AU1200
 	default y if ARCH_IXP4XX
 	default y if ARCH_W90X900
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index bf2e7d2..d01e878 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -146,6 +146,14 @@ config USB_W90X900_EHCI
 	---help---
 		Enables support for the W90X900 USB controller
 
+config USB_EHCI_ATH79
+	bool "EHCI support for AR71XX/AR724X/AR913X SoCs"
+	depends on USB_EHCI_HCD && ATH79
+	select USB_EHCI_ROOT_HUB_TT
+	---help---
+	  Enables support for the built-in EHCI controller present
+	  on the Atheros AR71XX/AR724X/AR913X SoCs.
+
 config USB_OXU210HP_HCD
 	tristate "OXU210HP HCD support"
 	depends on USB
diff --git a/drivers/usb/host/ehci-ath79.c b/drivers/usb/host/ehci-ath79.c
new file mode 100644
index 0000000..43a728f
--- /dev/null
+++ b/drivers/usb/host/ehci-ath79.c
@@ -0,0 +1,176 @@
+/*
+ *  Bus Glue for Atheros AR71XX/AR913X built-in EHCI controller.
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
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
+#include <asm/mach-ath79/ath79_ehci_platform.h>
+
+static int ehci_ath79_init(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct ath79_ehci_platform_data *pdata;
+	int ret;
+
+	pdata = hcd->self.controller->platform_data;
+
+	if (pdata->is_ar913x) {
+		hcd->has_tt = 1;
+
+		ehci->caps = hcd->regs + 0x100;
+		ehci->regs = hcd->regs + 0x100 +
+			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	} else {
+		ehci->has_synopsys_hc_bug = 1;
+
+		ehci->caps = hcd->regs;
+		ehci->regs = hcd->regs +
+			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	}
+
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
+#ifdef CONFIG_PM
+	.hub_suspend		= ehci_hub_suspend,
+	.hub_resume		= ehci_hub_resume,
+#endif
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_ath79_probe(struct platform_device *pdev)
+{
+	struct ath79_ehci_platform_data *pdata;
+	struct usb_hcd *hcd;
+	struct resource *res;
+	int irq;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "no platform data specified for %s\n",
+			dev_name(&pdev->dev));
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no IRQ specified for %s\n",
+			dev_name(&pdev->dev));
+		return -ENODEV;
+	}
+	irq = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no base address specified for %s\n",
+			dev_name(&pdev->dev));
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
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "ath79-ehci",
+	}
+};
+
+MODULE_ALIAS("platform:ath79-ehci");
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 2adae8e..05e759d 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1211,6 +1211,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_atmel_driver
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
