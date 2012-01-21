Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 23:21:13 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45808 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1901171Ab2AUWTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 23:19:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 82AA48F62;
        Sat, 21 Jan 2012 23:19:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hJcWSFOjH5+g; Sat, 21 Jan 2012 23:19:48 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id EEA488F63;
        Sat, 21 Jan 2012 23:19:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        zajec5@gmail.com, linux-wireless@vger.kernel.org, m@bues.ch,
        george@znau.edu.ua, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] USB: OHCI: Add a generic platform device driver
Date:   Sat, 21 Jan 2012 23:19:23 +0100
Message-Id: <1327184367-8824-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1327184367-8824-1-git-send-email-hauke@hauke-m.de>
References: <1327184367-8824-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This adds a generic driver for platform devices. It works like the PCI
driver and is based on it. This is for devices which do not have an own
bus but their OHCI controller works like a PCI controller. It will be
used for the Broadcom bcma and ssb USB OHCI controller.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/usb/host/Kconfig         |   10 ++
 drivers/usb/host/ohci-hcd.c      |    5 +
 drivers/usb/host/ohci-platform.c |  193 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ohci-platform.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 91413ca..6651ed6 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -393,6 +393,16 @@ config USB_CNS3XXX_OHCI
 	  Enable support for the CNS3XXX SOC's on-chip OHCI controller.
 	  It is needed for low-speed USB 1.0 device support.
 
+config USB_OHCI_HCD_PLATFORM
+	bool "OHCI driver for a platform device"
+	depends on USB_OHCI_HCD && EXPERIMENTAL
+	default n
+	---help---
+	  Adds an OHCI host driver for a generic platform device, which
+	  provieds a memory space and an irq.
+
+	  If unsure, say N.
+
 config USB_OHCI_BIG_ENDIAN_DESC
 	bool
 	depends on USB_OHCI_HCD
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 34b9edd..50fbbf9 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1121,6 +1121,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_xls_driver
 #endif
 
+#ifdef CONFIG_USB_OHCI_HCD_PLATFORM
+#include "ohci-platform.c"
+#define PLATFORM_DRIVER		ohci_platform_driver
+#endif
+
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
new file mode 100644
index 0000000..1b5fc73
--- /dev/null
+++ b/drivers/usb/host/ohci-platform.c
@@ -0,0 +1,193 @@
+/*
+ * Generic platform ohci driver
+ *
+ * Copyright 2007 Michael Buesch <m@bues.ch>
+ * Copyright 2011 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Derived from the OCHI-SSB driver
+ * Derived from the OHCI-PCI driver
+ * Copyright 1999 Roman Weissgaerber
+ * Copyright 2000-2002 David Brownell
+ * Copyright 1999 Linus Torvalds
+ * Copyright 1999 Gregory P. Smith
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+#include <linux/platform_device.h>
+
+static int ohci_platform_reset(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int err;
+
+	ohci_hcd_init(ohci);
+	err = ohci_init(ohci);
+
+	return err;
+}
+
+static int ohci_platform_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int err;
+
+	err = ohci_run(ohci);
+	if (err < 0) {
+		ohci_err(ohci, "can't start\n");
+		ohci_stop(hcd);
+	}
+
+	return err;
+}
+
+static const struct hc_driver ohci_platform_hc_driver = {
+	.description		= "platform-usb-ohci",
+	.product_desc		= "Generic Platform OHCI Controller",
+	.hcd_priv_size		= sizeof(struct ohci_hcd),
+
+	.irq			= ohci_irq,
+	.flags			= HCD_MEMORY | HCD_USB11,
+
+	.reset			= ohci_platform_reset,
+	.start			= ohci_platform_start,
+	.stop			= ohci_stop,
+	.shutdown		= ohci_shutdown,
+
+	.urb_enqueue		= ohci_urb_enqueue,
+	.urb_dequeue		= ohci_urb_dequeue,
+	.endpoint_disable	= ohci_endpoint_disable,
+
+	.get_frame_number	= ohci_get_frame,
+
+	.hub_status_data	= ohci_hub_status_data,
+	.hub_control		= ohci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend		= ohci_bus_suspend,
+	.bus_resume		= ohci_bus_resume,
+#endif
+
+	.start_port_reset	= ohci_start_port_reset,
+};
+
+static int ohci_platform_attach(struct platform_device *dev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res_irq, *res_mem;
+	int err = -ENOMEM;
+
+	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
+			dev_name(&dev->dev));
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
+static int ohci_platform_probe(struct platform_device *dev)
+{
+	int err;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	err = ohci_platform_attach(dev);
+
+	return err;
+}
+
+static int ohci_platform_remove(struct platform_device *dev)
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
+static void ohci_platform_shutdown(struct platform_device *dev)
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
+static int ohci_platform_suspend(struct platform_device *dev,
+				 pm_message_t state)
+{
+
+	return 0;
+}
+
+static int ohci_platform_resume(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
+	ohci_finish_controller_resume(hcd);
+	return 0;
+}
+
+#else /* !CONFIG_PM */
+#define ohci_platform_suspend	NULL
+#define ohci_platform_resume	NULL
+#endif /* CONFIG_PM */
+
+static const struct platform_device_id ohci_platform_table[] = {
+	{ "ohci-platform", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ohci_platform_table);
+
+static struct platform_driver ohci_platform_driver = {
+	.id_table	= ohci_platform_table,
+	.probe		= ohci_platform_probe,
+	.remove		= ohci_platform_remove,
+	.shutdown	= ohci_platform_shutdown,
+	.suspend	= ohci_platform_suspend,
+	.resume		= ohci_platform_resume,
+	.driver		= {
+		.name	= "ohci-platform",
+	}
+};
-- 
1.7.5.4
