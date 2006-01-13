Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:37:27 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:26251 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133502AbWAOSgW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:36:22 +0000
Received: from amdext4.amd.com ([IPv6:::ffff:163.181.251.6]:3255 "EHLO
	amdext4.amd.com") by linux-mips.net with ESMTP id <S874051AbWAMSYa>;
	Fri, 13 Jan 2006 19:24:30 +0100
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0DIKgOr008005;
	Fri, 13 Jan 2006 12:21:08 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 13 Jan 2006 12:21:00 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0DIKxh5000164; Fri,
 13 Jan 2006 12:20:59 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 766E82028; Fri, 13 Jan 2006
 11:20:59 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k0DIUcEX028910; Fri, 13 Jan 2006 11:30:38
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k0DIUc72028909; Fri, 13 Jan 2006 11:30:38
 -0700
Date:	Fri, 13 Jan 2006 11:30:38 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org
cc:	thomas.dahlmann@amd.com
Subject: [PATCH] EHCI support for the AU1200
Message-ID: <20060113183038.GK8925@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FD930060T03439990-01-01
Content-Type: multipart/mixed;
 boundary=LyciRD1jyfeSSjG0
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--LyciRD1jyfeSSjG0
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This is the re-send and fixed up version of the patch I sent out a few
weeks ago, to be applied against latest linux-mips GIT.  Unless somebody
finds something horrible,  I think these are ready to go into Greg's tree
and sent on upstream.

Here is the changelog:

* All OTG references are removed and moved to their own patch (which will
  be forthcoming soon).
* Fixed up some coding issues with the move from PCI, including the
  mapping of EHCI capability and operations registers (causing the bugs
  that were posted here).
* Cached the cap register for speed
* Au1200 init and remove routines were in the wrong place
* reboot_notifier was registered twice

Jordan

--LyciRD1jyfeSSjG0
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=usb_host.patch
Content-Transfer-Encoding: 7bit

ALCHEMY:  Add EHCI support for AU1200

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/common/cputable.c                 |    2 
 arch/mips/au1000/common/platform.c                 |    4 
 drivers/usb/Kconfig                                |    8 -
 drivers/usb/host/Kconfig                           |    2 
 drivers/usb/host/ehci-au1xxx.c                     |  299 ++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c                        |    8 -
 drivers/usb/host/ohci-au1xxx.c                     |  105 ++++++-
 include/asm-mips/mach-mips/cpu-feature-overrides.h |    4 
 8 files changed, 405 insertions(+), 27 deletions(-)

diff --git a/arch/mips/au1000/common/cputable.c b/arch/mips/au1000/common/cputable.c
index 4dbde82..d8df5fd 100644
--- a/arch/mips/au1000/common/cputable.c
+++ b/arch/mips/au1000/common/cputable.c
@@ -38,7 +38,7 @@ struct cpu_spec	cpu_specs[] = {
     { 0xffffffff, 0x02030204, "Au1100 BE", 0, 1 },
     { 0xffffffff, 0x03030200, "Au1550 AA", 0, 1 },
     { 0xffffffff, 0x04030200, "Au1200 AB", 0, 0 },
-    { 0xffffffff, 0x04030201, "Au1200 AC", 0, 1 },
+    { 0xffffffff, 0x04030201, "Au1200 AC", 1, 0 },
     { 0x00000000, 0x00000000, "Unknown Au1xxx", 1, 0 },
 };
 
diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 48d3f54..dbb4ee7 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -20,7 +20,7 @@
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
 		.start		= USB_OHCI_BASE,
-		.end		= USB_OHCI_BASE + USB_OHCI_LEN,
+		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -278,9 +278,7 @@ static struct platform_device *au1xxx_pl
 	&au1100_lcd_device,
 #endif
 #ifdef CONFIG_SOC_AU1200
-#if 0	/* fixme */
 	&au1xxx_usb_ehci_device,
-#endif
 	&au1xxx_usb_gdt_device,
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 85dacc9..bff1258 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -9,10 +9,16 @@ menu "USB support"
 # NOTE:  SL-811 option should be board-specific ...
 config USB_ARCH_HAS_HCD
 	boolean
-	default y if USB_ARCH_HAS_OHCI
+	default y if USB_ARCH_HAS_OHCI || USB_ARCH_HAS_EHCI
 	default y if ARM				# SL-811
 	default PCI
 
+# some non-PCI hcds implement EHCI
+config USB_ARCH_HAS_EHCI
+	boolean
+	default y if SOC_AU1200
+	default PCI
+
 # many non-PCI SOC chips embed OHCI
 config USB_ARCH_HAS_OHCI
 	boolean
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ed1899d..4a4db1a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -6,7 +6,7 @@ comment "USB Host Controller Drivers"
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
-	depends on USB && PCI
+	depends on USB && USB_ARCH_HAS_EHCI
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci-au1xxx.c
new file mode 100644
index 0000000..28faeaf
--- /dev/null
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -0,0 +1,299 @@
+/*
+ * EHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 2000-2004 David Brownell <dbrownell@users.sourceforge.net>
+ *
+ * Bus Glue for AMD Alchemy Au1xxx
+ *
+ * Based on "ohci-au1xxx.c" by Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Modified for AMD Alchemy Au1200 EHC
+ *  by K.Boge <karsten.boge@amd.com>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/platform_device.h>
+#include <asm/mach-au1x00/au1000.h>
+
+#ifndef CONFIG_SOC_AU1200
+#error "Alchemy chip doesn't have EHC"
+#else   /* Au1200 */
+
+#define USB_HOST_CONFIG   (USB_MSR_BASE + USB_MSR_MCFG)
+#define USB_MCFG_PFEN     (1<<31)
+#define USB_MCFG_RDCOMB   (1<<30)
+#define USB_MCFG_SSDEN    (1<<23)
+#define USB_MCFG_PHYPLLEN (1<<19)
+#define USB_MCFG_EHCCLKEN (1<<17)
+#define USB_MCFG_UCAM     (1<<7)
+#define USB_MCFG_EBMEN    (1<<3)
+#define USB_MCFG_EMEMEN   (1<<2)
+
+#define USBH_ENABLE_CE    (USB_MCFG_PHYPLLEN | USB_MCFG_EHCCLKEN)
+#ifdef CONFIG_DMA_COHERENT
+#define USBH_ENABLE_INIT  (USBH_ENABLE_CE \
+                         | USB_MCFG_PFEN | USB_MCFG_RDCOMB \
+                         | USB_MCFG_SSDEN | USB_MCFG_UCAM \
+                         | USB_MCFG_EBMEN | USB_MCFG_EMEMEN)
+#else
+#define USBH_ENABLE_INIT  (USBH_ENABLE_CE \
+                         | USB_MCFG_PFEN | USB_MCFG_RDCOMB \
+                         | USB_MCFG_SSDEN \
+                         | USB_MCFG_EBMEN | USB_MCFG_EMEMEN)
+#endif
+#define USBH_DISABLE      (USB_MCFG_EBMEN | USB_MCFG_EMEMEN)
+
+#endif  /* Au1200 */
+
+extern int usb_disabled(void);
+
+/*-------------------------------------------------------------------------*/
+
+static void au1xxx_start_ehc(struct platform_device *dev)
+{
+	pr_debug(__FILE__ ": starting Au1xxx EHCI USB Controller\n");
+
+	/* write HW defaults again in case Yamon cleared them */
+	if (au_readl(USB_HOST_CONFIG) == 0) {
+		au_writel(0x00d02000, USB_HOST_CONFIG);
+		au_readl(USB_HOST_CONFIG);
+		udelay(1000);
+	}
+	/* enable host controller */
+	au_writel(USBH_ENABLE_CE | au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+	udelay(1000);
+	au_writel(USBH_ENABLE_INIT | au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+	udelay(1000);
+
+	pr_debug(__FILE__ ": Clock to USB host has been enabled\n");
+}
+
+static void au1xxx_stop_ehc(struct platform_device *dev)
+{
+	pr_debug(__FILE__ ": stopping Au1xxx EHCI USB Controller\n");
+
+	/* Disable mem */
+	au_writel(~USBH_DISABLE & au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	udelay(1000);
+	/* Disable clock */
+	au_writel(~USB_MCFG_EHCCLKEN & au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+
+/**
+ * usb_ehci_au1xxx_probe - initialize Au1xxx-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ *
+ */
+int usb_ehci_au1xxx_probe (const struct hc_driver *driver,
+			   struct usb_hcd **hcd_out,
+			   struct platform_device *dev)
+{
+	int retval;
+	struct usb_hcd *hcd;
+        struct ehci_hcd *ehci;
+
+#if defined(CONFIG_SOC_AU1200) && defined(CONFIG_DMA_COHERENT)
+
+	/* Au1200 AB USB does not support coherent memory */
+	if (!(read_c0_prid() & 0xff)) {
+	pr_info ("Au1200 ohci: !!! This is chip revision AB                     !!!\n");
+	pr_info ("             !!! update your board or re-configure the kernel !!!\n");
+	return -ENODEV;
+	}
+#endif
+
+	au1xxx_start_ehc(dev);
+
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
+	pr_debug ("resource[1] is not IORESOURCE_IRQ");
+	retval = -ENOMEM;
+	}
+	hcd = usb_create_hcd(driver, &dev->dev, "Au1xxx");
+	if (!hcd)
+		return -ENOMEM;
+	hcd->rsrc_start = dev->resource[0].start;
+	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed");
+		retval = -EBUSY;
+		goto err1;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		retval = -ENOMEM;
+		goto err2;
+	}
+
+        ehci = hcd_to_ehci(hcd);
+        ehci->caps = hcd->regs;
+        ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+
+	/* ehci_hcd_init(hcd_to_ehci(hcd)); */
+
+	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT | SA_SHIRQ);
+	if (retval == 0)
+		return retval;
+
+	au1xxx_stop_ehc(dev);
+	iounmap(hcd->regs);
+ err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+ err1:
+	usb_put_hcd(hcd);
+ return retval;
+}
+
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/**
+ * usb_ehci_hcd_au1xxx_remove - shutdown processing for Au1xxx-based HCDs
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_ehci_hcd_au1xxx_probe(), first invoking
+ * the HCD's stop() method.  It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+ */
+void usb_ehci_au1xxx_remove (struct usb_hcd *hcd, struct platform_device *dev)
+{
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	au1xxx_stop_ehc(dev);
+}
+
+/*-------------------------------------------------------------------------*/
+
+static const struct hc_driver ehci_au1xxx_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"Au1xxx EHCI",
+	.hcd_priv_size =	sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ehci_irq,
+	.flags =		HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset =		ehci_init,
+	.start =		ehci_run,
+#ifdef	CONFIG_PM
+	/* suspend:		ehci_au1xxx_suspend,  -- tbd */
+	/* resume:		ehci_au1xxx_resume,   -- tbd */
+#endif /*CONFIG_PM*/
+	.stop =			ehci_stop,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ehci_urb_enqueue,
+	.urb_dequeue =		ehci_urb_dequeue,
+	.endpoint_disable =	ehci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ehci_hub_status_data,
+	.hub_control =		ehci_hub_control,
+#ifdef	CONFIG_USB_SUSPEND
+	.hub_suspend =		ehci_hub_suspend,
+	.hub_resume =		ehci_hub_resume,
+#endif
+};
+
+/*-------------------------------------------------------------------------*/
+
+static int ehci_hcd_au1xxx_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_hcd *hcd = NULL;
+	int ret;
+
+	pr_debug ("In ehci_hcd_au1xxx_drv_probe\n");
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	ret = usb_ehci_au1xxx_probe(&ehci_au1xxx_hc_driver, &hcd, pdev);
+	return ret;
+}
+
+static int ehci_hcd_au1xxx_drv_remove(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	usb_ehci_au1xxx_remove(hcd, pdev);
+	return 0;
+}
+	/*TBD*/
+/*static int ehci_hcd_au1xxx_drv_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	return 0;
+}
+static int ehci_hcd_au1xxx_drv_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	return 0;
+}
+*/
+
+static struct device_driver ehci_hcd_au1xxx_driver = {
+	.name		= "au1xxx-ehci",
+	.bus		= &platform_bus_type,
+	.probe		= ehci_hcd_au1xxx_drv_probe,
+	.remove		= ehci_hcd_au1xxx_drv_remove,
+	/*.suspend	= ehci_hcd_au1xxx_drv_suspend, */
+	/*.resume	= ehci_hcd_au1xxx_drv_resume, */
+};
+
+static int __init ehci_hcd_au1xxx_init (void)
+{
+	pr_debug (DRIVER_INFO " (Au1xxx)\n");
+
+	return driver_register(&ehci_hcd_au1xxx_driver);
+}
+
+static void __exit ehci_hcd_au1xxx_cleanup (void)
+{
+	driver_unregister(&ehci_hcd_au1xxx_driver);
+}
+
+module_init (ehci_hcd_au1xxx_init);
+module_exit (ehci_hcd_au1xxx_cleanup);
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 29f52a4..30833fe 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -894,10 +894,10 @@ MODULE_DESCRIPTION (DRIVER_INFO);
 MODULE_AUTHOR (DRIVER_AUTHOR);
 MODULE_LICENSE ("GPL");
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_SOC_AU1X00)
+#include "ehci-au1xxx.c"
+#elif defined(CONFIG_PCI)
 #include "ehci-pci.c"
