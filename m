Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2012 21:11:22 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42576 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903724Ab2CKUJc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Mar 2012 21:09:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 7FB618F62;
        Sun, 11 Mar 2012 21:09:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bKQOmEdBOOz2; Sun, 11 Mar 2012 21:09:15 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 5F5F68F66;
        Sun, 11 Mar 2012 21:08:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] USB: OHCI: remove old SSB OHCI driver
Date:   Sun, 11 Mar 2012 21:08:24 +0100
Message-Id: <1331496505-18697-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This is now replaced by the new ssb USB driver, which also supports
devices with an EHCI controller.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/usb/host/Kconfig    |   13 --
 drivers/usb/host/ohci-hcd.c |   21 +----
 drivers/usb/host/ohci-ssb.c |  260 -------------------------------------------
 3 files changed, 1 insertions(+), 293 deletions(-)
 delete mode 100644 drivers/usb/host/ohci-ssb.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index eab27d5..665fb89 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -360,19 +360,6 @@ config USB_OHCI_HCD_PCI
 	  Enables support for PCI-bus plug-in USB controller cards.
 	  If unsure, say Y.
 
-config USB_OHCI_HCD_SSB
-	bool "OHCI support for Broadcom SSB OHCI core"
-	depends on USB_OHCI_HCD && (SSB = y || SSB = USB_OHCI_HCD) && EXPERIMENTAL
-	default n
-	---help---
-	  Support for the Sonics Silicon Backplane (SSB) attached
-	  Broadcom USB OHCI core.
-
-	  This device is present in some embedded devices with
-	  Broadcom based SSB bus.
-
-	  If unsure, say N.
-
 config USB_OHCI_SH
 	bool "OHCI support for SuperH USB controller"
 	depends on USB_OHCI_HCD && SUPERH
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 50fbbf9..a2f4d4e 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1081,11 +1081,6 @@ MODULE_LICENSE ("GPL");
 #define PS3_SYSTEM_BUS_DRIVER	ps3_ohci_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_HCD_SSB
-#include "ohci-ssb.c"
-#define SSB_OHCI_DRIVER		ssb_ohci_driver
-#endif
-
 #ifdef CONFIG_MFD_SM501
 #include "ohci-sm501.c"
 #define SM501_OHCI_DRIVER	ohci_hcd_sm501_driver
@@ -1134,8 +1129,7 @@ MODULE_LICENSE ("GPL");
 	!defined(SA1111_DRIVER) &&	\
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(SM501_OHCI_DRIVER) && \
-	!defined(TMIO_OHCI_DRIVER) && \
-	!defined(SSB_OHCI_DRIVER)
+	!defined(TMIO_OHCI_DRIVER)
 #error "missing bus glue for ohci-hcd"
 #endif
 
@@ -1201,12 +1195,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_pci;
 #endif
 
-#ifdef SSB_OHCI_DRIVER
-	retval = ssb_driver_register(&SSB_OHCI_DRIVER);
-	if (retval)
-		goto error_ssb;
-#endif
-
 #ifdef SM501_OHCI_DRIVER
 	retval = platform_driver_register(&SM501_OHCI_DRIVER);
 	if (retval < 0)
@@ -1230,10 +1218,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&SM501_OHCI_DRIVER);
  error_sm501:
 #endif
-#ifdef SSB_OHCI_DRIVER
-	ssb_driver_unregister(&SSB_OHCI_DRIVER);
- error_ssb:
-#endif
 #ifdef PCI_DRIVER
 	pci_unregister_driver(&PCI_DRIVER);
  error_pci:
@@ -1281,9 +1265,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef SM501_OHCI_DRIVER
 	platform_driver_unregister(&SM501_OHCI_DRIVER);
 #endif
