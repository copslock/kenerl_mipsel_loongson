Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2012 22:13:38 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43490 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903703Ab2DKUNa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2012 22:13:30 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SI3ur-0000fb-1d; Wed, 11 Apr 2012 15:13:21 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, Chris Dearman <chris@mips.com>
Subject: [PATCH v3 10/10] usb: host: mips: sead3: USB Host controller support for SEAD-3 platform.
Date:   Wed, 11 Apr 2012 15:13:17 -0500
Message-Id: <1334175197-9049-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add EHCI driver for MIPS SEAD-3 development platform.

Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 drivers/usb/host/Kconfig      |    5 +-
 drivers/usb/host/ehci-hcd.c   |    5 +
 drivers/usb/host/ehci-sead3.c |  259 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/host/ehci-sead3.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index f788eb8..dde5a05 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -110,13 +110,14 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || \
 				    ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
 				    PPC_MPC512x || CPU_CAVIUM_OCTEON || \
-				    PMC_MSP || SPARC_LEON)
+				    PMC_MSP || SPARC_LEON || MIPS_SEAD3)
 	default y
 
 config USB_EHCI_BIG_ENDIAN_DESC
 	bool
 	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
-				    PPC_MPC512x || PMC_MSP || SPARC_LEON)
+				    PPC_MPC512x || PMC_MSP || SPARC_LEON || \
+				    MIPS_SEAD3)
 	default y
 
 config XPS_USB_HCD_XILINX
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index aede637..d082d9b 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1371,6 +1371,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_ls1x_driver
 #endif
 
+#ifdef CONFIG_MIPS_SEAD3
+#include "ehci-sead3.c"
+#define	PLATFORM_DRIVER		ehci_hcd_sead3_driver
+#endif
+
 #ifdef CONFIG_USB_EHCI_HCD_PLATFORM
 #include "ehci-platform.c"
 #define PLATFORM_DRIVER		ehci_platform_driver
diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
new file mode 100644
index 0000000..9e35663
--- /dev/null
+++ b/drivers/usb/host/ehci-sead3.c
@@ -0,0 +1,259 @@
+/*
+ * MIPS CI13320A EHCI Host Controller driver
+ * Based on "ehci-au1xxx.c" by K.Boge <karsten.boge@amd.com>
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.
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
+#include <linux/platform_device.h>
+
+const struct hc_driver ehci_sead3_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "SEAD-3 EHCI",
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
+	 *
+	 */
+	.reset			= ehci_setup,
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
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+	struct resource *res;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		pr_debug("resource[1] is not IORESOURCE_IRQ");
+		return -ENOMEM;
+	}
+	hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");
+	if (!hcd)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed");
+		ret = -EBUSY;
+		goto err1;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	ehci = hcd_to_ehci(hcd);
+	ehci->caps = hcd->regs + 0x100;
+	ehci->regs = hcd->regs + 0x100 +
+		HC_LENGTH(ehci, readl(&ehci->caps->hc_capbase));
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+
+	/* Root hub has integrated TT. */
+	hcd->has_tt = 1;
+
+	/* SEAD-3 EHCI matches CPU endianness. */
+#ifdef __BIG_ENDIAN
+	ehci->big_endian_mmio = 1;
+	ehci->big_endian_desc = 1;
+#endif
+
+	/* Set burst length to 16 words */
+	/* FIXME: should be tunable */
+	ehci_writel(ehci, 0x1010, &ehci->regs->reserved[1]);
+
+	ret = usb_add_hcd(hcd, pdev->resource[1].start,
+			  IRQF_SHARED);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, hcd);
+		return ret;
+	}
+
+	iounmap(hcd->regs);
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err1:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ehci_hcd_sead3_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ehci_hcd_sead3_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	unsigned long flags;
+	int rc = 0;
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(10);
+
+	/* Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible.  The PM and USB cores make sure that
+	 * the root hub is either suspended or stopped.
+	 */
+	ehci_prepare_ports_for_controller_suspend(ehci, device_may_wakeup(dev));
+	spin_lock_irqsave(&ehci->lock, flags);
+	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
+	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&ehci->lock, flags);
+
+	// could save FLADJ in case of Vaux power loss
+	// ... we'd only use it to handle clock skew
+
+	return rc;
+}
+
+static int ehci_hcd_sead3_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	// maybe restore FLADJ
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(100);
+
+	/* Mark hardware accessible again as we are out of D3 state by now */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	/* If CF is still set, we maintained PCI Vaux power.
+	 * Just undo the effect of ehci_pci_suspend().
+	 */
+	if (ehci_readl(ehci, &ehci->regs->configured_flag) == FLAG_CF) {
+		int	mask = INTR_MASK;
+
+		ehci_prepare_ports_for_controller_resume(ehci);
+		if (!hcd->self.root_hub->do_remote_wakeup)
+			mask &= ~STS_PCD;
+		ehci_writel(ehci, mask, &ehci->regs->intr_enable);
+		ehci_readl(ehci, &ehci->regs->intr_enable);
+		return 0;
+	}
+
+	ehci_dbg(ehci, "lost power, restarting\n");
+	usb_root_hub_lost_power(hcd->self.root_hub);
+
+	/* Else reset, to cope with power loss or flush-to-storage
+	 * style "resume" having let BIOS kick in during reboot.
+	 */
+	(void) ehci_halt(ehci);
+	(void) ehci_reset(ehci);
+
+	/* emptying the schedule aborts any urbs */
+	spin_lock_irq(&ehci->lock);
+	if (ehci->reclaim)
+		end_unlink_async(ehci);
+	ehci_work(ehci);
+	spin_unlock_irq(&ehci->lock);
+
+	ehci_writel(ehci, ehci->command, &ehci->regs->command);
+	ehci_writel(ehci, FLAG_CF, &ehci->regs->configured_flag);
+	ehci_readl(ehci, &ehci->regs->command);	/* unblock posted writes */
+
+	/* here we "know" root ports should always stay powered */
+	ehci_port_power(ehci, 1);
+
+	ehci->rh_state = EHCI_RH_SUSPENDED;
+
+	return 0;
+}
+
+static const struct dev_pm_ops sead3_ehci_pmops = {
+	.suspend	= ehci_hcd_sead3_drv_suspend,
+	.resume		= ehci_hcd_sead3_drv_resume,
+};
+
+#define SEAD3_EHCI_PMOPS &sead3_ehci_pmops
+
+#else
+#define SEAD3_EHCI_PMOPS NULL
+#endif
+
+static struct platform_driver ehci_hcd_sead3_driver = {
+	.probe		= ehci_hcd_sead3_drv_probe,
+	.remove		= ehci_hcd_sead3_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver = {
+		.name	= "sead3-ehci",
+		.owner	= THIS_MODULE,
+		.pm	= SEAD3_EHCI_PMOPS,
+	}
+};
+
+MODULE_ALIAS("platform:sead3-ehci");
-- 
1.7.9.6
