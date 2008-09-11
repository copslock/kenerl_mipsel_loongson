Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 18:59:51 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:56868 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20197085AbYIKR7o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 18:59:44 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by hq-ex-mb01.razamicroelectronics.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 10:59:31 -0700
Received: from localhost.localdomain (unknown [10.8.0.28])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id EDA99F729;
	Thu, 11 Sep 2008 12:46:23 -0500 (CDT)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-usb@vger.kernel.org, mano@roarinelk.homelinux.net
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH] Au1200 USB Device Controller and device-only OTG
Date:	Thu, 11 Sep 2008 12:59:27 -0500
Message-Id: <1221155967-25502-1-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 11 Sep 2008 17:59:31.0730 (UTC) FILETIME=[2458E720:01C91438]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

This patch adds support for the USB Device Controller on the Au1200 SOC as
well as basic device-only OTG (On-The-Go) support.  There are some defines and
hooks for future expansion to full OTG support.

This has been tested with the g_zero gadget as well as the g_file_storage
gadget on a DB1250 board.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/configs/db1200_defconfig |   21 +
 drivers/usb/core/Kconfig           |    2 -
 drivers/usb/gadget/Kconfig         |   49 +-
 drivers/usb/gadget/Makefile        |    5 +
 drivers/usb/gadget/au1200_otg.c    |  854 +++++++++++
 drivers/usb/gadget/au1200_otg.h    |  138 ++
 drivers/usb/gadget/au1200_udc.c    | 2862 ++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/au1200_udc.h    |  816 ++++++++++
 drivers/usb/gadget/au1200_uoc.h    | 1021 +++++++++++++
 drivers/usb/gadget/gadget_chips.h  |    6 +
 include/linux/usb/otg.h            |    7 +-
 11 files changed, 5770 insertions(+), 11 deletions(-)
 create mode 100644 drivers/usb/gadget/au1200_otg.c
 create mode 100644 drivers/usb/gadget/au1200_otg.h
 create mode 100644 drivers/usb/gadget/au1200_udc.c
 create mode 100644 drivers/usb/gadget/au1200_udc.h
 create mode 100644 drivers/usb/gadget/au1200_uoc.h

diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index ab17973..b69fec3 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -914,13 +914,34 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 CONFIG_USB_GADGET=m
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_ATMEL_USBA is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
+CONFIG_USB_GADGET_AU1200=y
+CONFIG_USB_AU1200=m
+# CONFIG_USB_GADGET_S3C2410 is not set
 # CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+CONFIG_USB_PORT_AU1200OTG=y
+CONFIG_USB_AU1200OTG=m
+CONFIG_USB_ZERO=m
+# CONFIG_USB_ETH is not set
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FILE_STORAGE=m
+# CONFIG_USB_FILE_STORAGE_TEST is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 # CONFIG_USB_GADGET_DUALSPEED is not set
 
 #
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index cc9f397..cc54c55 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -106,8 +106,6 @@ config USB_OTG
 	bool
 	depends on USB && EXPERIMENTAL
 	select USB_SUSPEND
-	default n
-
 
 config USB_OTG_WHITELIST
 	bool "Rely on OTG Targeted Peripherals List"
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index acc95b2..ceb8a17 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -315,16 +315,28 @@ config USB_OMAP
 	default USB_GADGET
 	select USB_GADGET_SELECTED
 
-config USB_OTG
-	boolean "OTG Support"
-	depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD
+config USB_GADGET_AU1200
+	boolean "AU1200 USB Device Controller"
+	depends on SOC_AU1200
+	select USB_GADGET_DUALSPEED
 	help
-	   The most notable feature of USB OTG is support for a
-	   "Dual-Role" device, which can act as either a device
-	   or a host.  The initial role choice can be changed
-	   later, when two dual-role devices talk to each other.
+	   The RMI Alchemy Au1200 and Au1250 SOCs include a full On-The-Go port
+	   with USB 1.1 and USB 2.0 support.  The device port supports 4
+	   bidirectional endpoints plus the default endpoint ep0.
+
+	   This driver provides the device mode for the On-The-Go port.  The
+	   port will not be active unless the au1200_otg driver is loaded or
+	   built statically.
+
+	   Say "y" to link the driver statically, or "m" to build a
+	   dynamically linked module called "au1200_udc" and force all
+	   gadget drivers to also be dynamically linked.
 
-	   Select this only if your OMAP board has a Mini-AB connector.
+config USB_AU1200
+	tristate
+	depends on USB_GADGET_AU1200
+	default USB_GADGET
+	select USB_GADGET_SELECTED
 
 config USB_GADGET_S3C2410
 	boolean "S3C2410 USB Device Controller"
@@ -407,6 +419,27 @@ config USB_GADGET_DUALSPEED
 	  Means that gadget drivers should include extra descriptors
 	  and code to handle dual-speed controllers.
 
+config USB_PORT_AU1200OTG
+	boolean "AU1200 USB portmux control (On-The-Go support)"
+	depends on USB_GADGET_AU1200 || USB_EHCI_HCD || USB_OHCI_HCD
+	default n
+	help
+	   The AU1200 and Au1200 USB device port can be used as either a host
+	   port or a device port.  This driver configures the port based on
+	   hardware or software set criteria.  It is required to be loaded for
+	   au1200_udc to be useful.
+
+	   NOTE: Currently, only device-port mode is supported.  Host-port and
+	   other On The Go modes will be supported in a future release.
+
+	   Say "y" to link this driver statically or "m" to build a dynamically
+	   linked module called "au1200_otg".
+
+config USB_AU1200OTG
+	tristate
+	depends on USB_PORT_AU1200OTG
+	default USB_AU1200
+
 #
 # USB Gadget Drivers
 #
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index fcb5cb9..d2af7cd 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_USB_PXA25X)	+= pxa25x_udc.o
 obj-$(CONFIG_USB_PXA27X)	+= pxa27x_udc.o
 obj-$(CONFIG_USB_GOKU)		+= goku_udc.o
 obj-$(CONFIG_USB_OMAP)		+= omap_udc.o
+obj-$(CONFIG_USB_AU1200)	+= au1200_udc.o
 obj-$(CONFIG_USB_LH7A40X)	+= lh7a40x_udc.o
 obj-$(CONFIG_USB_S3C2410)	+= s3c2410_udc.o
 obj-$(CONFIG_USB_AT91)		+= at91_udc.o
@@ -49,3 +50,7 @@ obj-$(CONFIG_USB_G_PRINTER)	+= g_printer.o
 obj-$(CONFIG_USB_MIDI_GADGET)	+= g_midi.o
 obj-$(CONFIG_USB_CDC_COMPOSITE) += g_cdc.o
 