-#ifdef SSB_OHCI_DRIVER
-	ssb_driver_unregister(&SSB_OHCI_DRIVER);
-#endif
 #ifdef PCI_DRIVER
 	pci_unregister_driver(&PCI_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-ssb.c b/drivers/usb/host/ohci-ssb.c
deleted file mode 100644
index 5ba1859..0000000
--- a/drivers/usb/host/ohci-ssb.c
+++ /dev/null
@@ -1,260 +0,0 @@
-/*
- * Sonics Silicon Backplane
- * Broadcom USB-core OHCI driver
- *
- * Copyright 2007 Michael Buesch <m@bues.ch>
- *
- * Derived from the OHCI-PCI driver
- * Copyright 1999 Roman Weissgaerber
- * Copyright 2000-2002 David Brownell
- * Copyright 1999 Linus Torvalds
- * Copyright 1999 Gregory P. Smith
- *
- * Derived from the USBcore related parts of Broadcom-SB
- * Copyright 2005 Broadcom Corporation
- *
- * Licensed under the GNU/GPL. See COPYING for details.
- */
-#include <linux/ssb/ssb.h>
-
-
-#define SSB_OHCI_TMSLOW_HOSTMODE	(1 << 29)
-
-struct ssb_ohci_device {
-	struct ohci_hcd ohci; /* _must_ be at the beginning. */
-
-	u32 enable_flags;
-};
-
-static inline
-struct ssb_ohci_device *hcd_to_ssb_ohci(struct usb_hcd *hcd)
-{
-	return (struct ssb_ohci_device *)(hcd->hcd_priv);
-}
-
-
-static int ssb_ohci_reset(struct usb_hcd *hcd)
-{
-	struct ssb_ohci_device *ohcidev = hcd_to_ssb_ohci(hcd);
-	struct ohci_hcd *ohci = &ohcidev->ohci;
-	int err;
-
-	ohci_hcd_init(ohci);
-	err = ohci_init(ohci);
-
-	return err;
-}
-
-static int ssb_ohci_start(struct usb_hcd *hcd)
-{
-	struct ssb_ohci_device *ohcidev = hcd_to_ssb_ohci(hcd);
-	struct ohci_hcd *ohci = &ohcidev->ohci;
-	int err;
-
-	err = ohci_run(ohci);
-	if (err < 0) {
-		ohci_err(ohci, "can't start\n");
-		ohci_stop(hcd);
-	}
-
-	return err;
-}
-
-static const struct hc_driver ssb_ohci_hc_driver = {
-	.description		= "ssb-usb-ohci",
-	.product_desc		= "SSB OHCI Controller",
-	.hcd_priv_size		= sizeof(struct ssb_ohci_device),
-
-	.irq			= ohci_irq,
-	.flags			= HCD_MEMORY | HCD_USB11,
-
-	.reset			= ssb_ohci_reset,
-	.start			= ssb_ohci_start,
-	.stop			= ohci_stop,
-	.shutdown		= ohci_shutdown,
-
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-
-	.get_frame_number	= ohci_get_frame,
-
-	.hub_status_data	= ohci_hub_status_data,
-	.hub_control		= ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend		= ohci_bus_suspend,
-	.bus_resume		= ohci_bus_resume,
-#endif
-
-	.start_port_reset	= ohci_start_port_reset,
-};
-
-static void ssb_ohci_detach(struct ssb_device *dev)
-{
-	struct usb_hcd *hcd = ssb_get_drvdata(dev);
-
-	if (hcd->driver->shutdown)
-		hcd->driver->shutdown(hcd);
-	usb_remove_hcd(hcd);
-	iounmap(hcd->regs);
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-	usb_put_hcd(hcd);
-	ssb_device_disable(dev, 0);
-}
-
-static int ssb_ohci_attach(struct ssb_device *dev)
-{
-	struct ssb_ohci_device *ohcidev;
-	struct usb_hcd *hcd;
-	int err = -ENOMEM;
-	u32 tmp, flags = 0;
-
-	if (dma_set_mask(dev->dma_dev, DMA_BIT_MASK(32)) ||
-	    dma_set_coherent_mask(dev->dma_dev, DMA_BIT_MASK(32)))
-		return -EOPNOTSUPP;
-
-	if (dev->id.coreid == SSB_DEV_USB11_HOSTDEV) {
-		/* Put the device into host-mode. */
-		flags |= SSB_OHCI_TMSLOW_HOSTMODE;
-		ssb_device_enable(dev, flags);
-	} else if (dev->id.coreid == SSB_DEV_USB20_HOST) {
-		/*
-		 * USB 2.0 special considerations:
-		 *
-		 * In addition to the standard SSB reset sequence, the Host
-		 * Control Register must be programmed to bring the USB core
-		 * and various phy components out of reset.
-		 */
-		ssb_device_enable(dev, 0);
-		ssb_write32(dev, 0x200, 0x7ff);
-
-		/* Change Flush control reg */
-		tmp = ssb_read32(dev, 0x400);
-		tmp &= ~8;
-		ssb_write32(dev, 0x400, tmp);
-		tmp = ssb_read32(dev, 0x400);
-
-		/* Change Shim control reg */
-		tmp = ssb_read32(dev, 0x304);
-		tmp &= ~0x100;
-		ssb_write32(dev, 0x304, tmp);
-		tmp = ssb_read32(dev, 0x304);
-
-		udelay(1);
-
-		/* Work around for 5354 failures */
-		if (dev->id.revision == 2 && dev->bus->chip_id == 0x5354) {
-			/* Change syn01 reg */
-			tmp = 0x00fe00fe;
-			ssb_write32(dev, 0x894, tmp);
-
-			/* Change syn03 reg */
-			tmp = ssb_read32(dev, 0x89c);
-			tmp |= 0x1;
-			ssb_write32(dev, 0x89c, tmp);
-		}
-	} else
-		ssb_device_enable(dev, 0);
-
-	hcd = usb_create_hcd(&ssb_ohci_hc_driver, dev->dev,
-			dev_name(dev->dev));
-	if (!hcd)
-		goto err_dev_disable;
-	ohcidev = hcd_to_ssb_ohci(hcd);
-	ohcidev->enable_flags = flags;
-
-	tmp = ssb_read32(dev, SSB_ADMATCH0);
-	hcd->rsrc_start = ssb_admatch_base(tmp);
-	hcd->rsrc_len = ssb_admatch_size(tmp);
-	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
-	if (!hcd->regs)
-		goto err_put_hcd;
-	err = usb_add_hcd(hcd, dev->irq, IRQF_SHARED);
-	if (err)
-		goto err_iounmap;
-
-	ssb_set_drvdata(dev, hcd);
-
-	return err;
-
-err_iounmap:
-	iounmap(hcd->regs);
-err_put_hcd:
-	usb_put_hcd(hcd);
-err_dev_disable:
-	ssb_device_disable(dev, flags);
-	return err;
-}
-
-static int ssb_ohci_probe(struct ssb_device *dev,
-		const struct ssb_device_id *id)
-{
-	int err;
-	u16 chipid_top;
-
-	/* USBcores are only connected on embedded devices. */
-	chipid_top = (dev->bus->chip_id & 0xFF00);
-	if (chipid_top != 0x4700 && chipid_top != 0x5300)
-		return -ENODEV;
-
-	/* TODO: Probably need checks here; is the core connected? */
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	/* We currently always attach SSB_DEV_USB11_HOSTDEV
-	 * as HOST OHCI. If we want to attach it as Client device,
-	 * we must branch here and call into the (yet to
-	 * be written) Client mode driver. Same for remove(). */
-
-	err = ssb_ohci_attach(dev);
-
-	return err;
-}
-
-static void ssb_ohci_remove(struct ssb_device *dev)
-{
-	ssb_ohci_detach(dev);
-}
-
-#ifdef CONFIG_PM
-
-static int ssb_ohci_suspend(struct ssb_device *dev, pm_message_t state)
-{
-	ssb_device_disable(dev, 0);
-
-	return 0;
-}
-
-static int ssb_ohci_resume(struct ssb_device *dev)
-{
-	struct usb_hcd *hcd = ssb_get_drvdata(dev);
-	struct ssb_ohci_device *ohcidev = hcd_to_ssb_ohci(hcd);
-
-	ssb_device_enable(dev, ohcidev->enable_flags);
-
-	ohci_finish_controller_resume(hcd);
-	return 0;
-}
-
-#else /* !CONFIG_PM */
-#define ssb_ohci_suspend	NULL
-#define ssb_ohci_resume	NULL
-#endif /* CONFIG_PM */
-
-static const struct ssb_device_id ssb_ohci_table[] = {
-	SSB_DEVICE(SSB_VENDOR_BROADCOM, SSB_DEV_USB11_HOSTDEV, SSB_ANY_REV),
-	SSB_DEVICE(SSB_VENDOR_BROADCOM, SSB_DEV_USB11_HOST, SSB_ANY_REV),
-	SSB_DEVICE(SSB_VENDOR_BROADCOM, SSB_DEV_USB20_HOST, SSB_ANY_REV),
-	SSB_DEVTABLE_END
-};
-MODULE_DEVICE_TABLE(ssb, ssb_ohci_table);
-
-static struct ssb_driver ssb_ohci_driver = {
-	.name		= KBUILD_MODNAME,
-	.id_table	= ssb_ohci_table,
-	.probe		= ssb_ohci_probe,
-	.remove		= ssb_ohci_remove,
-	.suspend	= ssb_ohci_suspend,
-	.resume		= ssb_ohci_resume,
-};
-- 
1.7.5.4
