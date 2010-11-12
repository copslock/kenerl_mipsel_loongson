Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:54:58 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56998 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492165Ab0KLVv7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:59 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 664BA41C010;
        Fri, 12 Nov 2010 22:51:53 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 9C874270001;
        Fri, 12 Nov 2010 22:51:52 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        David Brownell <dbrownell@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: [RFC 15/18] USB: ohci: add bus glue for the Atheros AR71XX/AR7240 SoCs
Date:   Fri, 12 Nov 2010 22:51:21 +0100
Message-Id: <1289598684-30624-16-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A122AADFFD6 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28373
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
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org
---
Sorry for sending this twice, i forgot to add some CCs in the first round.
 .../include/asm/mach-ath79/ath79_ehci_platform.h   |   18 +++
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/host/Kconfig                           |    8 +
 drivers/usb/host/ohci-ath79.c                      |  162 ++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 5 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h
 create mode 100644 drivers/usb/host/ohci-ath79.c

diff --git a/arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h b/arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h
new file mode 100644
index 0000000..6ee075f
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h
@@ -0,0 +1,18 @@
+/*
+ *  Platform data definition for Atheros AR71XX/AR913X EHCI controller
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_EHCI_PLATFORM_H
+#define _ATH79_EHCI_PLATFORM_H
+
+struct ath79_ehci_platform_data {
+	u8	is_ar913x;
+};
+
+#endif /* _ATH79_EHCI_PLATFORM_H */
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index a4d06bb..6e21ab8 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -47,6 +47,8 @@ config USB_ARCH_HAS_OHCI
 	# MIPS:
 	default y if MIPS_ALCHEMY
 	default y if MACH_JZ4740
+	default y if SOC_AR71XX
+	default y if SOC_AR724X
 	# SH:
 	default y if CPU_SUBTYPE_SH7720
 	default y if CPU_SUBTYPE_SH7721
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d01e878..14e13a2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -239,6 +239,14 @@ config USB_OHCI_HCD_OMAP3
 	  Enables support for the on-chip OHCI controller on
 	  OMAP3 and later chips.
 
+config USB_OHCI_ATH79
+	bool "USB OHCI support for the Atheros AR71XX/AR724X SoCs"
+	depends on USB_OHCI_HCD && (SOC_AR71XX || SOC_AR724X)
+	default y
+	help
+	  Enables support for the uilt-in OHCI controller present on the
+	  Atheros AR71XX/AR724X SoCs.
+
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
 	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
diff --git a/drivers/usb/host/ohci-ath79.c b/drivers/usb/host/ohci-ath79.c
new file mode 100644
index 0000000..6e864bf
--- /dev/null
+++ b/drivers/usb/host/ohci-ath79.c
@@ -0,0 +1,162 @@
+/*
+ *  OHCI HCD (Host Controller Driver) for USB.
+ *
+ *  Bus Glue for Atheros AR71XX/AR724X built-in OHCI controller.
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
+
+static int usb_hcd_ath79_probe(const struct hc_driver *driver,
+			       struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res;
+	int irq;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no IRQ specified for %s\n",
+			dev_name(&pdev->dev));
+		return -ENODEV;
+	}
+	irq = res->start;
+
+	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "no base address specified for %s\n",
+			dev_name(&pdev->dev));
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
+void usb_hcd_ath79_remove(struct usb_hcd *hcd, struct platform_device *pdev)
+{
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+}
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
+static int ohci_hcd_ath79_drv_probe(struct platform_device *pdev)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	return usb_hcd_ath79_probe(&ohci_ath79_hc_driver, pdev);
+}
+
+static int ohci_hcd_ath79_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_hcd_ath79_remove(hcd, pdev);
+	return 0;
+}
+
+static struct platform_driver ohci_hcd_ath79_driver = {
+	.probe		= ohci_hcd_ath79_drv_probe,
+	.remove		= ohci_hcd_ath79_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name	= "ath79-ohci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS("platform:ath79-ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index f3713f4..470895b 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1106,6 +1106,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER	ohci_hcd_jz4740_driver
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
