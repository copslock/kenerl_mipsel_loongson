Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2011 16:13:31 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45260 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491124Ab1BVPN1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Feb 2011 16:13:27 +0100
Received: by fxm16 with SMTP id 16so3835907fxm.36
        for <multiple recipients>; Tue, 22 Feb 2011 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Mmd6tf4qe6ZSVZ3LwySu4ezxnY8LM/pBbp+TY5+9yp4=;
        b=EVuTNgwqkjiQKWagiKuU4GEqBTjAQc2tRBnWtZnNiOUzb6RhQL4+XqLfQQayq2ywFi
         Xzjr1i0AiM1v5Bjb7Nfw5tCrvKHeSnsCM70ibIGsYn0/X4tob8k4bG9j9H6TQsHtoSuV
         kXxgKinV3Ysf7txpfodTr/nJKqcicuT+fyS1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QGIIqm3VCQldFx1/2O7ujc/An2ix4TWiOxpjCKKLG4gb6XRMGSrBss0HexsmOz2diq
         GSA0lkrnD5cnUm55vxWlvnUJRW0693xzqxbnqcyjNs02iULWnjw1GAo7eI8Ca7EojP/7
         iKUwqcc4QqV7yIW1y2g9bhn3MLdjgO2jPzmxM=
Received: by 10.223.72.6 with SMTP id k6mr3595015faj.46.1298387553245;
        Tue, 22 Feb 2011 07:12:33 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id r24sm162850fax.3.2011.02.22.07.12.25
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 07:12:32 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     "gregkh @ suse . de" <gregkh@suse.de>,
        "dbrownell @ users . sourceforge . net" 
        <dbrownell@users.sourceforge.net>,
        "stern @ rowland . harvard . edu" <stern@rowland.harvard.edu>,
        "pkondeti @ codeaurora . org" <pkondeti@codeaurora.org>,
        "jacob . jun . pan @ intel . com" <jacob.jun.pan@intel.com>,
        "linux-usb @ vger . kernel . org" <linux-usb@vger.kernel.org>,
        "alek . du @ intel . com" <alek.du@intel.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "gadiyar @ ti . com" <gadiyar@ti.com>,
        "ralf @ linux-mips . org" <ralf@linux-mips.org>,
        "linux-mips @ linux-mips . org" <linux-mips@linux-mips.org>,
        Greg KH <greg@kroah.com>
Cc:     anoop.pa@gmail.com
Subject: [PATCH v5] EHCI bus glue for on-chip PMC MSP USB controller
Date:   Tue, 22 Feb 2011 21:05:33 +0530
Message-Id: <1298388933-13707-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <4D5ABB65.3090101@parrot.com>
References: <4D5ABB65.3090101@parrot.com>
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop <paanoop1@paanoop1-desktop.(none)>

This patch add bus glue for USB controller commonly found in PMC-Sierra MSP71xx family of SoC's.


Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
Changes.
ehci-pmcmsp.c is based on latest ehci-pci.c.Addressed some stylistic issue pointed by Greg.
Addressed comments from Matthieu CASTET.

 drivers/usb/host/Kconfig       |   15 +-
 drivers/usb/host/ehci-hcd.c    |    5 +
 drivers/usb/host/ehci-pmcmsp.c |  524 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 542 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/host/ehci-pmcmsp.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0e6afa2..1b01c99 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -91,17 +91,28 @@ config USB_EHCI_TT_NEWSCHED
 
 	  If unsure, say Y.
 
+config USB_EHCI_HCD_PMC_MSP
+	tristate "EHCI support for on-chip PMC MSP USB controller"
+	depends on USB_EHCI_HCD && MSP_HAS_USB
+	default y
+	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	---help---
+		Enables support for the onchip USB controller on the PMC_MSP7100 Family SoC's.
+		If unsure, say N.
+
 config USB_EHCI_BIG_ENDIAN_MMIO
 	bool
 	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || \
 				    ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
-				    PPC_MPC512x || CPU_CAVIUM_OCTEON)
+				    PPC_MPC512x || CPU_CAVIUM_OCTEON || \
+				    PMC_MSP)
 	default y
 
 config USB_EHCI_BIG_ENDIAN_DESC
 	bool
 	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
