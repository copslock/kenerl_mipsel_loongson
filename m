Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2005 21:01:16 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:32706 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S3458391AbVLHVAu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2005 21:00:50 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB8L0MSP029272;
	Thu, 8 Dec 2005 13:00:37 -0800
Received: from 139.95.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Thu, 08 Dec 2005 13:00:26 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB8L0PGF011039; Thu, 8
 Dec 2005 13:00:25 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 549FE201E; Thu, 8 Dec 2005
 14:00:25 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB8L0gov018376; Thu, 8 Dec 2005 14:00:42
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB8L0gLV018375; Thu, 8 Dec 2005 14:00:42 -0700
Date:	Thu, 8 Dec 2005 14:00:42 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	linux-usb-devel@lists.sourceforge.net, matthias.lenk@amd.com
Subject: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
Message-ID: <20051208210042.GB17458@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8641601FS785599-01-01
Content-Type: multipart/mixed;
 boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--ikeVEW9yuYc//A+q
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Ok, here we go.  I give you the OHCI/EHCI host controller support for
the Alchemy AU1200 processor.  I'm sending this up, partly because I have
it ready to go, but also because it seems that enough folks are getting their
hands on AU1200 parts to make this a hot topic.  

Special thanks to Pete Popov and his merry band of kernel hackers for 
paving the way by pushing to seperate EHCI and PCI in the USB subsystem.    
Note that the AU1200 does support UDC/OTG as well, but thats another patch 
for another day. :)

Jordan

--ikeVEW9yuYc//A+q
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=usb_host.patch
Content-Transfer-Encoding: 7bit

ALCHEMY:  Add Au1200 support for OHCI and EHCI

Add the Au1200 platform to the alchemy OHCI and EHCI drivers.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/common/cputable.c                 |    2 
 arch/mips/au1000/common/platform.c                 |    4 
 drivers/usb/Kconfig                                |    8 -
 drivers/usb/Makefile                               |    7 
 drivers/usb/core/Kconfig                           |    5 
 drivers/usb/core/hcd.c                             |   13 +
 drivers/usb/core/hcd.h                             |    4 
 drivers/usb/core/hub.c                             |   76 ++++-
 drivers/usb/core/usb.c                             |   63 ++++
 drivers/usb/host/Kconfig                           |    2 
 drivers/usb/host/ehci-au1xxx.c                     |  304 ++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c                        |   81 +++++
 drivers/usb/host/ehci-hub.c                        |   74 +++++
 drivers/usb/host/ehci.h                            |    8 +
 drivers/usb/host/ohci-au1xxx.c                     |  109 ++++++-
 drivers/usb/host/ohci-hcd.c                        |   73 +++++
 drivers/usb/host/ohci-hub.c                        |   56 ++++
 drivers/usb/host/ohci-pci.c                        |    4 
 drivers/usb/host/ohci.h                            |    1 
 include/asm-mips/mach-mips/cpu-feature-overrides.h |    4 
 include/linux/usb.h                                |    7 
 21 files changed, 861 insertions(+), 44 deletions(-)

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
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index a50c2bc..f9642e8 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -76,3 +76,10 @@ obj-$(CONFIG_USB_SISUSBVGA)	+= misc/
 
 obj-$(CONFIG_USB_ATM)		+= atm/
 obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/
+
+
+ifneq ($(CONFIG_USB_GADGET_AMD5536UDC),y)
+ifeq ($(CONFIG_USB_PORT_AMD5536OTG),y)
+obj-$(CONFIG_USB)		+= gadget/
+endif
+endif
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index ff03184..7293161 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -82,6 +82,11 @@ config USB_OTG
 	select USB_SUSPEND
 	default n
 
+config USB_OTG_HIGHSPEED
+	bool
+	depends on USB_OTG
+	default n
+
 
 config USB_OTG_WHITELIST
 	bool "Rely on OTG Targeted Peripherals List"
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index da24c31..031147c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -714,6 +714,7 @@ static void usb_bus_init (struct usb_bus
 	bus->root_hub = NULL;
 	bus->hcpriv = NULL;
 	bus->busnum = -1;
+	bus->otg_port = 0;
 	bus->bandwidth_allocated = 0;
 	bus->bandwidth_int_reqs  = 0;
 	bus->bandwidth_isoc_reqs = 0;
@@ -1830,6 +1831,12 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	rhdev->speed = (hcd->driver->flags & HCD_USB2) ? USB_SPEED_HIGH :
 			USB_SPEED_FULL;
 
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG)
+	if ((retval = hcd->driver->start_otg (hcd)) < 0) {
+		dev_warn (hcd->self.controller, "OTG init error %d\n", retval);
+		goto err_hcd_driver_start;
+	}
+#endif	
 	/* Although in principle hcd->driver->start() might need to use rhdev,
 	 * none of the current drivers do.
 	 */