+#
+# AU1200 USB OTG options
+#
+obj-$(CONFIG_USB_AU1200OTG)	+= au1200_otg.o
diff --git a/drivers/usb/gadget/au1200_otg.c b/drivers/usb/gadget/au1200_otg.c
new file mode 100644
index 0000000..a110aff
--- /dev/null
+++ b/drivers/usb/gadget/au1200_otg.c
@@ -0,0 +1,854 @@
+/*
+ * Au1200 On The Go port driver.
+ */
+
+/*
+ * Copyright (C) 2008 RMI Corporation (http://www.rmicorp.com)
+ * Author: Kevin Hickey (khickey@rmicorp.com)
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
+ * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*****************************************************************************
+ *  Includes
+ *****************************************************************************/
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
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
+
+#include <asm/byteorder.h>
+#include <linux/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+#include <linux/platform_device.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_gpio.h>
+
+#include <linux/usb.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+
+#define	DRIVER_DESC		"Au1200 USB OTG Controller"
+#define DRIVER_NAME_FOR_PRINT   OTG_DRIVER_NAME
+
+#include "au1200_otg.h"
+#include "au1200_uoc.h"
+
+
+/*****************************************************************************
+ *  Function Declarations
+ *****************************************************************************/
+
+static u32 otg_app_query(int);
+static int au1200otg_set_peripheral(struct otg_transceiver *,
+		struct usb_gadget *);
+
+
+/*****************************************************************************
+ *  Data
+ *****************************************************************************/
+
+static const char driver_name[] = OTG_DRIVER_NAME;
+static const char driver_desc[] = DRIVER_DESC;
+
+static struct otg *the_controller;
+static const char *transceiver_label = "au1200_otg";
+
+static u32 init_state;
+
+struct usb_otg_gadget_extension otg_gadget_extension = {
+	.request = NULL,
+	.query   = otg_app_query,
+	.notify  = NULL
+};
+
+static u32 state_mask;
+u32 otg_tmr_high_count;
+
+/*****************************************************************************
+ *  Function Definitions
+ *****************************************************************************/
+
+/**
+ * \brief
+ * fill OTG transceiver struct
+ *
+ * \param  transceiver  OTG transceiver
+ *
+ * \return              void
+ */
+static inline void otg_init_transceiver(struct otg_transceiver *transceiver)
+{
+	transceiver->dev            = NULL;
+	transceiver->label          = transceiver_label;
+	transceiver->default_a      = 0;
+	transceiver->state          = OTG_STATE_UNDEFINED;
+	transceiver->prv_state      = OTG_STATE_UNDEFINED;
+	transceiver->params         = 0;
+	transceiver->otg_priv       = (void *) &otg_gadget_extension;
+	transceiver->host           = NULL;
+	transceiver->gadget         = NULL;
+	transceiver->port_status    = 0;
+	transceiver->port_change    = 0;
+	transceiver->set_host       = NULL;
+	transceiver->set_peripheral = au1200otg_set_peripheral;
+	transceiver->set_power      = NULL;
+	transceiver->start_srp      = NULL;
+	transceiver->start_hnp      = NULL;
+}
+
+/**
+ * \brief
+ * OTG state change
+ *
+ * subset of OTG states to support the gadget only or
+ * ID pin configuration
+ *
+ * \param  otg          OTG controller info
+ * \param  event_code   event that requested a state change
+ * \param  pEvt_mask
+ *
+ * \return              events that were not handled here
+ */
+u32 otg_change_state(struct otg *otg, u32 _event, u32 *pEvt_mask)
+{
+	u32  event_code = _event;
+	u32  uoc_status = get_status(otg);
+
+	if (GOT_EVENT(OTG_GADGET_READY, event_code) &&
+			((otg->transceiver.state & OTG_STATE_MASK) !=
+			 OTG_STATE_UNDEFINED)) {
+
+		/* Switch from "NO_B_DEVICE" states to normal operation or   */
+		/*       deactivate operations in case gadget was unloaded   */
+
+		CHANGE_STATE(otg, OTG_STATE_UNDEFINED, pEvt_mask);
+	}
+	if ((OTG_INT_TMX & event_code) && otg_tmr_high_count) {
+
+		/* a long timer is running : decrement the high part         */
+
+		restart_timer(otg);
+		otg_tmr_high_count--;
+		RES_EVENT(OTG_INT_TMX, event_code);
+	}
+
+	do {
+		switch (otg->transceiver.state & OTG_STATE_MASK) {
+		/* NOT_ASSIGNED (yet): init state, 1st time after loading     */
+		/* ======================================================     */
+
+		case OTG_STATE_UNDEFINED:
+
+			CHECK_STATE(otg, OTG_STATE_UNDEFINED, pEvt_mask);
+
+			if (IS_FLAG_RES(otg, OTG_FLAGS_ACTIV)) {
+
+				/* seems to be the first time: let it run !   */
+
+				SET_FLAG(otg, OTG_FLAGS_ACTIV);
+			}
+
+			/*      muxer is still neutral                        */
+
+			RES_EVENT((OTG_INT_IDC | OTG_INT_TMX), event_code);
+
+			if (IS_FLAG_RES(otg, OTG_GADGET_READY)) {
+				if (IS_BIT_RES(OTG_STS_ID, uoc_status)) {
+
+					/* ID pin connected: A-device (host)  */
+
+					if (OTG_STATE_NO_B_DEVICE_A !=
+							otg->transceiver.state)
+						CHANGE_STATE(otg,
+							OTG_STATE_NO_B_DEVICE_A,
+							pEvt_mask);
+				} else if (IS_BIT_SET(OTG_STS_ID, uoc_status)) {
+
+					/* ID pin not connected:
+					 * disable(neutral)*/
+
+					if (OTG_STATE_NO_B_DEVICE_B !=
+							otg->transceiver.state)
+						CHANGE_STATE(otg,
+							OTG_STATE_NO_B_DEVICE_B,
+							pEvt_mask);
+				}
+			} else if ((OTG_STATE_NO_B_DEVICE_A ==
+						otg->transceiver.state) ||
+					(OTG_STATE_NO_B_DEVICE_B ==
+					 otg->transceiver.state)) {
+
+				/* Exit "not ready" state                     */
+				/* ----------------------                     */
+
+				RES_EVENT(OTG_GADGET_READY, event_code);
+				CHANGE_STATE(otg, OTG_STATE_UNDEFINED,
+						pEvt_mask);
+			}
+
+			/* ================================================== */
+
+			else {
+
+				/* ID pin is not connected: B-device
+				 * (peripheral)*/
+
+				CHANGE_STATE(otg, OTG_STATE_B_IDLE, pEvt_mask);
+			}
+			break;
+
+		case OTG_STATE_B_IDLE:
+			/* B_IDLE: init state for B-devices                  */
+			/*         monitor VBus, no connection, no activity  */
+
+			CHECK_STATE(otg, OTG_STATE_B_IDLE, pEvt_mask);
+
+			if (IS_BIT_SET(OTG_STS_SESSVLD, uoc_status)) {
+				/* Session valid => B_PERIPHERAL             */
+
+				RES_EVENT(OTG_INT_SVC, event_code);
+				CHANGE_STATE(otg, OTG_STATE_B_PERIPHERAL,
+						pEvt_mask);
+				if (otg_gadget_extension.notify) {
+					otg_gadget_extension.notify(
+							OTG_GADGET_EVT_SVALID);
+				}
+			}
+			break;
+
+		case OTG_STATE_B_PERIPHERAL:
+			/* B_PERIPHERAL: connected to A-host, responding     */
+			/*               VBus driven by A, remote activity   */
+
+			CHECK_STATE(otg, OTG_STATE_B_PERIPHERAL, pEvt_mask);
+
+			if (IS_BIT_RES(OTG_STS_SESSVLD, uoc_status)) {
+				/* ID pin changed | ~Session valid => B_IDLE */
+
+				RES_EVENT((OTG_INT_IDC | OTG_INT_SVC),
+						event_code);
+				CHANGE_STATE(otg, OTG_STATE_B_IDLE, pEvt_mask);
+				if (otg_gadget_extension.notify) {
+					otg_gadget_extension.notify(
+							OTG_GADGET_EVT_SVDROP);
+				}
+			}
+			break;
+
+		default:
+			/* something went wrong */
+			BUG();
+			break;
+	}
+	} while ((otg->transceiver.state ^ otg->transceiver.prv_state) &
+			(OTG_STATE_MASK));
+
+
+	DBG("OTG-state change done\n");
+
+	return event_code;
+}
+
+/**
+ * \brief
+ * OTG state change request
+ *
+ * \param  dev    OTG device info
+ * \param  params
+ *
+ * \return void
+ */
+static inline void otg_req_state_chg(struct otg *otg, u32 params)
+{
+	u32 temp, tmp2;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* disable global OTG interrupt, clear int status:                   */
+	temp = ~((u32) OTG_INT_GLOBAL) & readl(&otg->regs->inten);
+	writel(temp, &otg->regs->inten);
+	tmp2 = readl(&otg->regs->intr);
+	writel(tmp2, &otg->regs->intr);
+	temp &= tmp2;
+
+	/* update OTG state:                                                 */
+	otg_change_state(otg, (params | temp), &temp);
+
+	/* enable global OTG interrupt:                                      */
+	state_mask = ~temp & OTG_INT_ADDS;
+	writel((OTG_INT_ADDS | temp | OTG_INT_GLOBAL), &otg->regs->inten);
+	local_irq_restore(flags);
+}
+
+/**
+ * \brief
+ * OTG set transceiver:
+ *
+ * \param  pointer to transceiver struct
+ *
+ * \return void
+ */
+int otg_set_transceiver(struct otg_transceiver *transceiver)
+{
+	struct otg *otg = the_controller;
+
+	if (unlikely(transceiver != otg_to_transceiver(otg))) {
+		ERR("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	} else
+		return 0;
+}
+
+/**
+ * \brief
+ * OTG get transceiver: provide info to others
+ *
+ * \param  void
+ *
+ * \return pointer to transceiver struct
+ */
+struct otg_transceiver *otg_get_transceiver(void)
+{
+	return otg_to_transceiver(the_controller);
+}
+
+/**
+ * \brief
+ * Bind/unbind the OTG controller to/from usb gadget
+ *
+ * \param  transceiver  this transceiver
+ * \param  gadget       usb gadget info
+ *
+ * \return error code
+ */
+static int au1200otg_set_peripheral(struct otg_transceiver *transceiver,
+		struct usb_gadget *gadget)
+{
+	struct otg *otg = the_controller;
+	int flag = 0;
+
+	if (unlikely(transceiver != otg_to_transceiver(otg))) {
+		ERR("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	if (gadget) {
+		if (transceiver->gadget) {
+			ERR("USB gadget: OTG driver already registered\n");
+			return -EBUSY;
+		}
+		DBG("bind OTG driver to USB gadget\n");
+		transceiver->gadget = gadget;
+		SET_FLAG(otg, OTG_GADGET_READY | OTG_B_BUS_REQ);
+
+		/* Now checking consistence ...                              */
+		/* Depending on the driver loading sequence is possible      */
+		/* that the "Load state defaults" function was already       */
+		/*  called so the state could be inconsistent.               */
+		if (transceiver->host && !transceiver->host->is_b_host)
+			flag |= 1;
+		transceiver->gadget->is_a_peripheral = flag;
+
+		if (IS_FLAG_SET(otg, OTG_FLAGS_ACTIV))
+			otg_req_state_chg(otg, OTG_GADGET_READY);
+
+		if (IS_BIT_SET(OTG_STS_SESSVLD, readl(&otg->regs->sts)) &&
+				(otg->transceiver.state & OTG_STATE_MASK)
+				== OTG_STATE_B_PERIPHERAL) {
+			VDBG("calling gadget: connect\n");
+			otg_gadget_extension.notify(OTG_GADGET_EVT_SVALID);
+		}
+		return 0;
+	} else {
+		DBG("unbind OTG driver from USB gadget\n");
+		RES_FLAG(otg, OTG_GADGET_READY | OTG_B_BUS_REQ);
+		if (IS_FLAG_SET(otg, OTG_FLAGS_ACTIV))
+			otg_req_state_chg(otg, OTG_GADGET_READY);
+
+		transceiver->gadget = NULL;
+		return 0;
+	}
+}
+
+/**
+ * \brief
+ * OTG application query
+ *
+ * \param  index   select status info data
+ *
+ * \return status
+ */
+static u32 otg_app_query(int index)
+{
+	struct otg *otg = the_controller;
+	u32  temp = 0;
+
+	if (index == 0) {
+		temp = otg->transceiver.params |
+			readl(&otg->regs->sts);
+
+		if (((readl(&otg->regs->ctl) & OTG_CTL_MUX_MASK) ==
+					OTG_CTL_ENABLE_UDC) &&
+				((temp & OTG_STS_PSUS) ||
+				 (~temp & OTG_STS_VBUSVLD)))
+			temp |= OTG_FLAGS_UDC_SUSP;
+	} else if (index == 1)
+		temp = otg->transceiver.state;
+
+	return temp;
+}
+
+/**
+ * \brief
+ * OTG ISR calling the main state machine
+ *
+ * \param  irq    IRQ number
+ * \param  _dev
+ * \param  r
+ *
+ * \return IRQ_HANDLED(system code)
+ */
+static irqreturn_t otg_isr(int irq, void *dev)
+{
+	struct otg *otg = (struct otg *) dev;
+	u32         interrupts, int_mask, temp;
+
+	int_mask = readl(&otg->regs->inten);
+	if ((OTG_INT_GLOBAL & int_mask) &&
+			(int_mask &= ~((u32) OTG_INT_GLOBAL)) &&
+			(interrupts = int_mask &
+			 (temp = readl(&otg->regs->intr)))) {
+
+		writel(int_mask, &otg->regs->inten);
+		/* clear interrupt status */
+		writel(temp, &otg->regs->intr);
+		/* filter out additional WA interrupts, they're done         */
+		/*       don't want to see them in the state machine         */
+
+		if (interrupts & ~state_mask) {
+
+			/* events pending for the state machine              */
+
+			otg_change_state(otg, (interrupts & ~state_mask),
+					&int_mask);
+		}
+
+		/* enable interrupts and keep information about WA ints:     */
+
+		state_mask = OTG_INT_ADDS & ~int_mask;
+		writel((OTG_INT_ADDS | int_mask | OTG_INT_GLOBAL),
+				&otg->regs->inten);
+	}
+	return IRQ_HANDLED;
+}
+
+/**
+ * \brief
+ * OTG probe: init hardware, register the driver
+ *
+ * \param  otg   otg controller info
+ *
+ * \return  success
+ */
+static inline int __init otg_probe(struct otg *otg)
+{
+	int         retval;
+	u32         temp;
+	int         i;
+
+	/* initialize the OTG controller */
+
+	VDBG("OTG init ...\n");
+
+#ifdef VERBOSE
+	/* print regs */
+	print_regs(otg);
+#endif
+	/* Make sure we'll remember the initial state                        */
+	init_state = readl(&otg->regs->ctl);
+	VDBG("  OTG init state was %08x\n", init_state);
+
+	/* turn on the OTG controller                                        */
+	writel((init_state | OTG_CTL_PADEN), &otg->regs->ctl);
+
+	/* initialize flags                                                  */
+	otg->transceiver.params = 0;
+
+	/* make sure all interrupts are disabled                             */
+	writel(OTG_INT_DISALL, &otg->regs->inten);
+	writel(OTG_INT_ENALL, &otg->regs->intr);
+
+	/* Set multiplexer to neutral, get power control, drop VBus          */
+
+	if (((init_state & OTG_CTL_MUX_MASK) == OTG_CTL_ENABLE_UHC) &&
+			((((init_state & OTG_CTL_PPO) &&
+			  (init_state & OTG_CTL_PPWR))) ||
+			 ((~init_state & OTG_CTL_PPO) &&
+			  (readl(&otg->regs->sts) & OTG_STS_SESSVLD)))) {
+
+		/* VBus still powered try to discharge VBus and set timer    */
+
+		DBG("Setting init state, trying to discharge VBus ...\n");
+
+		for (i = 0; i < 4; i++) {
+			writel(TIMER_PERIOD, &otg->regs->tmr);
+			writel((OTG_CTL_PADEN | OTG_CTL_IDSNSEN |
+						OTG_CTL_PPO | OTG_CTL_DISCHRG |
+						OTG_CTL_TMR_UNCOND),
+						&otg->regs->ctl);
+			while (!(readl(&otg->regs->sts) & OTG_STS_TMH))
+				udelay(1);
+		}
+		writel((OTG_CTL_PADEN | OTG_CTL_IDSNSEN | OTG_CTL_PPO),
+				&otg->regs->ctl);
+		writel(OTG_INT_ENALL, &otg->regs->intr);
+#ifdef DEBUG
+		if (readl(&otg->regs->sts) & OTG_STS_SESSVLD)
+			DBG("  VBus still high, external host connected\n");
+		else
+			DBG("  VBus discharged\n");
+#endif
+	} else {
+		DBG("Setting init state\n");
+
+		writel((OTG_CTL_PADEN | OTG_CTL_IDSNSEN | OTG_CTL_PPO),
+				&otg->regs->ctl);
+	}
+
+	VDBG("OTG init done\n");
+
+	/* registering to the device driver */
+	if (usb_gadget_register_otg(otg_get_transceiver)) {
+		ERR("gadget driver registration failed\n");
+		retval = -ENODEV;
+		goto err1;
+	}
+
+	/* finally activate OTG functionality */
+	/* Enable timer interrupt, start timer, set state                    */
+
+	SET_OTG_TIMER(otg, IDSNS_WAIT);
+	CHANGE_STATE(otg, OTG_STATE_UNDEFINED, &temp);
+	CHECK_STATE(otg, OTG_STATE_UNDEFINED, &temp);
+
+	/* clear all interrupts before enable */
+	writel(readl(&otg->regs->intr), &otg->regs->intr);
+
+	state_mask = ~temp & OTG_INT_ADDS;
+	writel((OTG_INT_ADDS | temp | OTG_INT_GLOBAL), &otg->regs->inten);
+
+	DBG("OTG-HW initialized, now checking ID ...\n");
+
+	return 0;
+
+	usb_gadget_unregister_otg();
+err1:
+	return retval;
+}
+
+/**
+ * \brief
+ * OTG remove: deregister the driver, clean-up hardware
+ *
+ * \param  otg   otg controller info
+ *
+ * \return void
+ */
+static inline void __exit otg_remove(struct otg *otg)
+{
+	int muxer;
+
+	/* unregistering from the usb gadget */
+	usb_gadget_unregister_otg();
+
+	/* clean up the OTG controller */
+
+	/* Disable all interrupts                                            */
+	writel(OTG_INT_DISALL, &otg->regs->inten);
+	writel(OTG_INT_ENALL, &otg->regs->intr);
+
+	/* reset state, terminate all connections                            */
+	CHANGE_STATE(otg, OTG_STATE_UNDEFINED, &state_mask);
+	CHECK_STATE(otg, OTG_STATE_UNDEFINED, &state_mask);
+	otg->transceiver.params = 0;
+
+	muxer = init_state & (OTG_CTL_ENABLE_UHC | OTG_CTL_ENABLE_UDC);
+
+
+	/* Don't assign the port to the device controller                    */
+
+	if (!(muxer ^ OTG_CTL_ENABLE_UDC)) {
+
+		init_state &= ~((u32)(OTG_CTL_MUX_MASK | OTG_CTL_PUEN));
+		muxer = OTG_CTL_DISABLE_ALL;
+	}
+	VDBG("OTG writing back corrected init state: %08x\n", init_state);
+
+	/* Now, that's the moment to remember                                */
+	/* Set dev muxer and pull up bits, turn off the OTG controller       */
+
+	/* Turn off VBus                                                     */
+	writel(init_state, &otg->regs->ctl);
+
+	if (!(muxer ^ OTG_CTL_ENABLE_UHC))
+		INFO("disabling OTG-HW, port is assigned to host\n");
+	else if (!(muxer ^ OTG_CTL_ENABLE_UDC))
+		INFO("disabling OTG-HW, port is assigned to device\n");
+	else
+		INFO("disabling OTG-HW, port is not assigned\n");
+
+	VDBG("OTG exit: OTG-HW disabled\n");
+
+	if (!muxer)
+		INFO("OTG HW disabled, port is not assigned\n");
+}
+
+/**
+ * \brief
+ * OTG dev probe: enable, init controller hardware
+ *
+ * \param  dev   platform device info
+ *
+ * \return success
+ */
+static int __init otg_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct otg *otg;
+	u32         resource, len, irq;
+	void       *base;
+	int         retval;
+	char        buf[8] = {0, 0, 0, 0, 0, 0, 0, 0}, *bufp;
+
+	/* alloc, and start init */
+	otg = kmalloc(sizeof(struct otg), GFP_KERNEL);
+	if (!otg) {
+		ERR("couldn't allocate memory for OTG driver\n");
+		retval = -ENOMEM;
+		goto err1;
+	}
+	DBG("kmalloc: OTG driver: %p\n", otg);
+
+	/* hold global device pointer */
+	the_controller = otg;
+
+	memset(otg, 0, sizeof(struct otg));
+	spin_lock_init(&otg->lock);
+
+	if (pdev->resource[0].flags != IORESOURCE_MEM) {
+		ERR("resource is not IORESOURCE_MEM\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+	resource = pdev->resource[0].start;
+	len = pdev->resource[0].end + 1 - pdev->resource[0].start;
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		ERR("resource is not IORESOURCE_IRQ\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+	irq = pdev->resource[1].start;
+
+	otg->pdev = pdev;
+
+	au_writel((au_readl(USB_MSR_BASE + USB_MSR_MCFG) |
+				(1 << USBMSRMCFG_GMEMEN)),
+				(USB_MSR_BASE + USB_MSR_MCFG));
+	au_readl(USB_MSR_BASE + USB_MSR_MCFG);
+	au_sync();
+
+	otg->enabled = 1;
+
+	if (!request_mem_region(resource, len, driver_name)) {
+		ERR("controller already in use\n");
+		retval = -EBUSY;
+		goto err3;
+	}
+	otg->region = 1;
+
+	base = ioremap_nocache(resource, len);
+	if (!base) {
+		ERR("couldn't map memory\n");
+		retval = -EFAULT;
+		goto err4;
+	}
+	otg->regs = (struct otg_regs *) base;
+	bufp = buf;
+
+	otg->chiprev = (u16) read_c0_prid() & 0xff;
+
+	/* OTG transceiver info */
+	otg->transceiver.dev = dev;
+	otg_init_transceiver(otg_to_transceiver(otg));
+
+	/* make sure all interrupts are disabled */
+	writel(OTG_INT_DISALL, &otg->regs->inten);
+	writel(OTG_INT_ENALL, &otg->regs->intr);
+	readl(&otg->regs->inten);
+
+	/* irq setup after old hardware is cleaned up */
+	if (!irq) {
+		ERR("No IRQ. Check system setup!\n");
+		retval = -ENODEV;
+		goto err5;
+	}
+	snprintf(buf, sizeof buf, "%d", irq);
+	bufp = buf;
+	if (request_irq(irq, otg_isr, IRQF_SHARED,
+				driver_name, otg) != 0) {
+		ERR("request interrupt %s failed\n", bufp);
+		retval = -EBUSY;
+		goto err5;
+	}
+	otg->got_irq = 1;
+
+	/* done */
+	INFO("%s\n", driver_desc);
+	INFO("irq %s, mem %08x, chip rev %02x (Au1200 %s)\n",
+			bufp, resource, otg->chiprev,
+			(otg->chiprev ? "AC" : "AB"));
+
+	retval = otg_probe(otg);
+	if (retval == 0) {
+		dev_set_drvdata(dev, otg);
+		return 0;
+	}
+
+	otg->got_irq = 0;
+	free_irq(irq, otg);
+err5:
+
+	otg->regs = NULL;
+	iounmap(base);
+err4:
+	otg->region = 0;
+	release_mem_region(resource, len);
+err3:
+	otg->enabled = 0;
+	au_writel((au_readl(USB_MSR_BASE + USB_MSR_MCFG) &
+				~((u32)(1 << USBMSRMCFG_GMEMEN))),
+			(USB_MSR_BASE + USB_MSR_MCFG));
+	au_readl(USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync(); */
+	udelay(1000);
+err2:
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG("kfree: OTG driver: %p\n", otg);
+	kfree(otg);
+err1:
+	otg = NULL;
+
+	return retval;
+}
+
+/**
+ * \brief
+ * OTG dev remove: clean-up, disable controller hardware
+ *
+ * \param  dev   platform device info
+ *
+ * \return void
+ */
+static int __exit otg_drv_remove(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct otg *otg = dev_get_drvdata(dev);
+
+	otg_remove(otg);
+
+	otg->got_irq = 0;
+	free_irq(pdev->resource[1].start, otg);
+	iounmap(otg->regs);
+	otg->regs = NULL;
+	otg->region = 0;
+	release_mem_region(pdev->resource[0].start,
+			pdev->resource[0].end + 1
+			- pdev->resource[0].start);
+	otg->enabled = 0;
+
+	au_readl(USB_MSR_BASE + USB_MSR_MCFG);
+	au_sync();
+
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG("kfree: OTG driver: %p\n", otg);
+	kfree(otg);
+	otg = NULL;
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+
+
+/*****************************************************************************
+ *  More data
+ *****************************************************************************/
+
+/**
+ * \brief
+ * driver struct to be used for driver registration
+ *
+ */
+static struct device_driver otg_device_driver = {
+	.name =		"au1xxx-uoc",
+	.bus =		&platform_bus_type,
+	.probe =	otg_drv_probe,
+	.remove =	otg_drv_remove,
+	/* 	.suspend =	otg_drv_suspend, */
+	/* 	.resume =	otg_drv_resume, */
+};
+
+/* This comment closes the module definition from above. There can be multiple
+   definitions of this kind in a file. See the doxygen documentation for more
+   information. */
+/** \}*/
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Kevin Hickey");
+MODULE_LICENSE("GPL");
+
+static int __init init(void)
+{
+	return driver_register(&otg_device_driver);
+}
+static void __exit cleanup(void)
+{
+	driver_unregister(&otg_device_driver);
+}
+
+module_init(init);
+module_exit(cleanup);
diff --git a/drivers/usb/gadget/au1200_otg.h b/drivers/usb/gadget/au1200_otg.h
new file mode 100644
index 0000000..8c2e3a5
--- /dev/null
+++ b/drivers/usb/gadget/au1200_otg.h
@@ -0,0 +1,138 @@
+/*
+ * Declarations for the Au1200 On The Go port driver.
+ */
+
+/*
+ * Copyright (C) 2008 RMI Corporation (http://www.rmicorp.com)
+ * Author: Kevin Hickey (khickey@rmicorp.com)
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
+ * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef AU1200_OTG_H
+#define AU1200_OTG_H
+
+/**********************************
+ * OTG sub-state definitions
+ ***********************************/
+
+#define OTG_STATE_MASK                  0x0F
+
+#define OTG_STATE_NO_B_DEVICE_A         (0x60 | OTG_STATE_UNDEFINED)
+#define OTG_STATE_NO_B_DEVICE_B         (0x40 | OTG_STATE_UNDEFINED)
+
+#define OTG_STATE_B_HOST_WT             (0x10 | OTG_STATE_B_HOST)
+#define OTG_STATE_B_PERIPHERAL_WT       (0x10 | OTG_STATE_B_PERIPHERAL)
+#define OTG_STATE_B_PERIPHERAL_DC       (0x20 | OTG_STATE_B_PERIPHERAL)
+#define OTG_STATE_B_SRP_WAIT_SE0        (0x10 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_D_PULSE         (0x20 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_V_PULSE         (0x30 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_V_DCHRG         (0x40 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_WAIT_VBUS       (0x50 | OTG_STATE_B_SRP_INIT)
+
+#define OTG_STATE_A_IDLE_WAIT_DP        (0x10 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_IDLE_WAIT_VP        (0x20 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_IDLE_WAIT_MP        (0x30 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_IDLE_WAIT_DV        (0x40 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_WAIT_BCON_VB        (0x10 | OTG_STATE_A_WAIT_BCON)
+#define OTG_STATE_A_WAIT_VFALL_DN       (0x10 | OTG_STATE_A_WAIT_VFALL)
+
+
+/**********************************
+ *  typical timer values
+ **********************************/
+
+#define OTG_TMR_WAIT_VFALL     10   /* (  ) A waits for VBus                 */
+#define OTG_TMR_A_WAIT_VRISE   100  /* (  ) A waits for VBus                 */
+#define OTG_TMR_A_WAIT_BCON    200  /* (  ) A waits for B-connect (1.. s)    */
+#define OTG_TMR_A_IDLE_BDIS    250  /* (ms) A waits for B-disc (200.. ms)    */
+#define OTG_TMR_B_WAIT_ADISCON 600  /* (us) B waits for A to disconnect <1ms */
+#define OTG_TMR_B_ACON_BRST    200  /* (us) B waits before starting reset    */
+#define OTG_TMR_B_ASE0_BRST    5    /* (ms) B waits for A-conn (3.125.. ms)  */
+#define OTG_TMR_B_AIDL_BDIS    50   /* (ms) B waits before dc (5..150ms)     */
+#define OTG_TMR_SRP_WAIT_SE0   2    /* (  ) B SRP idle wait                  */
+#define OTG_TMR_SRP_WAIT_DP    7    /* (ms) B SRP D_PULSE (5..10ms)          */
+#define OTG_TMR_SRP_WAIT_VP    80   /* (ms) B SRP V_PULSE (5..100ms)         */
+#define OTG_TMR_SRP_DCHRG_V    30   /* (  ) B SRP VBus discharge             */
+#define OTG_TMR_SRP_WAIT_VRS   5800 /* (ms) B SRP waits for VBus (5..6s)     */
+#define OTG_TMR_ASRP_WAIT_MP   4    /* (  ) A SRP min. pulse                 */
+#define OTG_TMR_ASRP_WAIT_DP   10   /* (ms) A SRP D_PULSE TO                 */
+#define OTG_TMR_ASRP_WAIT_VP   200  /* (ms) A SRP V_PULSE TO                 */
+#define OTG_TMR_ASRP_WAIT_DV   200  /* (  ) A SRP waits for V_PULSE          */
+#define OTG_TMR_A_BCON_VB      50   /* (  ) A waits for VBus after connect   */
+
+#define OTG_TMR_IDSNS_WAIT     10   /* (ms) ID sense wait                    */
+#define TIMER_PERIOD           1000 /* 10 ms, if longer than 10ms            */
+
+/**********************************
+ * OTG state parameters
+ **********************************/
+
+#define OTG_HOST_READY         (1<<20)   /* indicates a USB host driver is   */
+/* running                          */
+#define OTG_GADGET_READY       (1<<21)   /* indicates a USB gadget driver is */
+/* running                          */
+#define OTG_A_BUS_REQ          (1<<22)   /* used by appl-SW to request a     */
+/* VBus rise, auto-reset by driver  */
+#define OTG_A_BUS_DROP         (1<<23)   /* used by appl-SW to request a     */
+/* VBus drop, auto-reset by driver  */
+#define OTG_A_CLR_ERR          (1<<24)   /* used by appl-SW to request VBerr */
+/* clean-up, auto-reset by driver   */
+#define OTG_AB_HNP_REQ         (1<<25)   /* used by appl-SW to initiate      */
+/* HNP, auto-reset by driver        */
+#define OTG_B_BUS_REQ          (1<<26)   /* used by appl-SW to request       */
+/* B-device functionality, ...      */
+#define OTG_B_BUS_DIS          (1<<27)   /* used by appl-SW to request       */
+/* disable B-device functionality   */
+#define OTG_B_aSSN_REQ         (1<<28)   /* used by appl-SW to initiate SRP, */
+/* auto-reset by the driver         */
+#define OTG_B_SRP_ERROR        (1<<29)   /* indicates invalid HW conditions  */
+/* during SRP, reset by writing "1" */
+#define OTG_A_VBUS_FAILED      (1<<30)   /* indicates a VBus error, reset by */
+/* writing "1", when setting        */
+/* CLR_ERR or when leaving A-states */
+#define OTG_UDC_RWK_REQ        (1<<31)   /* call UDC function to force a     */
+/* remote wake-up                   */
+
+#define SW_REQUEST_MASK        (OTG_A_BUS_REQ | OTG_A_BUS_DROP | \
+		OTG_A_CLR_ERR | OTG_B_aSSN_REQ | \
+		OTG_B_BUS_REQ | OTG_B_BUS_DIS | \
+		OTG_UDC_RWK_REQ)
+
+/*********************************************************************/
+
+/*
+ * gadget events for notify function
+ */
+#define OTG_GADGET_EVT_SVDROP  (1<<0)    /* Session valid drop       */
+#define OTG_GADGET_EVT_SVALID  (1<<1)    /* Session valid            */
+#define OTG_GADGET_REQ_WAKE    (1<<2)    /* Request remote wake-up   */
+#define OTG_FLAGS_UDC_SUSP     (1<<17)   /* gadget phy suspended     */
+
+/*****************************************************************************
+ *  Data
+ *****************************************************************************/
+struct usb_otg_gadget_extension {
+	int (*request) (u32);	/* function call for state change requests */
+	u32 (*query) (int);	/* function call to query state            */
+	void (*notify) (u32);   /* filled in by gadget for notification    */
+};
+
+#endif /* AU1200_OTG_H */
diff --git a/drivers/usb/gadget/au1200_udc.c b/drivers/usb/gadget/au1200_udc.c
new file mode 100644
index 0000000..5289181
--- /dev/null
+++ b/drivers/usb/gadget/au1200_udc.c
@@ -0,0 +1,2862 @@
+/*
+ * RMI Au1200 UDC high/full speed USB device controller.
+ */
+
+/*
+ * Copyright (C) 2008 RMI Corporation (http://www.rmicorp.com)
+ * Author: Kevin Hickey (khickey@rmicorp.com)
+ *
+ * Adapted from the AMD5536 UDC module.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
+ * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*****************************************************************************
+ * Defines
+ *****************************************************************************/
+
+/* debug control */
+/* #define UDC_DEBUG */
+/* #define UDC_VERBOSE */
+/* #define UDC_REGISTER_DUMP */
+
+/* Driver strings */
+#define UDC_MOD_DESCRIPTION         "RMI Au1200 UDC - USB Device Controller"
+
+/*****************************************************************************
+ *  Includes
+ *****************************************************************************/
+/* system */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
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
+#include <linux/ioctl.h>
+#include <linux/fs.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+
+#include <asm/byteorder.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+/* MIPS config */
+#include <asm/mach-au1x00/au1xxx.h>
+
+/* gadget stack */
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+
+/* udc specific */
+#include "au1200_udc.h"
+
+/*****************************************************************************
+ *  Static Function Declarations
+ *****************************************************************************/
+static void udc_tasklet_disconnect(unsigned long);
+static void empty_req_queue(struct udc_ep *);
+static int udc_probe(struct udc *dev);
+static void udc_basic_init(struct udc *dev);
+static void udc_setup_endpoints(struct udc *dev);
+static void udc_soft_reset(struct udc *dev);
+static void udc_free_request(struct usb_ep *usbep, struct usb_request *usbreq);
+static struct udc_data_dma *udc_get_last_dma_desc(struct udc_request *req);
+static int udc_free_dma_chain(struct udc *dev, struct udc_request *req);
+static inline int startup_registers(struct udc *dev);
+static int udc_remote_wakeup(struct udc *dev);
+static int udc_suspend(struct udc *dev);
+static int udc_resume(struct udc *dev);
+static void udc_clear_NAK(struct udc_ep *ep);
+
+static int execute_bulk_request_with_dma(struct usb_ep *usbep,
+					 struct usb_request *usbreq, gfp_t gfp);
+
+static void udc_tasklet_execute_request(unsigned long);
+
+/*****************************************************************************
+ *  Data
+ *****************************************************************************/
+/* description */
+static const char mod_desc[] = UDC_MOD_DESCRIPTION;
+static const char name[] = DRIVER_NAME_FOR_PRINT;
+
+/* structure to hold endpoint function pointers */
+static struct usb_ep_ops udc_ep_ops;
+
+/* received setup data */
+static union udc_setup_data setup_data;
+
+/* pointer to device object */
+static struct udc       *udc;
+
+/* irq spin lock for soft reset */
+spinlock_t udc_irq_spinlock;
+/* stall spin lock */
+spinlock_t udc_stall_spinlock;
+
+/* this is used for dma chaining */
+static int udc_gfp_flags;
+
+/* count soft resets after suspend to avoid loop */
+static int soft_reset_occured;
+static int soft_reset_after_usbreset_occured;
+
+#ifdef UDC_USE_TIMER
+/* timer */
+static struct timer_list udc_timer;
+static int stop_timer;
+int set_rde = -1;
+DECLARE_COMPLETION(on_exit);
+static struct timer_list udc_pollstall_timer;
+static int stop_pollstall_timer;
+DECLARE_COMPLETION(on_pollstall_exit);
+#endif
+
+/* tasklet for usb disconnect */
+DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect,
+		(unsigned long)&udc);
+
+/* otg registering count */
+static u32 otg_reg_count;
+
+/* gadget registering count */
+static u32 gadget_bind_count;
+
+/* endpoint names used for print */
+static const char ep0_string[] = "ep0in";
+static const char *ep_string[] = {
+	ep0_string,
+	"ep1in-int", "ep2in-bulk", "ep3in-bulk", "ep4in-bulk", "ep5in-bulk",
+	"ep6in-bulk", "ep7in-bulk", "ep8in-bulk", "ep9in-bulk", "ep10in-bulk",
+	"ep11in-bulk", "ep12in-bulk", "ep13in-bulk", "ep14in-bulk",
+	"ep15in-bulk", "ep0out", "ep1out-bulk", "ep2out-bulk", "ep3out-bulk",
+	"ep4out-bulk", "ep5out-bulk", "ep6out-bulk", "ep7out-bulk",
+	"ep8out-bulk", "ep9out-bulk", "ep10out-bulk", "ep11out-bulk",
+	"ep12out-bulk", "ep13out-bulk", "ep14out-bulk", "ep15out-bulk"
+};
+
+
+#ifdef UDC_DEBUG
+/* data for debuging only */
+static unsigned long no_pref_req;
+static unsigned long no_req;
+static u32 same_cfg;
+static u32 num_enums;
+#endif
+
+/****** following flags can be set by module parameters */
+/* DMA usage flag */
+static int use_dma = 1;
+/* packet per buffer dma */
+static int use_dma_ppb = 1;
+/* with per descr. update */
+static int use_dma_ppb_du;
+/* buffer fill mode */
+static int use_dma_bufferfill_mode;
+/* full speed only mode */
+static int use_fullspeed;
+/* tx buffer size for high speed */
+static unsigned long hs_tx_buf = UDC_EPIN_BUFF_SIZE;
+
+/* module parameters */
+module_param(use_dma, bool, S_IRUGO);
+MODULE_PARM_DESC(use_dma, "true for DMA");
+module_param(use_dma_ppb, bool, S_IRUGO);
+MODULE_PARM_DESC(use_dma_ppb, "true for DMA in packet per buffer mode");
+module_param(use_dma_ppb_du, bool, S_IRUGO);
+MODULE_PARM_DESC(use_dma_ppb_du,
+	"true for DMA in packet per buffer mode with descriptor update");
+module_param(use_fullspeed, bool, S_IRUGO);
+MODULE_PARM_DESC(use_fullspeed, "true for fullspeed only");
+module_param(hs_tx_buf, long, S_IRUGO);
+MODULE_PARM_DESC(hs_tx_buf,
+		 "high speed tx buffer size for data endpoints in dwords");
+
+MODULE_DESCRIPTION(UDC_MOD_DESCRIPTION);
+MODULE_AUTHOR("Kevin Hickey");
+MODULE_LICENSE("GPL");
+
+/*****************************************************************************
+ *  Function Definitions
+ *****************************************************************************/
+/* printing registers --------------------------------------------------------*/
+/**
+ * Prints UDC device registers and endpoint irq registers
+ *
+ * \param dev pointer to device struct
+ */
+static void print_regs(struct udc *dev)
+{
+	DBG("------- Device registers -------\n");
+	DBG("dev config     = %08lx\n", (unsigned long) dev->regs->cfg);
+	DBG("dev control    = %08lx\n", (unsigned long) dev->regs->ctl);
+	DBG("dev status     = %08lx\n", (unsigned long) dev->regs->sts);
+	DBG("\n");
+	DBG("dev int's      = %08lx\n", (unsigned long) dev->regs->irqsts);
+	DBG("dev intmask    = %08lx\n", (unsigned long) dev->regs->irqmsk);
+	DBG("\n");
+	DBG("dev ep int's   = %08lx\n", (unsigned long) dev->regs->ep_irqsts);
+	DBG("dev ep intmask = %08lx\n", (unsigned long) dev->regs->ep_irqmsk);
+	DBG("\n");
+	DBG("USE DMA        = %d\n", use_dma);
+	if (use_dma) {
+		DBG("DMA mode       = ");
+		if (use_dma_ppb && !use_dma_ppb_du)
+			DBG("PPBNDU (packet per buffer w/o desc. update)\n");
+		else if (use_dma_ppb_du && use_dma_ppb_du)
+			DBG("PPBDU (packet per buffer with desc. update)\n");
+		if (use_dma_bufferfill_mode)
+			DBG("BF (buffer fill mode)\n");
+	}
+
+	if (!use_dma)
+		INFO("FIFO mode\n");
+#ifdef UDC_USE_TIMER
+	INFO("RDE timer is used\n");
+#endif
+	DBG("-------------------------------------------------------\n");
+}
+
+#ifdef UDC_DEBUG
+/**
+ * Prints misc information, to be removed
+ *
+ * \param dev           pointer to device struct
+ */
+static void print_misc(struct udc *dev)
+{
+	print_regs(dev);
+
+	if (use_dma)
+		INFO("no_req=%ld no_pref_req=%ld\n", no_req, no_pref_req);
+}
+#endif
+
+/**
+ * Masks unused interrupts
+ *
+ * \param dev           pointer to device struct
+ * \return 0 if success
+ */
+static int udc_mask_unused_interrupts(struct udc *dev)
+{
+	u32 tmp;
+
+	/* mask all dev interrupts */
+	tmp =   UDC_BIT(UDC_DEVINT_ENUM) |
+		UDC_BIT(UDC_DEVINT_US) |
+		UDC_BIT(UDC_DEVINT_UR) |
+		UDC_BIT(UDC_DEVINT_ES) |
+		UDC_BIT(UDC_DEVINT_SI) |
+		UDC_BIT(UDC_DEVINT_SOF)|
+		UDC_BIT(UDC_DEVINT_SC);
+	iowrite32(tmp, &dev->regs->irqmsk);
+
+	/* mask all ep interrupts */
+	iowrite32(UDC_EPINT_MSK_DISABLE_ALL, &dev->regs->ep_irqmsk);
+
+	return 0;
+}
+
+/**
+ * Enables endpoint 0 interrupts
+ *
+ * \param dev           pointer to device struct
+ * \return 0 if success
+ */
+static int udc_enable_ep0_interrupts(struct udc *dev)
+{
+	u32 tmp;
+
+	tmp = ioread32(&dev->regs->ep_irqmsk);
+	tmp &= ~(UDC_BIT(UDC_EPINT_IN_EP0) | UDC_BIT(UDC_EPINT_OUT_EP0));
+
+	iowrite32(tmp, &dev->regs->ep_irqmsk);
+
+	return 0;
+}
+
+/**
+ * Calculates fifo start of endpoint based on preceeding endpoints
+ *
+ * \param ep           pointer to ep struct
+ * \return 0 if success
+ */
+static u32 *udc_calc_txfifo_addr(const struct udc *dev, unsigned ep_num)
+{
+	u32 tmp;
+	int i;
+	u32 *retval = dev->txfifo;
+
+	/* traverse ep's */
+	for (i = 0; i < ep_num; ++i) {
+		if (dev->ep[i].regs) {
+			/* read fifo size */
+			tmp = ioread32(&dev->ep[i].regs->bufin_framenum);
+			tmp = UDC_GETBITS(tmp, UDC_EPIN_BUFF_SIZE);
+			retval += tmp;
+		}
+	}
+	return retval;
+}
+
+/**
+ * Enables endpoint, is called by gadget driver
+ *
+ * \param usbep         pointer to ep struct
+ * \param desc          pointer to endpoint descriptor
+ * \return 0 if success
+ */
+static int udc_ep_enable(struct usb_ep *usbep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	struct udc_ep           *ep;
+	struct udc              *dev;
+	u32                     tmp;
+	unsigned long           iflags;
+	u8 udc_csr_epix;
+
+	VDBG("udc_enable()\n");
+
+	ep = container_of(usbep, struct udc_ep, ep);
+	if (!usbep
+			|| usbep->name == ep0_string
+			|| !desc
+			|| desc->bDescriptorType != USB_DT_ENDPOINT) {
+		ERR("udc_enable: !usbep=%d !desc=%d ep->desc!=NULL=%d \
+				usbep->name==ep0_string=%d \
+				desc->bDescriptorType!=USB_DT_ENDPOINT=%d\n",
+				!usbep, !desc, ep->desc != NULL,
+				usbep->name == ep0_string,
+				desc->bDescriptorType != USB_DT_ENDPOINT);
+		return -EINVAL;
+	}
+
+	dev = ep->dev;
+
+	/* exit on suspend */
+	if (dev->sys_suspended)
+		return -ESHUTDOWN;
+
+	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+
+	spin_lock_irqsave(&dev->lock, iflags);
+	ep->desc = desc;
+
+	ep->halted = 0;
+
+	/* set traffic type */
+	tmp = ioread32(&ep->regs->ctl);
+	tmp = UDC_ADDBITS(tmp, desc->bmAttributes, UDC_EPCTL_ET);
+	iowrite32(tmp, &ep->regs->ctl);
+
+	/* set max packet size */
+	tmp = ioread32(&ep->regs->bufout_maxpkt);
+	tmp = UDC_ADDBITS(tmp, desc->wMaxPacketSize, UDC_EP_MAX_PKT_SIZE);
+	ep->ep.maxpacket = desc->wMaxPacketSize;
+	iowrite32(tmp, &ep->regs->bufout_maxpkt);
+
+	/* IN ep */
+	if (ep->in) {
+		/* ep ix in UDC CSR register space */
+		udc_csr_epix = ep->num;
+
+		/* set buffer size (tx fifo entries) */
+		tmp = ioread32(&ep->regs->bufin_framenum);
+		/* double buffering: fifo size = 2 x max packet size */
+		tmp = UDC_ADDBITS(
+				tmp,
+				desc->wMaxPacketSize * UDC_EPIN_BUFF_SIZE_MULT /
+				UDC_DWORD_BYTES,
+				UDC_EPIN_BUFF_SIZE);
+		iowrite32(tmp, &ep->regs->bufin_framenum);
+
+		/* calc. tx fifo base addr */
+		ep->txfifo = udc_calc_txfifo_addr(dev, ep->num);
+
+		/* flush fifo */
+		tmp = ioread32(&ep->regs->ctl);
+		tmp |= UDC_BIT(UDC_EPCTL_F);
+		iowrite32(tmp, &ep->regs->ctl);
+
+	} /* OUT ep */
+	else {
+		/* ep ix in UDC CSR register space */
+		udc_csr_epix = ep->num - UDC_CSR_EP_OUT_IX_OFS;
+
+		if (ep->num != UDC_EP0OUT_IX)
+			dev->data_ep_enabled = 1;
+	}
+
+	/***** UDC CSR reg ****************************/
+	/* set ep values  */
+	tmp = ioread32(&dev->csr->ne[udc_csr_epix]);
+	/* max packet */
+	tmp = UDC_ADDBITS(tmp, desc->wMaxPacketSize, UDC_CSR_NE_MAX_PKT);
+	/* ep number */
+	tmp = UDC_ADDBITS(tmp, desc->bEndpointAddress, UDC_CSR_NE_NUM);
+	/* ep direction */
+	tmp = UDC_ADDBITS(tmp, ep->in, UDC_CSR_NE_DIR);
+	/* ep type */
+	tmp = UDC_ADDBITS(tmp, desc->bmAttributes, UDC_CSR_NE_TYPE);
+	/* ep config */
+	tmp = UDC_ADDBITS(tmp, dev->cur_config, UDC_CSR_NE_CFG);
+	/* ep interface */
+	tmp = UDC_ADDBITS(tmp, dev->cur_intf, UDC_CSR_NE_INTF);
+	/* ep alt */
+	tmp = UDC_ADDBITS(tmp, dev->cur_alt, UDC_CSR_NE_ALT);
+	/* write reg */
+	iowrite32(tmp, &dev->csr->ne[udc_csr_epix]);
+
+	/* enable ep irq */
+	tmp = ioread32(&dev->regs->ep_irqmsk);
+	tmp &= UDC_UNMASK_BIT(ep->num);
+	iowrite32(tmp, &dev->regs->ep_irqmsk);
+
+	/* clear NAK by writing CNAK */
+	/* avoid BNA for OUT DMA,  dont clear NAK until DMA desc. written */
+	if (ep->in)
+		udc_clear_NAK(ep);
+
+	DBG("%s enabled\n", usbep->name);
+
+	spin_unlock_irqrestore(&dev->lock, iflags);
+	return 0;
+}
+
+/**
+ * Enables device interrupts for SET_INTF and SET_CONFIG
+ *
+ * \param dev           pointer to device struct
+ * \return 0 if success
+ */
+static int udc_enable_dev_setup_interrupts(struct udc *dev)
+{
+	u32 tmp;
+
+	/* read irq mask */
+	tmp = ioread32(&dev->regs->irqmsk);
+
+	/* enable SET_INTERFACE, SET_CONFIG and other needed irq's */
+	tmp &= UDC_UNMASK_BIT(UDC_DEVINT_SI)
+		& UDC_UNMASK_BIT(UDC_DEVINT_SC)
+		& UDC_UNMASK_BIT(UDC_DEVINT_UR)
+		& UDC_UNMASK_BIT(UDC_DEVINT_ENUM);
+	iowrite32(tmp, &dev->regs->irqmsk);
+
+	return 0;
+}
+
+/**
+ * Resets endpoint
+ *
+ * \param regs          pointer to device register struct
+ * \param ep            pointer to endpoint
+ */
+static void ep_init(struct udc_regs *regs, struct udc_ep *ep)
+{
+	u32             tmp;
+
+	VDBG("ep-%d reset\n", ep->num);
+	ep->desc = 0;
+	ep->ep.ops = &udc_ep_ops;
+	INIT_LIST_HEAD(&ep->queue);
+
+	ep->ep.maxpacket = (u16) ~0;
+	if (!(ep->dev->sys_suspended)) {
+		/* set NAK  */
+		tmp = ioread32(&ep->regs->ctl);
+		tmp |= UDC_BIT(UDC_EPCTL_SNAK);
+		iowrite32(tmp, &ep->regs->ctl);
+		ep->naking = 1;
+
+		/* disable interrupt */
+		tmp = ioread32(&regs->ep_irqmsk);
+		tmp |= UDC_BIT(ep->num);
+		iowrite32(tmp, &regs->ep_irqmsk);
+
+		if (ep->in) {
+			/* unset P and IN bit of potential former DMA */
+			tmp = ioread32(&ep->regs->ctl);
+			tmp &= UDC_UNMASK_BIT(UDC_EPCTL_P);
+			iowrite32(tmp, &ep->regs->ctl);
+
+			tmp = ioread32(&ep->regs->sts);
+			tmp |= UDC_BIT(UDC_EPSTS_IN);
+			iowrite32(tmp, &ep->regs->sts);
+
+			/* flush the fifo */
+			tmp = ioread32(&ep->regs->ctl);
+			tmp |= UDC_BIT(UDC_EPCTL_F);
+			iowrite32(tmp, &ep->regs->ctl);
+
+		}
+		/* reset desc pointer */
+		iowrite32(0, &ep->regs->desptr);
+	}
+
+
+}
+
+/**
+ * Disables endpoint, is called by gadget driver
+ *
+ * \param usbep            pointer to ep struct
+ * \return 0 if success
+ */
+static int udc_disable(struct usb_ep *usbep)
+{
+	struct udc_ep   *ep;
+	struct udc	*dev;
+	unsigned long	iflags;
+
+	if (!usbep)
+		return -EINVAL;
+
+	ep = container_of(usbep, struct udc_ep, ep);
+	dev = ep->dev;
+
+	if (usbep->name == ep0_string || !ep->desc)
+		return -EINVAL;
+
+	DBG("Disable %s\n", usbep->name);
+
+	spin_lock_irqsave(&dev->lock, iflags);
+	empty_req_queue(ep);
+	ep_init(dev->regs, ep);
+	spin_unlock_irqrestore(&dev->lock, iflags);
+
+	return 0;
+}
+
+/**
+ * Allocates request packet, called by gadget driver
+ */
+static struct usb_request *
+udc_alloc_request(struct usb_ep *usbep, gfp_t gfp)
+{
+	struct udc_request      *req;
+	struct udc_data_dma     *dma_desc;
+	struct udc_ep   	*ep;
+	struct udc		*dev;
+
+	static int		serial;
+
+	VDBG("udc_alloc_req()\n");
+	if (!usbep)
+		return 0;
+
+	ep = container_of(usbep, struct udc_ep, ep);
+	dev = ep->dev;
+	udc_gfp_flags = gfp;
+
+	req = kmalloc(sizeof(struct udc_request), gfp);
+	if (!req)
+		return 0;
+
+	memset(req, 0, sizeof *req);
+	req->req.dma = DMA_DONT_USE;
+	INIT_LIST_HEAD(&req->queue);
+	req->ready_for_p_bit = false;
+
+	req->serial_number = serial++;
+
+	/* KH TODO: Extract to function to be used by this
+	 * and prepare_dma_chain. */
+	gfp = GFP_ATOMIC | GFP_DMA;
+	/* ep0 in requests are allocated from data pool here */
+	dma_desc = dma_pool_alloc(dev->data_requests, gfp,
+			&req->td_phys);
+	if (!dma_desc) {
+		kfree(req);
+		return 0;
+	}
+
+	VDBG("udc_alloc_req: req = %lx dma_desc = %lx, \
+			req->td_phys = %lx\n",
+			(unsigned long)req, (unsigned long) dma_desc,
+			(unsigned long)req->td_phys);
+	/* prevent from using desc. - set HOST BUSY */
+	dma_desc->status = UDC_ADDBITS(dma_desc->status,
+			UDC_DMA_STP_STS_BS_HOST_BUSY,
+			UDC_DMA_STP_STS_BS);
+	dma_desc->bufptr = __constant_cpu_to_le32(DMA_DONT_USE);
+	dma_desc->next = req->td_phys;
+	req->td_data = dma_desc;
+	req->chain_len = 1;
+
+	return &req->req;
+}
+
+/**
+ * Frees request packet, called by gadget driver
+ */
+static void udc_free_request(struct usb_ep *usbep, struct usb_request *usbreq)
+{
+	struct udc_ep   	*ep;
+	struct udc_request      *req;
+
+	if (!usbep || !usbreq)
+		return;
+
+	ep = container_of(usbep, struct udc_ep, ep);
+	req = container_of(usbreq, struct udc_request, req);
+
+	WARN_ON(!list_empty(&req->queue));
+	if (req->td_data) {
+		if (req->chain_len > 1)
+			udc_free_dma_chain(ep->dev, req);
+
+		/* Free the first entry, not done by udc_free_dma_chain */
+		dma_pool_free(ep->dev->data_requests, req->td_data,
+			      req->td_phys);
+	}
+	kfree(req);
+}
+
+/**
+ * Completes request packet
+ */
+static void
+complete_req(struct udc_ep *ep, struct udc_request *req, int sts)
+{
+	unsigned                halted;
+
+	/* unmap DMA */
+	if (req->req.dma != DMA_DONT_USE) {
+		dma_unmap_single(0,
+				 req->req.dma,
+				 req->req.length,
+				 ep->in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+		req->req.dma = DMA_DONT_USE;
+	}
+
+	halted = ep->halted;
+	ep->halted = 1;
+
+	/* set new status if pending */
+	if (req->req.status == -EINPROGRESS)
+		req->req.status = sts;
+
+	list_del_init(&req->queue);
+
+	req->req.complete(&ep->ep, &req->req);
+
+	up(&ep->in_use);
+	ep->halted = halted;
+}
+
+/**
+ * Frees pci pool descriptors of a DMA chain
+ */
+static int udc_free_dma_chain(struct udc *dev, struct udc_request *req)
+{
+
+	int ret_val = 0;
+	struct udc_data_dma     *td;
+	struct udc_data_dma     *td_last = NULL;
+	unsigned int i;
+
+	/* Do not free first desc., will be done by free for request */
+	td_last = req->td_data;
+	td = phys_to_virt(td_last->next);
+
+	for (i = 1; i < req->chain_len; i++) {
+
+		dma_pool_free(dev->data_requests, td,
+				(dma_addr_t) td_last->next);
+		td_last = td;
+		td = phys_to_virt(td_last->next);
+	}
+
+	return ret_val;
+}
+
+/**
+ * Iterates to the end of a DMA chain and returns last descriptor
+ */
+static struct udc_data_dma *udc_get_last_dma_desc(struct udc_request *req)
+{
+	struct udc_data_dma     *td;
+
+	td = req->td_data;
+	while (td && !(td->status & UDC_BIT(UDC_DMA_IN_STS_L)))
+		td = phys_to_virt(td->next);
+
+	return td;
+
+}
+
+static inline void udc_set_rde(struct udc *dev)
+{
+	UDC_SET_BIT(UDC_DEVCTL_RDE, &dev->regs->ctl);
+}
+
+/*
+ * Print a single DMA descriptor.  Used by print_descriptor_chain.
+ */
+static void print_dma_descriptor(struct udc_data_dma *desc)
+{
+	INFO("DMA Descriptor:\n");
+	INFO("Address:0x%8.8x\n", (u32)desc);
+	INFO("Status: 0x%8.8x\n", desc->status);
+	INFO("Buffer: 0x%8.8x\n", desc->bufptr);
+	INFO("Next:   0x%8.8x\n", desc->next);
+}
+
+/*
+ * Walk and print a descriptor chain.  Useful for debugging and error output
+ */
+static void print_descriptor_chain(struct udc_ep *ep)
+{
+	struct udc_data_dma *desc = phys_to_virt(ep->regs->desptr);
+
+	INFO("DMA Descriptor Chain (%s: 0x%8.8X)\n", ep->ep.name,
+			ep->regs->desptr);
+	print_dma_descriptor(desc);
+	while (desc && !(desc->status & UDC_BIT(UDC_DMA_IN_STS_L)) &&
+		       (desc->next != ep->regs->desptr)) {
+		desc = (struct udc_data_dma *)(phys_to_virt(desc->next));
+		print_dma_descriptor(desc);
+	}
+
+}
+
+struct udc_data_dma *prepare_dma_chain(struct udc_ep *ep,
+		struct udc_request *req, gfp_t gfp)
+{
+	int i;
+	struct usb_ep *usbep = &ep->ep;
+	struct usb_request *usbreq = &req->req;
+	struct udc_data_dma *td = req->td_data;
+	struct udc_data_dma *next = NULL;
+	dma_addr_t dma_addr;
+
+	td->bufptr = usbreq->dma;
+	td->status = 0;
+	if (ep->in)
+		td->status = UDC_ADDBITS(td->status,
+				ep->ep.maxpacket,
+				UDC_DMA_IN_STS_TXBYTES);
+
+	for (i = usbep->maxpacket; i < usbreq->length; i += usbep->maxpacket) {
+		if (td->next == (u32)req->td_phys) {
+			next = dma_pool_alloc(ep->dev->data_requests,
+					gfp, &dma_addr);
+			if (next == NULL) {
+				ERR("%s allocation failed!\n", __func__);
+				return NULL;
+			}
+
+			++req->chain_len;
+			/* Last points to first */
+			next->next = (u32)req->td_phys;
+			td->next = dma_addr;
+		} else {
+			next = (struct udc_data_dma *)phys_to_virt(td->next);
+		}
+
+		next->bufptr = usbreq->dma + i;
+		next->status = 0;
+		if (ep->in)
+			next->status = UDC_ADDBITS(next->status,
+						   ep->ep.maxpacket,
+						   UDC_DMA_IN_STS_TXBYTES);
+		td = next;
+	}
+
+	return td;
+}
+
+static void udc_clear_NAK(struct udc_ep *ep)
+{
+	u32 tmp = ioread32(&ep->regs->ctl);
+	int i = 0;
+
+	while (tmp & UDC_BIT(UDC_EPCTL_NAK)) {
+		tmp |= UDC_BIT(UDC_EPCTL_CNAK);
+		iowrite32(tmp, &ep->regs->ctl);
+		au_sync();
+
+		udelay(100);
+		tmp = ioread32(&ep->regs->ctl);
+		++i;
+		if (i % 100 == 0)
+			INFO("Tried to CNAK %d times.\n", i);
+	}
+
+	ep->naking = 0;
+}
+
+static int execute_bulk_request_with_dma(struct usb_ep *usbep,
+					  struct usb_request *usbreq, gfp_t gfp)
+{
+	int			retval;
+	struct udc 		*dev;
+	struct udc_ep 		*ep;
+	struct udc_request	*req;
+	unsigned long 		iflags;
+	struct udc_data_dma	*td;
+
+	ep = container_of(usbep, struct udc_ep, ep);
+	req = container_of(usbreq, struct udc_request, req);
+	dev = ep->dev;
+	td = req->td_data;		/* For notational convenience */
+
+	/* We don't want the isr to start acting on this request while we're
+	 * setting it up.  */
+	spin_lock_irqsave(&dev->lock, iflags);
+
+	usbreq->actual = 0;
+	usbreq->status = -EINPROGRESS;
+
+	/* Map the buffer allocated for the request into DMA space.
+	 * Remember that the CPU should not access this memory until it is
+	 * unmapped.  */
+	if (usbreq->length > 0 && usbreq->dma == DMA_DONT_USE) {
+		usbreq->dma = dma_map_single(dev->pdev,
+					     usbreq->buf,
+					     usbreq->length,
+			ep->in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	}
+
+	td = prepare_dma_chain(ep, req, gfp);
+	if (td == NULL) {
+		retval = -ENOMEM;
+		goto finish;
+	}
+
+	if (ep->in && usbreq->length % usbep->maxpacket != 0)
+		td->status = UDC_ADDBITS(td->status,
+					usbreq->length % usbep->maxpacket,
+					UDC_DMA_IN_STS_TXBYTES);
+
+	td->status |= UDC_BIT(UDC_DMA_OUT_STS_L);
+
+	/* Set the endpoint descriptor register to start the transfer */
+	iowrite32((u32)req->td_phys, &ep->regs->desptr);
+	au_sync();
+
+	udc_clear_NAK(ep);
+
+finish:
+	spin_unlock_irqrestore(&dev->lock, iflags);
+	return retval;
+}
+
+static void udc_tasklet_execute_request(unsigned long ep_as_ul)
+{
+	struct udc_ep *ep = (struct udc_ep *)ep_as_ul;
+	struct udc_request *req;
+
+	down(&ep->in_et);
+
+	if (!list_empty(&ep->queue) && !down_trylock(&ep->in_use)) {
+		req = list_entry(ep->queue.next, struct udc_request, queue);
+
+		execute_bulk_request_with_dma(&ep->ep, &req->req,
+				udc_gfp_flags);
+		if (ep->in)
+			UDC_UNSET_BIT(ep->num, &ep->dev->regs->ep_irqmsk);
+		else
+			udc_set_rde(ep->dev);
+
+		/* Harmless to do on out EPs and saves a branch */
+		req->ready_for_p_bit = true;
+	}
+
+	up(&ep->in_et);
+}
+
+/**
+ * Queues a request packet, called by gadget driver
+ */
+static int udc_queue(struct usb_ep *usbep, struct usb_request *usbreq,
+		gfp_t gfp)
+{
+	int retval = 0;
+	unsigned long           iflags = 0;
+	struct udc_ep   	*ep;
+	struct udc_request      *req;
+	struct udc              *dev;
+
+	/* check the inputs */
+
+	if (!usbep || !usbreq || !usbreq->complete || !usbreq->buf)
+		return -EINVAL;
+
+	req = container_of(usbreq, struct udc_request, req);
+	ep = container_of(usbep, struct udc_ep, ep);
+	dev = ep->dev;
+
+	if (!ep->desc && (ep->num != 0 && ep->num != UDC_EP0OUT_IX))
+		return -EINVAL;
+
+	/* exit on suspend */
+	if (dev->sys_suspended)
+		return -ESHUTDOWN;
+
+	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+
+	spin_lock_irqsave(&dev->lock, iflags);
+	if (ep->num != UDC_EP0OUT_IX && ep->num != UDC_EP0IN_IX) {
+		list_add_tail(&req->queue, &ep->queue);
+		tasklet_schedule(&ep->execute_tasklet);
+		goto finished;
+	} else {
+		if (usbreq->length > 0) {
+			list_add_tail(&req->queue, &ep->queue);
+			execute_bulk_request_with_dma(usbep, usbreq, gfp);
+			UDC_UNSET_BIT(ep->num, &dev->regs->ep_irqmsk);
+			goto finished;
+		} else {
+			/* IN zlp's are handled by hardware */
+			complete_req(ep, req, 0);
+			if (dev->set_cfg_not_acked) {
+				UDC_SET_BIT(UDC_DEVCTL_CSR_DONE,
+						&dev->regs->ctl);
+				dev->set_cfg_not_acked = 0;
+			}
+			goto finished;
+		}
+	}
+
+finished:
+	spin_unlock_irqrestore(&dev->lock, iflags);
+	return retval;
+}
+
+/**
+ * Empty request queue of an endpoint
+ */
+static void empty_req_queue(struct udc_ep *ep)
+{
+	struct udc_request      *req;
+
+	ep->halted = 1;
+	while (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next,
+				struct udc_request,
+				queue);
+		complete_req(ep, req, -ESHUTDOWN);
+	}
+}
+
+/**
+ * Dequeues a request packet, called by gadget driver
+ */
+static int udc_dequeue(struct usb_ep *usbep, struct usb_request *usbreq)
+{
+	struct udc_ep   	*ep;
+	struct udc_request      *req;
+	unsigned long           iflags;
+
+	if (!usbep || !usbreq)
+		return -EINVAL;
+
+	ep = container_of(usbep, struct udc_ep, ep);
+	if (!ep->desc && (ep->num != 0 && ep->num != UDC_EP0OUT_IX))
+		return -EINVAL;
+
+	req = container_of(usbreq, struct udc_request, req);
+
+	spin_lock_irqsave(&ep->dev->lock, iflags);
+	complete_req(ep, req, -ECONNRESET);
+	spin_unlock_irqrestore(&ep->dev->lock, iflags);
+
+	return 0;
+}
+
+/**
+ * Halt or clear halt of endpoint, called by gadget driver
+ */
+static int udc_set_halt(struct usb_ep *usbep, int halt)
+{
+	struct udc_ep   *ep;
+	unsigned long iflags;
+	int retval = 0;
+
+	if (!usbep)
+		return -EINVAL;
+
+	DBG("set_halt %s: halt=%d\n", usbep->name, halt);
+
+	/* TODO: DRY */
+	ep = container_of(usbep, struct udc_ep, ep);
+	if (!ep->desc && (ep->num != 0 && ep->num != UDC_EP0OUT_IX))
+		return -EINVAL;
+	if (!ep->dev->driver || ep->dev->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+	if (ep->dev->sys_suspended)
+		return -ESHUTDOWN;
+
+	spin_lock_irqsave(&udc_stall_spinlock, iflags);
+	/* halt or clear halt */
+	if (halt) {
+		if (ep->num != 0) {
+			UDC_SET_BIT(UDC_EPCTL_S, &ep->regs->ctl);
+			ep->halted = 1;
+		}
+	} else {
+		if (ep->halted) {
+			UDC_UNSET_BIT(UDC_EPCTL_S, &ep->regs->ctl);
+			udc_clear_NAK(ep);
+			ep->halted = 0;
+		}
+	}
+	spin_unlock_irqrestore(&udc_stall_spinlock, iflags);
+	return retval;
+}
+
+/**
+ * Return fifo fill state, called by gadget driver
+ * This is equivalent to unimplemented
+ */
+static int udc_fifo_status(struct usb_ep *usbep)
+{
+	return 0;
+}
+
+/**
+ * Flush the endpoint fifo, called by gadget driver
+ * This is equivalent to unimplemented
+ */
+static void udc_fifo_flush(struct usb_ep *usbep)
+{
+	return;
+}
+
+static struct usb_ep_ops udc_ep_ops = {
+	.enable         = udc_ep_enable,
+	.disable        = udc_disable,
+
+	.queue          = udc_queue,
+	.dequeue        = udc_dequeue,
+
+	.alloc_request  = udc_alloc_request,
+	.free_request   = udc_free_request,
+
+	.set_halt       = udc_set_halt,
+	.fifo_status    = udc_fifo_status,
+	.fifo_flush     = udc_fifo_flush,
+};
+
+/*-------------------------------------------------------------------------*/
+
+/**
+ * Get frame count fifo, called by gadget driver
+ * This is equivalent to unimplemented
+ */
+static int udc_get_frame(struct usb_gadget *gadget)
+{
+	return 0;
+}
+
+/**
+ * Remote wakeup gadget interface
+ */
+static int udc_wakeup(struct usb_gadget *gadget)
+{
+	struct udc              *dev;
+
+	if (!gadget)
+		return -EINVAL;
+	dev = container_of(gadget, struct udc, gadget);
+	udc_remote_wakeup(dev);
+
+	return 0;
+}
+
+/**
+ * gadget ioctl, used for OTG support notification
+ * \return 1 if OTG supported, else 0
+ */
+static int udc_gadget_ioctl(struct usb_gadget *gadget, unsigned cmd,
+			     unsigned long par)
+{
+	struct udc              *dev;
+	int                     retval = 0;
+	unsigned long           iflags;
+	u32 tmp;
+
+	if (!gadget)
+		return -ENODEV;
+	dev = container_of(gadget, struct udc, gadget);
+	spin_lock_irqsave(&dev->lock, iflags);
+	tmp = ioread32(&dev->regs->cfg);
+
+	if (tmp & UDC_BIT(UDC_DEVCFG_HNPSFEN))
+		retval = 1;
+	else
+		retval = 0;
+	spin_unlock_irqrestore(&dev->lock, iflags);
+	return retval;
+}
+
+static const struct usb_gadget_ops udc_ops = {
+	.wakeup         = udc_wakeup,
+	.get_frame      = udc_get_frame,
+	.ioctl          = udc_gadget_ioctl,
+};
+
+/**
+ * Setups endpoint parameters, adds endpoints to linked list
+ */
+static void make_ep_lists(struct udc *dev)
+{
+	/* make gadget ep lists */
+	INIT_LIST_HEAD(&dev->gadget.ep_list);
+	list_add_tail(&dev->ep[UDC_EPIN_STATUS_IX].ep.ep_list,
+		      &dev->gadget.ep_list);
+	list_add_tail(&dev->ep[UDC_EPIN_IX].ep.ep_list, &dev->gadget.ep_list);
+	list_add_tail(&dev->ep[UDC_EPOUT_IX].ep.ep_list,
+		       &dev->gadget.ep_list);
+
+	/* fifo config */
+	dev->ep[UDC_EPIN_STATUS_IX].fifo_depth = UDC_EPIN_SMALLINT_BUFF_SIZE;
+	if (dev->gadget.speed == USB_SPEED_FULL)
+		dev->ep[UDC_EPIN_IX].fifo_depth = UDC_FS_EPIN_BUFF_SIZE;
+	else if (dev->gadget.speed == USB_SPEED_HIGH)
+		dev->ep[UDC_EPIN_IX].fifo_depth = hs_tx_buf;
+	dev->ep[UDC_EPOUT_IX].fifo_depth = UDC_RXFIFO_SIZE;
+}
+
+/**
+ * Init registers at driver load time
+ */
+static int startup_registers(struct udc *dev)
+{
+	u32 tmp;
+	DBG("In startup_registers()\n");
+
+	/* init controller by soft reset */
+	udc_soft_reset(dev);
+
+	/* mask not needed interrupts */
+	udc_mask_unused_interrupts(dev);
+
+	/* put into initial config */
+	udc_basic_init(dev);
+	/* link up all endpoints */
+	udc_setup_endpoints(dev);
+
+	/* program speed */
+	tmp = ioread32(&dev->regs->cfg);
+	if (use_fullspeed)
+		tmp = UDC_ADDBITS(tmp, UDC_DEVCFG_SPD_FS, UDC_DEVCFG_SPD);
+	else
+		tmp = UDC_ADDBITS(tmp, UDC_DEVCFG_SPD_HS, UDC_DEVCFG_SPD);
+	iowrite32(tmp, &dev->regs->cfg);
+
+	DBG("After speed program\n");
+
+	return 0;
+}
+
+/**
+ * Inits UDC context
+ */
+static void udc_basic_init(struct udc *dev)
+{
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	/* disable DMA */
+	UDC_UNSET_BIT(UDC_DEVCTL_RDE, &dev->regs->ctl);
+	UDC_UNSET_BIT(UDC_DEVCTL_TDE, &dev->regs->ctl);
+
+	/* enable dynamic CSR programming */
+	UDC_SET_BITS((UDC_BIT(UDC_DEVCFG_CSR_PRG) |
+		      UDC_BIT(UDC_DEVCFG_SP) |
+		      UDC_BIT(UDC_DEVCFG_RWKP)),
+		     &dev->regs->cfg);
+
+	make_ep_lists(dev);
+
+	dev->data_ep_enabled = 0;
+	dev->data_ep_queued = 0;
+}
+
+/**
+ * Sets initial endpoint parameters
+ *
+ * \param dev           pointer to device struct
+ */
+static void udc_setup_endpoints(struct udc *dev)
+{
+	struct udc_ep   *ep;
+	u32     tmp;
+
+	DBG("udc_setup_endpoints()\n");
+
+	/* read enum speed */
+	tmp = ioread32(&dev->regs->sts);
+	tmp = UDC_GETBITS(tmp, UDC_DEVSTS_ENUM_SPEED);
+	if (tmp ==  UDC_DEVSTS_ENUM_SPEED_HIGH)
+		dev->gadget.speed = USB_SPEED_HIGH;
+	else if (tmp ==  UDC_DEVSTS_ENUM_SPEED_FULL)
+		dev->gadget.speed = USB_SPEED_FULL;
+
+	/* set basic ep parameters */
+	for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
+		ep = &dev->ep[tmp];
+		ep->dev = dev;
+		ep->ep.name = ep_string[tmp];
+		ep->num = tmp;
+		/* txfifo size is calculated at enable time */
+		ep->txfifo = dev->txfifo;
+
+		/* fifo size */
+		if (tmp < UDC_EPIN_NUM) {
+			ep->fifo_depth = UDC_TXFIFO_SIZE;
+			ep->in = 1;
+		} else {
+			ep->fifo_depth = UDC_RXFIFO_SIZE;
+			ep->in = 0;
+
+		}
+		ep->regs = &dev->ep_regs[tmp];
+		/* ep will be reset only if ep was not enabled before to avoid
+		   disabling ep interrupts when ENUM interrupt occurs but ep is
+		   not enabled by gadget driver  */
+		if (!ep->desc)
+			ep_init(dev->regs, ep);
+
+		/* nak OUT endpoints until enable - not for ep0*/
+		if (tmp > UDC_EPIN_NUM) {
+			UDC_SET_BIT(UDC_EPCTL_SNAK, &ep->regs->ctl);
+			ep->naking = 1;
+		}
+	}
+
+	DBG("Done setting up ep params\n");
+
+	/* EP0 max packet */
+	if (dev->gadget.speed == USB_SPEED_FULL) {
+		dev->ep[UDC_EP0IN_IX].ep.maxpacket = UDC_FS_EP0IN_MAX_PKT_SIZE;
+		dev->ep[UDC_EP0OUT_IX].ep.maxpacket =
+			UDC_FS_EP0OUT_MAX_PKT_SIZE;
+	} else if (dev->gadget.speed == USB_SPEED_HIGH) {
+		dev->ep[UDC_EP0IN_IX].ep.maxpacket = UDC_EP0IN_MAX_PKT_SIZE;
+		dev->ep[UDC_EP0OUT_IX].ep.maxpacket = UDC_EP0OUT_MAX_PKT_SIZE;
+	}
+
+	DBG("Done setting up EP0 max packet\n");
+
+	/* with suspend bug workaround, ep0 params for gadget driver
+	   are set at gadget driver bind() call */
+	dev->gadget.ep0 = &dev->ep[UDC_EP0IN_IX].ep;
+	dev->ep[UDC_EP0IN_IX].halted = 0;
+	INIT_LIST_HEAD(&dev->gadget.ep0->ep_list);
+
+	/* init cfg/alt/int */
+	dev->cur_config = 0;
+	dev->cur_intf = 0;
+	dev->cur_alt = 0;
+
+	DBG("udc_setup_endpoints done\n");
+}
+
+/**
+ * Bringup after Connect event,
+ * initial bringup to be ready for ep0 events
+ */
+static void usb_connect(struct udc *dev)
+{
+	INFO("USB Connect\n");
+
+	dev->connected = 1;
+
+	/* put into initial config */
+	udc_basic_init(dev);
+
+	/* enable device setup interrupts */
+	udc_enable_dev_setup_interrupts(dev);
+}
+
+/**
+ * Calls gadget with disconnect event and resets the UDC and makes
+ * initial bringup to be ready for ep0 events
+ */
+static void usb_disconnect(struct udc *dev)
+{
+	INFO("USB Disconnect\n");
+
+	dev->connected = 0;
+
+	/* mask interrupts */
+	udc_mask_unused_interrupts(dev);
+
+	tasklet_schedule(&disconnect_tasklet);
+}
+
+/**
+ * Tasklet for disconnect to be outside of interrupt
+ * context
+ */
+static void udc_tasklet_disconnect(unsigned long par)
+{
+	struct udc *dev = (struct udc *)(*((struct udc **) par));
+	u32 tmp;
+
+	DBG("Tasklet disconnect\n");
+	if (dev->driver) {
+		/* call gadget to reset configs etc. */
+		if (spin_is_locked(&dev->lock)) {
+			spin_unlock(&dev->lock);
+			dev->driver->disconnect(&dev->gadget);
+			spin_lock(&dev->lock);
+		} else
+			dev->driver->disconnect(&dev->gadget);
+
+		/* empty queues */
+		for (tmp = 0; tmp < UDC_EP_NUM; tmp++)
+			empty_req_queue(&dev->ep[tmp]);
+	}
+
+	/* disable ep0 */
+	ep_init(dev->regs, &dev->ep[UDC_EP0IN_IX]);
+
+	if (!soft_reset_occured) {
+		/* init controller by soft reset */
+		udc_soft_reset(dev);
+		soft_reset_occured++;
+	}
+	/* re-enable dev interrupts */
+	udc_enable_dev_setup_interrupts(dev);
+	/* back to full speed ? */
+	if (use_fullspeed) {
+		tmp = ioread32(&dev->regs->cfg);
+		tmp = UDC_ADDBITS(tmp, UDC_DEVCFG_SPD_FS, UDC_DEVCFG_SPD);
+		iowrite32(tmp, &dev->regs->cfg);
+	}
+}
+
+/**
+ * Reset the UDC core
+ */
+static void udc_soft_reset(struct udc *dev)
+{
+	DBG("Soft reset\n");
+	/* reset possible waiting interrupts, because int.
+	   status is lost after soft reset */
+	/* ep int. status reset */
+	iowrite32(UDC_EPINT_MSK_DISABLE_ALL, &dev->regs->ep_irqsts);
+	/* device int. status reset */
+	iowrite32(UDC_DEV_MSK_DISABLE, &dev->regs->irqsts);
+
+	spin_lock_irq(&udc_irq_spinlock);
+	iowrite32(UDC_BIT(UDC_DEVCFG_SOFTRESET), &dev->regs->cfg);
+	ioread32(&dev->regs->cfg);
+	spin_unlock_irq(&udc_irq_spinlock);
+
+}
+
+/**
+ * Called by OTG driver to notify us regarding an OTG event
+ *
+ * \param code           notify code
+ */
+void otg_notify(unsigned int code)
+{
+	DBG("OTG notify code=%d\n", code);
+	switch (code) {
+	case OTG_GADGET_EVT_SVDROP:
+		/* disconnect event */
+		usb_disconnect(udc);
+		break;
+	case OTG_GADGET_EVT_SVALID:
+		/* connect event */
+		usb_connect(udc);
+		break;
+	case OTG_GADGET_REQ_WAKE:
+		/* remote wakeup event */
+		udc_remote_wakeup(udc);
+		break;
+	}
+}
+
+/**
+ * Inits endpoint 0 so that SETUP packets are processed
+ *
+ * \param dev           pointer to device struct
+ */
+static void activate_control_endpoints(struct udc *dev)
+{
+	u32 tmp;
+	struct udc_ep 	*ep0in = &dev->ep[UDC_EP0IN_IX];
+	struct udc_ep 	*ep0out = &dev->ep[UDC_EP0OUT_IX];
+
+	DBG("activate_control_endpoints\n");
+
+	/* flush fifo */
+	UDC_SET_BIT(UDC_EPCTL_F, &ep0in->regs->ctl);
+
+	/* set ep0 directions */
+	ep0in->in = 1;
+	ep0out->in = 0;
+
+	/* set buffer size (tx fifo entries) of EP0_IN */
+	tmp = ioread32(&ep0in->regs->bufin_framenum);
+	if (dev->gadget.speed == USB_SPEED_FULL)
+		tmp = UDC_ADDBITS(tmp, UDC_FS_EPIN0_BUFF_SIZE,
+		      UDC_EPIN_BUFF_SIZE);
+	else if (dev->gadget.speed == USB_SPEED_HIGH)
+		tmp = UDC_ADDBITS(tmp, UDC_EPIN0_BUFF_SIZE, UDC_EPIN_BUFF_SIZE);
+	iowrite32(tmp, &ep0in->regs->bufin_framenum);
+
+	/* set max packet size of EP0_IN */
+	tmp = ioread32(&ep0in->regs->bufout_maxpkt);
+	if (dev->gadget.speed == USB_SPEED_FULL)
+		tmp = UDC_ADDBITS(tmp, UDC_FS_EP0IN_MAX_PKT_SIZE,
+				  UDC_EP_MAX_PKT_SIZE);
+	else if (dev->gadget.speed == USB_SPEED_HIGH)
+		tmp = UDC_ADDBITS(tmp, UDC_EP0IN_MAX_PKT_SIZE,
+				  UDC_EP_MAX_PKT_SIZE);
+	iowrite32(tmp, &ep0in->regs->bufout_maxpkt);
+
+	/* set max packet size of EP0_OUT */
+	tmp = ioread32(&ep0out->regs->bufout_maxpkt);
+	if (dev->gadget.speed == USB_SPEED_FULL)
+		tmp = UDC_ADDBITS(tmp, UDC_FS_EP0OUT_MAX_PKT_SIZE,
+				  UDC_EP_MAX_PKT_SIZE);
+	else if (dev->gadget.speed == USB_SPEED_HIGH)
+		tmp = UDC_ADDBITS(tmp, UDC_EP0OUT_MAX_PKT_SIZE,
+				  UDC_EP_MAX_PKT_SIZE);
+	iowrite32(tmp, &ep0out->regs->bufout_maxpkt);
+
+	/* set max packet size of EP0 in UDC CSR  */
+	tmp = ioread32(&dev->csr->ne[0]);
+	if (dev->gadget.speed == USB_SPEED_FULL)
+		tmp = UDC_ADDBITS(tmp, UDC_FS_EP0OUT_MAX_PKT_SIZE,
+				  UDC_CSR_NE_MAX_PKT);
+	else if (dev->gadget.speed == USB_SPEED_HIGH)
+		tmp = UDC_ADDBITS(tmp, UDC_EP0OUT_MAX_PKT_SIZE,
+				  UDC_CSR_NE_MAX_PKT);
+	iowrite32(tmp, &dev->csr->ne[0]);
+
+	ep0out->td->status |= UDC_BIT(UDC_DMA_OUT_STS_L);
+	/* write dma desc address */
+	iowrite32(ep0out->td_stp_dma, &ep0out->regs->subptr);
+	iowrite32(ep0out->td_phys, &ep0out->regs->desptr);
+	/* enable DMA */
+	UDC_SET_BITS((UDC_BIT(UDC_DEVCTL_MODE)
+		      | UDC_BIT(UDC_DEVCTL_RDE)
+		      | UDC_BIT(UDC_DEVCTL_TDE)),
+		     &dev->regs->ctl);
+
+	if (use_dma_bufferfill_mode)
+		UDC_SET_BIT(UDC_DEVCTL_BF, &dev->regs->ctl);
+	else if (use_dma_ppb_du)
+		UDC_SET_BIT(UDC_DEVCTL_DU, &dev->regs->ctl);
+
+	/* clear NAK by writing CNAK for EP0IN */
+	udc_clear_NAK(ep0in);
+	udc_clear_NAK(ep0out);
+}
+
+/**
+ * \brief
+ * Make endpoint 0 ready for control traffic
+ */
+static int setup_ep0(struct udc *dev)
+{
+	activate_control_endpoints(dev);
+	/* enable ep0 interrupts */
+	udc_enable_ep0_interrupts(dev);
+	/* enable device setup interrupts */
+	udc_enable_dev_setup_interrupts(dev);
+
+	return 0;
+}
+
+/**
+ * Called by gadget driver to register itself
+ */
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	struct udc              *dev = udc;
+	int                     retval;
+	u32 tmp;
+
+	DBG("In usb_gadget_register_driver\n");
+
+	DBG("Driver speed is %d\n", driver->speed);
+	if (!driver || !driver->bind
+			|| !driver->unbind
+			|| !driver->setup
+			|| driver->speed != USB_SPEED_HIGH)
+		return -EINVAL;
+	if (!dev)
+		return -ENODEV;
+	if (dev->driver)
+		return -EBUSY;
+
+	driver->driver.bus = 0;
+	dev->driver = driver;
+	dev->gadget.dev.driver = &driver->driver;
+
+	device_create_file(&dev->pdev->dev, &dev_attr_function);
+	device_create_file(&dev->pdev->dev, &dev_attr_queues);
+
+#ifdef CONFIG_USB_OTG
+	DBG("Gadget is OTG\n");
+	dev->gadget.is_otg = 1;
+#endif
+	retval = driver->bind(&dev->gadget);
+	/* e.g. ether gadget needs driver_data on both ep0 endpoints */
+	dev->ep[UDC_EP0OUT_IX].ep.driver_data =
+		dev->ep[UDC_EP0IN_IX].ep.driver_data;
+
+	gadget_bind_count++;
+	if (retval) {
+		DBG("binding to  %s returning %d\n",
+				driver->driver.name, retval);
+		dev->driver = 0;
+		dev->gadget.dev.driver = 0;
+		return retval;
+	} else {
+		DBG("Binding successful\n");
+	}
+
+	/* if otg driver already registered */
+	/* call otg bind() to mux udc to phy */
+	if (dev->otg_transceiver) {
+		dev->otg_transceiver->set_peripheral(
+				dev->otg_transceiver, &dev->gadget);
+		/* clear SD */
+		tmp = ioread32(&dev->regs->ctl);
+		tmp = tmp & UDC_CLEAR_BIT(UDC_DEVCTL_SD);
+		iowrite32(tmp, &dev->regs->ctl);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_register_driver);
+
+/**
+ * Called by OTG driver to register itself
+ */
+int usb_gadget_register_otg(struct otg_transceiver *(*get_transceiver)(void))
+{
+	struct udc              *dev = udc;
+	int                     retval;
+	u32 tmp;
+
+	if (!get_transceiver)
+		return -EINVAL;
+	if (!dev)
+		return -ENODEV;
+	if (dev->otg_transceiver)
+		return -EBUSY;
+
+	dev->otg_transceiver = get_transceiver();
+
+	if (!dev->otg_transceiver->otg_priv)
+		return -EINVAL;
+	dev->otg_driver = (struct usb_otg_gadget_extension *)
+		dev->otg_transceiver->otg_priv;
+
+	/* init registers here first with suspend bug */
+	if (!otg_reg_count) {
+		startup_registers(dev);
+		otg_reg_count++;
+	}
+
+	/* set notify function */
+	dev->otg_driver->notify = otg_notify;
+	DBG("otg_driver->notify set.\n");
+	/* if gadget driver already registered */
+	/* call gadget bind() to switch to mux udc to phy */
+	if (dev->driver) {
+		/* otg driver bind() */
+		retval = dev->otg_transceiver->set_peripheral(
+				dev->otg_transceiver, &dev->gadget);
+		if (retval) {
+			DBG("error bind to uoc driver\n");
+			dev->otg_driver = NULL;
+			dev->otg_transceiver = NULL;
+			return retval;
+		}
+		/* get ready for ep0 traffic */
+		setup_ep0(dev);
+
+		/* clear SD */
+		tmp = ioread32(&dev->regs->ctl);
+		tmp = tmp & UDC_CLEAR_BIT(UDC_DEVCTL_SD);
+		iowrite32(tmp, &dev->regs->ctl);
+	}
+
+	INFO("registered uoc driver\n");
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_register_otg);
+
+/**
+ * Called by OTG driver to unregister itself
+ */
+int usb_gadget_unregister_otg(void)
+{
+	struct udc      *dev = udc;
+	unsigned long   flags;
+
+	if (!dev)
+		return -ENODEV;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	/* mask not needed interrupts */
+	udc_mask_unused_interrupts(dev);
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	dev->otg_supported = 0;
+	if (dev->otg_transceiver) {
+		dev->otg_transceiver->set_peripheral(dev->otg_transceiver,
+				NULL);
+		dev->otg_transceiver = NULL;
+	}
+	if (dev->otg_driver) {
+		dev->otg_driver->notify = NULL;
+		dev->otg_driver = NULL;
+	}
+
+	/* set SD */
+	UDC_SET_BIT(UDC_DEVCTL_SD, &dev->regs->ctl);
+
+	DBG("unregistered uoc driver\n");
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_unregister_otg);
+
+/**
+ *  shutdown requests and disconnect from gadget
+ */
+static void shutdown(struct udc *dev, struct usb_gadget_driver *driver)
+{
+	int tmp;
+
+	/* empty queues and init hardware */
+	udc_basic_init(dev);
+	for (tmp = 0; tmp < UDC_EP_NUM; tmp++)
+		empty_req_queue(&dev->ep[tmp]);
+
+	if (dev->gadget.speed != USB_SPEED_UNKNOWN)
+		driver->disconnect(&dev->gadget);
+	udc_setup_endpoints(dev);
+}
+
+/**
+ * Called by gadget driver to unregister itself
+ */
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+{
+	struct udc      *dev = udc;
+	unsigned long   iflags;
+
+	if (!dev)
+		return -ENODEV;
+	if (!driver || driver != dev->driver)
+		return -EINVAL;
+	if (gadget_bind_count) {
+		spin_lock_irqsave(&dev->lock, iflags);
+		shutdown(dev, driver);
+		spin_unlock_irqrestore(&dev->lock, iflags);
+	}
+
+	/* unbind from otg driver first */
+	if (dev->otg_transceiver) {
+		dev->otg_transceiver->set_peripheral(
+				dev->otg_transceiver, NULL);
+	}
+
+	if (gadget_bind_count)
+		driver->unbind(&dev->gadget);
+
+	gadget_bind_count = 0;
+	dev->driver = 0;
+
+	/* set SD */
+	UDC_SET_BIT(UDC_DEVCTL_SD, &dev->regs->ctl);
+	DBG("%s: unregistered\n", driver->driver.name);
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_unregister_driver);
+
+void update_req_count(struct udc_request *req)
+{
+	struct udc_data_dma *last_desc;
+	unsigned int count;
+	unsigned int tmp;
+
+	last_desc = udc_get_last_dma_desc(req);
+	count = UDC_GETBITS(last_desc->status, UDC_DMA_OUT_STS_RXBYTES);
+	if (count == 0) {
+		/* on 64k packets the RXBYTES field is zero */
+		if (req->req.length == UDC_DMA_MAXPACKET)
+			count = UDC_DMA_MAXPACKET;
+	}
+
+	VDBG("Received %lx bytes\n", (unsigned long) count);
+
+	tmp = req->req.length - req->req.actual;
+	if (count > tmp) {
+		ERR("Buffer overrun!\n");
+		req->req.status = -EOVERFLOW;
+		count = tmp;
+	}
+
+	req->req.actual += count;
+}
+
+/**
+ * Check for and clear BNA and Hardware errors
+ * returns nonzero if any errors were found
+ */
+static inline int check_and_clear_errors(struct udc_ep *ep)
+{
+	u32 				epsts;
+
+	epsts = ioread32(&ep->regs->sts);
+	/* BNA event */
+	if (epsts & UDC_BIT(UDC_EPSTS_BNA)) {
+		ERR("BNA occurred - %s: desptr = 0x%8.8x\n", ep->ep.name,
+		       ep->regs->desptr);
+		UDC_SET_BIT(UDC_EPSTS_BNA, &ep->regs->sts);
+		return 1;
+	}
+
+	/* HE event */
+	if (epsts & UDC_BIT(UDC_EPSTS_HE)) {
+		ERR("HE occured on %s\n", ep->ep.name);
+		UDC_SET_BIT(UDC_EPSTS_HE, &ep->regs->sts);
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * Interrupt handler for data OUT traffic
+ */
+static inline int udc_data_out_isr(struct udc *dev, int ep_ix)
+{
+	int 				ret_val = 0;
+	u32				tmp;
+	struct udc_ep   		*ep;
+	struct udc_request              *req;
+	unsigned long 			iflags;
+	struct udc_data_dma 		*last_desc;
+	unsigned 			dma_done;
+
+	VDBG("ep%d irq\n", ep_ix);
+	ep = &dev->ep[ep_ix];
+
+	spin_lock_irqsave(&dev->lock, iflags);
+
+	tmp = ioread32(&ep->regs->sts);
+	/* BNA event ? */
+	if (tmp & UDC_BIT(UDC_EPSTS_BNA)) {
+		ERR("BNA occurred - %s: desptr = 0x%8.8x\n", ep->ep.name,
+		       ep->regs->desptr);
+		/* clear BNA */
+		ep->regs->sts = UDC_BIT(UDC_EPSTS_BNA);
+		au_sync();
+		goto finished;
+	}
+
+	/* HE event ? */
+	if (tmp & UDC_BIT(UDC_EPSTS_HE)) {
+		ERR("HE occured on %s\n", ep->ep.name);
+
+		/* clear HE */
+		ep->regs->sts = UDC_BIT(UDC_EPSTS_HE);
+		au_sync();
+
+		ret_val = 1;
+		goto finished;
+	}
+
+	/*
+	epsts = ioread32(&ep->regs->sts);
+	if (check_and_clear_errors(ep))
+		goto finished;
+		*/
+
+	if (!list_empty(&ep->queue))
+		req = list_entry(ep->queue.next, struct udc_request, queue);
+	else {
+		INFO("In %s but there is no queued request.\n", __func__);
+		goto finished;
+	}
+
+	/* check for DMA done */
+	last_desc = udc_get_last_dma_desc(req);
+	dma_done = UDC_GETBITS(last_desc->status, UDC_DMA_OUT_STS_BS);
+
+	if (dma_done == UDC_DMA_OUT_STS_BS_DMA_DONE) {
+		update_req_count(req);
+		complete_req(ep, req, 0);
+		tasklet_schedule(&ep->execute_tasklet);
+	} else {
+		INFO("Got a DMA done interrupt but DMA is not done.\n");
+		print_descriptor_chain(ep);
+	}
+
+finished:
+	/* clear OUT bits in ep status */
+	ep->regs->sts = UDC_EPSTS_OUT_CLEAR;
+	au_sync();
+
+	spin_unlock_irqrestore(&dev->lock, iflags);
+	return ret_val;
+}
+
+/**
+ * Interrupt handler for data IN traffic
+ */
+static inline int udc_data_in_isr(struct udc *dev, int ep_ix)
+{
+	int ret_val = 0;
+	u32 epsts;
+	struct udc_ep  *ep;
+	unsigned long 			iflags;
+	struct udc_request *req;
+
+	spin_lock_irqsave(&dev->lock, iflags);
+
+	ep = &dev->ep[ep_ix];
+	epsts = ioread32(&ep->regs->sts);
+
+	/* BNA */
+	if (epsts & UDC_BIT(UDC_EPSTS_BNA)) {
+		ERR("BNA ep%din occured - DESPTR = %08lx \n", ep->num,
+			(long unsigned int)ep->regs->desptr);
+
+		/* clear BNA */
+		ep->regs->sts = UDC_BIT(UDC_EPSTS_BNA);
+		au_sync();
+
+		goto finished;
+	}
+
+	/* HE event */
+	if (epsts & UDC_BIT(UDC_EPSTS_HE)) {
+		ERR("HE occured on %s\n", ep->ep.name);
+
+		/* clear HE */
+		ep->regs->sts = UDC_BIT(UDC_EPSTS_HE);
+		au_sync();
+
+		ret_val = 1;
+		goto finished;
+	}
+	/*
+	epsts = ioread32(&ep->regs->sts);
+	if (check_and_clear_errors(ep))
+		goto finished;
+		*/
+
+	if (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct udc_request, queue);
+	} else {
+		/* This is not all that unusual - the host can be greedy when
+		 * it wants IN data and might beat the gadget to queueing a
+		 * request.
+		 */
+		goto finished;
+	}
+
+	/* DMA completion */
+	if (epsts & UDC_BIT(UDC_EPSTS_TDC)) {
+		/* Disable this IRQ to prevent flooding */
+		dev->regs->ep_irqmsk |= UDC_BIT(ep->num);
+		au_sync();
+
+		complete_req(ep, req, 0);
+		tasklet_schedule(&ep->execute_tasklet);
+	}
+
+	if (epsts & UDC_BIT(UDC_EPSTS_IN)) {
+		/* set poll demand bit */
+		if (req->ready_for_p_bit) {
+			req->ready_for_p_bit = false;
+			ep->regs->ctl |= UDC_BIT(UDC_EPCTL_P);
+			au_sync();
+		}
+	}
+
+finished:
+	/* clear status bits */
+	UDC_SET_BITS(epsts, &ep->regs->sts);
+	spin_unlock_irqrestore(&dev->lock, iflags);
+	return ret_val;
+}
+
+/**
+ * Interrupt handler for Control OUT traffic
+ *
+ * \param dev           pointer to UDC device object
+ * \return 0 if success
+ */
+static inline int udc_control_out_isr(struct udc *dev)
+{
+	int ret_val = 0;
+	u32 tmp;
+	int setup_supported;
+	struct udc_ep   *ep0in;
+	struct udc_ep   *ep0out;
+
+	ep0out = &dev->ep[UDC_EP0OUT_IX];
+	ep0in = &dev->ep[UDC_EP0IN_IX];
+
+	/* clear irq */
+	UDC_SET_BIT(UDC_EPINT_OUT_EP0, &dev->regs->ep_irqsts);
+	if (check_and_clear_errors(ep0out))
+		goto finished;
+
+	tmp = ep0out->regs->sts;
+
+	/* type of data: SETUP or DATA 0 bytes */
+	tmp = UDC_GETBITS(tmp, UDC_EPSTS_OUT);
+	/* setup data */
+	if (tmp == UDC_EPSTS_OUT_SETUP) {
+		dev->waiting_zlp_ack_ep0in = 0;
+
+		ep0out->regs->sts |= UDC_EPSTS_OUT_CLEAR;
+
+		setup_data.data[0] = dev->ep[UDC_EP0OUT_IX].td_stp->data12;
+		setup_data.data[1] = dev->ep[UDC_EP0OUT_IX].td_stp->data34;
+		ep0out->td_stp->status = UDC_DMA_STP_STS_BS_HOST_READY;
+
+		/* determine direction of control data */
+		if ((setup_data.request.bRequestType & USB_DIR_IN) == 0) {
+			dev->gadget.ep0 = &dev->ep[UDC_EP0OUT_IX].ep;
+		} else {
+			dev->gadget.ep0 = &dev->ep[UDC_EP0IN_IX].ep;
+			udc_set_rde(dev);
+		}
+
+		setup_supported = dev->driver->setup(&dev->gadget,
+						     &setup_data.request);
+
+		tmp = ioread32(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+
+		if (setup_supported >= 0 &&
+				setup_supported < UDC_EP0IN_MAXPACKET) {
+			ep0in->regs->ctl |= UDC_BIT(UDC_EPCTL_CNAK);
+		} else if (setup_supported < 0) {
+			/* if unsupported request then stall */
+			ep0in->regs->ctl |= UDC_BIT(UDC_EPCTL_S);
+			au_sync();
+		}
+
+		ep0out->regs->ctl |= UDC_BIT(UDC_EPCTL_CNAK);
+		au_sync();
+	} else if (tmp == UDC_EPSTS_OUT_DATA) {
+		/* no req if 0 packet, just reactivate */
+		if (list_empty(&ep0out->queue)) {
+			ep0out->td->status =
+				UDC_ADDBITS(ep0out->td->status,
+						UDC_DMA_OUT_STS_BS_HOST_READY,
+						UDC_DMA_OUT_STS_BS);
+		} else {
+			udc_data_out_isr(dev, UDC_EP0OUT_IX);
+			ep0out->regs->desptr = ep0out->td_phys;
+		}
+		udc_set_rde(dev);
+	}
+
+finished:
+	ep0out->regs->sts = UDC_EPSTS_OUT_CLEAR;
+	return ret_val;
+}
+
+/**
+ * Interrupt handler for Control IN traffic
+ *
+ * \param dev           pointer to UDC device object
+ * \return 0 if success
+ */
+static inline int udc_control_in_isr(struct udc *dev)
+{
+	int ret_val = 0;
+	u32 tmp;
+	struct udc_ep *ep;
+	struct udc_request *req;
+
+	ep = &dev->ep[UDC_EP0IN_IX];
+
+	UDC_SET_BIT(UDC_EPINT_IN_EP0, &dev->regs->ep_irqsts);
+
+	tmp = ep->regs->sts;
+	if (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct udc_request, queue);
+
+		/* DMA completion */
+		if (tmp & UDC_BIT(UDC_EPSTS_TDC)) {
+			ep->regs->ctl |= UDC_BIT(UDC_EPCTL_CNAK);
+		} else if (tmp & UDC_BIT(UDC_EPSTS_IN)) {
+			ep->regs->desptr = (u32)req->td_phys;
+			req->td_data->status = UDC_ADDBITS(req->td_data->status,
+						UDC_DMA_STP_STS_BS_HOST_READY,
+						UDC_DMA_STP_STS_BS);
+			au_sync();
+
+			ep->regs->ctl |= UDC_BIT(UDC_EPCTL_P);
+
+			/* All bytes are always transferred */
+			req->req.actual = req->req.length;
+			complete_req(ep, req, 0);
+			au_sync();
+		}
+	}
+	ep->regs->sts = ep->regs->sts;
+	au_sync();
+
+	return ret_val;
+}
+
+/**
+ * Interrupt handler for global device events
+ *
+ * \param dev           pointer to UDC device object
+ * \param dev_irq       device interrupt bit of DEVINT register
+ * \return 0 if success
+ */
+static inline int udc_dev_isr(struct udc *dev, u32 dev_irq)
+{
+	int ret_val = 0;
+	u32 tmp;
+	u32 cfg;
+	struct udc_ep *ep;
+	u16 i;
+	u8 udc_csr_epix;
+
+	DBG("Got interrupt.  dev_irq is %8.8X\n", dev_irq);
+
+	/* SET_CONFIG irq ? */
+	if (dev_irq & UDC_BIT(UDC_DEVINT_SC)) {
+
+		/* read config value */
+		tmp = ioread32(&dev->regs->sts);
+		cfg = UDC_GETBITS(tmp, UDC_DEVSTS_CFG);
+#ifdef UDC_DEBUG
+		/* this is needed for debug only */
+		if (cfg == dev->cur_config)
+			same_cfg = 1;
+		else
+			same_cfg = 0;
+		VDBG("same_cfg=%d\n", same_cfg);
+#endif
+		DBG("SET_CONFIG interrupt: config=%d\n", cfg);
+		dev->cur_config = cfg;
+		dev->set_cfg_not_acked = 1;
+
+		/* make usb request for gadget driver */
+		memset(&setup_data, 0 , sizeof(union udc_setup_data));
+		setup_data.request.bRequest = USB_REQ_SET_CONFIGURATION;
+		setup_data.request.wValue = dev->cur_config;
+
+		/* programm the NE registers */
+		for (i = 0; i < UDC_EP_NUM; i++) {
+			ep = &dev->ep[i];
+			if (ep->in) {
+
+				/* ep ix in UDC CSR register space */
+				udc_csr_epix = ep->num;
+
+
+			} /* OUT ep */
+			else {
+				/* ep ix in UDC CSR register space */
+				udc_csr_epix = ep->num - UDC_CSR_EP_OUT_IX_OFS;
+			}
+
+			tmp = ioread32(&dev->csr->ne[udc_csr_epix]);
+			/* ep cfg */
+			tmp = UDC_ADDBITS(tmp, ep->dev->cur_config,
+					UDC_CSR_NE_CFG);
+			/* write reg */
+			iowrite32(tmp, &dev->csr->ne[udc_csr_epix]);
+
+			/* clear stall bits */
+			ep->halted = 0;
+			tmp = ioread32(&ep->regs->ctl);
+			tmp = tmp & UDC_CLEAR_BIT(UDC_EPCTL_S);
+			iowrite32(tmp, &ep->regs->ctl);
+		}
+		/* call gadget zero with setup data received */
+		spin_unlock(&dev->lock);
+		tmp = dev->driver->setup(&dev->gadget, &setup_data.request);
+		spin_lock(&dev->lock);
+
+	} /* SET_INTERFACE ? */
+	if (dev_irq & UDC_BIT(UDC_DEVINT_SI)) {
+		dev->set_cfg_not_acked = 1;
+		/* read interface and alt setting values */
+		tmp = ioread32(&dev->regs->sts);
+		dev->cur_alt = UDC_GETBITS(tmp, UDC_DEVSTS_ALT);
+		dev->cur_intf = UDC_GETBITS(tmp, UDC_DEVSTS_INTF);
+
+		/* make usb request for gadget driver */
+		memset(&setup_data, 0 , sizeof(union udc_setup_data));
+		setup_data.request.bRequest = USB_REQ_SET_INTERFACE;
+		setup_data.request.bRequestType = USB_RECIP_INTERFACE;
+		setup_data.request.wValue = dev->cur_alt;
+		setup_data.request.wIndex = dev->cur_intf;
+
+		DBG("SET_INTERFACE interrupt: alt=%d intf=%d\n",
+				dev->cur_alt, dev->cur_intf);
+
+		for (i = 0; i < UDC_EP_NUM; i++) {
+			ep = &dev->ep[i];
+			if (ep->in) {
+
+				/* ep ix in UDC CSR register space */
+				udc_csr_epix = ep->num;
+
+
+			} /* OUT ep */
+			else {
+				/* ep ix in UDC CSR register space */
+				udc_csr_epix = ep->num - UDC_CSR_EP_OUT_IX_OFS;
+			}
+
+			/***** UDC CSR reg ****************************/
+			/* set ep values  */
+			tmp = ioread32(&dev->csr->ne[udc_csr_epix]);
+			/* ep interface */
+			tmp = UDC_ADDBITS(tmp, ep->dev->cur_intf,
+					UDC_CSR_NE_INTF);
+			/* ep alt */
+			tmp = UDC_ADDBITS(tmp, ep->dev->cur_alt,
+					UDC_CSR_NE_ALT);
+			/* write reg */
+			iowrite32(tmp, &dev->csr->ne[udc_csr_epix]);
+
+			/* clear stall bits */
+			ep->halted = 0;
+			tmp = ioread32(&ep->regs->ctl);
+			tmp = tmp & UDC_CLEAR_BIT(UDC_EPCTL_S);
+			iowrite32(tmp, &ep->regs->ctl);
+		}
+
+		/* call gadget zero with setup data received */
+		spin_unlock(&dev->lock);
+		tmp = dev->driver->setup(&dev->gadget, &setup_data.request);
+		spin_lock(&dev->lock);
+
+	} /* USB reset */
+	if (dev_irq & UDC_BIT(UDC_DEVINT_UR)) {
+		DBG("USB Reset interrupt\n");
+
+		/* allow soft reset when suspend occurs */
+		soft_reset_occured = 0;
+
+		dev->waiting_zlp_ack_ep0in = 0;
+		dev->set_cfg_not_acked = 0;
+
+		/* mask not needed interrupts */
+		udc_mask_unused_interrupts(dev);
+
+		/* call gadget to reset configs etc. */
+		spin_unlock(&dev->lock);
+		dev->driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+
+		/* disable ep0 to empty req queue */
+		empty_req_queue(&dev->ep[UDC_EP0IN_IX]);
+		ep_init(dev->regs,
+				&dev->ep[UDC_EP0IN_IX]);
+
+		/* soft reset when rxfifo not empty */
+		tmp = ioread32(&dev->regs->sts);
+		if (!(tmp & UDC_BIT(UDC_DEVSTS_RXFIFO_EMPTY)) &&
+				!soft_reset_after_usbreset_occured) {
+			udc_soft_reset(dev);
+			soft_reset_after_usbreset_occured++;
+		}
+
+		/* put into initial config */
+		udc_basic_init(dev);
+
+		/* enable device setup interrupts */
+		udc_enable_dev_setup_interrupts(dev);
+
+	} /* USB suspend */
+
+	if (dev_irq & UDC_BIT(UDC_DEVINT_ENUM)) {
+		DBG("ENUM interrupt\n");
+#ifdef UDC_DEBUG
+		num_enums++;
+		DBG("%d enumerations !\n", num_enums);
+#endif
+		soft_reset_after_usbreset_occured = 0;
+
+		/* disable ep0 to empty req queue */
+		empty_req_queue(&dev->ep[UDC_EP0IN_IX]);
+		ep_init(dev->regs, &dev->ep[UDC_EP0IN_IX]);
+
+		/* link up all endpoints */
+		udc_setup_endpoints(dev);
+		if (dev->gadget.speed == USB_SPEED_HIGH)
+			INFO("Connect: Speed = HIGH_SPEED\n");
+		else if (dev->gadget.speed == USB_SPEED_FULL)
+			INFO("Connect: Speed = FULL_SPEED\n");
+
+		/* init ep 0 */
+		activate_control_endpoints(dev);
+
+		/* enable ep0 interrupts */
+		udc_enable_ep0_interrupts(dev);
+	}
+
+	return ret_val;
+}
+
+static irqreturn_t udc_irq(int irq, void *pdev)
+{
+	struct udc *dev = pdev;
+	u32 reg;
+	u16 i;
+	u32 ep_irq;
+
+	/* If UDC is suspended, then don't touch any register, otherwise
+	   system hangs in endless retry => possibly hang !!! */
+	if (dev->otg_driver && dev->otg_driver->query) {
+		if (dev->otg_driver->query(0) & OTG_FLAGS_UDC_SUSP)
+			return IRQ_HANDLED;
+	} else {
+		return IRQ_HANDLED;
+	}
+
+	if (dev->sys_suspended)
+		return IRQ_HANDLED;
+
+	spin_lock(&dev->lock);
+
+	/* check for ep irq */
+	reg = ioread32(&dev->regs->ep_irqsts);
+	if (reg) {
+		/* EP0 OUT */
+		if (reg & UDC_BIT(UDC_EPINT_OUT_EP0))
+			udc_control_out_isr(dev);
+
+		if (reg & UDC_BIT(UDC_EPINT_IN_EP0))
+			udc_control_in_isr(dev);
+
+		/* data endpoint */
+		/* iterate ep's */
+		for (i = 1; i < UDC_EP_NUM; i++) {
+			ep_irq = 1 << i;
+			/* irq for out ep ? */
+			if ((reg & ep_irq) && i > UDC_EPIN_NUM) {
+				/* clear irq */
+				iowrite32(ep_irq, &dev->regs->ep_irqsts);
+				udc_data_out_isr(dev, i);
+			} /* irq for in ep ? */
+			if ((reg & ep_irq) && i < UDC_EPIN_NUM && i > 0) {
+				/* clear irq */
+				iowrite32(ep_irq, &dev->regs->ep_irqsts);
+				udc_data_in_isr(dev, i);
+			}
+
+		}
+
+	}
+
+	/* check for dev irq */
+	reg = ioread32(&dev->regs->irqsts);
+	if (reg) {
+		/* clear irq */
+		iowrite32(reg, &dev->regs->irqsts);
+		udc_dev_isr(dev, reg);
+	}
+
+
+	spin_unlock(&dev->lock);
+	return IRQ_HANDLED;
+}
+
+/**
+ * Tears down device
+ *
+ * \param pdev        pointer to device struct
+ */
+static void gadget_release(struct device *pdev)
+{
+	struct udc *dev = dev_get_drvdata(pdev);
+	kfree(dev);
+}
+
+static void udc_remove(struct udc *dev)
+{
+	u32 tmp;
+	/* disable UDC memory, DMA and clock */
+	tmp = ioread32((u32 *) (USB_MSR_BASE + USB_MSR_MCFG));
+	tmp &= UDC_CLEAR_BIT(USBMSRMCFG_DMEMEN)
+		& UDC_CLEAR_BIT(USBMSRMCFG_DBMEN)
+		& UDC_CLEAR_BIT(USBMSRMCFG_UDCCLKEN);
+	iowrite32(tmp, (u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+
+	device_unregister(&udc->gadget.dev);
+	udc = 0;
+}
+
+static void udc_drv_remove(struct device *_dev)
+{
+	struct platform_device *pdev = to_platform_device(_dev);
+	struct udc *dev = dev_get_drvdata(_dev);
+
+#ifdef UDC_DEBUG
+	print_misc(dev);
+#endif
+	/* gadget driver registered ? */
+	if (dev->driver) {
+		WARN("unregistering %s on driver remove\n",
+				dev->driver->driver.name);
+		usb_gadget_unregister_driver(dev->driver);
+	}
+	/* otg driver registered ? */
+	if (dev->otg_transceiver) {
+		/* should have been done already by driver model core */
+		WARN("uoc driver is still registered\n");
+	}
+	/* dma pool cleanup */
+	if (dev->data_requests)
+		dma_pool_destroy(dev->data_requests);
+	if (dev->stp_requests) {
+		/* cleanup DMA desc's for ep0in */
+		dma_pool_free(dev->stp_requests,
+				dev->ep[UDC_EP0OUT_IX].td_stp,
+				dev->ep[UDC_EP0OUT_IX].td_stp_dma);
+		dma_pool_free(dev->stp_requests,
+				dev->ep[UDC_EP0OUT_IX].td,
+				dev->ep[UDC_EP0OUT_IX].td_phys);
+
+		dma_pool_destroy(dev->stp_requests);
+	}
+
+	/* init controller by soft reset */
+	iowrite32(UDC_BIT(UDC_DEVCFG_SOFTRESET), &dev->regs->cfg);
+
+	if (dev->irq_registered)
+		free_irq(pdev->resource[1].start, dev);
+	if (dev->regs)
+		iounmap(dev->regs);
+	if (dev->mem_region)
+		release_mem_region(pdev->resource[0].start,
+				pdev->resource[0].end + 1
+				- pdev->resource[0].start);
+
+	device_remove_file(&pdev->dev, &dev_attr_registers);
+	dev_set_drvdata(_dev, 0);
+	udc_remove(dev);
+}
+
+__init static int init_dma_pools(struct udc *dev)
+{
+	struct udc_stp_dma      *td_stp;
+	struct udc_data_dma     *td_data;
+	int retval;
+
+	/* consistent DMA mode setting ? */
+	if (use_dma_ppb) {
+		use_dma_bufferfill_mode = 0;
+	} else {
+		use_dma_ppb_du = 0;
+		use_dma_bufferfill_mode = 1;
+	}
+
+	/* DMA setup */
+	dev->data_requests = dma_pool_create("data_requests", NULL,
+			sizeof(struct udc_data_dma),
+			UDC_POOL_ALIGN,
+			UDC_POOL_CROSS);
+	if (!dev->data_requests) {
+		DBG("can't get request data pool\n");
+		retval = -ENOMEM;
+		goto finished;
+	}
+
+	/* EP0 in dma regs = dev control regs */
+	dev->ep[UDC_EP0IN_IX].dma = &dev->regs->ctl;
+
+	/* dma desc for setup data */
+	dev->stp_requests = dma_pool_create("setup requests", NULL,
+			sizeof(struct udc_stp_dma),
+			UDC_POOL_ALIGN,
+			UDC_POOL_CROSS);
+	if (!dev->stp_requests) {
+		DBG("can't get stp request pool\n");
+		retval = -ENOMEM;
+		goto finished;
+	}
+	/* setup */
+	td_stp = dma_pool_alloc(dev->stp_requests, UDC_POOL_GFP_STP,
+			&dev->ep[UDC_EP0OUT_IX].td_stp_dma);
+	if (td_stp == NULL) {
+		retval = -ENOMEM;
+		goto finished;
+	}
+	dev->ep[UDC_EP0OUT_IX].td_stp = td_stp;
+	/* data: 0 packets !? */
+	td_data = dma_pool_alloc(dev->stp_requests, UDC_POOL_GFP_STP,
+			&dev->ep[UDC_EP0OUT_IX].td_phys);
+	if (td_data == NULL) {
+		retval = -ENOMEM;
+		goto finished;
+	}
+	dev->ep[UDC_EP0OUT_IX].td = td_data;
+	/* point to itself */
+	dev->ep[UDC_EP0OUT_IX].td->next = dev->ep[UDC_EP0OUT_IX].td_phys;
+	return 0;
+
+finished:
+	return retval;
+}
+
+/**
+ * Called by kernel  init device context
+ */
+static int udc_drv_probe(struct device *_dev)
+{
+	char                    tmp[8];
+	struct udc              *dev;
+	struct platform_device *pdev = to_platform_device(_dev);
+	u32                     resource;
+	u32                     len;
+	u32                     irq;
+	int                     retval = 0;
+	u32                     reg;
+
+	/* basic init */
+	reg = ioread32((u32 *) (USB_MSR_BASE + USB_MSR_MCFG));
+	if (reg == 0) {
+		/* default value */
+		reg = USBMSRMCFG_DEFAULT;
+		iowrite32(reg, (u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+		ioread32((u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+		udelay(1000);
+	}
+	/* enable UDC memory, DMA, clock, cacheable memory,
+	 * read combining and prefetch enable */
+	reg |= UDC_BIT(USBMSRMCFG_DMEMEN) | UDC_BIT(USBMSRMCFG_DBMEN)
+		| UDC_BIT(USBMSRMCFG_UDCCLKEN)
+		| UDC_BIT(USBMSRMCFG_PHYPLLEN)
+#ifdef CONFIG_DMA_COHERENT
+		| UDC_BIT(USBMSRMCFG_UCAM)
+#endif
+		| UDC_BIT(USBMSRMCFG_RDCOMB)
+		| UDC_BIT(USBMSRMCFG_PFEN);
+	iowrite32(reg, (u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+
+	/* one udc only */
+	if (udc) {
+		WARN("already probed.\n");
+		return -EBUSY;
+	}
+
+	/* init */
+	dev = kmalloc(sizeof(struct udc), GFP_KERNEL);
+	if (!dev) {
+		retval = -ENOMEM;
+		goto finished;
+	}
+	memset(dev, 0, sizeof(struct udc));
+
+	dev->pdev = _dev;
+
+	/* check platform resources */
+	if (pdev->resource[0].flags != IORESOURCE_MEM) {
+		ERR("resource[0] must be IORESOURCE_MEM\n");
+		retval = -ENOMEM;
+		goto finished;
+	}
+	resource = pdev->resource[0].start;
+	len = pdev->resource[0].end + 1 - pdev->resource[0].start;
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		ERR("resource[1] must be IORESOURCE_IRQ\n");
+		retval = -ENOMEM;
+		goto finished;
+	}
+	irq = pdev->resource[1].start;
+
+	/* platform device resource allocation */
+	/* mem */
+	if (!request_mem_region(resource, len, name)) {
+		ERR("controller already in use\n");
+		retval = -EBUSY;
+		goto finished;
+	}
+	dev->mem_region = 1;
+
+	dev->virt_addr = ioremap_nocache(resource, len);
+	if (dev->virt_addr == NULL) {
+		DBG("start address cannot be mapped\n");
+		retval = -EFAULT;
+		goto finished;
+	}
+
+	/* irq */
+	if (!irq) {
+		ERR("irq not set\n");
+		retval = -ENODEV;
+		goto finished;
+	}
+	snprintf(tmp, sizeof tmp, "%d", irq);
+	if (request_irq(irq, udc_irq, IRQF_SHARED, name, dev) != 0) {
+		ERR("error on request_irq() with %s\n", tmp);
+		retval = -EBUSY;
+		goto finished;
+	}
+	dev->irq_registered = 1;
+
+	dev_set_drvdata(_dev, dev);
+
+	/* chip revision */
+	dev->chiprev = 0;
+
+	/* chip rev for Au1200 */
+	dev->chiprev = (u16) read_c0_prid() & 0xff;
+
+	/* init dma pools */
+	if (use_dma) {
+		retval = init_dma_pools(dev);
+		if (retval != 0)
+			goto finished;
+	}
+
+	dev->phys_addr = resource;
+	dev->irq = irq;
+	dev->pdev = _dev;
+	dev->gadget.dev.parent = _dev;
+	dev->gadget.dev.dma_mask = _dev->dma_mask;
+	/* general probing */
+	if (udc_probe(dev) != 0)
+		goto finished;
+	return retval;
+
+finished:
+	if (dev)
+		udc_drv_remove(_dev);
+	return retval;
+}
+
+/**
+ * general probe
+ */
+__init int udc_probe(struct udc *dev)
+{
+	char                    tmp[128];
+	u32 reg;
+	int retval;
+
+	/* device struct setup */
+	spin_lock_init(&dev->lock);
+	spin_lock_init(&udc_irq_spinlock);
+	spin_lock_init(&udc_stall_spinlock);
+	dev->gadget.ops = &udc_ops;
+
+	strcpy(dev->gadget.dev.bus_id, "gadget");
+	dev->gadget.dev.release = gadget_release;
+	dev->gadget.name = name;
+	dev->gadget.is_dualspeed = 1;
+
+	/* udc csr registers base */
+	dev->csr = (struct udc_csrs *)(dev->virt_addr + UDC_CSR_ADDR);
+	/* dev registers base */
+	dev->regs = (struct udc_regs *)(dev->virt_addr + UDC_DEVCFG_ADDR);
+	/* ep registers base */
+	dev->ep_regs = (struct udc_ep_regs *)(dev->virt_addr + UDC_EPREGS_ADDR);
+	/* fifo's base */
+	dev->rxfifo = (u32 *) (dev->virt_addr + UDC_RXFIFO_ADDR);
+	dev->txfifo = (u32 *) (dev->virt_addr + UDC_TXFIFO_ADDR);
+
+	/* init registers, interrupts, ... */
+	{
+		u32 tmp;
+
+		dev->gadget.ep0 = &dev->ep[UDC_EP0IN_IX].ep;
+		dev->ep[UDC_EP0IN_IX].halted = 0;
+		INIT_LIST_HEAD(&dev->gadget.ep0->ep_list);
+		dev->gadget.speed = USB_SPEED_HIGH;
+		make_ep_lists(dev);
+		/* basic endpoint init */
+		for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
+			struct udc_ep   *ep = &dev->ep[tmp];
+
+			ep->ep.name = ep_string[tmp];
+			ep->dev = dev;
+			ep->num = tmp;
+			/* txfifo size is calculated at enable time */
+			ep->txfifo = dev->txfifo;
+
+			/* fifo size */
+			if (tmp < UDC_EPIN_NUM) {
+				ep->fifo_depth = UDC_TXFIFO_SIZE;
+				ep->in = 1;
+			} else {
+				ep->fifo_depth = UDC_RXFIFO_SIZE;
+				ep->in = 0;
+
+			}
+
+			ep->regs = &dev->ep_regs[tmp];
+			if (!ep->desc) {
+				ep->desc = 0;
+				INIT_LIST_HEAD(&ep->queue);
+
+				ep->ep.maxpacket = ~0;
+				ep->ep.ops = &udc_ep_ops;
+			}
+
+			tasklet_init(&ep->execute_tasklet,
+					udc_tasklet_execute_request,
+					(unsigned long)ep);
+					init_MUTEX(&ep->in_use);
+					init_MUTEX(&ep->in_et);
+		}
+		dev->ep[UDC_EP0IN_IX].ep.maxpacket = UDC_EP0IN_MAX_PKT_SIZE;
+		dev->ep[UDC_EP0OUT_IX].ep.maxpacket = UDC_EP0OUT_MAX_PKT_SIZE;
+	}
+
+
+	INFO("%s\n", mod_desc);
+
+	snprintf(tmp, sizeof tmp, "%d", dev->irq);
+	INFO("irq %s, mem %08lx, chip rev %02x (Au1200 %s)\n",
+			tmp, dev->phys_addr, dev->chiprev,
+			(dev->chiprev == 0) ? "AB" : "AC");
+#ifdef CONFIG_DMA_COHERENT
+	/* coherent DMA not possible with AB silicon */
+	if (dev->chiprev == UDC_AUAB_REV) {
+		ERR("Your chip revision is %s, it must be at least %s to use"
+				" coherent DMA. \nPlease change DMA_COHERENT to"
+				" DMA_NONCOHERENT in arch/mips/Kconfig and"
+				" re-compile .\n", "AB", "AC");
+		retval = -ENODEV;
+		goto finished;
+	}
+#endif
+
+#ifdef CONFIG_DMA_COHERENT
+	INFO("Compiled for coherent memory.\n");
+#endif
+#ifdef CONFIG_DMA_NONCOHERENT
+	INFO("Compiled for non-coherent memory.\n");
+#endif
+	udc = dev;
+
+	retval = device_register(&dev->gadget.dev);
+	if (retval) {
+		ERR("Failed to register gadget device\n");
+		goto finished;
+	}
+	device_create_file(&pdev->dev, &dev_attr_registers);
+
+	/* set SD */
+	reg = ioread32(&dev->regs->ctl);
+	reg |= UDC_BIT(UDC_DEVCTL_SD);
+	iowrite32(reg, &dev->regs->ctl);
+	/* print dev register info */
+	print_regs(dev);
+	return 0;
+
+finished:
+	return retval;
+}
+
+
+/**
+ *  Initiates a remote wakeup
+ *
+ * \return 0 if success
+ */
+/* initiate remote wakeup */
+static int udc_remote_wakeup(struct udc *dev)
+{
+	INFO("UDC initiates remote wakeup\n");
+
+	UDC_SET_BIT(UDC_DEVCTL_RES, &dev->regs->ctl);
+	UDC_UNSET_BIT(UDC_DEVCTL_RES, &dev->regs->ctl);
+
+	return 0;
+}
+
+/**
+ *  Suspends UDC
+ */
+static int udc_suspend(struct udc *dev)
+{
+	int retval = 0;
+
+	u32 tmp;
+	INFO("UDC suspend\n");
+	/* mask interrupts */
+	udc_mask_unused_interrupts(dev);
+
+	if (dev->driver && dev->driver->disconnect) {
+		/* call gadget to reset context */
+		if (spin_is_locked(&dev->lock)) {
+			spin_unlock(&dev->lock);
+			dev->driver->disconnect(&dev->gadget);
+			spin_lock(&dev->lock);
+		} else
+			dev->driver->disconnect(&dev->gadget);
+
+		/* disable ep0 to empty req queue */
+		empty_req_queue(&dev->ep[UDC_EP0IN_IX]);
+		ep_init(dev->regs,
+				&dev->ep[UDC_EP0IN_IX]);
+
+		/* init controller by soft reset */
+		udc_soft_reset(dev);
+
+	}
+	if (dev->otg_driver && dev->otg_transceiver
+			&& dev->otg_transceiver->set_peripheral) {
+		/* if UDC is supended by Host or already disconnected then
+		   don't force disconnect by unbind() */
+		if (dev->otg_driver->query) {
+			if (!(dev->otg_driver->query(0) & OTG_FLAGS_UDC_SUSP)) {
+				/* unbind from otg driver -> host disconnect */
+				dev->otg_transceiver->set_peripheral(
+						dev->otg_transceiver, NULL);
+				dev->connected = 0;
+			}
+		} else {
+			/* unbind from otg driver -> host disconnect */
+			dev->otg_transceiver->set_peripheral(
+					dev->otg_transceiver, NULL);
+			dev->connected = 0;
+		}
+	}
+
+	dev->sys_suspended = 1;
+
+	/* switch off UDC clock */
+			tmp = ioread32((u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+			tmp &= UDC_CLEAR_BIT(USBMSRMCFG_UDCCLKEN);
+			iowrite32(tmp, (u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+
+	return retval;
+}
+
+static int udc_resume(struct udc *dev)
+{
+	int retval = 0;
+
+	u32 tmp;
+	INFO("UDC resume\n");
+	/* switch on UDC clock */
+	tmp = ioread32((u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+	tmp |= UDC_BIT(USBMSRMCFG_UDCCLKEN);
+	iowrite32(tmp, (u32 *)(USB_MSR_BASE + USB_MSR_MCFG));
+
+	dev->sys_suspended = 0;
+
+	usb_connect(dev);
+	if (dev->otg_transceiver && dev->otg_transceiver->set_peripheral) {
+		/* bind to otg driver */
+		dev->otg_transceiver->set_peripheral(dev->otg_transceiver,
+						     &dev->gadget);
+	}
+	return retval;
+}
+
+static int udc_au1xxx_drv_probe(struct device *dev)
+{
+	int retval;
+
+	DBG("udc_au1xxx_drv_probe()\n");
+	retval = udc_drv_probe(dev);
+	return retval;
+}
+
+static int udc_au1xxx_drv_remove(struct device *dev)
+{
+	DBG("udc_au1xxx_drv_remove()\n");
+	udc_drv_remove(dev);
+	return 0;
+}
+
+static int udc_au1xxx_drv_suspend(struct device *dev, pm_message_t state)
+{
+	struct udc *udc_dev = dev_get_drvdata(dev);
+	return udc_suspend(udc_dev);
+}
+
+static int udc_au1xxx_drv_resume(struct device *dev)
+{
+	struct udc *udc_dev = dev_get_drvdata(dev);
+	return udc_resume(udc_dev);
+}
+
+static struct device_driver udc_au1xxx_driver = {
+	.name		= "au1xxx-udc",
+	.bus		= &platform_bus_type,
+	.probe		= udc_au1xxx_drv_probe,
+	.remove		= udc_au1xxx_drv_remove,
+	.suspend	= udc_au1xxx_drv_suspend,
+	.resume	    = udc_au1xxx_drv_resume,
+};
+
+
+static int __init init(void)
+{
+	int rc;
+
+	/* probe by device system */
+	rc = driver_register(&udc_au1xxx_driver);
+
+	return rc;
+}
+module_init(init);
+
+static void __exit cleanup(void)
+{
+	/* unregister at device system */
+	driver_unregister(&udc_au1xxx_driver);
+
+}
+module_exit(cleanup);
+
diff --git a/drivers/usb/gadget/au1200_udc.h b/drivers/usb/gadget/au1200_udc.h
new file mode 100644
index 0000000..2a4f7bf
--- /dev/null
+++ b/drivers/usb/gadget/au1200_udc.h
@@ -0,0 +1,816 @@
+/*
+ * Header for driver for RMI Au1200 UDC high/full speed USB device controller
+ */
+/*
+ * Copyright (C) 2008 RMI Corporation (http://www.rmicorp.com)
+ * Author: Kevin Hickey (khickey@rmicorp.com)
+ *
+ * Adapted from the AMD5536 UDC module.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef AU1200UDC_H
+#define AU1200UDC_H
+
+/*****************************************************************************
+ *  Constants
+ *****************************************************************************/
+
+/* Driver  constants -------------------------------------------------------*/
+#define DRIVER_NAME_FOR_PRINT "au1200_udc"
+
+/* Platform specific -------------------------------------------------------*/
+#define UDC_POOL_ALIGN       32
+#define UDC_POOL_CROSS       4096
+#define UDC_POOL_GFP_STP     (GFP_ATOMIC | GFP_DMA)
+
+#ifndef USBMSRMCFG_UCAM
+#define USBMSRMCFG_UCAM           7
+#endif
+#define USBMSRMCFG_DEFAULT        0x00d02000
+
+/* Au1200 rev. */
+#define UDC_AUAB_REV 0
+#define UDC_AUAC_REV 1
+#define UDC_AUA0 0
+
+/* Global CSR's -------------------------------------------------------------*/
+/* UDC CSR's */
+#define UDC_CSR_ADDR                            0x500
+
+/* EP NE bits */
+/* EP number */
+#define UDC_CSR_NE_NUM_MASK                     0x0000000f
+#define UDC_CSR_NE_NUM_OFS                      0
+/* EP direction */
+#define UDC_CSR_NE_DIR_MASK                     0x00000010
+#define UDC_CSR_NE_DIR_OFS                      4
+/* EP type */
+#define UDC_CSR_NE_TYPE_MASK                    0x00000060
+#define UDC_CSR_NE_TYPE_OFS                     5
+/* EP config number */
+#define UDC_CSR_NE_CFG_MASK                     0x00000780
+#define UDC_CSR_NE_CFG_OFS                      7
+/* EP interface number */
+#define UDC_CSR_NE_INTF_MASK                    0x00007800
+#define UDC_CSR_NE_INTF_OFS                     11
+/* EP alt setting */
+#define UDC_CSR_NE_ALT_MASK                     0x00078000
+#define UDC_CSR_NE_ALT_OFS                      15
+
+/* max pkt */
+#define UDC_CSR_NE_MAX_PKT_MASK                 0x3ff80000
+#define UDC_CSR_NE_MAX_PKT_OFS                  19
+
+/* Device Config Register ---------------------------------------------------*/
+#define UDC_DEVCFG_ADDR                         0x400
+
+#define UDC_DEVCFG_SOFTRESET                    31
+#define UDC_DEVCFG_HNPSFEN                      30
+#define UDC_DEVCFG_DMARST                       29
+#define UDC_DEVCFG_SET_DESC                     18
+#define UDC_DEVCFG_CSR_PRG                      17
+#define UDC_DEVCFG_STATUS                       7
+#define UDC_DEVCFG_DIR                          6
+#define UDC_DEVCFG_PI                           5
+#define UDC_DEVCFG_SS                           4
+#define UDC_DEVCFG_SP                           3
+#define UDC_DEVCFG_RWKP                         2
+
+#define UDC_DEVCFG_SPD_MASK                     0x3
+#define UDC_DEVCFG_SPD_OFS                      0
+#define UDC_DEVCFG_SPD_HS                       0x0
+#define UDC_DEVCFG_SPD_FS                       0x1
+#define UDC_DEVCFG_SPD_LS                       0x2
+/*#define UDC_DEVCFG_SPD_FS                     0x3*/
+
+
+/* Device Control Register --------------------------------------------------*/
+#define UDC_DEVCTL_ADDR                         0x404
+
+#define UDC_DEVCTL_THLEN_MASK                   0xff000000
+#define UDC_DEVCTL_THLEN_OFS                    24
+
+#define UDC_DEVCTL_BRLEN_MASK                   0x00ff0000
+#define UDC_DEVCTL_BRLEN_OFS                    16
+
+#define UDC_DEVCTL_CSR_DONE                     13
+#define UDC_DEVCTL_DEVNAK                       12
+#define UDC_DEVCTL_SD                           10
+#define UDC_DEVCTL_MODE                         9
+#define UDC_DEVCTL_BREN                         8
+#define UDC_DEVCTL_THE                          7
+#define UDC_DEVCTL_BF                           6
+#define UDC_DEVCTL_BE                           5
+#define UDC_DEVCTL_DU                           4
+#define UDC_DEVCTL_TDE                          3
+#define UDC_DEVCTL_RDE                          2
+#define UDC_DEVCTL_RES                          0
+
+
+/* Device Status Register ---------------------------------------------------*/
+#define UDC_DEVSTS_ADDR                         0x408
+
+#define UDC_DEVSTS_TS_MASK                      0xfffc0000
+#define UDC_DEVSTS_TS_OFS                       18
+
+#define UDC_DEVSTS_SESSVLD                      17
+#define UDC_DEVSTS_PHY_ERROR                    16
+#define UDC_DEVSTS_RXFIFO_EMPTY                 15
+
+#define UDC_DEVSTS_ENUM_SPEED_MASK              0x00006000
+#define UDC_DEVSTS_ENUM_SPEED_OFS               13
+#define UDC_DEVSTS_ENUM_SPEED_FULL              1
+#define UDC_DEVSTS_ENUM_SPEED_HIGH              0
+
+#define UDC_DEVSTS_SUSP                         12
+
+#define UDC_DEVSTS_ALT_MASK                     0x00000f00
+#define UDC_DEVSTS_ALT_OFS                      8
+
+#define UDC_DEVSTS_INTF_MASK                    0x000000f0
+#define UDC_DEVSTS_INTF_OFS                     4
+
+#define UDC_DEVSTS_CFG_MASK                     0x0000000f
+#define UDC_DEVSTS_CFG_OFS                      0
+
+
+/* Device Interrupt Register ------------------------------------------------*/
+#define UDC_DEVINT_ADDR                         0x40c
+
+#define UDC_DEVINT_ENUM                         6
+#define UDC_DEVINT_SOF                          5
+#define UDC_DEVINT_US                           4
+#define UDC_DEVINT_UR                           3
+#define UDC_DEVINT_ES                           2
+#define UDC_DEVINT_SI                           1
+#define UDC_DEVINT_SC                           0
+
+/* Device Interrupt Mask Register -------------------------------------------*/
+#define UDC_DEVINT_MSK_ADDR                     0x410
+
+#define UDC_DEVINT_MSK                          0x3f
+
+/* Endpoint Interrupt Register ----------------------------------------------*/
+#define UDC_EPINT_ADDR                          0x414
+
+#define UDC_EPINT_OUT_MASK                      0xffff0000
+#define UDC_EPINT_OUT_OFS                       16
+#define UDC_EPINT_IN_MASK                       0x0000ffff
+#define UDC_EPINT_IN_OFS                        0
+
+#define UDC_EPINT_IN_EP0                        0
+#define UDC_EPINT_IN_EP1                        1
+#define UDC_EPINT_IN_EP2                        2
+#define UDC_EPINT_IN_EP3                        3
+#define UDC_EPINT_OUT_EP0                       16
+#define UDC_EPINT_OUT_EP1                       17
+#define UDC_EPINT_OUT_EP2                       18
+#define UDC_EPINT_OUT_EP3                       19
+
+#define UDC_EPINT_EP0_ENABLE_MSK                0x001e001e
+
+/* Endpoint Interrupt Mask Register -----------------------------------------*/
+#define UDC_EPINT_MSK_ADDR                      0x418
+
+#define UDC_EPINT_OUT_MSK_MASK                  0xffff0000
+#define UDC_EPINT_OUT_MSK_OFS                   16
+#define UDC_EPINT_IN_MSK_MASK                   0x0000ffff
+#define UDC_EPINT_IN_MSK_OFS                    0
+
+#define UDC_EPINT_MSK_DISABLE_ALL               (UDC_EPINT_OUT_MASK |\
+						 UDC_EPINT_IN_MASK)
+/* mask non-EP0 endpoints */
+#define UDC_EPDATAINT_MSK_DISABLE               0xfffefffe
+/* mask all dev interrupts */
+#define UDC_DEV_MSK_DISABLE                     0x7f
+
+/* Endpoint-specific CSR's --------------------------------------------------*/
+/* Endpoint Control Registers -----------------------------------------------*/
+#define UDC_EPREGS_ADDR                         0x0
+#define UDC_EPIN_REGS_ADDR                      0x0
+#define UDC_EPOUT_REGS_ADDR                     0x200
+
+#define UDC_EPCTL_ADDR                          0x0
+
+#define UDC_EPCTL_RRDY                          9
+#define UDC_EPCTL_CNAK                          8
+#define UDC_EPCTL_SNAK                          7
+#define UDC_EPCTL_NAK                           6
+
+#define UDC_EPCTL_ET_MASK                       0x00000030
+#define UDC_EPCTL_ET_OFS                        4
+#define UDC_EPCTL_ET_CONTROL                    0
+#define UDC_EPCTL_ET_ISO                        1
+#define UDC_EPCTL_ET_BULK                       2
+#define UDC_EPCTL_ET_INTERRUPT                  3
+
+#define UDC_EPCTL_P                             3
+#define UDC_EPCTL_SN                            2
+#define UDC_EPCTL_F                             1
+#define UDC_EPCTL_S                             0
+
+/* Endpoint Status Registers ------------------------------------------------*/
+#define UDC_EPSTS_ADDR                          0x4
+
+#define UDC_EPSTS_RX_PKT_SIZE_MASK              0x007ff800
+#define UDC_EPSTS_RX_PKT_SIZE_OFS               11
+
+#define UDC_EPSTS_TDC                           10
+#define UDC_EPSTS_HE                            9
+#define UDC_EPSTS_BNA                           7
+#define UDC_EPSTS_IN                            6
+
+#define UDC_EPSTS_OUT_MASK                      0x00000030
+#define UDC_EPSTS_OUT_OFS                       4
+#define UDC_EPSTS_OUT_DATA                      1
+#define UDC_EPSTS_OUT_DATA_CLEAR                0x10
+#define UDC_EPSTS_OUT_SETUP                     2
+#define UDC_EPSTS_OUT_SETUP_CLEAR               0x20
+#define UDC_EPSTS_OUT_CLEAR                     0x30
+
+/* Endpoint Buffer Size IN/ Receive Packet Frame Number OUT  Registers ------*/
+#define UDC_EPIN_BUFF_SIZE_ADDR                 0x8
+#define UDC_EPOUT_FRAME_NUMBER_ADDR             0x8
+
+#define UDC_EPIN_BUFF_SIZE_MASK                 0x0000ffff
+#define UDC_EPIN_BUFF_SIZE_OFS                  0
+/*  EP0in txfifo = 128 bytes*/
+#define UDC_EPIN0_BUFF_SIZE                     32
+/*  EP0in fullspeed txfifo = 128 bytes*/
+#define UDC_FS_EPIN0_BUFF_SIZE                  32
+
+/* fifo size mult = fifo size / max packet */
+#define UDC_EPIN_BUFF_SIZE_MULT                 2
+
+/* EPin data fifo size = 1024 bytes DOUBLE BUFFERING */
+#define UDC_EPIN_BUFF_SIZE                      256
+/* EPin small INT data fifo size = 128 bytes */
+#define UDC_EPIN_SMALLINT_BUFF_SIZE             32
+
+/* EPin fullspeed data fifo size = 128 bytes DOUBLE BUFFERING */
+#define UDC_FS_EPIN_BUFF_SIZE                   32
+
+#define UDC_EPOUT_FRAME_NUMBER_MASK             0x0000ffff
+#define UDC_EPOUT_FRAME_NUMBER_OFS              0
+
+/* Endpoint Buffer Size OUT/Max Packet Size Registers -----------------------*/
+#define UDC_EPOUT_BUFF_SIZE_ADDR                0x0c
+#define UDC_EP_MAX_PKT_SIZE_ADDR                0x0c
+
+#define UDC_EPOUT_BUFF_SIZE_MASK                0xffff0000
+#define UDC_EPOUT_BUFF_SIZE_OFS                 16
+#define UDC_EP_MAX_PKT_SIZE_MASK                0x0000ffff
+#define UDC_EP_MAX_PKT_SIZE_OFS                 0
+/* EP0in max packet size = 64 bytes */
+#define UDC_EP0IN_MAX_PKT_SIZE                  64
+/* EP0out max packet size = 64 bytes */
+#define UDC_EP0OUT_MAX_PKT_SIZE                 64
+/* EP0in fullspeed max packet size = 64 bytes */
+#define UDC_FS_EP0IN_MAX_PKT_SIZE               64
+/* EP0out fullspeed max packet size = 64 bytes */
+#define UDC_FS_EP0OUT_MAX_PKT_SIZE              64
+
+/* Endpoint dma descriptors ------------------------------------------------*/
+/* Setup data */
+/* Status dword */
+#define UDC_DMA_STP_STS_CFG_MASK                0x0fff0000
+#define UDC_DMA_STP_STS_CFG_OFS                 16
+#define UDC_DMA_STP_STS_CFG_ALT_MASK            0x000f0000
+#define UDC_DMA_STP_STS_CFG_ALT_OFS             16
+#define UDC_DMA_STP_STS_CFG_INTF_MASK           0x00f00000
+#define UDC_DMA_STP_STS_CFG_INTF_OFS            20
+#define UDC_DMA_STP_STS_CFG_NUM_MASK            0x0f000000
+#define UDC_DMA_STP_STS_CFG_NUM_OFS             24
+#define UDC_DMA_STP_STS_RX_MASK                 0x30000000
+#define UDC_DMA_STP_STS_RX_OFS                  28
+#define UDC_DMA_STP_STS_BS_MASK                 0xc0000000
+#define UDC_DMA_STP_STS_BS_OFS                  30
+#define UDC_DMA_STP_STS_BS_HOST_READY           0
+#define UDC_DMA_STP_STS_BS_DMA_BUSY             1
+#define UDC_DMA_STP_STS_BS_DMA_DONE             2
+#define UDC_DMA_STP_STS_BS_HOST_BUSY            3
+/* IN data */
+/* Status dword */
+#define UDC_DMA_IN_STS_TXBYTES_MASK            0x0000ffff
+#define UDC_DMA_IN_STS_TXBYTES_OFS             0
+#define UDC_DMA_IN_STS_FRAMENUM_MASK           0x07ff0000
+#define UDC_DMA_IN_STS_FRAMENUM_OFS            0
+#define UDC_DMA_IN_STS_L                       27
+#define UDC_DMA_IN_STS_TX_MASK                 0x30000000
+#define UDC_DMA_IN_STS_TX_OFS                  28
+#define UDC_DMA_IN_STS_BS_MASK                 0xc0000000
+#define UDC_DMA_IN_STS_BS_OFS                  30
+#define UDC_DMA_IN_STS_BS_HOST_READY           0
+#define UDC_DMA_IN_STS_BS_DMA_BUSY             1
+#define UDC_DMA_IN_STS_BS_DMA_DONE             2
+#define UDC_DMA_IN_STS_BS_HOST_BUSY            3
+/* OUT data */
+/* Status dword */
+#define UDC_DMA_OUT_STS_RXBYTES_MASK            0x0000ffff
+#define UDC_DMA_OUT_STS_RXBYTES_OFS             0
+#define UDC_DMA_OUT_STS_FRAMENUM_MASK           0x07ff0000
+#define UDC_DMA_OUT_STS_FRAMENUM_OFS            0
+#define UDC_DMA_OUT_STS_L                       27
+#define UDC_DMA_OUT_STS_RX_MASK                 0x30000000
+#define UDC_DMA_OUT_STS_RX_OFS                  28
+#define UDC_DMA_OUT_STS_BS_MASK                 0xc0000000
+#define UDC_DMA_OUT_STS_BS_OFS                  30
+#define UDC_DMA_OUT_STS_BS_HOST_READY           0
+#define UDC_DMA_OUT_STS_BS_DMA_BUSY             1
+#define UDC_DMA_OUT_STS_BS_DMA_DONE             2
+#define UDC_DMA_OUT_STS_BS_HOST_BUSY            3
+/* other constants */
+/* max ep0in packet */
+#define UDC_EP0IN_MAXPACKET                     1000
+/* max dma packet */
+#define UDC_DMA_MAXPACKET                       65536
+/* DMA buffer len for temp request, should be the same as the upper
+   layer gadget is using */
+#define UDC_DMA_TEMP_BUFFER_LEN                 4096
+/* un-usable DMA address */
+#define DMA_DONT_USE                           (~(dma_addr_t)0)
+
+/* other Endpoint register addresses and values-----------------------------*/
+#define UDC_EP_SUBPTR_ADDR                      0x10
+#define UDC_EP_DESPTR_ADDR                      0x14
+#define UDC_EP_WRITE_CONFIRM_ADDR               0x1c
+
+/* EP number as layouted in AHB space */
+#define UDC_EP_NUM                              32
+#define UDC_EPIN_NUM                            16
+#define UDC_EPIN_NUM_USED                       5
+#define UDC_EPOUT_NUM                           16
+/* EP number of EP's really used = EP0 + 8 data EP's */
+#define UDC_USED_EP_NUM                         9
+/* UDC CSR regs are aligned but AHB regs not - offset for OUT EP's */
+#define UDC_CSR_EP_OUT_IX_OFS                   12
+
+#define UDC_EP0OUT_IX                           16
+#define UDC_EP0IN_IX                            0
+
+/* max packet */
+#define UDC_HS_BULK_MAXPKT                      512
+
+/* Rx fifo address and size = 1k -------------------------------------------*/
+#define UDC_RXFIFO_ADDR                         0x800
+#define UDC_RXFIFO_SIZE                         0x400
+
+/* Tx fifo address and size = 1.5k -----------------------------------------*/
+#define UDC_TXFIFO_ADDR                         0xc00
+#define UDC_TXFIFO_SIZE                         0x600
+
+/* default data endpoints --------------------------------------------------*/
+#define UDC_EPIN_STATUS_IX                      1
+#define UDC_EPIN_IX                             2
+#define UDC_EPOUT_IX                            18
+
+/* general constants -------------------------------------------------------*/
+#define UDC_DWORD_BYTES                         4
+#define UDC_BITS_PER_BYTE_SHIFT                 3
+#define UDC_BYTE_MASK                           0xff
+#define UDC_BITS_PER_BYTE                       8
+
+/* char device constants ---------------------------------------------------*/
+/* names */
+#ifdef UDC_DEBUG
+#ifdef UDC_DRIVER_NAME
+#define UDC_DEVICE_NAME UDC_DRIVER_NAME
+#else
+#define UDC_DEVICE_NAME "amd5536udc"
+#endif
+#define UDC_DEVICE_FILE_NAME "amd5536udc_dev"
+#define UDC_DEVICE_FILE_INODE "/dev/amd5536udc_dev"
+/* major number */
+#define UDC_MAJOR_NUM   240
+#endif
+
+#ifdef __KERNEL__
+/* kernel wrappers */
+#define device_create_file(x, y) do {} while (0)
+#define device_remove_file device_create_file
+
+#ifndef WARN_ON
+#define WARN_ON(a) do {} while (0)
+#endif
+
+#ifndef BUG_ON
+#define BUG_ON(cond)do {if (unlikely((cond) != 0)) BUG(); } while (0)
+#endif
+
+#ifndef likely
+#define likely(a) (a)
+#define unlikely(a) (a)
+#endif
+
+#ifndef container_of
+#define container_of list_entry
+#endif
+
+#endif
+
+/* MIPS specific -----------------------------------------------------------*/
+
+/*****************************************************************************
+ * Includes
+ *****************************************************************************/
+#include "au1200_otg.h"
+
+/*****************************************************************************
+ *  Types
+ *****************************************************************************/
+
+/* UDC CSR's */
+struct udc_csrs {
+
+	/* sca - setup command address */
+	u32 sca;
+
+	/* ep ne's */
+	u32 ne[UDC_USED_EP_NUM];
+} __attribute__ ((packed));
+
+/* AHB subsystem CSR registers */
+struct udc_regs {
+
+	/* device configuration */
+	u32 cfg;
+
+	/* device control */
+	u32 ctl;
+
+	/* device status */
+	u32 sts;
+
+	/* device interrupt */
+	u32 irqsts;
+
+	/* device interrupt mask */
+	u32 irqmsk;
+
+	/* endpoint interrupt  */
+	u32 ep_irqsts;
+
+	/* endpoint interrupt mask */
+	u32 ep_irqmsk;
+} __attribute__ ((packed));
+
+/* endpoint specific registers */
+struct udc_ep_regs {
+
+	/* endpoint control */
+	u32 ctl;
+
+	/* endpoint status */
+	u32 sts;
+
+	/* endpoint buffer size in/ receive packet frame number out  */
+	u32 bufin_framenum;
+
+	/* endpoint buffer size out/max packet size */
+	u32 bufout_maxpkt;
+
+	/* endpoint setup buffer pointer */
+	u32 subptr;
+
+	/* endpoint data descriptor pointer */
+	u32 desptr;
+
+	/* reserverd */
+	u32 reserved;
+
+	/* write/read confirmation */
+	u32 confirm;
+
+}  __attribute__ ((packed));
+
+#ifdef __KERNEL__
+/* control data DMA desc */
+struct udc_stp_dma {
+	/* status quadlet */
+	u32     status;
+	/* reserved */
+	u32     _reserved;
+	/* first setup word */
+	u32     data12;
+	/* second setup word */
+	u32     data34;
+} __attribute__((aligned(16)));
+
+/* normal data DMA desc */
+struct udc_data_dma {
+	/* status quadlet */
+	u32     status;
+	/* reserved */
+	u32     _reserved;
+	/* buffer pointer */
+	u32     bufptr;
+	/* next descriptor pointer */
+	u32     next;
+} __attribute__((aligned(16)));
+
+/* request packet */
+struct udc_request {
+	/* embedded gadget ep */
+	struct usb_request                  req;
+
+	/* flags */
+	unsigned                            dma_going:1,
+					    dma_done : 1;
+	/* phys. address */
+	dma_addr_t                          td_phys;
+	/* first dma desc. of chain */
+	struct udc_data_dma                 *td_data;
+
+	struct list_head                    queue;
+
+	/* chain length */
+	unsigned                            chain_len;
+	int				    serial_number;
+	bool				    ready_for_p_bit;
+
+};
+
+/* UDC specific endpoint parameters */
+struct udc_ep {
+	struct usb_ep                       ep;
+	struct udc_ep_regs                  *regs;
+	u32                                 *txfifo;
+	u32                                 *dma;
+	dma_addr_t                          td_phys;
+	dma_addr_t                          td_stp_dma;
+	struct udc_stp_dma                  *td_stp;
+	struct udc_data_dma                 *td;
+	/* temp request */
+	struct udc_request                  *req;
+	unsigned                            req_used;
+	unsigned                            req_completed;
+
+	/* NAK state */
+	unsigned                            naking;
+	struct tasklet_struct			execute_tasklet;
+	struct semaphore				in_use;
+	struct semaphore				in_et;
+
+	struct udc                          *dev;
+
+	/* queue for requests */
+	struct list_head                        queue;
+	const struct usb_endpoint_descriptor    *desc;
+	unsigned                                halted;
+	unsigned                                num:5,
+						fifo_depth : 14,
+						in : 1;
+};
+
+/* device struct */
+struct udc {
+	struct usb_gadget               gadget;
+	spinlock_t                      lock;
+	/* all endpoints */
+	struct udc_ep                   ep[UDC_EP_NUM];
+	struct usb_gadget_driver        *driver;
+	struct otg_transceiver          *otg_transceiver;
+	struct usb_otg_gadget_extension *otg_driver;
+	/* operational flags */
+	unsigned                        active:1,
+					waiting_zlp_ack_ep0in : 1,
+					set_cfg_not_acked : 1,
+					irq_registered : 1,
+					otg_supported : 1,
+					data_ep_enabled : 1,
+					data_ep_queued : 1,
+					mem_region : 1,
+					selfpowered : 1,
+					sys_suspended : 1,
+					connected;
+
+	u16                             chiprev;
+
+	/* registers */
+	struct device                   *pdev;
+	struct udc_csrs                 *csr;
+	struct udc_regs                 *regs;
+	struct udc_ep_regs              *ep_regs;
+	u32                             *rxfifo;
+	u32                             *txfifo;
+
+	/* DMA desc pools */
+	struct dma_pool                 *data_requests;
+	struct dma_pool                 *stp_requests;
+
+	/* device data */
+	unsigned long                   phys_addr;
+	void                            *virt_addr;
+	unsigned                        irq;
+
+	/* states */
+	u16                             cur_config;
+	u16                             cur_intf;
+	u16                             cur_alt;
+};
+
+/* setup request data */
+union udc_setup_data {
+	u32                        data[2];
+	struct usb_ctrlrequest     request;
+};
+#endif /*__KERNEL__*/
+
+/*****************************************************************************
+ *  Macros
+ *****************************************************************************/
+
+/***************************************
+ * SET and GET bitfields in u32 values
+ * via constants for mask/offset:
+ * <bit_field_stub_name> is the text between
+ * UDC_ and _MASK|_OFS of appropiate
+ * constant
+ ****************************************/
+/* set bitfield value in u32 u32Val */
+#define UDC_ADDBITS(u32Val, bitfield_val, bitfield_stub_name)\
+	(((u32Val) & (((u32) ~((u32) bitfield_stub_name##_MASK))))\
+	 |(((bitfield_val) << ((u32) bitfield_stub_name##_OFS))\
+		 & ((u32) bitfield_stub_name##_MASK)))
+
+/* set bitfield value in zero-initialized u32 u32Val */
+/* => bitfield bits in u32Val are all zero */
+#define UDC_INIT_SETBITS(u32Val, bitfield_val, bitfield_stub_name)\
+	((u32Val)\
+	 |(((bitfield_val) << ((u32) bitfield_stub_name##_OFS))\
+		 &((u32) bitfield_stub_name##_MASK)))
+
+/* get bitfield value from u32 u32Val */
+#define UDC_GETBITS(u32Val, bitfield_stub_name)\
+	((u32Val & ((u32) bitfield_stub_name##_MASK))\
+	 >> ((u32) bitfield_stub_name##_OFS))
+
+/* SET and GET bits in u32 values ------------------------------------------*/
+#define UDC_BIT(bit_stub_name) (1 << bit_stub_name)
+#define UDC_UNMASK_BIT(bit_stub_name) (~UDC_BIT(bit_stub_name))
+#define UDC_CLEAR_BIT(bit_stub_name) (~UDC_BIT(bit_stub_name))
+
+#define UDC_SET_BIT(bit_number, register_address)			\
+	do {								\
+		iowrite32(ioread32((register_address)) | (1 << bit_number),\
+				(register_address));			\
+		au_sync();						\
+	} while (0)
+
+/* Note that this takes a set of bits and does not shift them */
+#define	UDC_SET_BITS(bits_to_set, register_address)			\
+	do {								\
+		iowrite32(ioread32((register_address)) | (bits_to_set),	\
+				(register_address));			\
+		au_sync();						\
+	} while (0)
+
+#define UDC_UNSET_BIT(bit_number, register_address)			\
+	do {								\
+		iowrite32(ioread32((register_address)) & ~(1 << bit_number),\
+				(register_address)); 			\
+		au_sync();						\
+	} while (0)
+
+/* misc --------------------------------------------------------------------*/
+#define        DIR_STRING(bAddress) (((bAddress) & USB_DIR_IN) ? "in" : "out")
+
+/* print macros ------------------------------------------------------------*/
+
+#ifdef UDC_VERBOSE
+#ifndef UDC_DEBUG
+#define UDC_DEBUG
+#endif
+#endif
+
+/**
+ * \brief
+ * Macro for printing information in drivers
+ *
+ * This macro is used for printing kernel messages in driver source code.
+ * It should be used for printing useful information about states and called
+ * functions for normal operation (not for errors and warnings).
+ *
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#define INFO(args...) \
+	printk(KERN_INFO DRIVER_NAME_FOR_PRINT ": " args)
+
+/**
+ * \brief
+ * Macro for printing warnings in drivers
+ *
+ * This macro is used for printing kernel messages in driver source code.
+ * It should be used for printing warnings.
+ *
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#ifdef WARN
+#undef WARN
+#endif
+#define WARN(args...) \
+	printk(KERN_WARNING DRIVER_NAME_FOR_PRINT " warning: " args)
+
+/**
+ * \brief
+ * Macro for printing errors in drivers
+ *
+ * This macro is used for printing kernel messages in driver source code.
+ * It should be used for printing errors.
+ *
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#define ERR(args...) \
+	printk(KERN_ERR DRIVER_NAME_FOR_PRINT " error: " args)
+
+/**
+ * \brief
+ * Macro for printing debug messages in drivers
+ *
+ * This macro is used for printing kernel messages in driver source code
+ * when UDC_DEBUG is defined
+ * It should be used for printing debug messages.
+ *
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#ifdef UDC_DEBUG
+#define DBG(args...) \
+	printk(KERN_DEBUG DRIVER_NAME_FOR_PRINT " debug: " args)
+#else
+
+#define DBG(args...) \
+	do {} while (0)
+#endif
+
+/**
+ * \brief
+ * Macro for printing verbose debug messages in drivers
+ *
+ * This macro is used for printing kernel messages in driver source code
+ * when UDC_DEBUG and UDC_VERBOSE is defined
+ * It should be used for printing debug messages.
+ *
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#ifdef UDC_VERBOSE
+#define VDBG DBG
+#else
+#define VDBG(args...) \
+	do {} while (0)
+#endif
+
+/*****************************************************************************
+ *  Data
+ *****************************************************************************/
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
+/*****************************************************************************
+ *  Functions
+ *****************************************************************************/
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
+/*****************************************************************************
+ *  Inline Functions
+ *****************************************************************************/
+
+#endif /* #ifdef  AU1200UDC_H */
diff --git a/drivers/usb/gadget/au1200_uoc.h b/drivers/usb/gadget/au1200_uoc.h
new file mode 100644
index 0000000..569668a
--- /dev/null
+++ b/drivers/usb/gadget/au1200_uoc.h
@@ -0,0 +1,1021 @@
+/*
+ * Declarations and macros for the Au1200 On The Go port driver.
+ */
+
+/*
+ * Copyright (C) 2008 RMI Corporation (http://www.rmicorp.com)
+ * Author: Kevin Hickey (khickey@rmicorp.com)
+ *
+ * Adapted from earlier work by Karsten Boge
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ * EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
+ * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef AU1200_UOC_H
+#define AU1200_UOC_H
+
+
+/*****************************************************************************
+*  Config options
+*****************************************************************************/
+#ifdef VERBOSE
+#ifndef DEBUG
+#define DEBUG
+#endif
+#endif
+
+
+/*****************************************************************************
+*  Constants
+*****************************************************************************/
+
+#define OTG_DRIVER_NAME        "au1200_otg"
+#define OTG_FLAGS_ACTIV        (1<<19)   /* full OTG functionality is activ  */
+
+/**********************************
+*  Register definitions
+**********************************/
+/* capabilities */
+#define OTG_CAP_APU            (1<<15)   /* automatic pull-up enable         */
+
+/* multiplexer */
+#define OTG_MUX_DISABLE_ALL    0         /* not assigned                     */
+#define OTG_MUX_ENABLE_UHC     (2<<0)    /* assigned to host                 */
+#define OTG_MUX_ENABLE_UDC     (3<<0)    /* assigned to device               */
+#define OTG_MUX_PUEN           (1<<2)    /* pull-up enable                   */
+#define OTG_MUX_VBUSVLD        (1<<8)    /* VBus valid                       */
+
+/* status */
+#define OTG_STS_ID             (1<<0)    /* ID pin status                    */
+#define OTG_STS_VBUSVLD        (1<<1)    /* VBus valid                       */
+#define OTG_STS_SESSVLD        (1<<2)    /* Session valid                    */
+#define OTG_STS_SESSEND        (1<<3)    /* Session end                      */
+#define OTG_STS_LST            (3<<4)    /* Line state                       */
+#define OTG_STS_LST_J          (1<<4)    /* Line state                       */
+#define OTG_STS_LST_K          (2<<4)    /* Line state                       */
+#define OTG_STS_PSPD           (3<<6)    /* Port speed                       */
+#define OTG_STS_PSPD_LS        (1<<7)    /* Port speed                       */
+#define OTG_STS_PSPD_FS        (2<<7)    /* Port speed                       */
+#define OTG_STS_FSOE           (1<<8)    /* FS output enable (OHC)           */
+#define OTG_STS_PCON           (1<<9)    /* Port connected                   */
+#define OTG_STS_PSUS           (1<<10)   /* Port suspended                   */
+#define OTG_STS_TMH            (1<<11)   /* Timer halted                     */
+#define OTG_STS_HNP_EN         (1<<12)   /* HNP enabled for B-dev            */
+#define OTG_STS_HNP_SUPP       (1<<13)   /* A-host supports HNP              */
+#define OTG_STS_HNP_ALTSUPP    (1<<14)   /* A-host supports alt. HNP         */
+#define OTG_STS_HNPSTS         (OTG_STS_HNP_EN | OTG_STS_HNP_SUPP | \
+		OTG_STS_HNP_ALTSUPP)
+#define OTG_STS_OC             (1<<15)   /* over-current                     */
+#define OTG_STS_DPR            (1<<16)   /* Downstream port reset            */
+
+/* control */
+#define OTG_CTL_DISABLE_ALL    0         /* not assigned                     */
+#define OTG_CTL_ENABLE_UHC     (2<<0)    /* assigned to host                 */
+#define OTG_CTL_ENABLE_UDC     (3<<0)    /* assigned to device               */
+#define OTG_CTL_MUX_MASK       (3<<0)    /* port mux mask                    */
+#define OTG_CTL_PPWR           (1<<2)    /* port power switch                */
+#define OTG_CTL_PPO            (1<<3)    /* port power override              */
+#define OTG_CTL_CHRG           (1<<4)    /* charge VBus                      */
+#define OTG_CTL_DISCHRG        (1<<5)    /* discharge VBus                   */
+#define OTG_CTL_IDSNSEN        (1<<6)    /* ID sense enable, ID-PU           */
+#define OTG_CTL_PADEN          (1<<7)
+#define OTG_CTL_PUEN           (1<<8)    /* pull-up enable                   */
+#define OTG_CTL_DMPDEN         (1<<9)    /* pull-down enable                 */
+#define OTG_CTL_HNPSFEN        (1<<10)   /* HNP SET_FEATURE enable           */
+#define OTG_CTL_WPCS_DEAS      (2<<16)   /* deassert port connect            */
+#define OTG_CTL_WPCS_ASRT      (3<<16)   /* assert port connect              */
+#define OTG_CTL_WPSS_DEAS      (2<<18)   /* deassert port suspend            */
+#define OTG_CTL_WPSS_ASRT      (3<<18)   /* assert port suspend              */
+/* timer conditions */
+#define OTG_CTL_TMR_RLP        (1<<28)   /* timer reload policy              */
+#define OTG_CTL_TMR_ALL        (0xf<<24) /* stop timer                       */
+#define OTG_CTL_TMR_STOP       0         /* timer disabled                   */
+#define OTG_CTL_TMR_UNCOND     (1<<24)   /* count unconditionally            */
+#define OTG_CTL_TMR_SE0        (2<<24)   /* count if LSt = FS-SE0            */
+#define OTG_CTL_TMR_FSJ        (3<<24)   /* count if LSt = FS-J              */
+#define OTG_CTL_TMR_FSK        (4<<24)   /* count if LSt = FS-K              */
+#define OTG_CTL_TMR_NOSE0      (5<<24)   /* count if LSt <> FS-SE0           */
+#define OTG_CTL_TMR_NORX       (6<<24)   /* count if Rx inactiv              */
+#define OTG_CTL_TMR_ID         (7<<24)   /* count if ID = 0                  */
+
+/* interrupts */
+#define OTG_INT_GLOBAL         (1<<31)   /* global interrupt enable          */
+#define OTG_INT_ENALL          0x7fff    /* enable all                       */
+#define OTG_INT_DISALL         0         /* disable all                      */
+#define OTG_INT_IDC            (1<<0)    /* ID pin change                    */
+#define OTG_INT_VBVC           (1<<1)    /* VBUS valid change                */
+#define OTG_INT_SVC            (1<<2)    /* Session valid change             */
+#define OTG_INT_SEC            (1<<3)    /* Session end change               */
+#define OTG_INT_LSTC           (1<<4)    /* Line state change                */
+#define OTG_INT_PSPDC          (1<<5)    /* Port speed change                */
+#define OTG_INT_FSOEC          (1<<6)    /* FS/LS OE change                  */
+#define OTG_INT_HSDD           (1<<7)    /* HS disconnect detected           */
+#define OTG_INT_RXACT          (1<<8)    /* Rx activity detected             */
+#define OTG_INT_PCC            (1<<9)    /* Port connect change              */
+#define OTG_INT_PSC            (1<<10)   /* Port suspend change              */
+#define OTG_INT_TMX            (1<<11)   /* Timer expired                    */
+#define OTG_INT_HNPFC          (1<<12)   /* HNP feature change               */
+#define OTG_INT_OCD            (1<<13)   /* over current detected            */
+#define OTG_INT_DPRC           (1<<14)   /* Downstream port reset change     */
+
+#define OTG_INT_ADDS   OTG_INT_SVC
+
+/**********************************
+ *  OTG state dependend data
+ **********************************/
+
+/*
+ * generic
+ */
+#define OTG_CTL_DEFAULT                      (OTG_CTL_PADEN | \
+		OTG_CTL_IDSNSEN)
+#define OTG_CTL_HOST_DEFAULT                 (OTG_CTL_DEFAULT | \
+		OTG_CTL_ENABLE_UHC)
+#ifdef CONFIG_USB_OTG
+#define OTG_CTL_PERIPHERAL_DEFAULT           (OTG_CTL_DEFAULT | \
+		OTG_CTL_HNPSFEN | \
+		OTG_CTL_ENABLE_UDC | \
+		OTG_CTL_PPO | OTG_CTL_PUEN)
+#else
+#define OTG_CTL_PERIPHERAL_DEFAULT           (OTG_CTL_DEFAULT | \
+		OTG_CTL_ENABLE_UDC | \
+		OTG_CTL_PPO | OTG_CTL_PUEN)
+#endif
+
+#define OTG_INT_DEFAULT                      OTG_INT_IDC
+
+/*
+ * OTG_STATE_UNDEFINED
+ */
+#define OTG_STATE_UNDEFINED_CONTROL          (OTG_CTL_DEFAULT | OTG_CTL_PPO | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_UNDEFINED_STATUS           0
+#define OTG_STATE_UNDEFINED_STATUS_MASK      0
+#define OTG_STATE_UNDEFINED_INTERRUPTS       OTG_INT_TMX
+
+/*
+ * OTG_STATE_NO_B_DEVICE_A
+ */
+#define OTG_STATE_NO_B_DEVICE_A_CONTROL      OTG_CTL_HOST_DEFAULT
+#define OTG_STATE_NO_B_DEVICE_A_STATUS       0
+#define OTG_STATE_NO_B_DEVICE_A_STATUS_MASK  0
+#define OTG_STATE_NO_B_DEVICE_A_INTERRUPTS   OTG_INT_DEFAULT
+
+/*
+ * OTG_STATE_NO_B_DEVICE_B
+ */
+#define OTG_STATE_NO_B_DEVICE_B_CONTROL      (OTG_CTL_DEFAULT | OTG_CTL_PPO)
+#define OTG_STATE_NO_B_DEVICE_B_STATUS       0
+#define OTG_STATE_NO_B_DEVICE_B_STATUS_MASK  0
+#define OTG_STATE_NO_B_DEVICE_B_INTERRUPTS   OTG_INT_DEFAULT
+
+/*
+ * OTG_STATE_A_IDLE
+ */
+#define OTG_STATE_A_IDLE_CONTROL             (OTG_CTL_DEFAULT | OTG_CTL_PPO)
+#define OTG_STATE_A_IDLE_STATUS              0
+#define OTG_STATE_A_IDLE_STATUS_MASK         0
+#define OTG_STATE_A_IDLE_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC | \
+		OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_DP
+ */
+#define OTG_STATE_A_IDLE_WAIT_DP_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_DP_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_DP_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_DP_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+		OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_VP
+ */
+#define OTG_STATE_A_IDLE_WAIT_VP_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_VP_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_VP_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_VP_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+		OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_MP
+ */
+#define OTG_STATE_A_IDLE_WAIT_MP_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_MP_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_MP_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_MP_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+		OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_DV
+ */
+#define OTG_STATE_A_IDLE_WAIT_DV_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_DV_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_DV_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_DV_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+		OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_WAIT_VRISE
+ */
+#define OTG_STATE_A_WAIT_VRISE_CONTROL       (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_WAIT_VRISE_STATUS        0
+#define OTG_STATE_A_WAIT_VRISE_STATUS_MASK   0
+#define OTG_STATE_A_WAIT_VRISE_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_TMX | \
+		OTG_INT_VBVC)
+
+/*
+ * OTG_STATE_A_WAIT_BCON
+ */
+#define OTG_STATE_A_WAIT_BCON_CONTROL        OTG_CTL_HOST_DEFAULT
+#define OTG_STATE_A_WAIT_BCON_STATUS         0
+#define OTG_STATE_A_WAIT_BCON_STATUS_MASK    0
+#define OTG_STATE_A_WAIT_BCON_INTERRUPTS     (OTG_INT_DEFAULT | OTG_INT_TMX | \
+		OTG_INT_VBVC | OTG_INT_PCC)
+
+/*
+ * OTG_STATE_A_WAIT_BCON_VB
+ */
+#define OTG_STATE_A_WAIT_BCON_VB_CONTROL     (OTG_STATE_A_WAIT_BCON_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_WAIT_BCON_VB_STATUS      0
+#define OTG_STATE_A_WAIT_BCON_VB_STATUS_MASK 0
+#define OTG_STATE_A_WAIT_BCON_VB_INTERRUPTS  OTG_STATE_A_WAIT_BCON_INTERRUPTS
+
+/*
+ * OTG_STATE_A_HOST
+ */
+#define OTG_STATE_A_HOST_CONTROL             OTG_CTL_HOST_DEFAULT
+#define OTG_STATE_A_HOST_STATUS              0
+#define OTG_STATE_A_HOST_STATUS_MASK         0
+#ifdef CONFIG_USB_OTG
+#ifndef VERBOSE
+#define OTG_STATE_A_HOST_INTERRUPTS          (OTG_INT_DEFAULT | \
+		OTG_INT_VBVC | OTG_INT_DPRC | \
+		OTG_INT_PCC | OTG_INT_PSC)
+#else
+#define OTG_STATE_A_HOST_INTERRUPTS          (OTG_INT_DEFAULT | \
+		OTG_INT_VBVC | OTG_INT_DPRC | \
+		OTG_INT_PCC | OTG_INT_PSC | \
+		OTG_INT_PSPDC)
+/* OTG_INT_LSTC */
+#endif
+#else
+/* IDPIN mode only                                                   */
+#define OTG_STATE_A_HOST_INTERRUPTS          OTG_INT_IDC
+#endif
+
+/*
+ * OTG_STATE_A_SUSPEND
+ */
+#define OTG_STATE_A_SUSPEND_CONTROL          (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_SUSPEND_STATUS           0
+#define OTG_STATE_A_SUSPEND_STATUS_MASK      0
+#define OTG_STATE_A_SUSPEND_INTERRUPTS       (OTG_INT_DEFAULT | OTG_INT_TMX | \
+		OTG_INT_VBVC |  OTG_INT_DPRC | \
+		OTG_INT_PCC | OTG_INT_PSC)
+
+/*
+ * OTG_STATE_A_PERIPHERAL
+ */
+#define OTG_STATE_A_PERIPHERAL_CONTROL       (OTG_CTL_PERIPHERAL_DEFAULT | \
+		OTG_CTL_PPWR | OTG_CTL_DMPDEN)
+#define OTG_STATE_A_PERIPHERAL_STATUS        0
+#define OTG_STATE_A_PERIPHERAL_STATUS_MASK   0
+#ifndef VERBOSE
+#define OTG_STATE_A_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | \
+		OTG_INT_VBVC | OTG_INT_OCD | \
+		OTG_INT_PCC | OTG_INT_PSC)
+#else
+#define OTG_STATE_A_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | \
+		OTG_INT_VBVC | OTG_INT_OCD | \
+		OTG_INT_PCC | OTG_INT_PSC | \
+		OTG_INT_PSPDC)
+/* OTG_INT_LSTC */
+#endif
+
+/*
+ * OTG_STATE_A_VBUS_ERR
+ */
+#define OTG_STATE_A_VBUS_ERR_CONTROL         (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_PPO | OTG_CTL_DISCHRG)
+#define OTG_STATE_A_VBUS_ERR_STATUS          0
+#define OTG_STATE_A_VBUS_ERR_STATUS_MASK     0
+#define OTG_STATE_A_VBUS_ERR_INTERRUPTS      OTG_INT_DEFAULT
+
+/*
+ * OTG_STATE_A_WAIT_VFALL
+ */
+#define OTG_STATE_A_WAIT_VFALL_CONTROL       (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_PPO)
+#define OTG_STATE_A_WAIT_VFALL_STATUS        0
+#define OTG_STATE_A_WAIT_VFALL_STATUS_MASK   0
+#define OTG_STATE_A_WAIT_VFALL_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_SEC)
+
+/*
+ * OTG_STATE_A_WAIT_VFALL_DN
+ */
+#define OTG_STATE_A_WAIT_VFALL_DN_CONTROL    (OTG_STATE_A_WAIT_VFALL_CONTROL | \
+		OTG_CTL_DISCHRG)
+#define OTG_STATE_A_WAIT_VFALL_DN_STATUS      0
+#define OTG_STATE_A_WAIT_VFALL_DN_STATUS_MASK 0
+#define OTG_STATE_A_WAIT_VFALL_DN_INTERRUPTS  OTG_STATE_A_WAIT_VFALL_INTERRUPTS
+
+/*
+ * OTG_STATE_A_WAIT_BDISCON
+ */
+#define OTG_STATE_A_WAIT_BDISCON_CONTROL     (OTG_CTL_DEFAULT | \
+		OTG_CTL_PPO | OTG_CTL_PPWR | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_WAIT_BDISCON_STATUS      0
+#define OTG_STATE_A_WAIT_BDISCON_STATUS_MASK 0
+#define OTG_STATE_A_WAIT_BDISCON_INTERRUPTS  (OTG_INT_DEFAULT | OTG_INT_TMX | \
+		OTG_INT_VBVC | OTG_INT_OCD | \
+		OTG_INT_PSPDC | OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_B_IDLE
+ */
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+#define OTG_STATE_B_IDLE_CONTROL             (OTG_CTL_PERIPHERAL_DEFAULT & \
+		~((u32) (OTG_CTL_PUEN | \
+				OTG_CTL_ENABLE_UDC)))
+#define OTG_STATE_B_IDLE_STATUS              0
+#define OTG_STATE_B_IDLE_STATUS_MASK         0
+#ifdef CONFIG_USB_OTG
+#define OTG_STATE_B_IDLE_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC)
+#else
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+/* IDPIN mode                                                        */
+#define OTG_STATE_B_IDLE_INTERRUPTS          (OTG_INT_IDC | OTG_INT_SVC)
+#else
+/* gadget mode                                                       */
+#define OTG_STATE_B_IDLE_INTERRUPTS          OTG_INT_SVC
+#endif
+#endif
+
+/*
+ * OTG_STATE_B_PERIPHERAL
+ */
+#define OTG_STATE_B_PERIPHERAL_CONTROL       (OTG_CTL_PERIPHERAL_DEFAULT | \
+		OTG_CTL_DMPDEN)
+#define OTG_STATE_B_PERIPHERAL_STATUS        0
+#define OTG_STATE_B_PERIPHERAL_STATUS_MASK   0
+#ifdef CONFIG_USB_OTG
+#ifndef VERBOSE
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_SVC | \
+		OTG_INT_PCC | OTG_INT_PSC | \
+		OTG_INT_HNPFC)
+#else
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_SVC | \
+		OTG_INT_PCC | OTG_INT_PSC | \
+		OTG_INT_HNPFC | OTG_INT_PSPDC)
+/* OTG_INT_LSTC */
+#endif
+#else
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+/* IDPIN mode                                                        */
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    (OTG_INT_IDC | OTG_INT_SVC)
+#else
+/* gadget mode                                                       */
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    OTG_INT_SVC
+#endif
+#endif
+
+/*
+ * OTG_STATE_B_PERIPHERAL_WT
+ */
+#define OTG_STATE_B_PERIPHERAL_WT_CONTROL    (OTG_STATE_B_PERIPHERAL_CONTROL | \
+		OTG_CTL_PPO | OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_PERIPHERAL_WT_STATUS      0
+#define OTG_STATE_B_PERIPHERAL_WT_STATUS_MASK 0
+#define OTG_STATE_B_PERIPHERAL_WT_INTERRUPTS (OTG_STATE_B_PERIPHERAL_INTERRUPTS\
+		| OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_PERIPHERAL_DC
+ */
+#define OTG_STATE_B_PERIPHERAL_DC_CONTROL    (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_PPO | OTG_CTL_DMPDEN | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_PERIPHERAL_DC_STATUS      0
+#define OTG_STATE_B_PERIPHERAL_DC_STATUS_MASK 0
+#define OTG_STATE_B_PERIPHERAL_DC_INTERRUPTS (OTG_STATE_B_PERIPHERAL_INTERRUPTS\
+		| OTG_INT_TMX | OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_B_WAIT_ACON
+ */
+#define OTG_STATE_B_WAIT_ACON_CONTROL        (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_PPO | OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_WAIT_ACON_STATUS         0
+#define OTG_STATE_B_WAIT_ACON_STATUS_MASK    0
+#define OTG_STATE_B_WAIT_ACON_INTERRUPTS     (OTG_INT_DEFAULT | OTG_INT_SVC | \
+		OTG_INT_PCC | OTG_INT_PSC | \
+		OTG_INT_HNPFC | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_HOST
+ */
+#define OTG_STATE_B_HOST_CONTROL             (OTG_CTL_HOST_DEFAULT | \
+		OTG_CTL_PPO)
+#define OTG_STATE_B_HOST_STATUS              0
+#define OTG_STATE_B_HOST_STATUS_MASK         0
+#define OTG_STATE_B_HOST_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC | \
+		OTG_INT_PCC | OTG_INT_SVC | \
+		OTG_INT_PSPDC)
+
+/*
+ * OTG_STATE_B_HOST_WT
+ */
+#define OTG_STATE_B_HOST_WT_CONTROL          (OTG_STATE_B_HOST_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_HOST_WT_STATUS           0
+#define OTG_STATE_B_HOST_WT_STATUS_MASK      0
+#define OTG_STATE_B_HOST_WT_INTERRUPTS       (OTG_INT_DEFAULT | OTG_INT_SVC | \
+		OTG_INT_PCC | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_INIT
+ */
+#define OTG_STATE_B_SRP_INIT_CONTROL         OTG_STATE_B_IDLE_CONTROL
+#define OTG_STATE_B_SRP_INIT_STATUS          0
+#define OTG_STATE_B_SRP_INIT_STATUS_MASK     0
+#define OTG_STATE_B_SRP_INIT_INTERRUPTS      OTG_INT_DEFAULT
+
+/*
+ * OTG_STATE_B_SRP_WTSE0
+ */
+#define OTG_STATE_B_SRP_WAIT_SE0_CONTROL     (OTG_STATE_B_SRP_INIT_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_WAIT_SE0_STATUS      0
+#define OTG_STATE_B_SRP_WAIT_SE0_STATUS_MASK 0
+#define OTG_STATE_B_SRP_WAIT_SE0_INTERRUPTS  (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+		| OTG_INT_TMX | OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_B_SRP_D_PLS
+ *
+ * note: changing to this state requires an additional call:
+ *       set_srp_conditions (dev);
+ *       reset_srp_conditions (dev) is required for the next state
+ */
+#define OTG_STATE_B_SRP_D_PULSE_CONTROL      (OTG_CTL_PERIPHERAL_DEFAULT | \
+		OTG_CTL_PUEN | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_D_PULSE_STATUS       0
+#define OTG_STATE_B_SRP_D_PULSE_STATUS_MASK  0
+#define OTG_STATE_B_SRP_D_PULSE_INTERRUPTS   (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+		| OTG_INT_SEC | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_V_PLS
+ */
+#define OTG_STATE_B_SRP_V_PULSE_CONTROL      (OTG_STATE_B_SRP_INIT_CONTROL | \
+		OTG_CTL_CHRG | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_V_PULSE_STATUS       0
+#define OTG_STATE_B_SRP_V_PULSE_STATUS_MASK  0
+#define OTG_STATE_B_SRP_V_PULSE_INTERRUPTS   (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+		| OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_V_DCG
+ */
+#define OTG_STATE_B_SRP_V_DCHRG_CONTROL      (OTG_STATE_B_SRP_INIT_CONTROL | \
+		OTG_CTL_DISCHRG | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_V_DCHRG_STATUS       0
+#define OTG_STATE_B_SRP_V_DCHRG_STATUS_MASK  0
+#define OTG_STATE_B_SRP_V_DCHRG_INTERRUPTS   (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+		| OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_WTVB
+ */
+#define OTG_STATE_B_SRP_WAIT_VBUS_CONTROL    (OTG_STATE_B_SRP_INIT_CONTROL | \
+		OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_WAIT_VBUS_STATUS      0
+#define OTG_STATE_B_SRP_WAIT_VBUS_STATUS_MASK 0
+#define OTG_STATE_B_SRP_WAIT_VBUS_INTERRUPTS (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+		| OTG_INT_SVC | OTG_INT_TMX)
+
+/*********************************/
+
+/* other */
+
+#define OTG_APP_REQ_ACK        0
+
+
+/*****************************************************************************
+*  Types
+*****************************************************************************/
+
+
+/*****************************************************************************
+*  Macros
+*****************************************************************************/
+
+/* printing messages */
+
+#define INFO(args...) \
+	printk(KERN_INFO DRIVER_NAME_FOR_PRINT ": " args)
+
+#ifdef WARN
+#undef WARN
+#endif
+
+#define WARN(args...) \
+	printk(KERN_WARNING DRIVER_NAME_FOR_PRINT " warning: " args)
+
+#define ERR(args...) \
+	printk(KERN_ERR DRIVER_NAME_FOR_PRINT " error: " args)
+
+#ifdef DEBUG
+#define DBG(args...) \
+	printk(KERN_DEBUG DRIVER_NAME_FOR_PRINT " debug: " args)
+#else
+#define DBG(args...) \
+	do {} while (0)
+#endif
+
+#ifdef VERBOSE
+#define VDBG DBG
+#else
+#define VDBG(args...) \
+	do { } while (0)
+#endif
+
+/****************************************************************************/
+
+/* this should always return "1" and print something in verbose mode */
+#ifdef VERBOSE
+#define VDBG_SPC(fmt, args...) \
+	(VDBG(fmt, args) ? 1 : 1)
+#else
+#define VDBG_SPC(fmt, args...) 1
+#endif
+
+/* query bit(s) (long: 32-bit access) */
+#define IS_BIT_RES(data, code) \
+	(!((data) & (code)) ? \
+	 (VDBG_SPC("  OTG HW status: %s is reset\n", #data)) : 0)
+
+#define IS_BIT_SET(data, code) \
+	(((data) & (code)) ? \
+	 (VDBG_SPC("  OTG HW status: %s is set\n", #data)) : 0)
+
+/* query SW flag(s) */
+#define IS_FLAG_RES(dev, data) \
+	(!((data) & (dev)->transceiver.params) ? \
+	 (VDBG_SPC("  OTG SW status: %s is reset\n", #data)) : 0)
+
+#define IS_FLAG_SET(dev, data) \
+	(((data) & (dev)->transceiver.params) ? \
+	 (VDBG_SPC("  OTG SW status: %s is set\n", #data)) : 0)
+
+/* query event bit(s) */
+#define GOT_EVENT(data, code) \
+	(((data) & (code)) ? \
+	 (VDBG_SPC("  OTG event: %s\n", #data)) : 0)
+
+/* set SW flag */
+#ifdef VERBOSE
+#define SET_FLAG(dev, data) \
+do { \
+	if (!((data) & (dev)->transceiver.params)) \
+		DBG("  OTG SW status change: set flag %s\n", #data); \
+	(dev)->transceiver.params |= (data) \
+} while (0);
+#else
+#define SET_FLAG(dev, data) \
+	((dev)->transceiver.params |= (data))
+#endif
+
+/* reset SW flag */
+#ifdef VERBOSE
+#define RES_FLAG(dev, data) \
+do { \
+	if ((data) & (dev)->transceiver.params) \
+		DBG("  OTG SW status change: reset flag %s\n", #data); \
+	(dev)->transceiver.params &= ~((u32) (data)) \
+} while (0);
+#else
+#define RES_FLAG(dev, data) \
+	((dev)->transceiver.params &= ~((u32) (data)))
+#endif
+
+/* reset event bit */
+#define RES_EVENT(data, code) \
+	((code) &= ~((u32) (data)))
+/* NOTE: this is not really needed so far, might be replaced with */
+/* #define RES_EVENT(data, code) \                                */
+/* 	do {} while (0)                                           */
+
+/* change OTG state */
+#ifdef CONFIG_USB_OTG
+#define PREPARE_STATE_CHANGE(dev, new_state) \
+	switch ((new_state) & OTG_STATE_MASK) { \
+	case OTG_STATE_UNDEFINED: \
+		set_undef_state_defaults((dev)); \
+		break; \
+	case OTG_STATE_A_IDLE: \
+		set_a_state_defaults((dev)); \
+		break; \
+	case OTG_STATE_B_IDLE: \
+		set_b_state_defaults((dev)); \
+		break; \
+	default: \
+		break; \
+	} \
+	do {} while (0)
+#else
+#define PREPARE_STATE_CHANGE(dev, new_state) \
+	do {} while (0)
+#endif
+
+#define CHANGE_STATE(dev, new_state, pMask) \
+do { \
+	PREPARE_STATE_CHANGE(dev, new_state); \
+	iowrite32((new_state##_CONTROL), &(dev)->regs->ctl); \
+	*(pMask) = (new_state##_INTERRUPTS); \
+	(dev)->transceiver.state = (new_state); \
+	DBG("OTG new state: %s\n", #new_state); \
+} while (0);
+
+/* verify OTG state */
+#ifndef CONFIG_OTG_TEST_MODE
+
+#define CHECK_STATE(dev, act_state, pMask) \
+do { \
+	*(pMask) = (act_state##_INTERRUPTS); \
+	(dev)->transceiver.prv_state = (act_state); \
+	VDBG("OTG state: %s\n", #act_state); \
+} while (0);
+#else
+#define CHECK_STATE(dev, act_state, pMask) \
+do {\
+	*(pMask) = (act_state##_INTERRUPTS); \
+	(dev)->transceiver.prv_state = (act_state); \
+	if (((ioread32(&(dev)->regs->sts) ^ (act_state##_STATUS))) & \
+	    act_state##_STATUS_MASK) \
+		WARN("OTG warning: incorrect status\n"); \
+	VDBG("OTG state: %s\n", #act_state); \
+} while (0);
+#endif
+
+/* set timer */
+#define SET_OTG_TIMER(dev, val) \
+	set_timer((dev), ((OTG_TMR_##val) * 100))
+
+/* set timer (<1ms) */
+#define SET_OTG_TIMER_SHORT(dev, val) \
+	set_timer((dev), ((OTG_TMR_##val) / 10))
+
+/* set timer (>10ms) */
+#define SET_OTG_TIMER_LONG(dev, val) \
+	set_timer_long ((dev), ((OTG_TMR_##val) / 10))
+
+#ifdef VERBOSE
+#define HS_DISCON_WARNING() \
+	if (!(OTG_CTL_ENABLE_UHC ^ \
+	      (OTG_CTL_MUX_MASK & ioread32(&dev->regs->ctl))) && \
+	    !(OTG_STS_PSPD & ioread32(&dev->regs->sts))) \
+		DBG("  OTG warning: disable UHC from HS-mode\n")
+#else
+#define HS_DISCON_WARNING() \
+	do { } while (0)
+#endif
+
+
+/*****************************************************************************
+*  Data
+*****************************************************************************/
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+struct otg_regs {
+	u32  cap;               /* capabilities */
+	u32  mux;               /* mux */
+	u32  sts;               /* status */
+	u32  ctl;               /* control */
+	u32  tmr;               /* timer */
+	u32  intr;              /* interrupt request */
+	u32  inten;             /* interrupt enable */
+} __attribute__ ((packed));
+
+
+struct otg {
+	spinlock_t              lock;
+	unsigned                enabled:1,
+				got_irq : 1,
+				region : 1;
+	u16                     chiprev;
+
+	struct platform_device  *pdev;
+	struct otg_regs         *regs;
+	struct otg_transceiver  transceiver;
+};
+#define otg_transceiver_to_otg(pTransceiver) \
+	container_of(otg, struct otg, pTransceiver)
+#define otg_to_transceiver(pOtg) \
+	(&pOtg->transceiver)
+
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
+/*****************************************************************************
+*  Functions
+*****************************************************************************/
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+extern int usb_gadget_register_otg(struct otg_transceiver * (
+			*get_transceiver)(void));
+extern int usb_gadget_unregister_otg(void);
+
+void otg_init_state(struct otg *);
+int otg_exit_state(struct otg *);
+
+#ifdef DEBUG
+static void print_regs(struct otg *);
+#endif  /* DEBUG */
+
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
+
+/*****************************************************************************
+*  Inline Functions
+*****************************************************************************/
+
+extern u32 otg_tmr_high_count;
+extern struct otg_ctl *otg_ctl;
+
+#ifdef CONFIG_USB_OTG
+/**
+ * \brief
+ * set neutral state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_undef_state_defaults(struct otg *dev)
+{
+	dev->transceiver.default_a = 0;
+	if (dev->transceiver.host)
+		dev->transceiver.host->is_b_host = 0;
+	if (dev->transceiver.gadget)
+		dev->transceiver.gadget->is_a_peripheral = 0;
+}
+
+/**
+ * \brief
+ * set A state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_a_state_defaults(struct otg *dev)
+{
+	dev->transceiver.default_a = 1;
+	if (dev->transceiver.host)
+		dev->transceiver.host->is_b_host = 0;
+	if (dev->transceiver.gadget)
+		dev->transceiver.gadget->is_a_peripheral = 1;
+}
+
+/**
+ * \brief
+ * set B state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_b_state_defaults(struct otg *dev)
+{
+	dev->transceiver.default_a = 0;
+	if (dev->transceiver.host)
+		dev->transceiver.host->is_b_host = 1;
+	if (dev->transceiver.gadget)
+		dev->transceiver.gadget->is_a_peripheral = 0;
+}
+
+/**
+ * \brief
+ * set B state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void reset_b_hnp_enable(struct otg *dev)
+{
+	if (dev->transceiver.host)
+		dev->transceiver.host->b_hnp_enable = 0;
+	VDBG("  OTG action: HNP disabled in B-device\n");
+}
+
+/**
+ * \brief
+ * set B state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline int is_b_hnp_enabled(struct otg *dev)
+{
+	int retVal = 0;
+
+	if (dev->transceiver.host &&
+		dev->transceiver.host->b_hnp_enable) {
+		VDBG("  OTG status: HNP is enabled in HS-B-device\n");
+		retVal = 1;
+	}
+#ifdef VERBOSE
+	else
+		DBG("  OTG status: HNP is disabled in B-device\n");
+#endif
+	return retVal;
+}
+#endif
+
+/**
+ * \brief
+ * Read the status register
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return status
+ */
+static inline u32 get_status(struct otg *dev)
+{
+	return ioread32(&dev->regs->sts);
+}
+
+/**
+ * \brief
+ * Load and start the timer for an unconditional run
+ *
+ * \param  dev   OTG controller info
+ * \param  val   Value to load
+ *
+ * \return void
+ */
+static inline void set_timer(struct otg *dev, u32 val)
+{
+	otg_tmr_high_count = 0;
+
+	iowrite32((val), &dev->regs->tmr);
+	VDBG("  OTG action: start timer: %d0 us\n", val);
+}
+
+/**
+ * \brief
+ * Load and start the timer for an unconditional run
+ *
+ * \param  dev   OTG controller info
+ * \param  val   Value to load
+ *
+ * \return void
+ */
+static inline void set_timer_long(struct otg *dev, u32 val)
+{
+	otg_tmr_high_count = val - 1;
+
+	iowrite32(TIMER_PERIOD, &dev->regs->tmr);
+	VDBG("  OTG action: start timer: %d0 ms\n", val);
+}
+
+/**
+ * \brief
+ * Re-start the timer (value already loaded)
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void restart_timer(struct otg *dev)
+{
+	iowrite32((ioread32(&dev->regs->ctl) | OTG_CTL_TMR_UNCOND),
+			&dev->regs->ctl);
+}
+
+/**
+ * \brief
+ * Reset the timer while running (value already loaded)
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void reset_timer(struct otg *dev)
+{
+	u32 temp;
+
+	temp = ioread32(&dev->regs->ctl);
+	iowrite32((temp & ~((u32) OTG_CTL_TMR_ALL)), &dev->regs->ctl);
+	iowrite32(temp, &dev->regs->ctl);
+	VDBG("  OTG action: re-start timer\n");
+}
+
+/**
+ * \brief
+ * Prepare the D-pulse
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_srp_conditions(struct otg *dev)
+{
+	VDBG("  OTG action: SRP init: no action needed due to A0 WAs\n");
+}
+
+/**
+ * \brief
+ * Reset conditions after SRP
+ *
+ * activates the auto-pull-up feature so after SRP the host
+ * will detect a device connect after calling this function
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void reset_srp_conditions(struct otg *dev)
+{
+	VDBG("  OTG action: SRP done: no action needed due to A0 WAs\n");
+}
+
+/**
+ * \brief
+ * enable HNP for both devices
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return success
+ */
+static inline int otg_enable_hnp(struct otg *dev)
+{
+	int  retVal = 0;
+	return retVal;
+}
+
+#ifdef DEBUG
+/**
+ * \brief
+ * Print OTG controller registers (debug mode only)
+ *
+ * \param dev    OTG controller info
+ *
+ * \return void
+ */
+static inline void print_regs(struct otg *dev)
+{
+	DBG("-- UOC registers ---\n");
+	DBG("otg cap   = %08x\n", ioread32(&dev->regs->cap));
+	DBG("otg mux   = %08x\n", ioread32(&dev->regs->mux));
+	DBG("otg sts   = %08x\n", ioread32(&dev->regs->sts));
+	DBG("otg ctl   = %08x\n", ioread32(&dev->regs->ctl));
+	DBG("otg tmr   = %08x\n", ioread32(&dev->regs->tmr));
+	DBG("otg intr  = %08x\n", ioread32(&dev->regs->intr));
+	DBG("otg inten = %08x\n", ioread32(&dev->regs->inten));
+	DBG("--------------------\n");
+}
+#endif /* DEBUG */
+
+#endif /* AU1200_UOC_H */
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index 17d9905..8151d74 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -78,6 +78,12 @@
 #define	gadget_is_omap(g)	0
 #endif
 
+#ifdef CONFIG_USB_GADGET_AU1200
+#define gadget_is_au1200(g)	!strcmp("au1200_udc", (g)->name)
+#else
+#define gadget_is_au1200(g)	0
+#endif
+
 /* not yet ported 2.4 --> 2.6 */
 #ifdef CONFIG_USB_GADGET_N9604
 #define	gadget_is_n9604(g)	!strcmp("n9604_udc", (g)->name)
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 1db25d1..5b88c43 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -45,7 +45,12 @@ struct otg_transceiver {
 
 	u8			default_a;
 	enum usb_otg_state	state;
-
+#ifdef CONFIG_USB_PORT_AU1200OTG
+	u8			prv_state;
+	u32			params;
+	void			*otg_priv;
+	u8			hostcount;
+#endif
 	struct usb_bus		*host;
 	struct usb_gadget	*gadget;
 
-- 
1.5.4.3
