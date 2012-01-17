Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2012 06:15:09 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:41663 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903612Ab2AQFNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2012 06:13:48 +0100
Received: by mail-iy0-f177.google.com with SMTP id k3so595800iae.36
        for <multiple recipients>; Mon, 16 Jan 2012 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WN/ewXiGgRsgAcb9jiqnEH2jC9Ev2Ygj3dhDYylhVtc=;
        b=OOUcesSZw1RcRPhvKt6fHwHQCzHJZQO/KV85DOTMcezB9up/uG1XKmjYuirHyZ8VIf
         umq7JwIJWBiY+1Fnj0GR6WvnX8/au5S5e1XP8mLWTajQvf+tgupWfXSW4O30ANxwdPBK
         YlchhHaA8a3mdyLlll7qpTUEx0Fh/W17RFgJs=
Received: by 10.50.183.199 with SMTP id eo7mr15822504igc.5.1326777227920;
        Mon, 16 Jan 2012 21:13:47 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id lu10sm36937638igc.0.2012.01.16.21.13.40
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 21:13:47 -0800 (PST)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org
Cc:     gregkh@suse.de, zhzhl555@gmail.com, peppe.cavallaro@st.com,
        wuzhangjin@gmail.com, linux-kernel@vger.kernel.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V6 4/5] USB: Add EHCI bus glue for Loongson1x SoCs
Date:   Tue, 17 Jan 2012 13:12:39 +0800
Message-Id: <1326777160-9930-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1326777160-9930-1-git-send-email-keguang.zhang@gmail.com>
References: <1326777160-9930-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 32264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The Loongson1x SoCs have a built-in EHCI controller.
This patch adds the necessary glue code to make the generic EHCI
driver usable for them.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/usb/Kconfig          |    1 +
 drivers/usb/host/ehci-hcd.c  |    5 +
 drivers/usb/host/ehci-ls1x.c |  170 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-ls1x.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 85d5a01..78ac78b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -68,6 +68,7 @@ config USB_ARCH_HAS_EHCI
 	default y if ARCH_MSM
 	default y if MICROBLAZE
 	default y if SPARC_LEON
+	default y if MACH_LOONGSON1
 	default PCI
 
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 47aa22d..d38bd7c 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1291,6 +1291,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_grlib_driver
 #endif
 
+#ifdef CONFIG_MACH_LOONGSON1
+#include "ehci-ls1x.c"
+#define PLATFORM_DRIVER		ehci_ls1x_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-ls1x.c b/drivers/usb/host/ehci-ls1x.c
new file mode 100644
index 0000000..d3b6720
--- /dev/null
+++ b/drivers/usb/host/ehci-ls1x.c
@@ -0,0 +1,170 @@
+/*
+ *  Bus Glue for Loongson LS1X built-in EHCI controller.
+ *
+ *  Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+
+#include <linux/platform_device.h>
+
+static int ehci_ls1x_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int ret;
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+	ehci->sbrn = 0x20;
+
+	ehci_reset(ehci);
+
+	/* data structure init */
+	ret = ehci_init(hcd);
+	if (ret)
+		return ret;
+
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+static const struct hc_driver ehci_ls1x_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "LOONGSON1 EHCI",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset			= ehci_ls1x_setup,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number	= ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_hcd_ls1x_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res;
+	int irq;
+	int ret;
+
+	pr_debug("initializing loongson1 ehci USB Controller\n");
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"Found HC with no IRQ. Check %s setup!\n",
+			dev_name(&pdev->dev));
+		return -ENODEV;
+	}
+	irq = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"Found HC with no register addr. Check %s setup!\n",
+			dev_name(&pdev->dev));
+		return -ENODEV;
+	}
+
+	hcd = usb_create_hcd(&ehci_ls1x_hc_driver, &pdev->dev,
+				dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+	hcd->rsrc_start	= res->start;
+	hcd->rsrc_len	= resource_size(res);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		dev_dbg(&pdev->dev, "controller already in use\n");
+		ret = -EBUSY;
+		goto err_put_hcd;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (hcd->regs == NULL) {
+		dev_dbg(&pdev->dev, "error mapping memory\n");
+		ret = -EFAULT;
+		goto err_release_region;
+	}
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (ret)
+		goto err_iounmap;
+
+	return ret;
+
+err_iounmap:
+	iounmap(hcd->regs);
+err_release_region:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_put_hcd:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ehci_hcd_ls1x_remove(struct platform_device *pdev)
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
+static struct platform_driver ehci_ls1x_driver = {
+	.probe = ehci_hcd_ls1x_probe,
+	.remove = ehci_hcd_ls1x_remove,
+	.shutdown = usb_hcd_platform_shutdown,
+	.driver = {
+		.name = "ls1x-ehci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS(PLATFORM_MODULE_PREFIX "ls1x-ehci");
-- 
1.7.1
