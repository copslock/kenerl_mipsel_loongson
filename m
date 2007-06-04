Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 00:24:28 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:37103 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20026655AbXFDXYS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 00:24:18 +0100
Received: (qmail 14398 invoked by uid 101); 4 Jun 2007 23:23:54 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 4 Jun 2007 23:23:54 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l54NNrPp014781;
	Mon, 4 Jun 2007 16:23:53 -0700
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l54NNi6e013258;
	Mon, 4 Jun 2007 17:23:44 -0600
Date:	Mon, 4 Jun 2007 17:23:44 -0600
Message-Id: <200706042323.l54NNi6e013258@pasqua.pmc-sierra.bc.ca>
To:	gregkh@suse.de
Subject: [PATCH 11/12] drivers: PMC MSP71xx USB driver
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	linux-usb-devel@lists.sourceforge.net
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

[PATCH 11/12] drivers: PMC MSP71xx USB driver

Patch to add an USB driver for the PMC-Sierra MSP71xx devices.

Patches 1 through 10 were posted to linux-mips@linux-mips.org as well
as other sub-system lists/maintainers as appropriate. This patch has
some dependencies on the first few patches in the set. If you would
like to receive these or the entire set, please email me.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---
Initial posting of patch, includes host and gadget support.

 Kconfig                               |    1 
 core/hub.c                            |   46 
 gadget/Kconfig                        |   19 
 gadget/Makefile                       |    1 
 gadget/epautoconf.c                   |   23 
 gadget/ether.c                        |   22 
 gadget/file_storage.c                 |   14 
 gadget/gadget_chips.h                 |    8 
 gadget/pmc-sierra/Makefile            |    4 
 gadget/pmc-sierra/arc.c               |   90 +
 gadget/pmc-sierra/arc.h               |   72 +
 gadget/pmc-sierra/debug.c             |   23 
 gadget/pmc-sierra/debug.h             |  115 ++
 gadget/pmc-sierra/dev_cncl.c          |   63 +
 gadget/pmc-sierra/dev_ep_deinit.c     |   58 +
 gadget/pmc-sierra/dev_main.c          |  486 ++++++++
 gadget/pmc-sierra/dev_recv.c          |  104 +
 gadget/pmc-sierra/dev_send.c          |  104 +
 gadget/pmc-sierra/dev_shut.c          |   64 +
 gadget/pmc-sierra/dev_utl.c           |  243 ++++
 gadget/pmc-sierra/devapi.h            |   95 +
 gadget/pmc-sierra/msp71xx_dev.c       | 1192 +++++++++++++++++++++
 gadget/pmc-sierra/msp71xx_dev.h       |   97 +
 gadget/pmc-sierra/msp71xx_udc.c       | 1863 ++++++++++++++++++++++++++++++++++
 gadget/pmc-sierra/msp71xx_udc.h       |  284 +++++
 gadget/pmc-sierra/usb.h               |  127 ++
 gadget/pmc-sierra/usbprv_dev.h        |  245 ++++
 gadget/pmc-sierra/vusbhs.h            |  725 +++++++++++++
 gadget/pmc-sierra/vusbhs_dev_cncl.c   |  180 +++
 gadget/pmc-sierra/vusbhs_dev_deinit.c |   85 +
 gadget/pmc-sierra/vusbhs_dev_main.c   | 1418 +++++++++++++++++++++++++
 gadget/pmc-sierra/vusbhs_dev_shut.c   |   73 +
 gadget/pmc-sierra/vusbhs_dev_utl.c    |  265 ++++
 gadget/serial.c                       |   14 
 gadget/zero.c                         |   16 
 host/Kconfig                          |   32 
 host/ehci-dbg.c                       |   92 -
 host/ehci-hcd.c                       |   24 
 host/ehci-hub.c                       |    9 
 host/ehci-mem.c                       |    6 
 host/ehci-pmcmsp.c                    |  434 +++++++
 host/ehci-q.c                         |   48 
 host/ehci-sched.c                     |  107 +
 host/ehci.h                           |  204 +++
 44 files changed, 8994 insertions(+), 201 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 9980a4d..bb97a0b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -37,6 +37,7 @@ config USB_ARCH_HAS_OHCI
 # some non-PCI hcds implement EHCI
 config USB_ARCH_HAS_EHCI
 	boolean
+	default y if PMC_MSP7120_GW || PMC_MSP7120_EVAL || PMC_MSP7120_FPGA
 	default y if PPC_83xx
 	default y if SOC_AU1200
 	default PCI
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b89a98e..17c36cb 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -73,7 +73,6 @@ struct usb_hub {
 	struct delayed_work	leds;
 };
 
-
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -2749,12 +2748,45 @@ static void hub_events(void)
 			}
 			
 			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
-				dev_err (hub_dev,
-					"over-current change on port %d\n",
-					i);
-				clear_port_feature(hdev, i,
-					USB_PORT_FEAT_C_OVER_CURRENT);
-				hub_power_on(hub);
+				if (strcmp(hdev->bus->controller->driver->name,
+						"pmcmsp-ehci") == 0) {
+					/* clear OCC bit */
+					clear_port_feature(hdev, i,
+						USB_PORT_FEAT_C_OVER_CURRENT);
+
+					/*
+					 * This step is required to toggle
+					 * the PP bit to 0 and 1 (by
+					 * hub_power_on) in order the CSC bit
+					 * to be transitioned properly for
+					 * device hotplug
+					 */
+					/* clear PP bit */
+					clear_port_feature(hdev, i,
+							USB_PORT_FEAT_POWER);
+
+					/* resume power */
+					hub_power_on(hub);
+
+					/* delay 100 usec */
+					udelay(100);
+
+					/* read OCA bit */
+					if (portstatus &
+					   (1 << USB_PORT_FEAT_OVER_CURRENT)) {
+						/* declare overcurrent */
+						dev_err(hub_dev,
+							"over-current change "
+							"on port %d\n", i);
+					}
+				} else {
+					dev_err (hub_dev,
+						"over-current change "
+						"on port %d\n", i);
+					clear_port_feature(hdev, i,
+						USB_PORT_FEAT_C_OVER_CURRENT);
+					hub_power_on(hub);
+				}
 			}
 
 			if (portchange & USB_PORT_STAT_C_RESET) {
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 4097a86..57a9914 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -154,6 +154,25 @@ config USB_LH7A40X
 	default USB_GADGET
 	select USB_GADGET_SELECTED
 
+config USB_GADGET_MSP71XX
+	boolean "MSP71XX"
+	select USB_GADGET_DUALSPEED
+	help
+	   PMC MSP71XX USB peripheral controller which
+	   supports both full and high speed USB 2.0 data transfers.
+
+	   It has 6 endpoints, including endpoint zero
+	   (for control transfers)
+
+	   Say "y" to link the driver statically, or "m" to build a
+	   dynamically linked module called "pmc_tdi" and force all
+	   gadget drivers to also be dynamically linked.
+
+config USB_MSP71XX
+	tristate
+	depends on USB_GADGET_MSP71XX
+	default USB_GADGET
+	select USB_GADGET_SELECTED
 
 config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index e71e086..f8c2888 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_USB_GOKU)		+= goku_udc.o
 obj-$(CONFIG_USB_OMAP)		+= omap_udc.o
 obj-$(CONFIG_USB_LH7A40X)	+= lh7a40x_udc.o
 obj-$(CONFIG_USB_AT91)		+= at91_udc.o
+obj-$(CONFIG_USB_MSP71XX)	+= pmc-sierra/
 
 #
 # USB gadget drivers
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index f28af06..5312457 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -179,8 +179,10 @@ ep_matches (
 		int size = ep->maxpacket;
 
 		/* min() doesn't work on bitfields with gcc-3.5 */
-		if (size > 64)
-			size = 64;
+		if (!gadget_is_msp71xx (gadget)) {
+			if (size > 64)
+				size = 64;
+		}
 		desc->wMaxPacketSize = cpu_to_le16(size);
 	}
 	return 1;
@@ -274,6 +276,23 @@ struct usb_ep * __devinit usb_ep_autoconfig (
 		ep = find_ep (gadget, "ep1-bulk");
 		if (ep && ep_matches (gadget, ep, desc))
 			return ep;
+	} else if (gadget_is_msp71xx (gadget)) {
+		if (USB_ENDPOINT_XFER_BULK == type) {
+			/* ep1in-bulk, ep1out-bulk */
+			ep = find_ep (gadget, "ep1in-bulk");
+			if (ep && ep_matches (gadget, ep, desc))
+				return ep;
+			ep = find_ep (gadget, "ep1out-bulk");
+			if (ep && ep_matches (gadget, ep, desc))
+				return ep;
+		} else if (USB_ENDPOINT_XFER_INT == type) {
+			ep = find_ep (gadget, "ep2in-intr");
+			if (ep && ep_matches (gadget, ep, desc))
+				return ep;
+			ep = find_ep (gadget, "ep2out-intr");
+			if (ep && ep_matches (gadget, ep, desc))
+				return ep;
+		}
 	}
 
 	/* Second, look at endpoints until an unclaimed one looks usable */
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 04e6b85..3608f21 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -282,6 +282,10 @@ MODULE_PARM_DESC(host_addr, "Host Ethernet Address");
 #define DEV_CONFIG_CDC
 #endif
 