-#endif
-
-#if !defined(CONFIG_PCI)
+#else
 #error "missing bus glue for ehci-hcd"
 #endif
diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 486202d..56c488e 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -19,9 +19,10 @@
  */
 
 #include <linux/platform_device.h>
-
 #include <asm/mach-au1x00/au1000.h>
 
+#ifndef CONFIG_SOC_AU1200
+
 #define USBH_ENABLE_BE (1<<0)
 #define USBH_ENABLE_C  (1<<1)
 #define USBH_ENABLE_E  (1<<2)
@@ -36,16 +37,46 @@
 #error not byte order defined
 #endif
 
+#else   /* Au1200 */
+
+#define USB_HOST_CONFIG    (USB_MSR_BASE + USB_MSR_MCFG)
+#define USB_MCFG_PFEN     (1<<31)
+#define USB_MCFG_RDCOMB   (1<<30)
+#define USB_MCFG_SSDEN    (1<<23)
+#define USB_MCFG_OHCCLKEN (1<<16)
+#define USB_MCFG_UCAM     (1<<7)
+#define USB_MCFG_OBMEN    (1<<1)
+#define USB_MCFG_OMEMEN   (1<<0)
+
+#define USBH_ENABLE_CE    USB_MCFG_OHCCLKEN
+#ifdef CONFIG_DMA_COHERENT
+#define USBH_ENABLE_INIT  (USB_MCFG_OHCCLKEN \
+                         | USB_MCFG_PFEN | USB_MCFG_RDCOMB \
+                         | USB_MCFG_SSDEN | USB_MCFG_UCAM \
+                         | USB_MCFG_OBMEN | USB_MCFG_OMEMEN)
+#else
+#define USBH_ENABLE_INIT  (USB_MCFG_OHCCLKEN \
+                         | USB_MCFG_PFEN | USB_MCFG_RDCOMB \
+                         | USB_MCFG_SSDEN \
+                         | USB_MCFG_OBMEN | USB_MCFG_OMEMEN)
+#endif
+#define USBH_DISABLE      (USB_MCFG_OBMEN | USB_MCFG_OMEMEN)
+
+#endif  /* Au1200 */
+
 extern int usb_disabled(void);
 
 /*-------------------------------------------------------------------------*/
 
