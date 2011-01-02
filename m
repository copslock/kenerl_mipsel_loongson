Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 20:01:42 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43426 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491954Ab1ABS4z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 19:56:55 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id B0CA43FC049;
        Sun,  2 Jan 2011 19:56:48 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 08D311F0001;
        Sun,  2 Jan 2011 19:56:48 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        David Brownell <dbrownell@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: [PATCH v4 12/16] USB: ehci: add bus glue for the Atheros AR71XX/AR724X/AR913X SoCs
Date:   Sun,  2 Jan 2011 19:56:25 +0100
Message-Id: <1293994589-6794-13-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1293994589-6794-1-git-send-email-juhosg@openwrt.org>
References: <1293994589-6794-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A17F027C157 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28799
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
Changes since RFC:
    - don't use 'default y if SOC_*', select USB_ARCH_HAS_EHCI option in the
      platform specific Kconfig file instead
    - add missing 'ath79_ehci_platform.h' file

Changes since v1:
    - rebased against 2.6.37-rc7

Changes since v2: ---

Changes since v3:
    - rebased against 2.6.37-rc8

 arch/mips/ath79/Kconfig                            |    3 +
 .../include/asm/mach-ath79/ath79_ehci_platform.h   |   18 ++
 drivers/usb/host/Kconfig                           |    8 +
 drivers/usb/host/ehci-ath79.c                      |  176 ++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c                        |    5 +
 5 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h
 create mode 100644 drivers/usb/host/ehci-ath79.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index cd6c738..647f535 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -15,12 +15,15 @@ config ATH79_MACH_PB44
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
 
 config ATH79_DEV_GPIO_BUTTONS
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
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6f4f8e6..3a2667a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -147,6 +147,14 @@ config USB_W90X900_EHCI
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
index e906280..b1313af 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1216,6 +1216,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_octeon_driver
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
