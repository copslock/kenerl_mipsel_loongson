Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 23:21:39 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45817 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903704Ab2AUWTz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 23:19:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id AEBB98F63;
        Sat, 21 Jan 2012 23:19:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MZapiaf0oG1c; Sat, 21 Jan 2012 23:19:50 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 56AF78F64;
        Sat, 21 Jan 2012 23:19:44 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        zajec5@gmail.com, linux-wireless@vger.kernel.org, m@bues.ch,
        george@znau.edu.ua, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] USB: EHCI: Add a generic platform device driver
Date:   Sat, 21 Jan 2012 23:19:24 +0100
Message-Id: <1327184367-8824-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1327184367-8824-1-git-send-email-hauke@hauke-m.de>
References: <1327184367-8824-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This adds a generic driver for platform devices. It works like the PCI
driver and is based on it. This is for devices which do not have an own
bus but their EHCI controller works like a PCI controller. It will be
used for the Broadcom bcma and ssb USB EHCI controller.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/usb/host/Kconfig         |   10 ++
 drivers/usb/host/ehci-hcd.c      |    5 +
 drivers/usb/host/ehci-platform.c |  211 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-platform.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6651ed6..e7b5efe 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -403,6 +403,16 @@ config USB_OHCI_HCD_PLATFORM
 
 	  If unsure, say N.
 
+config USB_EHCI_HCD_PLATFORM
+	bool "Generic EHCI driver for a platform device"
+	depends on USB_EHCI_HCD && EXPERIMENTAL
+	default n
+	---help---
+	  Adds an EHCI host driver for a generic platform device, which
+	  provieds a memory space and an irq.
+
+	  If unsure, say N.
+
 config USB_OHCI_BIG_ENDIAN_DESC
 	bool
 	depends on USB_OHCI_HCD
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index a007a9f..afe0984 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1376,6 +1376,11 @@ MODULE_LICENSE ("GPL");
 #define        PLATFORM_DRIVER         ehci_mv_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_PLATFORM
+#include "ehci-platform.c"
+#define PLATFORM_DRIVER		ehci_platform_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
new file mode 100644
index 0000000..1c20c02
--- /dev/null
+++ b/drivers/usb/host/ehci-platform.c
@@ -0,0 +1,211 @@
+/*
+ * Generic platform ehci driver
+ *
+ * Copyright 2007 Steven Brown <sbrown@cortland.com>
+ * Copyright 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Derived from the ohci-ssb driver
+ * Copyright 2007 Michael Buesch <m@bues.ch>
+ *
+ * Derived from the EHCI-PCI driver
+ * Copyright (c) 2000-2004 by David Brownell
+ *
+ * Derived from the ohci-pci driver
+ * Copyright 1999 Roman Weissgaerber
+ * Copyright 2000-2002 David Brownell
+ * Copyright 1999 Linus Torvalds
+ * Copyright 1999 Gregory P. Smith
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+#include <linux/platform_device.h>
+
+static int ehci_platform_reset(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int retval;
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
+
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	ehci_reset(ehci);
+
+	ehci_port_power(ehci, 1);
+
+	return retval;
+}
+
+static const struct hc_driver ehci_platform_hc_driver = {
+	.description		= "platform-usb-ehci",
+	.product_desc		= "Generic Platform EHCI Controller",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	.reset			= ehci_platform_reset,
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
+#if defined(CONFIG_PM)
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+#endif
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.update_device		= ehci_update_device,
+
+	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_platform_attach(struct platform_device *dev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res_irq, *res_mem;
+	int err = -ENOMEM;
+
+	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
+			     dev_name(&dev->dev));
+	if (!hcd)
+		goto err_return;
+
+	res_irq = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+	if (!res_irq) {
+		err = -ENXIO;
+		goto err_return;
+	}
+	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res_mem) {
+		err = -ENXIO;
+		goto err_return;
+	}
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = res_mem->end - res_mem->start + 1;
+
+	/*
+	 * start & size modified per sbutils.c
+	 */
+	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs)
+		goto err_put_hcd;
+	err = usb_add_hcd(hcd, res_irq->start, IRQF_SHARED);
+	if (err)
+		goto err_iounmap;
+
+	platform_set_drvdata(dev, hcd);
+
+	return err;
+
+err_iounmap:
+	iounmap(hcd->regs);
+err_put_hcd:
+	usb_put_hcd(hcd);
+err_return:
+	return err;
+}
+
+static int ehci_platform_probe(struct platform_device *dev)
+{
+	int err;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	err = ehci_platform_attach(dev);
+
+	return err;
+}
+
+static int ehci_platform_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd;
+
+	hcd = platform_get_drvdata(dev);
+	if (!hcd)
+		return -ENODEV;
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+static void ehci_platform_shutdown(struct platform_device *dev)
+{
+	struct usb_hcd *hcd;
+
+	hcd = platform_get_drvdata(dev);
+	if (!hcd)
+		return;
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+
+#ifdef CONFIG_PM
+
+static int ehci_platform_suspend(struct platform_device *dev,
+				 pm_message_t state)
+{
+	return 0;
+}
+
+static int ehci_platform_resume(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
+	ehci_finish_controller_resume(hcd);
+	return 0;
+}
+
+#else /* !CONFIG_PM */
+#define ehci_platform_suspend	NULL
+#define ehci_platform_resume	NULL
+#endif /* CONFIG_PM */
+
+static const struct platform_device_id ehci_platform_table[] = {
+	{ "ehci-platform", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ehci_platform_table);
+
+static struct platform_driver ehci_platform_driver = {
+	.id_table	= ehci_platform_table,
+	.probe		= ehci_platform_probe,
+	.remove		= ehci_platform_remove,
+	.shutdown	= ehci_platform_shutdown,
+	.suspend	= ehci_platform_suspend,
+	.resume		= ehci_platform_resume,
+	.driver		= {
+		.name	= "ehci-platform",
+	}
+};
-- 
1.7.5.4