@@ -1855,6 +1862,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
  err_register_root_hub:
 	hcd->driver->stop(hcd);
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG)
+	hcd->driver->stop_otg (hcd);
+#endif	
 
  err_hcd_driver_start:
 	usb_put_dev(rhdev);
@@ -1897,6 +1907,9 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	del_timer_sync(&hcd->rh_timer);
 
 	hcd->driver->stop(hcd);
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG)
+	hcd->driver->stop_otg(hcd);
+#endif
 	hcd->state = HC_STATE_HALT;
 
 	if (hcd->irq >= 0)
diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index c8a1b35..48c6dd6 100644
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -216,6 +216,10 @@ struct hc_driver {
 	int		(*bus_suspend)(struct usb_hcd *);
 	int		(*bus_resume)(struct usb_hcd *);
 	int		(*start_port_reset)(struct usb_hcd *, unsigned port_num);
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG)
+	int		(*start_otg)(struct usb_hcd *);
+	void		(*stop_otg)(struct usb_hcd *);
+#endif	
 	void		(*hub_irq_enable)(struct usb_hcd *);
 		/* Needed only if port-change IRQs are level-triggered */
 };
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f78bd12..629124e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1228,6 +1228,10 @@ int usb_new_device(struct usb_device *ud
 {
 	int err;
 	int c;
+#ifdef CONFIG_USB_OTG_WHITELIST_RELAXED
+	unsigned port1 = 0;
+	struct usb_device *root = udev->bus->root_hub;
+#endif	
 
 	err = usb_get_configuration(udev);
 	if (err < 0) {
@@ -1253,14 +1257,29 @@ int usb_new_device(struct usb_device *ud
 	show_string(udev, "SerialNumber", udev->serial);
 
 #ifdef	CONFIG_USB_OTG
+
+#ifdef CONFIG_USB_OTG_WHITELIST_RELAXED
+		
+	if (udev->parent) {
+
+	struct usb_device *tdev = udev;
+
+	while (tdev->parent != root)
+		tdev = tdev->parent;
+	for (port1 = 1; port1 <= root->maxchild; port1++) {
+		if (root->children[port1-1] == tdev)
+			break;
+	}
+	}
+	root = udev->parent;
+#endif
 	/*
 	 * OTG-aware devices on OTG-capable root hubs may be able to use SRP,
 	 * to wake us after we've powered off VBUS; and HNP, switching roles
 	 * "host" to "peripheral".  The OTG descriptor helps figure this out.
 	 */
 	if (!udev->bus->is_b_host
-			&& udev->config
-			&& udev->parent == udev->bus->root_hub) {
+			&& udev->config) {
 		struct usb_otg_descriptor	*desc = 0;
 		struct usb_bus			*bus = udev->bus;
 
@@ -1269,6 +1288,7 @@ int usb_new_device(struct usb_device *ud
 					le16_to_cpu(udev->config[0].desc.wTotalLength),
 					USB_DT_OTG, (void **) &desc) == 0) {
 			if (desc->bmAttributes & USB_OTG_HNP) {
+#ifndef CONFIG_USB_OTG_WHITELIST_RELAXED
 				unsigned		port1;
 				struct usb_device	*root = udev->parent;
 				
@@ -1277,15 +1297,23 @@ int usb_new_device(struct usb_device *ud
 					if (root->children[port1-1] == udev)
 						break;
 				}
-
-				dev_info(&udev->dev,
-					"Dual-Role OTG device on %sHNP port\n",
-					(port1 == bus->otg_port)
-						? "" : "non-");
-
-				/* enable HNP before suspend, it's simpler */
-				if (port1 == bus->otg_port)
+#endif
+				if (udev->parent != bus->root_hub) {
+					dev_info(&udev->dev,
+		  				"Dual-Role OTG device connected through hub(s)\n");
+					bus->b_hnp_enable = 0;
+				}
+				else if (port1 == bus->otg_port) {
+					dev_info(&udev->dev,
+							"Dual-Role OTG device on HNP port\n");
 					bus->b_hnp_enable = 1;
+				}
+				else {
+					dev_info(&udev->dev,
+							"Dual-Role OTG device on non-HNP port\n");
+					bus->b_hnp_enable = 0;
+				}	
+				/* enable HNP before suspend, it's simpler */
 				err = usb_control_msg(udev,
 					usb_sndctrlpipe(udev, 0),
 					USB_REQ_SET_FEATURE, 0,
@@ -1298,16 +1326,22 @@ int usb_new_device(struct usb_device *ud
 					 * customize to match your product.
 					 */
 					dev_info(&udev->dev,
-						"can't set HNP mode; %d\n",
+							"Device Not Responding (trying to set HNP mode: %d)\n",
 						err);
 					bus->b_hnp_enable = 0;
+					goto fail;
 				}
 			}
 		}
 	}
 
-	if (!is_targeted(udev)) {
-
+#ifdef CONFIG_USB_OTG_WHITELIST_RELAXED
+	if (port1 && (port1 == udev->bus->otg_port) \
+		&& !is_targeted(udev))
+#else
+	if (!is_targeted(udev))
+#endif
+	{
 		/* Maybe it can talk to us, though we can't talk to it.
 		 * (Includes HNP test device.)
 		 */
@@ -1315,10 +1349,12 @@ int usb_new_device(struct usb_device *ud
 			static int __usb_suspend_device(struct usb_device *,
 						int port1);
 			err = __usb_suspend_device(udev, udev->bus->otg_port);
-			if (err < 0)
+			if (err < 0) {
 				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
+				goto fail;
+			}
 		}
-		err = -ENODEV;
+		err = -ENOTCONN;
 		goto fail;
 	}
 #endif
@@ -2565,6 +2601,16 @@ static void hub_port_connect_change(stru
 		}
 
 		up (&udev->serialize);
+
+#ifdef CONFIG_USB_OTG
+
+		/* don't want to disturb HNP: no retry */
+		if ((udev->bus->is_b_host || udev->bus->b_hnp_enable)
+		    && (status == -ENOTCONN))
+			/* FIXME: rather keep the port enabled until */
+			/*        disconnect, but it works this way  */
+			goto loop;
+#endif
 		if (status)
 			goto loop_disable;
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index e197ce9..13113b3 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -81,6 +81,11 @@ static struct device_driver usb_generic_
 
 static int usb_generic_driver_data;
 
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG) 
+
+struct otg_transceiver * (*usb_otg_get_transceiver)(void) = NULL;
+#endif
+
 /* called from driver core with usb_bus_type.subsys writelock */
 static int usb_probe_interface(struct device *dev)
 {
@@ -1485,6 +1490,58 @@ static int usb_generic_resume(struct dev
 	return 0;
 }
 
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG) 
+/*
+ * To be called from OTG controller driver
+ */
+int usb_host_register_otg(struct otg_transceiver * (*get_transceiver)(void))
+{
+	struct list_head  *tmp;
+	struct usb_bus    *bus;
+	struct usb_hcd    *hcd;
+
+	if (get_transceiver) {
+		usb_otg_get_transceiver = get_transceiver;
+		down (&usb_bus_list_lock);
+		tmp = usb_bus_list.next;
+		while (tmp != &usb_bus_list) {
+			bus = list_entry(tmp, struct usb_bus, bus_list);
+			tmp = tmp->next;
+			hcd = container_of (bus, struct usb_hcd, self);
+			hcd->driver->start_otg (hcd);
+		}
+		up (&usb_bus_list_lock);
+		pr_info("USB OTG driver registered\n");
+		return 0;
+	}
+	else {
+		printk(KERN_ERR "can't register OTG, no device\n");
+		return -ENODEV;
+	}
+}
+
+void usb_host_deregister_otg(void)
+{
+	struct list_head  *tmp;
+	struct usb_bus    *bus;
+	struct usb_hcd    *hcd;
+
+	down (&usb_bus_list_lock);
+	tmp = usb_bus_list.next;
+	while (tmp != &usb_bus_list) {
+		bus = list_entry(tmp, struct usb_bus, bus_list);
+		tmp = tmp->next;
+		if (bus->otg_port) {
+			hcd = container_of (bus, struct usb_hcd, self);
+			hcd->driver->stop_otg (hcd);
+		}
+	}
+	up (&usb_bus_list_lock);
+	usb_otg_get_transceiver = NULL;
+	pr_info("USB OTG driver deregistered\n");
+}
+#endif
+
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
@@ -1642,4 +1699,10 @@ EXPORT_SYMBOL (usb_buffer_dmasync_sg);
 #endif
 EXPORT_SYMBOL (usb_buffer_unmap_sg);
 
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG) 
+EXPORT_SYMBOL(usb_host_register_otg);
+EXPORT_SYMBOL(usb_host_deregister_otg);
+EXPORT_SYMBOL(usb_otg_get_transceiver);
+#endif
+
 MODULE_LICENSE("GPL");
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
index 0000000..32cf6e6
--- /dev/null
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -0,0 +1,304 @@
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
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
+	pr_debug ("resource[1] is not IORESOURCE_IRQ");
+	retval = -ENOMEM;
+	}
+
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
+	au1xxx_start_ehc(dev);
+	
+	if ((retval = driver->reset (hcd)) < 0) {
+		pr_debug ("can't reset hc\n");
+		goto err3;
+	}
+	
+	/* ehci_hcd_init(hcd_to_ehci(hcd)); */
+
+	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT | SA_SHIRQ);
+	if (retval == 0)
+		return retval;
+
+ err3:
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
+	au1xxx_stop_ehc(dev);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
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
+	.start_port_reset =	ehci_start_port_reset,
+#ifdef	CONFIG_USB_OTG_HIGHSPEED
+	.start_otg =		ehci_start_otg,
+	.stop_otg =		ehci_stop_otg,
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
index 29f52a4..2b431ef 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -40,6 +40,7 @@
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/usb.h>
+#include <linux/usb_otg.h>
 #include <linux/moduleparam.h>
 #include <linux/dma-mapping.h>
 
@@ -124,6 +125,11 @@ static const char	hcd_name [] = "ehci_hc
 #define EHCI_ASYNC_JIFFIES	(HZ/20)		/* async idle timeout */
 #define EHCI_SHRINK_JIFFIES	(HZ/200)	/* async qh unlink delay */
 
+#if (EHCI_SHRINK_JIFFIES < 1)
+#undef EHCI_SHRINK_JIFFIES
+#define EHCI_SHRINK_JIFFIES	1
+#endif
+
 /* Initial IRQ latency:  faster than hw default */
 static int log2_irq_thresh = 0;		// 0 to 6
 module_param (log2_irq_thresh, int, S_IRUGO);
@@ -418,7 +424,7 @@ static int ehci_init(struct usb_hcd *hcd
 	u32			temp;
 	int			retval;
 	u32			hcc_params;
-
+	
 	spin_lock_init(&ehci->lock);
 
 	init_timer(&ehci->watchdog);
@@ -573,6 +579,66 @@ static int ehci_run (struct usb_hcd *hcd
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_USB_OTG_HIGHSPEED) && defined(CONFIG_USB_PORT_AMD5536OTG)
+
+static int ehci_start_otg (struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+
+	if (!hcd->self.otg_port) {
+		hcd->self.otg_port = USB_OTG_PORT;
+		ehci->power_budget = OTG_PWR_BUDGET;
+	}
+	if (usb_otg_get_transceiver) {
+		ehci->transceiver = usb_otg_get_transceiver();
+		if (ehci->transceiver) {
+			int	status;
+
+			if (ehci->transceiver->host) {
+				ehci_err (ehci, "OTG already registered\n");
+				return -EBUSY;
+			}
+			ehci->transceiver->host = &hcd->self;
+			hcd->self.hand_over = 0;
+			status = ehci->transceiver->set_host(
+					ehci->transceiver, &hcd->self);
+
+			ehci_dbg (ehci, "init %s transceiver, status %d\n",
+				  ehci->transceiver->label, status);
+
+			/* if (status)
+			put_device(ehci->transceiver->dev); */
+			return status;
+		}
+		else  {
+			ehci_err (ehci, "can't find transceiver\n");
+			return -ENODEV;
+		}
+	}
+	else {
+		ehci_info (ehci, "OTG driver not loaded\n");
+		return 0;
+	}
+}
+
+static void ehci_stop_otg (struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+
+	ehci_dbg (ehci, "clean up %s transceiver\n",
+		  ehci->transceiver->label);
+	if (ehci->transceiver) {
+		ehci->transceiver->host = NULL;
+		ehci->transceiver->set_host(ehci->transceiver, NULL);
+	}
+	ehci->transceiver = NULL;
+	ehci->power_budget = 0;
+	hcd->self.otg_port = 0;
+}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 static irqreturn_t ehci_irq (struct usb_hcd *hcd, struct pt_regs *regs)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
@@ -884,20 +950,23 @@ static int ehci_get_frame (struct usb_hc
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	return (readl (&ehci->regs->frame_index) >> 3) % ehci->periodic_size;
+#if defined(CONFIG_USB_OTG_HIGHSPEED) && defined(CONFIG_USB_PORT_AMD5536OTG)
+	.start_otg =		ehci_start_otg,
+	.stop_otg =		ehci_stop_otg,
+#endif
 }
 
 /*-------------------------------------------------------------------------*/
 
 #define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
-
 MODULE_DESCRIPTION (DRIVER_INFO);
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
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 82caf33..26e070d 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -201,6 +201,17 @@ static int check_reset_complete (
 		port_status |= PORT_OWNER;
 		port_status &= ~PORT_RWC_BITS;
 		writel (port_status, &ehci->regs->port_status [index]);
+		
+#if defined(CONFIG_USB_OTG_HIGHSPEED) && defined(CONFIG_USB_PORT_AMD5536OTG)
+
+		if (ehci->transceiver &&
+		    ((index + 1) == ehci_to_hcd(ehci)->self.otg_port) &&
+		    (ehci->transceiver->companion)) {
+			ehci->transceiver->companion->hand_over = 1;
+			usb_bus_start_enum (ehci->transceiver->companion,
+				ehci->transceiver->companion->otg_port);
+		}
+#endif
 
 	} else
 		ehci_dbg (ehci, "port %d high speed\n", index + 1);
@@ -304,6 +315,59 @@ ehci_hub_descriptor (
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+
+static int ehci_start_port_reset (struct usb_hcd *hcd, unsigned port)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci (hcd);
+	u32			status;
+
+	if (!port)
+		return -EINVAL;
+	port--;
+
+	/* start port reset before HNP protocol times out */
+	status = readl (&ehci->regs->port_status [port]);
+	if (status & PORT_RESUME)
+		return -EINVAL;
+
+	if (!(status & PORT_CONNECT))
+		return -ENODEV;
+
+	status |= PORT_RESET;
+	status &= ~(PORT_PE | PORT_CSC);   /* PORT_CSC for khubd notification */
+	ehci->reset_done [port] = jiffies + msecs_to_jiffies (50);
+	writel (status, &ehci->regs->port_status [port]);
+	return 0;
+}
+
+#ifdef CONFIG_USB_PORT_AMD5536OTG
+
+static void start_hnp (struct ehci_hcd *ehci)
+{
+	const unsigned	port = ehci_to_hcd(ehci)->self.otg_port - 1;
+	unsigned long	flags;
+	u32		status;
+
+	otg_start_hnp (ehci->transceiver);
+	local_irq_save (flags);
+	status = readl (&ehci->regs->port_status [port]);
+	if (!(status & PORT_OWNER) && (status & PORT_PE))
+		writel (status | PORT_SUSPEND, &ehci->regs->port_status [port]);
+	local_irq_restore (flags);
+}
+#endif
+
+static void start_hnp (struct ehci_hcd *ehci);
+
+#else
+
+#define	ehci_start_port_reset		NULL
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #define	PORT_WAKE_BITS 	(PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E)
 
 static int ehci_hub_control (
@@ -517,10 +581,20 @@ static int ehci_hub_control (
 			if ((temp & PORT_PE) == 0
 					|| (temp & PORT_RESET) != 0)
 				goto error;
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+			if (hcd->self.otg_port == (wIndex + 1)
+					&& hcd->self.b_hnp_enable)
+				start_hnp(ehci);
+			else {
+#endif
+
 			if (hcd->remote_wakeup)
 				temp |= PORT_WAKE_BITS;
 			writel (temp | PORT_SUSPEND,
 				&ehci->regs->port_status [wIndex]);
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+			}
+#endif
 			break;
 		case USB_PORT_FEAT_POWER:
 			if (HCS_PPC (ehci->hcs_params))
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 18e257c..d762443 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -75,6 +75,14 @@ struct ehci_hcd {			/* one per controlle
 	/* per root hub port */
 	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
 
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	/*
+	 * OTG controller needs software interaction
+	 */
+	struct otg_transceiver	*transceiver;
+	unsigned		power_budget;
+#endif
+
 	/* per-HC memory pools (could be per-bus, but ...) */
 	struct dma_pool		*qh_pool;	/* qh per active urb */
 	struct dma_pool		*qtd_pool;	/* one or more per qh */
diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 486202d..a5f2dfe 100644
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
@@ -216,11 +286,15 @@ static const struct hc_driver ohci_au1xx
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
+#ifdef	CONFIG_USB_OTG
+	.start_otg =		ohci_start_otg,
+	.stop_otg =		ohci_stop_otg,
+#endif
 };
 
 /*-------------------------------------------------------------------------*/
@@ -234,7 +308,7 @@ static int ohci_hcd_au1xxx_drv_probe(str
 	if (usb_disabled())
 		return -ENODEV;
 
-	ret = usb_hcd_au1xxx_probe(&ohci_au1xxx_hc_driver, pdev);
+	ret = usb_ohci_au1xxx_probe(&ohci_au1xxx_hc_driver, pdev);
 	return ret;
 }
 
@@ -242,7 +316,7 @@ static int ohci_hcd_au1xxx_drv_remove(st
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
-	usb_hcd_au1xxx_remove(hcd, pdev);
+	usb_ohci_au1xxx_remove(hcd, pdev);
 	return 0;
 }
 	/*TBD*/
@@ -287,3 +361,4 @@ static void __exit ohci_hcd_au1xxx_clean
 
 module_init (ohci_hcd_au1xxx_init);
 module_exit (ohci_hcd_au1xxx_cleanup);
+
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index b8efc6e..b610ea5 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -879,6 +879,79 @@ static int ohci_restart (struct ohci_hcd
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_USB_OTG) && (CONFIG_USB_PORT_AMD5536OTG)
+
+static int ohci_start_otg (struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+
+	if (!hcd->self.otg_port) {
+		hcd->self.otg_port = USB_OTG_PORT;
+		ohci->power_budget = OTG_PWR_BUDGET;
+	}
+	if (usb_otg_get_transceiver) {
+		ohci->transceiver = usb_otg_get_transceiver();
+		if (ohci->transceiver) {
+			int	status;
+
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+			if (ohci->transceiver->companion) {
+	ohci_err (ohci, "OTG already registered\n");
+	return -EBUSY;
+			}
+			ohci->transceiver->companion = &hcd->self;
+			hcd->self.hand_over = 0;
+#else
+			if (ohci->transceiver->host) {
+	ohci_err (ohci, "OTG already registered\n");
+	return -EBUSY;
+			}
+			ohci->transceiver->host = &hcd->self;
+#endif
+			status = ohci->transceiver->set_host(
+					ohci->transceiver, &hcd->self);
+
+			ohci_dbg(ohci, "init %s transceiver, status %d\n",
+				 ohci->transceiver->label, status);
+
+			/* if (status)
+			put_device(ohci->transceiver->dev); */
+			return status;
+		}
+		else  {
+			ohci_err (ohci, "can't find transceiver\n");
+			return -ENODEV;
+		}
+	}
+	else {
+		ohci_info (ohci, "OTG driver not loaded\n");
+		return 0;
+	}
+}
+
+static void ohci_stop_otg (struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+
+	if (ohci->transceiver) {
+		ohci_dbg (ohci, "clean up %s transceiver\n",
+			  ohci->transceiver->label);
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+		ohci->transceiver->companion = NULL;
+#else
+		ohci->transceiver->host = NULL;
+#endif
+		ohci->transceiver->set_host(ohci->transceiver, NULL);
+		ohci->transceiver = NULL;
+		ohci->power_budget = 0;
+		hcd->self.otg_port = 0;
+	}
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
 
 MODULE_AUTHOR (DRIVER_AUTHOR);
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 72e3b12..31a8a0d 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -431,13 +431,31 @@ static int ohci_start_port_reset (struct
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	u32			status;
+	int			usec = 500;  /* 500 usec handshake time */
 
 	if (!port)
 		return -EINVAL;
 	port--;
 
 	/* start port reset before HNP protocol times out */
+#ifdef	CONFIG_USB_OTG_HIGHSPEED
+
+	if (hcd->self.hand_over && (port + 1 == hcd->self.otg_port)) {
+		udelay (usec);
+		usec = 0;
+		status = ohci_readl (ohci, &ohci->regs->roothub.portstatus [port]);
+	}
+	else {
+#endif
 	status = ohci_readl(ohci, &ohci->regs->roothub.portstatus [port]);
+	while (usec && !(status & RH_PS_CCS)) {
+		status = ohci_readl (ohci, &ohci->regs->roothub.portstatus [port]);
+		usec--;
+		udelay(1);
+	}
+#ifdef	CONFIG_USB_OTG_HIGHSPEED
+	}
+#endif	
 	if (!(status & RH_PS_CCS))
 		return -ENODEV;
 
@@ -446,8 +464,29 @@ static int ohci_start_port_reset (struct
 	return 0;
 }
 
+#ifdef	CONFIG_USB_PORT_AMD5536OTG
+
+static void start_hnp (struct ohci_hcd *ohci)
+{
+	const unsigned	port = ohci_to_hcd(ohci)->self.otg_port - 1;
+	unsigned long	flags;
+	u32		status;
+
+	otg_start_hnp (ohci->transceiver);
+
+	local_irq_save (flags);
+	status = ohci_readl (ohci, &ohci->regs->roothub.portstatus [port]);
+	if (status & RH_PS_PES)
+		ohci_writel (ohci, RH_PS_PSS,
+		&ohci->regs->roothub.portstatus [port]);
+	local_irq_restore (flags);
+}
+#else
+
 static void start_hnp(struct ohci_hcd *ohci);
 
+#endif
+
 #else
 
 #define	ohci_start_port_reset		NULL
@@ -482,10 +521,27 @@ static inline void root_port_reset (stru
 	u16	now = ohci_readl(ohci, &ohci->regs->fmnumber);
 	u16	reset_done = now + PORT_RESET_MSEC;
 
+#ifdef CONFIG_USB_OTG
+	struct usb_hcd *hcd = ohci_to_hcd (ohci);
+#endif
+
 	/* build a "continuous enough" reset signal, with up to
 	 * 3msec gap between pulses.  scheduler HZ==100 must work;
 	 * this might need to be deadline-scheduled.
 	 */
+
+#ifdef CONFIG_USB_OTG
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	if (hcd->self.hand_over && (port + 1 == hcd->self.otg_port)) {
+		hcd->self.hand_over = 0;
+		reset_done = now + PORT_RESET_HW_MSEC - 1;
+	}
+	else
+#else
+	if (hcd->self.is_b_host)
+		reset_done = now + PORT_RESET_HW_MSEC - 1;
+#endif
+#endif
 	do {
 		/* spin until any current reset finishes */
 		for (;;) {
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 1b09dde..54d3afa 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -188,6 +188,10 @@ static const struct hc_driver ohci_pci_h
 	.bus_resume =		ohci_bus_resume,
 #endif
 	.start_port_reset =	ohci_start_port_reset,
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG)
+	.start_otg =		ohci_start_otg,
+	.stop_otg =		ohci_stop_otg,
+#endif	
 };
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index caacf14..b94717a 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -371,6 +371,7 @@ struct ohci_hcd {
 	 * other external transceivers should be software-transparent 
 	 */
 	struct otg_transceiver	*transceiver;
+	unsigned		power_budget;
 
 	/*
 	 * memory management for queue data structures
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
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d81b050..e71b584 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -270,6 +270,7 @@ struct usb_bus {
 	u8 otg_port;			/* 0, or number of OTG/HNP port */
 	unsigned is_b_host:1;		/* true during some HNP roleswitches */
 	unsigned b_hnp_enable:1;	/* OTG: did A-Host enable HNP? */
+	unsigned hand_over:1;		/* HS controller detected FS device */
 
 	int devnum_next;		/* Next open device number in
 					 * round-robin allocation */
@@ -1015,6 +1016,12 @@ extern int usb_clear_halt(struct usb_dev
 extern int usb_reset_configuration(struct usb_device *dev);
 extern int usb_set_interface(struct usb_device *dev, int ifnum, int alternate);
 
+#if defined(CONFIG_USB_OTG) && defined(CONFIG_USB_PORT_AMD5536OTG)
+extern struct otg_transceiver * (*usb_otg_get_transceiver)(void);
+extern int usb_host_register_otg (struct otg_transceiver * (*get_transceiver)(void));
+extern void usb_host_deregister_otg(void);
+#endif
+
 /*
  * timeouts, in milliseconds, used for sending/receiving control messages
  * they typically complete within a few frames (msec) after they're issued

--ikeVEW9yuYc//A+q--