-				    PPC_MPC512x)
+				    PPC_MPC512x || PMC_MSP)
 	default y
 
 config XPS_USB_HCD_XILINX
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index cbf451a..196050a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1250,6 +1250,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_msm_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
+#include "ehci-pmcmsp.c"
+#define	PLATFORM_DRIVER		ehci_hcd_msp_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-pmcmsp.c b/drivers/usb/host/ehci-pmcmsp.c
new file mode 100644
index 0000000..b157f19
--- /dev/null
+++ b/drivers/usb/host/ehci-pmcmsp.c
@@ -0,0 +1,524 @@
+/*
+ * PMC MSP EHCI (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 2006-2010 PMC-Sierra Inc
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+/* includes */
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/usb.h>
+#include <msp_usb.h>
+
+/* stream disable*/
+#define USB_CTRL_MODE_STREAM_DISABLE	0x10
+
+/* threshold */
+#define USB_CTRL_FIFO_THRESH		0x00300000
+
+/* register offset for usb_mode */
+#define USB_EHCI_REG_USB_MODE		0x68
+
+/* register offset for usb fifo */
+#define USB_EHCI_REG_USB_FIFO		0x24
+
+/* register offset for usb status */
+#define USB_EHCI_REG_USB_STATUS		0x44
+
+/* serial/parallel transceiver */
+#define USB_EHCI_REG_BIT_STAT_STS	(1<<29)
+
+/* TWI USB0 host device pin */
+#define MSP_PIN_USB0_HOST_DEV		49
+
+/* TWI USB1 host device pin */
+#define MSP_PIN_USB1_HOST_DEV		50
+
+
+static void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci)
+{
+	u8 *base;
+	u8 *statreg;
+	u8 *fiforeg;
+	u32 val;
+	struct ehci_regs *reg_base = ehci->regs;
+
+	/* get register base */
+	base = (u8 *)reg_base + USB_EHCI_REG_USB_MODE;
+	statreg = (u8 *)reg_base + USB_EHCI_REG_USB_STATUS;
+	fiforeg = (u8 *)reg_base + USB_EHCI_REG_USB_FIFO;
+
+	/* Disable controller mode stream */
+	val = ehci_readl(ehci, (u32 *)base);
+	ehci_writel(ehci, (val | USB_CTRL_MODE_STREAM_DISABLE),
+			(u32 *)base);
+
+	/* clear STS to select parallel transceiver interface */
+	val = ehci_readl(ehci, (u32 *)statreg);
+	val = val & ~USB_EHCI_REG_BIT_STAT_STS;
+	ehci_writel(ehci, val, (u32 *)statreg);
+
+	/* write to set the proper fifo threshold */
+	ehci_writel(ehci, USB_CTRL_FIFO_THRESH, (u32 *)fiforeg);
+
+	/* set TWI GPIO USB_HOST_DEV pin high */
+	gpio_direction_output(MSP_PIN_USB0_HOST_DEV, 1);
+#ifdef CONFIG_MSP_HAS_DUAL_USB
+	gpio_direction_output(MSP_PIN_USB1_HOST_DEV, 1);
+#endif
+}
+
+/* called after powerup, by probe or system-pm "wakeup" */
+static int ehci_msp_reinit(struct ehci_hcd *ehci)
+{
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+/* called during probe() after chip reset completes */
+static int ehci_msp_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	u32			temp;
+	int			retval;
+	ehci->big_endian_mmio = 1;
+	ehci->big_endian_desc = 1;
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+	hcd->has_tt = 1;
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	ehci_reset(ehci);
+
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	temp = HCS_N_CC(ehci->hcs_params) * HCS_N_PCC(ehci->hcs_params);
+	temp &= 0x0f;
+	if (temp && HCS_N_PORTS(ehci->hcs_params) > temp) {
+		ehci_dbg(ehci, "bogus port configuration: "
+			"cc=%d x pcc=%d < ports=%d\n",
+			HCS_N_CC(ehci->hcs_params),
+			HCS_N_PCC(ehci->hcs_params),
+			HCS_N_PORTS(ehci->hcs_params));
+	}
+
+	usb_hcd_tdi_set_mode(ehci);
+	retval = ehci_msp_reinit(ehci);
+
+	return retval;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void msp_start_hc(struct platform_device *dev)
+{
+}
+
+static void msp_stop_hc(struct platform_device *dev)
+{
+}
+
+
+/*-------------------------------------------------------------------------*/
+
+/*-------------------------------------------------------------------------*/
+
+#ifdef	CONFIG_PM
+
+/* suspend/resume, section 4.3 */
+
+/* These routines rely on the bus glue
+ * to handle powerdown and wakeup, and currently also on
+ * transceivers that don't need any software attention to set up
+ * the right sort of wakeup.
+ * Also they depend on separate root hub suspend/resume.
+ */
+static int ehci_msp_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	unsigned long flags;
+	int rc;
+
+	return 0;
+	rc = 0;
+
+	if (time_before(jiffies, ehci->next_statechange))
+		usleep(10000);
+
+	/* Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible.  The PM and USB cores make sure that
+	 * the root hub is either suspended or stopped.
+	 */
+	spin_lock_irqsave(&ehci->lock, flags);
+	ehci_prepare_ports_for_controller_suspend(ehci, device_may_wakeup(dev));
+	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
+	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&ehci->lock, flags);
+
+	return rc;
+}
+
+static int ehci_msp_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
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
+	(void) ehci_msp_reinit(ehci);
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
+	hcd->state = HC_STATE_SUSPENDED;
+
+	return 0;
+}
+
+static const struct dev_pm_ops ehci_msp_pmops = {
+	.suspend	= ehci_msp_suspend,
+	.resume		= ehci_msp_resume,
+};
+#endif
+
+
+/* configure so an HC device and id are always provided
+ * always called with process context; sleeping is OK
+ */
+
+static int usb_hcd_msp_map_regs(struct mspusb_device *dev)
+{
+	struct resource *res;
+	struct platform_device *pdev = &dev->dev;
+	u32 res_len;
+	int retval;
+
+	/* MAB register space */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res == NULL)
+		return -ENOMEM;
+	res_len = res->end - res->start + 1;
+	if (!request_mem_region(res->start, res_len, "mab regs"))
+		return -EBUSY;
+
+	dev->mab_regs = ioremap_nocache(res->start, res_len);
+	if (dev->mab_regs == NULL) {
+		retval = -ENOMEM;
+		goto err1;
+	}
+
+	/* MSP USB register space */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (res == NULL) {
+		retval = -ENOMEM;
+		goto err2;
+	}
+	res_len = res->end - res->start + 1;
+	if (!request_mem_region(res->start, res_len, "usbid regs")) {
+		retval = -EBUSY;
+		goto err2;
+	}
+	dev->usbid_regs = ioremap_nocache(res->start, res_len);
+	if (dev->usbid_regs == NULL) {
+		retval = -ENOMEM;
+		goto err3;
+	}
+
+	return 0;
+err3:
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	res_len = res->end - res->start + 1;
+	release_mem_region(res->start, res_len);
+err2:
+	iounmap(dev->mab_regs);
+err1:
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res_len = res->end - res->start + 1;
+	release_mem_region(res->start, res_len);
+	dev_err(&pdev->dev, "Failed to map non-EHCI regs.\n");
+	return retval;
+}
+
+/**
+ * usb_hcd_msp_probe - initialize PMC MSP-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ *
+ */
+int usb_hcd_msp_probe(const struct hc_driver *driver,
+			  struct platform_device *dev)
+{
+	int retval;
+	struct usb_hcd *hcd;
+	struct resource *res;
+	struct ehci_hcd		*ehci ;
+
+	hcd = usb_create_hcd(driver, &dev->dev, "pmcmsp");
+	if (!hcd)
+		return -ENOMEM;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		pr_debug("No IOMEM resource info for %s.\n", dev->name);
+		retval = -ENOMEM;
+		goto err1;
+	}
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = res->end - res->start + 1;
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, dev->name)) {
+		retval = -EBUSY;
+		goto err1;
+	}
+	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		retval = -ENOMEM;
+		goto err2;
+	}
+	msp_start_hc(dev);
+
+	res = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+	if (res == NULL) {
+		dev_err(&dev->dev, "No IRQ resource info for %s.\n", dev->name);
+		retval = -ENOMEM;
+		goto err3;
+	}
+
+	/* Map non-EHCI register spaces */
+	retval = usb_hcd_msp_map_regs(to_mspusb_device(dev));
+	if (retval != 0)
+		goto err3;
+
+	ehci = hcd_to_ehci(hcd);
+	ehci->big_endian_mmio = 1;
+	ehci->big_endian_desc = 1;
+
+
+	retval = usb_add_hcd(hcd, res->start, IRQF_SHARED);
+	if (retval == 0)
+		return 0;
+
+	usb_remove_hcd(hcd);
+err3:
+	msp_stop_hc(dev);
+	iounmap(hcd->regs);
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err1:
+	usb_put_hcd(hcd);
+
+	return retval;
+}
+
+
+
+/**
+ * usb_hcd_msp_remove - shutdown processing for PMC MSP-based HCDs
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_msp_probe(), first invoking
+ * the HCD's stop() method.  It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+ * may be called without controller electrically present
+ * may be called with controller, bus, and devices active
+ */
+void usb_hcd_msp_remove(struct usb_hcd *hcd, struct platform_device *dev)
+{
+	usb_remove_hcd(hcd);
+	msp_stop_hc(dev);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+}
+
+#ifdef CONFIG_MSP_HAS_DUAL_USB
+/*-------------------------------------------------------------------------*/
+/*
+ * Wrapper around the main ehci_irq.  Since both USB host controllers are
+ * sharing the same IRQ, need to first determine whether we're the intended
+ * recipient of this interrupt.
+ */
+static irqreturn_t ehci_msp_irq(struct usb_hcd *hcd)
+{
+	u32 int_src;
+	struct device *dev = hcd->self.controller;
+	struct platform_device *pdev;
+	struct mspusb_device *mdev;
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	/* need to reverse-map a couple of containers to get our device */
+	pdev = to_platform_device(dev);
+	mdev = to_mspusb_device(pdev);
+
+	/* Check to see if this interrupt is for this host controller */
+	int_src = ehci_readl(ehci, &mdev->mab_regs->int_stat);
+	if (int_src & (1 << pdev->id))
+		return ehci_irq(hcd);
+
+	/* Not for this device */
+	return IRQ_NONE;
+}
+/*-------------------------------------------------------------------------*/
+#endif /* DUAL_USB */
+
+static const struct hc_driver ehci_msp_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"PMC MSP EHCI",
+	.hcd_priv_size =	sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+#ifdef CONFIG_MSP_HAS_DUAL_USB
+	.irq =			ehci_msp_irq,
+#else
+	.irq =			ehci_irq,
+#endif
+	.flags =		HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset =		ehci_msp_setup,
+	.start =		ehci_run,
+	.shutdown		= ehci_shutdown,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
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
+static int ehci_hcd_msp_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pr_debug("In ehci_hcd_msp_drv_probe");
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	gpio_request(MSP_PIN_USB0_HOST_DEV, "USB0_HOST_DEV_GPIO");
+#ifdef CONFIG_MSP_HAS_DUAL_USB
+	gpio_request(MSP_PIN_USB1_HOST_DEV, "USB1_HOST_DEV_GPIO");
+#endif
+
+	ret = usb_hcd_msp_probe(&ehci_msp_hc_driver, pdev);
+
+	return ret;
+}
+
+static int ehci_hcd_msp_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_hcd_msp_remove(hcd, pdev);
+
+	/* free TWI GPIO USB_HOST_DEV pin */
+	gpio_free(MSP_PIN_USB0_HOST_DEV);
+#ifdef CONFIG_MSP_HAS_DUAL_USB
+	gpio_free(MSP_PIN_USB1_HOST_DEV);
+#endif
+
+	return 0;
+}
+
+MODULE_ALIAS("pmcmsp-ehci");
+
+static struct platform_driver ehci_hcd_msp_driver = {
+	.probe		= ehci_hcd_msp_drv_probe,
+	.remove		= ehci_hcd_msp_drv_remove,
+	.driver		= {
+		.name	= "pmcmsp-ehci",
+		.owner	= THIS_MODULE,
+#ifdef	CONFIG_PM
+		.pm	= &ehci_msp_pmops,
+#endif
+	},
+};
-- 
1.7.0.4