+#ifdef CONFIG_USB_GADGET_MSP71XX
+#define DEV_CONFIG_CDC
+#endif
+
 
 /* For CDC-incapable hardware, choose the simple cdc subset.
  * Anything that talks bulk (without notable bugs) can do this.
@@ -1598,14 +1602,16 @@ done_set_intf:
 
 	/* respond with data transfer before status phase? */
 	if (value >= 0) {
-		req->length = value;
-		req->zero = value < wLength
-				&& (value % gadget->ep0->maxpacket) == 0;
-		value = usb_ep_queue (gadget->ep0, req, GFP_ATOMIC);
-		if (value < 0) {
-			DEBUG (dev, "ep_queue --> %d\n", value);
-			req->status = 0;
-			eth_setup_complete (gadget->ep0, req);
+		if ((!gadget_is_msp71xx (gadget)) || (value != 0)) {
+			req->length = value;
+			req->zero = value < wLength
+				    && (value % gadget->ep0->maxpacket) == 0;
+			value = usb_ep_queue (gadget->ep0, req, GFP_ATOMIC);
+			if (value < 0) {
+				DEBUG (dev, "ep_queue --> %d\n", value);
+				req->status = 0;
+				eth_setup_complete (gadget->ep0, req);
+			}
 		}
 	}
 
diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index c6b6479..4b06c69 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -1134,14 +1134,16 @@ static void fsg_disconnect(struct usb_gadget *gadget)
 
 static int ep0_queue(struct fsg_dev *fsg)
 {
-	int	rc;
-
-	rc = usb_ep_queue(fsg->ep0, fsg->ep0req, GFP_ATOMIC);
-	if (rc != 0 && rc != -ESHUTDOWN) {
+	int	rc = 0;
 
-		/* We can't do much more than wait for a reset */
-		WARN(fsg, "error in submission: %s --> %d\n",
+	if ((!gadget_is_msp71xx (fsg->gadget)) ||
+	    (fsg->ep0req->length != 0)) {
+		rc = usb_ep_queue(fsg->ep0, fsg->ep0req, GFP_ATOMIC);
+		if (rc != 0 && rc != -ESHUTDOWN) {
+			/* We can't do much more than wait for a reset */
+			WARN(fsg, "error in submission: %s --> %d\n",
 				fsg->ep0->name, rc);
+		}
 	}
 	return rc;
 }
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index 2e3d662..02039cb 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -119,6 +119,12 @@
 #define gadget_is_mpc8272(g)	0
 #endif
 
+#ifdef CONFIG_USB_GADGET_MSP71XX
+#define gadget_is_msp71xx(g)	!strcmp("msp71xx_udc", (g)->name)
+#else
+#define gadget_is_msp71xx(g)	0
+#endif
+
 // CONFIG_USB_GADGET_SX2
 // CONFIG_USB_GADGET_AU1X00
 // ...
@@ -177,5 +183,7 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x17;
 	else if (gadget_is_husb2dev(gadget))
 		return 0x18;
+	else if (gadget_is_msp71xx(gadget))
+		return 0x19;
 	return -ENOENT;
 }
diff --git a/drivers/usb/gadget/serial.c b/drivers/usb/gadget/serial.c
index e552668..86a1797 100644
--- a/drivers/usb/gadget/serial.c
+++ b/drivers/usb/gadget/serial.c
@@ -1536,12 +1536,14 @@ static int gs_setup(struct usb_gadget *gadget,
 		req->length = ret;
 		req->zero = ret < wLength
 				&& (ret % gadget->ep0->maxpacket) == 0;
-		ret = usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
-		if (ret < 0) {
-			printk(KERN_ERR "gs_setup: cannot queue response, ret=%d\n",
-				ret);
-			req->status = 0;
-			gs_setup_complete(gadget->ep0, req);
+		if ((!gadget_is_msp71xx (gadget)) || (req->length != 0)) {
+			ret = usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
+			if (ret < 0) {
+				printk(KERN_ERR "gs_setup: cannot "
+					"queue response, ret=%d\n", ret);
+				req->status = 0;
+				gs_setup_complete(gadget->ep0, req);
+			}
 		}
 	}
 
diff --git a/drivers/usb/gadget/zero.c b/drivers/usb/gadget/zero.c
index 8c85e33..a8f0e62 100644
--- a/drivers/usb/gadget/zero.c
+++ b/drivers/usb/gadget/zero.c
@@ -1069,13 +1069,15 @@ unknown:
 
 	/* respond with data transfer before status phase? */
 	if (value >= 0) {
-		req->length = value;
-		req->zero = value < w_length;
-		value = usb_ep_queue (gadget->ep0, req, GFP_ATOMIC);
-		if (value < 0) {
-			DBG (dev, "ep_queue --> %d\n", value);
-			req->status = 0;
-			zero_setup_complete (gadget->ep0, req);
+		if (!gadget_is_msp71xx(gadget) || value != 0) {
+			req->length = value;
+			req->zero = value < w_length;
+			value = usb_ep_queue (gadget->ep0, req, GFP_ATOMIC);
+			if (value < 0) {
+				DBG (dev, "ep_queue --> %d\n", value);
+				req->status = 0;
+				zero_setup_complete (gadget->ep0, req);
+			}
 		}
 	}
 
diff --git a/drivers/usb/gadget/pmc-sierra/arc.c b/drivers/usb/gadget/pmc-sierra/arc.c
new file mode 100644
index 0000000..ed2d786
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/arc.c
@@ -0,0 +1,90 @@
+/*
+ * arc.c -- This file contains all architecture declarations and functions
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even
+ * the implied  warranty of NON- INFRINGEMENT AND MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <asm/r4kcache.h>
+
+#include "arc.h"
+
+volatile bool in_isr = false;
+
+/****************************************************************************
+ *
+ * Function Name : _bsp_install_isr
+ * Returned Value : None
+ * Comments :
+ *	Installs the USB interrupt service routine
+ *
+ ***************************************************************************/
+void _bsp_install_isr(
+	u8 vector_number,
+	void ( * isr_ptr)(void),
+	void * handle)
+{
+}
+
+
+/****************************************************************************
+ *
+ * Function Name : _bsp_get_usb_vector
+ * Returned Value : interrupt vector number
+ * Comments :
+ *	Get the vector number for the specified device number
+ ***************************************************************************/
+u8 _bsp_get_usb_vector(u8 device_number)
+{
+	if (device_number == 0)
+		return BSP_VUSB20_DEVICE_VECTOR0;
+
+	return -1;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _bsp_get_usb_base
+ * Returned Value : Address of the VUSB register base
+ * Comments :
+ *	Get the USB register base address
+ ***************************************************************************/
+void * _bsp_get_usb_base(u8 device_number)
+{
+	if (device_number == 0)
+		return ioremap_nocache(BSP_VUSB20_DEVICE_BASE_ADDRESS0,
+					BSP_VUSB20_DEVICE_SIZE0);
+
+	return (void *)-1;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _bsp_get_usb_capability_register_base
+ * Returned Value : Address of the VUSB1.1 capability register base
+ * Comments :
+ *	Get the USB capability register base address
+ ***************************************************************************/
+void * _bsp_get_usb_capability_register_base(u8 device_number)
+{
+	if (device_number == 0)
+		return ioremap_nocache(BSP_VUSB20_DEVICE_CAP_BASE_ADDRESS0,
+					BSP_VUSB20_DEVICE_CAP_SIZE0);
+
+	return (void *)-1;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/debug.c b/drivers/usb/gadget/pmc-sierra/debug.c
new file mode 100644
index 0000000..640900b
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/debug.c
@@ -0,0 +1,23 @@
+/*
+ * debug.c -- This file contains all debug trace declarations
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#define __TRACE_VARIABLES_DEFINED__
+#include "debug.h"
diff --git a/drivers/usb/gadget/pmc-sierra/dev_cncl.c b/drivers/usb/gadget/pmc-sierra/dev_cncl.c
new file mode 100644
index 0000000..ec86a12
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_cncl.c
@@ -0,0 +1,63 @@
+/*
+ * dev_cncl.c -- This file contains USB device API specific function to cancel
+ *		transfer
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_cancel_transfer
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	returns the status of the transaction on the specified endpoint.
+ *
+ ***************************************************************************/
+u8 _usb_device_cancel_transfer(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	u8 error = USB_OK;
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_cancel_transfer");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	spin_lock(&usb_dev_ptr->lock);
+
+	/*
+	 * Cancel transfer on the specified endpoint for the specified
+	 * direction.
+	 */
+	error = _usb_dci_vusb20_cancel_transfer(handle, ep_num, direction);
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_cancel_transfer, SUCCESSFUL");
+#endif
+
+	return error;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/dev_ep_deinit.c b/drivers/usb/gadget/pmc-sierra/dev_ep_deinit.c
new file mode 100644
index 0000000..343a915
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_ep_deinit.c
@@ -0,0 +1,58 @@
+/*
+ * dev_ep_deinit.c -- This file contains USB device API specific function to
+ *		deinitialize the endpoint.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ *  Function Name  : _usb_device_deinit_endpoint
+ *  Returned Value : USB_OK or error code
+ *  Comments :
+ *  Disables the endpoint and the data structures associated with the
+ *  endpoint
+ *
+ ***************************************************************************/
+u8 _usb_device_deinit_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	u8 error = 0;
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_deinit_endpoint");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	spin_lock(&usb_dev_ptr->lock);
+	error = _usb_dci_vusb20_deinit_endpoint(handle, ep_num, direction);
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_deinit_endpoint,SUCCESSFUL");
+#endif
+
+	return error;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/dev_main.c b/drivers/usb/gadget/pmc-sierra/dev_main.c
new file mode 100644
index 0000000..c23217b
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_main.c
@@ -0,0 +1,486 @@
+/*
+ * dev_main.c -- This file contains the main USB device API functions that
+ *		will be used by most applications.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_free_xd
+ * Returned Value : void
+ * Comments :
+ *	Enqueues a XD onto the free XD ring.
+ *
+ ***************************************************************************/
+void _usb_device_free_xd(void * xd_ptr)
+{
+	struct usb_dev_state * usb_dev_ptr = (struct usb_dev_state *)
+			((struct xd *)xd_ptr)->scratch_ptr->private;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_free_xd");
+#endif
+
+	/*
+	 * This function can be called from any context, and it needs mutual
+	 * exclusion with itself.
+	 */
+	spin_lock(&usb_dev_ptr->lock);
+
+	/*
+	 * Add the XD to the free XD queue (linked via private) and
+	 * increment the tail to the next descriptor
+	 */
+	USB_XD_QADD(usb_dev_ptr->xd_head, usb_dev_ptr->xd_tail,
+			(struct xd *)xd_ptr);
+	usb_dev_ptr->xd_entries++;
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_free_xd, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_init
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Initializes the USB device specific data structures and calls
+ *	the low-level device controller chip initialization routine.
+ *
+ ***************************************************************************/
+u8 _usb_device_init(
+	u8 devnum,
+	_usb_device_handle * handle,
+	u8 endpoints)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	struct xd * xd_ptr;
+	u8 i, error;
+	struct scratch * temp_scratch_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_init");
+#endif
+
+	if (devnum > MAX_USB_DEVICES) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE(
+			"_usb_device_init, error invalid device number");
+#endif
+		return USBERR_INVALID_DEVICE_NUM;
+	}
+
+	/* Allocate memory for the state structure */
+	usb_dev_ptr = (struct usb_dev_state *)
+			kzalloc(sizeof(struct usb_dev_state), GFP_KERNEL);
+
+	if (usb_dev_ptr == NULL) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE(
+			"_usb_device_init, error NULL device handle");
+#endif
+		return USBERR_ALLOC_STATE;
+	}
+
+	/* Initialize device lock */
+	spin_lock_init(&usb_dev_ptr->lock);
+
+	/*
+	 * Multiple devices will have different base addresses and
+	 * interrupt vectors (For future).
+	 */
+	usb_dev_ptr->dev_ptr = _bsp_get_usb_base(devnum);
+	usb_dev_ptr->dev_vec = _bsp_get_usb_vector(devnum);
+	usb_dev_ptr->usb_state = USB_STATE_UNKNOWN;
+
+	usb_dev_ptr->max_endpoints = endpoints;
+
+	/* Allocate MAX_XDS_FOR_TR_CALLS */
+	xd_ptr = (struct xd *)kzalloc(sizeof(struct xd) *
+					MAX_XDS_FOR_TR_CALLS, GFP_KERNEL);
+
+	if (xd_ptr == NULL) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_init, malloc error");
+#endif
+		return USBERR_ALLOC_TR;
+	}
+
+	usb_dev_ptr->xd_base = xd_ptr;
+
+	/* Allocate memory for internal scratch structure */
+	usb_dev_ptr->xd_scratch_base = (struct scratch *)kmalloc(
+		sizeof(struct scratch) * MAX_XDS_FOR_TR_CALLS, GFP_KERNEL);
+
+	if (usb_dev_ptr->xd_scratch_base == NULL) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_init, malloc error");
+#endif
+		return USBERR_ALLOC;
+	}
+
+	temp_scratch_ptr = usb_dev_ptr->xd_scratch_base;
+	usb_dev_ptr->xd_head = NULL;
+	usb_dev_ptr->xd_tail = NULL;
+	usb_dev_ptr->xd_entries = 0;
+
+	/* Enqueue all the XDs */
+	for (i = 0; i < MAX_XDS_FOR_TR_CALLS; i++) {
+		xd_ptr->scratch_ptr = temp_scratch_ptr;
+		xd_ptr->scratch_ptr->free = _usb_device_free_xd;
+		xd_ptr->scratch_ptr->private = (void *)usb_dev_ptr;
+		_usb_device_free_xd((void *)xd_ptr);
+		xd_ptr++;
+		temp_scratch_ptr++;
+	}
+
+	usb_dev_ptr->temp_xd_ptr = (struct xd *)kzalloc(
+					sizeof(struct xd), GFP_KERNEL);
+
+	/* Initialize the USB controller chip */
+	error = _usb_dci_vusb20_init(devnum, usb_dev_ptr);
+	if (error) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_init, init failed");
+#endif
+		return USBERR_INIT_FAILED;
+	}
+
+	*handle = usb_dev_ptr;
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_init, SUCCESSFUL");
+#endif
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_register_service
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Registers a callback routine for a specified event or endpoint.
+ *
+ ***************************************************************************/
+u8 _usb_device_register_service(
+	_usb_device_handle handle,
+	u8 type,
+	void( * service)(void *, bool, u8, u8 *, u32, u8))
+{
+	struct usb_dev_state * usb_dev_ptr;
+	struct service * service_ptr;
+	struct service * * search_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_register_service");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/* Needs mutual exclusion */
+	spin_lock(&usb_dev_ptr->lock);
+
+	/* Search for an existing entry for type */
+	for (search_ptr = &usb_dev_ptr->service_head_ptr;
+	     *search_ptr; search_ptr = &(*search_ptr)->next) {
+		if ((*search_ptr)->type == type) {
+			/* Found an existing entry */
+			spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+			DEBUG_LOG_TRACE("_usb_device_register_service, "
+				"service closed");
+#endif
+			return USBERR_OPEN_SERVICE;
+		}
+	}
+
+	/* No existing entry found - create a new one */
+	service_ptr = (struct service *)kmalloc(
+				sizeof(struct service), GFP_KERNEL);
+	if (!service_ptr) {
+		spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_register_service, "
+			"error allocating service");
+#endif
+		return USBERR_ALLOC;
+	}
+
+	service_ptr->type = type;
+	service_ptr->service = service;
+	service_ptr->next = NULL;
+	*search_ptr = service_ptr;
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_register_service, SUCCESSFUL");
+#endif
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_unregister_service
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Unregisters a callback routine for a specified event or endpoint.
+ *
+ ***************************************************************************/
+u8 _usb_device_unregister_service(
+	_usb_device_handle handle,
+	u8 type)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	struct service * service_ptr;
+	struct service * * search_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_unregister_service");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/* Needs mutual exclusion */
+	spin_lock(&usb_dev_ptr->lock);
+
+	/* Search for an existing entry for type */
+	for (search_ptr = &usb_dev_ptr->service_head_ptr;
+	     *search_ptr; search_ptr = &(*search_ptr)->next) {
+		/* Found an existing entry - delete it */
+		if ((*search_ptr)->type == type)
+			break;
+	}
+
+	/* No existing entry found */
+	if (!*search_ptr) {
+		spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_unregister_service, "
+			"no service found");
+#endif
+		return USBERR_CLOSED_SERVICE;
+	}
+
+	service_ptr = *search_ptr;
+	*search_ptr = service_ptr->next;
+
+	kfree((void *)service_ptr);
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_unregister_service, SUCCESSFUL");
+#endif
+
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_call_service
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Calls the appropriate service for the specified type, if one is
+ *	registered. Used internally only.
+ *
+ ***************************************************************************/
+u8 _usb_device_call_service(
+	_usb_device_handle handle,
+	u8 type,
+	bool setup,
+	bool direction,
+	u8 * buffer_ptr,
+	u32 length,
+	u8 errors)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	struct service * service_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_call_service");
+#endif
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/* Needs mutual exclusion */
+	spin_lock(&usb_dev_ptr->lock);
+
+	/* Search for an existing entry for type */
+	for (service_ptr = usb_dev_ptr->service_head_ptr;
+	     service_ptr; service_ptr = service_ptr->next) {
+		if (service_ptr->type == type) {
+			service_ptr->service(handle, setup, direction,
+						buffer_ptr, length, errors);
+			spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+			DEBUG_LOG_TRACE("_usb_device_call_service, "
+				"SUCCESSFUL service called");
+#endif
+			return USB_OK;
+		}
+	}
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE(
+		"_usb_device_call_service, SUCCESSFUL service closed");
+#endif
+
+	return USBERR_CLOSED_SERVICE;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_init_endpoint
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Initializes the endpoint and the data structures associated with the
+ *	endpoint
+ *
+ ***************************************************************************/
+u8 _usb_device_init_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u16 max_pkt_size,
+	u8 direction,
+	u8 type,
+	u8 flag)
+{
+	u8 error = 0;
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_init_endpoint");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/* Initialize the transfer descriptor */
+	usb_dev_ptr->temp_xd_ptr->ep_num = ep_num;
+	usb_dev_ptr->temp_xd_ptr->bdirection = direction;
+	usb_dev_ptr->temp_xd_ptr->wmaxpacketsize = max_pkt_size;
+	usb_dev_ptr->temp_xd_ptr->ep_type = type;
+	usb_dev_ptr->temp_xd_ptr->dont_zero_terminate = flag;
+	usb_dev_ptr->temp_xd_ptr->max_pkts_per_uframe =
+				((flag & USB_MAX_PKTS_PER_UFRAME) >> 1);
+
+	error = _usb_dci_vusb20_init_endpoint(handle,
+					usb_dev_ptr->temp_xd_ptr);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_init_endpoint, SUCCESSFUL");
+#endif
+	return error;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_get_transfer_status
+ * Returned Value : Status of the transfer
+ * Comments :
+ *	returns the status of the transaction on the specified endpoint.
+ *
+ ***************************************************************************/
+u8 _usb_device_get_transfer_status(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	u8 status;
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_get_transfer_status");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	spin_lock(&usb_dev_ptr->lock);
+	status = _usb_dci_vusb20_get_transfer_status(handle,
+						ep_num, direction);
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_get_transfer_status, SUCCESSFUL");
+#endif
+
+	/* Return the status of the last queued transfer */
+	return status;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_read_setup_data
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Reads the setup data from the hardware
+ *
+ ***************************************************************************/
+void _usb_device_read_setup_data(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 * buff_ptr)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_read_setup_data");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	_usb_dci_vusb20_get_setup_data(handle, ep_num, buff_ptr);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_read_setup_data, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_set_address
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Sets the device address as assigned by the host during enumeration
+ *
+ ***************************************************************************/
+void _usb_device_set_address(
+	_usb_device_handle handle,
+	u8 address)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_set_address");
+#endif
+
+	_usb_dci_vusb20_set_address(handle, address);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_set_address, SUCCESSFUL");
+#endif
+}
diff --git a/drivers/usb/gadget/pmc-sierra/dev_recv.c b/drivers/usb/gadget/pmc-sierra/dev_recv.c
new file mode 100644
index 0000000..18d01b3
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_recv.c
@@ -0,0 +1,104 @@
+/*
+ * dev_recv.c -- This file contains USB device API specific function to
+ * 		receive data.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_recv_data
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Receives data on a specified endpoint.
+ *
+ ***************************************************************************/
+u8 _usb_device_recv_data(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 * buff_ptr,
+	u32 size)
+{
+	u8 error = USB_OK;
+	struct xd * xd_ptr;
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_recv_data");
+#endif
+
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * If system has a data cache, it is assumed that buffer
+	 * passed to this routine will be aligned on a cache line
+	 * boundry. The following code will invalidate the
+	 * buffer before passing it to hardware driver.
+	 */
+	if (buff_ptr) {
+		dma_addr_t dma_buff = dma_map_single(
+					msp71xx_get_dev_ptr()->dev,
+					buff_ptr, size, DMA_FROM_DEVICE);
+		dma_unmap_single(msp71xx_get_dev_ptr()->dev,
+					dma_buff, size, DMA_FROM_DEVICE);
+	}
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	spin_lock(&usb_dev_ptr->lock);
+
+	if (!usb_dev_ptr->xd_entries) {
+		spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_recv_data, transfer in progress");
+#endif
+		return USB_STATUS_TRANSFER_IN_PROGRESS;
+	}
+
+	/*
+	 * Get a transfer descriptor for the specified endpoint
+	 * and direction.
+	 */
+	USB_XD_QGET(usb_dev_ptr->xd_head, usb_dev_ptr->xd_tail, xd_ptr);
+
+	usb_dev_ptr->xd_entries--;
+
+	/* Initialize the new transfer descriptor */
+	xd_ptr->ep_num = ep_num;
+	xd_ptr->bdirection = USB_RECV;
+	xd_ptr->wtotallength = size;
+	xd_ptr->wstartaddress = buff_ptr;
+
+	xd_ptr->bstatus = USB_STATUS_TRANSFER_ACCEPTED;
+
+	error = _usb_dci_vusb20_recv_data(handle, xd_ptr);
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+	if (error) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_recv_data, receive failed");
+#endif
+		return USBERR_RX_FAILED;
+	}
+
+	return error;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/dev_send.c b/drivers/usb/gadget/pmc-sierra/dev_send.c
new file mode 100644
index 0000000..9fccdc1
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_send.c
@@ -0,0 +1,104 @@
+/*
+ * dev_send.c -- This file contains USB device API specific function to send
+ * 				data.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_send_data
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Sends data on a specified endpoint.
+ *
+ ***************************************************************************/
+u8 _usb_device_send_data(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 * buff_ptr,
+	u32 size)
+{
+	u8 error;
+	struct xd * xd_ptr;
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_send_data");
+#endif
+
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * If system has a data cache, it is assumed that buffer
+	 * passed to this routine will be aligned on a cache line
+	 * boundry. The following code will flush the
+	 * buffer before passing it to hardware driver.
+	 */
+	if (buff_ptr) {
+		dma_addr_t dma_buff = dma_map_single(
+					msp71xx_get_dev_ptr()->dev,
+					buff_ptr, size, DMA_TO_DEVICE);
+		dma_unmap_single(msp71xx_get_dev_ptr()->dev,
+					dma_buff, size, DMA_TO_DEVICE);
+	}
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	spin_lock(&usb_dev_ptr->lock);
+
+	if (!usb_dev_ptr->xd_entries) {
+		spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_send_data, transfer in progress");
+#endif
+		return USB_STATUS_TRANSFER_IN_PROGRESS;
+	}
+
+	/* Get a transfer descriptor */
+	USB_XD_QGET(usb_dev_ptr->xd_head, usb_dev_ptr->xd_tail, xd_ptr);
+
+	usb_dev_ptr->xd_entries--;
+
+	/* Initialize the new transfer descriptor */
+	xd_ptr->ep_num = ep_num;
+	xd_ptr->bdirection = USB_SEND;
+	xd_ptr->wtotallength = size;
+	xd_ptr->wstartaddress = buff_ptr;
+
+	xd_ptr->bstatus = USB_STATUS_TRANSFER_ACCEPTED;
+
+	error = _usb_dci_vusb20_send_data(handle, xd_ptr);
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+	if (error) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_device_send_data, transfer failed");
+#endif
+		return USBERR_TX_FAILED;
+	}
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_send_data, SUCCESSFUL");
+#endif
+	return error;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/dev_shut.c b/drivers/usb/gadget/pmc-sierra/dev_shut.c
new file mode 100644
index 0000000..643fe70
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_shut.c
@@ -0,0 +1,64 @@
+/*
+ * dev_shut.c -- This file contains USB device API specific function to
+ * 				shutdown the device
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_shutdown
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Shutdown an initialized USB device
+ *
+ ***************************************************************************/
+void _usb_device_shutdown(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_shutdown");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	_usb_dci_vusb20_shutdown(usb_dev_ptr);
+
+	/* Free all the Callback function structure memory */
+	kfree((void *)usb_dev_ptr->service_head_ptr);
+
+	/* Free all internal transfer descriptors */
+	kfree((void *)usb_dev_ptr->xd_base);
+
+	/* Free all XD scratch memory */
+	kfree((void *)usb_dev_ptr->xd_scratch_base);
+
+	/* Free the temp ep init XD */
+	kfree((void *)usb_dev_ptr->temp_xd_ptr);
+
+	/* Free the USB state structure */
+	kfree((void *)usb_dev_ptr);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_shutdown, SUCCESSFUL");
+#endif
+}
diff --git a/drivers/usb/gadget/pmc-sierra/dev_utl.c b/drivers/usb/gadget/pmc-sierra/dev_utl.c
new file mode 100644
index 0000000..daee69e
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/dev_utl.c
@@ -0,0 +1,243 @@
+/*
+ * dev_utl.c -- This file contains USB device API specific utility functions.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_unstall_endpoint
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Unstalls the endpoint in specified direction
+ *
+ ***************************************************************************/
+void _usb_device_unstall_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_unstall_endpoint");
+#endif
+
+	spin_lock(&usb_dev_ptr->lock);
+	_usb_dci_vusb20_unstall_endpoint(handle, ep_num, direction);
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_unstall_endpoint, SUCCESSFULL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_get_status
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Provides API to access the USB internal state.
+ *
+ ***************************************************************************/
+u8 _usb_device_get_status(
+	_usb_device_handle handle,
+	u8 component,
+	u16 * status)
+{
+	struct usb_dev_state * usb_dev_ptr = (struct usb_dev_state *)handle;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_get_status, SUCCESSFULL");
+#endif
+
+	spin_lock(&usb_dev_ptr->lock);
+
+	switch (component) {
+	case USB_STATUS_DEVICE_STATE:
+		*status = usb_dev_ptr->usb_state;
+		break;
+
+	case USB_STATUS_DEVICE:
+		*status = usb_dev_ptr->usb_dev_state;
+		break;
+
+	case USB_STATUS_INTERFACE:
+		break;
+
+	case USB_STATUS_ADDRESS:
+		*status = usb_dev_ptr->device_address;
+		break;
+
+	case USB_STATUS_CURRENT_CONFIG:
+		*status = usb_dev_ptr->usb_curr_config;
+		break;
+
+	case USB_STATUS_SOF_COUNT:
+		*status = usb_dev_ptr->usb_sof_count;
+		break;
+
+	default:
+		if (component & USB_STATUS_ENDPOINT) {
+			*status = _usb_dci_vusb20_get_endpoint_status(handle,
+				component & USB_STATUS_ENDPOINT_NUMBER_MASK);
+		} else {
+			spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+			DEBUG_LOG_TRACE("_usb_device_get_status, bad status");
+#endif
+			return USBERR_BAD_STATUS;
+		}
+		break;
+	}
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_get_status, SUCCESSFUL");
+#endif
+
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_set_status
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Provides API to set internal state
+ *
+ ***************************************************************************/
+u8 _usb_device_set_status(
+	_usb_device_handle handle,
+	u8 component,
+	u16 setting)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_set_status");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	spin_lock(&usb_dev_ptr->lock);
+
+	switch (component) {
+	case USB_STATUS_DEVICE_STATE:
+		usb_dev_ptr->usb_state = setting;
+		break;
+
+	case USB_STATUS_DEVICE:
+		usb_dev_ptr->usb_dev_state = setting;
+		break;
+
+	case USB_STATUS_INTERFACE:
+		break;
+
+	case USB_STATUS_CURRENT_CONFIG:
+		usb_dev_ptr->usb_curr_config = setting;
+		break;
+
+	case USB_STATUS_SOF_COUNT:
+		usb_dev_ptr->usb_sof_count = setting;
+		break;
+
+	case USB_STATUS_ADDRESS:
+		usb_dev_ptr->device_address = setting;
+
+		_usb_dci_vusb20_set_address((void *)usb_dev_ptr, setting);
+		break;
+
+	case USB_STATUS_TEST_MODE:
+		_usb_dci_vusb20_set_test_mode(handle, setting);
+		break;
+
+	default:
+		if (component & USB_STATUS_ENDPOINT) {
+			_usb_dci_vusb20_set_endpoint_status(handle,
+				component & USB_STATUS_ENDPOINT_NUMBER_MASK,
+				setting);
+		} else {
+			spin_unlock(&usb_dev_ptr->lock);
+#ifdef _DEVICE_DEBUG_
+			DEBUG_LOG_TRACE("_usb_device_set_status, bad status");
+#endif
+			return USBERR_BAD_STATUS;
+		}
+		break;
+	}
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_set_status, SUCCESSFUL");
+#endif
+
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_stall_endpoint
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Stalls the endpoint.
+ *
+ ***************************************************************************/
+void _usb_device_stall_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_stall_endpoint");
+#endif
+
+	_usb_dci_vusb20_stall_endpoint(handle, ep_num, direction);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_stall_endpoint, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_device_process_resume
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Process Resume event
+ *
+ ***************************************************************************/
+void _usb_device_assert_resume(_usb_device_handle handle)
+{
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_assert_resume");
+#endif
+
+	_usb_dci_vusb20_assert_resume(handle);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_device_assert_resume, SUCCESSFUL");
+#endif
+}
diff --git a/drivers/usb/gadget/pmc-sierra/vusbhs_dev_cncl.c b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_cncl.c
new file mode 100644
index 0000000..3caded3
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_cncl.c
@@ -0,0 +1,180 @@
+/*
+ * vusbhs_dev_cncl.c -- This file contains the VUSB_HS Device Controller
+ *			interface function to cancel a transfer.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_cancel_transfer
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Cancels a transfer
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_cancel_transfer(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_tr * dtd_ptr, * check_dtd_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	struct xd * xd_ptr;
+	u32 temp, bit_pos;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_cancel_transfer");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	bit_pos = 1 << (16 * direction + ep_num);
+	temp = 2 * ep_num + direction;
+
+	ep_queue_head_ptr = (struct vusb20_ep_queue_head *)phys_to_virt(
+				dev_ptr->regs.op_dev.ep_list_addr) + temp;
+
+	/* Unlink the dTD */
+	dtd_ptr = usb_dev_ptr->ep_dtd_heads[temp];
+	if (dtd_ptr) {
+		check_dtd_ptr = (struct vusb20_ep_tr *)((u32)phys_to_virt(
+				dtd_ptr->next_tr_elem_ptr) &
+				VUSBHS_TD_ADDR_MASK);
+		if (dtd_ptr->size_ioc_sts & VUSBHS_TD_STATUS_ACTIVE) {
+			/*
+			 * Flushing will halt the pipe.
+			 * Write 1 to the Flush register.
+			 */
+			dev_ptr->regs.op_dev.ep_flush = bit_pos;
+
+			/* Wait until flushing completed */
+			while (dev_ptr->regs.op_dev.ep_flush & bit_pos) {
+				/*
+				 * ep_flush bit should be cleared to
+				 * indicate this operation is complete.
+				 */
+			}
+
+			while (dev_ptr->regs.op_dev.ep_status & bit_pos) {
+				/* Write 1 to the Flush register */
+				dev_ptr->regs.op_dev.ep_flush = bit_pos;
+
+				/* Wait until flushing completed */
+				while (dev_ptr->regs.op_dev.ep_flush &
+					bit_pos) {
+					/*
+					 * ep_flush bit should be cleared to
+					 * indicate this operation is complete.
+					 */
+				}
+			}
+		}
+
+		/* Retire the current dTD */
+		dtd_ptr->size_ioc_sts = 0;
+		dtd_ptr->next_tr_elem_ptr = VUSBHS_TD_NEXT_TERMINATE;
+
+		/* The transfer descriptor for this dTD */
+		xd_ptr = (struct xd *)dtd_ptr->scratch_ptr->xd_for_this_dtd;
+		dtd_ptr->scratch_ptr->private = (void *)usb_dev_ptr;
+		/* Free the dTD */
+		_usb_dci_vusb20_free_dtd((void *)dtd_ptr);
+
+		/*
+		 * Update the dTD head and tail for specific
+		 * endpoint/direction
+		 */
+		if (!((u32)check_dtd_ptr & 0x1ffffffe)) {
+			usb_dev_ptr->ep_dtd_heads[temp] = NULL;
+			usb_dev_ptr->ep_dtd_tails[temp] = NULL;
+			if (xd_ptr) {
+				xd_ptr->scratch_ptr->private =
+						(void *)usb_dev_ptr;
+				/* Free the transfer descriptor */
+				_usb_device_free_xd((void *)xd_ptr);
+			}
+
+			/* No other transfers on the queue */
+			ep_queue_head_ptr->next_dtd_ptr =
+				VUSB_EP_QUEUE_HEAD_NEXT_TERMINATE;
+			ep_queue_head_ptr->size_ioc_int_sts = 0;
+		} else {
+			usb_dev_ptr->ep_dtd_heads[temp] = check_dtd_ptr;
+			if (xd_ptr) {
+				if ((u32)check_dtd_ptr->scratch_ptr->
+				    xd_for_this_dtd != (u32)xd_ptr) {
+					xd_ptr->scratch_ptr->private =
+						(void *)usb_dev_ptr;
+					/* Free the transfer descriptor */
+					_usb_device_free_xd((void *)xd_ptr);
+				}
+			}
+
+			if (check_dtd_ptr->size_ioc_sts &
+			    VUSBHS_TD_STATUS_ACTIVE) {
+				/* Start CR 1015 */
+				/* Prime the Endpoint */
+				dev_ptr->regs.op_dev.ep_prime = bit_pos;
+				if (!(dev_ptr->regs.op_dev.ep_status &
+				    bit_pos)) {
+					while (dev_ptr->regs.op_dev.ep_prime &
+						bit_pos) {
+						/*
+						 * Wait for the ep_prime
+						 * to go to zero
+						 */
+					}
+
+					if (dev_ptr->regs.op_dev.ep_status &
+					    bit_pos) {
+						/*
+						 * The endpoint was not not
+						 * primed so no other
+						 * transfers on the queue.
+						 */
+						goto done;
+					}
+				} else
+					goto done;
+
+				/* No other transfers on the queue */
+				ep_queue_head_ptr->next_dtd_ptr =
+						(u32)check_dtd_ptr;
+				ep_queue_head_ptr->size_ioc_int_sts = 0;
+
+				/* Prime the Endpoint */
+				dev_ptr->regs.op_dev.ep_prime = bit_pos;
+			}
+		}
+	}
+
+done:
+	/* End CR 1015 */
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_cancel_transfer, SUCCESSFUL");
+#endif
+	return USB_OK;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/vusbhs_dev_deinit.c b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_deinit.c
new file mode 100644
index 0000000..686e569
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_deinit.c
@@ -0,0 +1,85 @@
+/*
+ * vusbhs_dev_deinit.c -- This file contains the VUSB_HS Device Controller
+ *			interface to de-initialize the endpoints.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_deinit_endpoint
+ * Returned Value : None
+ * Comments :
+ *	Disables the specified endpoint and the endpoint queue head
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_deinit_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	u32 bit_pos;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_deinit_endpoint");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Get the endpoint queue head address */
+	ep_queue_head_ptr = (struct vusb20_ep_queue_head *)
+		phys_to_virt(dev_ptr->regs.op_dev.ep_list_addr) +
+		2 * ep_num + direction;
+
+	bit_pos = 1 << (16 * direction + ep_num);
+
+	/* Check if the Endpoint is Primed */
+	if (!(dev_ptr->regs.op_dev.ep_prime & bit_pos) &&
+	    !(dev_ptr->regs.op_dev.ep_status & bit_pos)) {
+		/* Reset the max packet length and the interrupt on Setup */
+		ep_queue_head_ptr->max_pkt_length = 0;
+
+		/*
+		 * Disable the endpoint for Rx or Tx and reset the
+		 * endpoint type
+		 */
+		dev_ptr->regs.op_dev.ep_ctrlx[ep_num] &=
+			(direction ? ~EHCI_EPCTRL_TX_ENABLE :
+				~EHCI_EPCTRL_RX_ENABLE) |
+			(direction ? ~EHCI_EPCTRL_TX_TYPE :
+				~EHCI_EPCTRL_RX_TYPE);
+	} else {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_dci_vusb20_deinit_endpoint, "
+				"error deinit failed");
+#endif
+		return USBERR_EP_DEINIT_FAILED;
+	}
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_deinit_endpoint, SUCCESSFUL");
+#endif
+
+	return USB_OK;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/vusbhs_dev_main.c b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_main.c
new file mode 100644
index 0000000..aeb4e17
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_main.c
@@ -0,0 +1,1418 @@
+/*
+ * vusbhs_dev_main.c -- This file contains the main VUSB_HS Device Controller
+ *			interface functions.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/* in the OTG mode this need to be a global */
+struct usb_dev_state * usb_device_state_ptr;
+
+/* USB 1.1 Setup Packet */
+struct vusbhs_setup {
+	u8	request_type;
+	u8	request;
+	u16	value;
+	u16	index;
+	u16	length;
+};
+
+extern volatile bool in_isr;
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_init
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Initializes the USB device controller.
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_init(
+	u8 devnum,
+	_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20 * cap_dev_ptr;
+	u32 temp;
+	u32 total_memory = 0;
+	u8 * driver_memory;
+#ifdef CONFIG_DMA_NONCOHERENT
+	dma_addr_t dma_buff;
+#endif
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_init");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	cap_dev_ptr = (struct vusb20 *)
+			_bsp_get_usb_capability_register_base(devnum);
+
+	/* Get the base address of the VUSB_HS registers */
+	usb_dev_ptr->dev_ptr = (struct vusb20 *)((u32)cap_dev_ptr +
+			(cap_dev_ptr->regs.capab.caplength_hciver &
+			EHCI_CAP_LEN_MASK));
+
+	/*
+	 * Get the maximum number of endpoints supported by this
+	 * USB controller
+	 */
+	usb_dev_ptr->max_endpoints = cap_dev_ptr->regs.capab.dcc_params &
+			VUSB20_MAX_ENDPTS_SUPPORTED;
+
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	temp = usb_dev_ptr->max_endpoints * 2;
+
+	/****************************************************************
+	 * Consolidated memory allocation
+	 ****************************************************************/
+	total_memory = (temp * sizeof(struct vusb20_ep_queue_head) + 2048) +
+		(MAX_EP_TR_DESCRS * sizeof(struct vusb20_ep_tr) + 32) +
+		sizeof(struct scratch) * MAX_EP_TR_DESCRS;
+
+	driver_memory = (u8 *)kzalloc(total_memory, GFP_KERNEL);
+	if (driver_memory == NULL) {
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_dci_vusb20_init, malloc failed");
+#endif
+		return USBERR_ALLOC;
+	}
+
+#ifdef CONFIG_DMA_NONCOHERENT
+	/****************************************************************
+	 * Flush the zeroed memory if cache is enabled
+	 ****************************************************************/
+	dma_buff = dma_map_single(msp71xx_get_dev_ptr()->dev,
+				driver_memory, total_memory, DMA_TO_DEVICE);
+	dma_unmap_single(msp71xx_get_dev_ptr()->dev,
+			dma_buff, total_memory, DMA_NONE);
+#endif
+
+	driver_memory = UNCAC_ADDR(driver_memory);
+
+	/****************************************************************
+	 * Keep a pointer to driver memory alloctaion
+	 ****************************************************************/
+	usb_dev_ptr->driver_memory = driver_memory;
+
+	/****************************************************************
+	 * Assign QH base
+	 ****************************************************************/
+	usb_dev_ptr->ep_queue_head_base = (struct vusb20_ep_queue_head *)
+						driver_memory;
+	driver_memory += temp * sizeof(struct vusb20_ep_queue_head) + 2048;
+
+	/* Align the endpoint queue head to 2K boundary */
+	usb_dev_ptr->ep_queue_head_ptr = (struct vusb20_ep_queue_head *)
+		USB_MEM2048_ALIGN((u32)usb_dev_ptr->ep_queue_head_base);
+
+	/****************************************************************
+	 * Assign DTD base
+	 ****************************************************************/
+	usb_dev_ptr->dtd_base_ptr = (struct vusb20_ep_tr *)driver_memory;
+	driver_memory += MAX_EP_TR_DESCRS * sizeof(struct vusb20_ep_tr) + 32;
+
+	/* Align the dTD base to 32 byte boundary */
+	usb_dev_ptr->dtd_aligned_base_ptr = (struct vusb20_ep_tr *)
+			USB_MEM32_ALIGN((u32)usb_dev_ptr->dtd_base_ptr);
+
+	/****************************************************************
+	 * Assign scratch structure base
+	 ****************************************************************/
+	/* Allocate memory for internal scratch structure */
+	usb_dev_ptr->scratch_base = (struct scratch *)driver_memory;
+
+#ifndef __USB_OTG__
+	/* Install the interrupt service routine */
+	_bsp_install_isr(usb_dev_ptr->dev_vec, _usb_dci_vusb20_isr, NULL);
+#endif /* __USB_OTG__ */
+
+	usb_dev_ptr->usb_state = USB_STATE_UNKNOWN;
+
+	/* Initialize the VUSB_HS controller */
+	_usb_dci_vusb20_chip_initialize((void *)usb_dev_ptr);
+
+	usb_device_state_ptr = usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_init, SUCCESSFUL");
+#endif
+
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_chip_initialize
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Initializes the USB device controller.
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_chip_initialize(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20 * cap_dev_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	volatile struct vusb20_ep_tr * dtd_ptr;
+	u32 temp, i, port_control;
+	struct scratch * temp_scratch_ptr;
+	u32 status;
+	u32 otg_status;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_chip_initialize");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+	cap_dev_ptr = (struct vusb20 *)_bsp_get_usb_capability_register_base(
+							usb_dev_ptr->dev_num);
+
+	/* Stop the controller */
+	dev_ptr->regs.op_dev.usb_cmd &= ~EHCI_CMD_RUN_STOP;
+
+	/* Reset the controller to get default values */
+	dev_ptr->regs.op_dev.usb_cmd = EHCI_CMD_CTRL_RESET;
+
+	/* Wait for the controller reset to complete */
+	while (dev_ptr->regs.op_dev.usb_cmd & EHCI_CMD_CTRL_RESET);
+
+#ifdef TRIP_WIRE
+	/* Program the controller to be the USB device controller */
+	dev_ptr->regs.op_dev.usb_mode =
+		VUSBHS_MODE_CTRL_MODE_DEV | VUSBHS_MODE_SETUP_LOCK_DISABLE |
+		VUSBHS_MODE_BIG_ENDIAN | VUSBHS_MODE_STREAM_DISABLE;
+#else
+	/* Program the controller to be the USB device controller */
+	dev_ptr->regs.op_dev.usb_mode =
+		VUSBHS_MODE_CTRL_MODE_DEV | VUSBHS_MODE_BIG_ENDIAN |
+		VUSBHS_MODE_STREAM_DISABLE;
+#endif
+
+	status = dev_ptr->regs.op_dev.portscx[0];
+	status = status & ~EHCI_STS_SER_SELECT;
+	dev_ptr->regs.op_dev.portscx[0] = status;
+
+	temp = usb_dev_ptr->max_endpoints * 2;
+
+	/* Initialize the internal dTD head and tail to NULL */
+	usb_dev_ptr->dtd_head = NULL;
+	usb_dev_ptr->dtd_tail = NULL;
+
+	/* Make sure the 16 MSBs of this register are 0s */
+	dev_ptr->regs.op_dev.ep_setup_stat = 0;
+
+	ep_queue_head_ptr = usb_dev_ptr->ep_queue_head_ptr;
+
+	/* Initialize all device queue heads */
+	for (i = 0; i < temp; i++) {
+		/* Interrupt on Setup packet */
+		(ep_queue_head_ptr + i)->max_pkt_length =
+			(((u32)USB_MAX_CTRL_PAYLOAD <<
+			VUSB_EP_QUEUE_HEAD_MAX_PKT_LEN_POS) |
+			VUSB_EP_QUEUE_HEAD_IOS);
+		(ep_queue_head_ptr + i)->next_dtd_ptr =
+			VUSB_EP_QUEUE_HEAD_NEXT_TERMINATE;
+	}
+
+	/* Configure the Endpoint List Address */
+	dev_ptr->regs.op_dev.ep_list_addr = virt_to_phys(ep_queue_head_ptr);
+
+	if (cap_dev_ptr->regs.capab.hcs_params &
+	    VUSB20_HCS_PARAMS_PORT_POWER_CONTROL_FLAG) {
+		port_control = dev_ptr->regs.op_dev.portscx[0];
+		port_control &= ~EHCI_PORTSCX_W1C_BITS |
+				~EHCI_PORTSCX_PORT_POWER;
+		dev_ptr->regs.op_dev.portscx[0] = port_control;
+	}
+
+	dtd_ptr = usb_dev_ptr->dtd_aligned_base_ptr;
+
+	temp_scratch_ptr = usb_dev_ptr->scratch_base;
+
+	/* Enqueue all the dTDs */
+	for (i = 0; i < MAX_EP_TR_DESCRS; i++) {
+		dtd_ptr->scratch_ptr = temp_scratch_ptr;
+		dtd_ptr->scratch_ptr->free = _usb_dci_vusb20_free_dtd;
+		/* Set the dTD to be invalid */
+		dtd_ptr->next_tr_elem_ptr = VUSBHS_TD_NEXT_TERMINATE;
+		/* Set the Reserved fields to 0 */
+		dtd_ptr->size_ioc_sts &= ~VUSBHS_TD_RESERVED_FIELDS;
+		dtd_ptr->scratch_ptr->private = (void *)usb_dev_ptr;
+		_usb_dci_vusb20_free_dtd((void *)dtd_ptr);
+		dtd_ptr++;
+		temp_scratch_ptr++;
+	}
+
+	/* Initialize the endpoint 0 properties */
+	dev_ptr->regs.op_dev.ep_ctrlx[0] = EHCI_EPCTRL_TX_DATA_TOGGLE_RST |
+		EHCI_EPCTRL_RX_DATA_TOGGLE_RST;
+	dev_ptr->regs.op_dev.ep_ctrlx[0] &=
+		~(EHCI_EPCTRL_TX_EP_STALL | EHCI_EPCTRL_RX_EP_STALL);
+
+	/* Enable OTG interrupts */
+	dev_ptr->regs.op_dev.otgsc = VUSBHS_OTGSC_AVVIE;
+
+	/* Enable USB interrupts */
+	dev_ptr->regs.op_dev.usb_intr = EHCI_INTR_INT_EN |
+		EHCI_INTR_ERR_INT_EN | EHCI_INTR_PORT_CHANGE_DETECT_EN |
+		EHCI_INTR_RESET_EN | EHCI_INTR_DEVICE_SUSPEND;
+
+	/* USB state */
+	usb_dev_ptr->usb_state = USB_STATE_UNKNOWN;
+
+	/* Set device state to be self powered and remote wakeup */
+	usb_dev_ptr->usb_dev_state = USB_SELF_POWERED;
+
+	/* get OTGSC status */
+	otg_status = dev_ptr->regs.op_dev.otgsc;
+	if (otg_status & VUSBHS_OTGSC_AVV) {
+		dev_ptr->regs.op_dev.usb_cmd = EHCI_CMD_RUN_STOP;
+	} else {
+		/* Stop the controller */
+		dev_ptr->regs.op_dev.usb_cmd &= ~EHCI_CMD_RUN_STOP;
+	}
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_chip_initialize, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_free_dtd
+ * Returned Value : void
+ * Comments :
+ *	Enqueues a dTD onto the free DTD ring.
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_free_dtd(void * dtd_ptr)
+{
+	struct usb_dev_state * usb_dev_ptr = (struct usb_dev_state *)
+		((struct vusb20_ep_tr *)dtd_ptr)->scratch_ptr->private;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_free_dtd");
+#endif
+
+	/*
+	 * This function can be called from any context, and it needs mutual
+	 * exclusion with itself.
+	 */
+	spin_lock(&usb_dev_ptr->lock);
+
+	/*
+	 * Add the dTD to the free dTD queue (linked via private) and
+	 * increment the tail to the next descriptor
+	 */
+	EHCI_DTD_QADD(usb_dev_ptr->dtd_head, usb_dev_ptr->dtd_tail,
+			(struct vusb20_ep_tr *)dtd_ptr);
+	usb_dev_ptr->dtd_entries++;
+
+	spin_unlock(&usb_dev_ptr->lock);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_free_dtd, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_add_dtd
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Adds a device transfer desriptor(s) to the queue.
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_add_dtd(
+	_usb_device_handle handle,
+	struct xd * xd_ptr)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_tr * dtd_ptr, * temp_dtd_ptr,
+						* first_dtd_ptr = NULL;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	u32 curr_pkt_len, remaining_len;
+	u32 curr_offset, temp, bit_pos;
+
+	/*********************************************************************
+	 * For a optimal implementation, we need to detect the fact that
+	 * we are adding DTD to an empty list. If list is empty, we can
+	 * actually skip several programming steps esp. those for ensuring
+	 * that there is no race condition.The following boolean will be
+	 * useful in skipping some code here.
+	 ********************************************************************/
+	bool list_empty = false;
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_add_dtd");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	remaining_len = xd_ptr->wtotallength;
+
+	curr_offset = 0;
+	temp = 2 * xd_ptr->ep_num + xd_ptr->bdirection;
+	bit_pos = 1 << (16 * xd_ptr->bdirection + xd_ptr->ep_num);
+
+	ep_queue_head_ptr = (struct vusb20_ep_queue_head *)phys_to_virt(
+				dev_ptr->regs.op_dev.ep_list_addr) + temp;
+
+	/*********************************************************************
+	 * This loops iterates through the length of the transfer and divides
+	 * the data in to DTDs each handling the a max of 0x4000 bytes of
+	 * data.
+	 * The first DTD in the list is stored in a pointer called
+	 * first_dtd_ptr. This pointer is later linked in to QH for processing
+	 * by the hardware.
+	 ********************************************************************/
+
+	do {
+		/* Check if we need to split the transfer into multiple dTDs */
+		if (remaining_len > VUSB_EP_MAX_LENGTH_TRANSFER)
+			curr_pkt_len = VUSB_EP_MAX_LENGTH_TRANSFER;
+		else
+			curr_pkt_len = remaining_len;
+
+		remaining_len -= curr_pkt_len;
+
+		/* Get a dTD from the queue */
+		EHCI_DTD_QGET(usb_dev_ptr->dtd_head,
+				usb_dev_ptr->dtd_tail, dtd_ptr);
+
+		if (!dtd_ptr) {
+#ifdef _DEVICE_DEBUG_
+			DEBUG_LOG_TRACE("_usb_dci_vusb20_add_dtd, SUCCESSFUL");
+#endif
+			return USBERR_TR_FAILED;
+		}
+
+		usb_dev_ptr->dtd_entries--;
+
+		if (curr_offset == 0)
+			first_dtd_ptr = dtd_ptr;
+
+#ifdef CONFIG_DMA_NONCOHERENT
+		/************************************************************
+		 * memset does not bypass the cache and hence we must
+		 * use DTD pointer to update the memory and bypass the cache.
+		 * If your DTD are allocated from an uncached regigio, you
+		 * can eliminitate this approach and switch back to
+		 * memset.
+		 ***********************************************************/
+		dtd_ptr->next_tr_elem_ptr = 0;
+		dtd_ptr->size_ioc_sts = 0;
+		dtd_ptr->buff_ptr0 = 0;
+		dtd_ptr->buff_ptr1 = 0;
+		dtd_ptr->buff_ptr2 = 0;
+		dtd_ptr->buff_ptr3 = 0;
+		dtd_ptr->buff_ptr4 = 0;
+#else
+		/*
+		 * Zero the dTD. Leave the last 4 bytes as that is
+		 * the scratch pointer
+		 */
+		memset((void *)dtd_ptr, 0, sizeof(struct vusb20_ep_tr) - 4);
+#endif
+
+		/* Initialize the dTD */
+		dtd_ptr->scratch_ptr->private = handle;
+
+		/* Set the Terminate bit */
+		dtd_ptr->next_tr_elem_ptr = VUSB_EP_QUEUE_HEAD_NEXT_TERMINATE;
+
+
+		/************************************************************
+		 * TODO: For hig-speed and high-bandwidth ISO IN endpoints,
+		 * we must initialize the multiplied field so that Host can
+		 * issues multiple IN transactions on the endpoint. See the
+		 * DTD data structure for MultiIO field.
+		 *
+		 * S Garg 11/06/2003
+		 ***********************************************************/
+
+		/* Fill in the transfer size */
+		if (!remaining_len)
+			dtd_ptr->size_ioc_sts =
+				((curr_pkt_len << VUSBHS_TD_LENGTH_BIT_POS) |
+				VUSBHS_TD_IOC | VUSBHS_TD_STATUS_ACTIVE);
+		else
+			dtd_ptr->size_ioc_sts =
+				((curr_pkt_len << VUSBHS_TD_LENGTH_BIT_POS) |
+				VUSBHS_TD_STATUS_ACTIVE);
+
+		/* Set the reserved field to 0 */
+		dtd_ptr->size_ioc_sts &= ~VUSBHS_TD_RESERVED_FIELDS;
+
+		/* 4K apart buffer page pointers */
+		dtd_ptr->buff_ptr0 = virt_to_phys(xd_ptr->wstartaddress) +
+					curr_offset;
+		dtd_ptr->buff_ptr1 = dtd_ptr->buff_ptr0 + 4096;
+		dtd_ptr->buff_ptr2 = dtd_ptr->buff_ptr1 + 4096;
+		dtd_ptr->buff_ptr3 = dtd_ptr->buff_ptr2 + 4096;
+		dtd_ptr->buff_ptr4 = dtd_ptr->buff_ptr3 + 4096;
+
+		curr_offset += curr_pkt_len;
+
+		/*
+		 * Maintain the first and last device transfer descriptor per
+		 * endpoint and direction.
+		 */
+		if (!usb_dev_ptr->ep_dtd_heads[temp]) {
+			usb_dev_ptr->ep_dtd_heads[temp] = dtd_ptr;
+			/***********************************************
+			 * If list does not have a head, it means that
+			 * list is empty. An empty condition is detected.
+			 ***********************************************/
+			list_empty = true;
+		}
+
+		/*
+		 * Check if the transfer is to be queued at the end or
+		 * beginning
+		 */
+		temp_dtd_ptr = usb_dev_ptr->ep_dtd_tails[temp];
+
+		/* Remember which XD to use for this dTD */
+		dtd_ptr->scratch_ptr->xd_for_this_dtd = (void *)xd_ptr;
+
+		/* New tail */
+		usb_dev_ptr->ep_dtd_tails[temp] = dtd_ptr;
+		if (temp_dtd_ptr) {
+			/*
+			 * Should not do |=. The Terminate bit should
+			 * be zero
+			 */
+			temp_dtd_ptr->next_tr_elem_ptr = virt_to_phys(dtd_ptr);
+		}
+	} while (remaining_len);
+
+	/**************************************************************
+	* In the loop above DTD has already been added to the list
+	* However endpoint has not been primed yet. If list is not
+	* empty we need safter ways to add DTD to the existing list.
+	* Else we just skip to adding DTD to QH safely.
+	**************************************************************/
+
+	if (!list_empty) {
+#ifdef TRIP_WIRE
+		/*********************************************************
+		 * Hardware v3.2+ require the use of semaphore to ensure
+		 * that QH is safely updated.
+		 *********************************************************/
+
+		/*********************************************************
+		 * Check the prime bit. If set goto done
+		 *********************************************************/
+		if (dev_ptr->regs.op_dev.ep_prime & bit_pos)
+			goto done;
+
+		bool read_safe = false;
+		while (!read_safe) {
+			/****************************************************
+			 * start with setting the semaphores
+			 ***************************************************/
+			dev_ptr->regs.op_dev.usb_cmd |=
+					EHCI_CMD_ATDTW_TRIPWIRE_SET;
+
+			/****************************************************
+			 * Read the endpoint status
+			 ***************************************************/
+			if (dev_ptr->regs.op_dev.ep_status & bit_pos)
+				read_safe = true;
+		}
+
+		/*********************************************************
+		 * Clear the semaphore
+		 *********************************************************/
+		dev_ptr->regs.op_dev.usb_cmd &=
+					EHCI_CMD_ATDTW_TRIPWIRE_CLEAR;
+
+#else /* workaround old method */
+
+		/* Start CR 1015 */
+		/* Prime the Endpoint */
+		dev_ptr->regs.op_dev.ep_prime = bit_pos;
+
+		/* old workaround will be compiled */
+		if (!(dev_ptr->regs.op_dev.ep_status & bit_pos)) {
+			/* Wait for the ep_prime to go to zero */
+			while (dev_ptr->regs.op_dev.ep_prime & bit_pos);
+
+			if (dev_ptr->regs.op_dev.ep_status & bit_pos) {
+				/*
+				 * The endpoint was not primed so no
+				 * other transfers on the queue.
+				 */
+				printk(KERN_ERR "1 prime ERR %8x\r\n",
+					(int)bit_pos);
+				goto done;
+			}
+		} else {
+			printk(KERN_ERR "2  prime ERR %8x\r\n", (int)bit_pos);
+			goto done;
+		}
+
+		/* No other transfers on the queue */
+		ep_queue_head_ptr->next_dtd_ptr = virt_to_phys(first_dtd_ptr);
+		ep_queue_head_ptr->size_ioc_int_sts = 0;
+
+		/* Prime the Endpoint */
+		dev_ptr->regs.op_dev.ep_prime = bit_pos;
+#endif
+	} else {
+		/* No other transfers on the queue */
+		ep_queue_head_ptr->next_dtd_ptr = virt_to_phys(first_dtd_ptr);
+		ep_queue_head_ptr->size_ioc_int_sts = 0;
+
+		/* Prime the Endpoint */
+		dev_ptr->regs.op_dev.ep_prime = bit_pos;
+	}
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_add_dtd, SUCCESSFUL");
+#endif
+
+done:
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_add_dtd, SUCCESSFUL");
+#endif
+	/* End CR 1015 */
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_send_data
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Sends data by adding and executing the dTD. Non-blocking.
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_send_data(
+	_usb_device_handle handle,
+	struct xd * xd_ptr)
+{
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_send_data, SUCCESSFUL");
+#endif
+
+	/* Add and execute the device transfer descriptor */
+	return _usb_dci_vusb20_add_dtd(handle, xd_ptr);
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_recv_data
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Receives data by adding and executing the dTD. Non-blocking.
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_recv_data(
+	_usb_device_handle handle,
+	struct xd * xd_ptr)
+{
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_recv_data, SUCCESSFUL");
+#endif
+
+	/* Add and execute the device transfer descriptor */
+	return _usb_dci_vusb20_add_dtd(handle, xd_ptr);
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_process_tr_complete
+ * Returned Value : None
+ * Comments :
+ *	Services transaction complete interrupt
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_process_tr_complete(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_tr * dtd_ptr;
+	volatile struct vusb20_ep_tr * temp_dtd_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	u32 temp, i, ep_num, direction, bit_pos;
+	u32 remaining_length = 0;
+	u32 actual_transfer_length = 0;
+	u32 errors = 0;
+	struct xd * xd_ptr;
+	struct xd * temp_xd_ptr = NULL;
+	u8 * buff_start_address = NULL;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_tr_complete");
+#endif
+
+	/*
+	 * We use separate loops for ep_setup_stat and ep_complete because the
+	 * setup packets are to be read ASAP.
+	 */
+
+	/* Process all Setup packet received interrupts */
+	bit_pos = dev_ptr->regs.op_dev.ep_setup_stat;
+	if (bit_pos) {
+		for (i = 0; i < 16; i++) {
+			if (bit_pos & (1 << i))
+				_usb_device_call_service(
+					handle, i, true, 0, 0, 8, 0);
+		}
+	}
+
+	/*
+	 * Don't clear the endpoint setup status register here. It is
+	 * cleared as a setup packet is read out of the buffer.
+	 */
+
+	/* Process non-setup transaction complete interrupts */
+	bit_pos = dev_ptr->regs.op_dev.ep_complete;
+
+	/* Clear the bits in the register */
+	dev_ptr->regs.op_dev.ep_complete = bit_pos;
+	if (bit_pos) {
+		/* Get the endpoint number and the direction of transfer */
+		for (i = 0; i < 32; i++) {
+			if (bit_pos & (1 << i)) {
+				if (i > 15) {
+					ep_num = (i - 16);
+					direction = 1;
+				} else {
+					ep_num = i;
+					direction = 0;
+				}
+
+				temp = 2 * ep_num + direction;
+
+				/* Get the first dTD */
+				dtd_ptr = usb_dev_ptr->ep_dtd_heads[temp];
+
+				ep_queue_head_ptr =
+					(struct vusb20_ep_queue_head *)
+					phys_to_virt(
+					dev_ptr->regs.op_dev.ep_list_addr) +
+					temp;
+
+				/*
+				 * Process all the dTDs for respective
+				 * transfers
+				 */
+				while (dtd_ptr &&
+					((u32)dtd_ptr & 0x1ffffffe)) {
+					if (dtd_ptr->size_ioc_sts &
+					    VUSBHS_TD_STATUS_ACTIVE) {
+						/*
+						 * No more dTDs to process.
+						 * Next one is owned by VUSB.
+						 */
+						break;
+					}
+
+					/*
+					 * Get the correct internal transfer
+					 * descriptor
+					 */
+					xd_ptr = (struct xd *)dtd_ptr->
+						scratch_ptr->xd_for_this_dtd;
+					if (xd_ptr) {
+						buff_start_address =
+							xd_ptr->wstartaddress;
+						actual_transfer_length =
+							xd_ptr->wtotallength;
+						temp_xd_ptr = xd_ptr;
+					}
+
+					/* Get the address of the next dTD */
+					temp_dtd_ptr = (struct vusb20_ep_tr *)
+						((u32)phys_to_virt(
+						dtd_ptr->next_tr_elem_ptr) &
+						VUSBHS_TD_ADDR_MASK);
+
+					/* Read the errors */
+					errors = dtd_ptr->size_ioc_sts &
+						VUSBHS_TD_ERROR_MASK;
+					if (!errors) {
+						/*
+						 * No errors.
+						 * Get the length of transfer
+						 *  from the current dTD.
+						 */
+						remaining_length += (dtd_ptr->
+							size_ioc_sts &
+							VUSB_EP_TR_PACKET_SIZE)
+							>> 16;
+						actual_transfer_length -=
+							remaining_length;
+					} else  if (errors &
+						    VUSBHS_TD_STATUS_HALTED) {
+						/*
+						 * Clear the errors and
+						 * Halt condition.
+						 */
+						ep_queue_head_ptr->
+							size_ioc_int_sts &=
+							~errors;
+					}
+
+					/* Retire the processed dTD */
+					_usb_dci_vusb20_cancel_transfer(
+						handle, ep_num, direction);
+					if (!(temp_dtd_ptr &&
+					    ((u32)temp_dtd_ptr &
+					    0x1ffffffe))) {
+						/*
+						 * Transfer complete. Call the
+						 * register service function
+						 * for the endpoint.
+						 */
+						_usb_device_call_service(
+							handle, ep_num,
+							false, direction,
+							buff_start_address,
+							actual_transfer_length,
+							errors);
+					} else  if ((u32)temp_dtd_ptr->
+						    scratch_ptr->
+						    xd_for_this_dtd !=
+						    (u32)temp_xd_ptr) {
+						/*
+						 * Transfer complete.
+						 * Call the register
+						 * service function
+						 * for the endpoint.
+						 */
+						_usb_device_call_service(
+							handle, ep_num,
+							false, direction,
+							buff_start_address,
+							actual_transfer_length,
+							errors);
+						remaining_length = 0;
+					}
+					dtd_ptr = temp_dtd_ptr;
+					errors = 0;
+				}
+			}
+		}
+	}
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_tr_complete, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_isr
+ * Returned Value : None
+ * Comments :
+ *	Services all the VUSB_HS interrupt sources
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_isr(void)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	u32 otg_status;
+	u32 run_status;
+	u32 status;
+	u32 int_ena;
+
+	usb_dev_ptr = (struct usb_dev_state *)usb_device_state_ptr;
+#ifndef __USB_OTG__
+	in_isr = true;
+#endif
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_isr");
+#endif
+
+	/* get interrupt enables */
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+	int_ena = dev_ptr->regs.op_dev.usb_intr;
+
+	/* clear USB interrupts */
+	dev_ptr->regs.op_dev.usb_intr = 0;
+
+	/* get OTGSC status */
+	otg_status = dev_ptr->regs.op_dev.otgsc;
+
+	/* clear OTGSC interrupts */
+	dev_ptr->regs.op_dev.otgsc &= VUSBHS_OTGSC_AVVIS;
+
+	if (otg_status & VUSBHS_OTGSC_AVV) {
+		/* Set the Run bit in the command register if stopped */
+		run_status = dev_ptr->regs.op_dev.usb_cmd & EHCI_CMD_RUN_STOP;
+		if (!run_status)
+			dev_ptr->regs.op_dev.usb_cmd = EHCI_CMD_RUN_STOP;
+	} else {
+		/* Stop the controller */
+		dev_ptr->regs.op_dev.usb_cmd &= ~EHCI_CMD_RUN_STOP;
+	}
+	for (;;) {
+		status = dev_ptr->regs.op_dev.usb_sts;
+		if (!(status & int_ena))
+			break;
+
+		/* Clear all the interrupts occured */
+		dev_ptr->regs.op_dev.usb_sts = status;
+
+		if (status & EHCI_STS_RESET & int_ena)
+			_usb_dci_vusb20_process_reset((void *)usb_dev_ptr);
+
+		if (status & EHCI_STS_PORT_CHANGE & int_ena)
+			_usb_dci_vusb20_process_port_change(
+						(void *)usb_dev_ptr);
+
+		if (status & EHCI_STS_ERR & int_ena)
+			_usb_dci_vusb20_process_error((void *)usb_dev_ptr);
+
+		if (status & EHCI_STS_SOF & int_ena)
+			_usb_dci_vusb20_process_SOF((void *)usb_dev_ptr);
+
+		if (status & EHCI_STS_INT & int_ena)
+			_usb_dci_vusb20_process_tr_complete(
+						(void *)usb_dev_ptr);
+
+		if (status & EHCI_STS_SUSPEND & int_ena) {
+			_usb_dci_vusb20_process_suspend((void *)usb_dev_ptr);
+			dev_ptr->regs.op_dev.usb_intr = int_ena;
+			return;
+		}
+	}
+	dev_ptr->regs.op_dev.usb_intr = int_ena;
+
+#ifndef __USB_OTG__
+	in_isr = false;
+#endif
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_isr, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_process_reset
+ * Returned Value : None
+ * Comments :
+ *	Services reset interrupt
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_process_reset(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	u32 temp;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_reset");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/*
+	 * Inform the application so that it can cancel all
+	 * previously queued transfers
+	 */
+	_usb_device_call_service(usb_dev_ptr, USB_SERVICE_BUS_RESET,
+					0, 0, 0, 0, 0);
+
+	/* The address bits are past bit 25-31. Set the address */
+	dev_ptr->regs.op_dev.device_addr &= ~0xFE000000;
+
+	/* Clear all the setup token semaphores */
+	temp = dev_ptr->regs.op_dev.ep_setup_stat;
+	dev_ptr->regs.op_dev.ep_setup_stat = temp;
+
+	/* Clear all the endpoint complete status bits */
+	temp = dev_ptr->regs.op_dev.ep_complete;
+	dev_ptr->regs.op_dev.ep_complete = temp;
+
+	/* Wait until all ep_prime bits cleared */
+	while (dev_ptr->regs.op_dev.ep_prime & 0xFFFFFFFF);
+
+	/* Write 1s to the Flush register */
+	dev_ptr->regs.op_dev.ep_flush = 0xFFFFFFFF;
+
+	if (dev_ptr->regs.op_dev.portscx[0] & EHCI_PORTSCX_PORT_RESET) {
+		usb_dev_ptr->bus_resetting = true;
+		usb_dev_ptr->usb_state = USB_STATE_POWERED;
+	} else {
+		/* re-initialize */
+		_usb_dci_vusb20_chip_initialize((void *)usb_dev_ptr);
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE(
+			"_usb_dci_vusb20_process_reset, SUCCESSFUL reinit hw");
+#endif
+		return;
+	}
+
+	_usb_device_call_service(usb_dev_ptr, USB_SERVICE_BUS_RESET,
+				0, 0, 0, 0, 0);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_reset, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_process_suspend
+ * Returned Value : None
+ * Comments :
+ *	Services suspend interrupt
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_process_suspend(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_suspend");
+#endif
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	usb_dev_ptr->usb_dev_state_b4_suspend = usb_dev_ptr->usb_state;
+
+	usb_dev_ptr->usb_state = USB_STATE_SUSPEND;
+
+	/* Inform the upper layers */
+	_usb_device_call_service(usb_dev_ptr, USB_SERVICE_SLEEP,
+				0, 0, 0, 0, 0);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_suspend, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_process_SOF
+ * Returned Value : None
+ * Comments :
+ *	Services SOF interrupt
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_process_SOF(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_SOF");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Inform the upper layer */
+	_usb_device_call_service(usb_dev_ptr, USB_SERVICE_SOF, 0, 0, 0,
+				dev_ptr->regs.op_dev.usb_frindex, 0);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_SOF, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_process_port_change
+ * Returned Value : None
+ * Comments :
+ *	Services port change detect interrupt
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_process_port_change(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_port_change");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	if (usb_dev_ptr->bus_resetting) {
+		/* Bus reset operation complete */
+		usb_dev_ptr->bus_resetting = false;
+	}
+
+	if (!(dev_ptr->regs.op_dev.portscx[0] & EHCI_PORTSCX_PORT_RESET)) {
+		/* Get the speed */
+		if (dev_ptr->regs.op_dev.portscx[0] &
+		    EHCI_PORTSCX_PORT_HIGH_SPEED)
+			usb_dev_ptr->dev_speed = USB_DEV_SPEED_HIGH;
+		else
+			usb_dev_ptr->dev_speed = USB_DEV_SPEED_FULL;
+
+		/* Inform the upper layers of the speed of operation */
+		_usb_device_call_service(usb_dev_ptr,
+					USB_SERVICE_SPEED_DETECTION,
+					0, 0, 0, usb_dev_ptr->dev_speed, 0);
+	}
+
+	if (dev_ptr->regs.op_dev.portscx[0] & EHCI_PORTSCX_PORT_SUSPEND) {
+		usb_dev_ptr->usb_dev_state_b4_suspend = usb_dev_ptr->usb_state;
+		usb_dev_ptr->usb_state = USB_STATE_SUSPEND;
+
+		/* Inform the upper layers */
+		_usb_device_call_service(usb_dev_ptr, USB_SERVICE_SUSPEND,
+					0, 0, 0, 0, 0);
+	}
+
+	if (!(dev_ptr->regs.op_dev.portscx[0] & EHCI_PORTSCX_PORT_SUSPEND) &&
+	    (usb_dev_ptr->usb_state == USB_STATE_SUSPEND)) {
+		usb_dev_ptr->usb_state = usb_dev_ptr->usb_dev_state_b4_suspend;
+		/* Inform the upper layers */
+		_usb_device_call_service(usb_dev_ptr, USB_SERVICE_RESUME,
+					0, 0, 0, 0, 0);
+
+#ifdef _DEVICE_DEBUG_
+		DEBUG_LOG_TRACE("_usb_dci_vusb20_process_port_change, "
+				"SUCCESSFUL, resumed");
+#endif
+		return;
+	}
+
+	usb_dev_ptr->usb_state = USB_STATE_DEFAULT;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_port_change, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_process_error
+ * Returned Value : None
+ * Comments :
+ *	Services error interrupt
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_process_error(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_error");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/* Increment the error count */
+	usb_dev_ptr->errors++;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_process_error, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_set_address
+ * Returned Value : None
+ * Comments :
+ *	Sets the newly assigned device address
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_set_address(
+	_usb_device_handle handle,
+	u8 address)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_set_address");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* The address bits are past bit 25-31. Set the address */
+	dev_ptr->regs.op_dev.device_addr =
+		(u32)address << VUSBHS_ADDRESS_BIT_SHIFT;
+
+	usb_dev_ptr->usb_state = USB_STATE_ADDRESS;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_set_address, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_get_setup_data
+ * Returned Value : None
+ * Comments :
+ *	Reads the Setup data from the 8-byte setup buffer
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_get_setup_data(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 * buffer_ptr)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	u32 temp;
+	struct vusbhs_setup * setup_ptr;
+#ifdef CONFIG_DMA_NONCOHERENT
+	int i;
+#endif
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_get_setup_data");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Get the endpoint queue head */
+	ep_queue_head_ptr = (struct vusb20_ep_queue_head *)phys_to_virt(
+				dev_ptr->regs.op_dev.ep_list_addr) +
+				2 * ep_num + USB_RECV;
+
+	/********************************************************************
+	 * CR 1219. Hardware versions 2.3+ have a implementation of tripwire
+	 * semaphore mechanism that requires that we read the contents of
+	 * QH safely by using the semaphore. Read the USBHS document to under
+	 * stand how the code uses the semaphore mechanism. The following are
+	 * the steps in brief
+	 *
+	 * 1. USBCMD Write 1 to Setup Tripwire in register.
+	 * 2. Duplicate contents of dQH.StatusBuffer into local software byte
+	 * array.
+	 * 3. Read Setup TripWire in register. (if set - continue; if
+	 * cleared goto 1.)
+	 * 4. Write '0' to clear Setup Tripwire in register.
+	 * 5. Process setup packet using local software byte array copy and
+	 * execute status/handshake phases.
+	 *******************************************************************/
+#ifdef TRIP_WIRE
+	/* If semaphore mechanism is used the following code is compiled in */
+	bool read_safe = false;
+	while (!read_safe) {
+		/*********************************************************
+		 * start with setting the semaphores
+		 *********************************************************/
+		dev_ptr->regs.op_dev.usb_cmd |= EHCI_CMD_SETUP_TRIPWIRE_SET;
+
+		/*********************************************************
+		 * Duplicate the contents of SETUP buffer to our buffer
+		 *********************************************************/
+#ifdef CONFIG_DMA_NONCOHERENT
+		for (i = 0; i < 8; i++)
+			*(buffer_ptr + i) = ep_queue_head_ptr->setup_buffer[i];
+#else
+		/* Copy the setup packet to private buffer */
+		memcpy(buffer_ptr, (u8 *)ep_queue_head_ptr->setup_buffer, 8);
+#endif
+		/*********************************************************
+		 * If setup tripwire semaphore is cleared by hardware it
+		 * means that we have a danger and we need to restart.
+		 * else we can exit out of loop safely.
+		 *********************************************************/
+		if (dev_ptr->regs.op_dev.usb_cmd &
+		    EHCI_CMD_SETUP_TRIPWIRE_SET) {
+			/* we can proceed exiting out of loop */
+			read_safe = true;
+		}
+	}
+
+	/*********************************************************
+	 * Clear the semaphore bit now
+	 *********************************************************/
+	dev_ptr->regs.op_dev.usb_cmd &= EHCI_CMD_SETUP_TRIPWIRE_CLEAR;
+
+#else
+	/* when semaphore is not used */
+#ifdef CONFIG_DMA_NONCOHERENT
+	for (i = 0; i < 8; i++)
+		*(buffer_ptr + i) = ep_queue_head_ptr->setup_buffer[i];
+#else
+	/* Copy the setup packet to private buffer */
+	memcpy(buffer_ptr, (u8 *)ep_queue_head_ptr->setup_buffer, 8);
+#endif
+#endif
+
+	/* Clear the bit in the ep_setup_stat */
+	dev_ptr->regs.op_dev.ep_setup_stat = 1 << ep_num;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_get_setup_data, SUCCESSFUL");
+#endif
+	setup_ptr = (struct vusbhs_setup *)buffer_ptr;
+	temp = USB_SWAP(*((u32 *)buffer_ptr));
+	*(u32 *)buffer_ptr = temp;
+	buffer_ptr += 4;
+	temp = USB_SWAP(*((u32 *)buffer_ptr));
+	*(u32 *)buffer_ptr = temp;
+	setup_ptr->value = USB_WORD_SWAP(setup_ptr->value);
+	setup_ptr->length = USB_WORD_SWAP(setup_ptr->length);
+	setup_ptr->index = USB_WORD_SWAP(setup_ptr->index);
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_init_endpoint
+ * Returned Value : None
+ * Comments :
+ *	Initializes the specified endpoint and the endpoint queue head
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_init_endpoint(
+	_usb_device_handle handle,
+	struct xd * xd_ptr)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+	u32 bit_pos;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_init_endpoint");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Get the endpoint queue head address */
+	ep_queue_head_ptr = (struct vusb20_ep_queue_head *)phys_to_virt(
+				dev_ptr->regs.op_dev.ep_list_addr) +
+				2 * xd_ptr->ep_num + xd_ptr->bdirection;
+
+	bit_pos = 1 << (16 * xd_ptr->bdirection + xd_ptr->ep_num);
+
+	/* Check if the Endpoint is Primed */
+	if (!(dev_ptr->regs.op_dev.ep_prime & bit_pos) &&
+	    !(dev_ptr->regs.op_dev.ep_status & bit_pos)) {
+		/*
+		 * Set the max packet length, interrupt on Setup and
+		 * Mult fields
+		 */
+		if (xd_ptr->ep_type == USB_ISOCHRONOUS_ENDPOINT) {
+			/* Mult bit should be set for isochronous endpoints */
+			ep_queue_head_ptr->max_pkt_length =
+				(xd_ptr->wmaxpacketsize << 16) |
+				((xd_ptr->max_pkts_per_uframe ?
+				xd_ptr->max_pkts_per_uframe : 1) <<
+				VUSB_EP_QUEUE_HEAD_MULT_POS);
+		} else {
+			if (xd_ptr->ep_type != USB_CONTROL_ENDPOINT) {
+				ep_queue_head_ptr->max_pkt_length =
+					(xd_ptr->wmaxpacketsize << 16) |
+					(xd_ptr->dont_zero_terminate ?
+					VUSB_EP_QUEUE_HEAD_ZERO_LEN_TER_SEL :
+					0);
+			} else {
+				ep_queue_head_ptr->max_pkt_length =
+					(xd_ptr->wmaxpacketsize << 16) |
+					VUSB_EP_QUEUE_HEAD_IOS;
+			}
+		}
+
+		/*
+		 * Enable the endpoint for Rx and Tx and set the
+		 * endpoint type
+		 */
+		dev_ptr->regs.op_dev.ep_ctrlx[xd_ptr->ep_num] |=
+			(xd_ptr->bdirection ?
+				(EHCI_EPCTRL_TX_ENABLE |
+				EHCI_EPCTRL_TX_DATA_TOGGLE_RST) :
+				(EHCI_EPCTRL_RX_ENABLE |
+				EHCI_EPCTRL_RX_DATA_TOGGLE_RST)) |
+				(xd_ptr->ep_type << (xd_ptr->bdirection ?
+				EHCI_EPCTRL_TX_EP_TYPE_SHIFT :
+				EHCI_EPCTRL_RX_EP_TYPE_SHIFT));
+		} else {
+#ifdef _DEVICE_DEBUG_
+			DEBUG_LOG_TRACE("_usb_dci_vusb20_init_endpoint, "
+				"error ep init");
+#endif
+			return USBERR_EP_INIT_FAILED;
+		}
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_init_endpoint, SUCCESSFUL");
+#endif
+
+	return USB_OK;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_get_transfer_status
+ * Returned Value : USB_OK or error code
+ * Comments :
+ *	Gets the status of a transfer
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_get_transfer_status(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20_ep_tr * dtd_ptr;
+	struct xd * xd_ptr;
+	u8 status;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_get_transfer_status");
+#endif
+
+	/* Unlink the dTD */
+	dtd_ptr = usb_dev_ptr->ep_dtd_heads[2 * ep_num + direction];
+	if (dtd_ptr) {
+		/* Get the transfer descriptor for the dTD */
+		xd_ptr = (struct xd *)dtd_ptr->scratch_ptr->xd_for_this_dtd;
+		status = xd_ptr->bstatus;
+	} else
+		status = USB_STATUS_IDLE;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_get_transfer_status, SUCCESSFUL");
+#endif
+
+	return status;
+}
diff --git a/drivers/usb/gadget/pmc-sierra/vusbhs_dev_shut.c b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_shut.c
new file mode 100644
index 0000000..80509bb
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_shut.c
@@ -0,0 +1,73 @@
+/*
+ * vusbhs_dev_shut.c -- This file contains the VUSB_HS Device Controller
+ * 			interface function to shutdown the device.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_shutdown
+ * Returned Value : None
+ * Comments :
+ *	Shuts down the VUSB_HS Device
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_shutdown(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_shutdown");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Disable interrupts */
+	dev_ptr->regs.op_dev.usb_intr &=
+		~(EHCI_INTR_INT_EN | EHCI_INTR_ERR_INT_EN |
+		EHCI_INTR_PORT_CHANGE_DETECT_EN | EHCI_INTR_RESET_EN);
+
+	/* Reset the Run the bit in the command register to stop VUSB */
+	dev_ptr->regs.op_dev.usb_cmd &= ~EHCI_CMD_RUN_STOP;
+
+	/* Reset the controller to get default values */
+	dev_ptr->regs.op_dev.usb_cmd = EHCI_CMD_CTRL_RESET;
+
+	kfree((void *)usb_dev_ptr->driver_memory);
+
+#if 0
+	/* Free all the Endpoint Queue Heads */
+	kfree((void *)usb_dev_ptr->ep_queue_head_base);
+
+	/* Free all dTDs */
+	kfree((void *)usb_dev_ptr->dtd_base_ptr);
+
+	/* Free scratch structures */
+	kfree((void *)usb_dev_ptr->scratch_base);
+#endif
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_shutdown, SUCCESSFUL");
+#endif
+}
diff --git a/drivers/usb/gadget/pmc-sierra/vusbhs_dev_utl.c b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_utl.c
new file mode 100644
index 0000000..c8be2d7
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/vusbhs_dev_utl.c
@@ -0,0 +1,265 @@
+/*
+ * vusbhs_dev_utl.c -- This file contains the VUSB_HS Device Controller
+ * 			interface functions.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include "devapi.h"
+#include "usbprv_dev.h"
+
+#define USB_TEST_MODE_TEST_PACKET_LENGTH	53
+
+/*
+ * Test packet for Test Mode :
+ * TEST_PACKET. USB 2.0 Specification section 7.1.20
+ */
+u8 test_packet[USB_TEST_MODE_TEST_PACKET_LENGTH] =
+{
+	/* Synch */
+	/* DATA 0 PID */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+	0xAA, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE, 0xEE,
+	0xEE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0xBF, 0xDF,
+	0xEF, 0xF7, 0xFB, 0xFD, 0xFC, 0x7E, 0xBF, 0xDF,
+	0xEF, 0xF7, 0xFB, 0xFD, 0x7E
+};
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_assert_resume
+ * Returned Value : None
+ * Comments :
+ *	Resume signalling for remote wakeup
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_assert_resume(_usb_device_handle handle)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	u32 temp;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_assert_resume");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Assert the Resume signal */
+	temp = dev_ptr->regs.op_dev.portscx[0];
+	temp &= ~EHCI_PORTSCX_W1C_BITS;
+	temp |= EHCI_PORTSCX_PORT_FORCE_RESUME;
+	dev_ptr->regs.op_dev.portscx[0] = temp;
+
+	/*
+	 * Port change interrupt will be asserted at the end of resume
+	 * operation.
+	 */
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_assert_resume, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_stall_endpoint
+ * Returned Value : None
+ * Comments :
+ *	Stalls the specified endpoint
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_stall_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	volatile struct vusb20_ep_queue_head * ep_queue_head_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_stall_endpoint");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Get the endpoint queue head address */
+	ep_queue_head_ptr = (struct vusb20_ep_queue_head *)phys_to_virt(
+			dev_ptr->regs.op_dev.ep_list_addr) +
+			2 * ep_num + direction;
+
+	/* Stall the endpoint for Rx or Tx and set the endpoint type */
+	if (ep_queue_head_ptr->max_pkt_length & VUSB_EP_QUEUE_HEAD_IOS) {
+		/* This is a control endpoint so STALL both directions */
+		dev_ptr->regs.op_dev.ep_ctrlx[ep_num] |=
+			EHCI_EPCTRL_TX_EP_STALL | EHCI_EPCTRL_RX_EP_STALL;
+	} else {
+		dev_ptr->regs.op_dev.ep_ctrlx[ep_num] |=
+			direction ? EHCI_EPCTRL_TX_EP_STALL :
+			EHCI_EPCTRL_RX_EP_STALL;
+	}
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_stall_endpoint, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_unstall_endpoint
+ * Returned Value : None
+ * Comments :
+ *	Unstall the specified endpoint in the specified direction
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_unstall_endpoint(
+	_usb_device_handle handle,
+	u8 ep_num,
+	u8 direction)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_unstall_endpoint");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* Enable the endpoint for Rx or Tx and set the endpoint type */
+	dev_ptr->regs.op_dev.ep_ctrlx[ep_num] &=
+		direction ? ~EHCI_EPCTRL_TX_EP_STALL :
+		~EHCI_EPCTRL_RX_EP_STALL;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_unstall_endpoint, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_get_endpoint_status
+ * Returned Value : None
+ * Comments :
+ *	Gets the endpoint status
+ *
+ ***************************************************************************/
+u8 _usb_dci_vusb20_get_endpoint_status(
+	_usb_device_handle handle,
+	u8 ep)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_get_endpoint_status");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_get_endpoint_status, SUCCESSFUL");
+#endif
+
+	return (dev_ptr->regs.op_dev.ep_ctrlx[ep] &
+		(EHCI_EPCTRL_TX_EP_STALL | EHCI_EPCTRL_RX_EP_STALL)) ? 1 : 0;
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_set_test_mode
+ * Returned Value : None
+ * Comments :
+ *	sets/resets the test mode
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_set_test_mode(
+	_usb_device_handle handle,
+	u16 test_mode)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	u32 temp;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_set_test_mode");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	temp = dev_ptr->regs.op_dev.ep_ctrlx[0];
+
+	dev_ptr->regs.op_dev.ep_ctrlx[0] =
+		(temp | EHCI_EPCTRL_TX_DATA_TOGGLE_RST);
+
+	if (test_mode == USB_TEST_MODE_TEST_PACKET)
+		_usb_device_send_data(handle, 0, test_packet,
+					USB_TEST_MODE_TEST_PACKET_LENGTH);
+
+	temp = dev_ptr->regs.op_dev.portscx[0];
+	temp &= ~EHCI_PORTSCX_W1C_BITS;
+
+	dev_ptr->regs.op_dev.portscx[0] = temp | ((u32)test_mode << 8);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_set_test_mode, SUCCESSFUL");
+#endif
+}
+
+/****************************************************************************
+ *
+ * Function Name : _usb_dci_vusb20_set_endpoint_status
+ * Returned Value : None
+ * Comments :
+ *	Sets the endpoint registers e.g. to enable TX, RX, control
+ *
+ ***************************************************************************/
+void _usb_dci_vusb20_set_endpoint_status(
+	_usb_device_handle handle,
+	u8 ep,
+	u8 stall)
+{
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_set_endpoint_status");
+#endif
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	if (stall)
+		dev_ptr->regs.op_dev.ep_ctrlx[ep] |=
+			EHCI_EPCTRL_TX_EP_STALL | EHCI_EPCTRL_RX_EP_STALL;
+	else
+		dev_ptr->regs.op_dev.ep_ctrlx[ep] &=
+			~(EHCI_EPCTRL_TX_EP_STALL | EHCI_EPCTRL_RX_EP_STALL);
+
+#ifdef _DEVICE_DEBUG_
+	DEBUG_LOG_TRACE("_usb_dci_vusb20_set_endpoint_status, SUCCESSFUL");
+#endif
+}
diff --git a/drivers/usb/gadget/pmc-sierra/arc.h b/drivers/usb/gadget/pmc-sierra/arc.h
new file mode 100644
index 0000000..aabf67a
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/arc.h
@@ -0,0 +1,72 @@
+/*
+ * arc.h -- This file contains architecture specific defines
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __arc_h__
+#define __arc_h__
+
+#include "msp_cic_int.h"
+#include "msp_regs.h"
+
+/*
+ * STANDARD CONSTANTS
+ */
+#define BSP_VUSB20_DEVICE_BASE_ADDRESS0		MSP_USB_BASE
+#define BSP_VUSB20_DEVICE_SIZE0			0x1D0
+#define BSP_VUSB20_DEVICE_CAP_BASE_ADDRESS0	(MSP_USB_BASE + 0x100)
+#define BSP_VUSB20_DEVICE_CAP_SIZE0		0x28
+#define BSP_VUSB20_DEVICE_VECTOR0		MSP_INT_USB
+
+/*
+ * Common macros
+ */
+#define MSB(x)	(((x) >> 8) & 0xff)	/* MSB of 2-byte integer */
+#define LSB(x)	((x) & 0xff)		/* LSB of 2-byte integer */
+
+#define LLSB(x)		((x) & 0xff)	/* 32bit word byte/word swap macros */
+#define LNLSB(x)	(((x) >> 8) & 0xff)
+#define LNMSB(x)	(((x) >> 16) & 0xff)
+#define LMSB(x)		(((x) >> 24) & 0xff)
+#define LONGSWAP(x)	((LLSB(x) << 24)  | \
+			 (LNLSB(x) << 16) | \
+			 (LNMSB(x) << 8)  | \
+			 (LMSB(x)))
+
+#ifdef __BIG_ENDIAN
+#define USB_SWAP(x)		LONGSWAP((int)(x))
+#define USB_WORD_SWAP(x)	((LSB((u16)(x)) << 8) | \
+				  MSB((u16)(x)))
+#else
+#define USB_SWAP(x)		(x)
+#define USB_WORD_SWAP(x)	(x)
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+extern void _bsp_install_isr(u8, void (*)(void), void *);
+extern u8 _bsp_get_usb_vector(u8);
+extern void * _bsp_get_usb_base(u8);
+extern void * _bsp_get_usb_capability_register_base(u8);
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/drivers/usb/gadget/pmc-sierra/debug.h b/drivers/usb/gadget/pmc-sierra/debug.h
new file mode 100644
index 0000000..18d4a72
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/debug.h
@@ -0,0 +1,115 @@
+/*
+ * debug.h -- This file contains definitions for debugging the software stack
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __host_debug_h__
+#define __host_debug_h__
+
+#include "arc.h"
+
+/************************************************************
+ * Debug macros, assume _DBUG_ is defined during development
+ * (perhaps in the make file), and undefined for production.
+ ************************************************************/
+#ifndef _DBUG_
+#define DEBUG_FLUSH
+#define DEBUG_PRINT(X)
+#define DEBUG_PRINT2(X, Y)
+#else
+#define DEBUG_FLUSH		fflush(stdout);
+#define DEBUG_PRINT(X)		printf(X);
+#define DEBUG_PRINT2(X, Y)	printf(X, Y);
+#endif
+
+/************************************************************
+ * ASSERT macros, assume _ASSERT_ is defined during development
+ * (perhaps in the make file), and undefined for production.
+ * This macro will check for pointer values and other validations
+ * wherever appropriate.
+ ************************************************************/
+#ifndef _ASSERT_
+#define ASSERT(X, Y)
+#else
+#define ASSERT(X, Y)	if (Y) { printf(X); exit(1); }
+#endif
+
+/************************************************************
+ * The following array is used to make a run time trace route
+ * inside the USB stack.
+ ************************************************************/
+
+#ifdef _DEBUG_INFO_TRACE_LEVEL_
+
+#define TRACE_ARRAY_SIZE	1000
+#define MAX_STRING_SIZE		50
+
+#ifndef __TRACE_VARIABLES_DEFINED__
+extern u16 debug_trace_array_counter;
+extern char debug_trace_array[TRACE_ARRAY_SIZE][MAX_STRING_SIZE];
+extern bool debug_trace_enabled;
+#else
+u16 debug_trace_array_counter;
+char debug_trace_array[TRACE_ARRAY_SIZE][MAX_STRING_SIZE];
+bool debug_trace_enabled;
+#endif
+
+#define DEBUG_LOG_TRACE(x) \
+{ \
+	if (debug_trace_enabled) { \
+		memcpy(debug_trace_array[debug_trace_array_counter], x, \
+			MAX_STRING_SIZE); \
+	debug_trace_array_counter++; \
+	if (debug_trace_array_counter >= TRACE_ARRAY_SIZE) \
+		debug_trace_array_counter = 0; \
+	} \
+}
+#define START_DEBUG_TRACE \
+{ \
+	debug_trace_array_counter = 0; \
+	debug_trace_enabled = true; \
+}
+
+#define STOP_DEBUG_TRACE \
+{ \
+	debug_trace_enabled = false; \
+}
+
+/* if trace switch is not enabled define debug log trace to empty */
+#else
+
+#define DEBUG_LOG_TRACE(x)
+#define START_DEBUG_TRACE
+#define STOP_DEBUG_TRACE
+
+#endif
+
+/************************************************************
+ * The following are global data structures that can be used
+ * to copy data from stack on run time. This structure can
+ * be analyzed at run time to see the state of various other
+ * data structures in the memory.
+ ************************************************************/
+
+#ifdef _DEBUG_INFO_DATA_LEVEL_
+struct debug_data {
+};
+#endif
+
+#endif
diff --git a/drivers/usb/gadget/pmc-sierra/devapi.h b/drivers/usb/gadget/pmc-sierra/devapi.h
new file mode 100644
index 0000000..f6b947e
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/devapi.h
@@ -0,0 +1,95 @@
+/*
+ * devapi.h -- This file contains the declarations specific to the USB
+ *		Device API
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __devapi_h__
+#define __devapi_h__
+
+#include "arc.h"
+#include "usb.h"
+#include "debug.h"
+
+/* Endpoint types */
+#define USB_CONTROL_ENDPOINT		0
+#define USB_ISOCHRONOUS_ENDPOINT	1
+#define USB_BULK_ENDPOINT		2
+#define USB_INTERRUPT_ENDPOINT		3
+
+/* Informational Request/Set Types */
+#define USB_STATUS_DEVICE_STATE		0x01
+#define USB_STATUS_INTERFACE		0x02
+#define USB_STATUS_ADDRESS		0x03
+#define USB_STATUS_CURRENT_CONFIG	0x04
+#define USB_STATUS_SOF_COUNT		0x05
+#define USB_STATUS_DEVICE		0x06
+#define USB_STATUS_TEST_MODE		0x07
+#define USB_STATUS_ENDPOINT		0x10
+#define USB_STATUS_ENDPOINT_NUMBER_MASK	0x0F
+
+#define USB_TEST_MODE_TEST_PACKET	0x0400
+
+/*
+ * Available service types
+ * Services 0 through 15 are reserved for endpoints
+ */
+#define USB_SERVICE_EP0			0x00
+#define USB_SERVICE_EP1			0x01
+#define USB_SERVICE_EP2			0x02
+#define USB_SERVICE_EP3			0x03
+#define USB_SERVICE_BUS_RESET		0x10
+#define USB_SERVICE_SUSPEND		0x11
+#define USB_SERVICE_SOF			0x12
+#define USB_SERVICE_RESUME		0x13
+#define USB_SERVICE_SLEEP		0x14
+#define USB_SERVICE_SPEED_DETECTION	0x15
+#define USB_SERVICE_ERROR		0x16
+#define USB_SERVICE_STALL		0x17
+
+#define _usb_device_handle		void *
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+extern u8 _usb_device_init(u8, _usb_device_handle *, u8);
+extern u8 _usb_device_recv_data(_usb_device_handle, u8, u8 *, u32);
+extern u8 _usb_device_send_data(_usb_device_handle, u8, u8 *, u32);
+extern u8 _usb_device_get_transfer_status(_usb_device_handle, u8, u8);
+extern u8 _usb_device_cancel_transfer(_usb_device_handle, u8, u8);
+extern u8 _usb_device_get_status(_usb_device_handle, u8, u16 *);
+extern u8 _usb_device_set_status(_usb_device_handle, u8, u16);
+extern u8 _usb_device_register_service(_usb_device_handle, u8,
+			void( * service)(void *, bool, u8, u8 *, u32, u8));
+extern u8 _usb_device_unregister_service(_usb_device_handle, u8);
+extern u8 _usb_device_call_service(_usb_device_handle, u8,
+				bool, bool, u8 *, u32, u8);
+extern void _usb_device_shutdown(_usb_device_handle);
+extern void _usb_device_set_address(_usb_device_handle, u8);
+extern void _usb_device_read_setup_data(_usb_device_handle, u8, u8 *);
+extern void _usb_device_assert_resume(_usb_device_handle);
+extern u8 _usb_device_init_endpoint(_usb_device_handle, u8, u16, u8, u8, u8);
+extern void _usb_device_stall_endpoint(_usb_device_handle, u8, u8);
+extern void _usb_device_unstall_endpoint(_usb_device_handle, u8, u8);
+extern u8 _usb_device_deinit_endpoint(_usb_device_handle, u8, u8);
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/drivers/usb/gadget/pmc-sierra/usb.h b/drivers/usb/gadget/pmc-sierra/usb.h
new file mode 100644
index 0000000..bf50d5e
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/usb.h
@@ -0,0 +1,127 @@
+/*
+ * usb.h -- This file contains USB Device API defines for state and
+ *	function returns
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __usb_h__
+#define __usb_h__
+
+/* Host specific */
+#define USB_DEBOUNCE_DELAY		101
+#define USB_RESET_RECOVERY_DELAY	11
+#define USB_RESET_DELAY			60
+
+/* Error codes */
+#define USB_OK				0x00
+#define USBERR_ALLOC			0x81
+#define USBERR_BAD_STATUS		0x82
+#define USBERR_CLOSED_SERVICE		0x83
+#define USBERR_OPEN_SERVICE		0x84
+#define USBERR_TRANSFER_IN_PROGRESS	0x85
+#define USBERR_ENDPOINT_STALLED		0x86
+#define USBERR_ALLOC_STATE		0x87
+#define USBERR_DRIVER_INSTALL_FAILED	0x88
+#define USBERR_DRIVER_NOT_INSTALLED	0x89
+#define USBERR_INSTALL_ISR		0x8A
+#define USBERR_INVALID_DEVICE_NUM	0x8B
+#define USBERR_ALLOC_SERVICE		0x8C
+#define USBERR_INIT_FAILED		0x8D
+#define USBERR_SHUTDOWN			0x8E
+#define USBERR_INVALID_PIPE_HANDLE	0x8F
+#define USBERR_OPEN_PIPE_FAILED		0x90
+#define USBERR_INIT_DATA		0x91
+#define USBERR_SRP_REQ_INVALID_STATE	0x92
+#define USBERR_TX_FAILED		0x93
+#define USBERR_RX_FAILED		0x94
+#define USBERR_EP_INIT_FAILED		0x95
+#define USBERR_EP_DEINIT_FAILED		0x96
+#define USBERR_TR_FAILED		0x97
+#define USBERR_BANDWIDTH_ALLOC_FAILED	0x98
+#define USBERR_INVALID_NUM_OF_ENDPOINTS	0x99
+
+#define USBERR_DEVICE_NOT_FOUND		0xC0
+#define USBERR_DEVICE_BUSY		0xC1
+#define USBERR_NO_DEVICE_CLASS		0xC3
+#define USBERR_UNKNOWN_ERROR		0xC4
+#define USBERR_INVALID_BMREQ_TYPE	0xC5
+#define USBERR_GET_MEMORY_FAILED	0xC6
+#define USBERR_INVALID_MEM_TYPE		0xC7
+#define USBERR_NO_DESCRIPTOR		0xC8
+#define USBERR_NULL_CALLBACK		0xC9
+#define USBERR_NO_INTERFACE		0xCA
+#define USBERR_INVALID_CFIG_NUM		0xCB
+#define USBERR_INVALID_ANCHOR		0xCC
+#define USBERR_INVALID_REQ_TYPE		0xCD
+
+/* Error Codes for lower-layer */
+#define USBERR_ALLOC_EP_QUEUE_HEAD	0xA8
+#define USBERR_ALLOC_TR			0xA9
+#define USBERR_ALLOC_DTD_BASE		0xAA
+#define USBERR_CLASS_DRIVER_INSTALL	0xAB
+
+/* Pipe Types */
+#define USB_ISOCHRONOUS_PIPE		0x01
+#define USB_INTERRUPT_PIPE		0x02
+#define USB_CONTROL_PIPE		0x03
+#define USB_BULK_PIPE			0x04
+
+#define USB_STATE_UNKNOWN		0xff
+#define USB_STATE_POWERED		0x03
+#define USB_STATE_DEFAULT		0x02
+#define USB_STATE_ADDRESS		0x01
+#define USB_STATE_CONFIG		0x00
+#define USB_STATE_SUSPEND		0x80
+
+#define USB_SELF_POWERED		0x01
+#define USB_REMOTE_WAKEUP		0x02
+
+/* Bus Control values */
+#define USB_NO_OPERATION		0x00
+#define USB_ASSERT_BUS_RESET		0x01
+#define USB_DEASSERT_BUS_RESET		0x02
+#define USB_ASSERT_RESUME		0x03
+#define USB_DEASSERT_RESUME		0x04
+#define USB_SUSPEND_SOF			0x05
+#define USB_RESUME_SOF			0x06
+
+/* possible values of XD->bStatus */
+#define USB_STATUS_IDLE			0
+#define USB_STATUS_TRANSFER_ACCEPTED	1
+#define USB_STATUS_TRANSFER_PENDING	2
+#define USB_STATUS_TRANSFER_IN_PROGRESS	3
+#define USB_STATUS_ERROR		4
+#define USB_STATUS_DISABLED		5
+#define USB_STATUS_STALLED		6
+#define USB_STATUS_TRANSFER_QUEUED	7
+
+#define USB_RECV			0
+#define USB_SEND			1
+
+#define USB_DEVICE_DONT_ZERO_TERMINATE	0x1
+
+#define USB_SETUP_DATA_XFER_DIRECTION	0x80
+
+#define USB_DEV_SPEED_FULL		0
+#define USB_DEV_SPEED_LOW		1
+#define USB_DEV_SPEED_HIGH		2
+
+#define USB_MAX_PKTS_PER_UFRAME		0x6
+
+#endif
diff --git a/drivers/usb/gadget/pmc-sierra/usbprv_dev.h b/drivers/usb/gadget/pmc-sierra/usbprv_dev.h
new file mode 100644
index 0000000..5b4edd2
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/usbprv_dev.h
@@ -0,0 +1,245 @@
+/*
+ * usbprv_dev.h -- This file contains the private defines, externs and
+ *		data structure definitions required by the VUSB_HS Device
+ *		driver.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __usbprv_dev_h__
+#define __usbprv_dev_h__
+
+#include "vusbhs.h"
+
+#define MAX_EP_TR_DESCRS		32
+#define MAX_XDS_FOR_TR_CALLS		32
+#define MAX_USB_DEVICES			1
+#define USB_MAX_ENDPOINTS		16
+
+#define USB_MAX_CTRL_PAYLOAD		64
+
+/* Macro for aligning the EP queue head to 32 byte boundary */
+#define USB_MEM32_ALIGN(n)		((n) + (-(n) & 31))
+
+/* Macro for aligning the EP queue head to 1024 byte boundary */
+#define USB_MEM1024_ALIGN(n)		((n) + (-(n) & 1023))
+
+/* Macro for aligning the EP queue head to 1024 byte boundary */
+#define USB_MEM2048_ALIGN(n)		((n) + (-(n) & 2047))
+
+#define USB_XD_QADD(head, tail, xd) \
+({ \
+	if ((head) == NULL) \
+		(head) = (xd); \
+	else \
+		(tail)->scratch_ptr->private = (xd); \
+	(tail) = (xd); \
+	(xd)->scratch_ptr->private = NULL; \
+})
+
+#define USB_XD_QGET(head, tail, xd) \
+({ \
+	(xd) = (head); \
+	if (head) { \
+		(head) = (head)->scratch_ptr->private; \
+		if ((head) == NULL) \
+			(tail) = NULL; \
+	} \
+})
+
+#define EHCI_DTD_QADD(head, tail, dtd) \
+({ \
+	if ((head) == NULL) \
+		(head) = (dtd); \
+	else \
+		(tail)->scratch_ptr->private = (dtd); \
+	(tail) = (dtd); \
+	(dtd)->scratch_ptr->private = NULL; \
+})
+
+#define EHCI_DTD_QGET(head, tail, dtd) \
+({ \
+	(dtd) = (head); \
+	if (head) { \
+		(head) = (head)->scratch_ptr->private; \
+		if ((head) == NULL) \
+			(tail) = NULL; \
+	} \
+})
+
+/*
+ * Data structures
+ */
+
+/* Callback function storage structure */
+struct service {
+	u8		type;
+	void		( * service)(void *, bool, u8, u8 *, u32, u8);
+	struct service *next;
+};
+
+struct xd {
+	u8		ep_num;	 	/* Endpoint number */
+	u8		bdirection;	/* Direction : Send/Receive */
+	u8		ep_type;	/* Type of the endpoint: Ctrl, Isoch,
+					 * Bulk, Int
+					 */
+	u8		bstatus;	/* Current transfer status */
+	u8 *		wstartaddress;	/* Address of first byte */
+	u32		wtotallength;	/* Number of bytes to send/recv */
+	u32		wsofar;		/* Number of bytes recv'd so far */
+	u16		wmaxpacketsize;	/* Max Packet size */
+	u32		dont_zero_terminate;
+	u8		max_pkts_per_uframe;
+	struct scratch *scratch_ptr;
+};
+
+/* The USB Device State Structure */
+struct usb_dev_state {
+	u32			bus_resetting; /* Device is
+						* being reset
+						*/
+	u32			transfer_pending; /* Transfer pending ? */
+
+	volatile struct vusb20 *dev_ptr;	/* Device Controller
+						 * Register base
+						 * address
+						 */
+
+	void *			callback_ptr;
+
+	struct service *	service_head_ptr; /* Head struct
+						   * address of
+						   * registered services
+						   */
+	struct xd *		temp_xd_ptr;	/* Temp xd for ep init */
+	struct xd *		xd_base;
+	struct xd *		xd_head;	/* Head Transaction
+						 * descriptors
+						 */
+	struct xd *		xd_tail;	/* Tail Transaction
+						 * descriptors
+						 */
+	struct xd *		pending_xd_ptr;	/* pending transfer */
+	u32			xd_entries;
+	volatile struct vusb20_ep_queue_head *ep_queue_head_ptr;
+						/* Endpoint Queue
+						 * head
+						 */
+	u8 *			driver_memory;
+	volatile struct vusb20_ep_queue_head *ep_queue_head_base;
+	volatile struct vusb20_ep_tr *dtd_base_ptr;
+						/* Device transfer
+						 * descriptor pool
+						 * address
+						 */
+	volatile struct vusb20_ep_tr *dtd_aligned_base_ptr;
+						/* Aligned transfer
+						 * descriptor pool
+						 * address
+						 */
+	volatile struct vusb20_ep_tr *dtd_head;
+	volatile struct vusb20_ep_tr *dtd_tail;
+	volatile struct vusb20_ep_tr *ep_dtd_heads[USB_MAX_ENDPOINTS * 2];
+	volatile struct vusb20_ep_tr *ep_dtd_tails[USB_MAX_ENDPOINTS * 2];
+	struct scratch *	xd_scratch_base;
+	struct scratch *	scratch_base;
+
+	/* These fields are kept only for USB_shutdown() */
+	void			( * oldisr_ptr)(void *);
+	void *			oldisr_data;
+	u16			usb_state;
+	u16			usb_dev_state;
+	u16			usb_sof_count;
+	u16			dtd_entries;
+	u16			errors;
+	u16			usb_dev_state_b4_suspend;
+	u8			dev_num;	/* USB device number
+						 * on the board
+						 */
+	u8			dev_vec;	/* Interrupt vector
+						 * number for USB
+						 */
+	u8			dev_speed;	/* Low Speed,
+						 * High Speed,
+						 * Full Speed
+						 */
+	u8			max_endpoints;	/* Max endpoints
+						 * supported by this
+						 * device
+						 */
+	u8			usb_curr_config;
+	u8			device_address;
+
+	/*
+	 * All high-speed device are supposed to support test mode
+	 * see USB specification
+	 */
+	u32			enter_test_mode;
+	u16			test_mode_index;
+	u8			speed;
+	u8			usb_if_alt[4];
+	u8			usb_status[2];
+	struct setup		local_setup_packet;
+	u8			endpoint;
+	u8			if_status;
+
+	/* Lock to provide mutual exclusion for device */
+	spinlock_t		lock;
+};
+
+/*
+ * Prototypes
+ */
+#ifdef __cplusplus
+extern "C" {
+#endif
+extern void _usb_dci_vusb20_isr(void);
+
+extern u8 _usb_dci_vusb20_init(u8, _usb_device_handle);
+extern void _usb_device_free_xd(void *);
+extern void _usb_dci_vusb20_free_dtd(void *);
+extern u8 _usb_dci_vusb20_add_dtd(_usb_device_handle, struct xd *);
+extern u8 _usb_dci_vusb20_send_data(_usb_device_handle, struct xd *);
+extern u8 _usb_dci_vusb20_recv_data(_usb_device_handle, struct xd *);
+extern u8 _usb_dci_vusb20_cancel_transfer(_usb_device_handle, u8, u8);
+extern u8 _usb_dci_vusb20_get_transfer_status(_usb_device_handle, u8, u8);
+extern void _usb_dci_vusb20_process_tr_complete(_usb_device_handle);
+extern void _usb_dci_vusb20_process_reset(_usb_device_handle);
+extern void _usb_dci_vusb20_process_tr_complete(_usb_device_handle);
+extern void _usb_dci_vusb20_process_suspend(_usb_device_handle);
+extern void _usb_dci_vusb20_process_SOF(_usb_device_handle);
+extern void _usb_dci_vusb20_process_port_change(_usb_device_handle);
+extern void _usb_dci_vusb20_process_error(_usb_device_handle);
+extern void _usb_dci_vusb20_shutdown(_usb_device_handle);
+extern void _usb_dci_vusb20_set_address(_usb_device_handle, u8);
+extern void _usb_dci_vusb20_get_setup_data(_usb_device_handle, u8, u8 *);
+extern void _usb_dci_vusb20_assert_resume(_usb_device_handle);
+extern u8 _usb_dci_vusb20_init_endpoint(_usb_device_handle, struct xd *);
+extern void _usb_dci_vusb20_stall_endpoint(_usb_device_handle, u8, u8);
+extern void _usb_dci_vusb20_unstall_endpoint(_usb_device_handle, u8, u8);
+extern u8 _usb_dci_vusb20_deinit_endpoint(_usb_device_handle, u8, u8);
+extern void _usb_dci_vusb20_set_endpoint_status(_usb_device_handle, u8, u8);
+extern void _usb_dci_vusb20_set_test_mode(_usb_device_handle, u16);
+extern u8 _usb_dci_vusb20_get_endpoint_status(_usb_device_handle, u8);
+extern void _usb_dci_vusb20_chip_initialize(_usb_device_handle);
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/drivers/usb/gadget/pmc-sierra/vusbhs.h b/drivers/usb/gadget/pmc-sierra/vusbhs.h
new file mode 100644
index 0000000..32e7341
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/vusbhs.h
@@ -0,0 +1,725 @@
+/*
+ * vusbhs.h -- This file contains the defines, externs and
+ *		data structure definitions required by the VUSB_HS Device
+ *		driver.
+ *
+ * Copyright (C) 1989-2006 Chipidea
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __vusbhs_h__
+#define __vusbhs_h__
+
+#include "arc.h"
+
+/* VUSBHS specific defines */
+#define VUSBHS_MAX_PORTS		8
+#define EHCI_CAP_LEN_MASK		0x000000FF
+#define EHCI_DATA_STRUCTURE_BASE_ADDR	0
+
+/* Command Register Bit Masks */
+#define EHCI_CMD_RUN_STOP		0x00000001
+#define EHCI_CMD_CTRL_RESET		0x00000002
+#define EHCI_CMD_SETUP_TRIPWIRE_SET	0x00002000
+#define EHCI_CMD_SETUP_TRIPWIRE_CLEAR	(~EHCI_CMD_SETUP_TRIPWIRE_SET)
+
+#define EHCI_CMD_ATDTW_TRIPWIRE_SET	0x00001000
+#define EHCI_CMD_ATDTW_TRIPWIRE_CLEAR	(~EHCI_CMD_SETUP_TRIPWIRE_CLEAR)
+
+/* Bits 15, 3, 2 are for frame list size */
+#define EHCI_CMD_FRAME_SIZE_1024	0x00000000 /* 000 */
+#define EHCI_CMD_FRAME_SIZE_512		0x00000004 /* 001 */
+#define EHCI_CMD_FRAME_SIZE_256		0x00000008 /* 010 */
+#define EHCI_CMD_FRAME_SIZE_128		0x0000000C /* 011 */
+#define EHCI_CMD_FRAME_SIZE_64		0x00008000 /* 100 */
+#define EHCI_CMD_FRAME_SIZE_32		0x00008004 /* 101 */
+#define EHCI_CMD_FRAME_SIZE_16		0x00008008 /* 110 */
+#define EHCI_CMD_FRAME_SIZE_8		0x0000800C /* 111 */
+
+/* Mode Register Bit Masks */
+#define VUSBHS_MODE_CTRL_MODE_IDLE	0x00000000
+#define VUSBHS_MODE_CTRL_MODE_DEV	0x00000002
+#define VUSBHS_MODE_CTRL_MODE_HOST	0x00000003
+#define VUSBHS_MODE_BIG_ENDIAN		0x00000004
+#define VUSBHS_MODE_SETUP_LOCK_DISABLE	0x00000008
+#define VUSBHS_MODE_STREAM_DISABLE	0x00000010
+
+/* Interrupt Enable Register Bit Masks */
+#define EHCI_INTR_INT_EN		0x00000001
+#define EHCI_INTR_ERR_INT_EN		0x00000002
+#define EHCI_INTR_PORT_CHANGE_DETECT_EN	0x00000004
+
+#define EHCI_INTR_ASYNC_ADV_AAE		0x00000020
+#define EHCI_INTR_ASYNC_ADV_AAE_ENABLE	0x00000020 /* | with this to enable */
+#define EHCI_INTR_ASYNC_ADV_AAE_DISABLE	0xFFFFFFDF /* & with this to disable */
+
+#define EHCI_INTR_RESET_EN		0x00000040
+#define EHCI_INTR_SOF_UFRAME_EN		0x00000080
+#define EHCI_INTR_DEVICE_SUSPEND	0x00000100
+
+/* Interrupt Status Register Masks */
+#define EHCI_STS_SOF			0x00000080
+#define EHCI_STS_RESET			0x00000040
+#define EHCI_STS_PORT_CHANGE		0x00000004
+#define EHCI_STS_ERR			0x00000002
+#define EHCI_STS_INT			0x00000001
+#define EHCI_STS_SUSPEND		0x00000100
+#define EHCI_STS_HC_HALTED		0x00001000
+#define EHCI_STS_SER_SELECT		0x20000000
+
+/* Endpoint Queue Head Bit Masks */
+#define VUSB_EP_QUEUE_HEAD_IOS			0x00008000
+#define VUSB_EP_QUEUE_HEAD_IOC			0x00008000
+#define VUSB_EP_QUEUE_HEAD_INT			0x00000100
+#define VUSB_EP_QUEUE_HEAD_NEXT_TERMINATE	0x00000001
+#define VUSB_EP_QUEUE_HEAD_MAX_PKT_LEN_POS	16
+#define VUSB_EP_QUEUE_HEAD_ZERO_LEN_TER_SEL	0x20000000
+#define VUSB_EP_QUEUE_HEAD_MULT_POS		30
+#define VUSB_EP_MAX_LENGTH_TRANSFER		0x4000
+
+#define VUSB_EP_QUEUE_HEAD_STATUS_ACTIVE	0x00000080
+
+#define VUSBHS_TD_NEXT_TERMINATE		0x00000001
+#define VUSBHS_TD_IOC				0x00008000
+#define VUSBHS_TD_STATUS_ACTIVE			0x00000080
+#define VUSBHS_TD_STATUS_HALTED			0x00000040
+#define VUSBHS_TD_RESERVED_FIELDS		0x00007F00
+#define VUSBHS_TD_ERROR_MASK			0x68
+#define VUSBHS_TD_ADDR_MASK			0xFFFFFFE0
+#define VUSBHS_TD_LENGTH_BIT_POS		16
+
+#define EHCI_EPCTRL_TX_DATA_TOGGLE_RST		0x00400000
+#define EHCI_EPCTRL_TX_EP_STALL			0x00010000
+#define EHCI_EPCTRL_RX_EP_STALL			0x00000001
+#define EHCI_EPCTRL_RX_DATA_TOGGLE_RST		0x00000040
+#define EHCI_EPCTRL_RX_ENABLE			0x00000080
+#define EHCI_EPCTRL_TX_ENABLE			0x00800000
+#define EHCI_EPCTRL_CONTROL			0x00000000
+#define EHCI_EPCTRL_ISOCHRONOUS			0x00040000
+#define EHCI_EPCTRL_BULK			0x00080000
+#define EHCI_EPCTRL_INT				0x000C0000
+#define EHCI_EPCTRL_TX_TYPE			0x000C0000
+#define EHCI_EPCTRL_RX_TYPE			0x0000000C
+#define EHCI_EPCTRL_DATA_TOGGLE_INHIBIT		0x00000020
+#define EHCI_EPCTRL_TX_EP_TYPE_SHIFT		18
+#define EHCI_EPCTRL_RX_EP_TYPE_SHIFT		2
+
+#define EHCI_PORTSCX_PORT_POWER			0x00001000
+#define EHCI_PORTSCX_LINE_STATUS_BITS		0x00000C00
+#define EHCI_PORTSCX_LINE_STATUS_SE0		0x00000000
+#define EHCI_PORTSCX_LINE_STATUS_KSTATE		0x00000400
+#define EHCI_PORTSCX_LINE_STATUS_JSTATE		0x00000800
+#define EHCI_PORTSCX_PORT_HIGH_SPEED		0x00000200
+#define EHCI_PORTSCX_PORT_RESET			0x00000100
+#define EHCI_PORTSCX_PORT_SUSPEND		0x00000080
+#define EHCI_PORTSCX_PORT_FORCE_RESUME		0x00000040
+#define EHCI_PORTSCX_PORT_EN_DIS_CHANGE		0x00000008
+#define EHCI_PORTSCX_PORT_ENABLE		0x00000004
+#define EHCI_PORTSCX_CONNECT_STATUS_CHANGE	0x00000002
+#define EHCI_PORTSCX_CURRENT_CONNECT_STATUS	0x00000001
+
+#define VUSBHS_PORTSCX_PORT_SPEED_FULL		0x00000000
+#define VUSBHS_PORTSCX_PORT_SPEED_LOW		0x04000000
+#define VUSBHS_PORTSCX_PORT_SPEED_HIGH		0x08000000
+#define VUSBHS_SPEED_MASK			0x0C000000
+#define VUSBHS_SPEED_BIT_POS			26
+
+#define EHCI_PORTSCX_W1C_BITS			0x2A
+
+#define VUSB_EP_TR_PACKET_SIZE			0x7FFF0000
+
+#define VUSBHS_FRINDEX_MS_MASK			0xFFFFFFF8
+#define VUSBHS_ADDRESS_BIT_SHIFT		25
+
+#define VUSB20_MAX_ENDPTS_SUPPORTED		0x1F
+#define EHCI_HCC_PARAMS_64_BIT_ADDR_CAP		0x01
+#define EHCI_HCC_PARAMS_PGM_FRM_LIST_FLAG	0x02
+#define EHCI_HCC_PARAMS_ASYNC_PARK_CAP		0x04
+#define EHCI_HCC_PARAMS_ISOCH_SCHED_THRESHOLD	0xF0
+#define EHCI_HCC_PARAMS_ISOCH_FRAME_CACHED	0x80
+
+#define VUSB20_HCS_PARAMS_PORT_POWER_CONTROL_FLAG 0x10
+
+#define VUSB20_HOST_INTR_EN_BITS		0x37
+
+#define VUSB20_DEFAULT_PERIODIC_FRAME_LIST_SIZE	1024
+#define VUSB20_NEW_PERIODIC_FRAME_LIST_BITS	2
+#define EHCI_FRAME_LIST_ELEMENT_POINTER_T_BIT	0x01
+#define EHCI_ITD_T_BIT				0x01
+#define EHCI_SITD_T_BIT				0x01
+#define EHCI_QUEUE_HEAD_POINTER_T_BIT		0x01
+
+/************************************************************
+ * Split transatcions specific defines
+ ************************************************************/
+#define EHCI_START_SPLIT_MAX_BUDGET		188
+
+#define EHCI_ELEMENT_TYPE_ITD			0x00
+#define EHCI_ELEMENT_TYPE_QH			0x02
+#define EHCI_ELEMENT_TYPE_SITD			0x04
+#define EHCI_ELEMENT_TYPE_FSTN			0x06
+#define EHCI_ELEMENT_TYPE_MASK			0x06
+
+#define EHCI_FRAME_LIST_ELEMENT_TYPE_ITD	0x00
+#define EHCI_FRAME_LIST_ELEMENT_TYPE_QH		0x01
+#define EHCI_FRAME_LIST_ELEMENT_TYPE_SITD	0x02
+#define EHCI_FRAME_LIST_ELEMENT_TYPE_FSTN	0x03
+#define EHCI_FRAME_LIST_ELEMENT_TYPE_BIT_POS	1
+
+#define EHCI_QH_ELEMENT_TYPE_ITD		0x00
+#define EHCI_QH_ELEMENT_TYPE_QH			0x01
+#define EHCI_QH_ELEMENT_TYPE_SITD		0x02
+#define EHCI_QH_ELEMENT_TYPE_FSTN		0x03
+
+#define EHCI_QH_ELEMENT_TYPE_BIT_POS		1
+
+#define EHCI_QTD_PID_OUT_TOKEN			0x000
+#define EHCI_QTD_PID_IN_TOKEN			0x100
+#define EHCI_QTD_PID_SETUP_TOKEN		0x200
+#define EHCI_QTD_IOC				0x8000
+#define EHCI_QTD_STATUS_ACTIVE			0x0080
+#define EHCI_QTD_STATUS_HALTED			0x0040
+#define EHCI_QTD_PID_SETUP			0x0200
+#define EHCI_QTD_PID_IN				0x0100
+#define EHCI_QTD_PID_OUT			0x0000
+#define EHCI_QTD_LENGTH_BIT_POS			16
+#define EHCI_QTD_DATA_TOGGLE			0x80000000
+#define EHCI_QTD_DATA_TOGGLE_BIT_POS		31
+#define EHCI_QTD_LENGTH_BIT_MASK		0x7FFF0000
+#define EHCI_QTD_ERROR_BITS_MASK		0x0000003E
+#define EHCI_QTD_DEFAULT_CERR_VALUE		0xC00
+
+#define EHCI_SETUP_TOKEN			2
+#define EHCI_OUT_TOKEN				0
+#define EHCI_IN_TOKEN				1
+
+#define EHCI_QTD_T_BIT				0x01
+
+#define EHCI_QH_ENDPOINT_SPEED_FULL		0x00
+#define EHCI_QH_ENDPOINT_SPEED_LOW		0x01
+#define EHCI_QH_ENDPOINT_SPEED_HIGH		0x02
+#define EHCI_QH_ENDPOINT_SPEED_RESERVED		0x03
+
+#define EHCI_ITD_LENGTH_BIT_POS			16
+#define EHCI_ITD_IOC_BIT			0x00008000
+#define EHCI_ITD_ACTIVE_BIT			0x80000000
+#define EHCI_ITD_PG_SELECT_BIT_POS		12
+#define EHCI_ITD_DIRECTION_BIT_POS		11
+#define EHCI_ITD_EP_BIT_POS			8
+#define EHCI_ITD_STATUS				0xF0000000
+#define EHCI_ITD_STATUS_ACTIVE			0x80000000 /* bit 4 = 1000 */
+#define EHCI_ITD_STATUS_DATA_BUFFER_ERR		0x40000000 /* bit 3 = 0100 */
+#define EHCI_ITD_STATUS_BABBLE_ERROR		0x20000000 /* bit 2 = 0010 */
+#define EHCI_ITD_STATUS_TRANSACTION_ERR		0x10000000 /* bit 4 = 0001 */
+
+#define EHCI_ITD_LENGTH_TRANSMITTED		0x0FFF0000
+#define EHCI_ITD_BUFFER_OFFSET			0x00000FFF
+#define EHCI_ITD_PAGE_NUMBER			0x00007000
+#define EHCI_ITD_BUFFER_POINTER			0xFFFFF000
+#define EHCI_ITD_MULTI_TRANSACTION_BITS		0x00000003
+
+/* SITD position bits */
+#define EHCI_SITD_DIRECTION_BIT_POS		31
+#define EHCI_SITD_PORT_NUMBER_BIT_POS		24
+#define EHCI_SITD_HUB_ADDR_BIT_POS		16
+#define EHCI_SITD_EP_ADDR_BIT_POS		8
+
+#define EHCI_SITD_COMPLETE_SPLIT_MASK_BIT_POS	8
+
+#define EHCI_SITD_IOC_BIT_SET			0x80000000
+#define EHCI_SITD_PAGE_SELECT_BIT_POS		30
+#define EHCI_SITD_TRANSFER_LENGTH_BIT_POS	16
+#define EHCI_SITD_STATUS_ACTIVE			0x80
+
+#define EHCI_SITD_STATUS			0xFF
+#define EHCI_SITD_LENGTH_TRANSMITTED		0x03FF0000
+#define EHCI_SITD_BUFFER_OFFSET			0x00000FFF
+#define EHCI_SITD_PAGE_NUMBER			0x40000000
+#define EHCI_SITD_BUFFER_POINTER		0xFFFFF000
+
+#define EHCI_SITD_BUFFER_PTR_BIT_POS		12
+#define EHCI_SITD_TP_BIT_POS			3
+#define EHCI_SITD_TP_ALL			0
+#define EHCI_SITD_TP_BEGIN			1
+#define EHCI_SITD_TP_MID			2
+#define EHCI_SITD_TP_END			3
+
+/* Interrupt enable bit masks */
+#define EHCI_IER_ASYNCH_ADVANCE			0x00000020
+#define EHCI_IER_HOST_SYS_ERROR			0x00000010
+#define EHCI_IER_FRAME_LIST_ROLLOVER		0x00000008
+#define EHCI_IER_PORT_CHANGE			0x00000004
+#define EHCI_IER_USB_ERROR			0x00000002
+#define EHCI_IER_USB_INTERRUPT			0x00000001
+
+/* Interrupt status bit masks */
+#define EHCI_STS_RECLAIMATION			0x00002000
+#define EHCI_STS_SOF_COUNT			0x00000080
+#define EHCI_STS_ASYNCH_ADVANCE			0x00000020
+#define EHCI_STS_HOST_SYS_ERROR			0x00000010
+#define EHCI_STS_FRAME_LIST_ROLLOVER		0x00000008
+#define EHCI_STS_PORT_CHANGE			0x00000004
+#define EHCI_STS_USB_ERROR			0x00000002
+#define EHCI_STS_USB_INTERRUPT			0x00000001
+
+/* Status bit masks */
+#define EHCI_STS_ASYNCH_SCHEDULE		0x00008000
+#define EHCI_STS_PERIODIC_SCHEDULE		0x00004000
+#define EHCI_STS_RECLAMATION			0x00002000
+#define EHCI_STS_HC_HALTED			0x00001000
+
+/* USB command bit masks */
+#define EHCI_USBCMD_ASYNC_SCHED_ENABLE		0x00000020
+#define EHCI_USBCMD_PERIODIC_SCHED_ENABLE	0x00000010
+
+#define EHCI_HCS_PARAMS_N_PORTS			0x0F
+
+#define VUSB_HS_DELAY				3500
+
+#define EHCI_QH_EP_NUM_MASK			0x0F00
+#define EHCI_QH_EP_NUM_BITS_POS			8
+#define EHCI_QH_DEVICE_ADDRESS_MASK		0x7F
+#define EHCI_QH_SPEED_BITS_POS			12
+#define EHCI_QH_MAX_PKT_SIZE_BITS_POS		16
+#define EHCI_QH_NAK_COUNT_RL_BITS_POS		28
+#define EHCI_QH_EP_CTRL_FLAG_BIT_POS		27
+#define EHCI_QH_HEAD_RECLAMATION_BIT_POS	15
+#define EHCI_QH_DTC_BIT_POS			14
+#define EHCI_QH_HIGH_BW_MULT_BIT_POS		30
+#define EHCI_QH_HUB_PORT_NUM_BITS_POS		23
+#define EHCI_QH_HUB_ADDR_BITS_POS		16
+#define EHCI_QH_SPLIT_COMPLETION_MASK_BITS_POS	8
+#define EHCI_QH_SPLIT_COMPLETION_MASK		0xFF00
+#define EHCI_QH_INTR_SCHED_MASK			0xFF
+#define EHCI_QH_INACTIVATE_NEXT_TR_BIT_POS	7
+#define EHCI_QH_HORIZ_PHY_ADDRESS_MASK		0xFFFFFFE0
+#define EHCI_QH_TR_OVERLAY_DT_BIT		0x80000000
+
+#define EHCI_SITD_SPLIT_COMPLETION_MASK_BITS_POS 8
+
+#define EHCI_INTR_NO_THRESHOLD_IMMEDIATE	0x00010000
+#define EHCI_NEW_PERIODIC_FRAME_LIST_SIZE	1024
+#define EHCI_FRAME_LIST_SIZE_BITS_POS		2
+#define EHCI_HORIZ_PHY_ADDRESS_MASK		0xFFFFFFE0
+
+#define DEFAULT_MAX_NAK_COUNT			15
+
+/* OTG Status and control register bit masks */
+
+/* OTG interrupt enable bit masks */
+#define VUSBHS_OTGSC_INTERRUPT_ENABLE_BITS_MASK	0x5F000000
+#define VUSBHS_OTGSC_DPIE		0x40000000 /* Data-line pulsing IE */
+#define VUSBHS_OTGSC_1MSIE		0x20000000
+#define VUSBHS_OTGSC_BSEIE		0x10000000 /* B-session end IE */
+#define VUSBHS_OTGSC_BSVIE		0x08000000 /* B-session valid IE */
+#define VUSBHS_OTGSC_ASVIE		0x04000000 /* A-session valid IE */
+#define VUSBHS_OTGSC_AVVIE		0x02000000 /* A-V-bus valid IE */
+#define VUSBHS_OTGSC_IDIE		0x01000000 /* OTG ID IE */
+
+/* OTG interrupt status bit masks */
+#define VUSBHS_OTGSC_INTERRUPT_STATUS_BITS_MASK	0x005F0000
+#define VUSBHS_OTGSC_DPIS		0x00400000 /* Data-line pulsing IS */
+#define VUSBHS_OTGSC_1MSIS		0x00200000
+#define VUSBHS_OTGSC_BSEIS		0x00100000 /* B-session end IS */
+#define VUSBHS_OTGSC_BSVIS		0x00080000 /* B-session valid IS */
+#define VUSBHS_OTGSC_ASVIS		0x00040000 /* A-session valid IS */
+#define VUSBHS_OTGSC_AVVIS		0x00020000 /* A-Vbus valid IS */
+#define VUSBHS_OTGSC_IDIS		0x00010000 /* OTG ID IS */
+
+/* OTG status bit masks */
+#define VUSBHS_OTGSC_DPS		0x00004000
+#define VUSBHS_OTGSC_BSE		0x00001000 /* B-session end */
+#define VUSBHS_OTGSC_BSV		0x00000800 /* B-session valid */
+#define VUSBHS_OTGSC_ASV		0x00000400 /* A-session valid */
+#define VUSBHS_OTGSC_AVV		0x00000200 /* A-Vbus Valid */
+#define VUSBHS_OTGSC_ID			0x00000100 /* OTG ID */
+
+/* OTG control bit masks */
+#define VUSBHS_OTGSC_CTL_BITS		0x2F
+#define VUSBHS_OTGSC_B_HOST_EN		0x00000020 /* B_host_enable */
+#define VUSBHS_OTGSC_DP			0x00000010 /* Data-pulsing */
+#define VUSBHS_OTGSC_OT			0x00000008 /* OTG termination */
+#define VUSBHS_OTGSC_VO			0x00000004 /* Vbus on */
+#define VUSBHS_OTGSC_VC			0x00000002 /* Vbus charge */
+#define VUSBHS_OTGSC_VD			0x00000001 /* Vbus discharge */
+
+#define usb_register			volatile u32
+#define ehci_frame_list_element_pointer	u32
+
+/* The VUSB register structure */
+struct vusb20 {
+	union {
+		struct {
+			usb_register	id;
+			usb_register	hw_general;
+			usb_register	hw_host;
+			usb_register	hw_device;
+			usb_register	hw_txbuf;
+			usb_register	hw_rxbuf;
+		} id;
+
+		struct {
+			usb_register	caplength_hciver;
+			usb_register	hcs_params;
+					/* HC structural parameters */
+			usb_register	hcc_params;
+					/* HC Capability Parameters */
+			usb_register	reserved1[5];
+			usb_register	dci_version;
+					/* DC version number and resv'd bits */
+			usb_register	dcc_params;
+					/* DC Capability Parameters */
+		} capab;
+
+		struct {
+			usb_register	usb_cmd;	/* Command register */
+			usb_register	usb_sts;	/* Status register */
+			usb_register	usb_intr;	/* Interrupt enable */
+			usb_register	usb_frindex;	/* Frame index */
+			usb_register	ctrldssegment;
+					/* 4G segment selector */
+			usb_register	device_addr;	/* Device Address */
+			usb_register	ep_list_addr;
+					/* Endpoint List Address */
+			usb_register	reserved0[9];
+			usb_register	config_flag;
+					/* Configured Flag register */
+			usb_register	portscx[VUSBHS_MAX_PORTS];
+					/* Port Status/Control x, x = 1..8 */
+			usb_register	otgsc;
+			usb_register	usb_mode;
+					/* USB Host/Device mode */
+			usb_register	ep_setup_stat;
+					/* Endpoint Setup Status */
+			usb_register	ep_prime;
+					/* Endpoint Initialize */
+			usb_register	ep_flush;
+					/* Endpoint De-initialize */
+			usb_register	ep_status;
+					/* Endpoint Status */
+			usb_register	ep_complete;
+					/* Endpoint Interrupt On Complete */
+			usb_register	ep_ctrlx[16];
+					/* Endpoint Control, where x = 0..15 */
+		} op_dev;
+
+		struct {
+			usb_register	usb_cmd;	/* Command register */
+			usb_register	usb_sts;	/* Status register */
+			usb_register	usb_intr;	/* Interrupt enable */
+			usb_register	usb_frindex;	/* Frame index */
+			usb_register	ctrldssegment;
+					/* 4G segment selector */
+			usb_register	periodic_list_base_addr;
+					/* Periodic schedule list */
+			usb_register	curr_async_list_addr;
+					/* Current Asynch schedule list */
+			usb_register	asyncttsts;
+					/* Async buf in embedded TT control */
+			usb_register	reserved0[8];
+			usb_register	config_flag;
+					/* Configured Flag register */
+			usb_register	portscx[VUSBHS_MAX_PORTS];
+					/* Port Status/Control x, x = 1..8 */
+			usb_register	otgsc;
+					/* OTG status and control register */
+			usb_register	usb_mode;
+					/* USB Host/Device mode */
+		} op_host;
+	} regs;
+};
+
+struct vusb20_ep_queue_head {
+	u32	max_pkt_length;	/* Bits 16..26 Bit 15 is Interrupt
+				 * On Setup
+				 */
+	u32	curr_dtd_ptr;	/* Current dTD Pointer */
+	u32	next_dtd_ptr;	/* Next dTD Pointer */
+	u32	size_ioc_int_sts; /* Total bytes (16..30), IOC (15),
+				   * INT (8), STS (0-7)
+				   */
+	u32	buff_ptr0;	/* Buffer pointer Page 0 (12-31) */
+	u32	buff_ptr1;	/* Buffer pointer Page 1 (12-31) */
+	u32	buff_ptr2;	/* Buffer pointer Page 2 (12-31) */
+	u32	buff_ptr3;	/* Buffer pointer Page 3 (12-31) */
+	u32	buff_ptr4;	/* Buffer pointer Page 4 (12-31) */
+	u32	reserved1;
+	u8	setup_buffer[8]; /* 8 bytes of setup data that
+				  * follows the Setup PID
+				  */
+	u32	reserved2[4];
+};
+
+struct scratch {
+	void *	private;
+	void	( * free)(void *);
+	void *	xd_for_this_dtd;
+};
+
+struct vusb20_ep_tr {
+	u32		next_tr_elem_ptr; /* Memory address of next
+					   * dTD to be processed (5-31)
+					   * and the T (bit 0) indicating
+					   * pointer validity
+					   */
+	u32		size_ioc_sts;	/* Total bytes (16-30),
+					 * IOC (15), Status (0-7)
+					 */
+	u32		buff_ptr0;	/* Buffer pointer Page 0 */
+	u32		buff_ptr1;	/* Buffer pointer Page 1 */
+	u32		buff_ptr2;	/* Buffer pointer Page 2 */
+	u32		buff_ptr3;	/* Buffer pointer Page 3 */
+	u32		buff_ptr4;	/* Buffer pointer Page 4 */
+	struct scratch *scratch_ptr;
+};
+
+struct ehci_itd {
+	u32		next_link_ptr;	/* (5-31) Memory address of
+					 * next schedule data structure
+					 * item Type (1..2 ) and the
+					 * T (bit 0) indicating pointer
+					 * validity
+					 */
+	u32		tr_status_ctl_list[8];	/* bits 31-28: Status,
+						 * bits 27-16: Tr X length
+						 * bit 15: Int on complete
+						 * bits 14-12: Page Select
+						 * bits 11-0: Tr X offset
+						 */
+	u32		buffer_page_ptr_list[7]; /* bits 31-12 4K aligned
+						  * pointer to physical memory
+						  * bits 11-8 endpoint no.
+						  * bit 7: reserved
+						  * bits 6-0 device address
+						  */
+	struct scratch *scratch_ptr;
+	void *		pipe_descr_for_this_itd;
+	void *		pipe_tr_descr_for_this_itd;
+	u32 *		frame_list_ptr;
+	u32		number_of_transactions;
+
+	/* 32-byte aligned structures */
+	u32		reserved[11];
+};
+
+struct ehci_sitd {
+	u32		next_link_ptr;	/* (5-31) Memory address of
+					 * next schedule data structure
+					 * item Type (1..2 ) and the
+					 * T (bit 0) indicating pointer
+					 * validity
+					 */
+	u32		ep_capab_charac; /* bits 31: Direction (I/O),
+					  * bits 30-24: Port number
+					  * bit 23: reserved
+					  * bits 22-16: Hub address
+					  * bits 15-12: Reserved
+					  * bits 11-8: Endpoint number
+					  * bit 7: reserved
+					  * bits 6-0: device address
+					  */
+	u32		uframe_sched_ctl; /* bits 31-16: reserved
+					   * bits 15-8: Split completion mask
+					   * bits 7-0: Split start mask
+					   */
+	u32		transfer_state;	/* bit 31: int on complete
+					 * bit 30: Page Select
+					 * bits 29-26: Reserved
+					 * bits 25-16: total bytes to
+					 * transfer
+					 * bits 15-8: uframe
+					 * complete-split progress mask
+					 * bits 7-0: status
+					 */
+	u32		buffer_ptr_0;	/* bits 31-12: 4K aligned pointer
+					 * to physical memory
+					 * bits 11-0: Current offset
+					 */
+	u32		buffer_ptr_1;	/* bits 31-12: 4K aligned pointer
+					 * to physical memory
+					 * bits 11-5 reserved
+					 * bits 4-3 tr position
+					 * bits 2-0 tr count
+					 */
+	u32		back_link_ptr;	/* bits 31-5 back pointer points to sITD
+					 * bits 4-1: reserved
+					 * bit 0: terminate
+					 */
+	struct scratch *scratch_ptr;
+	void *		pipe_descr_for_this_sitd;
+	void *		pipe_tr_descr_for_this_sitd;
+	u32 *		frame_list_ptr;
+
+	/* align to 16 word boundry */
+	u32		reserved[5];
+};
+
+struct ehci_qtd {
+	u32		next_qtd_ptr;	/* (5-31) Memory address of
+					 * next qTD to be processed
+					 * (4..1) reserved
+					 * T (bit 0) indicating pointer
+					 * validity
+					 */
+	u32		alt_next_qtd_ptr; /* bits 31-5: alternate next
+					   * qTD if the above one encounters
+					   * a short packet
+					   * (4..1) reserved
+					   * T (bit 0) indicating pointer
+					   * validity
+					   */
+	u32		token;		/* bits 31: data toggle
+					 * bits 30-16: Total bytes to transfer
+					 * bit 15: Interrupt on Complete
+					 * bits 14-12: Current page
+					 * bits 11-10: Error Counter
+					 * bits 9-8: PID code
+					 * bits 7-0: status
+					 */
+	u32		buffer_ptr_0;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: Current Offset
+					 */
+	u32		buffer_ptr_1;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	u32		buffer_ptr_2;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	u32		buffer_ptr_3;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	u32		buffer_ptr_4;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	struct scratch *scratch_ptr;
+	void *		pipe_descr_for_this_qtd;
+	void *		pipe_tr_descr_for_this_qtd;
+
+	u32		reserved[5];
+};
+
+struct ehci_qh {
+	u32		horiz_link_tpr;	/* (5-31) Memory address of
+					 * next data object to be processed
+					 * (4..3) reserved
+					 * (2..1) type of the item
+					 * T (bit 0) indicating pointer
+					 * validity
+					 */
+	u32		ep_capab_charac1; /* bits 31-28: NAK count reload,
+					   * bit 27: Control endpoint flag
+					   * bit 26-16: Maximum packet length
+					   * bit 15: Head of reclamation
+					   * list flag
+					   * bit 14: data toggle control
+					   * bits 13-12: endpoint speed
+					   * bit 11-8: endpoint number
+					   * bits 7: Inactivate on next tr
+					   * bits 6-0: Device address
+					   */
+	u32		ep_capab_charac2; /* bits 31-30: High-BW pipe
+					   * Multiplier,
+					   * bit 29-23: Port number
+					   * bit 22-16: Hub address
+					   * bit 15-8: Split completion mask
+					   * bit 7-0: Interrupt schedule mask
+					   */
+	u32		curr_qtd_link_ptr;/* bits 31-5: physical memory address
+					   * of the current xaction processed
+					   */
+	u32		next_qtd_link_ptr;/* bits 31-5: physical memory address
+					   * of the current xaction processed
+					   * bit 0: Terminate bit
+					   */
+	u32		alt_next_qtd_link_ptr; /* bits 31-5: physical memory
+						* address of the current
+						* xaction processed
+						* bits 4-1: NAK counter
+						* bit 0: Terminate bit
+						*/
+	u32		status;		/* bit 31: data-toggle
+					 * bits 30-16: total bytes to transfer
+					 * bit 15: Interrupt on complete
+					 * bits 11-10: Error counter
+					 * bit 0: Ping state/Err
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	u32		buffer_ptr_0;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	u32		buffer_ptr_1;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 7-0: Split-transaction,
+					 * complete-split progress
+					 */
+	u32		buffer_ptr_2;	/* bits 31-12: 4K-page aligned
+					 * physical memory address
+					 * bits 11-5: S-bytes
+					 * bits 4-0: Split-transaction
+					 * frame tag
+					 */
+	u32		buffer_ptr_3;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	u32		buffer_ptr_4;	/* bit 31-12: 4K-page aligned
+					 * physical memory address
+					 * bit 11-0: reserved
+					 */
+	struct scratch *scratch_ptr;
+	void *		pipe_descr_for_this_qh;
+
+	u32		reserved[18];
+};
+
+struct ehci_fstn {
+	u32		normal_path_link_ptr;	/* (5-31) Memory address of
+						 * next data object to be
+						 * processed in the periodic
+						 * list
+						 * bits 4-3: reserved
+						 * (2..1) type of the item
+						 * T (bit 0) indicating pointer
+						 * validity
+						 */
+	u32		back_path_link_ptr;	/* bits 31-5: Memory address of
+						 * the queue head,
+						 * bit 4-3: reserved
+						 * (2..1) type of the item
+						 * T (bit 0) indicating pointer
+						 * validity
+						 */
+	struct scratch *scratch_ptr;
+
+	/* 32-bytes aligned */
+	u32		reserved[6];
+};
+
+struct frame_bw {
+	u32		allocated_bw;	/* Allocated bandwidth for this
+					 * frame/uframe
+					 */
+};
+
+#endif
diff --git a/drivers/usb/gadget/pmc-sierra/Makefile b/drivers/usb/gadget/pmc-sierra/Makefile
new file mode 100644
index 0000000..0e1850f
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/Makefile
@@ -0,0 +1,4 @@
+#
+#  Makefile for PMC MSP71XX USB peripheral controller driver
+#
+obj-$(CONFIG_USB_MSP71XX)	+= msp71xx_udc.o
diff --git a/drivers/usb/gadget/pmc-sierra/msp71xx_dev.c b/drivers/usb/gadget/pmc-sierra/msp71xx_dev.c
new file mode 100644
index 0000000..0de95ef
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/msp71xx_dev.c
@@ -0,0 +1,1192 @@
+/*
+ * msp71xx_dev.c -- This file contains all the chapter 9 handling routines
+ *		and service handlers for handling bus reset, suspend and
+ *		endpoints completion functions
+ *
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/usb/cdc.h>
+
+#include "usb.h"
+#include "devapi.h"
+#include "msp71xx_dev.h"
+#include "usbprv_dev.h"
+#include "debug.c"
+#include "debug.h"
+
+/*
+ * Local Constants
+ */
+#define APP_CONTROL_MAX_PKT_SIZE	64
+#define DEV_DESC_MAX_PACKET_SIZE	7
+#define EP1_FS_MAX_TX_PACKET_SIZE	64
+#define EP1_FS_MAX_RX_PACKET_SIZE	64
+
+#define EP1_HS_MAX_TX_PACKET_SIZE	512
+#define EP1_HS_MAX_RX_PACKET_SIZE	512
+
+#define EP2_FS_MAX_TX_PACKET_SIZE	64
+#define EP2_FS_MAX_RX_PACKET_SIZE	64
+#define EP2_HS_MAX_TX_PACKET_SIZE	512
+#define EP2_HS_MAX_RX_PACKET_SIZE	512
+
+#define DEV_MAX_CFG			4
+
+/*
+ * Local Variables
+ */
+
+/* A temporary buffer for control enpoint to send data */
+static u8 * ep_temp_buf;
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_get_status
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Get Status command
+ *
+ * INPUTS:	handle - (pointer to) USB device handle
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *	Chapter 9 GetStatus command
+ *	wValue=Zero
+ *	wIndex=Zero
+ *	wLength=1
+ *	DATA=bmERR_STAT
+ *	The GET_STATUS command is used to read the bmERR_STAT register.
+ *
+ *	Return the status based on the bRrequestType bits:
+ *	device (0) = bit 0 = 1 = self powered
+ *		bit 1 = 0 = DEVICE_REMOTE_WAKEUP which can be modified
+ *	with a SET_FEATURE/CLEAR_FEATURE command.
+ *	interface(1) = 0000.
+ *	endpoint(2) = bit 0 = stall.
+ *	static u8 * pData;
+ *
+ *	See section 9.4.5 (page 190) of the USB 1.1 Specification.
+ *
+ ***************************************************************************/
+static void ch9_get_status(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	u16 temp_status;
+	struct usb_dev_state * usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	if (setup) {
+		switch (setup_ptr->request_type) {
+		case (USB_RECIP_DEVICE | USB_DIR_IN):
+			/* Device request */
+			_usb_device_get_status(handle, USB_STATUS_DEVICE,
+						(u16 *)&temp_status);
+			usb_dev_ptr->usb_status[0] = temp_status & 0xFF;
+			usb_dev_ptr->usb_status[1] = (temp_status >> 8) & 0xFF;
+			/* Send the requested data */
+			_usb_device_send_data(handle, 0,
+					(u8 *)&usb_dev_ptr->usb_status[0],
+					2 /* two bytes */);
+			break;
+
+		case (USB_RECIP_INTERFACE | USB_DIR_IN):
+			/* Interface request */
+			usb_dev_ptr->if_status = usb_dev_ptr->usb_if_alt[
+						setup_ptr->index & 0x0003];
+
+			/* Send the requested data */
+			_usb_device_send_data(handle, 0,
+					(void *)&usb_dev_ptr->if_status,
+					sizeof(usb_dev_ptr->if_status));
+			break;
+
+		case (USB_RECIP_ENDPOINT | USB_DIR_IN):
+			/* Endpoint request */
+			usb_dev_ptr->endpoint = setup_ptr->index &
+					USB_STATUS_ENDPOINT_NUMBER_MASK;
+
+			_usb_device_get_status(handle, USB_STATUS_ENDPOINT |
+					usb_dev_ptr->endpoint, &temp_status);
+
+			/*
+			 * copy status to usb_status global buffer for
+			 * uncached access
+			*/
+			usb_dev_ptr->usb_status[0] = temp_status & 0xFF;
+			usb_dev_ptr->usb_status[1] = (temp_status >> 8) & 0xFF;
+
+			/* Send the requested data */
+			_usb_device_send_data(handle, 0,
+					(u8 *)&usb_dev_ptr->usb_status[0],
+					2 /* sizeof(usb_status) */);
+			break;
+
+		default:
+			/* Unknown request */
+			_usb_device_stall_endpoint(handle, 0, 0);
+			return;
+
+		}
+
+		/* status phase */
+		_usb_device_recv_data(handle, 0, 0, 0);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_clear_feature
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Clear Feature command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void ch9_clear_feature(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	static u8 endpoint;
+	u16 usb_status;
+
+	_usb_device_get_status(handle, USB_STATUS_DEVICE_STATE, &usb_status);
+
+	if ((usb_status != USB_STATE_CONFIG) &&
+	    (usb_status != USB_STATE_ADDRESS)) {
+		_usb_device_stall_endpoint(handle, 0, 0);
+		return;
+	}
+
+	if (setup) {
+		switch (setup_ptr->request_type) {
+		case USB_RECIP_DEVICE:
+			/* DEVICE */
+			if (setup_ptr->value == 1) {
+				/* clear remote wakeup */
+				_usb_device_get_status(handle,
+					USB_STATUS_DEVICE, &usb_status);
+				usb_status &= ~USB_REMOTE_WAKEUP;
+				_usb_device_set_status(handle,
+					USB_STATUS_DEVICE, usb_status);
+			} else {
+				_usb_device_stall_endpoint(handle, 0, 0);
+				return;
+			}
+			break;
+
+		case USB_RECIP_ENDPOINT:
+			/* ENDPOINT */
+			if (setup_ptr->value != 0) {
+				_usb_device_stall_endpoint(handle, 0, 0);
+				return;
+			}
+			endpoint = setup_ptr->index &
+					USB_STATUS_ENDPOINT_NUMBER_MASK;
+			_usb_device_get_status(handle,
+					USB_STATUS_ENDPOINT | endpoint,
+					&usb_status);
+			/* unstall */
+			_usb_device_set_status(handle,
+					USB_STATUS_ENDPOINT | endpoint,
+					0);
+			break;
+		default:
+			_usb_device_stall_endpoint(handle, 0, 0);
+			return;
+		}
+
+		/* status phase */
+		_usb_device_send_data(handle, 0, 0, 0);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_set_feature
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Set Feature command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void ch9_set_feature(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	u16 usb_status;
+	u8 endpoint;
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	if (setup) {
+		switch (setup_ptr->request_type) {
+		case USB_RECIP_DEVICE:
+			/* DEVICE */
+			switch (setup_ptr->value) {
+			case USB_DEVICE_REMOTE_WAKEUP:
+				/* set remote wakeup */
+				_usb_device_get_status(handle,
+					USB_STATUS_DEVICE, &usb_status);
+				usb_status |= USB_REMOTE_WAKEUP;
+				_usb_device_set_status(handle,
+					USB_STATUS_DEVICE, usb_status);
+				break;
+			case USB_DEVICE_TEST_MODE:
+				/* Test Mode */
+				if (setup_ptr->index & 0x00FF) {
+					_usb_device_stall_endpoint(
+							handle, 0, 0);
+					return;
+				}
+				_usb_device_get_status(handle,
+						USB_STATUS_DEVICE_STATE,
+						&usb_status);
+				if ((usb_status == USB_STATE_CONFIG) ||
+				    (usb_status == USB_STATE_ADDRESS) ||
+				    (usb_status == USB_STATE_DEFAULT)) {
+					usb_dev_ptr->enter_test_mode = true;
+					usb_dev_ptr->test_mode_index =
+						setup_ptr->index & 0xFF00;
+				} else {
+					_usb_device_stall_endpoint(
+						handle, 0, 0);
+					return;
+				}
+				break;
+			default:
+				_usb_device_stall_endpoint(handle, 0, 0);
+				return;
+			}
+		break;
+
+		case USB_RECIP_ENDPOINT:
+			/* ENDPOINT */
+			if (setup_ptr->value != 0) {
+				_usb_device_stall_endpoint(handle, 0, 0);
+				return;
+			}
+			endpoint = setup_ptr->index &
+					USB_STATUS_ENDPOINT_NUMBER_MASK;
+			_usb_device_get_status(handle,
+					USB_STATUS_ENDPOINT | endpoint,
+					&usb_status);
+			/* set stall */
+			_usb_device_set_status(handle,
+					USB_STATUS_ENDPOINT | endpoint,
+					1);
+			break;
+
+		default:
+			_usb_device_stall_endpoint(handle, 0, 0);
+			return;
+		}
+
+		/* status phase */
+		_usb_device_send_data(handle, 0, 0, 0);
+	}
+
+	if (usb_dev_ptr->enter_test_mode) {
+		/* Enter Test Mode */
+		_usb_device_set_status(handle, USB_STATUS_TEST_MODE,
+					usb_dev_ptr->test_mode_index);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_set_address
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Set Address command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	We setup a TX packet of 0 length ready for the IN token
+ *		Once we get the TOK_DNE interrupt for the IN token, then
+ *		we change the ADDR register and go to the ADDRESS state.
+ *
+ ***************************************************************************/
+static void ch9_set_address(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	static u8 new_address;
+	u32 max_pkt_tx_size1;
+	u32 max_pkt_rx_size1;
+	u32 max_pkt_tx_size2;
+	u32 max_pkt_rx_size2;
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+	struct msp71xx_udc *dev;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	/* get device handle */
+	dev = msp71xx_get_dev_ptr();
+
+	if (setup) {
+		new_address = setup_ptr->value;
+		/* ack */
+		_usb_device_send_data(handle, 0, 0, 0);
+	} else {
+		_usb_device_set_status(handle,
+			USB_STATUS_ADDRESS, new_address);
+		_usb_device_set_status(handle,
+			USB_STATUS_DEVICE_STATE, USB_STATE_ADDRESS);
+
+		if (usb_dev_ptr->speed == USB_DEV_SPEED_HIGH) {
+			max_pkt_tx_size1 = EP1_HS_MAX_TX_PACKET_SIZE;
+			max_pkt_rx_size1 = EP1_HS_MAX_RX_PACKET_SIZE;
+			max_pkt_tx_size2 = EP2_HS_MAX_TX_PACKET_SIZE;
+			max_pkt_rx_size2 = EP2_HS_MAX_RX_PACKET_SIZE;
+		} else {
+			max_pkt_tx_size1 = EP1_FS_MAX_TX_PACKET_SIZE;
+			max_pkt_rx_size1 = EP1_FS_MAX_RX_PACKET_SIZE;
+			max_pkt_tx_size2 = EP2_FS_MAX_TX_PACKET_SIZE;
+			max_pkt_rx_size2 = EP2_FS_MAX_RX_PACKET_SIZE;
+		}
+
+		/* initialize bulk endpoints */
+		if (dev) {
+			printk(KERN_INFO "max pkt size rx %8x tx %8x\r\n",
+				(u32)max_pkt_rx_size1,
+				(u32)max_pkt_tx_size1);
+			_usb_device_init_endpoint(handle,
+				dev->ep[EP_1_OUT].num, max_pkt_rx_size1,
+				USB_RECV, USB_BULK_ENDPOINT,
+				USB_DEVICE_DONT_ZERO_TERMINATE);
+			_usb_device_init_endpoint(handle,
+				dev->ep[EP_1_IN].num, max_pkt_tx_size1,
+				USB_SEND, USB_BULK_ENDPOINT,
+				USB_DEVICE_DONT_ZERO_TERMINATE);
+
+			/* initialize interrupt endpoints */
+			_usb_device_init_endpoint(handle,
+				dev->ep[EP_2_OUT].num, max_pkt_rx_size2,
+				USB_RECV, USB_INTERRUPT_ENDPOINT,
+				USB_DEVICE_DONT_ZERO_TERMINATE);
+			_usb_device_init_endpoint(handle,
+				dev->ep[EP_2_IN].num, max_pkt_tx_size2,
+				USB_SEND, USB_INTERRUPT_ENDPOINT,
+				USB_DEVICE_DONT_ZERO_TERMINATE);
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_get_descriptor
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Get Description command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	The Device Request can ask for
+ *		Device/Config/string/interface/endpoint
+ *		descriptors (via wValue).
+ *		We then post an IN response to return the
+ *		requested descriptor. And then wait for the
+ *		OUT which terminates the control transfer.
+ *
+ ***************************************************************************/
+static void ch9_get_descriptor(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	/* status phase */
+	_usb_device_recv_data(handle, 0, 0, 0);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_set_descriptor
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Set Description command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES
+ *
+ ***************************************************************************/
+static void ch9_set_descriptor(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	_usb_device_send_data(handle, 0, 0, 0);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_get_config
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Get Configuration command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void ch9_get_config(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	/* Return the currently selected configuration */
+	if (setup) {
+		/* status phase */
+		_usb_device_recv_data(handle, 0, 0, 0);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_set_config
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Set Configuration command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void ch9_set_config(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	u16 usb_state;
+
+	if (setup) {
+		if ((setup_ptr->value & 0x00FF) > DEV_MAX_CFG) {
+			/* generate stall */
+			_usb_device_stall_endpoint(handle, 0, 0);
+			return;
+		}
+
+		/* 0 indicates return to unconfigured state */
+		if ((setup_ptr->value & 0x00FF) == 0) {
+			_usb_device_get_status(handle,
+				USB_STATUS_DEVICE_STATE, &usb_state);
+			if ((usb_state == USB_STATE_CONFIG) ||
+			    (usb_state == USB_STATE_ADDRESS)) {
+				/* clear the currently selected config value */
+				_usb_device_set_status(handle,
+					USB_STATUS_CURRENT_CONFIG, 0);
+				_usb_device_set_status(handle,
+					USB_STATUS_DEVICE_STATE,
+					USB_STATE_ADDRESS);
+				/* status phase */
+				_usb_device_send_data(handle, 0, 0, 0);
+			} else
+				_usb_device_stall_endpoint(handle, 0, 0);
+			return;
+		}
+
+		/*
+		 * If the configuration value (setup_ptr->value & 0x00FF)
+		 * differs from the current configuration value, then
+		 * endpoints must be reconfigured to match the new device
+		 * configuration
+		 */
+		_usb_device_get_status(handle, USB_STATUS_CURRENT_CONFIG,
+					&usb_state);
+		if (usb_state != (setup_ptr->value & 0x00FF)) {
+			/* Reconfigure endpoints here */
+			_usb_device_set_status(handle,
+					USB_STATUS_CURRENT_CONFIG,
+					setup_ptr->value & 0x00FF);
+			_usb_device_set_status(handle,
+					USB_STATUS_DEVICE_STATE,
+					USB_STATE_CONFIG);
+			/* status phase */
+			_usb_device_send_data(handle, 0, 0, 0);
+			return;
+		}
+		_usb_device_set_status(handle, USB_STATUS_DEVICE_STATE,
+					USB_STATE_CONFIG);
+
+		/* status phase */
+		_usb_device_send_data(handle, 0, 0, 0);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_get_interface
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Get Interface command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void ch9_get_interface(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	if (setup) {
+		/* status phase */
+		_usb_device_recv_data(handle, 0, 0, 0);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_set_interface
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Set Interface command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void ch9_set_interface(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	/* status phase */
+	_usb_device_send_data(handle, 0, 0, 0);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_synch_frame
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 Synch Frame command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		setup_ptr - pointer to setup packet
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void ch9_synch_frame(
+	_usb_device_handle handle,
+	bool setup,
+	struct setup * setup_ptr)
+{
+	if (setup) {
+		if (setup_ptr->request_type != 0x02) {
+			_usb_device_stall_endpoint(handle, 0, 0);
+			return;
+		}
+
+		_usb_device_get_status(handle, USB_STATUS_SOF_COUNT,
+					(u16 *)ep_temp_buf);
+		_usb_device_send_data(handle, 0, ep_temp_buf,
+				min((size_t)setup_ptr->length, sizeof(u16)));
+
+		/* status phase */
+		_usb_device_recv_data(handle, 0, 0, 0);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ch9_class
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Executes the Chapter 9 specific class driver command
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void ch9_class(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct msp71xx_udc *dev;
+	int status;
+	struct setup * setup_ptr;
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/* get device handle */
+	dev = msp71xx_get_dev_ptr();
+
+	if (setup) {
+		/* This spin_lock is locked in the msp71xx_udc_irq() */
+		spin_unlock (&dev->lock);
+		status = 0;
+		if (dev) {
+			setup_ptr = &usb_dev_ptr->local_setup_packet;
+			/*
+			 * Preserve little endian setup value, length,
+			 * index for driver->setup function.
+			 */
+			setup_ptr->value = USB_WORD_SWAP(setup_ptr->value);
+			setup_ptr->length = USB_WORD_SWAP(setup_ptr->length);
+			setup_ptr->index = USB_WORD_SWAP(setup_ptr->index);
+			if (dev->driver)
+				status = dev->driver->setup(&dev->gadget,
+					(const struct usb_ctrlrequest *)
+					&usb_dev_ptr->local_setup_packet);
+
+			/* restore big endian setup value, length, index */
+			setup_ptr->value = USB_WORD_SWAP(setup_ptr->value);
+			setup_ptr->length = USB_WORD_SWAP(setup_ptr->length);
+			setup_ptr->index = USB_WORD_SWAP(setup_ptr->index);
+		}
+		if (status)
+			_usb_device_stall_endpoint(handle, 0, 0);
+
+		/* This spin_lock will be unlocked in the msp71xx_udc_irq() */
+		spin_lock (&dev->lock);
+		switch (usb_dev_ptr->local_setup_packet.request) {
+		case USB_CDC_SEND_ENCAPSULATED_COMMAND:
+			/* status phase */
+			_usb_device_send_data(handle, 0, 0, 0);
+			break;
+		case USB_CDC_GET_ENCAPSULATED_RESPONSE:
+			/* status phase */
+			_usb_device_recv_data(handle, 0, 0, 0);
+			break;
+		default:
+			_usb_device_stall_endpoint(handle, 0, 0);
+			break;
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: service_ep0
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles endpoint 0 interrupt event
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void service_ep0(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct msp71xx_udc *dev;
+	int status;
+	int flag;
+	struct setup * setup_ptr;
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	setup_ptr = &usb_dev_ptr->local_setup_packet;
+
+	/* get device handle */
+	dev = msp71xx_get_dev_ptr();
+	flag = 0;
+
+	if (setup)
+		_usb_device_read_setup_data(handle, 0, (u8 *)setup_ptr);
+
+	if (setup_ptr->request_type & USB_DIR_IN)
+		dev->ep[EP_0].is_in = 1;
+	else
+		dev->ep[EP_0].is_in = 0;
+
+	switch (setup_ptr->request_type &
+		(USB_TYPE_CLASS | USB_TYPE_VENDOR)) {
+	case USB_TYPE_STANDARD:
+		switch (setup_ptr->request) {
+		case USB_REQ_GET_STATUS:
+			ch9_get_status(handle, setup, setup_ptr);
+			break;
+
+		case USB_REQ_CLEAR_FEATURE:
+			ch9_clear_feature(handle, setup, setup_ptr);
+			break;
+
+		case USB_REQ_SET_FEATURE:
+			ch9_set_feature(handle, setup, setup_ptr);
+			break;
+
+		case USB_REQ_SET_ADDRESS:
+			ch9_set_address(handle, setup, setup_ptr);
+			break;
+
+		/* Let upper layer handles this */
+		case USB_REQ_SET_DESCRIPTOR:
+			ch9_set_descriptor(handle, setup, setup_ptr);
+			/* fall through */
+
+		case USB_REQ_SET_CONFIGURATION:
+		case USB_REQ_SET_INTERFACE:
+		case USB_REQ_GET_CONFIGURATION:
+		case USB_REQ_GET_INTERFACE:
+		case USB_REQ_GET_DESCRIPTOR:
+			if (setup) {
+				/*
+				 * This spin_lock is locked in the
+				 * msp71xx_udc_irq()
+				 */
+				spin_unlock (&dev->lock);
+				status = 0;
+				if (dev) {
+					/*
+					 * Preserve little endian setup value,
+					 * length, index for driver->setup
+					 * function.
+					 */
+					setup_ptr->value = USB_WORD_SWAP(
+							setup_ptr->value);
+					setup_ptr->length = USB_WORD_SWAP(
+							setup_ptr->length);
+					setup_ptr->index = USB_WORD_SWAP(
+							setup_ptr->index);
+
+					if (dev->driver)
+						status = dev->driver->setup(
+							&dev->gadget,
+							(const struct
+							 usb_ctrlrequest*)
+							 setup_ptr);
+					/*
+					 * restore big endian setup value,
+					 * length, index
+					 */
+					setup_ptr->value = USB_WORD_SWAP(
+							setup_ptr->value);
+					setup_ptr->length = USB_WORD_SWAP(
+							setup_ptr->length);
+					setup_ptr->index = USB_WORD_SWAP(
+							setup_ptr->index);
+				}
+				if (status)
+					_usb_device_stall_endpoint(handle,
+								0, 0);
+				else {
+					/* send ack */
+					switch (setup_ptr->request) {
+					case USB_REQ_GET_DESCRIPTOR:
+						ch9_get_descriptor(handle,
+							setup, setup_ptr);
+						break;
+					case USB_REQ_SET_CONFIGURATION:
+						ch9_set_config(handle,
+							setup, setup_ptr);
+						break;
+					case USB_REQ_SET_INTERFACE:
+						ch9_set_interface(handle,
+							setup, setup_ptr);
+						break;
+					case USB_REQ_GET_CONFIGURATION:
+						ch9_get_config(handle,
+							setup, setup_ptr);
+						break;
+					case USB_REQ_GET_INTERFACE:
+						ch9_get_interface(handle,
+							setup, setup_ptr);
+						break;
+					case USB_REQ_SET_DESCRIPTOR:
+						ch9_set_descriptor(handle,
+							setup, setup_ptr);
+						break;
+					default:
+						break;
+					}
+				}
+				/*
+				 * This spin_lock will be unlocked in the
+				 * msp71xx_udc_irq()
+				 */
+				spin_lock(&dev->lock);
+			}
+			break;
+
+		case USB_REQ_SYNCH_FRAME:
+			ch9_synch_frame(handle, setup, setup_ptr);
+			break;
+
+		default:
+			_usb_device_stall_endpoint(handle, 0, 0);
+			break;
+		}
+		break;
+
+	case USB_TYPE_CLASS:
+		/* class specific request */
+		if (setup)
+			ch9_class(handle, setup, direction,
+				(u8 *)setup_ptr, 0, 0);
+		else
+			ch9_class(handle, setup, direction,
+				buffer, length, error);
+		break;
+
+	case USB_TYPE_VENDOR:
+		/* vendor specific request can be handled here */
+		break;
+	}
+
+	if (!setup) {
+		/* service to ep0 bulk in and out */
+		if (dev) {
+			pmc_io_complete(&dev->ep[EP_0], buffer,
+					length, error);
+			pmc_io_advance(&dev->ep[EP_0]);
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: service_ep1
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles endpoint 1 interrupt event
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void service_ep1(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct msp71xx_udc *dev = msp71xx_get_dev_ptr();
+
+	if (!direction) {
+		if (dev) {
+			/* service ep1 bulk out */
+			pmc_io_complete(&dev->ep[EP_1_OUT], buffer,
+					length, error);
+			pmc_io_advance(&dev->ep[EP_1_OUT]);
+		}
+	} else {
+		if (dev) {
+			/* service ep1 bulk in */
+			pmc_io_complete(&dev->ep[EP_1_IN], buffer,
+					length, error);
+			pmc_io_advance(&dev->ep[EP_1_IN]);
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: service_ep2
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles endpoint 2 interrupt event
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void service_ep2(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct msp71xx_udc *dev = msp71xx_get_dev_ptr();
+
+	if (!direction) {
+		if (dev) {
+			/* service ep2 intr out */
+			pmc_io_complete(&dev->ep[EP_2_OUT], buffer,
+					length, error);
+			pmc_io_advance(&dev->ep[EP_2_OUT]);
+		}
+	} else {
+		/* service ep2 intr in */
+		if (dev) {
+			pmc_io_complete(&dev->ep[EP_2_IN], buffer,
+					length, error);
+			pmc_io_advance(&dev->ep[EP_2_IN]);
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: service_speed
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles speed detection interrupt event
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void service_speed(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct msp71xx_udc *dev;
+	enum usb_device_speed sp;
+	u8 flag;
+	struct usb_dev_state * usb_dev_ptr;
+	u8 speed;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+	flag = 0;
+	dev = msp71xx_get_dev_ptr();
+	usb_dev_ptr->speed = length;
+	speed = length;
+
+	sp = USB_SPEED_HIGH;
+	if (speed == USB_DEV_SPEED_LOW) {
+		sp = USB_SPEED_LOW;
+		flag = 1;
+	} else if (speed == USB_DEV_SPEED_FULL) {
+		sp = USB_SPEED_FULL;
+		flag = 1;
+	} else if (speed == USB_DEV_SPEED_HIGH) {
+		sp = USB_SPEED_HIGH;
+		flag = 1;
+	}
+	if (dev)
+		dev->gadget.speed = sp;
+	if (!flag)
+		printk(KERN_WARNING "Speed not detected %8x, "
+			"using Default High Speed\r\n", sp);
+	else
+		printk(KERN_INFO "Speed detected %8x\r\n", sp);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: service_suspend
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles suspend detection interrupt event
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void service_suspend(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: reset_ep0
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles bus reset interrupt event
+ *
+ * INPUTS:	handle    - (pointer to) USB device handle
+ *		setup     - setup phase
+ *		direction - transmit or receive
+ *		buffer    - (pointer) to buffer
+ *		length    - length of transfer
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:
+ *
+ ***************************************************************************/
+static void reset_ep0(
+	_usb_device_handle handle,
+	bool setup,
+	u8 direction,
+	u8 * buffer,
+	u32 length,
+	u8 error)
+{
+	struct usb_dev_state * usb_dev_ptr;
+
+	usb_dev_ptr = (struct usb_dev_state *)handle;
+
+	/*
+	 * on a reset always ensure all transfers are cancelled on
+	 * control EP
+	 */
+	_usb_device_cancel_transfer(handle, 0, USB_RECV);
+	_usb_device_cancel_transfer(handle, 0, USB_SEND);
+
+	/* Initialize the endpoint 0 in both directions */
+	_usb_device_init_endpoint(handle, 0, APP_CONTROL_MAX_PKT_SIZE,
+				USB_RECV, USB_CONTROL_ENDPOINT, 0);
+	_usb_device_init_endpoint(handle, 0, APP_CONTROL_MAX_PKT_SIZE,
+				USB_SEND, USB_CONTROL_ENDPOINT, 0);
+}
diff --git a/drivers/usb/gadget/pmc-sierra/msp71xx_dev.h b/drivers/usb/gadget/pmc-sierra/msp71xx_dev.h
new file mode 100644
index 0000000..32540c5
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/msp71xx_dev.h
@@ -0,0 +1,97 @@
+/*
+ * msp71xx_dev.h -- This file contains all the definitions & declaration
+ *		for the PMC MSP71XX USB peripheral device driver
+ *		for handling chapter 9 commands
+ *
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef MSP71XX_DEV_H
+#define MSP71XX_DEV_H
+
+/*
+ * Constants
+ */
+
+/* endpoint offset for in and out */
+#define EP_0		0
+#define EP_0_OUT	1
+#define EP_1_IN		2
+#define EP_1_OUT	3
+#define EP_2_IN		4
+#define EP_2_OUT	5
+
+/*
+ * Structures and Unions
+ */
+
+/*****************************************************************************
+ * STRUCTURE: setup
+ * ___________________________________________________________________________
+ *
+ * This structure is used to define the setup control packet
+ *
+ * ELEMENTS:
+ *	request_type - request type fields
+ *		first field: USB direction: USB_DIR_IN,
+ *					USB_DIR_OUT
+ *		second field: USB types: USB_TYPE_STANDARD
+ *					USB_TYPE_CLASS
+ *					USB_TYPE_VENDOR
+ *					USB_TYPE_RESERVED
+ *		third field: USB recipients: USB_RECIP_DEVICE
+ *					USB_RECIP_INTERFACE
+ *					USB_RECIP_ENDPOINT
+ *					USB_RECIP_OTHER
+ *	request	- request
+ *		example standard requests:
+ *		USB_REQ_GET_STATUS
+ *		USB_REQ_CLEAR_FEATURE
+ *		USB_REQ_SET_FEATURE
+ *		USB_REQ_SET_ADDRESS
+ *		USB_REQ_GET_DESCRIPTOR
+ *		USB_REQ_SET_DESCRIPTOR
+ *		USB_REQ_GET_CONFIGURATION
+ *		USB_REQ_SET_CONFIGURATION
+ *		USB_REQ_GET_INTERFACE
+ *		USB_REQ_SET_INTERFACE
+ *	value	- value can be the following or any other values
+ *		required by the control request
+ *		USB_DEVICE_SELF_POWERED
+ *		USB_DEVICE_REMOTE_WAKEUP
+ *		USB_DEVICE_TEST_MODE
+ *		USB_DEVICE_BATTERY
+ *		USB_DEVICE_B_HNP_ENABLE
+ *		USB_DEVICE_WUSB_DEVICE
+ *		USB_DEVICE_A_HNP_SUPPORT
+ *		USB_DEVICE_A_ALT_HNP_SUPPORT
+ *		USB_DEVICE_DEBUG_MODE
+ *	index	- index
+ *	length	- length
+ *
+ ****************************************************************************/
+
+/* USB 1.1 Setup Packet */
+struct setup {
+	u8	request_type;
+	u8	request;
+	u16	value;
+	u16	index;
+	u16	length;
+};
+
+#endif /* MSP71XX_DEV_H */
diff --git a/drivers/usb/gadget/pmc-sierra/msp71xx_udc.c b/drivers/usb/gadget/pmc-sierra/msp71xx_udc.c
new file mode 100644
index 0000000..5bb0031
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/msp71xx_udc.c
@@ -0,0 +1,1863 @@
+/*
+ * msp71xx_udc.c -- This file contains all the definitions & declaration
+ *		for the PMC MSP71XX USB peripheral device driver
+ *		This driver should work with some "gadget" drivers,
+ *		including Ethernet/RNDIS gadget drivers as well as
+ *		Gadget Zero.
+ *
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#undef DEBUG	/* messages on error and most fault paths */
+#undef VERBOSE	/* extra debug messages (success too) */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb_gadget.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+
+#include <asm/byteorder.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+#include "devapi.h"
+#include "msp71xx_dev.h"
+#include "usbprv_dev.h"
+#include "msp71xx_udc.h"
+
+#include "arc.c"
+#include "debug.c"
+#include "dev_cncl.c"
+#include "dev_ep_deinit.c"
+#include "dev_main.c"
+#include "dev_recv.c"
+#include "dev_send.c"
+#include "dev_shut.c"
+#include "dev_utl.c"
+#include "vusbhs_dev_cncl.c"
+#include "vusbhs_dev_deinit.c"
+#include "vusbhs_dev_main.c"
+#include "vusbhs_dev_shut.c"
+#include "vusbhs_dev_utl.c"
+#include "msp71xx_dev.c"
+
+#ifdef CONFIG_PMCTWILED
+#include "msp_led_macros.h"
+#endif
+
+/*
+ * Forward References
+ */
+static void nuke(struct msp71xx_udc_ep *);
+static int msp71xx_udc_enable(struct usb_ep *_ep,
+				const struct usb_endpoint_descriptor *desc);
+static int msp71xx_udc_disable(struct usb_ep *_ep);
+static struct usb_request * msp71xx_udc_alloc_request(struct usb_ep *_ep,
+						gfp_t gfp_flags);
+static void msp71xx_udc_free_request(struct usb_ep *_ep,
+					struct usb_request *_req);
+static void * msp71xx_udc_alloc_buffer(struct usb_ep *_ep, unsigned int bytes,
+					dma_addr_t *dma, gfp_t gfp_flags);
+static void msp71xx_udc_free_buffer(struct usb_ep *_ep, void *buf,
+					dma_addr_t dma, unsigned int bytes);
+static int msp71xx_udc_queue(struct usb_ep *_ep,
+				struct usb_request *_req, gfp_t gfp_flags);
+static int msp71xx_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req);
+static int msp71xx_udc_set_halt(struct usb_ep *_ep, int value);
+static void msp71xx_udc_fifo_flush(struct usb_ep *_ep);
+static int msp71xx_udc_get_frame(struct usb_gadget *_gadget);
+static int msp71xx_udc_wakeup(struct usb_gadget *_gadget);
+
+/*
+ * Local Constants
+ */
+#define USE_SYSFS_DEBUG_FILES
+#define DMA_ADDR_INVALID	(~(dma_addr_t)0)
+
+/*
+ * Local Macro Definitions
+ */
+#define DIR_STRING(bAddress)	(((bAddress) & USB_DIR_IN) ? "in" : "out")
+
+/*
+ * Local Structures
+ */
+static const char driver_name[] = "msp71xx_udc";
+static const char driver_desc[] = "PMC MSP71XX USB Peripheral Controller";
+
+static const char ep0in[] = "ep0in";
+static const char ep0out[] = "ep0out";
+static const char ep1in[] = "ep1in-bulk";
+static const char ep1out[] = "ep1out-bulk";
+static const char ep2in[] = "ep2in-intr";
+static const char ep2out[] = "ep2out-intr";
+static const char *ep_name[] = {
+	ep0in, ep0out,
+	ep1in, ep1out,
+	ep2in, ep2out
+};
+
+static struct usb_ep_ops msp71xx_udc_ep_ops = {
+	.enable		= msp71xx_udc_enable,
+	.disable	= msp71xx_udc_disable,
+
+	.alloc_request	= msp71xx_udc_alloc_request,
+	.free_request	= msp71xx_udc_free_request,
+
+	.alloc_buffer	= msp71xx_udc_alloc_buffer,
+	.free_buffer	= msp71xx_udc_free_buffer,
+
+	.queue		= msp71xx_udc_queue,
+	.dequeue	= msp71xx_udc_dequeue,
+
+	.set_halt	= msp71xx_udc_set_halt,
+	.fifo_flush	= msp71xx_udc_fifo_flush,
+};
+
+static const struct usb_gadget_ops msp71xx_udc_ops = {
+	.get_frame	= msp71xx_udc_get_frame,
+	.wakeup		= msp71xx_udc_wakeup,
+};
+
+static struct msp71xx_udc	*the_controller;
+
+/****************************************************************************
+ *
+ * FUNCTION: set_halt
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Halts an endpoint
+ *
+ * INPUTS:	ep - (pointer to) pmc td endpoint structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static inline void set_halt(struct msp71xx_udc_ep *ep)
+{
+	/* ep0 and bulk/intr endpoints */
+	_usb_device_stall_endpoint(ep->dev->handle, ep->num, USB_SEND);
+	_usb_device_stall_endpoint(ep->dev->handle, ep->num, USB_RECV);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: clear_halt
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Clears an endpoint
+ *
+ * INPUTS:	ep - (pointer to) pmc td endpoint structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static inline void clear_halt(struct msp71xx_udc_ep *ep)
+{
+	/* ep0 and bulk/intr endpoints */
+	_usb_device_unstall_endpoint(ep->dev->handle, ep->num, USB_SEND);
+	_usb_device_unstall_endpoint(ep->dev->handle, ep->num, USB_RECV);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_enable
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Enables the endpoint
+ *
+ * INPUTS:	_ep - (pointer to) usb endpoint descriptor structure
+ *		desc - (pointer to) usb endpoint description
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EINVAL
+ *			= ESHUTDOWN
+ *			= EIO
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_enable(
+	struct usb_ep *_ep,
+	const struct usb_endpoint_descriptor *desc)
+{
+	struct msp71xx_udc *dev;
+	struct msp71xx_udc_ep *ep;
+	u32 max, tmp;
+	unsigned long flags;
+	int retval1, retval2, retval = 0;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || !desc || ep->desc ||
+	    _ep->name == ep0in || _ep->name == ep0out ||
+	    desc->bDescriptorType != USB_DT_ENDPOINT)
+		return -EINVAL;
+
+	dev = ep->dev;
+	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+
+	/* get max packet size */
+	max = le16_to_cpu(desc->wMaxPacketSize) & 0x1fff;
+
+	if (ep->num > (MSP71XX_UDC_MAX_ENDPT / 2))
+		return -ERANGE;
+
+	/* validate max range */
+	if (max > MSP71XX_UDC_HS_MAX_PACKET_SIZE)
+		return -ERANGE;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	_ep->maxpacket = max & 0x7ff;
+	ep->desc = desc;
+
+	/* ep_reset() has already been called */
+	ep->stopped = 0;
+
+	tmp = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
+	if (tmp == USB_ENDPOINT_XFER_BULK) {
+		/* catch some particularly blatant driver bugs */
+		if ((dev->gadget.speed == USB_SPEED_HIGH &&
+		    max > MSP71XX_UDC_HS_MAX_PACKET_SIZE) ||
+		    (dev->gadget.speed == USB_SPEED_FULL &&
+		    max > MSP71XX_UDC_FS_MAX_PACKET_SIZE)) {
+			spin_unlock_irqrestore(&dev->lock, flags);
+			return -ERANGE;
+		}
+	}
+
+	/* for OUT transfers, block the rx fifo until a read is posted */
+	tmp = desc->bEndpointAddress;
+	ep->is_in = (tmp & USB_DIR_IN) != 0;
+
+	/* flush endpoints */
+	retval1 = _usb_device_cancel_transfer(dev->handle, ep->num, USB_RECV);
+	retval2 = _usb_device_cancel_transfer(dev->handle, ep->num, USB_SEND);
+
+	/* unstall bulk endpoint */
+	_usb_device_unstall_endpoint(dev->handle, ep->num, USB_RECV);
+	_usb_device_unstall_endpoint(dev->handle, ep->num, USB_SEND);
+
+	if (retval1 | retval2)
+		retval = EIO;
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return retval;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: ep_reset
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Resets the endpoint
+ *
+ * INPUTS:	ep - (pointer to) pmc usb endpoint descriptor structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EIO
+ *
+ * NOTES:	This function is called with spinlock held
+ *
+ ***************************************************************************/
+static int ep_reset(struct msp71xx_udc_ep *ep)
+{
+	int retval1, retval2, retval = 0;
+	struct msp71xx_udc *dev;
+
+	dev = ep->dev;
+	ep->desc = NULL;
+	INIT_LIST_HEAD(&ep->queue);
+
+	ep->ep.ops = &msp71xx_udc_ep_ops;
+	ep->ep.maxpacket = MSP71XX_UDC_FS_MAX_PACKET_SIZE;
+	if (dev->gadget.speed == USB_SPEED_HIGH)
+		ep->ep.maxpacket = MSP71XX_UDC_HS_MAX_PACKET_SIZE;
+	ep->desc = 0;
+	ep->irqs = 0;
+
+	retval1 = _usb_device_cancel_transfer(dev->handle, ep->num, USB_RECV);
+	retval2 = _usb_device_cancel_transfer(dev->handle, ep->num, USB_SEND);
+	_usb_device_stall_endpoint(dev->handle, ep->num, USB_RECV);
+	_usb_device_stall_endpoint(dev->handle, ep->num, USB_SEND);
+
+	if (retval1 | retval2)
+		retval = EIO;
+
+	return retval;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_disable
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Disables the endpoint specified
+ *
+ * INPUTS:	_ep - (pointer to) usb endpoint descriptor structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EIO
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_disable(struct usb_ep *_ep)
+{
+	struct msp71xx_udc_ep *ep;
+	unsigned long flags;
+	int retval = 0;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || !ep->desc || _ep->name == ep0in || _ep->name == ep0out)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+	nuke(ep);
+	retval = ep_reset(ep);
+
+	VDEBUG(ep->dev, "endpt disabled %s\n", _ep->name);
+
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+
+	return retval;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_alloc_request
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Allocates a usb request block
+ *
+ * INPUTS:	_ep	- (pointer to) usb endpoint descriptor structure
+ *		gfp_flags - allocation flags
+ *
+ * OUTPUTS:	(pointer to) usb request block
+ *
+ * RETURNS:	(pointer to) usb request block
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static struct usb_request * msp71xx_udc_alloc_request(
+	struct usb_ep *_ep,
+	gfp_t gfp_flags)
+{
+	struct msp71xx_udc_request *req;
+
+	/* allocate memory */
+	req = kzalloc(sizeof(*req), gfp_flags);
+	if (!req)
+		return NULL;
+
+	INIT_LIST_HEAD(&req->queue);
+
+	return &req->req;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_free_request
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Deallocates a usb request block
+ *
+ * INPUTS:	_ep	- (pointer to) usb endpoint descriptor structure
+ *		_req	- (pointer to) usb request block
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void msp71xx_udc_free_request(
+	struct usb_ep *_ep,
+	struct usb_request *_req)
+{
+	struct msp71xx_udc_ep *ep;
+	struct msp71xx_udc_request *req;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || !_req)
+		return;
+
+	req = container_of(_req, struct msp71xx_udc_request, req);
+	WARN_ON(!list_empty(&req->queue));
+	kfree(req);
+}
+
+/*-------------------------------------------------------------------------*/
+#undef USE_KMALLOC
+
+/*
+ * Many common platforms have dma-coherent caches, which means that it's
+ * safe to use kmalloc() memory for all i/o buffers without using any
+ * cache flushing calls. (unless you're trying to share cache lines
+ * between dma and non-dma activities, which is a slow idea in any case.)
+ *
+ * other platforms need more care, with 2.5 having a moderately general
+ * solution (which falls down for allocations smaller than one page)
+ * that improves significantly on the 2.4 PCI allocators by removing
+ * the restriction that memory never be freed in_interrupt().
+ */
+#if defined(CONFIG_X86)
+#define USE_KMALLOC
+#elif defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
+#define USE_KMALLOC
+#elif defined(CONFIG_MIPS) && \
+	(defined(CONFIG_DMA_COHERENT) || defined(CONFIG_DMA_IP27))
+#define USE_KMALLOC
+#elif defined(CONFIG_USB_GADGET_MSP71XX)
+#define USE_KMALLOC
+/* TODO: there are other cases, including an x86-64 one ... */
+#endif
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_alloc_buffer
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Allocates a buffer to I/O operation
+ *
+ * INPUTS:	_ep	- (pointer to) usb endpoint descriptor structure
+ *		bytes	- number of bytes to allocate
+ *		dma	- (pointer to) dma address returned
+ *		gfp_flags - allocation flags
+ *
+ * OUTPUTS:	(pointer to) usb buffer
+ *
+ * RETURNS:	(pointer to) usb buffer
+ *
+ * NOTES:	This code currently uses kmalloc to allocate, this code
+ *		can be updated to use scratch pad RAM in future
+ *
+ ***************************************************************************/
+static void * msp71xx_udc_alloc_buffer(
+	struct usb_ep *_ep,
+	unsigned int bytes,
+	dma_addr_t *dma,
+	gfp_t gfp_flags)
+{
+	*dma = DMA_ADDR_INVALID;
+
+	if (!_ep)
+		return NULL;
+
+	return (void *)kmalloc(bytes, gfp_flags);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_free_buffer
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Deallocates a buffer previously allocated
+ *
+ * INPUTS:	_ep: (pointer to) usb endpoint descriptor structure
+ *		buf: (pointer to) buffer
+ *		dma: (pointer to) dma address
+ *		bytes: number of bytes
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	This code currently uses kfree to deallocate, this code
+ *		can be updated to deallocate scratch pad RAM in future
+ *
+ ***************************************************************************/
+static void msp71xx_udc_free_buffer(
+	struct usb_ep *_ep,
+	void *buf,
+	dma_addr_t dma,
+	unsigned int bytes)
+{
+	kfree(buf);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: write_fifo
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Writes data to the transmission fifo for usb IN transfers
+ *
+ * INPUTS:	ep	- (pointer to) pmc usb endpoint descriptor structure
+ *		req	- (pointer to) pmc usb request block
+ *
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void write_fifo(
+	struct msp71xx_udc_ep *ep,
+	struct msp71xx_udc_request *req)
+{
+	u8 *bufp;
+	unsigned int len;
+
+	if (req) {
+		bufp = req->req.buf;
+		len = req->req.length;
+		if (ep) {
+			_usb_device_send_data(ep->dev->handle,
+						ep->num, bufp, len);
+			VDEBUG(ep->dev,
+				"write %s fifo (IN) buf %8x %d bytes req %p\n",
+				ep->ep.name, (int)bufp, len, req);
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: read_fifo
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Reads data from receive fifo
+ *
+ * INPUTS:	ep	- (pointer to) pmc usb endpoint descriptor structure
+ *		req	- (pointer to) pmc usb request block
+ *
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void read_fifo(
+	struct msp71xx_udc_ep *ep,
+	struct msp71xx_udc_request *req)
+{
+	u8 *bufp;
+	unsigned int len;
+
+	if (req) {
+		bufp = req->req.buf;
+		len = req->req.length;
+		if (ep) {
+			_usb_device_recv_data(ep->dev->handle,
+						ep->num, bufp, len);
+			VDEBUG(ep->dev,
+				"read %s fifo (IN) buf %8x %d bytes req %p\n",
+				ep->ep.name, (int)bufp, len, req);
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: pmc_io_advance
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Advances the usb request queue and service it
+ *
+ * INPUTS:	ep - (pointer to) pmc usb endpoint descriptor structure
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+void pmc_io_advance(struct msp71xx_udc_ep *ep)
+{
+	struct msp71xx_udc_request *req;
+
+	if (unlikely(list_empty(&ep->queue)))
+		return;
+
+	req = list_entry(ep->queue.next, struct msp71xx_udc_request, queue);
+	if (req && !ep->stopped) {
+		req->req.status = -EINPROGRESS;
+		req->valid = 1;
+		(ep->is_in ? write_fifo : read_fifo)(ep, req);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: io_done
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Completes an IO operation by invoking
+ *		completion callback
+ *
+ * INPUTS:	ep - (pointer to) pmc usb endpoint descriptor structure
+ *		req - (pointer to) pmc usb request block
+ *		status - status
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void io_done(
+	struct msp71xx_udc_ep *ep,
+	struct msp71xx_udc_request *req,
+	int status)
+{
+	struct msp71xx_udc *dev;
+	unsigned int stopped = ep->stopped;
+
+	list_del_init(&req->queue);
+
+	if (req->req.status == -EINPROGRESS)
+		req->req.status = status;
+	else
+		status = req->req.status;
+
+	dev = ep->dev;
+
+	if (status && status != -ESHUTDOWN)
+		VDEBUG(dev, "complete %s req %p stat %d len %u/%u\n",
+			ep->ep.name, &req->req, status,
+			req->req.actual, req->req.length);
+
+	/* don't modify queue heads during completion callback */
+	ep->stopped = 1;
+	spin_unlock(&dev->lock);
+	req->req.complete(&ep->ep, &req->req);
+	spin_lock(&dev->lock);
+	ep->stopped = stopped;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_queue
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Enqueues a usb request
+ *
+ * INPUTS:	_ep - (pointer to) usb endpoint descriptor structure
+ *		_req - (pointer to) usb request block
+ *		gfp_flags - allocation flags
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EINVAL
+ *			= EDOM
+ *			= ESHUTDOWN
+ *			= EINPROGRESS
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_queue(
+	struct usb_ep *_ep,
+	struct usb_request *_req,
+	gfp_t gfp_flags)
+{
+	struct msp71xx_udc_request *req;
+	struct msp71xx_udc_ep *ep;
+	struct msp71xx_udc *dev;
+	unsigned long flags;
+	const struct list_head *headp;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || (!ep->desc && ep->num != 0))
+		return -EINVAL;
+
+	dev = ep->dev;
+
+	req = container_of(_req, struct msp71xx_udc_request, req);
+	if (!_req || !_req->complete || !_req->buf ||
+	    !list_empty(&req->queue)) {
+		ERROR(dev,
+			"list is not empty req %8x complete %8x buf %8x\r\n",
+			(int)_req, (int)_req->complete, (int)_req->buf);
+		headp = (const struct list_head *)&req->queue;
+		VDEBUG("list head %8x next %8x \r\n",
+			(int)headp, (int)headp->next);
+		return -EINVAL;
+	}
+
+	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+
+	VDEBUG(dev, "%s queue req %p, len %d buf %p\n",
+		_ep->name, _req, _req->length, _req->buf);
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	_req->status = -EINPROGRESS;
+	_req->actual = 0;
+	req->valid = 1;
+
+	/*
+	 * kickstart this i/o queue if empty
+	 * else irq handler will advance the queue.
+	 */
+	if (list_empty(&ep->queue) && !ep->stopped) {
+		/* issue write or read fifo data */
+		(ep->is_in ? write_fifo : read_fifo)(ep, req);
+	}
+
+	if (req)
+		list_add_tail(&req->queue, &ep->queue);
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return 0;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: pmc_io_complete
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Complete the I/O process by removing the entry and
+ *		invoking the completion function
+ *
+ * INPUTS:	ep: - (pointer to) pmc usb endpoint descriptor structure
+ *		buffer: buffer
+ *		length: length received or transmitted
+ *		status: status of reception or transmission
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+void pmc_io_complete(
+	struct msp71xx_udc_ep *ep,
+	void *buffer,
+	unsigned int length,
+	int status)
+{
+	struct msp71xx_udc_request *req;
+
+	/*
+	 * only look at descriptors that were "naturally" retired,
+	 * so fifo and list head state won't matter
+	 */
+	if (ep) {
+		if (!list_empty(&ep->queue)) {
+			if (ep->queue.next) {
+				req = list_entry(ep->queue.next,
+						struct msp71xx_udc_request,
+						queue);
+				if (req) {
+					if (req->valid) {
+						req->req.actual = length;
+						io_done(ep, req, status);
+					}
+				}
+			}
+		}
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: nuke
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Dequeues ALL requests
+ *
+ * INPUTS:	ep	- (pointer to) pmc usb endpoint descriptor structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	This function is called with spinlock held
+ *
+ ***************************************************************************/
+static void nuke(struct msp71xx_udc_ep *ep)
+{
+	struct msp71xx_udc_request *req;
+
+	/* called with spinlock held */
+	ep->stopped = 1;
+	while (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next,
+				struct msp71xx_udc_request,
+				queue);
+		io_done(ep, req, -ESHUTDOWN);
+	}
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_dequeue
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Dequeues a usb request
+ *
+ * INPUTS:	_ep - (pointer to) usb endpoint descriptor structure
+ *		_req - (pointer to) usb request block
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EINVAL
+ *			= ECONNRESET
+ *			= EOPNOTSUPP
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_dequeue(
+	struct usb_ep *_ep,
+	struct usb_request *_req)
+{
+	struct msp71xx_udc_ep *ep;
+	struct msp71xx_udc_request *req;
+	unsigned long flags;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || (!ep->desc && ep->num != 0) || !_req)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+
+	/* make sure it's actually queued on this endpoint */
+	list_for_each_entry(req, &ep->queue, queue) {
+		if (&req->req == _req)
+			break;
+	}
+	if (&req->req != _req) {
+		spin_unlock_irqrestore(&ep->dev->lock, flags);
+		return -EINVAL;
+	}
+
+	if (!list_empty(&req->queue))
+		io_done(ep, req, -ECONNRESET);
+	else
+		req = 0;
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+
+	return req ? 0 : -EOPNOTSUPP;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_set_halt
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Stalls/Unstalls an endpoint
+ *
+ * INPUTS:	_ep - (pointer to) usb endpoint descriptor structure
+ *		value - =1 to set
+ *			=0 to clear
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EINVAL
+ *			= ESHUTDOWN
+ *			= EAGAIN
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_set_halt(
+	struct usb_ep *_ep,
+	int value)
+{
+	struct msp71xx_udc_ep *ep;
+	unsigned long flags;
+	int retval = 0;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || (!ep->desc && ep->num != 0))
+		return -EINVAL;
+	if (!ep->dev->driver || ep->dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+	if (ep->desc /* not ep0 */ &&
+	    (ep->desc->bmAttributes & 0x03) == USB_ENDPOINT_XFER_ISOC)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+	if (!list_empty(&ep->queue))
+		retval = -EAGAIN;
+	else {
+		VDEBUG(ep->dev, "%s %s halt\n", _ep->name,
+			value ? "set" : "clear");
+		/* set/clear, then synch memory views with the device */
+		if (value) {
+			if (ep->num == 0)
+				ep->dev->protocol_stall = 1;
+			else
+				set_halt(ep);
+		} else
+			clear_halt(ep);
+	}
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+
+	return retval;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_fifo_flush
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Flushes the endpoint
+ *
+ * INPUTS:	_ep - (pointer to) usb endpoint descriptor structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void msp71xx_udc_fifo_flush(struct usb_ep *_ep)
+{
+	struct msp71xx_udc_ep *ep;
+
+	ep = container_of(_ep, struct msp71xx_udc_ep, ep);
+	if (!_ep || (!ep->desc && ep->num != 0))
+		return;
+	if (!ep->dev->driver || ep->dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return;
+
+	/* flush endpoints */
+	_usb_device_cancel_transfer(ep->dev->handle, ep->num, USB_RECV);
+	_usb_device_cancel_transfer(ep->dev->handle, ep->num, USB_SEND);
+}
+
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_get_frame
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Gets the frame index
+ *
+ * INPUTS:	_gadget	- (pointer to) gadget structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	frame index
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_get_frame(struct usb_gadget *_gadget)
+{
+	struct msp71xx_udc *dev;
+	u32 retval;
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+	if (!_gadget)
+		return -ENODEV;
+
+	dev = container_of(_gadget, struct msp71xx_udc, gadget);
+	usb_dev_ptr = (struct usb_dev_state *)dev->handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+	retval = dev_ptr->regs.op_dev.usb_frindex & MSP71XX_UDC_FRINDEX_MASK;
+
+	return retval;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_wakeup
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Wakeups the device
+ *
+ * INPUTS:	_gadget	- (pointer to) gadget structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_wakeup(struct usb_gadget *_gadget)
+{
+	struct msp71xx_udc *dev;
+	unsigned long flags;
+
+	if (!_gadget)
+		return 0;
+
+	dev = container_of(_gadget, struct msp71xx_udc, gadget);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	_usb_device_assert_resume(dev->handle);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+
+#ifdef	CONFIG_USB_GADGET_DEBUG_FILES
+
+/****************************************************************************
+ *
+ * FUNCTION: show_function
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Shows device function
+ *
+ * INPUTS:	_dev:	(pointer to) device structure
+ *		attr:	device attribute
+ *		buf:	print buffer
+ *
+ * OUTPUTS:	page size
+ *
+ * RETURNS:	page size
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static ssize_t show_function(
+	struct device *_dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	struct msp71xx_udc *dev = dev_get_drvdata(_dev);
+
+	if (!dev->driver || !dev->driver->function ||
+	    strlen(dev->driver->function) > PAGE_SIZE)
+		return 0;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", dev->driver->function);
+}
+
+static DEVICE_ATTR(function, S_IRUGO, show_function, NULL);
+
+/****************************************************************************
+ *
+ * FUNCTION: show_registers
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Shows device registers function
+ *
+ * INPUTS:	_dev:	(pointer to) device structure
+ *		attr:	device attribute
+ *		buf:	print buffer
+ *
+ * OUTPUTS:	page size
+ *
+ * RETURNS:	page size
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static ssize_t show_registers(
+	struct device *_dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	struct msp71xx_udc *dev;
+	struct msp71xx_udc_ep *ep;
+	char *next;
+	unsigned int size, t;
+	unsigned long flags;
+	int i;
+	const char *s;
+	struct usb_dev_state * usb_dev_ptr;
+	volatile struct vusb20 * dev_ptr;
+
+	dev = dev_get_drvdata(_dev);
+	usb_dev_ptr = (struct usb_dev_state *)dev->handle;
+	dev_ptr = (struct vusb20 *)usb_dev_ptr->dev_ptr;
+
+	next = buf;
+	size = PAGE_SIZE;
+	spin_lock_irqsave(&dev->lock, flags);
+
+	if (dev->driver)
+		s = dev->driver->driver.name;
+	else
+		s = "(none)";
+
+	/* Main Control Registers */
+	t = scnprintf(next, size, "%s "
+			"cmd %08x status %08x intr %8x fridx %8x\n"
+			"ctrlseg %08x device addr %08x ep list addr %8x "
+			"ctrl flag %8x\n"
+			"mode %08x end setup %08x prime %8x flush %8x\n"
+			"end status %08x complete %08x \n",
+			driver_name,
+			readl(&dev_ptr->regs.op_dev.usb_cmd),
+			readl(&dev_ptr->regs.op_dev.usb_sts),
+			readl(&dev_ptr->regs.op_dev.usb_intr),
+			readl(&dev_ptr->regs.op_dev.usb_frindex),
+			readl(&dev_ptr->regs.op_dev.ctrldssegment),
+			readl(&dev_ptr->regs.op_dev.device_addr),
+			readl(&dev_ptr->regs.op_dev.ep_list_addr),
+			readl(&dev_ptr->regs.op_dev.config_flag),
+			readl(&dev_ptr->regs.op_dev.usb_mode),
+			readl(&dev_ptr->regs.op_dev.ep_setup_stat),
+			readl(&dev_ptr->regs.op_dev.ep_prime),
+			readl(&dev_ptr->regs.op_dev.ep_flush),
+			readl(&dev_ptr->regs.op_dev.ep_status),
+			readl(&dev_ptr->regs.op_dev.ep_complete));
+	size -= t;
+	next += t;
+
+	/* Configurable EP Control Registers */
+	t = scnprintf(next, size, "\nport ctrl:  ");
+	size -= t;
+	next += t;
+	for (i = 0; i < VUSBHS_MAX_PORTS; i++) {
+		t = scnprintf(next, size, "%08x ",
+				readl(&dev_ptr->regs.op_dev.portscx[i]));
+		size -= t;
+		next += t;
+	}
+	t = scnprintf(next, size, "\nend ctrl:  ");
+	size -= t;
+	next += t;
+	for (i = 0; i < MSP71XX_UDC_MAX_ENDPT; i++) {
+		ep = &dev->ep[i];
+		t = scnprintf(next, size, "%08x ",
+				readl(&dev_ptr->regs.op_dev.ep_ctrlx[i]));
+		size -= t;
+		next += t;
+	}
+
+	/* Indexed Registers - none yet */
+
+	/* Statistics */
+	t = scnprintf(next, size, "\nirqs:  ");
+	size -= t;
+	next += t;
+	for (i = 0; i < MSP71XX_UDC_MAX_ENDPT; i++) {
+		ep = &dev->ep[i];
+		t = scnprintf(next, size, " %s/%lu", ep->ep.name, ep->irqs);
+		size -= t;
+		next += t;
+	}
+	t = scnprintf(next, size, "\n");
+	size -= t;
+	next += t;
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return PAGE_SIZE - size;
+}
+
+static DEVICE_ATTR(registers, S_IRUGO, show_registers, NULL);
+
+/****************************************************************************
+ *
+ * FUNCTION: show_queues
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Shows device queues function
+ *
+ * INPUTS:	_dev:	(pointer to) device structure
+ *		attr:	device attribute
+ *		buf:	print buffer
+ *
+ * OUTPUTS:	page size
+ *
+ * RETURNS:	page size
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static ssize_t show_queues(
+	struct device *_dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	struct msp71xx_udc *dev;
+	char *next;
+	unsigned int size;
+	unsigned long flags;
+	int i;
+
+	dev = dev_get_drvdata(_dev);
+	next = buf;
+	size = PAGE_SIZE;
+	spin_lock_irqsave(&dev->lock, flags);
+
+	for (i = 0; i < MSP71XX_UDC_MAX_ENDPT; i++) {
+		struct msp71xx_udc_ep *ep = &dev->ep[i];
+		struct msp71xx_udc_request *req;
+		int t;
+
+		if (i > 2) {
+			const struct usb_endpoint_descriptor *d = ep->desc;
+			if (!d)
+				continue;
+
+			t = d->bEndpointAddress;
+			t = scnprintf(next, size,
+				"\n%s (ep%d%s-%s) max %04x \n",
+				ep->ep.name, t & USB_ENDPOINT_NUMBER_MASK,
+				(t & USB_DIR_IN) ? "in" : "out",
+				({ char *val;
+					switch (d->bmAttributes & 0x03) {
+					case USB_ENDPOINT_XFER_BULK:
+						val = "bulk";
+						break;
+					case USB_ENDPOINT_XFER_INT:
+						val = "intr";
+						break;
+					default:
+						val = "iso";
+						break;
+				}; val; }),
+			le16_to_cpu(d->wMaxPacketSize) & 0x1fff);
+		} else /* ep0 should only have one transfer queued */
+			t = scnprintf(next, size, "ep0 max 64 pio %s\n",
+					ep->is_in ? "in" : "out");
+		if (t <= 0 || t > size)
+			goto done;
+		size -= t;
+		next += t;
+
+		if (list_empty(&ep->queue)) {
+			t = scnprintf(next, size, "\t(nothing queued)\n");
+			if (t <= 0 || t > size)
+				goto done;
+			size -= t;
+			next += t;
+			continue;
+		}
+		list_for_each_entry(req, &ep->queue, queue) {
+			t = scnprintf(next, size,
+				"\treq %p len %d/%d buf %p\n",
+				&req->req, req->req.actual,
+				req->req.length, req->req.buf);
+			if (t <= 0 || t > size)
+				goto done;
+			size -= t;
+			next += t;
+
+		}
+	}
+
+done:
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return PAGE_SIZE - size;
+}
+
+static DEVICE_ATTR(queues, S_IRUGO, show_queues, NULL);
+
+#else
+
+#define device_create_file(a, b)	do {} while (0)
+#define device_remove_file		device_create_file
+
+#endif
+
+/****************************************************************************
+ *
+ * FUNCTION: usb_reset
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Resets and initializes the usb device controller
+ *
+ * INPUTS:	dev:	(pointer to) pmc udc device structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void usb_reset(struct msp71xx_udc *dev)
+{
+	u8 error;
+
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	spin_lock(&dev->lock);
+
+	/* Initialize the USB interface */
+	error = _usb_device_init(0, (void *)&dev->handle,
+				MSP71XX_UDC_MAX_ENDPT);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Initialization failed. Error: %x\n", error);
+
+	error = _usb_device_register_service(dev->handle,
+					USB_SERVICE_EP0, service_ep0);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Service Registration failed ep0. "
+			"Error: %x\n", error);
+
+	error = _usb_device_register_service(dev->handle,
+					USB_SERVICE_BUS_RESET, reset_ep0);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Service Registration failed reset ep0. "
+			"Error: %x\n", error);
+
+	error = _usb_device_register_service(dev->handle,
+					USB_SERVICE_SUSPEND, service_suspend);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Service Registration failed service suspend. "
+			"Error: %x\n", error);
+
+	error = _usb_device_register_service(dev->handle,
+					USB_SERVICE_SPEED_DETECTION,
+					service_speed);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Service Registration failed speed detect. "
+			"Error: %x\n", error);
+
+	error = _usb_device_register_service(dev->handle,
+					USB_SERVICE_EP1, service_ep1);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Service Registration failed ep1. "
+			"Error: %x\n", error);
+
+	error = _usb_device_register_service(dev->handle,
+					USB_SERVICE_EP2, service_ep2);
+	if (error != USB_OK)
+		ERROR(dev, "\nUSB Service Registration failed ep2. "
+			"Error: %x\n", error);
+
+#ifdef CONFIG_PMCTWILED
+	/* set TWI GPIO USB_HOST_DEV pin to active low */
+	msp_led_pin_lo(MSP_PIN_USB_HOST_DEV);
+#endif
+
+	spin_unlock(&dev->lock);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: usb_shutdown
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION:	Shuts down the device controller
+ *
+ * INPUTS:	dev:	(pointer to) pmc udc device structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void usb_shutdown(struct msp71xx_udc *dev)
+{
+	/* shut down device */
+	_usb_device_shutdown(dev->handle);
+
+	spin_lock(&dev->lock);
+	_usb_device_unregister_service(dev->handle, USB_SERVICE_EP0);
+	_usb_device_unregister_service(dev->handle, USB_SERVICE_BUS_RESET);
+	_usb_device_unregister_service(dev->handle, USB_SERVICE_SUSPEND);
+	_usb_device_unregister_service(dev->handle,
+					USB_SERVICE_SPEED_DETECTION);
+	_usb_device_unregister_service(dev->handle, USB_SERVICE_EP1);
+	_usb_device_unregister_service(dev->handle, USB_SERVICE_EP2);
+	spin_unlock(&dev->lock);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: usb_reinit
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION:	Initializes the device control block
+ *
+ * INPUTS:	dev:	(pointer to) PMC udc device structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void usb_reinit(struct msp71xx_udc *dev)
+{
+	int i;
+
+	/* basic endpoint init */
+	for (i = 0; i < MSP71XX_UDC_MAX_ENDPT; i++) {
+		struct msp71xx_udc_ep *ep = &dev->ep[i];
+		ep->ep.name = ep_name[i];
+		ep->dev = dev;
+		ep->num = i/2;
+		if (i % 2)
+			ep->is_in = 0;
+		else
+			ep->is_in = 1;
+
+		ep->ep.maxpacket = MSP71XX_UDC_FS_MAX_PACKET_SIZE;
+		if (dev->gadget.speed == USB_SPEED_HIGH)
+			ep->ep.maxpacket = MSP71XX_UDC_HS_MAX_PACKET_SIZE;
+		ep->irqs = 0;
+		ep_reset(ep);
+	}
+
+	dev->gadget.ep0 = &dev->ep[EP_0].ep;
+	INIT_LIST_HEAD(&dev->gadget.ep0->ep_list);
+
+	/* always ep lists */
+	INIT_LIST_HEAD(&dev->gadget.ep_list);
+	list_add_tail(&dev->ep[EP_1_IN].ep.ep_list, &dev->gadget.ep_list);
+	list_add_tail(&dev->ep[EP_1_OUT].ep.ep_list, &dev->gadget.ep_list);
+	list_add_tail(&dev->ep[EP_2_IN].ep.ep_list, &dev->gadget.ep_list);
+	list_add_tail(&dev->ep[EP_2_OUT].ep.ep_list, &dev->gadget.ep_list);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: usb_gadget_register_device
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Registers the gadget driver
+ *
+ * INPUTS:	driver:	(pointer to) gadget driver
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EINVAL
+ *			= ENODEV
+ *			= EBUSY
+ *
+ * NOTES:	When a driver is successfully registered, it will receive
+ *		control requests including set_configuration(), which
+ *		enables non-control requests. then usb traffic follows
+ *		until a disconnect is reported. then a host may connect
+ *		again, or the driver might get unbound.
+ *
+ ***************************************************************************/
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	struct msp71xx_udc *dev = the_controller;
+	int retval;
+	unsigned int i;
+
+	if (!driver || !driver->bind || !driver->unbind || !driver->setup)
+		return -EINVAL;
+	if (!dev)
+		return -ENODEV;
+	if (dev->driver)
+		return -EBUSY;
+
+	for (i = 0; i < MSP71XX_UDC_MAX_ENDPT; i++)
+		dev->ep[i].irqs = 0;
+
+	/* hook up the driver... */
+	dev->softconnect = 1;
+	driver->driver.bus = NULL;
+	dev->driver = driver;
+	dev->gadget.dev.driver = &driver->driver;
+
+	retval = driver->bind(&dev->gadget);
+	if (retval) {
+		DEBUG(dev, "bind to driver %s --> %d\n",
+			driver->driver.name, retval);
+		dev->driver = NULL;
+		dev->gadget.dev.driver = NULL;
+		return retval;
+	}
+	device_create_file(dev->dev, &dev_attr_function);
+	device_create_file(dev->dev, &dev_attr_queues);
+
+	DEBUG(dev, "%s ready \n", driver->driver.name);
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_register_driver);
+
+/****************************************************************************
+ *
+ * FUNCTION: stop_activity
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Stops activity on the usb device
+ *
+ * INPUTS:	dev:	(pointer to) PMC udc device structure
+ *		driver:	(pointer to) gadget driver
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	This function is called with spinlock held
+ *
+ ***************************************************************************/
+static void stop_activity(
+	struct msp71xx_udc *dev,
+	struct usb_gadget_driver *driver)
+{
+	int i;
+
+	/* don't disconnect if it's not connected */
+	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
+		driver = NULL;
+
+	/*
+	 * stop hardware; prevent new request submissions;
+	 * and kill any outstanding requests.
+	 */
+	for (i = 0; i < MSP71XX_UDC_MAX_ENDPT; i++) {
+		/* reset endpoint queues */
+		nuke(&dev->ep[i]);
+		ep_reset(&dev->ep[i]);
+	}
+
+	/* report disconnect; the driver is already quiesced */
+	if (driver) {
+		spin_unlock(&dev->lock);
+		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
+
+	usb_reinit(dev);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: usb_gadget_unregister_device
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Unregisters the gadget driver
+ *
+ * INPUTS:	driver:	(pointer to) gadget driver
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = ENODEV
+ *			= EINVAL
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+{
+	struct msp71xx_udc *dev = the_controller;
+	unsigned long flags;
+
+	if (!dev)
+		return -ENODEV;
+	if (!driver || driver != dev->driver)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	stop_activity(dev, driver);
+	usb_shutdown(dev);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	driver->unbind(&dev->gadget);
+	dev->gadget.dev.driver = NULL;
+	dev->driver = NULL;
+
+	device_remove_file(dev->dev, &dev_attr_function);
+	device_remove_file(dev->dev, &dev_attr_queues);
+
+	DEBUG(dev, "unregistered driver '%s'\n", driver->driver.name);
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_unregister_driver);
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_irq
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Handles USB interrupts
+ *
+ * INPUTS:	irq:	IRQ number
+ *		pdevice:	(pointer to) PMC device structure
+ *		r:	 (pointer to) registers
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	IRQ_HANDLED
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static irqreturn_t msp71xx_udc_irq(int irq, void *pdevice)
+{
+	struct msp71xx_udc *dev;
+	dev = (struct msp71xx_udc *)pdevice;
+
+	spin_lock(&dev->lock);
+
+	/* invoke device controller int handler */
+	_usb_dci_vusb20_isr();
+
+	spin_unlock(&dev->lock);
+
+	return IRQ_HANDLED;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: gadget_release
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Release the gadget driver
+ *
+ * INPUTS:	_dev:	(pointer to) device structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void gadget_release(struct device *_dev)
+{
+	struct msp71xx_udc *dev = dev_get_drvdata(_dev);
+
+	kfree(dev);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_remove
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Removes the gadget device
+ *
+ * INPUTS:	pdev:	(pointer to) platform device structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+
+static int msp71xx_udc_remove(struct platform_device *pdev)
+{
+	struct msp71xx_udc *dev = platform_get_drvdata(pdev);
+
+	/* start with the driver above us */
+	if (dev->driver) {
+		/* should have been done already by driver model core */
+		VDEBUG(dev, "msp71xx_udc remove, driver '%s' "
+			"is still registered\n",
+			dev->driver->driver.name);
+		usb_gadget_unregister_driver(dev->driver);
+	}
+
+	if (dev->got_irq) {
+		free_irq(pdev->resource[1].start, dev);
+		dev->got_irq = 0;
+	}
+	device_unregister(&dev->gadget.dev);
+	device_remove_file(dev->dev, &dev_attr_registers);
+
+	platform_set_drvdata(pdev, 0);
+	the_controller = 0;
+
+	INFO(dev, "unbind\n");
+
+	return 0;
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_probe
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Probes the usb gadget device controller
+ *
+ * INPUTS:	pdev:	(pointer to) platform device structure
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = 0
+ *		Error = EBUSY
+ *			= ENOMEM
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int msp71xx_udc_probe(struct platform_device *pdev)
+{
+	struct msp71xx_udc *dev = NULL;
+	int retval;
+
+	/*
+	 * if you want to support more than one controller in a system,
+	 * usb_gadget_driver_{register,unregister}() must change.
+	 */
+	if (the_controller) {
+		DEBUG(dev, "ignoring\n");
+		return -EBUSY;
+	}
+
+	/* alloc, and start init */
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (dev == NULL) {
+		retval = -ENOMEM;
+		goto done;
+	}
+
+	spin_lock_init(&dev->lock);
+	dev->dev = &pdev->dev;
+	dev->gadget.ops = &msp71xx_udc_ops;
+	dev->gadget.is_dualspeed = 1;
+
+	the_controller = dev;
+	platform_set_drvdata(pdev, dev);
+
+	/* the "gadget" abstracts/virtualizes the controller */
+	device_initialize(&dev->gadget.dev);
+	strcpy(dev->gadget.dev.bus_id, "gadget");
+	dev->gadget.dev.parent = &pdev->dev;
+	dev->gadget.dev.release = gadget_release;
+	dev->gadget.name = driver_name;
+
+	dev->enabled = 1;
+
+	/* put into initial config, link up all endpoints */
+	usb_reset(dev);
+	usb_reinit(dev);
+
+	if (request_irq(pdev->resource[1].start, msp71xx_udc_irq, 0,
+				driver_name, dev) != 0) {
+		DEBUG(dev, "request interrupt failed\n");
+		retval = -EBUSY;
+		goto done;
+	}
+	dev->got_irq = 1;
+
+	retval = device_register(&dev->gadget.dev);
+	if (retval != 0)
+		goto done;
+
+	device_create_file(dev->dev, &dev_attr_registers);
+
+	return 0;
+
+done:
+	if (dev)
+		msp71xx_udc_remove(pdev);
+
+	return retval;
+}
+
+/* device driver structure */
+static struct platform_driver msp71xx_udc_driver = {
+	.probe	= msp71xx_udc_probe,
+	.remove	= __exit_p(msp71xx_udc_remove),
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "msp71xx_udc",
+		},
+	/*
+	 * TODO: power management support
+	 * .suspend = ... disable UDC
+	 * .resume = ... re-enable UDC
+	 */
+};
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_init
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Initializes the device controller and register the driver
+ *
+ * INPUTS:	None
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success =0
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static int __init msp71xx_udc_init(void)
+{
+	printk(KERN_INFO "%s: %s\n", driver_name, driver_desc);
+
+	return platform_driver_register(&msp71xx_udc_driver);
+}
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_udc_exit
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Shutdowns the device controller and unregister the druiver
+ *
+ * INPUTS:	None
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	None
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static void __exit msp71xx_udc_exit(void)
+{
+	platform_driver_unregister(&msp71xx_udc_driver);
+}
+
+module_init(msp71xx_udc_init);
+module_exit(msp71xx_udc_exit);
diff --git a/drivers/usb/gadget/pmc-sierra/msp71xx_udc.h b/drivers/usb/gadget/pmc-sierra/msp71xx_udc.h
new file mode 100644
index 0000000..5a4aa89
--- /dev/null
+++ b/drivers/usb/gadget/pmc-sierra/msp71xx_udc.h
@@ -0,0 +1,284 @@
+/*
+ * msp71xx_udc.h -- This file contains all the definitions & declaration
+ *		for the PMC MSP71XX USB peripheral device driver
+ *
+ * Copyright (C) 2006-2007 PMC-Sierra
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, RESPONSIBILITY OR LIABILITY; without even the
+ * implied warranty of NON- INFRINGEMENT AND MERCHANTABILITY or FITNESS FOR A
+ * PARTICULAR PURPOSE. See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef MSP71XX_UDC_H
+#define MSP71XX_UDC_H
+
+/*
+ * Constants
+ */
+#define MSP71XX_UDC_MAX_ENDPT		6
+#define MSP71XX_UDC_FS_MAX_PACKET_SIZE	64
+#define MSP71XX_UDC_HS_MAX_PACKET_SIZE	512
+
+#define MSP71XX_UDC_FRINDEX_MASK	0x3FFF
+
+/*
+ * External variables
+ */
+extern struct msp71xx_udc *the_controller;
+
+
+/*
+ * Macro Definitions
+ */
+
+/*****************************************************************************
+ *
+ * MACRO: xprintf
+ * ___________________________________________________________________________
+ *
+ * DESCRIPTION:
+ *	print gadget driver msg
+ *
+ * INPUTS:
+ *	dev   - device
+ *	level - print level
+ *	fmt   - print format
+ *	args  - arg list
+ *
+ * RETURNS:
+ *
+ ****************************************************************************/
+#define xprintk(dev, level, fmt, args...) \
+	printk(level "%s %s: " fmt, driver_name, \
+		dev->gadget.name, ## args)
+
+/*****************************************************************************
+ *
+ * MACRO: DEBUG
+ * ___________________________________________________________________________
+ *
+ * DESCRIPTION:
+ *	print gadget driver debug msg
+ *
+ * INPUTS:
+ *	dev   - device
+ *	fmt   - print format
+ *	args  - arg list
+ *
+ * RETURNS:
+ *
+ ****************************************************************************/
+#ifdef DEBUG
+#undef DEBUG
+#define DEBUG(dev, fmt, args...) \
+	xprintk(dev, KERN_DEBUG, fmt, ## args)
+#else
+#define DEBUG(dev, fmt, args...) \
+	do { } while (0)
+#endif /* DEBUG */
+
+/*****************************************************************************
+ *
+ * MACRO: VDEBUG
+ * ___________________________________________________________________________
+ *
+ * DESCRIPTION:
+ *	print gadget driver verbose msg only if VERBOSE and DEBUG is defined
+ *
+ * INPUTS:
+ *	dev   - device
+ *	fmt   - print format
+ *	args  - arg list
+ *
+ * RETURNS:
+ *
+ ****************************************************************************/
+#ifdef VERBOSE
+#define VDEBUG DEBUG
+#else
+#define VDEBUG(dev, fmt, args...) \
+	do { } while (0)
+#endif /* VERBOSE */
+
+/*****************************************************************************
+ *
+ * MACRO: ERROR
+ * ___________________________________________________________________________
+ *
+ * DESCRIPTION:
+ *	print driver error msg
+ *
+ * INPUTS:
+ *	dev   - device
+ *	fmt   - print format
+ *	args  - arg list
+ *
+ * RETURNS:
+ *
+ ****************************************************************************/
+#define ERROR(dev, fmt, args...) \
+	xprintk(dev, KERN_ERR, fmt, ## args)
+
+/*****************************************************************************
+ *
+ * MACRO: WARN
+ * ___________________________________________________________________________
+ *
+ * DESCRIPTION:
+ *	print driver warning msg
+ *
+ * INPUTS:
+ *	dev   - device
+ *	fmt   - print format
+ *	args  - arg list
+ *
+ * RETURNS:
+ *
+ ****************************************************************************/
+#define WARN(dev, fmt, args...) \
+	xprintk(dev, KERN_WARNING, fmt, ## args)
+
+/*****************************************************************************
+ *
+ * MACRO: INFO
+ * ___________________________________________________________________________
+ *
+ * DESCRIPTION:
+ *	print driver info msg
+ *
+ * INPUTS:
+ *	dev   - device
+ *	fmt   - print format
+ *	args  - arg list
+ *
+ * RETURNS:
+ *
+ ****************************************************************************/
+#define INFO(dev, fmt, args...) \
+	xprintk(dev, KERN_INFO, fmt, ## args)
+
+/*
+ * Inline functions
+ */
+
+/****************************************************************************
+ *
+ * FUNCTION: msp71xx_get_dev_ptr
+ * __________________________________________________________________________
+ *
+ * DESCRIPTION: Get the device controller pointer
+ *
+ * INPUTS:	None
+ *
+ * OUTPUTS:	None
+ *
+ * RETURNS:	Success = the controller device pointer
+ *
+ * NOTES:	None
+ *
+ ***************************************************************************/
+static inline struct msp71xx_udc *msp71xx_get_dev_ptr(void)
+{
+	return the_controller;
+}
+
+/*
+ * Structures and Unions
+ */
+
+/*****************************************************************************
+ * STRUCTURE: msp71xx_udc_ep
+ * ___________________________________________________________________________
+ *
+ * This structure defines the PMC td endpoint descriptor.
+ *
+ * ELEMENTS:
+ *	usb_ep  - usb endpoint structure
+ *	dev	- (pointer to) PMC td device structure
+ *	irq	- number of interrupts
+ *	queue   - list head structure
+ *	desc    - (pointer to) usb endpoint descriptor
+ *	num	- endpoint address number
+ *	stopped - endpoint stop
+ *	is_in   - is bulk in or out
+ *
+ ****************************************************************************/
+struct msp71xx_udc_ep {
+	struct usb_ep		ep;
+	struct msp71xx_udc	*dev;
+	unsigned long		irqs;
+
+	/* analogous to a host-side qh */
+	struct list_head	queue;
+	const struct usb_endpoint_descriptor	*desc;
+	unsigned int		num : 8,	/* endpoint address */
+				stopped : 1,
+				is_in : 1;	/* bulk in or out */
+};
+
+/*****************************************************************************
+ * STRUCTURE: msp71xx_udc_request
+ * ___________________________________________________________________________
+ *
+ * This structure defines the PMC td user request
+ *
+ * ELEMENTS:
+ *	req    - usb request
+ *	queue  - list head structure
+ *	valid  - indicates request is valid
+ *
+ ****************************************************************************/
+struct msp71xx_udc_request {
+	struct usb_request	req;
+	struct list_head	queue;
+	unsigned int		valid : 1;
+};
+
+/*****************************************************************************
+ * STRUCTURE: msp71xx_udc
+ * ___________________________________________________________________________
+ *
+ * This structure defines the PMC td device structure
+ *
+ * ELEMENTS:
+ *	gadget	  - gadget device structure
+ *	driver	  - (pointer to) gadget driver structure
+ *	dev	  - (pointer to) device structure
+ *	handle	  - usb device handle
+ *	lock	  - lock
+ *	ep	  - array of endpoint structures
+ *	enabled	  - device is enable
+ *	protocol_stall - device is stalled
+ *	softconnect    - soft connect
+ *	got_irq	   - got interrupt
+ *
+ ****************************************************************************/
+struct msp71xx_udc {
+	struct usb_gadget		gadget;
+	struct usb_gadget_driver *	driver;
+	struct device *			dev;
+	_usb_device_handle *		handle;
+	spinlock_t			lock;
+	struct msp71xx_udc_ep		ep[MSP71XX_UDC_MAX_ENDPT];
+	unsigned int			enabled : 1,
+					protocol_stall : 1,
+					softconnect : 1,
+					got_irq : 1;
+};
+
+/* External functions */
+extern void pmc_io_complete(struct msp71xx_udc_ep *ep, void *buffer,
+				unsigned int length, int status);
+extern void pmc_io_advance(struct msp71xx_udc_ep *ep);
+
+#endif /* MSP71XX_UDC_H */
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6271187..902e059 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -72,6 +72,38 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 	depends on USB_EHCI_HCD
 	default n
 
+config USB_EHCI_HCD_PMC_MSP
+	bool "EHCI support for on-chip PMC MSP USB controller"
+	depends on USB_EHCI_HCD && (PMC_MSP7120_GW || PMC_MSP7120_EVAL || \
+					PMC_MSP7120_FPGA)
+	default y if (PMC_MSP7120_GW || PMC_MSP7120_EVAL || PMC_MSP7120_FPGA)
+	select USB_EHCI_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	---help---
+	  Enables support for the onchip USB controller on the PMC_MSP7120_GW 
+	  or PMC_MSP7120_EVAL or PMC_MSP7120_FPGA processor chip.
+	  If unsure, say N.
+
+config USB_EHCI_HCD_PCI
+	bool "EHCI support for PCI-bus USB controllers"
+	depends on USB_EHCI_HCD && PCI && !USB_EHCI_HCD_PMC_MSP
+	default n if USB_EHCI_HCD_PMC_MSP
+	select USB_EHCI_LITTLE_ENDIAN
+	---help---
+	  Enables support for PCI-bus plug-in USB controller cards.
+	  If unsure, say Y.
+
+config USB_EHCI_BIG_ENDIAN
+	bool
+	depends on USB_EHCI_HCD
+	default n
+
+config USB_EHCI_LITTLE_ENDIAN
+	bool
+	depends on USB_EHCI_HCD
+	default n if USB_EHCI_HCD_PMC_MSP
+	default y
+
 config USB_ISP116X_HCD
 	tristate "ISP116X HCD support"
 	depends on USB
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 43eddae..68f8868 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -119,16 +119,16 @@ static void __attribute__((__unused__))
 dbg_qtd (const char *label, struct ehci_hcd *ehci, struct ehci_qtd *qtd)
 {
 	ehci_dbg (ehci, "%s td %p n%08x %08x t%08x p0=%08x\n", label, qtd,
-		le32_to_cpup (&qtd->hw_next),
-		le32_to_cpup (&qtd->hw_alt_next),
-		le32_to_cpup (&qtd->hw_token),
-		le32_to_cpup (&qtd->hw_buf [0]));
+		ehci32_to_cpup (&qtd->hw_next),
+		ehci32_to_cpup (&qtd->hw_alt_next),
+		ehci32_to_cpup (&qtd->hw_token),
+		ehci32_to_cpup (&qtd->hw_buf [0]));
 	if (qtd->hw_buf [1])
 		ehci_dbg (ehci, "  p1=%08x p2=%08x p3=%08x p4=%08x\n",
-			le32_to_cpup (&qtd->hw_buf [1]),
-			le32_to_cpup (&qtd->hw_buf [2]),
-			le32_to_cpup (&qtd->hw_buf [3]),
-			le32_to_cpup (&qtd->hw_buf [4]));
+			ehci32_to_cpup (&qtd->hw_buf [1]),
+			ehci32_to_cpup (&qtd->hw_buf [2]),
+			ehci32_to_cpup (&qtd->hw_buf [3]),
+			ehci32_to_cpup (&qtd->hw_buf [4]));
 }
 
 static void __attribute__((__unused__))
@@ -144,26 +144,27 @@ static void __attribute__((__unused__))
 dbg_itd (const char *label, struct ehci_hcd *ehci, struct ehci_itd *itd)
 {
 	ehci_dbg (ehci, "%s [%d] itd %p, next %08x, urb %p\n",
-		label, itd->frame, itd, le32_to_cpu(itd->hw_next), itd->urb);
+		label, itd->frame, itd, ehci32_to_cpu(itd->hw_next),
+		itd->urb);
 	ehci_dbg (ehci,
 		"  trans: %08x %08x %08x %08x %08x %08x %08x %08x\n",
-		le32_to_cpu(itd->hw_transaction[0]),
-		le32_to_cpu(itd->hw_transaction[1]),
-		le32_to_cpu(itd->hw_transaction[2]),
-		le32_to_cpu(itd->hw_transaction[3]),
-		le32_to_cpu(itd->hw_transaction[4]),
-		le32_to_cpu(itd->hw_transaction[5]),
-		le32_to_cpu(itd->hw_transaction[6]),
-		le32_to_cpu(itd->hw_transaction[7]));
+		ehci32_to_cpu(itd->hw_transaction[0]),
+		ehci32_to_cpu(itd->hw_transaction[1]),
+		ehci32_to_cpu(itd->hw_transaction[2]),
+		ehci32_to_cpu(itd->hw_transaction[3]),
+		ehci32_to_cpu(itd->hw_transaction[4]),
+		ehci32_to_cpu(itd->hw_transaction[5]),
+		ehci32_to_cpu(itd->hw_transaction[6]),
+		ehci32_to_cpu(itd->hw_transaction[7]));
 	ehci_dbg (ehci,
 		"  buf:   %08x %08x %08x %08x %08x %08x %08x\n",
-		le32_to_cpu(itd->hw_bufp[0]),
-		le32_to_cpu(itd->hw_bufp[1]),
-		le32_to_cpu(itd->hw_bufp[2]),
-		le32_to_cpu(itd->hw_bufp[3]),
-		le32_to_cpu(itd->hw_bufp[4]),
-		le32_to_cpu(itd->hw_bufp[5]),
-		le32_to_cpu(itd->hw_bufp[6]));
+		ehci32_to_cpu(itd->hw_bufp[0]),
+		ehci32_to_cpu(itd->hw_bufp[1]),
+		ehci32_to_cpu(itd->hw_bufp[2]),
+		ehci32_to_cpu(itd->hw_bufp[3]),
+		ehci32_to_cpu(itd->hw_bufp[4]),
+		ehci32_to_cpu(itd->hw_bufp[5]),
+		ehci32_to_cpu(itd->hw_bufp[6]));
 	ehci_dbg (ehci, "  index: %d %d %d %d %d %d %d %d\n",
 		itd->index[0], itd->index[1], itd->index[2],
 		itd->index[3], itd->index[4], itd->index[5],
@@ -174,14 +175,15 @@ static void __attribute__((__unused__))
 dbg_sitd (const char *label, struct ehci_hcd *ehci, struct ehci_sitd *sitd)
 {
 	ehci_dbg (ehci, "%s [%d] sitd %p, next %08x, urb %p\n",
-		label, sitd->frame, sitd, le32_to_cpu(sitd->hw_next), sitd->urb);
+		label, sitd->frame, sitd, ehci32_to_cpu(sitd->hw_next),
+		sitd->urb);
 	ehci_dbg (ehci,
 		"  addr %08x sched %04x result %08x buf %08x %08x\n",
-		le32_to_cpu(sitd->hw_fullspeed_ep),
-		le32_to_cpu(sitd->hw_uframe),
-		le32_to_cpu(sitd->hw_results),
-		le32_to_cpu(sitd->hw_buf [0]),
-		le32_to_cpu(sitd->hw_buf [1]));
+		ehci32_to_cpu(sitd->hw_fullspeed_ep),
+		ehci32_to_cpu(sitd->hw_uframe),
+		ehci32_to_cpu(sitd->hw_results),
+		ehci32_to_cpu(sitd->hw_buf [0]),
+		ehci32_to_cpu(sitd->hw_buf [1]));
 }
 
 static int __attribute__((__unused__))
@@ -332,9 +334,9 @@ static inline void remove_debug_files (struct ehci_hcd *bus) { }
 		default: tmp = '?'; break; \
 		}; tmp; })
 
-static inline char token_mark (__le32 token)
+static inline char token_mark (__ehci32 token)
 {
-	__u32 v = le32_to_cpu (token);
+	__u32 v = ehci32_to_cpu (token);
 	if (v & QTD_STS_ACTIVE)
 		return '*';
 	if (v & QTD_STS_HALT)
@@ -372,29 +374,29 @@ static void qh_lines (
 			mark = '.';	/* use hw_qtd_next */
 		/* else alt_next points to some other qtd */
 	}
-	scratch = le32_to_cpup (&qh->hw_info1);
-	hw_curr = (mark == '*') ? le32_to_cpup (&qh->hw_current) : 0;
+	scratch = ehci32_to_cpup (&qh->hw_info1);
+	hw_curr = (mark == '*') ? ehci32_to_cpup (&qh->hw_current) : 0;
 	temp = scnprintf (next, size,
 			"qh/%p dev%d %cs ep%d %08x %08x (%08x%c %s nak%d)",
 			qh, scratch & 0x007f,
 			speed_char (scratch),
 			(scratch >> 8) & 0x000f,
-			scratch, le32_to_cpup (&qh->hw_info2),
-			le32_to_cpup (&qh->hw_token), mark,
-			(__constant_cpu_to_le32 (QTD_TOGGLE) & qh->hw_token)
+			scratch, ehci32_to_cpup (&qh->hw_info2),
+			ehci32_to_cpup (&qh->hw_token), mark,
+			(__constant_cpu_to_ehci32 (QTD_TOGGLE) & qh->hw_token)
 				? "data1" : "data0",
-			(le32_to_cpup (&qh->hw_alt_next) >> 1) & 0x0f);
+			(ehci32_to_cpup (&qh->hw_alt_next) >> 1) & 0x0f);
 	size -= temp;
 	next += temp;
 
 	/* hc may be modifying the list as we read it ... */
 	list_for_each (entry, &qh->qtd_list) {
 		td = list_entry (entry, struct ehci_qtd, qtd_list);
-		scratch = le32_to_cpup (&td->hw_token);
+		scratch = ehci32_to_cpup (&td->hw_token);
 		mark = ' ';
 		if (hw_curr == td->qtd_dma)
 			mark = '*';
-		else if (qh->hw_qtd_next == cpu_to_le32(td->qtd_dma))
+		else if (qh->hw_qtd_next == cpu_to_ehci32(td->qtd_dma))
 			mark = '+';
 		else if (QTD_LENGTH (scratch)) {
 			if (td->hw_alt_next == ehci->async->hw_alt_next)
@@ -490,7 +492,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 	unsigned		temp, size, seen_count;
 	char			*next;
 	unsigned		i;
-	__le32			tag;
+	__ehci32		tag;
 
 	if (!(seen = kmalloc (DBG_SCHED_LIMIT * sizeof *seen, GFP_ATOMIC)))
 		return 0;
@@ -525,7 +527,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 			case Q_TYPE_QH:
 				temp = scnprintf (next, size, " qh%d-%04x/%p",
 						p.qh->period,
-						le32_to_cpup (&p.qh->hw_info2)
+						ehci32_to_cpup(&p.qh->hw_info2)
 							/* uframe masks */
 							& (QH_CMASK | QH_SMASK),
 						p.qh);
@@ -543,7 +545,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 				}
 				/* show more info the first time around */
 				if (temp == seen_count && p.ptr) {
-					u32	scratch = le32_to_cpup (
+					u32	scratch = ehci32_to_cpup (
 							&p.qh->hw_info1);
 					struct ehci_qtd	*qtd;
 					char		*type = "";
@@ -554,7 +556,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 							&p.qh->qtd_list,
 							qtd_list) {
 						temp++;
-						switch (0x03 & (le32_to_cpu (
+						switch (0x03 & (ehci32_to_cpu (
 							qtd->hw_token) >> 8)) {
 						case 0: type = "out"; continue;
 						case 1: type = "in"; continue;
@@ -597,7 +599,7 @@ show_periodic (struct class_device *class_dev, char *buf)
 				temp = scnprintf (next, size,
 					" sitd%d-%04x/%p",
 					p.sitd->stream->interval,
-					le32_to_cpup (&p.sitd->hw_uframe)
+					ehci32_to_cpup (&p.sitd->hw_uframe)
 						& 0x0000ffff,
 					p.sitd);
 				tag = Q_NEXT_TYPE (p.sitd->hw_next);
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index c7458f7..fee885a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -16,6 +16,12 @@
  * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#ifdef CONFIG_USB_DEBUG
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/dmapool.h>
@@ -141,6 +147,12 @@ MODULE_PARM_DESC (ignore_oc, "ignore bogus hardware overcurrent indications");
 #include "ehci.h"
 #include "ehci-dbg.c"
 
+#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
+extern void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci);
+#else
+#define usb_hcd_tdi_set_mode(ehci)	do { } while (0)
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -206,6 +218,9 @@ static void tdi_reset (struct ehci_hcd *ehci)
 	tmp = ehci_readl(ehci, reg_ptr);
 	tmp |= 0x3;
 	ehci_writel(ehci, tmp, reg_ptr);
+
+	/* set controller to host mode */
+	usb_hcd_tdi_set_mode(ehci);
 }
 
 /* reset a non-running (STS_HALT == 1) controller */
@@ -472,8 +487,8 @@ static int ehci_init(struct usb_hcd *hcd)
 	 */
 	ehci->async->qh_next.qh = NULL;
 	ehci->async->hw_next = QH_NEXT(ehci->async->qh_dma);
-	ehci->async->hw_info1 = cpu_to_le32(QH_HEAD);
-	ehci->async->hw_token = cpu_to_le32(QTD_STS_HALT);
+	ehci->async->hw_info1 = cpu_to_ehci32(QH_HEAD);
+	ehci->async->hw_token = cpu_to_ehci32(QTD_STS_HALT);
 	ehci->async->hw_qtd_next = EHCI_LIST_END;
 	ehci->async->qh_state = QH_STATE_LINKED;
 	ehci->async->hw_alt_next = QTD_NEXT(ehci->async->dummy->qtd_dma);
@@ -936,6 +951,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_PMC_MSP
+#include "ehci-pmcmsp.c"
+#define	PLATFORM_DRIVER		ehci_hcd_msp_driver
+#endif
+
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_sb_driver
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 1813b7c..9eb6489 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -552,9 +552,16 @@ static int ehci_hub_control (
 			status |= 1 << USB_PORT_FEAT_C_CONNECTION;
 		if (temp & PORT_PEC)
 			status |= 1 << USB_PORT_FEAT_C_ENABLE;
-		if ((temp & PORT_OCC) && !ignore_oc)
+		if ((temp & PORT_OCC) && !ignore_oc) {
 			status |= 1 << USB_PORT_FEAT_C_OVER_CURRENT;
 
+			/* read PORT_OC bit as well */
+			if ((temp & PORT_OC) &&
+			    strcmp(hcd->self.controller->driver->name,
+			    "pmcmsp-ehci") == 0)
+				status |= 1 << USB_PORT_FEAT_OVER_CURRENT;
+		}
+
 		/* whoever resumes must GetPortStatus to complete it!! */
 		if (temp & PORT_RESUME) {
 
diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index a8ba2e1..1134b55 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -39,7 +39,7 @@ static inline void ehci_qtd_init (struct ehci_qtd *qtd, dma_addr_t dma)
 {
 	memset (qtd, 0, sizeof *qtd);
 	qtd->qtd_dma = dma;
-	qtd->hw_token = cpu_to_le32 (QTD_STS_HALT);
+	qtd->hw_token = cpu_to_ehci32 (QTD_STS_HALT);
 	qtd->hw_next = EHCI_LIST_END;
 	qtd->hw_alt_next = EHCI_LIST_END;
 	INIT_LIST_HEAD (&qtd->qtd_list);
@@ -209,9 +209,9 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 	}
 
 	/* Hardware periodic table */
-	ehci->periodic = (__le32 *)
+	ehci->periodic = (__ehci32 *)
 		dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
-			ehci->periodic_size * sizeof(__le32),
+			ehci->periodic_size * sizeof(__ehci32),
 			&ehci->periodic_dma, 0);
 	if (ehci->periodic == NULL) {
 		goto fail;
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index e7fbbd0..b87344d 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -50,8 +50,8 @@ qtd_fill (struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 	u64	addr = buf;
 
 	/* one buffer entry per 4K ... first might be short or unaligned */
-	qtd->hw_buf [0] = cpu_to_le32 ((u32)addr);
-	qtd->hw_buf_hi [0] = cpu_to_le32 ((u32)(addr >> 32));
+	qtd->hw_buf [0] = cpu_to_ehci32 ((u32)addr);
+	qtd->hw_buf_hi [0] = cpu_to_ehci32 ((u32)(addr >> 32));
 	count = 0x1000 - (buf & 0x0fff);	/* rest of that page */
 	if (likely (len < count))		/* ... iff needed */
 		count = len;
@@ -62,8 +62,8 @@ qtd_fill (struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 		/* per-qtd limit: from 16K to 20K (best alignment) */
 		for (i = 1; count < len && i < 5; i++) {
 			addr = buf;
-			qtd->hw_buf [i] = cpu_to_le32 ((u32)addr);
-			qtd->hw_buf_hi [i] = cpu_to_le32 ((u32)(addr >> 32));
+			qtd->hw_buf [i] = cpu_to_ehci32 ((u32)addr);
+			qtd->hw_buf_hi [i] = cpu_to_ehci32 ((u32)(addr >> 32));
 			buf += 0x1000;
 			if ((count + 0x1000) < len)
 				count += 0x1000;
@@ -75,7 +75,7 @@ qtd_fill (struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 		if (count != len)
 			count -= (count % maxpacket);
 	}
-	qtd->hw_token = cpu_to_le32 ((count << 16) | token);
+	qtd->hw_token = cpu_to_ehci32 ((count << 16) | token);
 	qtd->length = count;
 
 	return count;
@@ -97,20 +97,20 @@ qh_update (struct ehci_hcd *ehci, struct ehci_qh *qh, struct ehci_qtd *qtd)
 	 * and set the pseudo-toggle in udev. Only usb_clear_halt() will
 	 * ever clear it.
 	 */
-	if (!(qh->hw_info1 & cpu_to_le32(1 << 14))) {
+	if (!(qh->hw_info1 & cpu_to_ehci32(1 << 14))) {
 		unsigned	is_out, epnum;
 
-		is_out = !(qtd->hw_token & cpu_to_le32(1 << 8));
-		epnum = (le32_to_cpup(&qh->hw_info1) >> 8) & 0x0f;
+		is_out = !(qtd->hw_token & cpu_to_ehci32(1 << 8));
+		epnum = (ehci32_to_cpup(&qh->hw_info1) >> 8) & 0x0f;
 		if (unlikely (!usb_gettoggle (qh->dev, epnum, is_out))) {
-			qh->hw_token &= ~__constant_cpu_to_le32 (QTD_TOGGLE);
+			qh->hw_token &= ~__constant_cpu_to_ehci32 (QTD_TOGGLE);
 			usb_settoggle (qh->dev, epnum, is_out, 1);
 		}
 	}
 
 	/* HC must see latest qtd and qh data before we clear ACTIVE+HALT */
 	wmb ();
-	qh->hw_token &= __constant_cpu_to_le32 (QTD_TOGGLE | QTD_STS_PING);
+	qh->hw_token &= __constant_cpu_to_ehci32 (QTD_TOGGLE | QTD_STS_PING);
 }
 
 /* if it weren't for a common silicon quirk (writing the dummy into the qh
@@ -128,7 +128,7 @@ qh_refresh (struct ehci_hcd *ehci, struct ehci_qh *qh)
 		qtd = list_entry (qh->qtd_list.next,
 				struct ehci_qtd, qtd_list);
 		/* first qtd may already be partially processed */
-		if (cpu_to_le32 (qtd->qtd_dma) == qh->hw_current)
+		if (cpu_to_ehci32 (qtd->qtd_dma) == qh->hw_current)
 			qtd = NULL;
 	}
 
@@ -222,7 +222,7 @@ __acquires(ehci->lock)
 		struct ehci_qh	*qh = (struct ehci_qh *) urb->hcpriv;
 
 		/* S-mask in a QH means it's an interrupt urb */
-		if ((qh->hw_info2 & __constant_cpu_to_le32 (QH_SMASK)) != 0) {
+		if ((qh->hw_info2 & __constant_cpu_to_ehci32 (QH_SMASK)) != 0) {
 
 			/* ... update hc-wide periodic stats (for usbfs) */
 			ehci_to_hcd(ehci)->self.bandwidth_int_reqs--;
@@ -277,7 +277,7 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
  * Chases up to qh->hw_current.  Returns number of completions called,
  * indicating how much "real" work we did.
  */
-#define HALT_BIT __constant_cpu_to_le32(QTD_STS_HALT)
+#define HALT_BIT __constant_cpu_to_ehci32(QTD_STS_HALT)
 static unsigned
 qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
@@ -330,7 +330,7 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 		/* hardware copies qtd out of qh overlay */
 		rmb ();
-		token = le32_to_cpu (qtd->hw_token);
+		token = ehci32_to_cpu (qtd->hw_token);
 
 		/* always clean up qtds the hc de-activated */
 		if ((token & QTD_STS_ACTIVE) == 0) {
@@ -374,9 +374,9 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 			/* token in overlay may be most current */
 			if (state == QH_STATE_IDLE
-					&& cpu_to_le32 (qtd->qtd_dma)
+					&& cpu_to_ehci32 (qtd->qtd_dma)
 						== qh->hw_current)
-				token = le32_to_cpu (qh->hw_token);
+				token = ehci32_to_cpu (qh->hw_token);
 
 			/* force halt for unlinked or blocked qh, so we'll
 			 * patch the qh later and so that completions can't
@@ -428,7 +428,7 @@ halt:
 			/* should be rare for periodic transfers,
 			 * except maybe high bandwidth ...
 			 */
-			if ((__constant_cpu_to_le32 (QH_SMASK)
+			if ((__constant_cpu_to_ehci32 (QH_SMASK)
 					& qh->hw_info2) != 0) {
 				intr_deschedule (ehci, qh);
 				(void) qh_schedule (ehci, qh);
@@ -600,7 +600,7 @@ qh_urb_transaction (
 
 	/* by default, enable interrupt on urb completion */
 	if (likely (!(urb->transfer_flags & URB_NO_INTERRUPT)))
-		qtd->hw_token |= __constant_cpu_to_le32 (QTD_IOC);
+		qtd->hw_token |= __constant_cpu_to_ehci32 (QTD_IOC);
 	return head;
 
 cleanup:
@@ -769,8 +769,8 @@ done:
 
 	/* init as live, toggle clear, advance to dummy */
 	qh->qh_state = QH_STATE_IDLE;
-	qh->hw_info1 = cpu_to_le32 (info1);
-	qh->hw_info2 = cpu_to_le32 (info2);
+	qh->hw_info1 = cpu_to_ehci32 (info1);
+	qh->hw_info2 = cpu_to_ehci32 (info2);
 	usb_settoggle (urb->dev, usb_pipeendpoint (urb->pipe), !is_input, 1);
 	qh_refresh (ehci, qh);
 	return qh;
@@ -782,7 +782,7 @@ done:
 
 static void qh_link_async (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
-	__le32		dma = QH_NEXT (qh->qh_dma);
+	__ehci32	dma = QH_NEXT (qh->qh_dma);
 	struct ehci_qh	*head;
 
 	/* (re)start the async schedule? */
@@ -820,7 +820,7 @@ static void qh_link_async (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 /*-------------------------------------------------------------------------*/
 
-#define	QH_ADDR_MASK	__constant_cpu_to_le32(0x7f)
+#define	QH_ADDR_MASK	__constant_cpu_to_ehci32(0x7f)
 
 /*
  * For control/bulk/interrupt, return QH with these TDs appended.
@@ -867,7 +867,7 @@ static struct ehci_qh *qh_append_tds (
 		if (likely (qtd != NULL)) {
 			struct ehci_qtd		*dummy;
 			dma_addr_t		dma;
-			__le32			token;
+			__ehci32		token;
 
 			/* to avoid racing the HC, use the dummy td instead of
 			 * the first td of our list (becomes new dummy).  both
@@ -970,7 +970,7 @@ static void end_unlink_async (struct ehci_hcd *ehci)
 
 	timer_action_done (ehci, TIMER_IAA_WATCHDOG);
 
-	// qh->hw_next = cpu_to_le32 (qh->qh_dma);
+	/* qh->hw_next = cpu_to_ehci32 (qh->qh_dma); */
 	qh->qh_state = QH_STATE_IDLE;
 	qh->qh_next.qh = NULL;
 	qh_put (qh);			// refcount from reclaim
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 7b5ae71..1e51c0d 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -44,7 +44,7 @@ static int ehci_get_frame (struct usb_hcd *hcd);
  * @tag: hardware tag for type of this record
  */
 static union ehci_shadow *
-periodic_next_shadow (union ehci_shadow *periodic, __le32 tag)
+periodic_next_shadow (union ehci_shadow *periodic, __ehci32 tag)
 {
 	switch (tag) {
 	case Q_TYPE_QH:
@@ -63,7 +63,7 @@ periodic_next_shadow (union ehci_shadow *periodic, __le32 tag)
 static void periodic_unlink (struct ehci_hcd *ehci, unsigned frame, void *ptr)
 {
 	union ehci_shadow	*prev_p = &ehci->pshadow [frame];
-	__le32			*hw_p = &ehci->periodic [frame];
+	__ehci32		*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	here = *prev_p;
 
 	/* find predecessor of "ptr"; hw and shadow lists are in sync */
@@ -87,7 +87,7 @@ static void periodic_unlink (struct ehci_hcd *ehci, unsigned frame, void *ptr)
 static unsigned short
 periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 {
-	__le32			*hw_p = &ehci->periodic [frame];
+	__ehci32		*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	*q = &ehci->pshadow [frame];
 	unsigned		usecs = 0;
 
@@ -95,10 +95,11 @@ periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 		switch (Q_NEXT_TYPE (*hw_p)) {
 		case Q_TYPE_QH:
 			/* is it in the S-mask? */
-			if (q->qh->hw_info2 & cpu_to_le32 (1 << uframe))
+			if (q->qh->hw_info2 & cpu_to_ehci32 (1 << uframe))
 				usecs += q->qh->usecs;
 			/* ... or C-mask? */
-			if (q->qh->hw_info2 & cpu_to_le32 (1 << (8 + uframe)))
+			if (q->qh->hw_info2 &
+			    cpu_to_ehci32 (1 << (8 + uframe)))
 				usecs += q->qh->c_usecs;
 			hw_p = &q->qh->hw_next;
 			q = &q->qh->qh_next;
@@ -121,9 +122,10 @@ periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 			break;
 		case Q_TYPE_SITD:
 			/* is it in the S-mask?  (count SPLIT, DATA) */
-			if (q->sitd->hw_uframe & cpu_to_le32 (1 << uframe)) {
+			if (q->sitd->hw_uframe &
+			    cpu_to_ehci32 (1 << uframe)) {
 				if (q->sitd->hw_fullspeed_ep &
-						__constant_cpu_to_le32 (1<<31))
+				    __constant_cpu_to_ehci32 (1<<31))
 					usecs += q->sitd->stream->usecs;
 				else	/* worst case for OUT start-split */
 					usecs += HS_USECS_ISO (188);
@@ -131,7 +133,7 @@ periodic_usecs (struct ehci_hcd *ehci, unsigned frame, unsigned uframe)
 
 			/* ... C-mask?  (count CSPLIT, DATA) */
 			if (q->sitd->hw_uframe &
-					cpu_to_le32 (1 << (8 + uframe))) {
+					cpu_to_ehci32 (1 << (8 + uframe))) {
 				/* worst case for IN complete-split */
 				usecs += q->sitd->stream->c_usecs;
 			}
@@ -173,9 +175,10 @@ static int same_tt (struct usb_device *dev1, struct usb_device *dev2)
  * will cause a transfer in "B-frame" uframe 0.  "B-frames" lag
  * "H-frames" by 1 uframe.  See the EHCI spec sec 4.5 and figure 4.7.
  */
-static inline unsigned char tt_start_uframe(struct ehci_hcd *ehci, __le32 mask)
+static inline unsigned char tt_start_uframe(struct ehci_hcd *ehci,
+					    __ehci32 mask)
 {
-	unsigned char smask = QH_SMASK & le32_to_cpu(mask);
+	unsigned char smask = QH_SMASK & ehci32_to_cpu(mask);
 	if (!smask) {
 		ehci_err(ehci, "invalid empty smask!\n");
 		/* uframe 7 can't have bw so this will indicate failure */
@@ -217,7 +220,7 @@ periodic_tt_usecs (
 	unsigned short tt_usecs[8]
 )
 {
-	__le32			*hw_p = &ehci->periodic [frame];
+	__ehci32		*hw_p = &ehci->periodic [frame];
 	union ehci_shadow	*q = &ehci->pshadow [frame];
 	unsigned char		uf;
 
@@ -368,7 +371,7 @@ static int tt_no_collision (
 	 */
 	for (; frame < ehci->periodic_size; frame += period) {
 		union ehci_shadow	here;
-		__le32			type;
+		__ehci32		type;
 
 		here = ehci->pshadow [frame];
 		type = Q_NEXT_TYPE (ehci->periodic [frame]);
@@ -382,7 +385,8 @@ static int tt_no_collision (
 				if (same_tt (dev, here.qh->dev)) {
 					u32		mask;
 
-					mask = le32_to_cpu (here.qh->hw_info2);
+					mask = ehci32_to_cpu(
+							here.qh->hw_info2);
 					/* "knows" no gap is needed */
 					mask |= mask >> 8;
 					if (mask & uf_mask)
@@ -395,7 +399,7 @@ static int tt_no_collision (
 				if (same_tt (dev, here.sitd->urb->dev)) {
 					u16		mask;
 
-					mask = le32_to_cpu (here.sitd
+					mask = ehci32_to_cpu (here.sitd
 								->hw_uframe);
 					/* FIXME assumes no gap for IN! */
 					mask |= mask >> 8;
@@ -487,7 +491,7 @@ static int qh_link_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 	dev_dbg (&qh->dev->dev,
 		"link qh%d-%04x/%p start %d [%d/%d us]\n",
-		period, le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
+		period, ehci32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* high bandwidth, or otherwise every microframe */
@@ -496,9 +500,9 @@ static int qh_link_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 	for (i = qh->start; i < ehci->periodic_size; i += period) {
 		union ehci_shadow	*prev = &ehci->pshadow [i];
-		__le32			*hw_p = &ehci->periodic [i];
+		__ehci32		*hw_p = &ehci->periodic [i];
 		union ehci_shadow	here = *prev;
-		__le32			type = 0;
+		__ehci32		type = 0;
 
 		/* skip the iso nodes at list head */
 		while (here.ptr) {
@@ -555,7 +559,7 @@ static void qh_unlink_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	//   and this qh is active in the current uframe
 	//   (and overlay token SplitXstate is false?)
 	// THEN
-	//   qh->hw_info1 |= __constant_cpu_to_le32 (1 << 7 /* "ignore" */);
+	//   qh->hw_info1 |= __constant_cpu_to_ehci32 (1 << 7 /* "ignore" */);
 
 	/* high bandwidth, or otherwise part of every microframe */
 	if ((period = qh->period) == 0)
@@ -572,7 +576,7 @@ static void qh_unlink_periodic (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	dev_dbg (&qh->dev->dev,
 		"unlink qh%d-%04x/%p start %d [%d/%d us]\n",
 		qh->period,
-		le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
+		ehci32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* qh->qh_next still "live" to HC */
@@ -598,7 +602,7 @@ static void intr_deschedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	 * active high speed queues may need bigger delays...
 	 */
 	if (list_empty (&qh->qtd_list)
-			|| (__constant_cpu_to_le32 (QH_CMASK)
+			|| (__constant_cpu_to_ehci32 (QH_CMASK)
 					& qh->hw_info2) != 0)
 		wait = 2;
 	else
@@ -663,7 +667,7 @@ static int check_intr_schedule (
 	unsigned		frame,
 	unsigned		uframe,
 	const struct ehci_qh	*qh,
-	__le32			*c_maskp
+	__ehci32		*c_maskp
 )
 {
 	int		retval = -ENOSPC;
@@ -685,7 +689,7 @@ static int check_intr_schedule (
 				qh->tt_usecs)) {
 		unsigned i;
 
-		/* TODO : this may need FSTN for SSPLIT in uframe 5. */
+		/* TODO: this may need FSTN for SSPLIT in uframe 5. */
 		for (i=uframe+1; i<8 && i<uframe+4; i++)
 			if (!check_period (ehci, frame, i,
 						qh->period, qh->c_usecs))
@@ -695,7 +699,7 @@ static int check_intr_schedule (
 
 		retval = 0;
 
-		*c_maskp = cpu_to_le32 (mask << 8);
+		*c_maskp = cpu_to_ehci32 (mask << 8);
 	}
 #else
 	/* Make sure this tt's buffer is also available for CSPLITs.
@@ -706,7 +710,7 @@ static int check_intr_schedule (
 	 * one smart pass...
 	 */
 	mask = 0x03 << (uframe + qh->gap_uf);
-	*c_maskp = cpu_to_le32 (mask << 8);
+	*c_maskp = cpu_to_ehci32 (mask << 8);
 
 	mask |= 1 << uframe;
 	if (tt_no_collision (ehci, qh->period, qh->dev, frame, mask)) {
@@ -730,7 +734,7 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	int		status;
 	unsigned	uframe;
-	__le32		c_mask;
+	__ehci32	c_mask;
 	unsigned	frame;		/* 0..(qh->period - 1), or NO_FRAME */
 
 	qh_refresh(ehci, qh);
@@ -739,7 +743,7 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 
 	/* reuse the previous schedule slots, if we can */
 	if (frame < qh->period) {
-		uframe = ffs (le32_to_cpup (&qh->hw_info2) & QH_SMASK);
+		uframe = ffs (ehci32_to_cpup (&qh->hw_info2) & QH_SMASK);
 		status = check_intr_schedule (ehci, frame, --uframe,
 				qh, &c_mask);
 	} else {
@@ -775,10 +779,11 @@ static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh)
 		qh->start = frame;
 
 		/* reset S-frame and (maybe) C-frame masks */
-		qh->hw_info2 &= __constant_cpu_to_le32(~(QH_CMASK | QH_SMASK));
+		qh->hw_info2 &= __constant_cpu_to_ehci32(
+					~(QH_CMASK | QH_SMASK));
 		qh->hw_info2 |= qh->period
-			? cpu_to_le32 (1 << uframe)
-			: __constant_cpu_to_le32 (QH_SMASK);
+			? cpu_to_ehci32 (1 << uframe)
+			: __constant_cpu_to_ehci32 (QH_SMASK);
 		qh->hw_info2 |= c_mask;
 	} else
 		ehci_dbg (ehci, "reused qh %p schedule\n", qh);
@@ -898,9 +903,9 @@ iso_stream_init (
 		buf1 |= maxp;
 		maxp *= multi;
 
-		stream->buf0 = cpu_to_le32 ((epnum << 8) | dev->devnum);
-		stream->buf1 = cpu_to_le32 (buf1);
-		stream->buf2 = cpu_to_le32 (multi);
+		stream->buf0 = cpu_to_ehci32 ((epnum << 8) | dev->devnum);
+		stream->buf1 = cpu_to_ehci32 (buf1);
+		stream->buf2 = cpu_to_ehci32 (multi);
 
 		/* usbfs wants to report the average usecs per frame tied up
 		 * when transfers on this endpoint are scheduled ...
@@ -943,7 +948,7 @@ iso_stream_init (
 		bandwidth /= 1 << (interval + 2);
 
 		/* stream->splits gets created from raw_mask later */
-		stream->address = cpu_to_le32 (addr);
+		stream->address = cpu_to_ehci32 (addr);
 	}
 	stream->bandwidth = bandwidth;
 
@@ -1107,7 +1112,7 @@ itd_sched_init (
 				&& !(urb->transfer_flags & URB_NO_INTERRUPT))
 			trans |= EHCI_ITD_IOC;
 		trans |= length << 16;
-		uframe->transaction = cpu_to_le32 (trans);
+		uframe->transaction = cpu_to_ehci32 (trans);
 
 		/* might need to cross a buffer page within a uframe */
 		uframe->bufp = (buf & ~(u64)0x0fff);
@@ -1294,7 +1299,7 @@ sitd_slot_ok (
 		uframe += period_uframes;
 	} while (uframe < mod);
 
-	stream->splits = cpu_to_le32(stream->raw_mask << (uframe & 7));
+	stream->splits = cpu_to_ehci32(stream->raw_mask << (uframe & 7));
 	return 1;
 }
 
@@ -1448,16 +1453,16 @@ itd_patch (
 	itd->index [uframe] = index;
 
 	itd->hw_transaction [uframe] = uf->transaction;
-	itd->hw_transaction [uframe] |= cpu_to_le32 (pg << 12);
-	itd->hw_bufp [pg] |= cpu_to_le32 (uf->bufp & ~(u32)0);
-	itd->hw_bufp_hi [pg] |= cpu_to_le32 ((u32)(uf->bufp >> 32));
+	itd->hw_transaction [uframe] |= cpu_to_ehci32 (pg << 12);
+	itd->hw_bufp [pg] |= cpu_to_ehci32 (uf->bufp & ~(u32)0);
+	itd->hw_bufp_hi [pg] |= cpu_to_ehci32 ((u32)(uf->bufp >> 32));
 
 	/* iso_frame_desc[].offset must be strictly increasing */
 	if (unlikely (uf->cross)) {
 		u64	bufp = uf->bufp + 4096;
 		itd->pg = ++pg;
-		itd->hw_bufp [pg] |= cpu_to_le32 (bufp & ~(u32)0);
-		itd->hw_bufp_hi [pg] |= cpu_to_le32 ((u32)(bufp >> 32));
+		itd->hw_bufp [pg] |= cpu_to_ehci32 (bufp & ~(u32)0);
+		itd->hw_bufp_hi [pg] |= cpu_to_ehci32 ((u32)(bufp >> 32));
 	}
 }
 
@@ -1470,7 +1475,7 @@ itd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_itd *itd)
 	ehci->pshadow [frame].itd = itd;
 	itd->frame = frame;
 	wmb ();
-	ehci->periodic [frame] = cpu_to_le32 (itd->itd_dma) | Q_TYPE_ITD;
+	ehci->periodic [frame] = cpu_to_ehci32 (itd->itd_dma) | Q_TYPE_ITD;
 }
 
 /* fit urb's itds into the selected schedule slot; activate as needed */
@@ -1570,7 +1575,7 @@ itd_complete (
 		urb_index = itd->index[uframe];
 		desc = &urb->iso_frame_desc [urb_index];
 
-		t = le32_to_cpup (&itd->hw_transaction [uframe]);
+		t = ehci32_to_cpup (&itd->hw_transaction [uframe]);
 		itd->hw_transaction [uframe] = 0;
 		stream->depth -= stream->interval;
 
@@ -1729,7 +1734,7 @@ sitd_sched_init (
 				&& !(urb->transfer_flags & URB_NO_INTERRUPT))
 			trans |= SITD_IOC;
 		trans |= length << 16;
-		packet->transaction = cpu_to_le32 (trans);
+		packet->transaction = cpu_to_ehci32 (trans);
 
 		/* might need to cross a buffer page within a td */
 		packet->bufp = buf;
@@ -1834,13 +1839,13 @@ sitd_patch (
 	sitd->hw_backpointer = EHCI_LIST_END;
 
 	bufp = uf->bufp;
-	sitd->hw_buf [0] = cpu_to_le32 (bufp);
-	sitd->hw_buf_hi [0] = cpu_to_le32 (bufp >> 32);
+	sitd->hw_buf [0] = cpu_to_ehci32 (bufp);
+	sitd->hw_buf_hi [0] = cpu_to_ehci32 (bufp >> 32);
 
-	sitd->hw_buf [1] = cpu_to_le32 (uf->buf1);
+	sitd->hw_buf [1] = cpu_to_ehci32 (uf->buf1);
 	if (uf->cross)
 		bufp += 4096;
-	sitd->hw_buf_hi [1] = cpu_to_le32 (bufp >> 32);
+	sitd->hw_buf_hi [1] = cpu_to_ehci32 (bufp >> 32);
 	sitd->index = index;
 }
 
@@ -1853,7 +1858,7 @@ sitd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_sitd *sitd)
 	ehci->pshadow [frame].sitd = sitd;
 	sitd->frame = frame;
 	wmb ();
-	ehci->periodic [frame] = cpu_to_le32 (sitd->sitd_dma) | Q_TYPE_SITD;
+	ehci->periodic [frame] = cpu_to_ehci32 (sitd->sitd_dma) | Q_TYPE_SITD;
 }
 
 /* fit urb's sitds into the selected schedule slot; activate as needed */
@@ -1881,7 +1886,7 @@ sitd_link_urb (
 			urb->dev->devpath, stream->bEndpointAddress & 0x0f,
 			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out",
 			(next_uframe >> 3) % ehci->periodic_size,
-			stream->interval, le32_to_cpu (stream->splits));
+			stream->interval, ehci32_to_cpu (stream->splits));
 		stream->start = jiffies;
 	}
 	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs++;
@@ -1940,7 +1945,7 @@ sitd_complete (
 
 	urb_index = sitd->index;
 	desc = &urb->iso_frame_desc [urb_index];
-	t = le32_to_cpup (&sitd->hw_results);
+	t = ehci32_to_cpup (&sitd->hw_results);
 
 	/* report transfer status */
 	if (t & SITD_ERRS) {
@@ -2095,7 +2100,7 @@ scan_periodic (struct ehci_hcd *ehci)
 
 	for (;;) {
 		union ehci_shadow	q, *q_p;
-		__le32			type, *hw_p;
+		__ehci32		type, *hw_p;
 		unsigned		uframes;
 
 		/* don't scan past the live uframe */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 46fa57a..b5de2cf 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -21,6 +21,99 @@
 
 /* definitions used for the EHCI driver */
 
+/*
+ * __ehci32 and __ehci16 are "EHCI Host Controller" types, they may be
+ * equivalent to __leXX (normally) or __beXX (given EHCI_BIG_ENDIAN),
+ * depending on the host controller implementation.
+ */
+typedef __u32 __bitwise __ehci32;
+typedef __u16 __bitwise __ehci16;
+
+/* cpu to ehci */
+static inline __ehci16 cpu_to_ehci16 (const u16 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return (__force __ehci16)cpu_to_be16(x);
+#else
+	return (__force __ehci16)cpu_to_le16(x);
+#endif
+}
+
+static inline __ehci16 cpu_to_ehci16p (const u16 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return cpu_to_be16p(x);
+#else
+	return cpu_to_le16p(x);
+#endif
+}
+
+static inline __ehci32 cpu_to_ehci32 (const u32 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return (__force __ehci32)cpu_to_be32(x);
+#else
+	return (__force __ehci32)cpu_to_le32(x);
+#endif
+}
+
+static inline __ehci32 cpu_to_ehci32p (const u32 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return cpu_to_be32p(x);
+#else
+	return cpu_to_le32p(x);
+#endif
+}
+
+/* ehci to cpu */
+static inline u16 ehci16_to_cpu (const __ehci16 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be16_to_cpu((__force __be16)x);
+#else
+	return le16_to_cpu((__force __le16)x);
+#endif
+}
+
+static inline u16 ehci16_to_cpup (const __ehci16 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be16_to_cpup((__force __be16 *)x);
+#else
+	return le16_to_cpup((__force __le16 *)x);
+#endif
+}
+
+static inline u32 ehci32_to_cpu (const __ehci32 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be32_to_cpu((__force __be32)x);
+#else
+	return le32_to_cpu((__force __le32)x);
+#endif
+}
+
+static inline u32 ehci32_to_cpup (const __ehci32 *x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return be32_to_cpup((__force __be32 *)x);
+#else
+	return le32_to_cpup((__force __le32 *)x);
+#endif
+}
+
+static inline u32 __constant_cpu_to_ehci32(const __ehci32 x)
+{
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+	return __constant_cpu_to_be32((__force __be32)x);
+#else
+	return __constant_cpu_to_le32((__force __le32 )x);
+#endif
+}
+
+/*-------------------------------------------------------------------------*/
+
 /* statistics can be kept for for tuning/monitoring */
 struct ehci_stats {
 	/* irq usage */
@@ -64,7 +157,7 @@ struct ehci_hcd {			/* one per controller */
 	/* periodic schedule support */
 #define	DEFAULT_I_TDPS		1024		/* some HCs can do less */
 	unsigned		periodic_size;
-	__le32			*periodic;	/* hw periodic table */
+	__ehci32		*periodic;	/* hw periodic table */
 	dma_addr_t		periodic_dma;
 	unsigned		i_thresh;	/* uframes HC might cache */
 
@@ -303,7 +396,7 @@ struct ehci_dbg_port {
 
 /*-------------------------------------------------------------------------*/
 
-#define	QTD_NEXT(dma)	cpu_to_le32((u32)dma)
+#define	QTD_NEXT(dma)	cpu_to_ehci32((u32)dma)
 
 /*
  * EHCI Specification 0.95 Section 3.5
@@ -315,9 +408,9 @@ struct ehci_dbg_port {
  */
 struct ehci_qtd {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;	  /* see EHCI 3.5.1 */
-	__le32			hw_alt_next;      /* see EHCI 3.5.2 */
-	__le32			hw_token;         /* see EHCI 3.5.3 */
+	__ehci32		hw_next;	  /* see EHCI 3.5.1 */
+	__ehci32		hw_alt_next;	  /* see EHCI 3.5.2 */
+	__ehci32		hw_token;	  /* see EHCI 3.5.3 */
 #define	QTD_TOGGLE	(1 << 31)	/* data toggle */
 #define	QTD_LENGTH(tok)	(((tok)>>16) & 0x7fff)
 #define	QTD_IOC		(1 << 15)	/* interrupt on complete */
@@ -331,8 +424,8 @@ struct ehci_qtd {
 #define	QTD_STS_MMF	(1 << 2)	/* incomplete split transaction */
 #define	QTD_STS_STS	(1 << 1)	/* split transaction state */
 #define	QTD_STS_PING	(1 << 0)	/* issue PING? */
-	__le32			hw_buf [5];        /* see EHCI 3.5.4 */
-	__le32			hw_buf_hi [5];        /* Appendix B */
+	__ehci32		hw_buf [5];        /* see EHCI 3.5.4 */
+	__ehci32		hw_buf_hi [5];        /* Appendix B */
 
 	/* the rest is HCD-private */
 	dma_addr_t		qtd_dma;		/* qtd address */
@@ -342,26 +435,45 @@ struct ehci_qtd {
 } __attribute__ ((aligned (32)));
 
 /* mask NakCnt+T in qh->hw_alt_next */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define QTD_MASK __constant_cpu_to_be32 (~0x1f)
+#else
 #define QTD_MASK __constant_cpu_to_le32 (~0x1f)
+#endif
 
 #define IS_SHORT_READ(token) (QTD_LENGTH (token) != 0 && QTD_PID (token) == 1)
 
 /*-------------------------------------------------------------------------*/
 
 /* type tag from {qh,itd,sitd,fstn}->hw_next */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define Q_NEXT_TYPE(dma) ((dma) & __constant_cpu_to_be32 (3 << 1))
+#else
 #define Q_NEXT_TYPE(dma) ((dma) & __constant_cpu_to_le32 (3 << 1))
+#endif
 
 /* values for that type tag */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define Q_TYPE_ITD	__constant_cpu_to_be32 (0 << 1)
+#define Q_TYPE_QH	__constant_cpu_to_be32 (1 << 1)
+#define Q_TYPE_SITD	__constant_cpu_to_be32 (2 << 1)
+#define Q_TYPE_FSTN	__constant_cpu_to_be32 (3 << 1)
+#else
 #define Q_TYPE_ITD	__constant_cpu_to_le32 (0 << 1)
 #define Q_TYPE_QH	__constant_cpu_to_le32 (1 << 1)
 #define Q_TYPE_SITD	__constant_cpu_to_le32 (2 << 1)
 #define Q_TYPE_FSTN	__constant_cpu_to_le32 (3 << 1)
+#endif
 
 /* next async queue entry, or pointer to interrupt/periodic QH */
-#define	QH_NEXT(dma)	(cpu_to_le32(((u32)dma)&~0x01f)|Q_TYPE_QH)
+#define	QH_NEXT(dma)	(cpu_to_ehci32(((u32)dma)&~0x01f)|Q_TYPE_QH)
 
 /* for periodic/async schedules and qtd lists, mark end of list */
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define	EHCI_LIST_END	__constant_cpu_to_be32(1) /* "null pointer" to hw */
+#else
 #define	EHCI_LIST_END	__constant_cpu_to_le32(1) /* "null pointer" to hw */
+#endif
 
 /*
  * Entries in periodic shadow table are pointers to one of four kinds
@@ -376,7 +488,7 @@ union ehci_shadow {
 	struct ehci_itd		*itd;		/* Q_TYPE_ITD */
 	struct ehci_sitd	*sitd;		/* Q_TYPE_SITD */
 	struct ehci_fstn	*fstn;		/* Q_TYPE_FSTN */
-	__le32			*hw_next;	/* (all types) */
+	__ehci32		*hw_next;	/* (all types) */
 	void			*ptr;
 };
 
@@ -392,23 +504,23 @@ union ehci_shadow {
 
 struct ehci_qh {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;	 /* see EHCI 3.6.1 */
-	__le32			hw_info1;        /* see EHCI 3.6.2 */
+	__ehci32		hw_next;	 /* see EHCI 3.6.1 */
+	__ehci32		hw_info1;	 /* see EHCI 3.6.2 */
 #define	QH_HEAD		0x00008000
-	__le32			hw_info2;        /* see EHCI 3.6.2 */
+	__ehci32		hw_info2;	 /* see EHCI 3.6.2 */
 #define	QH_SMASK	0x000000ff
 #define	QH_CMASK	0x0000ff00
 #define	QH_HUBADDR	0x007f0000
 #define	QH_HUBPORT	0x3f800000
 #define	QH_MULT		0xc0000000
-	__le32			hw_current;	 /* qtd list - see EHCI 3.6.4 */
+	__ehci32		hw_current;	 /* qtd list - see EHCI 3.6.4 */
 
 	/* qtd overlay (hardware parts of a struct ehci_qtd) */
-	__le32			hw_qtd_next;
-	__le32			hw_alt_next;
-	__le32			hw_token;
-	__le32			hw_buf [5];
-	__le32			hw_buf_hi [5];
+	__ehci32		hw_qtd_next;
+	__ehci32		hw_alt_next;
+	__ehci32		hw_token;
+	__ehci32		hw_buf [5];
+	__ehci32		hw_buf_hi [5];
 
 	/* the rest is HCD-private */
 	dma_addr_t		qh_dma;		/* address of qh */
@@ -445,7 +557,7 @@ struct ehci_qh {
 struct ehci_iso_packet {
 	/* These will be copied to iTD when scheduling */
 	u64			bufp;		/* itd->hw_bufp{,_hi}[pg] |= */
-	__le32			transaction;	/* itd->hw_transaction[i] |= */
+	__ehci32		transaction;	/* itd->hw_transaction[i] |= */
 	u8			cross;		/* buf crosses pages */
 	/* for full speed OUT splits */
 	u32			buf1;
@@ -467,8 +579,8 @@ struct ehci_iso_sched {
  */
 struct ehci_iso_stream {
 	/* first two fields match QH, but info1 == 0 */
-	__le32			hw_next;
-	__le32			hw_info1;
+	__ehci32		hw_next;
+	__ehci32		hw_info1;
 
 	u32			refcount;
 	u8			bEndpointAddress;
@@ -483,7 +595,7 @@ struct ehci_iso_stream {
 	unsigned long		start;		/* jiffies */
 	unsigned long		rescheduled;
 	int			next_uframe;
-	__le32			splits;
+	__ehci32		splits;
 
 	/* the rest is derived from the endpoint descriptor,
 	 * trusting urb->interval == f(epdesc->bInterval) and
@@ -497,12 +609,12 @@ struct ehci_iso_stream {
 	unsigned		bandwidth;
 
 	/* This is used to initialize iTD's hw_bufp fields */
-	__le32			buf0;
-	__le32			buf1;
-	__le32			buf2;
+	__ehci32		buf0;
+	__ehci32		buf1;
+	__ehci32		buf2;
 
 	/* this is used to initialize sITD's tt info */
-	__le32			address;
+	__ehci32		address;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -515,8 +627,8 @@ struct ehci_iso_stream {
  */
 struct ehci_itd {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;           /* see EHCI 3.3.1 */
-	__le32			hw_transaction [8]; /* see EHCI 3.3.2 */
+	__ehci32		hw_next;       /* see EHCI 3.3.1 */
+	__ehci32		hw_transaction [8]; /* see EHCI 3.3.2 */
 #define EHCI_ISOC_ACTIVE        (1<<31)        /* activate transfer this slot */
 #define EHCI_ISOC_BUF_ERR       (1<<30)        /* Data buffer error */
 #define EHCI_ISOC_BABBLE        (1<<29)        /* babble detected */
@@ -524,10 +636,14 @@ struct ehci_itd {
 #define	EHCI_ITD_LENGTH(tok)	(((tok)>>16) & 0x0fff)
 #define	EHCI_ITD_IOC		(1 << 15)	/* interrupt on complete */
 
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define ITD_ACTIVE	__constant_cpu_to_be32(EHCI_ISOC_ACTIVE)
+#else
 #define ITD_ACTIVE	__constant_cpu_to_le32(EHCI_ISOC_ACTIVE)
+#endif
 
-	__le32			hw_bufp [7];	/* see EHCI 3.3.3 */
-	__le32			hw_bufp_hi [7];	/* Appendix B */
+	__ehci32		hw_bufp [7];	/* see EHCI 3.3.3 */
+	__ehci32		hw_bufp_hi [7];	/* Appendix B */
 
 	/* the rest is HCD-private */
 	dma_addr_t		itd_dma;	/* for this itd */
@@ -554,11 +670,11 @@ struct ehci_itd {
  */
 struct ehci_sitd {
 	/* first part defined by EHCI spec */
-	__le32			hw_next;
+	__ehci32		hw_next;
 /* uses bit field macros above - see EHCI 0.95 Table 3-8 */
-	__le32			hw_fullspeed_ep;	/* EHCI table 3-9 */
-	__le32			hw_uframe;		/* EHCI table 3-10 */
-	__le32			hw_results;		/* EHCI table 3-11 */
+	__ehci32		hw_fullspeed_ep;	/* EHCI table 3-9 */
+	__ehci32		hw_uframe;		/* EHCI table 3-10 */
+	__ehci32		hw_results;		/* EHCI table 3-11 */
 #define	SITD_IOC	(1 << 31)	/* interrupt on completion */
 #define	SITD_PAGE	(1 << 30)	/* buffer 0/1 */
 #define	SITD_LENGTH(x)	(0x3ff & ((x)>>16))
@@ -570,11 +686,15 @@ struct ehci_sitd {
 #define	SITD_STS_MMF	(1 << 2)	/* incomplete split transaction */
 #define	SITD_STS_STS	(1 << 1)	/* split transaction state */
 
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN
+#define SITD_ACTIVE	__constant_cpu_to_be32(SITD_STS_ACTIVE)
+#else
 #define SITD_ACTIVE	__constant_cpu_to_le32(SITD_STS_ACTIVE)
+#endif
 
-	__le32			hw_buf [2];		/* EHCI table 3-12 */
-	__le32			hw_backpointer;		/* EHCI table 3-13 */
-	__le32			hw_buf_hi [2];		/* Appendix B */
+	__ehci32		hw_buf [2];		/* EHCI table 3-12 */
+	__ehci32		hw_backpointer;		/* EHCI table 3-13 */
+	__ehci32		hw_buf_hi [2];		/* Appendix B */
 
 	/* the rest is HCD-private */
 	dma_addr_t		sitd_dma;
@@ -599,8 +719,8 @@ struct ehci_sitd {
  * it hits a "restore" FSTN; then it returns to finish other uframe 0/1 work.
  */
 struct ehci_fstn {
-	__le32			hw_next;	/* any periodic q entry */
-	__le32			hw_prev;	/* qh or EHCI_LIST_END */
+	__ehci32		hw_next;	/* any periodic q entry */
+	__ehci32		hw_prev;	/* qh or EHCI_LIST_END */
 
 	/* the rest is HCD-private */
 	dma_addr_t		fstn_dma;
@@ -672,6 +792,12 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
 #define ehci_big_endian_mmio(e)		0
 #endif
 
+#if defined(CONFIG_USB_EHCI_BIG_ENDIAN) && \
+    defined(CONFIG_USB_EHCI_BIG_ENDIAN_MMIO)
+#define readl_be(addr)			__raw_readl((addr))
+#define writel_be(val, addr)		__raw_writel((val), (addr))
+#endif
+
 static inline unsigned int ehci_readl (const struct ehci_hcd *ehci,
 				       __u32 __iomem * regs)
 {
diff --git a/drivers/usb/host/ehci-pmcmsp.c b/drivers/usb/host/ehci-pmcmsp.c
new file mode 100644
index 0000000..18aa74d
--- /dev/null
+++ b/drivers/usb/host/ehci-pmcmsp.c
@@ -0,0 +1,434 @@
+/*
+ * PMC MSP EHCI (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 2006-2007 PMC-Sierra Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/platform_device.h>
+
+#ifdef CONFIG_PMCTWILED
+#include "msp_led_macros.h"
+#endif
+
+/* includes */
+#define USB_CTRL_MODE_HOST		0x3	   /* host mode */
+#define USB_CTRL_MODE_BIG_ENDIAN	0x4	   /* big endian */
+#define USB_CTRL_MODE_STREAM_DISABLE	0x10	   /* stream disable*/
+#define USB_CTRL_FIFO_THRESH		0x00300000 /* thresh hold */
+#define USB_EHCI_REG_USB_MODE		0x68	   /* reg offset usb mode */
+#define USB_EHCI_REG_USB_FIFO		0x24	   /* reg offset usb fifo */
+#define USB_EHCI_REG_USB_STATUS		0x44	   /* reg offset usb status*/
+#define USB_EHCI_REG_BIT_STAT_STS	(1<<29)	   /* serial/parallel xcvr */
+
+extern int usb_disabled(void);
+extern void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci);
+
+void usb_hcd_tdi_set_mode(struct ehci_hcd *ehci)
+{
+	u8 *base;
+	u8 *statreg;
+	u8 *fiforeg;
+	u32 val;
+
+	/* get register base */
+	base = (u8 *)ehci->regs + USB_EHCI_REG_USB_MODE;
+	statreg = (u8 *)ehci->regs + USB_EHCI_REG_USB_STATUS;
+	fiforeg = (u8 *)ehci->regs + USB_EHCI_REG_USB_FIFO;
+
+	/* set the controller to host mode and BIG ENDIAN */
+	ehci_writel(ehci, (USB_CTRL_MODE_HOST | USB_CTRL_MODE_BIG_ENDIAN |
+			USB_CTRL_MODE_STREAM_DISABLE), (u32 *)base);
+
+	/* clear STS to select parallel transceiver interface */
+	val = ehci_readl(ehci, (u32 *)statreg);
+	val = val & ~USB_EHCI_REG_BIT_STAT_STS;
+	ehci_writel(ehci, val, (u32 *)statreg);
+
+	/* write to set the proper fifo threshold */
+	ehci_writel(ehci, USB_CTRL_FIFO_THRESH, (u32 *)fiforeg);
+
+#ifdef CONFIG_PMCTWILED
+	/* set TWI GPIO USB_HOST_DEV pin to active high */
+	msp_led_pin_hi(MSP_PIN_USB_HOST_DEV);
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
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	u32		temp;
+	int		retval;
+
+#ifdef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
+	ehci->big_endian_mmio = 1;
+#endif
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(
+			ehci_readl(ehci, &ehci->caps->hc_capbase));
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	ehci->is_tdi_rh_tt = 1;
+	tdi_reset(ehci);
+
+	ehci_reset(ehci);
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
+	retval = ehci_msp_reinit(ehci);
+
+	return retval;
+}
+
+/*-------------------------------------------------------------------------*/
+
+#ifdef	CONFIG_PM
+/* suspend/resume, section 4.3 */
+
+/*
+ * These routines rely on the bus glue
+ * to handle powerdown and wakeup, and currently also on
+ * transceivers that don't need any software attention to set up
+ * the right sort of wakeup.
+ * Also they depend on separate root hub suspend/resume.
+ */
+
+static int ehci_msp_suspend(struct usb_hcd *hcd, pm_message_t message)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	unsigned long	flags;
+	int		rc = 0;
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(10);
+
+	/*
+	 * Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible, bail out if RH has been resumed. Use
+	 * the spinlock to properly synchronize with possible pending
+	 * RH suspend or resume activity.
+	 *
+	 * This is still racy as hcd->state is manipulated outside of
+	 * any locks =P But that will be a different fix.
+	 */
+	spin_lock_irqsave(&ehci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		rc = -EINVAL;
+		goto bail;
+	}
+	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
+	(void)ehci_readl(ehci, &ehci->regs->intr_enable);
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+ bail:
+	spin_unlock_irqrestore(&ehci->lock, flags);
+
+	/*
+	 * could save FLADJ in case of Vaux power loss
+	 * ... we'd only use it to handle clock skew
+	 */
+	return rc;
+}
+
+static int ehci_msp_resume(struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	unsigned		port;
+	struct usb_device	*root = hcd->self.root_hub;
+	int			retval = -EINVAL;
+
+	/* maybe restore FLADJ */
+
+	if (time_before(jiffies, ehci->next_statechange))
+		msleep(100);
+
+	/* Mark hardware accessible again as we are out of D3 state by now */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	/* If CF is clear, we lost PCI Vaux power and need to restart. */
+	if (ehci_readl(ehci, &ehci->regs->configured_flag) != FLAG_CF)
+		goto restart;
+
+	/*
+	 * If any port is suspended (or owned by the companion),
+	 * we know we can/must resume the HC (and mustn't reset it).
+	 * We just defer that to the root hub code.
+	 */
+	for (port = HCS_N_PORTS(ehci->hcs_params); port > 0; ) {
+		u32	status;
+		port--;
+		status = ehci_readl(ehci, &ehci->regs->port_status [port]);
+		if (!(status & PORT_POWER))
+			continue;
+		if (status & (PORT_SUSPEND | PORT_RESUME | PORT_OWNER)) {
+			usb_hcd_resume_root_hub(hcd);
+			return 0;
+		}
+	}
+
+restart:
+	ehci_dbg(ehci, "lost power, restarting\n");
+	for (port = HCS_N_PORTS(ehci->hcs_params); port > 0; ) {
+		port--;
+		if (!root->children [port])
+			continue;
+		usb_set_device_state(root->children[port],
+					USB_STATE_NOTATTACHED);
+	}
+
+	/*
+	 * Else reset, to cope with power loss or flush-to-storage
+	 * style "resume" having let BIOS kick in during reboot.
+	 */
+	(void) ehci_halt(ehci);
+	(void) ehci_reset(ehci);
+	(void) ehci_msp_reinit(ehci, pdev);
+
+	/* emptying the schedule aborts any urbs */
+	spin_lock_irq(&ehci->lock);
+	if (ehci->reclaim)
+		ehci->reclaim_ready = 1;
+	ehci_work(ehci, NULL);
+	spin_unlock_irq(&ehci->lock);
+
+	/* restart; khubd will disconnect devices */
+	retval = ehci_run(hcd);
+
+	/* here we "know" root ports should always stay powered */
+	ehci_port_power(ehci, 1);
+
+	return retval;
+}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
+static void msp_start_hc(struct platform_device *dev)
+{
+	printk(KERN_DEBUG __FILE__
+		": starting PMC MSP EHCI USB Controller\n");
+
+	/*
+	 * Now, carefully enable the USB clock, and take
+	 * the USB host controller out of reset.
+	 */
+
+	printk(KERN_DEBUG __FILE__
+		": Clock to USB host has been enabled \n");
+}
+
+static void msp_stop_hc(struct platform_device *dev)
+{
+	printk(KERN_DEBUG __FILE__
+		": stopping PMC MSP EHCI USB Controller\n");
+}
+
+
+/*-------------------------------------------------------------------------*/
+
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+
+/*
+ * usb_hcd_msp_probe - initialize PMC MSP-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ */
+int usb_hcd_msp_probe(const struct hc_driver *driver,
+			struct platform_device *dev)
+{
+	int retval;
+	struct usb_hcd *hcd;
+
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
+		pr_debug("resource[1] is not IORESOURCE_IRQ");
+		return -ENOMEM;
+	}
+
+	hcd = usb_create_hcd(driver, &dev->dev, "pmcmsp");
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
+	msp_start_hc(dev);
+
+	retval = usb_add_hcd(hcd, dev->resource[1].start, 0);
+	if (retval == 0)
+		return retval;
+
+	msp_stop_hc(dev);
+	iounmap(hcd->regs);
+
+ err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+ err1:
+	usb_put_hcd(hcd);
+
+	return retval;
+}
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/*
+ * usb_hcd_msp_remove - shutdown processing for PMC MSP-based HCDs
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_msp_probe(), first invoking
+ * the HCD's stop() method. It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
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
+/*-------------------------------------------------------------------------*/
+
+static const struct hc_driver ehci_msp_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"PMC MSP EHCI",
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
+	.reset =		ehci_msp_setup,
+	.start =		ehci_run,
+#ifdef	CONFIG_PM
+	.suspend =		ehci_msp_suspend,
+	.resume =		ehci_msp_resume,
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
+};
+
+/*-------------------------------------------------------------------------*/
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
+	return 0;
+}
+
+MODULE_ALIAS("pmcmsp-ehci");
+static struct platform_driver ehci_hcd_msp_driver = {
+	.probe		= ehci_hcd_msp_drv_probe,
+	.remove		= ehci_hcd_msp_drv_remove,
+	.driver		= {
+		.name	= "pmcmsp-ehci",
+	},
+};
