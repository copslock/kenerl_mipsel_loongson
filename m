Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2012 01:05:58 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47482 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903614Ab2CMAFZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2012 01:05:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 22F2E8F60;
        Tue, 13 Mar 2012 01:05:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MBpclNva9B2o; Tue, 13 Mar 2012 01:05:10 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id B11488F61;
        Tue, 13 Mar 2012 01:05:09 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 1/7] USB: OHCI: Add a generic platform device driver
Date:   Tue, 13 Mar 2012 01:04:47 +0100
Message-Id: <1331597093-425-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32661
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

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/usb/host/Kconfig         |   10 ++
 drivers/usb/host/ohci-hcd.c      |    5 +
 drivers/usb/host/ohci-platform.c |  194 ++++++++++++++++++++++++++++++++++++++
 include/linux/usb/ohci_pdriver.h |   38 ++++++++
 4 files changed, 247 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ohci-platform.c
 create mode 100644 include/linux/usb/ohci_pdriver.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 353cdd4..fd521f3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -393,6 +393,16 @@ config USB_CNS3XXX_OHCI
 	  Enable support for the CNS3XXX SOC's on-chip OHCI controller.
 	  It is needed for low-speed USB 1.0 device support.
 
+config USB_OHCI_HCD_PLATFORM
+	bool "Generic OHCI driver for a platform device"
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
index 0000000..ec5c679
--- /dev/null
+++ b/drivers/usb/host/ohci-platform.c
@@ -0,0 +1,194 @@
+/*
+ * Generic platform ohci driver
+ *
+ * Copyright 2007 Michael Buesch <m@bues.ch>
+ * Copyright 2011-2012 Hauke Mehrtens <hauke@hauke-m.de>
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
+#include <linux/usb/ohci_pdriver.h>
+
+static int ohci_platform_reset(struct usb_hcd *hcd)
+{
+	struct platform_device *pdev = to_platform_device(hcd->self.controller);
+	struct usb_ohci_pdata *pdata = pdev->dev.platform_data;
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int err;
+
+	if (pdata->big_endian_desc)
+		ohci->flags |= OHCI_QUIRK_BE_DESC;
+	if (pdata->big_endian_mmio)
+		ohci->flags |= OHCI_QUIRK_BE_MMIO;
+	if (pdata->no_big_frame_no)
+		ohci->flags |= OHCI_QUIRK_FRAME_NO;
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
+	.description		= hcd_name,
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
+static int __devinit ohci_platform_probe(struct platform_device *dev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res_mem;
+	int irq;
+	int err = -ENOMEM;
+
+	BUG_ON(!dev->dev.platform_data);
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		pr_err("no irq provieded");
+		return irq;
+	}
+
+	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res_mem) {
+		pr_err("no memory recourse provieded");
+		return -ENXIO;
+	}
+
+	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
+			dev_name(&dev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_err("controller already in use");
+		err = -EBUSY;
+		goto err_put_hcd;
+	}
+
+	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs)
+		goto err_release_region;
+	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (err)
+		goto err_iounmap;
+
+	platform_set_drvdata(dev, hcd);
+
+	return err;
+
+err_iounmap:
+	iounmap(hcd->regs);
+err_release_region:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_put_hcd:
+	usb_put_hcd(hcd);
+	return err;
+}
+
+static int __devexit ohci_platform_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int ohci_platform_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int ohci_platform_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
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
+static const struct dev_pm_ops ohci_platform_pm_ops = {
+	.suspend	= ohci_platform_suspend,
+	.resume		= ohci_platform_resume,
+};
+
+static struct platform_driver ohci_platform_driver = {
+	.id_table	= ohci_platform_table,
+	.probe		= ohci_platform_probe,
+	.remove		= __devexit_p(ohci_platform_remove),
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ohci-platform",
+		.pm	= &ohci_platform_pm_ops,
+	}
+};
diff --git a/include/linux/usb/ohci_pdriver.h b/include/linux/usb/ohci_pdriver.h
new file mode 100644
index 0000000..2808f2a
--- /dev/null
+++ b/include/linux/usb/ohci_pdriver.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2012 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __USB_CORE_OHCI_PDRIVER_H
+#define __USB_CORE_OHCI_PDRIVER_H
+
+/**
+ * struct usb_ohci_pdata - platform_data for generic ohci driver
+ *
+ * @big_endian_desc:	BE descriptors
+ * @big_endian_mmio:	BE registers
+ * @no_big_frame_no:	no big endian frame_no shift
+ *
+ * These are general configuration options for the OHCI controller. All of
+ * these options are activating more or less workarounds for some hardware.
+ */
+struct usb_ohci_pdata {
+	unsigned	big_endian_desc:1;
+	unsigned	big_endian_mmio:1;
+	unsigned	no_big_frame_no:1;
+};
+
+#endif /* __USB_CORE_OHCI_PDRIVER_H */
-- 
1.7.5.4