-static void au1xxx_start_hc(struct platform_device *dev)
+static void au1xxx_start_ohc(struct platform_device *dev)
 {
 	printk(KERN_DEBUG __FILE__
 		": starting Au1xxx OHCI USB Controller\n");
 
 	/* enable host controller */
+	
+#ifndef CONFIG_SOC_AU1200
+
 	au_writel(USBH_ENABLE_CE, USB_HOST_CONFIG);
 	udelay(1000);
 	au_writel(USBH_ENABLE_INIT, USB_HOST_CONFIG);
@@ -56,17 +87,46 @@ static void au1xxx_start_hc(struct platf
 		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
 		udelay(1000);
 
+#else   /* Au1200 */
+
+	/* write HW defaults again in case Yamon cleared them */
+	if (au_readl(USB_HOST_CONFIG) == 0) {
+	au_writel(0x00d02000, USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+	udelay(1000);
+	}
+	au_writel(USBH_ENABLE_CE | au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+	udelay(1000);
+	au_writel(USBH_ENABLE_INIT | au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+	udelay(1000);
+
+#endif  /* Au1200 */
+
 	printk(KERN_DEBUG __FILE__
 	": Clock to USB host has been enabled \n");
 }
 
-static void au1xxx_stop_hc(struct platform_device *dev)
+static void au1xxx_stop_ohc(struct platform_device *dev)
 {
 	printk(KERN_DEBUG __FILE__
 	       ": stopping Au1xxx OHCI USB Controller\n");
 
+#ifndef CONFIG_SOC_AU1200
+
 	/* Disable clock */
 	au_writel(readl((void *)USB_HOST_CONFIG) & ~USBH_ENABLE_CE, USB_HOST_CONFIG);
+
+#else   /* Au1200 */
+
+	/* Disable mem */
+	au_writel(~USBH_DISABLE & au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	udelay(1000);
+	/* Disable clock */
+	au_writel(~USBH_ENABLE_CE & au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+	au_readl(USB_HOST_CONFIG);
+#endif  /* Au1200 */
 }
 
 
@@ -85,14 +145,24 @@ static void au1xxx_stop_hc(struct platfo
  * through the hotplug entry's driver_data.
  *
  */
-int usb_hcd_au1xxx_probe (const struct hc_driver *driver,
+int usb_ohci_au1xxx_probe (const struct hc_driver *driver,
 			  struct platform_device *dev)
 {
 	int retval;
 	struct usb_hcd *hcd;
 
+#if defined(CONFIG_SOC_AU1200) && defined(CONFIG_DMA_COHERENT)
+
+	/* Au1200 AB USB does not support coherent memory */
+	if (!(read_c0_prid() & 0xff)) {
+	pr_info ("Au1200 ohci: !!! This is chip revision AB                     !!!\n");
+	pr_info ("             !!! update your board or re-configure the kernel !!!\n");
+	return -ENODEV;
+	}
+#endif
+
 	if (dev->resource[1].flags != IORESOURCE_IRQ) {
-		pr_debug ("resource[1] is not IORESOURCE_IRQ");
+		pr_debug ("resource[1] is not IORESOURCE_IRQ\n");
 		retval = -ENOMEM;
 	}
 
@@ -103,26 +173,26 @@ int usb_hcd_au1xxx_probe (const struct h
 	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
 
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
-		pr_debug("request_mem_region failed");
+		pr_debug("request_mem_region failed\n");
 		retval = -EBUSY;
 		goto err1;
 	}
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
-		pr_debug("ioremap failed");
+		pr_debug("ioremap failed\n");
 		retval = -ENOMEM;
 		goto err2;
 	}
 
-	au1xxx_start_hc(dev);
+	au1xxx_start_ohc(dev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
+	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT | SA_SHIRQ);
 	if (retval == 0)
 		return retval;
 
-	au1xxx_stop_hc(dev);
+	au1xxx_stop_ohc(dev);
 	iounmap(hcd->regs);
  err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
@@ -145,10 +215,10 @@ int usb_hcd_au1xxx_probe (const struct h
  * context, normally "rmmod", "apmd", or something similar.
  *
  */
-void usb_hcd_au1xxx_remove (struct usb_hcd *hcd, struct platform_device *dev)
+void usb_ohci_au1xxx_remove (struct usb_hcd *hcd, struct platform_device *dev)
 {
 	usb_remove_hcd(hcd);
-	au1xxx_stop_hc(dev);
+	au1xxx_stop_ohc(dev);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
@@ -216,9 +286,9 @@ static const struct hc_driver ohci_au1xx
 	 */
 	.hub_status_data =	ohci_hub_status_data,
 	.hub_control =		ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
+#ifdef	CONFIG_USB_SUSPEND
+	.hub_suspend =		ohci_hub_suspend,
+	.hub_resume =		ohci_hub_resume,
 #endif
 	.start_port_reset =	ohci_start_port_reset,
 };
@@ -234,7 +304,7 @@ static int ohci_hcd_au1xxx_drv_probe(str
 	if (usb_disabled())
 		return -ENODEV;
 
-	ret = usb_hcd_au1xxx_probe(&ohci_au1xxx_hc_driver, pdev);
+	ret = usb_ohci_au1xxx_probe(&ohci_au1xxx_hc_driver, pdev);
 	return ret;
 }
 
@@ -242,7 +312,7 @@ static int ohci_hcd_au1xxx_drv_remove(st
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
-	usb_hcd_au1xxx_remove(hcd, pdev);
+	usb_ohci_au1xxx_remove(hcd, pdev);
 	return 0;
 }
 	/*TBD*/
@@ -287,3 +357,4 @@ static void __exit ohci_hcd_au1xxx_clean
 
 module_init (ohci_hcd_au1xxx_init);
 module_exit (ohci_hcd_au1xxx_cleanup);
+
diff --git a/include/asm-mips/mach-mips/cpu-feature-overrides.h b/include/asm-mips/mach-mips/cpu-feature-overrides.h
index 9f92aed..e06af6c 100644
--- a/include/asm-mips/mach-mips/cpu-feature-overrides.h
+++ b/include/asm-mips/mach-mips/cpu-feature-overrides.h
@@ -29,7 +29,11 @@
 /* #define cpu_has_prefetch	? */
 #define cpu_has_mcheck		1
 /* #define cpu_has_ejtag	? */
+#ifdef CONFIG_CPU_HAS_LLSC
 #define cpu_has_llsc		1
+#else
+#define cpu_has_llsc		0
+#endif
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */

--LyciRD1jyfeSSjG0--
