Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 03:41:08 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:62440 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493069Ab0HCBlC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 03:41:02 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAIRV0yrRN+J/2dsb2JhbACgBnGpKZtoghiDIQSEFg
X-IronPort-AV: E=Sophos;i="4.55,306,1278288000"; 
   d="scan'208";a="166566270"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 03 Aug 2010 01:40:54 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id o731esOK015916;
        Tue, 3 Aug 2010 01:40:54 GMT
Date:   Mon, 2 Aug 2010 18:40:54 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     greg@kroah.com, linux-usb@vger.kernel.org, ralf@linux-mips.org
Subject: [PATCH 1/2][USB] USB/PowerTV: Add support for PowerTV USB interface
Message-ID: <20100803014054.GA31524@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Add support for the Cisco PowerTV USB interface.

This is a very simple set of glue functions, apparently derived some time
ago from the au1xxx driver by Matt Porter.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 drivers/usb/host/ehci-hcd.c     |    5 +
 drivers/usb/host/ehci-powertv.c |  196 ++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c     |    5 +
 drivers/usb/host/ohci-powertv.c |  237 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 443 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index a3ef2a9..1dca632 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1158,6 +1158,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_atmel_driver
 #endif
 
+#ifdef CONFIG_POWERTV
+#include "ehci-powertv.c"
+#define	PLATFORM_DRIVER		ehci_hcd_powertv_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-powertv.c b/drivers/usb/host/ehci-powertv.c
new file mode 100644
index 0000000..92fe201
--- /dev/null
+++ b/drivers/usb/host/ehci-powertv.c
@@ -0,0 +1,196 @@
+/*
+ * EHCI HCD (Host Controller Driver) for USB.
+ *
+ * Bus Glue for PowerTV USB interface
+ *
+ * Based on "ohci-au1xxx.c" by Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Modified for AMD Alchemy Au1200 EHC
+ *  by K.Boge <karsten.boge@amd.com>
+ * Modified for PowerTV USB interface
+ *  by D. VomLehn <dvomlehn@cisco.com>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <asm/mach-powertv/asic.h>
+
+#ifndef CONFIG_POWERTV
+#error "This file is POWERTV bus glue.  CONFIG_POWERTV must be defined."
+#endif
+
+static void powertv_start_ehc(struct usb_hcd *hcd)
+{
+	platform_configure_usb_ehci();
+	udelay(10);			/* Is this necessary? */
+}
+
+static void powertv_stop_ehc(struct usb_hcd *hcd)
+{
+	platform_unconfigure_usb_ehci();
+	udelay(10);			/* Is this necessary? */
+}
+
+static const struct hc_driver ehci_powertv_hc_driver = {
+	.description		= hcd_name,
+	.product_desc =		"POWERTV EHCI",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ehci_irq,
+	.flags =		HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 *
+	 * FIXME -- ehci_init() doesn't do enough here.
+	 * See ehci-ppc-soc for a complete implementation.
+	 */
+	.reset			= ehci_init,
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
+	.bus_suspend =		ehci_bus_suspend,
+	.bus_resume =		ehci_bus_resume,
+	.relinquish_port =	ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+};
+
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+
+/**
+ * usb_hcd_powertv_probe - initialize asic-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ *
+ */
+static int ehci_hcd_powertv_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		pr_debug("resource[1] is not IORESOURCE_IRQ");
+		return -ENOMEM;
+	}
+	hcd = usb_create_hcd(&ehci_powertv_hc_driver, &pdev->dev,
+		"powertv-ehci");
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = pdev->resource[0].start;
+	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+
+#ifdef DO_MEMORY_REGION
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed");
+		ret = -EBUSY;
+		goto err1;
+	}
+
+#endif
+		hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		ret = -ENOMEM;
+#ifdef DO_MEMORY_REGION
+		goto err2;
+#else
+		goto err1;
+#endif
+	}
+
+	powertv_start_ehc(hcd);
+
+	ehci = hcd_to_ehci(hcd);
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+		HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+
+	ret = usb_add_hcd(hcd, pdev->resource[1].start,
+			  IRQF_DISABLED | IRQF_SHARED);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, hcd);
+		return ret;
+	}
+
+	powertv_stop_ehc(hcd);
+	iounmap(hcd->regs);
+#ifdef DO_MEMORY_REGION
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+#endif
+err1:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/**
+ * usb_hcd_powertv_remove - shutdown processing for asic-based HCDs
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_powertv_probe(), first invoking
+ * the HCD's stop() method.  It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+ */
+static int ehci_hcd_powertv_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	powertv_stop_ehc(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ehci_hcd_powertv_driver = {
+	.probe = ehci_hcd_powertv_drv_probe,
+	.remove = ehci_hcd_powertv_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver = {
+		.name = "powertv-ehci",
+		.owner	= THIS_MODULE,
+	}
+};
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index fc57655..86992a0 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1095,6 +1095,11 @@ MODULE_LICENSE ("GPL");
 #define TMIO_OHCI_DRIVER	ohci_hcd_tmio_driver
 #endif
 
+#ifdef CONFIG_POWERTV
+#include "ohci-powertv.c"
+#define PLATFORM_DRIVER		ohci_hcd_powertv_driver
+#endif
+
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
diff --git a/drivers/usb/host/ohci-powertv.c b/drivers/usb/host/ohci-powertv.c
new file mode 100644
index 0000000..1f48ca6
--- /dev/null
+++ b/drivers/usb/host/ohci-powertv.c
@@ -0,0 +1,237 @@
+/*
+ * OHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
+ * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
+ * (C) Copyright 2002 Hewlett-Packard Company
+ *
+ * Bus Glue for PowerTV USB interface
+ *
+ * Written by Christopher Hoover <ch@hpl.hp.com>
+ * Based on fragments of previous driver by Russell King et al.
+ *
+ * Modified for LH7A404 from ohci-sa1111.c
+ *  by Durgesh Pattamatta <pattamattad@sharpsec.com>
+ * Modified for AMD Alchemy Au1xxx
+ *  by Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <asm/mach-powertv/asic.h>
+
+#ifndef CONFIG_POWERTV
+#error "This file is POWERTV bus glue.  CONFIG_POWERTV must be defined."
+#endif
+
+/*
+ * Enable the controller interface
+ */
+static void powertv_start_ohc(struct usb_hcd *hcd)
+{
+	int rc;
+
+	platform_configure_usb_ohci();
+
+	rc = ohci_init(hcd_to_ohci(hcd));
+
+	if (rc == 0) {
+		__hc32 a;
+		struct ohci_hcd *ohci;
+
+		/* ensure the state is one consistent with that expected by the
+		 * OHCI-specific driver */
+		ohci = hcd_to_ohci(hcd);
+		a = ohci_readl(ohci, &ohci->regs->roothub.a);
+		a &= ~(RH_A_NOCP | RH_A_NPS);
+		ohci_writel(ohci, a, &ohci->regs->roothub.a);
+	}
+	udelay(10);			/* Is this necessary? */
+}
+
+/*
+ * Disable the controller interface
+ */
+static void powertv_stop_ohc(struct usb_hcd *hcd)
+{
+	platform_unconfigure_usb_ohci();
+	udelay(10);			/* Is this necessary? */
+}
+
+static int __devinit ohci_powertv_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int ret;
+
+	ohci_dbg(ohci, "ohci_powertv_start, ohci:%p", ohci);
+
+	ret = ohci_init(ohci);
+
+	if (ret < 0)
+		return ret;
+
+	ret = ohci_run(ohci);
+
+	if (ret < 0) {
+		err("can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hc_driver ohci_powertv_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"POWERTV OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ohci_irq,
+	.flags =		HCD_USB11 | HCD_MEMORY,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.start =		ohci_powertv_start,
+	.stop =			ohci_stop,
+	.shutdown =		ohci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ohci_urb_enqueue,
+	.urb_dequeue =		ohci_urb_dequeue,
+	.endpoint_disable =	ohci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ohci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ohci_hub_status_data,
+	.hub_control =		ohci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend =		ohci_bus_suspend,
+	.bus_resume =		ohci_bus_resume,
+#endif
+	.start_port_reset =	ohci_start_port_reset,
+};
+
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+
+/**
+ * usb_hcd_powertv_probe - initialize asic-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ *
+ */
+static int ohci_hcd_powertv_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct usb_hcd *hcd;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		pr_debug("resource[1] is not IORESOURCE_IRQ\n");
+		return -ENOMEM;
+	}
+
+	hcd = usb_create_hcd(&ohci_powertv_hc_driver, &pdev->dev,
+		"powertv-ohci");
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = pdev->resource[0].start;
+	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+
+#ifdef DO_MEMORY_REGION
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed\n");
+		ret = -EBUSY;
+		goto err1;
+	}
+
+#endif
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed\n");
+		ret = -ENOMEM;
+#ifdef DO_MEMORY_REGION
+		goto err2;
+#else
+		goto err1;
+#endif
+	}
+
+	powertv_start_ohc(hcd);
+	ohci_hcd_init(hcd_to_ohci(hcd));
+
+	ret = usb_add_hcd(hcd, pdev->resource[1].start,
+			  IRQF_DISABLED | IRQF_SHARED);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, hcd);
+		return ret;
+	}
+
+	powertv_stop_ohc(hcd);
+	iounmap(hcd->regs);
+#ifdef DO_MEMORY_REGION
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+#endif
+err1:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/**
+ * usb_hcd_powertv_drv_remove - shutdown processing for asic-based HCDs
+ * @pdev: Pointer to platform device for USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_powertv_probe(), first invoking
+ * the HCD's stop() method.  It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+ */
+static int ohci_hcd_powertv_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	powertv_stop_ohc(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ohci_hcd_powertv_driver = {
+	.probe		= ohci_hcd_powertv_drv_probe,
+	.remove		= ohci_hcd_powertv_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name	= "powertv-ohci",
+		.owner	= THIS_MODULE,
+	},
+};
