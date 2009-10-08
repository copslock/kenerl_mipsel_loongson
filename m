Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 18:58:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17630 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493065AbZJHAQJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 02:16:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4acd2f380003>; Wed, 07 Oct 2009 17:15:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 17:15:32 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 17:15:32 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n980FScZ012215;
	Wed, 7 Oct 2009 17:15:28 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n980FRXV012214;
	Wed, 7 Oct 2009 17:15:27 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-usb@vger.kernel.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] USB: Add HCD for Octeon SOC
Date:	Wed,  7 Oct 2009 17:15:26 -0700
Message-Id: <1254960926-12185-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4ACD2EBF.8020901@caviumnetworks.com>
References: <4ACD2EBF.8020901@caviumnetworks.com>
X-OriginalArrivalTime: 08 Oct 2009 00:15:32.0083 (UTC) FILETIME=[72E1D430:01CA47AC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24186
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/usb/host/Kconfig                     |    8 +
 drivers/usb/host/Makefile                    |    1 +
 drivers/usb/host/dwc_otg/Kbuild              |   16 +
 drivers/usb/host/dwc_otg/dwc_otg_attr.c      |  854 ++++++++
 drivers/usb/host/dwc_otg/dwc_otg_attr.h      |   63 +
 drivers/usb/host/dwc_otg/dwc_otg_cil.c       | 2887 ++++++++++++++++++++++++++
 drivers/usb/host/dwc_otg/dwc_otg_cil.h       |  866 ++++++++
 drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c  |  689 ++++++
 drivers/usb/host/dwc_otg/dwc_otg_driver.h    |   63 +
 drivers/usb/host/dwc_otg/dwc_otg_hcd.c       | 2878 +++++++++++++++++++++++++
 drivers/usb/host/dwc_otg/dwc_otg_hcd.h       |  661 ++++++
 drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c  | 1890 +++++++++++++++++
 drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c |  695 +++++++
 drivers/usb/host/dwc_otg/dwc_otg_octeon.c    | 1078 ++++++++++
 drivers/usb/host/dwc_otg/dwc_otg_plat.h      |  236 +++
 drivers/usb/host/dwc_otg/dwc_otg_regs.h      | 2355 +++++++++++++++++++++
 16 files changed, 15240 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/dwc_otg/Kbuild
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_attr.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_attr.h
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil.h
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_driver.h
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd.h
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_octeon.c
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_plat.h
 create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_regs.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 9b43b22..342dc54 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -381,3 +381,11 @@ config USB_HWA_HCD
 
 	  To compile this driver a module, choose M here: the module
 	  will be called "hwa-hc".
+
+config USB_DWC_OTG
+	tristate "Cavium Octeon USB"
+	depends on USB && CPU_CAVIUM_OCTEON
+	---help---
+	  The Cavium Octeon on-chip USB controller.  To compile this
+	  driver as a module, choose M here: the module will be called
+	  "dwc_otg".
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index f58b249..76faf12 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -15,6 +15,7 @@ endif
 xhci-objs := xhci-hcd.o xhci-mem.o xhci-pci.o xhci-ring.o xhci-hub.o xhci-dbg.o
 
 obj-$(CONFIG_USB_WHCI_HCD)	+= whci/
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc_otg/
 
 obj-$(CONFIG_PCI)		+= pci-quirks.o
 
diff --git a/drivers/usb/host/dwc_otg/Kbuild b/drivers/usb/host/dwc_otg/Kbuild
new file mode 100644
index 0000000..cb32638
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/Kbuild
@@ -0,0 +1,16 @@
+#
+# Makefile for DWC_otg Highspeed USB controller driver
+#
+
+# Use one of the following flags to compile the software in host-only or
+# device-only mode.
+#EXTRA_CFLAGS   += -DDWC_HOST_ONLY
+#EXTRA_CFLAGS	+= -DDWC_DEVICE_ONLY
+
+EXTRA_CFLAGS   += -DDWC_HOST_ONLY
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc_otg.o
+
+dwc_otg-y := dwc_otg_octeon.o dwc_otg_attr.o
+dwc_otg-y	+= dwc_otg_cil.o dwc_otg_cil_intr.o
+dwc_otg-y	+= dwc_otg_hcd.o dwc_otg_hcd_intr.o dwc_otg_hcd_queue.o
+
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_attr.c b/drivers/usb/host/dwc_otg/dwc_otg_attr.c
new file mode 100644
index 0000000..d854a79
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_attr.c
@@ -0,0 +1,854 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+/*
+ *
+ * The diagnostic interface will provide access to the controller for
+ * bringing up the hardware and testing.  The Linux driver attributes
+ * feature will be used to provide the Linux Diagnostic
+ * Interface. These attributes are accessed through sysfs.
+ */
+
+/** @page "Linux Module Attributes"
+ *
+ * The Linux module attributes feature is used to provide the Linux
+ * Diagnostic Interface.  These attributes are accessed through sysfs.
+ * The diagnostic interface will provide access to the controller for
+ * bringing up the hardware and testing.
+
+ The following table shows the attributes.
+ <table>
+ <tr>
+ <td><b> Name</b></td>
+ <td><b> Description</b></td>
+ <td><b> Access</b></td>
+ </tr>
+
+ <tr>
+ <td> mode </td>
+ <td> Returns the current mode: 0 for device mode, 1 for host mode</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> hnpcapable </td>
+ <td> Gets or sets the "HNP-capable" bit in the Core USB Configuraton Register.
+ Read returns the current value.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> srpcapable </td>
+ <td> Gets or sets the "SRP-capable" bit in the Core USB Configuraton Register.
+ Read returns the current value.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> hnp </td>
+ <td> Initiates the Host Negotiation Protocol.  Read returns the status.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> srp </td>
+ <td> Initiates the Session Request Protocol.  Read returns the status.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> buspower </td>
+ <td> Gets or sets the Power State of the bus (0 - Off or 1 - On)</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> bussuspend </td>
+ <td> Suspends the USB bus.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> busconnected </td>
+ <td> Gets the connection status of the bus</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> gotgctl </td>
+ <td> Gets or sets the Core Control Status Register.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> gusbcfg </td>
+ <td> Gets or sets the Core USB Configuration Register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> grxfsiz </td>
+ <td> Gets or sets the Receive FIFO Size Register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> gnptxfsiz </td>
+ <td> Gets or sets the non-periodic Transmit Size Register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> gpvndctl </td>
+ <td> Gets or sets the PHY Vendor Control Register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> ggpio </td>
+ <td> Gets the value in the lower 16-bits of the General Purpose IO Register
+ or sets the upper 16 bits.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> guid </td>
+ <td> Gets or sets the value of the User ID Register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> gsnpsid </td>
+ <td> Gets the value of the Synopsys ID Regester</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> devspeed </td>
+ <td> Gets or sets the device speed setting in the DCFG register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> enumspeed </td>
+ <td> Gets the device enumeration Speed.</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> hptxfsiz </td>
+ <td> Gets the value of the Host Periodic Transmit FIFO</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> hprt0 </td>
+ <td> Gets or sets the value in the Host Port Control and Status Register</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> regoffset </td>
+ <td> Sets the register offset for the next Register Access</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> regvalue </td>
+ <td> Gets or sets the value of the register at the offset in the regoffset attribute.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> remote_wakeup </td>
+ <td> On read, shows the status of Remote Wakeup. On write, initiates a remote
+ wakeup of the host. When bit 0 is 1 and Remote Wakeup is enabled, the Remote
+ Wakeup signalling bit in the Device Control Register is set for 1
+ milli-second.</td>
+ <td> Read/Write</td>
+ </tr>
+
+ <tr>
+ <td> regdump </td>
+ <td> Dumps the contents of core registers.</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> hcddump </td>
+ <td> Dumps the current HCD state.</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> hcd_frrem </td>
+ <td> Shows the average value of the Frame Remaining
+ field in the Host Frame Number/Frame Remaining register when an SOF interrupt
+ occurs. This can be used to determine the average interrupt latency. Also
+ shows the average Frame Remaining value for start_transfer and the "a" and
+ "b" sample points. The "a" and "b" sample points may be used during debugging
+ bto determine how long it takes to execute a section of the HCD code.</td>
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> rd_reg_test </td>
+ <td> Displays the time required to read the GNPTXFSIZ register many times
+ (the output shows the number of times the register is read).
+ <td> Read</td>
+ </tr>
+
+ <tr>
+ <td> wr_reg_test </td>
+ <td> Displays the time required to write the GNPTXFSIZ register many times
+ (the output shows the number of times the register is written).
+ <td> Read</td>
+ </tr>
+
+ </table>
+
+ Example usage:
+ To get the current mode:
+ cat /sys/devices/lm0/mode
+
+ To power down the USB:
+ echo 0 > /sys/devices/lm0/buspower
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/stat.h>		/* permission constants */
+
+#include <asm/io.h>
+
+#include "dwc_otg_plat.h"
+#include "dwc_otg_attr.h"
+#include "dwc_otg_driver.h"
+#ifndef DWC_HOST_ONLY
+#include "dwc_otg_pcd.h"
+#endif
+#include "dwc_otg_hcd.h"
+
+/*
+ * MACROs for defining sysfs attribute
+ */
+#define DWC_OTG_DEVICE_ATTR_BITFIELD_SHOW(_otg_attr_name_, _addr_,	\
+					_mask_, _shift_, _string_)	\
+	static ssize_t _otg_attr_name_##_show (struct device *_dev,	\
+					struct device_attribute *attr,	\
+					char *buf)			\
+	{								\
+		struct dwc_otg_device *otg_dev = _dev->platform_data;	\
+		uint32_t val;						\
+		val = dwc_read_reg32(_addr_);				\
+		val = (val & (_mask_)) >> _shift_;			\
+		return sprintf(buf, "%s = 0x%x\n", _string_, val);	\
+	}
+
+#define DWC_OTG_DEVICE_ATTR_BITFIELD_STORE(_otg_attr_name_, _addr_,	\
+					_mask_, _shift_, _string_)	\
+	static ssize_t _otg_attr_name_##_store (struct device *_dev,	\
+						struct device_attribute *attr, \
+						const char *buf, size_t count) \
+	{								\
+		struct dwc_otg_device *otg_dev = _dev->platform_data;	\
+		uint32_t set = simple_strtoul(buf, NULL, 16);		\
+		uint32_t clear = set;					\
+		clear = ((~clear) << _shift_) & _mask_;			\
+		set = (set << _shift_) & _mask_;			\
+		dev_dbg(_dev,						\
+			"Storing Address=%p Set=0x%08x Clear=0x%08x\n",	\
+			_addr_, set, clear);				\
+		dwc_modify_reg32(_addr_, clear, set);			\
+		return count;						\
+	}
+
+#define DWC_OTG_DEVICE_ATTR_BITFIELD_RW(_otg_attr_name_, _addr_,	\
+					_mask_, _shift_, _string_)	\
+	DWC_OTG_DEVICE_ATTR_BITFIELD_SHOW(_otg_attr_name_, _addr_,	\
+					_mask_, _shift_, _string_)	\
+	DWC_OTG_DEVICE_ATTR_BITFIELD_STORE(_otg_attr_name_, _addr_,	\
+					_mask_, _shift_, _string_)	\
+	DEVICE_ATTR(_otg_attr_name_, 0644, _otg_attr_name_##_show,	\
+		_otg_attr_name_##_store);
+
+#define DWC_OTG_DEVICE_ATTR_BITFIELD_RO(_otg_attr_name_, _addr_,	\
+					_mask_,	_shift_, _string_)	\
+	DWC_OTG_DEVICE_ATTR_BITFIELD_SHOW(_otg_attr_name_,		\
+					_addr_, _mask_, _shift_, _string_) \
+	DEVICE_ATTR(_otg_attr_name_, 0444, _otg_attr_name_##_show, NULL);
+
+/*
+ * MACROs for defining sysfs attribute for 32-bit registers
+ */
+#define DWC_OTG_DEVICE_ATTR_REG_SHOW(_otg_attr_name_, _addr_, _string_) \
+	static ssize_t _otg_attr_name_##_show(struct device *_dev,	\
+					struct device_attribute *attr,	\
+					char *buf)			\
+	{								\
+		struct dwc_otg_device *otg_dev = _dev->platform_data;	\
+		uint32_t val;						\
+		val = dwc_read_reg32(_addr_);				\
+		return sprintf(buf, "%s = 0x%08x\n", _string_, val);	\
+	}
+
+#define DWC_OTG_DEVICE_ATTR_REG_STORE(_otg_attr_name_, _addr_, _string_) \
+	static ssize_t _otg_attr_name_##_store(struct device *_dev,	\
+					struct device_attribute *attr,	\
+					const char *buf, size_t count)	\
+	{								\
+		struct dwc_otg_device *otg_dev = _dev->platform_data;	\
+		uint32_t val = simple_strtoul(buf, NULL, 16);		\
+		dev_dbg(_dev, "Storing Address=%p Val=0x%08x\n", _addr_, val); \
+		dwc_write_reg32(_addr_, val);				\
+		return count;						\
+	}
+
+#define DWC_OTG_DEVICE_ATTR_REG32_RW(_otg_attr_name_, _addr_, _string_) \
+	DWC_OTG_DEVICE_ATTR_REG_SHOW(_otg_attr_name_, _addr_, _string_) \
+	DWC_OTG_DEVICE_ATTR_REG_STORE(_otg_attr_name_, _addr_, _string_) \
+	DEVICE_ATTR(_otg_attr_name_, 0644, _otg_attr_name_##_show,	\
+		_otg_attr_name_##_store);
+
+#define DWC_OTG_DEVICE_ATTR_REG32_RO(_otg_attr_name_, _addr_, _string_) \
+	DWC_OTG_DEVICE_ATTR_REG_SHOW(_otg_attr_name_, _addr_, _string_) \
+	DEVICE_ATTR(_otg_attr_name_, 0444, _otg_attr_name_##_show, NULL);
+
+/**
+ * Show the register offset of the Register Access.
+ */
+static ssize_t regoffset_show(struct device *_dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	return snprintf(buf, sizeof("0xFFFFFFFF\n") + 1, "0x%08x\n",
+			otg_dev->reg_offset);
+}
+
+/**
+ * Set the register offset for the next Register Access 	Read/Write
+ */
+static ssize_t regoffset_store(struct device *_dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t offset = simple_strtoul(buf, NULL, 16);
+
+	if (offset < SZ_256K)
+		otg_dev->reg_offset = offset;
+	else
+		dev_err(_dev, "invalid offset\n");
+
+	return count;
+}
+
+DEVICE_ATTR(regoffset, S_IRUGO | S_IWUSR, regoffset_show, regoffset_store);
+
+/**
+ * Show the value of the register at the offset in the reg_offset
+ * attribute.
+ */
+static ssize_t regvalue_show(struct device *_dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t val;
+	uint32_t *addr;
+
+	if (otg_dev->reg_offset != 0xFFFFFFFF && 0 != otg_dev->base) {
+		/* Calculate the address */
+		addr = (uint32_t *) (otg_dev->reg_offset +
+				     (uint8_t *) otg_dev->base);
+
+		val = dwc_read_reg32(addr);
+		return snprintf(buf,
+				sizeof("Reg@0xFFFFFFFF = 0xFFFFFFFF\n") + 1,
+				"Reg@0x%06x = 0x%08x\n", otg_dev->reg_offset,
+				val);
+	} else {
+		dev_err(_dev, "Invalid offset (0x%0x)\n", otg_dev->reg_offset);
+		return sprintf(buf, "invalid offset\n");
+	}
+}
+
+/**
+ * Store the value in the register at the offset in the reg_offset
+ * attribute.
+ *
+ */
+static ssize_t regvalue_store(struct device *_dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t *addr;
+	uint32_t val = simple_strtoul(buf, NULL, 16);
+
+	if (otg_dev->reg_offset != 0xFFFFFFFF && 0 != otg_dev->base) {
+		/* Calculate the address */
+		addr = (uint32_t *) (otg_dev->reg_offset +
+				     (uint8_t *) otg_dev->base);
+
+		dwc_write_reg32(addr, val);
+	} else {
+		dev_err(_dev, "Invalid Register Offset (0x%08x)\n",
+			otg_dev->reg_offset);
+	}
+	return count;
+}
+
+DEVICE_ATTR(regvalue, S_IRUGO | S_IWUSR, regvalue_show, regvalue_store);
+
+/*
+ * Attributes
+ */
+DWC_OTG_DEVICE_ATTR_BITFIELD_RO(mode,
+				&(otg_dev->core_if->core_global_regs->gotgctl),
+				(1 << 20), 20, "Mode");
+DWC_OTG_DEVICE_ATTR_BITFIELD_RW(hnpcapable,
+				&(otg_dev->core_if->core_global_regs->gusbcfg),
+				(1 << 9), 9, "Mode");
+DWC_OTG_DEVICE_ATTR_BITFIELD_RW(srpcapable,
+				&(otg_dev->core_if->core_global_regs->gusbcfg),
+				(1 << 8), 8, "Mode");
+#if 0
+DWC_OTG_DEVICE_ATTR_BITFIELD_RW(buspower, &(otg_dev->core_if->core_global_regs->gotgctl), (1<<8), 8, "Mode");
+DWC_OTG_DEVICE_ATTR_BITFIELD_RW(bussuspend, &(otg_dev->core_if->core_global_regs->gotgctl), (1<<8), 8, "Mode");
+#endif
+DWC_OTG_DEVICE_ATTR_BITFIELD_RO(busconnected, otg_dev->core_if->host_if->hprt0,
+				0x01, 0, "Bus Connected");
+
+DWC_OTG_DEVICE_ATTR_REG32_RW(gotgctl,
+			     &(otg_dev->core_if->core_global_regs->gotgctl),
+			     "GOTGCTL");
+DWC_OTG_DEVICE_ATTR_REG32_RW(gusbcfg,
+			     &(otg_dev->core_if->core_global_regs->gusbcfg),
+			     "GUSBCFG");
+DWC_OTG_DEVICE_ATTR_REG32_RW(grxfsiz,
+			     &(otg_dev->core_if->core_global_regs->grxfsiz),
+			     "GRXFSIZ");
+DWC_OTG_DEVICE_ATTR_REG32_RW(gnptxfsiz,
+			     &(otg_dev->core_if->core_global_regs->gnptxfsiz),
+			     "GNPTXFSIZ");
+DWC_OTG_DEVICE_ATTR_REG32_RW(gpvndctl,
+			     &(otg_dev->core_if->core_global_regs->gpvndctl),
+			     "GPVNDCTL");
+DWC_OTG_DEVICE_ATTR_REG32_RW(ggpio,
+			     &(otg_dev->core_if->core_global_regs->ggpio),
+			     "GGPIO");
+DWC_OTG_DEVICE_ATTR_REG32_RW(guid, &(otg_dev->core_if->core_global_regs->guid),
+			     "GUID");
+DWC_OTG_DEVICE_ATTR_REG32_RO(gsnpsid,
+			     &(otg_dev->core_if->core_global_regs->gsnpsid),
+			     "GSNPSID");
+DWC_OTG_DEVICE_ATTR_BITFIELD_RW(devspeed,
+				&(otg_dev->core_if->dev_if->dev_global_regs->
+				  dcfg), 0x3, 0, "Device Speed");
+DWC_OTG_DEVICE_ATTR_BITFIELD_RO(enumspeed,
+				&(otg_dev->core_if->dev_if->dev_global_regs->
+				  dsts), 0x6, 1, "Device Enumeration Speed");
+
+DWC_OTG_DEVICE_ATTR_REG32_RO(hptxfsiz,
+			     &(otg_dev->core_if->core_global_regs->hptxfsiz),
+			     "HPTXFSIZ");
+DWC_OTG_DEVICE_ATTR_REG32_RW(hprt0, otg_dev->core_if->host_if->hprt0, "HPRT0");
+
+/**
+ * @todo Add code to initiate the HNP.
+ */
+/**
+ * Show the HNP status bit
+ */
+static ssize_t hnp_show(struct device *_dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	union gotgctl_data val;
+	val.d32 =
+	    dwc_read_reg32(&(otg_dev->core_if->core_global_regs->gotgctl));
+	return sprintf(buf, "HstNegScs = 0x%x\n", val.b.hstnegscs);
+}
+
+/**
+ * Set the HNP Request bit
+ */
+static ssize_t hnp_store(struct device *_dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t in = simple_strtoul(buf, NULL, 16);
+	uint32_t *addr =
+	    (uint32_t *) &(otg_dev->core_if->core_global_regs->gotgctl);
+	union gotgctl_data mem;
+	mem.d32 = dwc_read_reg32(addr);
+	mem.b.hnpreq = in;
+	dev_dbg(_dev, "Storing Address=%p Data=0x%08x\n", addr, mem.d32);
+	dwc_write_reg32(addr, mem.d32);
+	return count;
+}
+
+DEVICE_ATTR(hnp, 0644, hnp_show, hnp_store);
+
+/**
+ * @todo Add code to initiate the SRP.
+ */
+/**
+ * Show the SRP status bit
+ */
+static ssize_t srp_show(struct device *_dev, struct device_attribute *attr,
+			char *buf)
+{
+#ifndef DWC_HOST_ONLY
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	union gotgctl_data val;
+	val.d32 =
+	    dwc_read_reg32(&(otg_dev->core_if->core_global_regs->gotgctl));
+	return sprintf(buf, "SesReqScs = 0x%x\n", val.b.sesreqscs);
+#else
+	return sprintf(buf, "Host Only Mode!\n");
+#endif
+}
+
+/**
+ * Set the SRP Request bit
+ */
+static ssize_t srp_store(struct device *_dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+#ifndef DWC_HOST_ONLY
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	dwc_otg_pcd_initiate_srp(otg_dev->pcd);
+#endif
+	return count;
+}
+
+DEVICE_ATTR(srp, 0644, srp_show, srp_store);
+
+/**
+ * @todo Need to do more for power on/off?
+ */
+/**
+ * Show the Bus Power status
+ */
+static ssize_t buspower_show(struct device *_dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	union hprt0_data val;
+	val.d32 = dwc_read_reg32(otg_dev->core_if->host_if->hprt0);
+	return sprintf(buf, "Bus Power = 0x%x\n", val.b.prtpwr);
+}
+
+/**
+ * Set the Bus Power status
+ */
+static ssize_t buspower_store(struct device *_dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t on = simple_strtoul(buf, NULL, 16);
+	uint32_t *addr = (uint32_t *) otg_dev->core_if->host_if->hprt0;
+	union hprt0_data mem;
+
+	mem.d32 = dwc_read_reg32(addr);
+	mem.b.prtpwr = on;
+
+	dwc_write_reg32(addr, mem.d32);
+
+	return count;
+}
+
+DEVICE_ATTR(buspower, 0644, buspower_show, buspower_store);
+
+/**
+ * @todo Need to do more for suspend?
+ */
+/**
+ * Show the Bus Suspend status
+ */
+static ssize_t bussuspend_show(struct device *_dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	union hprt0_data val;
+	val.d32 = dwc_read_reg32(otg_dev->core_if->host_if->hprt0);
+	return sprintf(buf, "Bus Suspend = 0x%x\n", val.b.prtsusp);
+}
+
+/**
+ * Set the Bus Suspend status
+ */
+static ssize_t bussuspend_store(struct device *_dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t in = simple_strtoul(buf, NULL, 16);
+	uint32_t *addr = (uint32_t *) otg_dev->core_if->host_if->hprt0;
+	union hprt0_data mem;
+	mem.d32 = dwc_read_reg32(addr);
+	mem.b.prtsusp = in;
+	dev_dbg(_dev, "Storing Address=%p Data=0x%08x\n", addr, mem.d32);
+	dwc_write_reg32(addr, mem.d32);
+	return count;
+}
+
+DEVICE_ATTR(bussuspend, 0644, bussuspend_show, bussuspend_store);
+
+/**
+ * Show the status of Remote Wakeup.
+ */
+static ssize_t remote_wakeup_show(struct device *_dev,
+				  struct device_attribute *attr, char *buf)
+{
+#ifndef DWC_HOST_ONLY
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	union dctl_data val;
+	val.d32 =
+	    dwc_read_reg32(&otg_dev->core_if->dev_if->dev_global_regs->dctl);
+	return sprintf(buf, "Remote Wakeup = %d Enabled = %d\n",
+		       val.b.rmtwkupsig, otg_dev->pcd->remote_wakeup_enable);
+#else
+	return sprintf(buf, "Host Only Mode!\n");
+#endif
+}
+
+/**
+ * Initiate a remote wakeup of the host.  The Device control register
+ * Remote Wakeup Signal bit is written if the PCD Remote wakeup enable
+ * flag is set.
+ *
+ */
+static ssize_t remote_wakeup_store(struct device *_dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+#ifndef DWC_HOST_ONLY
+	uint32_t val = simple_strtoul(buf, NULL, 16);
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	if (val & 1)
+		dwc_otg_pcd_remote_wakeup(otg_dev->pcd, 1);
+	else
+		dwc_otg_pcd_remote_wakeup(otg_dev->pcd, 0);
+#endif
+	return count;
+}
+
+DEVICE_ATTR(remote_wakeup, S_IRUGO | S_IWUSR, remote_wakeup_show,
+	    remote_wakeup_store);
+
+/**
+ * Dump global registers and either host or device registers (depending on the
+ * current mode of the core).
+ */
+static ssize_t regdump_show(struct device *_dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+
+	dwc_otg_dump_global_registers(otg_dev->core_if);
+	if (dwc_otg_is_host_mode(otg_dev->core_if))
+		dwc_otg_dump_host_registers(otg_dev->core_if);
+	else
+		dwc_otg_dump_dev_registers(otg_dev->core_if);
+
+	return sprintf(buf, "Register Dump\n");
+}
+
+DEVICE_ATTR(regdump, S_IRUGO | S_IWUSR, regdump_show, 0);
+
+/**
+ * Dump the current hcd state.
+ */
+static ssize_t hcddump_show(struct device *_dev, struct device_attribute *attr,
+			    char *buf)
+{
+#ifndef DWC_DEVICE_ONLY
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	dwc_otg_hcd_dump_state(otg_dev->hcd);
+#endif
+	return sprintf(buf, "HCD Dump\n");
+}
+
+DEVICE_ATTR(hcddump, S_IRUGO | S_IWUSR, hcddump_show, 0);
+
+/**
+ * Dump the average frame remaining at SOF. This can be used to
+ * determine average interrupt latency. Frame remaining is also shown for
+ * start transfer and two additional sample points.
+ */
+static ssize_t hcd_frrem_show(struct device *_dev,
+			      struct device_attribute *attr, char *buf)
+{
+#ifndef DWC_DEVICE_ONLY
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	dwc_otg_hcd_dump_frrem(otg_dev->hcd);
+#endif
+	return sprintf(buf, "HCD Dump Frame Remaining\n");
+}
+
+DEVICE_ATTR(hcd_frrem, S_IRUGO | S_IWUSR, hcd_frrem_show, 0);
+
+/**
+ * Displays the time required to read the GNPTXFSIZ register many times (the
+ * output shows the number of times the register is read).
+ */
+#define RW_REG_COUNT 10000000
+#define MSEC_PER_JIFFIE (1000/HZ)
+static ssize_t rd_reg_test_show(struct device *_dev,
+				struct device_attribute *attr, char *buf)
+{
+	int i;
+	int time;
+	int start_jiffies;
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+
+	pr_info("HZ %d, MSEC_PER_JIFFIE %d, loops_per_jiffy %lu\n",
+	       HZ, MSEC_PER_JIFFIE, loops_per_jiffy);
+	start_jiffies = jiffies;
+	for (i = 0; i < RW_REG_COUNT; i++)
+		dwc_read_reg32(&otg_dev->core_if->core_global_regs->gnptxfsiz);
+
+	time = jiffies - start_jiffies;
+	return sprintf(buf,
+		       "Time to read GNPTXFSIZ reg %d times: %d msecs (%d jiffies)\n",
+		       RW_REG_COUNT, time * MSEC_PER_JIFFIE, time);
+}
+
+DEVICE_ATTR(rd_reg_test, S_IRUGO | S_IWUSR, rd_reg_test_show, 0);
+
+/**
+ * Displays the time required to write the GNPTXFSIZ register many times (the
+ * output shows the number of times the register is written).
+ */
+static ssize_t wr_reg_test_show(struct device *_dev,
+				struct device_attribute *attr, char *buf)
+{
+	int i;
+	int time;
+	int start_jiffies;
+	struct dwc_otg_device *otg_dev = _dev->platform_data;
+	uint32_t reg_val;
+
+	pr_info("HZ %d, MSEC_PER_JIFFIE %d, loops_per_jiffy %lu\n",
+	       HZ, MSEC_PER_JIFFIE, loops_per_jiffy);
+	reg_val =
+	    dwc_read_reg32(&otg_dev->core_if->core_global_regs->gnptxfsiz);
+	start_jiffies = jiffies;
+	for (i = 0; i < RW_REG_COUNT; i++)
+		dwc_write_reg32(&otg_dev->core_if->core_global_regs->gnptxfsiz,
+				reg_val);
+
+	time = jiffies - start_jiffies;
+	return sprintf(buf,
+		       "Time to write GNPTXFSIZ reg %d times: %d msecs (%d jiffies)\n",
+		       RW_REG_COUNT, time * MSEC_PER_JIFFIE, time);
+}
+
+DEVICE_ATTR(wr_reg_test, S_IRUGO | S_IWUSR, wr_reg_test_show, 0);
+
+/*
+ * Create the device files
+ */
+void dwc_otg_attr_create(struct device *dev)
+{
+	int error;
+	error = device_create_file(dev, &dev_attr_regoffset);
+	error |= device_create_file(dev, &dev_attr_regvalue);
+	error |= device_create_file(dev, &dev_attr_mode);
+	error |= device_create_file(dev, &dev_attr_hnpcapable);
+	error |= device_create_file(dev, &dev_attr_srpcapable);
+	error |= device_create_file(dev, &dev_attr_hnp);
+	error |= device_create_file(dev, &dev_attr_srp);
+	error |= device_create_file(dev, &dev_attr_buspower);
+	error |= device_create_file(dev, &dev_attr_bussuspend);
+	error |= device_create_file(dev, &dev_attr_busconnected);
+	error |= device_create_file(dev, &dev_attr_gotgctl);
+	error |= device_create_file(dev, &dev_attr_gusbcfg);
+	error |= device_create_file(dev, &dev_attr_grxfsiz);
+	error |= device_create_file(dev, &dev_attr_gnptxfsiz);
+	error |= device_create_file(dev, &dev_attr_gpvndctl);
+	error |= device_create_file(dev, &dev_attr_ggpio);
+	error |= device_create_file(dev, &dev_attr_guid);
+	error |= device_create_file(dev, &dev_attr_gsnpsid);
+	error |= device_create_file(dev, &dev_attr_devspeed);
+	error |= device_create_file(dev, &dev_attr_enumspeed);
+	error |= device_create_file(dev, &dev_attr_hptxfsiz);
+	error |= device_create_file(dev, &dev_attr_hprt0);
+	error |= device_create_file(dev, &dev_attr_remote_wakeup);
+	error |= device_create_file(dev, &dev_attr_regdump);
+	error |= device_create_file(dev, &dev_attr_hcddump);
+	error |= device_create_file(dev, &dev_attr_hcd_frrem);
+	error |= device_create_file(dev, &dev_attr_rd_reg_test);
+	error |= device_create_file(dev, &dev_attr_wr_reg_test);
+	if (error)
+		pr_err("DWC_OTG: Creating some device files failed\n");
+}
+
+/*
+ * Remove the device files
+ */
+void dwc_otg_attr_remove(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_regoffset);
+	device_remove_file(dev, &dev_attr_regvalue);
+	device_remove_file(dev, &dev_attr_mode);
+	device_remove_file(dev, &dev_attr_hnpcapable);
+	device_remove_file(dev, &dev_attr_srpcapable);
+	device_remove_file(dev, &dev_attr_hnp);
+	device_remove_file(dev, &dev_attr_srp);
+	device_remove_file(dev, &dev_attr_buspower);
+	device_remove_file(dev, &dev_attr_bussuspend);
+	device_remove_file(dev, &dev_attr_busconnected);
+	device_remove_file(dev, &dev_attr_gotgctl);
+	device_remove_file(dev, &dev_attr_gusbcfg);
+	device_remove_file(dev, &dev_attr_grxfsiz);
+	device_remove_file(dev, &dev_attr_gnptxfsiz);
+	device_remove_file(dev, &dev_attr_gpvndctl);
+	device_remove_file(dev, &dev_attr_ggpio);
+	device_remove_file(dev, &dev_attr_guid);
+	device_remove_file(dev, &dev_attr_gsnpsid);
+	device_remove_file(dev, &dev_attr_devspeed);
+	device_remove_file(dev, &dev_attr_enumspeed);
+	device_remove_file(dev, &dev_attr_hptxfsiz);
+	device_remove_file(dev, &dev_attr_hprt0);
+	device_remove_file(dev, &dev_attr_remote_wakeup);
+	device_remove_file(dev, &dev_attr_regdump);
+	device_remove_file(dev, &dev_attr_hcddump);
+	device_remove_file(dev, &dev_attr_hcd_frrem);
+	device_remove_file(dev, &dev_attr_rd_reg_test);
+	device_remove_file(dev, &dev_attr_wr_reg_test);
+}
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_attr.h b/drivers/usb/host/dwc_otg/dwc_otg_attr.h
new file mode 100644
index 0000000..925524f
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_attr.h
@@ -0,0 +1,63 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+#if !defined(__DWC_OTG_ATTR_H__)
+#define __DWC_OTG_ATTR_H__
+
+/*
+ * This file contains the interface to the Linux device attributes.
+ */
+extern struct device_attribute dev_attr_regoffset;
+extern struct device_attribute dev_attr_regvalue;
+
+extern struct device_attribute dev_attr_mode;
+extern struct device_attribute dev_attr_hnpcapable;
+extern struct device_attribute dev_attr_srpcapable;
+extern struct device_attribute dev_attr_hnp;
+extern struct device_attribute dev_attr_srp;
+extern struct device_attribute dev_attr_buspower;
+extern struct device_attribute dev_attr_bussuspend;
+extern struct device_attribute dev_attr_busconnected;
+extern struct device_attribute dev_attr_gotgctl;
+extern struct device_attribute dev_attr_gusbcfg;
+extern struct device_attribute dev_attr_grxfsiz;
+extern struct device_attribute dev_attr_gnptxfsiz;
+extern struct device_attribute dev_attr_gpvndctl;
+extern struct device_attribute dev_attr_ggpio;
+extern struct device_attribute dev_attr_guid;
+extern struct device_attribute dev_attr_gsnpsid;
+extern struct device_attribute dev_attr_devspeed;
+extern struct device_attribute dev_attr_enumspeed;
+extern struct device_attribute dev_attr_hptxfsiz;
+extern struct device_attribute dev_attr_hprt0;
+
+void dwc_otg_attr_create(struct device *dev);
+void dwc_otg_attr_remove(struct device *dev);
+
+#endif
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_cil.c b/drivers/usb/host/dwc_otg/dwc_otg_cil.c
new file mode 100644
index 0000000..86153ba
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_cil.c
@@ -0,0 +1,2887 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+/*
+ *
+ * The Core Interface Layer provides basic services for accessing and
+ * managing the DWC_otg hardware. These services are used by both the
+ * Host Controller Driver and the Peripheral Controller Driver.
+ *
+ * The CIL manages the memory map for the core so that the HCD and PCD
+ * don't have to do this separately. It also handles basic tasks like
+ * reading/writing the registers and data FIFOs in the controller.
+ * Some of the data access functions provide encapsulation of several
+ * operations required to perform a task, such as writing multiple
+ * registers to start a transfer. Finally, the CIL performs basic
+ * services that are not specific to either the host or device modes
+ * of operation. These services include management of the OTG Host
+ * Negotiation Protocol (HNP) and Session Request Protocol (SRP). A
+ * Diagnostic API is also provided to allow testing of the controller
+ * hardware.
+ *
+ * The Core Interface Layer has the following requirements:
+ * - Provides basic controller operations.
+ * - Minimal use of OS services.
+ * - The OS services used will be abstracted by using inline functions
+ *   or macros.
+ *
+ */
+#include <asm/unaligned.h>
+#ifdef DEBUG
+#include <linux/jiffies.h>
+#endif
+
+#include "dwc_otg_plat.h"
+#include "dwc_otg_regs.h"
+#include "dwc_otg_cil.h"
+
+/**
+ * This function is called to initialize the DWC_otg CSR data
+ * structures.  The register addresses in the device and host
+ * structures are initialized from the base address supplied by the
+ * caller.  The calling function must make the OS calls to get the
+ * base address of the DWC_otg controller registers.  The core_params
+ * argument holds the parameters that specify how the core should be
+ * configured.
+ *
+ * @reg_base_addr: Base address of DWC_otg core registers
+ * @core_params: Pointer to the core configuration parameters
+ *
+ */
+struct dwc_otg_core_if *dwc_otg_cil_init(const uint32_t *reg_base_addr,
+				    struct dwc_otg_core_params *core_params)
+{
+	struct dwc_otg_core_if *core_if = 0;
+	struct dwc_otg_dev_if *dev_if = 0;
+	struct dwc_otg_host_if *host_if = 0;
+	uint8_t *reg_base = (uint8_t *) reg_base_addr;
+	int i = 0;
+
+	DWC_DEBUGPL(DBG_CILV, "%s(%p,%p)\n", __func__, reg_base_addr,
+		    core_params);
+
+	core_if = kmalloc(sizeof(struct dwc_otg_core_if), GFP_KERNEL);
+	if (core_if == 0) {
+		DWC_DEBUGPL(DBG_CIL,
+			    "Allocation of struct dwc_otg_core_if failed\n");
+		return 0;
+	}
+	memset(core_if, 0, sizeof(struct dwc_otg_core_if));
+
+	core_if->core_params = core_params;
+	core_if->core_global_regs =
+		(struct dwc_otg_core_global_regs *)reg_base;
+	/*
+	 * Allocate the Device Mode structures.
+	 */
+	dev_if = kmalloc(sizeof(struct dwc_otg_dev_if), GFP_KERNEL);
+	if (dev_if == 0) {
+		DWC_DEBUGPL(DBG_CIL, "Allocation of struct dwc_otg_dev_if "
+			    "failed\n");
+		kfree(core_if);
+		return 0;
+	}
+
+	dev_if->dev_global_regs =
+	    (struct dwc_otg_dev_global_regs *) (reg_base +
+					      DWC_DEV_GLOBAL_REG_OFFSET);
+
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		dev_if->in_ep_regs[i] = (struct dwc_otg_dev_in_ep_regs *)
+		    (reg_base + DWC_DEV_IN_EP_REG_OFFSET +
+		     (i * DWC_EP_REG_OFFSET));
+
+		dev_if->out_ep_regs[i] = (struct dwc_otg_dev_out_ep_regs *)
+		    (reg_base + DWC_DEV_OUT_EP_REG_OFFSET +
+		     (i * DWC_EP_REG_OFFSET));
+		DWC_DEBUGPL(DBG_CILV, "in_ep_regs[%d]->diepctl=%p\n",
+			    i, &dev_if->in_ep_regs[i]->diepctl);
+		DWC_DEBUGPL(DBG_CILV, "out_ep_regs[%d]->doepctl=%p\n",
+			    i, &dev_if->out_ep_regs[i]->doepctl);
+	}
+	dev_if->speed = 0;	/* unknown */
+	dev_if->num_eps = MAX_EPS_CHANNELS;
+	dev_if->num_perio_eps = 0;
+
+	core_if->dev_if = dev_if;
+	/*
+	 * Allocate the Host Mode structures.
+	 */
+	host_if = kmalloc(sizeof(struct dwc_otg_host_if), GFP_KERNEL);
+	if (host_if == 0) {
+		DWC_DEBUGPL(DBG_CIL,
+			    "Allocation of struct dwc_otg_host_if failed\n");
+		kfree(dev_if);
+		kfree(core_if);
+		return 0;
+	}
+
+	host_if->host_global_regs = (struct dwc_otg_host_global_regs *)
+	    (reg_base + DWC_OTG_HOST_GLOBAL_REG_OFFSET);
+	host_if->hprt0 =
+	    (uint32_t *) (reg_base + DWC_OTG_HOST_PORT_REGS_OFFSET);
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		host_if->hc_regs[i] = (struct dwc_otg_hc_regs *)
+		    (reg_base + DWC_OTG_HOST_CHAN_REGS_OFFSET +
+		     (i * DWC_OTG_CHAN_REGS_OFFSET));
+		DWC_DEBUGPL(DBG_CILV, "hc_reg[%d]->hcchar=%p\n",
+			    i, &host_if->hc_regs[i]->hcchar);
+	}
+	host_if->num_host_channels = MAX_EPS_CHANNELS;
+	core_if->host_if = host_if;
+
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		core_if->data_fifo[i] =
+		    (uint32_t *) (reg_base + DWC_OTG_DATA_FIFO_OFFSET +
+				  (i * DWC_OTG_DATA_FIFO_SIZE));
+		DWC_DEBUGPL(DBG_CILV, "data_fifo[%d]=%p\n",
+			    i, core_if->data_fifo[i]);
+	}
+
+	core_if->pcgcctl = (uint32_t *) (reg_base + DWC_OTG_PCGCCTL_OFFSET);
+
+	/*
+	 * Store the contents of the hardware configuration registers here for
+	 * easy access later.
+	 */
+	core_if->hwcfg1.d32 =
+	    dwc_read_reg32(&core_if->core_global_regs->ghwcfg1);
+	core_if->hwcfg2.d32 =
+	    dwc_read_reg32(&core_if->core_global_regs->ghwcfg2);
+	core_if->hwcfg3.d32 =
+	    dwc_read_reg32(&core_if->core_global_regs->ghwcfg3);
+	core_if->hwcfg4.d32 =
+	    dwc_read_reg32(&core_if->core_global_regs->ghwcfg4);
+
+	DWC_DEBUGPL(DBG_CILV, "hwcfg1=%08x\n", core_if->hwcfg1.d32);
+	DWC_DEBUGPL(DBG_CILV, "hwcfg2=%08x\n", core_if->hwcfg2.d32);
+	DWC_DEBUGPL(DBG_CILV, "hwcfg3=%08x\n", core_if->hwcfg3.d32);
+	DWC_DEBUGPL(DBG_CILV, "hwcfg4=%08x\n", core_if->hwcfg4.d32);
+
+	DWC_DEBUGPL(DBG_CILV, "op_mode=%0x\n", core_if->hwcfg2.b.op_mode);
+	DWC_DEBUGPL(DBG_CILV, "arch=%0x\n", core_if->hwcfg2.b.architecture);
+	DWC_DEBUGPL(DBG_CILV, "num_dev_ep=%d\n", core_if->hwcfg2.b.num_dev_ep);
+	DWC_DEBUGPL(DBG_CILV, "num_host_chan=%d\n",
+		    core_if->hwcfg2.b.num_host_chan);
+	DWC_DEBUGPL(DBG_CILV, "nonperio_tx_q_depth=0x%0x\n",
+		    core_if->hwcfg2.b.nonperio_tx_q_depth);
+	DWC_DEBUGPL(DBG_CILV, "host_perio_tx_q_depth=0x%0x\n",
+		    core_if->hwcfg2.b.host_perio_tx_q_depth);
+	DWC_DEBUGPL(DBG_CILV, "dev_token_q_depth=0x%0x\n",
+		    core_if->hwcfg2.b.dev_token_q_depth);
+
+	DWC_DEBUGPL(DBG_CILV, "Total FIFO SZ=%d\n",
+		    core_if->hwcfg3.b.dfifo_depth);
+	DWC_DEBUGPL(DBG_CILV, "xfer_size_cntr_width=%0x\n",
+		    core_if->hwcfg3.b.xfer_size_cntr_width);
+
+	/*
+	 * Set the SRP sucess bit for FS-I2c
+	 */
+	core_if->srp_success = 0;
+	core_if->srp_timer_started = 0;
+
+	return core_if;
+}
+
+/**
+ * This function frees the structures allocated by dwc_otg_cil_init().
+ *
+ * @core_if: The core interface pointer returned from
+ * dwc_otg_cil_init().
+ *
+ */
+void dwc_otg_cil_remove(struct dwc_otg_core_if *core_if)
+{
+	/* Disable all interrupts */
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, 1, 0);
+	dwc_write_reg32(&core_if->core_global_regs->gintmsk, 0);
+
+	kfree(core_if->dev_if);
+	kfree(core_if->host_if);
+
+	kfree(core_if);
+}
+
+/**
+ * This function enables the controller's Global Interrupt in the AHB Config
+ * register.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+extern void dwc_otg_enable_global_interrupts(struct dwc_otg_core_if *core_if)
+{
+	union gahbcfg_data ahbcfg = {.d32 = 0 };
+	ahbcfg.b.glblintrmsk = 1;	/* Enable interrupts */
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, 0, ahbcfg.d32);
+}
+
+/**
+ * This function disables the controller's Global Interrupt in the AHB Config
+ * register.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+extern void dwc_otg_disable_global_interrupts(struct dwc_otg_core_if *core_if)
+{
+	union gahbcfg_data ahbcfg = {.d32 = 0 };
+	ahbcfg.b.glblintrmsk = 1;	/* Enable interrupts */
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, ahbcfg.d32, 0);
+}
+
+/**
+ * This function initializes the commmon interrupts, used in both
+ * device and host modes.
+ *
+ * @core_if: Programming view of the DWC_otg controller
+ *
+ */
+static void dwc_otg_enable_common_interrupts(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs =
+		core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+	/* Clear any pending OTG Interrupts */
+	dwc_write_reg32(&global_regs->gotgint, 0xFFFFFFFF);
+	/* Clear any pending interrupts */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+	/*
+	 * Enable the interrupts in the GINTMSK.
+	 */
+	intr_mask.b.modemismatch = 1;
+	intr_mask.b.otgintr = 1;
+	if (!core_if->dma_enable)
+		intr_mask.b.rxstsqlvl = 1;
+
+	intr_mask.b.conidstschng = 1;
+	intr_mask.b.wkupintr = 1;
+	intr_mask.b.disconnect = 1;
+	intr_mask.b.usbsuspend = 1;
+	intr_mask.b.sessreqintr = 1;
+	dwc_write_reg32(&global_regs->gintmsk, intr_mask.d32);
+}
+
+/**
+ * Initializes the FSLSPClkSel field of the HCFG register depending on the PHY
+ * type.
+ */
+static void init_fslspclksel(struct dwc_otg_core_if *core_if)
+{
+	uint32_t val;
+	union hcfg_data hcfg;
+
+	if (((core_if->hwcfg2.b.hs_phy_type == 2) &&
+	     (core_if->hwcfg2.b.fs_phy_type == 1) &&
+	     (core_if->core_params->ulpi_fs_ls)) ||
+	    (core_if->core_params->phy_type == DWC_PHY_TYPE_PARAM_FS)) {
+		/* Full speed PHY */
+		val = DWC_HCFG_48_MHZ;
+	} else {
+		/* High speed PHY running at full speed or high speed */
+		val = DWC_HCFG_30_60_MHZ;
+	}
+
+	DWC_DEBUGPL(DBG_CIL, "Initializing HCFG.FSLSPClkSel to 0x%1x\n", val);
+	hcfg.d32 = dwc_read_reg32(&core_if->host_if->host_global_regs->hcfg);
+	hcfg.b.fslspclksel = val;
+	dwc_write_reg32(&core_if->host_if->host_global_regs->hcfg, hcfg.d32);
+}
+
+/**
+ * Initializes the DevSpd field of the DCFG register depending on the PHY type
+ * and the enumeration speed of the device.
+ */
+static void init_devspd(struct dwc_otg_core_if *core_if)
+{
+	uint32_t val;
+	union dcfg_data dcfg;
+
+	if (((core_if->hwcfg2.b.hs_phy_type == 2) &&
+	     (core_if->hwcfg2.b.fs_phy_type == 1) &&
+	     (core_if->core_params->ulpi_fs_ls)) ||
+	    (core_if->core_params->phy_type == DWC_PHY_TYPE_PARAM_FS)) {
+		/* Full speed PHY */
+		val = 0x3;
+	} else if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL) {
+		/* High speed PHY running at full speed */
+		val = 0x1;
+	} else {
+		/* High speed PHY running at high speed */
+		val = 0x0;
+	}
+
+	DWC_DEBUGPL(DBG_CIL, "Initializing DCFG.DevSpd to 0x%1x\n", val);
+	dcfg.d32 = dwc_read_reg32(&core_if->dev_if->dev_global_regs->dcfg);
+	dcfg.b.devspd = val;
+	dwc_write_reg32(&core_if->dev_if->dev_global_regs->dcfg, dcfg.d32);
+}
+
+/**
+ * This function initializes the DWC_otg controller registers and
+ * prepares the core for device mode or host mode operation.
+ *
+ * @core_if: Programming view of the DWC_otg controller
+ *
+ */
+void dwc_otg_core_init(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	struct dwc_otg_dev_if *dev_if = core_if->dev_if;
+	int i = 0;
+	union gahbcfg_data ahbcfg = {.d32 = 0 };
+	union gusbcfg_data usbcfg = {.d32 = 0 };
+	union gi2cctl_data i2cctl = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_CILV, "dwc_otg_core_init(%p)\n", core_if);
+
+	/* Common Initialization */
+
+	usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+
+	/* Program the ULPI External VBUS bit if needed */
+	usbcfg.b.ulpi_ext_vbus_drv =
+	    (core_if->core_params->phy_ulpi_ext_vbus ==
+	     DWC_PHY_ULPI_EXTERNAL_VBUS) ? 1 : 0;
+
+	/* Set external TS Dline pulsing */
+	usbcfg.b.term_sel_dl_pulse =
+	    (core_if->core_params->ts_dline == 1) ? 1 : 0;
+	dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+	/* Reset the Controller */
+	dwc_otg_core_reset(core_if);
+
+	/* Initialize parameters from Hardware configuration registers. */
+	dev_if->num_eps = core_if->hwcfg2.b.num_dev_ep;
+	dev_if->num_perio_eps = core_if->hwcfg4.b.num_dev_perio_in_ep;
+
+	DWC_DEBUGPL(DBG_CIL, "num_dev_perio_in_ep=%d\n",
+		    core_if->hwcfg4.b.num_dev_perio_in_ep);
+	for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+		dev_if->perio_tx_fifo_size[i] =
+		    dwc_read_reg32(&global_regs->dptxfsiz[i]) >> 16;
+		DWC_DEBUGPL(DBG_CIL, "Periodic Tx FIFO SZ #%d=0x%0x\n",
+			    i, dev_if->perio_tx_fifo_size[i]);
+	}
+
+	core_if->total_fifo_size = core_if->hwcfg3.b.dfifo_depth;
+	core_if->rx_fifo_size = dwc_read_reg32(&global_regs->grxfsiz);
+	core_if->nperio_tx_fifo_size =
+	    dwc_read_reg32(&global_regs->gnptxfsiz) >> 16;
+
+	DWC_DEBUGPL(DBG_CIL, "Total FIFO SZ=%d\n", core_if->total_fifo_size);
+	DWC_DEBUGPL(DBG_CIL, "Rx FIFO SZ=%d\n", core_if->rx_fifo_size);
+	DWC_DEBUGPL(DBG_CIL, "NP Tx FIFO SZ=%d\n",
+		    core_if->nperio_tx_fifo_size);
+
+	/* This programming sequence needs to happen in FS mode before any other
+	 * programming occurs */
+	if ((core_if->core_params->speed == DWC_SPEED_PARAM_FULL) &&
+	    (core_if->core_params->phy_type == DWC_PHY_TYPE_PARAM_FS)) {
+		/* If FS mode with FS PHY */
+
+		/* core_init() is now called on every switch so only call the
+		 * following for the first time through. */
+		if (!core_if->phy_init_done) {
+			core_if->phy_init_done = 1;
+			DWC_DEBUGPL(DBG_CIL, "FS_PHY detected\n");
+			usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+			usbcfg.b.physel = 1;
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Reset after a PHY select */
+			dwc_otg_core_reset(core_if);
+		}
+
+		/* Program DCFG.DevSpd or HCFG.FSLSPclkSel to 48Mhz in FS.  Also
+		 * do this on HNP Dev/Host mode switches (done in dev_init and
+		 * host_init). */
+		if (dwc_otg_is_host_mode(core_if))
+			init_fslspclksel(core_if);
+		else
+			init_devspd(core_if);
+
+		if (core_if->core_params->i2c_enable) {
+			DWC_DEBUGPL(DBG_CIL, "FS_PHY Enabling I2c\n");
+			/* Program GUSBCFG.OtgUtmifsSel to I2C */
+			usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+			usbcfg.b.otgutmifssel = 1;
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Program GI2CCTL.I2CEn */
+			i2cctl.d32 = dwc_read_reg32(&global_regs->gi2cctl);
+			i2cctl.b.i2cdevaddr = 1;
+			i2cctl.b.i2cen = 0;
+			dwc_write_reg32(&global_regs->gi2cctl, i2cctl.d32);
+			i2cctl.b.i2cen = 1;
+			dwc_write_reg32(&global_regs->gi2cctl, i2cctl.d32);
+		}
+
+	}
+	/* endif speed == DWC_SPEED_PARAM_FULL */
+	else {
+		/* High speed PHY. */
+		if (!core_if->phy_init_done) {
+			core_if->phy_init_done = 1;
+			/* HS PHY parameters.  These parameters are preserved
+			 * during soft reset so only program the first time.  Do
+			 * a soft reset immediately after setting phyif.  */
+			usbcfg.b.ulpi_utmi_sel =
+			    (core_if->core_params->phy_type ==
+			     DWC_PHY_TYPE_PARAM_ULPI);
+			if (usbcfg.b.ulpi_utmi_sel == 1) {
+				/* ULPI interface */
+				usbcfg.b.phyif = 0;
+				usbcfg.b.ddrsel =
+				    core_if->core_params->phy_ulpi_ddr;
+			} else {
+				/* UTMI+ interface */
+				if (core_if->core_params->phy_utmi_width == 16)
+					usbcfg.b.phyif = 1;
+				else
+					usbcfg.b.phyif = 0;
+			}
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Reset after setting the PHY parameters */
+			dwc_otg_core_reset(core_if);
+		}
+	}
+
+	if ((core_if->hwcfg2.b.hs_phy_type == 2) &&
+	    (core_if->hwcfg2.b.fs_phy_type == 1) &&
+	    (core_if->core_params->ulpi_fs_ls)) {
+		DWC_DEBUGPL(DBG_CIL, "Setting ULPI FSLS\n");
+		usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+		usbcfg.b.ulpi_fsls = 1;
+		usbcfg.b.ulpi_clk_sus_m = 1;
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+	} else {
+		usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+		usbcfg.b.ulpi_fsls = 0;
+		usbcfg.b.ulpi_clk_sus_m = 0;
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+	}
+
+	/* Program the GAHBCFG Register. */
+	switch (core_if->hwcfg2.b.architecture) {
+
+	case DWC_SLAVE_ONLY_ARCH:
+		DWC_DEBUGPL(DBG_CIL, "Slave Only Mode\n");
+		ahbcfg.b.nptxfemplvl = DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY;
+		ahbcfg.b.ptxfemplvl = DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY;
+		core_if->dma_enable = 0;
+		break;
+
+	case DWC_EXT_DMA_ARCH:
+		DWC_DEBUGPL(DBG_CIL, "External DMA Mode\n");
+		ahbcfg.b.hburstlen = core_if->core_params->dma_burst_size;
+		core_if->dma_enable = (core_if->core_params->dma_enable != 0);
+		break;
+
+	case DWC_INT_DMA_ARCH:
+		DWC_DEBUGPL(DBG_CIL, "Internal DMA Mode\n");
+		ahbcfg.b.hburstlen = DWC_GAHBCFG_INT_DMA_BURST_INCR;
+		core_if->dma_enable = (core_if->core_params->dma_enable != 0);
+		break;
+
+	}
+	ahbcfg.b.dmaenable = core_if->dma_enable;
+	dwc_write_reg32(&global_regs->gahbcfg, ahbcfg.d32);
+
+	/*
+	 * Program the GUSBCFG register.
+	 */
+	usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+
+	switch (core_if->hwcfg2.b.op_mode) {
+	case DWC_MODE_HNP_SRP_CAPABLE:
+		usbcfg.b.hnpcap = (core_if->core_params->otg_cap ==
+				   DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE);
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+				   DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+
+	case DWC_MODE_SRP_ONLY_CAPABLE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+				   DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+
+	case DWC_MODE_NO_HNP_SRP_CAPABLE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+
+	case DWC_MODE_SRP_CAPABLE_DEVICE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+				   DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+
+	case DWC_MODE_NO_SRP_CAPABLE_DEVICE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+
+	case DWC_MODE_SRP_CAPABLE_HOST:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+				   DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+
+	case DWC_MODE_NO_SRP_CAPABLE_HOST:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	}
+
+	dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+	/* Enable common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/* Do device or host intialization based on mode during PCD
+	 * and HCD initialization  */
+	if (dwc_otg_is_host_mode(core_if)) {
+		DWC_DEBUGPL(DBG_ANY, "Host Mode\n");
+		core_if->op_state = A_HOST;
+	} else {
+		DWC_DEBUGPL(DBG_ANY, "Device Mode\n");
+		core_if->op_state = B_PERIPHERAL;
+#ifdef DWC_DEVICE_ONLY
+		dwc_otg_core_dev_init(core_if);
+#endif
+	}
+}
+
+/**
+ * This function enables the Device mode interrupts.
+ *
+ * @core_if: Programming view of DWC_otg controller
+ */
+void dwc_otg_enable_device_interrupts(struct dwc_otg_core_if *core_if)
+{
+	union gintmsk_data intr_mask = {.d32 = 0 };
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+
+	DWC_DEBUGPL(DBG_CIL, "%s()\n", __func__);
+
+	/* Disable all interrupts. */
+	dwc_write_reg32(&global_regs->gintmsk, 0);
+
+	/* Clear any pending interrupts */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/* Enable interrupts */
+	intr_mask.b.usbreset = 1;
+	intr_mask.b.enumdone = 1;
+	intr_mask.b.epmismatch = 1;
+	intr_mask.b.inepintr = 1;
+	intr_mask.b.outepintr = 1;
+	intr_mask.b.erlysuspend = 1;
+
+#ifdef USE_PERIODIC_EP
+	/** @todo NGS: Should this be a module parameter? */
+	intr_mask.b.isooutdrop = 1;
+	intr_mask.b.eopframe = 1;
+	intr_mask.b.incomplisoin = 1;
+	intr_mask.b.incomplisoout = 1;
+#endif
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
+
+	DWC_DEBUGPL(DBG_CIL, "%s() gintmsk=%0x\n", __func__,
+		    dwc_read_reg32(&global_regs->gintmsk));
+}
+
+/**
+ * This function initializes the DWC_otg controller registers for
+ * device mode.
+ *
+ * @core_if: Programming view of DWC_otg controller
+ *
+ */
+void dwc_otg_core_dev_init(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	struct dwc_otg_dev_if *dev_if = core_if->dev_if;
+	struct dwc_otg_core_params *params = core_if->core_params;
+	union dcfg_data dcfg = {.d32 = 0 };
+	union grstctl_data resetctl = {.d32 = 0 };
+	int i;
+	uint32_t rx_fifo_size;
+	union fifosize_data nptxfifosize;
+#ifdef USE_PERIODIC_EP
+	union fifosize_data ptxfifosize;
+#endif
+
+	/* Restart the Phy Clock */
+	dwc_write_reg32(core_if->pcgcctl, 0);
+
+	/* Device configuration register */
+	init_devspd(core_if);
+	dcfg.d32 = dwc_read_reg32(&dev_if->dev_global_regs->dcfg);
+	dcfg.b.perfrint = DWC_DCFG_FRAME_INTERVAL_80;
+	dwc_write_reg32(&dev_if->dev_global_regs->dcfg, dcfg.d32);
+
+	/* Configure data FIFO sizes */
+	if (core_if->hwcfg2.b.dynamic_fifo && params->enable_dynamic_fifo) {
+
+		DWC_DEBUGPL(DBG_CIL, "Total FIFO Size=%d\n",
+			    core_if->total_fifo_size);
+		DWC_DEBUGPL(DBG_CIL, "Rx FIFO Size=%d\n",
+			    params->dev_rx_fifo_size);
+		DWC_DEBUGPL(DBG_CIL, "NP Tx FIFO Size=%d\n",
+			    params->dev_nperio_tx_fifo_size);
+
+		/* Rx FIFO */
+		DWC_DEBUGPL(DBG_CIL, "initial grxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->grxfsiz));
+		rx_fifo_size = params->dev_rx_fifo_size;
+		dwc_write_reg32(&global_regs->grxfsiz, rx_fifo_size);
+		DWC_DEBUGPL(DBG_CIL, "new grxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->grxfsiz));
+
+		/* Non-periodic Tx FIFO */
+		DWC_DEBUGPL(DBG_CIL, "initial gnptxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->gnptxfsiz));
+		nptxfifosize.b.depth = params->dev_nperio_tx_fifo_size;
+		nptxfifosize.b.startaddr = params->dev_rx_fifo_size;
+		dwc_write_reg32(&global_regs->gnptxfsiz, nptxfifosize.d32);
+		DWC_DEBUGPL(DBG_CIL, "new gnptxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->gnptxfsiz));
+
+#ifdef USE_PERIODIC_EP
+		/**@todo NGS: Fix Periodic FIFO Sizing! */
+		/*
+		 * Periodic Tx FIFOs These FIFOs are numbered from 1 to 15.
+		 * Indexes of the FIFO size module parameters in the
+		 * dev_perio_tx_fifo_size array and the FIFO size registers in
+		 * the dptxfsiz array run from 0 to 14.
+		 */
+		/** @todo Finish debug of this */
+		ptxfifosize.b.startaddr =
+		    nptxfifosize.b.startaddr + nptxfifosize.b.depth;
+		for (i = 0; i < dev_if->num_perio_eps; i++) {
+			ptxfifosize.b.depth = params->dev_perio_tx_fifo_size[i];
+			DWC_DEBUGPL(DBG_CIL, "initial dptxfsiz[%d]=%08x\n", i,
+				    dwc_read_reg32(&global_regs->dptxfsiz[i]));
+			dwc_write_reg32(&global_regs->dptxfsiz[i],
+					ptxfifosize.d32);
+			DWC_DEBUGPL(DBG_CIL, "new dptxfsiz[%d]=%08x\n", i,
+				    dwc_read_reg32(&global_regs->dptxfsiz[i]));
+			ptxfifosize.b.startaddr += ptxfifosize.b.depth;
+		}
+#endif
+	}
+	/* Flush the FIFOs */
+	dwc_otg_flush_tx_fifo(core_if, 0x10);	/* all Tx FIFOs */
+	dwc_otg_flush_rx_fifo(core_if);
+
+	/* Flush the Learning Queue. */
+	resetctl.b.intknqflsh = 1;
+	dwc_write_reg32(&core_if->core_global_regs->grstctl, resetctl.d32);
+
+	/* Clear all pending Device Interrupts */
+	dwc_write_reg32(&dev_if->dev_global_regs->diepmsk, 0);
+	dwc_write_reg32(&dev_if->dev_global_regs->doepmsk, 0);
+	dwc_write_reg32(&dev_if->dev_global_regs->daint, 0xFFFFFFFF);
+	dwc_write_reg32(&dev_if->dev_global_regs->daintmsk, 0);
+
+	for (i = 0; i < dev_if->num_eps; i++) {
+		union depctl_data depctl;
+		depctl.d32 = dwc_read_reg32(&dev_if->in_ep_regs[i]->diepctl);
+		if (depctl.b.epena) {
+			depctl.d32 = 0;
+			depctl.b.epdis = 1;
+			depctl.b.snak = 1;
+		} else {
+			depctl.d32 = 0;
+		}
+		dwc_write_reg32(&dev_if->in_ep_regs[i]->diepctl, depctl.d32);
+
+		depctl.d32 = dwc_read_reg32(&dev_if->out_ep_regs[i]->doepctl);
+		if (depctl.b.epena) {
+			depctl.d32 = 0;
+			depctl.b.epdis = 1;
+			depctl.b.snak = 1;
+		} else {
+			depctl.d32 = 0;
+		}
+		dwc_write_reg32(&dev_if->out_ep_regs[i]->doepctl, depctl.d32);
+
+		dwc_write_reg32(&dev_if->in_ep_regs[i]->dieptsiz, 0);
+		dwc_write_reg32(&dev_if->out_ep_regs[i]->doeptsiz, 0);
+		dwc_write_reg32(&dev_if->in_ep_regs[i]->diepdma, 0);
+		dwc_write_reg32(&dev_if->out_ep_regs[i]->doepdma, 0);
+		dwc_write_reg32(&dev_if->in_ep_regs[i]->diepint, 0xFF);
+		dwc_write_reg32(&dev_if->out_ep_regs[i]->doepint, 0xFF);
+	}
+
+	dwc_otg_enable_device_interrupts(core_if);
+}
+
+/**
+ * This function enables the Host mode interrupts.
+ *
+ * @core_if: Programming view of DWC_otg controller
+ */
+void dwc_otg_enable_host_interrupts(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_CIL, "%s()\n", __func__);
+
+	/* Disable all interrupts. */
+	dwc_write_reg32(&global_regs->gintmsk, 0);
+
+	/* Clear any pending interrupts. */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/*
+	 * Enable host mode interrupts without disturbing common
+	 * interrupts.
+	 */
+	intr_mask.b.sofintr = 1;
+	intr_mask.b.portintr = 1;
+	intr_mask.b.hcintr = 1;
+
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
+}
+
+/**
+ * This function disables the Host Mode interrupts.
+ *
+ * @core_if: Programming view of DWC_otg controller
+ */
+void dwc_otg_disable_host_interrupts(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_CILV, "%s()\n", __func__);
+
+	/*
+	 * Disable host mode interrupts without disturbing common
+	 * interrupts.
+	 */
+	intr_mask.b.sofintr = 1;
+	intr_mask.b.portintr = 1;
+	intr_mask.b.hcintr = 1;
+	intr_mask.b.ptxfempty = 1;
+	intr_mask.b.nptxfempty = 1;
+
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, 0);
+}
+
+/**
+ * The FIFOs are established based on a default percentage of the
+ * total FIFO depth. This function converts the percentage into the
+ * proper setting.
+ *
+ */
+static inline uint32_t fifo_percentage(uint16_t total_fifo_size,
+				       int32_t percentage)
+{
+	/* 16-byte aligned */
+	return ((total_fifo_size * percentage) / 100) & (-1 << 3);
+}
+
+/**
+ * This function initializes the DWC_otg controller registers for
+ * host mode.
+ *
+ * This function flushes the Tx and Rx FIFOs and it flushes any entries in the
+ * request queues. Host channels are reset to ensure that they are ready for
+ * performing transfers.
+ *
+ * @core_if: Programming view of DWC_otg controller
+ *
+ */
+void dwc_otg_core_host_init(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	struct dwc_otg_host_if *host_if = core_if->host_if;
+	struct dwc_otg_core_params *params = core_if->core_params;
+	union hprt0_data hprt0 = {.d32 = 0 };
+	union fifosize_data nptxfifosize;
+	union fifosize_data ptxfifosize;
+	int i;
+	union hcchar_data hcchar;
+	union hcfg_data hcfg;
+	struct dwc_otg_hc_regs *hc_regs;
+	int num_channels;
+	union gotgctl_data gotgctl = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_CILV, "%s(%p)\n", __func__, core_if);
+
+	/* Restart the Phy Clock */
+	dwc_write_reg32(core_if->pcgcctl, 0);
+
+	/* Initialize Host Configuration Register */
+	init_fslspclksel(core_if);
+	if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL) {
+		hcfg.d32 = dwc_read_reg32(&host_if->host_global_regs->hcfg);
+		hcfg.b.fslssupp = 1;
+		dwc_write_reg32(&host_if->host_global_regs->hcfg, hcfg.d32);
+	}
+
+	/* Configure data FIFO sizes */
+	if (core_if->hwcfg2.b.dynamic_fifo && params->enable_dynamic_fifo) {
+		DWC_DEBUGPL(DBG_CIL, "Total FIFO Size=%d\n",
+			    core_if->total_fifo_size);
+		DWC_DEBUGPL(DBG_CIL, "Rx FIFO Size=%d\n",
+			    params->host_rx_fifo_size);
+		DWC_DEBUGPL(DBG_CIL, "NP Tx FIFO Size=%d\n",
+			    params->host_nperio_tx_fifo_size);
+		DWC_DEBUGPL(DBG_CIL, "P Tx FIFO Size=%d\n",
+			    params->host_perio_tx_fifo_size);
+
+		/* Rx FIFO */
+		DWC_DEBUGPL(DBG_CIL, "initial grxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->grxfsiz));
+		dwc_write_reg32(&global_regs->grxfsiz,
+				fifo_percentage(core_if->total_fifo_size,
+						dwc_param_host_rx_fifo_size_percentage));
+		DWC_DEBUGPL(DBG_CIL, "new grxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->grxfsiz));
+
+		/* Non-periodic Tx FIFO */
+		DWC_DEBUGPL(DBG_CIL, "initial gnptxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->gnptxfsiz));
+		nptxfifosize.b.depth =
+		    fifo_percentage(core_if->total_fifo_size,
+				    dwc_param_host_nperio_tx_fifo_size_percentage);
+		nptxfifosize.b.startaddr =
+		    dwc_read_reg32(&global_regs->grxfsiz);
+		dwc_write_reg32(&global_regs->gnptxfsiz, nptxfifosize.d32);
+		DWC_DEBUGPL(DBG_CIL, "new gnptxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->gnptxfsiz));
+
+		/* Periodic Tx FIFO */
+		DWC_DEBUGPL(DBG_CIL, "initial hptxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->hptxfsiz));
+		ptxfifosize.b.depth =
+		    core_if->total_fifo_size -
+		    dwc_read_reg32(&global_regs->grxfsiz) -
+		    nptxfifosize.b.depth;
+		ptxfifosize.b.startaddr =
+		    nptxfifosize.b.startaddr + nptxfifosize.b.depth;
+		dwc_write_reg32(&global_regs->hptxfsiz, ptxfifosize.d32);
+		DWC_DEBUGPL(DBG_CIL, "new hptxfsiz=%08x\n",
+			    dwc_read_reg32(&global_regs->hptxfsiz));
+	}
+
+	/* Clear Host Set HNP Enable in the OTG Control Register */
+	gotgctl.b.hstsethnpen = 1;
+	dwc_modify_reg32(&global_regs->gotgctl, gotgctl.d32, 0);
+
+	/* Make sure the FIFOs are flushed. */
+	dwc_otg_flush_tx_fifo(core_if, 0x10); /* all Tx FIFOs */
+	dwc_otg_flush_rx_fifo(core_if);
+
+	/* Flush out any leftover queued requests. */
+	num_channels = core_if->core_params->host_channels;
+	for (i = 0; i < num_channels; i++) {
+		hc_regs = core_if->host_if->hc_regs[i];
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hcchar.b.chen = 0;
+		hcchar.b.chdis = 1;
+		hcchar.b.epdir = 0;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+	}
+
+	/* Halt all channels to put them into a known state. */
+	for (i = 0; i < num_channels; i++) {
+		int count = 0;
+		hc_regs = core_if->host_if->hc_regs[i];
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hcchar.b.chen = 1;
+		hcchar.b.chdis = 1;
+		hcchar.b.epdir = 0;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+		DWC_DEBUGPL(DBG_HCDV, "%s: Halt channel %d\n", __func__, i);
+		do {
+			hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+			if (++count > 1000) {
+				DWC_ERROR
+				    ("%s: Unable to clear halt on channel %d\n",
+				     __func__, i);
+				break;
+			}
+		} while (hcchar.b.chen);
+	}
+
+	/* Turn on the vbus power. */
+	DWC_PRINT("Init: Port Power? op_state=%d\n", core_if->op_state);
+	if (core_if->op_state == A_HOST) {
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		DWC_PRINT("Init: Power Port (%d)\n", hprt0.b.prtpwr);
+		if (hprt0.b.prtpwr == 0) {
+			hprt0.b.prtpwr = 1;
+			dwc_write_reg32(host_if->hprt0, hprt0.d32);
+		}
+	}
+
+	dwc_otg_enable_host_interrupts(core_if);
+}
+
+/**
+ * Prepares a host channel for transferring packets to/from a specific
+ * endpoint. The HCCHARn register is set up with the characteristics specified
+ * in hc. Host channel interrupts that may need to be serviced while this
+ * transfer is in progress are enabled.
+ *
+ * @core_if: Programming view of DWC_otg controller
+ * @hc: Information needed to initialize the host channel
+ */
+void dwc_otg_hc_init(struct dwc_otg_core_if *core_if, struct dwc_hc *hc)
+{
+	uint32_t intr_enable;
+	union hcintmsk_data hc_intr_mask;
+	union gintmsk_data gintmsk = {.d32 = 0 };
+	union hcchar_data hcchar;
+	union hcsplt_data hcsplt;
+
+	uint8_t hc_num = hc->hc_num;
+	struct dwc_otg_host_if *host_if = core_if->host_if;
+	struct dwc_otg_hc_regs *hc_regs = host_if->hc_regs[hc_num];
+
+	/* Clear old interrupt conditions for this host channel. */
+	hc_intr_mask.d32 = 0xFFFFFFFF;
+	hc_intr_mask.b.reserved = 0;
+	dwc_write_reg32(&hc_regs->hcint, hc_intr_mask.d32);
+
+	/* Enable channel interrupts required for this transfer. */
+	hc_intr_mask.d32 = 0;
+	hc_intr_mask.b.chhltd = 1;
+	if (core_if->dma_enable) {
+		hc_intr_mask.b.ahberr = 1;
+		if (hc->error_state && !hc->do_split &&
+		    hc->ep_type != DWC_OTG_EP_TYPE_ISOC) {
+			hc_intr_mask.b.ack = 1;
+			if (hc->ep_is_in) {
+				hc_intr_mask.b.datatglerr = 1;
+				if (hc->ep_type != DWC_OTG_EP_TYPE_INTR)
+					hc_intr_mask.b.nak = 1;
+			}
+		}
+	} else {
+		switch (hc->ep_type) {
+		case DWC_OTG_EP_TYPE_CONTROL:
+		case DWC_OTG_EP_TYPE_BULK:
+			hc_intr_mask.b.xfercompl = 1;
+			hc_intr_mask.b.stall = 1;
+			hc_intr_mask.b.xacterr = 1;
+			hc_intr_mask.b.datatglerr = 1;
+			if (hc->ep_is_in) {
+				hc_intr_mask.b.bblerr = 1;
+			} else {
+				hc_intr_mask.b.nak = 1;
+				hc_intr_mask.b.nyet = 1;
+				if (hc->do_ping)
+					hc_intr_mask.b.ack = 1;
+			}
+
+			if (hc->do_split) {
+				hc_intr_mask.b.nak = 1;
+				if (hc->complete_split)
+					hc_intr_mask.b.nyet = 1;
+				else
+					hc_intr_mask.b.ack = 1;
+			}
+
+			if (hc->error_state)
+				hc_intr_mask.b.ack = 1;
+			break;
+		case DWC_OTG_EP_TYPE_INTR:
+			hc_intr_mask.b.xfercompl = 1;
+			hc_intr_mask.b.nak = 1;
+			hc_intr_mask.b.stall = 1;
+			hc_intr_mask.b.xacterr = 1;
+			hc_intr_mask.b.datatglerr = 1;
+			hc_intr_mask.b.frmovrun = 1;
+
+			if (hc->ep_is_in)
+				hc_intr_mask.b.bblerr = 1;
+			if (hc->error_state)
+				hc_intr_mask.b.ack = 1;
+			if (hc->do_split) {
+				if (hc->complete_split)
+					hc_intr_mask.b.nyet = 1;
+				else
+					hc_intr_mask.b.ack = 1;
+			}
+			break;
+		case DWC_OTG_EP_TYPE_ISOC:
+			hc_intr_mask.b.xfercompl = 1;
+			hc_intr_mask.b.frmovrun = 1;
+			hc_intr_mask.b.ack = 1;
+
+			if (hc->ep_is_in) {
+				hc_intr_mask.b.xacterr = 1;
+				hc_intr_mask.b.bblerr = 1;
+			}
+			break;
+		}
+	}
+	dwc_write_reg32(&hc_regs->hcintmsk, hc_intr_mask.d32);
+
+	/* Enable the top level host channel interrupt. */
+	intr_enable = (1 << hc_num);
+	dwc_modify_reg32(&host_if->host_global_regs->haintmsk, 0, intr_enable);
+
+	/* Make sure host channel interrupts are enabled. */
+	gintmsk.b.hcintr = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gintmsk, 0, gintmsk.d32);
+
+	/*
+	 * Program the HCCHARn register with the endpoint characteristics for
+	 * the current transfer.
+	 */
+	hcchar.d32 = 0;
+	hcchar.b.devaddr = hc->dev_addr;
+	hcchar.b.epnum = hc->ep_num;
+	hcchar.b.epdir = hc->ep_is_in;
+	hcchar.b.lspddev = (hc->speed == DWC_OTG_EP_SPEED_LOW);
+	hcchar.b.eptype = hc->ep_type;
+	hcchar.b.mps = hc->max_packet;
+
+	dwc_write_reg32(&host_if->hc_regs[hc_num]->hcchar, hcchar.d32);
+
+	DWC_DEBUGPL(DBG_HCDV, "%s: Channel %d\n", __func__, hc->hc_num);
+	DWC_DEBUGPL(DBG_HCDV, "  Dev Addr: %d\n", hcchar.b.devaddr);
+	DWC_DEBUGPL(DBG_HCDV, "  Ep Num: %d\n", hcchar.b.epnum);
+	DWC_DEBUGPL(DBG_HCDV, "  Is In: %d\n", hcchar.b.epdir);
+	DWC_DEBUGPL(DBG_HCDV, "  Is Low Speed: %d\n", hcchar.b.lspddev);
+	DWC_DEBUGPL(DBG_HCDV, "  Ep Type: %d\n", hcchar.b.eptype);
+	DWC_DEBUGPL(DBG_HCDV, "  Max Pkt: %d\n", hcchar.b.mps);
+	DWC_DEBUGPL(DBG_HCDV, "  Multi Cnt: %d\n", hcchar.b.multicnt);
+
+	/*
+	 * Program the HCSPLIT register for SPLITs
+	 */
+	hcsplt.d32 = 0;
+	if (hc->do_split) {
+		DWC_DEBUGPL(DBG_HCDV, "Programming HC %d with split --> %s\n",
+			    hc->hc_num,
+			    hc->complete_split ? "CSPLIT" : "SSPLIT");
+		hcsplt.b.compsplt = hc->complete_split;
+		hcsplt.b.xactpos = hc->xact_pos;
+		hcsplt.b.hubaddr = hc->hub_addr;
+		hcsplt.b.prtaddr = hc->port_addr;
+		DWC_DEBUGPL(DBG_HCDV, "   comp split %d\n",
+			    hc->complete_split);
+		DWC_DEBUGPL(DBG_HCDV, "   xact pos %d\n", hc->xact_pos);
+		DWC_DEBUGPL(DBG_HCDV, "   hub addr %d\n", hc->hub_addr);
+		DWC_DEBUGPL(DBG_HCDV, "   port addr %d\n", hc->port_addr);
+		DWC_DEBUGPL(DBG_HCDV, "   is_in %d\n", hc->ep_is_in);
+		DWC_DEBUGPL(DBG_HCDV, "   Max Pkt: %d\n", hcchar.b.mps);
+		DWC_DEBUGPL(DBG_HCDV, "   xferlen: %d\n", hc->xfer_len);
+	}
+	dwc_write_reg32(&host_if->hc_regs[hc_num]->hcsplt, hcsplt.d32);
+
+}
+
+/**
+ * Attempts to halt a host channel. This function should only be called in
+ * Slave mode or to abort a transfer in either Slave mode or DMA mode. Under
+ * normal circumstances in DMA mode, the controller halts the channel when the
+ * transfer is complete or a condition occurs that requires application
+ * intervention.
+ *
+ * In slave mode, checks for a free request queue entry, then sets the Channel
+ * Enable and Channel Disable bits of the Host Channel Characteristics
+ * register of the specified channel to intiate the halt. If there is no free
+ * request queue entry, sets only the Channel Disable bit of the HCCHARn
+ * register to flush requests for this channel. In the latter case, sets a
+ * flag to indicate that the host channel needs to be halted when a request
+ * queue slot is open.
+ *
+ * In DMA mode, always sets the Channel Enable and Channel Disable bits of the
+ * HCCHARn register. The controller ensures there is space in the request
+ * queue before submitting the halt request.
+ *
+ * Some time may elapse before the core flushes any posted requests for this
+ * host channel and halts. The Channel Halted interrupt handler completes the
+ * deactivation of the host channel.
+ *
+ * @core_if: Controller register interface.
+ * @hc: Host channel to halt.
+ * @halt_status: Reason for halting the channel.
+ */
+void dwc_otg_hc_halt(struct dwc_otg_core_if *core_if,
+		     struct dwc_hc *hc, enum dwc_otg_halt_status halt_status)
+{
+	union gnptxsts_data nptxsts;
+	union hptxsts_data hptxsts;
+	union hcchar_data hcchar;
+	struct dwc_otg_hc_regs *hc_regs;
+	struct dwc_otg_core_global_regs *global_regs;
+	struct dwc_otg_host_global_regs *host_global_regs;
+
+	hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+	global_regs = core_if->core_global_regs;
+	host_global_regs = core_if->host_if->host_global_regs;
+
+	WARN_ON(halt_status == DWC_OTG_HC_XFER_NO_HALT_STATUS);
+
+	if (halt_status == DWC_OTG_HC_XFER_URB_DEQUEUE ||
+	    halt_status == DWC_OTG_HC_XFER_AHB_ERR) {
+		/*
+		 * Disable all channel interrupts except Ch Halted. The QTD
+		 * and QH state associated with this transfer has been cleared
+		 * (in the case of URB_DEQUEUE), so the channel needs to be
+		 * shut down carefully to prevent crashes.
+		 */
+		union hcintmsk_data hcintmsk;
+		hcintmsk.d32 = 0;
+		hcintmsk.b.chhltd = 1;
+		dwc_write_reg32(&hc_regs->hcintmsk, hcintmsk.d32);
+
+		/*
+		 * Make sure no other interrupts besides halt are currently
+		 * pending. Handling another interrupt could cause a crash due
+		 * to the QTD and QH state.
+		 */
+		dwc_write_reg32(&hc_regs->hcint, ~hcintmsk.d32);
+
+		/*
+		 * Make sure the halt status is set to URB_DEQUEUE or AHB_ERR
+		 * even if the channel was already halted for some other
+		 * reason.
+		 */
+		hc->halt_status = halt_status;
+
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		if (hcchar.b.chen == 0) {
+			/*
+			 * The channel is either already halted or it hasn't
+			 * started yet. In DMA mode, the transfer may halt if
+			 * it finishes normally or a condition occurs that
+			 * requires driver intervention. Don't want to halt
+			 * the channel again. In either Slave or DMA mode,
+			 * it's possible that the transfer has been assigned
+			 * to a channel, but not started yet when an URB is
+			 * dequeued. Don't want to halt a channel that hasn't
+			 * started yet.
+			 */
+			return;
+		}
+	}
+
+	if (hc->halt_pending) {
+		/*
+		 * A halt has already been issued for this channel. This might
+		 * happen when a transfer is aborted by a higher level in
+		 * the stack.
+		 */
+#ifdef DEBUG
+		DWC_PRINT
+		    ("*** %s: Channel %d, hc->halt_pending already set ***\n",
+		     __func__, hc->hc_num);
+
+/* 		dwc_otg_dump_global_registers(core_if); */
+/* 		dwc_otg_dump_host_registers(core_if); */
+#endif
+		return;
+	}
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.chen = 1;
+	hcchar.b.chdis = 1;
+
+	if (!core_if->dma_enable) {
+		/* Check for space in the request queue to issue the halt. */
+		if (hc->ep_type == DWC_OTG_EP_TYPE_CONTROL ||
+		    hc->ep_type == DWC_OTG_EP_TYPE_BULK) {
+			nptxsts.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+			if (nptxsts.b.nptxqspcavail == 0)
+				hcchar.b.chen = 0;
+		} else {
+			hptxsts.d32 =
+			    dwc_read_reg32(&host_global_regs->hptxsts);
+			if ((hptxsts.b.ptxqspcavail == 0)
+			    || (core_if->queuing_high_bandwidth)) {
+				hcchar.b.chen = 0;
+			}
+		}
+	}
+
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	hc->halt_status = halt_status;
+
+	if (hcchar.b.chen) {
+		hc->halt_pending = 1;
+		hc->halt_on_queue = 0;
+	} else {
+		hc->halt_on_queue = 1;
+	}
+
+	DWC_DEBUGPL(DBG_HCDV, "%s: Channel %d\n", __func__, hc->hc_num);
+	DWC_DEBUGPL(DBG_HCDV, "  hcchar: 0x%08x\n", hcchar.d32);
+	DWC_DEBUGPL(DBG_HCDV, "  halt_pending: %d\n", hc->halt_pending);
+	DWC_DEBUGPL(DBG_HCDV, "  halt_on_queue: %d\n", hc->halt_on_queue);
+	DWC_DEBUGPL(DBG_HCDV, "  halt_status: %d\n", hc->halt_status);
+
+	return;
+}
+
+/**
+ * Clears the transfer state for a host channel. This function is normally
+ * called after a transfer is done and the host channel is being released.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @hc: Identifies the host channel to clean up.
+ */
+void dwc_otg_hc_cleanup(struct dwc_otg_core_if *core_if, struct dwc_hc *hc)
+{
+	struct dwc_otg_hc_regs *hc_regs;
+
+	hc->xfer_started = 0;
+
+	/*
+	 * Clear channel interrupt enables and any unhandled channel interrupt
+	 * conditions.
+	 */
+	hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+	dwc_write_reg32(&hc_regs->hcintmsk, 0);
+	dwc_write_reg32(&hc_regs->hcint, 0xFFFFFFFF);
+
+#ifdef DEBUG
+	del_timer(&core_if->hc_xfer_timer[hc->hc_num]);
+	{
+		union hcchar_data hcchar;
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		if (hcchar.b.chdis) {
+			DWC_WARN("%s: chdis set, channel %d, hcchar 0x%08x\n",
+				 __func__, hc->hc_num, hcchar.d32);
+		}
+	}
+#endif
+}
+
+/**
+ * Sets the channel property that indicates in which frame a periodic transfer
+ * should occur. This is always set to the _next_ frame. This function has no
+ * effect on non-periodic transfers.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @hc: Identifies the host channel to set up and its properties.
+ * @hcchar: Current value of the HCCHAR register for the specified host
+ * channel.
+ */
+static inline void hc_set_even_odd_frame(struct dwc_otg_core_if *core_if,
+					 struct dwc_hc *hc,
+					 union hcchar_data *hcchar)
+{
+	if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+	    hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+		union hfnum_data hfnum;
+		hfnum.d32 =
+		    dwc_read_reg32(&core_if->host_if->host_global_regs->hfnum);
+		/* 1 if _next_ frame is odd, 0 if it's even */
+		hcchar->b.oddfrm = (hfnum.b.frnum & 0x1) ? 0 : 1;
+#ifdef DEBUG
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR && hc->do_split
+		    && !hc->complete_split) {
+			switch (hfnum.b.frnum & 0x7) {
+			case 7:
+				core_if->hfnum_7_samples++;
+				core_if->hfnum_7_frrem_accum += hfnum.b.frrem;
+				break;
+			case 0:
+				core_if->hfnum_0_samples++;
+				core_if->hfnum_0_frrem_accum += hfnum.b.frrem;
+				break;
+			default:
+				core_if->hfnum_other_samples++;
+				core_if->hfnum_other_frrem_accum +=
+				    hfnum.b.frrem;
+				break;
+			}
+		}
+#endif
+	}
+}
+
+#ifdef DEBUG
+static void hc_xfer_timeout(unsigned long _ptr)
+{
+	struct hc_xfer_info *xfer_info = (struct hc_xfer_info *) _ptr;
+	int hc_num = xfer_info->hc->hc_num;
+	DWC_WARN("%s: timeout on channel %d\n", __func__, hc_num);
+	DWC_WARN("  start_hcchar_val 0x%08x\n",
+		 xfer_info->core_if->start_hcchar_val[hc_num]);
+}
+#endif
+
+/**
+ * This function does the setup for a data transfer for a host channel and
+ * starts the transfer. May be called in either Slave mode or DMA mode. In
+ * Slave mode, the caller must ensure that there is sufficient space in the
+ * request queue and Tx Data FIFO.
+ *
+ * For an OUT transfer in Slave mode, it loads a data packet into the
+ * appropriate FIFO. If necessary, additional data packets will be loaded in
+ * the Host ISR.
+ *
+ * For an IN transfer in Slave mode, a data packet is requested. The data
+ * packets are unloaded from the Rx FIFO in the Host ISR. If necessary,
+ * additional data packets are requested in the Host ISR.
+ *
+ * For a PING transfer in Slave mode, the Do Ping bit is set in the HCTSIZ
+ * register along with a packet count of 1 and the channel is enabled. This
+ * causes a single PING transaction to occur. Other fields in HCTSIZ are
+ * simply set to 0 since no data transfer occurs in this case.
+ *
+ * For a PING transfer in DMA mode, the HCTSIZ register is initialized with
+ * all the information required to perform the subsequent data transfer. In
+ * addition, the Do Ping bit is set in the HCTSIZ register. In this case, the
+ * controller performs the entire PING protocol, then starts the data
+ * transfer.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @hc: Information needed to initialize the host channel. The xfer_len
+ * value may be reduced to accommodate the max widths of the XferSize and
+ * PktCnt fields in the HCTSIZn register. The multi_count value may be changed
+ * to reflect the final xfer_len value.
+ */
+void dwc_otg_hc_start_transfer(struct dwc_otg_core_if *core_if,
+			       struct dwc_hc *hc)
+{
+	union hcchar_data hcchar;
+	union hctsiz_data hctsiz;
+	uint16_t num_packets;
+	uint32_t max_hc_xfer_size = core_if->core_params->max_transfer_size;
+	uint16_t max_hc_pkt_count = core_if->core_params->max_packet_count;
+	struct dwc_otg_hc_regs *hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+
+	hctsiz.d32 = 0;
+
+	if (hc->do_ping) {
+		if (!core_if->dma_enable) {
+			dwc_otg_hc_do_ping(core_if, hc);
+			hc->xfer_started = 1;
+			return;
+		} else {
+			hctsiz.b.dopng = 1;
+		}
+	}
+
+	if (hc->do_split) {
+		num_packets = 1;
+
+		if (hc->complete_split && !hc->ep_is_in) {
+			/* For CSPLIT OUT Transfer, set the size to 0 so the
+			 * core doesn't expect any data written to the FIFO */
+			hc->xfer_len = 0;
+		} else if (hc->ep_is_in || (hc->xfer_len > hc->max_packet)) {
+			hc->xfer_len = hc->max_packet;
+		} else if (!hc->ep_is_in && (hc->xfer_len > 188)) {
+			hc->xfer_len = 188;
+		}
+
+		hctsiz.b.xfersize = hc->xfer_len;
+	} else {
+		/*
+		 * Ensure that the transfer length and packet count will fit
+		 * in the widths allocated for them in the HCTSIZn register.
+		 */
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+		    hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			/*
+			 * Make sure the transfer size is no larger than one
+			 * (micro)frame's worth of data. (A check was done
+			 * when the periodic transfer was accepted to ensure
+			 * that a (micro)frame's worth of data can be
+			 * programmed into a channel.)
+			 */
+			uint32_t max_periodic_len =
+			    hc->multi_count * hc->max_packet;
+			if (hc->xfer_len > max_periodic_len)
+				hc->xfer_len = max_periodic_len;
+		} else if (hc->xfer_len > max_hc_xfer_size) {
+			/*
+			 * Make sure that xfer_len is a multiple of
+			 * max packet size.
+			 */
+			hc->xfer_len = max_hc_xfer_size - hc->max_packet + 1;
+		}
+
+		if (hc->xfer_len > 0) {
+			num_packets =
+			    (hc->xfer_len + hc->max_packet -
+			     1) / hc->max_packet;
+			if (num_packets > max_hc_pkt_count) {
+				num_packets = max_hc_pkt_count;
+				hc->xfer_len = num_packets * hc->max_packet;
+			}
+		} else {
+			/* Need 1 packet for transfer length of 0. */
+			num_packets = 1;
+		}
+
+		if (hc->ep_is_in) {
+			/*
+			 * Always program an integral # of max packets
+			 * for IN transfers.
+			 */
+			hc->xfer_len = num_packets * hc->max_packet;
+		}
+
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+		    hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			/*
+			 * Make sure that the multi_count field matches the
+			 * actual transfer length.
+			 */
+			hc->multi_count = num_packets;
+
+		}
+
+		if (hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			/* Set up the initial PID for the transfer. */
+			if (hc->speed == DWC_OTG_EP_SPEED_HIGH) {
+				if (hc->ep_is_in) {
+					if (hc->multi_count == 1) {
+						hc->data_pid_start =
+						    DWC_OTG_HC_PID_DATA0;
+					} else if (hc->multi_count == 2) {
+						hc->data_pid_start =
+						    DWC_OTG_HC_PID_DATA1;
+					} else {
+						hc->data_pid_start =
+						    DWC_OTG_HC_PID_DATA2;
+					}
+				} else {
+					if (hc->multi_count == 1) {
+						hc->data_pid_start =
+						    DWC_OTG_HC_PID_DATA0;
+					} else {
+						hc->data_pid_start =
+						    DWC_OTG_HC_PID_MDATA;
+					}
+				}
+			} else {
+				hc->data_pid_start = DWC_OTG_HC_PID_DATA0;
+			}
+		}
+
+		hctsiz.b.xfersize = hc->xfer_len;
+	}
+
+	hc->start_pkt_count = num_packets;
+	hctsiz.b.pktcnt = num_packets;
+	hctsiz.b.pid = hc->data_pid_start;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	DWC_DEBUGPL(DBG_HCDV, "%s: Channel %d\n", __func__, hc->hc_num);
+	DWC_DEBUGPL(DBG_HCDV, "  Xfer Size: %d\n", hctsiz.b.xfersize);
+	DWC_DEBUGPL(DBG_HCDV, "  Num Pkts: %d\n", hctsiz.b.pktcnt);
+	DWC_DEBUGPL(DBG_HCDV, "  Start PID: %d\n", hctsiz.b.pid);
+
+	if (core_if->dma_enable) {
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		/* Octeon uses external DMA */
+		const uint64_t USBN_DMA0_OUTB_CHN0 =
+		    CVMX_USBNX_DMA0_OUTB_CHN0(core_if->usb_num);
+		wmb();
+		cvmx_write_csr(USBN_DMA0_OUTB_CHN0 + hc->hc_num * 8,
+			       (unsigned long)hc->xfer_buff);
+		cvmx_read_csr(USBN_DMA0_OUTB_CHN0 + hc->hc_num * 8);
+		DWC_DEBUGPL(DBG_HCDV,
+			    "OUT: hc->hc_num = %d, hc->xfer_buff = %p\n",
+			    hc->hc_num, hc->xfer_buff);
+#else
+		dwc_write_reg32(&hc_regs->hcdma,
+				(uint32_t) (long)hc->xfer_buff);
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
+	}
+
+	/* Start the split */
+	if (hc->do_split) {
+		union hcsplt_data hcsplt;
+		hcsplt.d32 = dwc_read_reg32(&hc_regs->hcsplt);
+		hcsplt.b.spltena = 1;
+		dwc_write_reg32(&hc_regs->hcsplt, hcsplt.d32);
+	}
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.multicnt = hc->multi_count;
+	hc_set_even_odd_frame(core_if, hc, &hcchar);
+#ifdef DEBUG
+	core_if->start_hcchar_val[hc->hc_num] = hcchar.d32;
+	if (hcchar.b.chdis) {
+		DWC_WARN("%s: chdis set, channel %d, hcchar 0x%08x\n",
+			 __func__, hc->hc_num, hcchar.d32);
+	}
+#endif
+
+	/* Set host channel enable after all other setup is complete. */
+	hcchar.b.chen = 1;
+	hcchar.b.chdis = 0;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	hc->xfer_started = 1;
+	hc->requests++;
+
+	if (!core_if->dma_enable && !hc->ep_is_in && hc->xfer_len > 0) {
+		/* Load OUT packet into the appropriate Tx FIFO. */
+		dwc_otg_hc_write_packet(core_if, hc);
+	}
+#ifdef DEBUG
+	/* Start a timer for this transfer. */
+	core_if->hc_xfer_timer[hc->hc_num].function = hc_xfer_timeout;
+	core_if->hc_xfer_info[hc->hc_num].core_if = core_if;
+	core_if->hc_xfer_info[hc->hc_num].hc = hc;
+	core_if->hc_xfer_timer[hc->hc_num].data =
+	    (unsigned long)(&core_if->hc_xfer_info[hc->hc_num]);
+	core_if->hc_xfer_timer[hc->hc_num].expires = jiffies + (HZ * 10);
+	add_timer(&core_if->hc_xfer_timer[hc->hc_num]);
+#endif
+}
+
+/**
+ * This function continues a data transfer that was started by previous call
+ * to <code>dwc_otg_hc_start_transfer</code>. The caller must ensure there is
+ * sufficient space in the request queue and Tx Data FIFO. This function
+ * should only be called in Slave mode. In DMA mode, the controller acts
+ * autonomously to complete transfers programmed to a host channel.
+ *
+ * For an OUT transfer, a new data packet is loaded into the appropriate FIFO
+ * if there is any data remaining to be queued. For an IN transfer, another
+ * data packet is always requested. For the SETUP phase of a control transfer,
+ * this function does nothing.
+ *
+ * Returns 1 if a new request is queued, 0 if no more requests are required
+ * for this transfer.
+ */
+int dwc_otg_hc_continue_transfer(struct dwc_otg_core_if *core_if,
+				 struct dwc_hc *hc)
+{
+	DWC_DEBUGPL(DBG_HCDV, "%s: Channel %d\n", __func__, hc->hc_num);
+
+	if (hc->do_split) {
+		/* SPLITs always queue just once per channel */
+		return 0;
+	} else if (hc->data_pid_start == DWC_OTG_HC_PID_SETUP) {
+		/* SETUPs are queued only once since they can't be NAKed. */
+		return 0;
+	} else if (hc->ep_is_in) {
+		/*
+		 * Always queue another request for other IN transfers. If
+		 * back-to-back INs are issued and NAKs are received for both,
+		 * the driver may still be processing the first NAK when the
+		 * second NAK is received. When the interrupt handler clears
+		 * the NAK interrupt for the first NAK, the second NAK will
+		 * not be seen. So we can't depend on the NAK interrupt
+		 * handler to requeue a NAKed request. Instead, IN requests
+		 * are issued each time this function is called. When the
+		 * transfer completes, the extra requests for the channel will
+		 * be flushed.
+		 */
+		union hcchar_data hcchar;
+		struct dwc_otg_hc_regs *hc_regs =
+		    core_if->host_if->hc_regs[hc->hc_num];
+
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hc_set_even_odd_frame(core_if, hc, &hcchar);
+		hcchar.b.chen = 1;
+		hcchar.b.chdis = 0;
+		DWC_DEBUGPL(DBG_HCDV, "  IN xfer: hcchar = 0x%08x\n",
+			    hcchar.d32);
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+		hc->requests++;
+		return 1;
+	} else {
+		/* OUT transfers. */
+		if (hc->xfer_count < hc->xfer_len) {
+			if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+			    hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+				union hcchar_data hcchar;
+				struct dwc_otg_hc_regs *hc_regs;
+				hc_regs =
+				    core_if->host_if->hc_regs[hc->hc_num];
+				hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+				hc_set_even_odd_frame(core_if, hc, &hcchar);
+			}
+
+			/* Load OUT packet into the appropriate Tx FIFO. */
+			dwc_otg_hc_write_packet(core_if, hc);
+			hc->requests++;
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+}
+
+/**
+ * Starts a PING transfer. This function should only be called in Slave mode.
+ * The Do Ping bit is set in the HCTSIZ register, then the channel is enabled.
+ */
+void dwc_otg_hc_do_ping(struct dwc_otg_core_if *core_if, struct dwc_hc *hc)
+{
+	union hcchar_data hcchar;
+	union hctsiz_data hctsiz;
+	struct dwc_otg_hc_regs *hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+
+	DWC_DEBUGPL(DBG_HCDV, "%s: Channel %d\n", __func__, hc->hc_num);
+
+	hctsiz.d32 = 0;
+	hctsiz.b.dopng = 1;
+	hctsiz.b.pktcnt = 1;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.chen = 1;
+	hcchar.b.chdis = 0;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+}
+
+/*
+ * This function writes a packet into the Tx FIFO associated with the Host
+ * Channel. For a channel associated with a non-periodic EP, the non-periodic
+ * Tx FIFO is written. For a channel associated with a periodic EP, the
+ * periodic Tx FIFO is written. This function should only be called in Slave
+ * mode.
+ *
+ * Upon return the xfer_buff and xfer_count fields in hc are incremented by
+ * then number of bytes written to the Tx FIFO.
+ */
+void dwc_otg_hc_write_packet(struct dwc_otg_core_if *core_if, struct dwc_hc *hc)
+{
+	uint32_t i;
+	uint32_t remaining_count;
+	uint32_t byte_count;
+	uint32_t dword_count;
+
+	uint32_t *data_buff = (uint32_t *) (hc->xfer_buff);
+	uint32_t *data_fifo = core_if->data_fifo[hc->hc_num];
+
+	remaining_count = hc->xfer_len - hc->xfer_count;
+	if (remaining_count > hc->max_packet)
+		byte_count = hc->max_packet;
+	else
+		byte_count = remaining_count;
+
+	dword_count = (byte_count + 3) / 4;
+
+	if ((((unsigned long)data_buff) & 0x3) == 0) {
+		/* xfer_buff is DWORD aligned. */
+		for (i = 0; i < dword_count; i++, data_buff++)
+			dwc_write_reg32(data_fifo, *data_buff);
+	} else {
+		/* xfer_buff is not DWORD aligned. */
+		for (i = 0; i < dword_count; i++, data_buff++)
+			dwc_write_reg32(data_fifo, get_unaligned(data_buff));
+	}
+
+	hc->xfer_count += byte_count;
+	hc->xfer_buff += byte_count;
+}
+
+/**
+ * Gets the current USB frame number. This is the frame number from the last
+ * SOF packet.
+ */
+uint32_t dwc_otg_get_frame_number(struct dwc_otg_core_if *core_if)
+{
+	union dsts_data dsts;
+	dsts.d32 = dwc_read_reg32(&core_if->dev_if->dev_global_regs->dsts);
+
+	/* read current frame/microfreme number from DSTS register */
+	return dsts.b.soffn;
+}
+
+/**
+ * This function reads a setup packet from the Rx FIFO into the destination
+ * buffer.  This function is called from the Rx Status Queue Level (RxStsQLvl)
+ * Interrupt routine when a SETUP packet has been received in Slave mode.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @dest: Destination buffer for packet data.
+ */
+void dwc_otg_read_setup_packet(struct dwc_otg_core_if *core_if, uint32_t *dest)
+{
+	/* Get the 8 bytes of a setup transaction data */
+
+	/* Pop 2 DWORDS off the receive data FIFO into memory */
+	dest[0] = dwc_read_reg32(core_if->data_fifo[0]);
+	dest[1] = dwc_read_reg32(core_if->data_fifo[0]);
+}
+
+/**
+ * This function enables EP0 OUT to receive SETUP packets and configures EP0
+ * IN for transmitting packets.  It is normally called when the
+ * "Enumeration Done" interrupt occurs.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP0 data.
+ */
+void dwc_otg_ep0_activate(struct dwc_otg_core_if *core_if, struct dwc_ep *ep)
+{
+	struct dwc_otg_dev_if *dev_if = core_if->dev_if;
+	union dsts_data dsts;
+	union depctl_data diepctl;
+	union depctl_data doepctl;
+	union dctl_data dctl = {.d32 = 0 };
+
+	/* Read the Device Status and Endpoint 0 Control registers */
+	dsts.d32 = dwc_read_reg32(&dev_if->dev_global_regs->dsts);
+	diepctl.d32 = dwc_read_reg32(&dev_if->in_ep_regs[0]->diepctl);
+	doepctl.d32 = dwc_read_reg32(&dev_if->out_ep_regs[0]->doepctl);
+
+	/* Set the MPS of the IN EP based on the enumeration speed */
+	switch (dsts.b.enumspd) {
+	case DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ:
+	case DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ:
+	case DWC_DSTS_ENUMSPD_FS_PHY_48MHZ:
+		diepctl.b.mps = DWC_DEP0CTL_MPS_64;
+		break;
+	case DWC_DSTS_ENUMSPD_LS_PHY_6MHZ:
+		diepctl.b.mps = DWC_DEP0CTL_MPS_8;
+		break;
+	}
+
+	dwc_write_reg32(&dev_if->in_ep_regs[0]->diepctl, diepctl.d32);
+
+	/* Enable OUT EP for receive */
+	doepctl.b.epena = 1;
+	dwc_write_reg32(&dev_if->out_ep_regs[0]->doepctl, doepctl.d32);
+
+#ifdef VERBOSE
+	DWC_DEBUGPL(DBG_PCDV, "doepctl0=%0x\n",
+		    dwc_read_reg32(&dev_if->out_ep_regs[0]->doepctl));
+	DWC_DEBUGPL(DBG_PCDV, "diepctl0=%0x\n",
+		    dwc_read_reg32(&dev_if->in_ep_regs[0]->diepctl));
+#endif
+	dctl.b.cgnpinnak = 1;
+	dwc_modify_reg32(&dev_if->dev_global_regs->dctl, dctl.d32, dctl.d32);
+	DWC_DEBUGPL(DBG_PCDV, "dctl=%0x\n",
+		    dwc_read_reg32(&dev_if->dev_global_regs->dctl));
+}
+
+/**
+ * This function activates an EP.  The Device EP control register for
+ * the EP is configured as defined in the ep structure.  Note: This
+ * function is not used for EP0.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP to activate.
+ */
+void dwc_otg_ep_activate(struct dwc_otg_core_if *core_if, struct dwc_ep *ep)
+{
+	struct dwc_otg_dev_if *dev_if = core_if->dev_if;
+	union depctl_data depctl;
+	uint32_t *addr;
+	union daint_data daintmsk = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_PCDV, "%s() EP%d-%s\n", __func__, ep->num,
+		    (ep->is_in ? "IN" : "OUT"));
+
+	/* Read DEPCTLn register */
+	if (ep->is_in == 1) {
+		addr = &dev_if->in_ep_regs[ep->num]->diepctl;
+		daintmsk.ep.in = 1 << ep->num;
+	} else {
+		addr = &dev_if->out_ep_regs[ep->num]->doepctl;
+		daintmsk.ep.out = 1 << ep->num;
+	}
+
+	/* If the EP is already active don't change the EP Control
+	 * register. */
+	depctl.d32 = dwc_read_reg32(addr);
+	if (!depctl.b.usbactep) {
+		depctl.b.mps = ep->maxpacket;
+		depctl.b.eptype = ep->type;
+		depctl.b.txfnum = ep->tx_fifo_num;
+
+		if (ep->type != DWC_OTG_EP_TYPE_ISOC)
+			depctl.b.setd0pid = 1;
+
+		depctl.b.usbactep = 1;
+
+		dwc_write_reg32(addr, depctl.d32);
+		DWC_DEBUGPL(DBG_PCDV, "DEPCTL=%08x\n", dwc_read_reg32(addr));
+	}
+
+	/* Enable the Interrupt for this EP */
+	dwc_modify_reg32(&dev_if->dev_global_regs->daintmsk, 0, daintmsk.d32);
+	DWC_DEBUGPL(DBG_PCDV, "DAINTMSK=%0x\n",
+		    dwc_read_reg32(&dev_if->dev_global_regs->daintmsk));
+	return;
+}
+
+/**
+ * This function deactivates an EP.  This is done by clearing the USB Active
+ * EP bit in the Device EP control register.  Note: This function is not used
+ * for EP0. EP0 cannot be deactivated.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP to deactivate.
+ */
+void dwc_otg_ep_deactivate(struct dwc_otg_core_if *core_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl = {.d32 = 0 };
+	uint32_t *addr;
+	union daint_data daintmsk = {.d32 = 0 };
+
+	/* Read DEPCTLn register */
+	if (ep->is_in == 1) {
+		addr = &core_if->dev_if->in_ep_regs[ep->num]->diepctl;
+		daintmsk.ep.in = 1 << ep->num;
+	} else {
+		addr = &core_if->dev_if->out_ep_regs[ep->num]->doepctl;
+		daintmsk.ep.out = 1 << ep->num;
+	}
+
+	depctl.b.usbactep = 0;
+	dwc_write_reg32(addr, depctl.d32);
+
+	/* Disable the Interrupt for this EP */
+	dwc_modify_reg32(&core_if->dev_if->dev_global_regs->daintmsk,
+			 daintmsk.d32, 0);
+
+	return;
+}
+
+/**
+ * This function does the setup for a data transfer for an EP and
+ * starts the transfer.  For an IN transfer, the packets will be
+ * loaded into the appropriate Tx FIFO in the ISR. For OUT transfers,
+ * the packets are unloaded from the Rx FIFO in the ISR.  the ISR.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP to start the transfer on.
+ */
+void dwc_otg_ep_start_transfer(struct dwc_otg_core_if *core_if,
+			       struct dwc_ep *ep)
+{
+	/*
+	 * @todo Refactor this funciton to check the transfer size
+	 * count value does not execed the number bits in the Transfer
+	 * count register.
+	 */
+	union depctl_data depctl;
+	union deptsiz_data deptsiz;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+
+#ifdef CHECK_PACKET_COUNTER_WIDTH
+	const uint32_t MAX_XFER_SIZE = core_if->core_params->max_transfer_size;
+	const uint32_t MAX_PKT_COUNT = core_if->core_params->max_packet_count;
+	uint32_t num_packets;
+	uint32_t transfer_len;
+	struct dwc_otg_dev_out_ep_regs *out_regs =
+	    core_if->dev_if->out_ep_regs[ep->num];
+	struct dwc_otg_dev_in_ep_regs *in_regs =
+	    core_if->dev_if->in_ep_regs[ep->num];
+	union gnptxsts_data txstatus;
+
+	int lvl = SET_DEBUG_LEVEL(DBG_PCD);
+
+	DWC_DEBUGPL(DBG_PCD, "ep%d-%s xfer_len=%d xfer_cnt=%d "
+		    "xfer_buff=%p start_xfer_buff=%p\n",
+		    ep->num, (ep->is_in ? "IN" : "OUT"), ep->xfer_len,
+		    ep->xfer_count, ep->xfer_buff, ep->start_xfer_buff);
+
+	transfer_len = ep->xfer_len - ep->xfer_count;
+	if (transfer_len > MAX_XFER_SIZE)
+		transfer_len = MAX_XFER_SIZE;
+
+	if (transfer_len == 0) {
+		num_packets = 1;
+		/* OUT EP to recieve Zero-length packet set transfer
+		 * size to maxpacket size. */
+		if (!ep->is_in)
+			transfer_len = ep->maxpacket;
+	} else {
+		num_packets =
+		    (transfer_len + ep->maxpacket - 1) / ep->maxpacket;
+		if (num_packets > MAX_PKT_COUNT)
+			num_packets = MAX_PKT_COUNT;
+	}
+	DWC_DEBUGPL(DBG_PCD, "transfer_len=%d #pckt=%d\n", transfer_len,
+		    num_packets);
+
+	deptsiz.b.xfersize = transfer_len;
+	deptsiz.b.pktcnt = num_packets;
+
+	/* IN endpoint */
+	if (ep->is_in == 1) {
+		depctl.d32 = dwc_read_reg32(&in_regs->diepctl);
+	} else {		/* OUT endpoint */
+		depctl.d32 = dwc_read_reg32(&out_regs->doepctl);
+	}
+
+	/* EP enable, IN data in FIFO */
+	depctl.b.cnak = 1;
+	depctl.b.epena = 1;
+	/* IN endpoint */
+	if (ep->is_in == 1) {
+		txstatus.d32 =
+		    dwc_read_reg32(&core_if->core_global_regs->gnptxsts);
+		if (txstatus.b.nptxqspcavail == 0) {
+			DWC_DEBUGPL(DBG_ANY, "TX Queue Full (0x%0x)\n",
+				    txstatus.d32);
+			return;
+		}
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+		/*
+		 * Enable the Non-Periodic Tx FIFO empty interrupt, the
+		 * data will be written into the fifo by the ISR.
+		 */
+		if (core_if->dma_enable) {
+			dwc_write_reg32(&in_regs->diepdma,
+					(uint32_t) ep->xfer_buff);
+		} else {
+			intr_mask.b.nptxfempty = 1;
+			dwc_modify_reg32(&core_if->core_global_regs->gintsts,
+					 intr_mask.d32, 0);
+			dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+					 intr_mask.d32, intr_mask.d32);
+		}
+	} else {		/* OUT endpoint */
+		dwc_write_reg32(&out_regs->doeptsiz, deptsiz.d32);
+		dwc_write_reg32(&out_regs->doepctl, depctl.d32);
+		if (core_if->dma_enable) {
+			dwc_write_reg32(&out_regs->doepdma,
+					(uint32_t) ep->xfer_buff);
+		}
+	}
+	DWC_DEBUGPL(DBG_PCD, "DOEPCTL=%08x DOEPTSIZ=%08x\n",
+		    dwc_read_reg32(&out_regs->doepctl),
+		    dwc_read_reg32(&out_regs->doeptsiz));
+	DWC_DEBUGPL(DBG_PCD, "DAINTMSK=%08x GINTMSK=%08x\n",
+		    dwc_read_reg32(&core_if->dev_if->dev_global_regs->
+				   daintmsk),
+		    dwc_read_reg32(&core_if->core_global_regs->gintmsk));
+
+	SET_DEBUG_LEVEL(lvl);
+#endif
+	DWC_DEBUGPL((DBG_PCDV | DBG_CILV), "%s()\n", __func__);
+
+	DWC_DEBUGPL(DBG_PCD, "ep%d-%s xfer_len=%d xfer_cnt=%d "
+		    "xfer_buff=%p start_xfer_buff=%p\n",
+		    ep->num, (ep->is_in ? "IN" : "OUT"), ep->xfer_len,
+		    ep->xfer_count, ep->xfer_buff, ep->start_xfer_buff);
+
+	/* IN endpoint */
+	if (ep->is_in == 1) {
+		struct dwc_otg_dev_in_ep_regs *in_regs =
+		    core_if->dev_if->in_ep_regs[ep->num];
+		union gnptxsts_data txstatus;
+
+		txstatus.d32 =
+		    dwc_read_reg32(&core_if->core_global_regs->gnptxsts);
+		if (txstatus.b.nptxqspcavail == 0) {
+#ifdef DEBUG
+			DWC_PRINT("TX Queue Full (0x%0x)\n", txstatus.d32);
+#endif
+			return;
+		}
+
+		depctl.d32 = dwc_read_reg32(&(in_regs->diepctl));
+		deptsiz.d32 = dwc_read_reg32(&(in_regs->dieptsiz));
+
+		/* Zero Length Packet? */
+		if (ep->xfer_len == 0) {
+			deptsiz.b.xfersize = 0;
+			deptsiz.b.pktcnt = 1;
+		} else {
+
+			/* Program the transfer size and packet count
+			 *  as follows: xfersize = N * maxpacket +
+			 *  short_packet pktcnt = N + (short_packet
+			 *  exist ? 1 : 0)
+			 */
+			deptsiz.b.xfersize = ep->xfer_len;
+			deptsiz.b.pktcnt =
+			    (ep->xfer_len - 1 + ep->maxpacket) /
+			    ep->maxpacket;
+		}
+
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+
+		/* Write the DMA register */
+		if (core_if->dma_enable) {
+			dwc_write_reg32(&(in_regs->diepdma),
+					(uint32_t) ep->dma_addr);
+		} else {
+			/*
+			 * Enable the Non-Periodic Tx FIFO empty interrupt,
+			 * the data will be written into the fifo by the ISR.
+			 */
+			intr_mask.b.nptxfempty = 1;
+			dwc_modify_reg32(&core_if->core_global_regs->gintsts,
+					 intr_mask.d32, 0);
+			dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+					 intr_mask.d32, intr_mask.d32);
+		}
+
+		/* EP enable, IN data in FIFO */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+
+		depctl.d32 =
+		    dwc_read_reg32(&core_if->dev_if->in_ep_regs[0]->diepctl);
+		depctl.b.nextep = ep->num;
+		dwc_write_reg32(&core_if->dev_if->in_ep_regs[0]->diepctl,
+				depctl.d32);
+
+	} else {
+		/* OUT endpoint */
+		struct dwc_otg_dev_out_ep_regs *out_regs =
+		    core_if->dev_if->out_ep_regs[ep->num];
+
+		depctl.d32 = dwc_read_reg32(&(out_regs->doepctl));
+		deptsiz.d32 = dwc_read_reg32(&(out_regs->doeptsiz));
+
+		/* Program the transfer size and packet count as follows:
+		 *
+		 *  pktcnt = N
+		 *  xfersize = N * maxpacket
+		 */
+		if (ep->xfer_len == 0) {
+			/* Zero Length Packet */
+			deptsiz.b.xfersize = ep->maxpacket;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			deptsiz.b.pktcnt =
+			    (ep->xfer_len + (ep->maxpacket - 1)) /
+			    ep->maxpacket;
+			deptsiz.b.xfersize = deptsiz.b.pktcnt * ep->maxpacket;
+		}
+		dwc_write_reg32(&out_regs->doeptsiz, deptsiz.d32);
+
+		DWC_DEBUGPL(DBG_PCDV, "ep%d xfersize=%d pktcnt=%d\n",
+			    ep->num, deptsiz.b.xfersize, deptsiz.b.pktcnt);
+
+		if (core_if->dma_enable) {
+			dwc_write_reg32(&(out_regs->doepdma),
+					(uint32_t) ep->dma_addr);
+		}
+
+		if (ep->type == DWC_OTG_EP_TYPE_ISOC) {
+			/*
+			 * @todo NGS: dpid is read-only. Use setd0pid
+			 * or setd1pid.
+			 */
+			depctl.b.dpid = ep->even_odd_frame;
+		}
+
+		/* EP enable */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+
+		dwc_write_reg32(&out_regs->doepctl, depctl.d32);
+
+		DWC_DEBUGPL(DBG_PCD, "DOEPCTL=%08x DOEPTSIZ=%08x\n",
+			    dwc_read_reg32(&out_regs->doepctl),
+			    dwc_read_reg32(&out_regs->doeptsiz));
+		DWC_DEBUGPL(DBG_PCD, "DAINTMSK=%08x GINTMSK=%08x\n",
+			    dwc_read_reg32(&core_if->dev_if->dev_global_regs->
+					   daintmsk),
+			    dwc_read_reg32(&core_if->core_global_regs->
+					   gintmsk));
+	}
+}
+
+/**
+ * This function does the setup for a data transfer for EP0 and starts
+ * the transfer.  For an IN transfer, the packets will be loaded into
+ * the appropriate Tx FIFO in the ISR. For OUT transfers, the packets are
+ * unloaded from the Rx FIFO in the ISR.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP0 data.
+ */
+void dwc_otg_ep0_start_transfer(struct dwc_otg_core_if *core_if,
+				struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	union deptsiz0_data deptsiz;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_PCD, "ep%d-%s xfer_len=%d xfer_cnt=%d "
+		    "xfer_buff=%p start_xfer_buff=%p total_len=%d\n",
+		    ep->num, (ep->is_in ? "IN" : "OUT"), ep->xfer_len,
+		    ep->xfer_count, ep->xfer_buff, ep->start_xfer_buff,
+		    ep->total_len);
+	ep->total_len = ep->xfer_len;
+
+	/* IN endpoint */
+	if (ep->is_in == 1) {
+		struct dwc_otg_dev_in_ep_regs *in_regs =
+		    core_if->dev_if->in_ep_regs[0];
+		union gnptxsts_data tx_status = {.d32 = 0 };
+
+		tx_status.d32 =
+		    dwc_read_reg32(&core_if->core_global_regs->gnptxsts);
+		if (tx_status.b.nptxqspcavail == 0) {
+#ifdef DEBUG
+			deptsiz.d32 = dwc_read_reg32(&in_regs->dieptsiz);
+			DWC_DEBUGPL(DBG_PCD, "DIEPCTL0=%0x\n",
+				    dwc_read_reg32(&in_regs->diepctl));
+			DWC_DEBUGPL(DBG_PCD, "DIEPTSIZ0=%0x (sz=%d, pcnt=%d)\n",
+				    deptsiz.d32,
+				    deptsiz.b.xfersize, deptsiz.b.pktcnt);
+			DWC_PRINT("TX Queue or FIFO Full (0x%0x)\n",
+				  tx_status.d32);
+#endif
+
+			return;
+		}
+
+		depctl.d32 = dwc_read_reg32(&in_regs->diepctl);
+		deptsiz.d32 = dwc_read_reg32(&in_regs->dieptsiz);
+
+		/* Zero Length Packet? */
+		if (ep->xfer_len == 0) {
+			deptsiz.b.xfersize = 0;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			/* Program the transfer size and packet count
+			 *  as follows: xfersize = N * maxpacket +
+			 *  short_packet pktcnt = N + (short_packet
+			 *  exist ? 1 : 0)
+			 */
+			if (ep->xfer_len > ep->maxpacket) {
+				ep->xfer_len = ep->maxpacket;
+				deptsiz.b.xfersize = ep->maxpacket;
+			} else {
+				deptsiz.b.xfersize = ep->xfer_len;
+			}
+			deptsiz.b.pktcnt = 1;
+
+		}
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+		DWC_DEBUGPL(DBG_PCDV,
+			    "IN len=%d  xfersize=%d pktcnt=%d [%08x]\n",
+			    ep->xfer_len, deptsiz.b.xfersize, deptsiz.b.pktcnt,
+			    deptsiz.d32);
+
+		/* Write the DMA register */
+		if (core_if->dma_enable) {
+			dwc_write_reg32(&(in_regs->diepdma),
+					(uint32_t) ep->dma_addr);
+		}
+
+		/* EP enable, IN data in FIFO */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+
+		/*
+		 * Enable the Non-Periodic Tx FIFO empty interrupt, the
+		 * data will be written into the fifo by the ISR.
+		 */
+		if (!core_if->dma_enable) {
+			/* First clear it from GINTSTS */
+			intr_mask.b.nptxfempty = 1;
+			dwc_modify_reg32(&core_if->core_global_regs->gintsts,
+					 intr_mask.d32, 0);
+
+			dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+					 intr_mask.d32, intr_mask.d32);
+		}
+
+	} else {		/* OUT endpoint */
+		struct dwc_otg_dev_out_ep_regs *out_regs =
+		    core_if->dev_if->out_ep_regs[ep->num];
+
+		depctl.d32 = dwc_read_reg32(&out_regs->doepctl);
+		deptsiz.d32 = dwc_read_reg32(&out_regs->doeptsiz);
+
+		/* Program the transfer size and packet count as follows:
+		 *  xfersize = N * (maxpacket + 4 - (maxpacket % 4))
+		 *  pktcnt = N                                          */
+		if (ep->xfer_len == 0) {
+			/* Zero Length Packet */
+			deptsiz.b.xfersize = ep->maxpacket;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			deptsiz.b.pktcnt =
+			    (ep->xfer_len + (ep->maxpacket - 1)) /
+			    ep->maxpacket;
+			deptsiz.b.xfersize = deptsiz.b.pktcnt * ep->maxpacket;
+		}
+
+		dwc_write_reg32(&out_regs->doeptsiz, deptsiz.d32);
+		DWC_DEBUGPL(DBG_PCDV, "len=%d  xfersize=%d pktcnt=%d\n",
+			    ep->xfer_len,
+			    deptsiz.b.xfersize, deptsiz.b.pktcnt);
+
+		if (core_if->dma_enable) {
+			dwc_write_reg32(&(out_regs->doepdma),
+					(uint32_t) ep->dma_addr);
+		}
+
+		/* EP enable */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&(out_regs->doepctl), depctl.d32);
+	}
+}
+
+/**
+ * This function continues control IN transfers started by
+ * dwc_otg_ep0_start_transfer, when the transfer does not fit in a
+ * single packet.  NOTE: The DIEPCTL0/DOEPCTL0 registers only have one
+ * bit for the packet count.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP0 data.
+ */
+void dwc_otg_ep0_continue_transfer(struct dwc_otg_core_if *core_if,
+				   struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	union deptsiz0_data deptsiz;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+
+	if (ep->is_in == 1) {
+		struct dwc_otg_dev_in_ep_regs *in_regs =
+		    core_if->dev_if->in_ep_regs[0];
+		union gnptxsts_data tx_status = {.d32 = 0 };
+
+		tx_status.d32 =
+		    dwc_read_reg32(&core_if->core_global_regs->gnptxsts);
+		/*
+		 * @todo Should there be check for room in the Tx
+		 * Status Queue.  If not remove the code above this comment.
+		 */
+
+		depctl.d32 = dwc_read_reg32(&in_regs->diepctl);
+		deptsiz.d32 = dwc_read_reg32(&in_regs->dieptsiz);
+
+		/*
+		 * Program the transfer size and packet count
+		 * as follows: xfersize = N * maxpacket +
+		 * short_packet pktcnt = N + (short_packet
+		 * exist ? 1 : 0)
+		 */
+		deptsiz.b.xfersize =
+		    (ep->total_len - ep->xfer_count) >
+		    ep->maxpacket ? ep->maxpacket : (ep->total_len -
+						       ep->xfer_count);
+		deptsiz.b.pktcnt = 1;
+		ep->xfer_len += deptsiz.b.xfersize;
+
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+		DWC_DEBUGPL(DBG_PCDV,
+			    "IN len=%d  xfersize=%d pktcnt=%d [%08x]\n",
+			    ep->xfer_len, deptsiz.b.xfersize, deptsiz.b.pktcnt,
+			    deptsiz.d32);
+
+		/* Write the DMA register */
+		if (core_if->hwcfg2.b.architecture == DWC_INT_DMA_ARCH) {
+			dwc_write_reg32(&(in_regs->diepdma),
+					(uint32_t) ep->dma_addr);
+		}
+
+		/* EP enable, IN data in FIFO */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+
+		/*
+		 * Enable the Non-Periodic Tx FIFO empty interrupt, the
+		 * data will be written into the fifo by the ISR.
+		 */
+		if (!core_if->dma_enable) {
+			/* First clear it from GINTSTS */
+			intr_mask.b.nptxfempty = 1;
+			dwc_write_reg32(&core_if->core_global_regs->gintsts,
+					intr_mask.d32);
+
+			dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+					 intr_mask.d32, intr_mask.d32);
+		}
+
+	}
+
+}
+
+#ifdef DEBUG
+void dump_msg(const u8 *buf, unsigned int length)
+{
+	unsigned int start, num, i;
+	char line[52], *p;
+
+	if (length >= 512)
+		return;
+	start = 0;
+	while (length > 0) {
+		num = min(length, 16u);
+		p = line;
+		for (i = 0; i < num; ++i) {
+			if (i == 8)
+				*p++ = ' ';
+			sprintf(p, " %02x", buf[i]);
+			p += 3;
+		}
+		*p = 0;
+		DWC_PRINT("%6x: %s\n", start, line);
+		buf += num;
+		start += num;
+		length -= num;
+	}
+}
+#else
+static inline void dump_msg(const u8 *buf, unsigned int length)
+{
+}
+#endif
+
+/**
+ * This function writes a packet into the Tx FIFO associated with the
+ * EP.  For non-periodic EPs the non-periodic Tx FIFO is written.  For
+ * periodic EPs the periodic Tx FIFO associated with the EP is written
+ * with all packets for the next micro-frame.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP to write packet for.
+ * @_dma: Indicates if DMA is being used.
+ */
+void dwc_otg_ep_write_packet(struct dwc_otg_core_if *core_if,
+			     struct dwc_ep *ep,
+			     int _dma)
+{
+	/**
+	 * The buffer is padded to DWORD on a per packet basis in
+	 * slave/dma mode if the MPS is not DWORD aligned.  The last
+	 * packet, if short, is also padded to a multiple of DWORD.
+	 *
+	 * ep->xfer_buff always starts DWORD aligned in memory and is a
+	 * multiple of DWORD in length
+	 *
+	 * ep->xfer_len can be any number of bytes
+	 *
+	 * ep->xfer_count is a multiple of ep->maxpacket until the last
+	 *  packet
+	 *
+	 * FIFO access is DWORD */
+
+	uint32_t i;
+	uint32_t byte_count;
+	uint32_t dword_count;
+	uint32_t *fifo;
+	uint32_t *data_buff = (uint32_t *) ep->xfer_buff;
+
+	if (ep->xfer_count >= ep->xfer_len) {
+		DWC_WARN("%s() No data for EP%d!!!\n", __func__, ep->num);
+		return;
+	}
+
+	/* Find the byte length of the packet either short packet or MPS */
+	if ((ep->xfer_len - ep->xfer_count) < ep->maxpacket)
+		byte_count = ep->xfer_len - ep->xfer_count;
+	else
+		byte_count = ep->maxpacket;
+
+	/* Find the DWORD length, padded by extra bytes as neccessary if MPS
+	 * is not a multiple of DWORD */
+	dword_count = (byte_count + 3) / 4;
+
+#ifdef VERBOSE
+	dump_msg(ep->xfer_buff, byte_count);
+#endif
+	if (ep->type == DWC_OTG_EP_TYPE_ISOC)
+		/*
+		 *@todo NGS Where are the Periodic Tx FIFO addresses
+		 * intialized?  What should this be?
+		 */
+		fifo = core_if->data_fifo[ep->tx_fifo_num];
+	else
+		fifo = core_if->data_fifo[ep->num];
+
+	DWC_DEBUGPL((DBG_PCDV | DBG_CILV), "fifo=%p buff=%p *p=%08x bc=%d\n",
+		    fifo, data_buff, *data_buff, byte_count);
+
+	if (!_dma) {
+		for (i = 0; i < dword_count; i++, data_buff++)
+			dwc_write_reg32(fifo, *data_buff);
+	}
+
+	ep->xfer_count += byte_count;
+	ep->xfer_buff += byte_count;
+}
+
+/**
+ * Set the EP STALL.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP to set the stall on.
+ */
+void dwc_otg_ep_set_stall(struct dwc_otg_core_if *core_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	uint32_t *depctl_addr;
+
+	DWC_DEBUGPL(DBG_PCD, "%s ep%d-%s\n", __func__, ep->num,
+		    (ep->is_in ? "IN" : "OUT"));
+
+	if (ep->is_in == 1) {
+		depctl_addr =
+		    &(core_if->dev_if->in_ep_regs[ep->num]->diepctl);
+		depctl.d32 = dwc_read_reg32(depctl_addr);
+
+		/* set the disable and stall bits */
+		if (depctl.b.epena)
+			depctl.b.epdis = 1;
+		depctl.b.stall = 1;
+		dwc_write_reg32(depctl_addr, depctl.d32);
+
+	} else {
+		depctl_addr =
+		    &(core_if->dev_if->out_ep_regs[ep->num]->doepctl);
+		depctl.d32 = dwc_read_reg32(depctl_addr);
+
+		/* set the stall bit */
+		depctl.b.stall = 1;
+		dwc_write_reg32(depctl_addr, depctl.d32);
+	}
+	DWC_DEBUGPL(DBG_PCD, "DEPCTL=%0x\n", dwc_read_reg32(depctl_addr));
+	return;
+}
+
+/**
+ * Clear the EP STALL.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @ep: The EP to clear stall from.
+ */
+void dwc_otg_ep_clear_stall(struct dwc_otg_core_if *core_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	uint32_t *depctl_addr;
+
+	DWC_DEBUGPL(DBG_PCD, "%s ep%d-%s\n", __func__, ep->num,
+		    (ep->is_in ? "IN" : "OUT"));
+
+	if (ep->is_in == 1) {
+		depctl_addr =
+		    &(core_if->dev_if->in_ep_regs[ep->num]->diepctl);
+	} else {
+		depctl_addr =
+		    &(core_if->dev_if->out_ep_regs[ep->num]->doepctl);
+	}
+
+	depctl.d32 = dwc_read_reg32(depctl_addr);
+
+	/* clear the stall bits */
+	depctl.b.stall = 0;
+
+	/*
+	 * USB Spec 9.4.5: For endpoints using data toggle, regardless
+	 * of whether an endpoint has the Halt feature set, a
+	 * ClearFeature(ENDPOINT_HALT) request always results in the
+	 * data toggle being reinitialized to DATA0.
+	 */
+	if (ep->type == DWC_OTG_EP_TYPE_INTR ||
+	    ep->type == DWC_OTG_EP_TYPE_BULK) {
+		depctl.b.setd0pid = 1;	/* DATA0 */
+	}
+
+	dwc_write_reg32(depctl_addr, depctl.d32);
+	DWC_DEBUGPL(DBG_PCD, "DEPCTL=%0x\n", dwc_read_reg32(depctl_addr));
+	return;
+}
+
+/**
+ * This function reads a packet from the Rx FIFO into the destination
+ * buffer.  To read SETUP data use dwc_otg_read_setup_packet.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @dest:   Destination buffer for the packet.
+ * @bytes:  Number of bytes to copy to the destination.
+ */
+void dwc_otg_read_packet(struct dwc_otg_core_if *core_if,
+			 uint8_t *dest, uint16_t bytes)
+{
+	int i;
+	int word_count = (bytes + 3) / 4;
+
+	uint32_t *fifo = core_if->data_fifo[0];
+	uint32_t *data_buff = (uint32_t *) dest;
+
+	/**
+	 * @todo Account for the case where dest is not dword aligned. This
+	 * requires reading data from the FIFO into a uint32_t temp buffer,
+	 * then moving it into the data buffer.
+	 */
+
+	DWC_DEBUGPL((DBG_PCDV | DBG_CILV), "%s(%p,%p,%d)\n", __func__,
+		    core_if, dest, bytes);
+
+	for (i = 0; i < word_count; i++, data_buff++)
+		*data_buff = dwc_read_reg32(fifo);
+	return;
+}
+
+/**
+ * This functions reads the device registers and prints them
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+void dwc_otg_dump_dev_registers(struct dwc_otg_core_if *core_if)
+{
+	int i;
+	uint32_t *addr;
+
+	DWC_PRINT("Device Global Registers\n");
+	addr = &core_if->dev_if->dev_global_regs->dcfg;
+	DWC_PRINT("DCFG      @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->dev_if->dev_global_regs->dctl;
+	DWC_PRINT("DCTL      @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->dev_if->dev_global_regs->dsts;
+	DWC_PRINT("DSTS      @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->dev_if->dev_global_regs->diepmsk;
+	DWC_PRINT("DIEPMSK   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->dev_if->dev_global_regs->doepmsk;
+	DWC_PRINT("DOEPMSK   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->dev_if->dev_global_regs->daint;
+	DWC_PRINT("DAINT     @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->dev_if->dev_global_regs->dtknqr1;
+	DWC_PRINT("DTKNQR1   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	if (core_if->hwcfg2.b.dev_token_q_depth > 6) {
+		addr = &core_if->dev_if->dev_global_regs->dtknqr2;
+		DWC_PRINT("DTKNQR2   @%p : 0x%08X\n",
+			  addr, dwc_read_reg32(addr));
+	}
+
+	addr = &core_if->dev_if->dev_global_regs->dvbusdis;
+	DWC_PRINT("DVBUSID   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+
+	addr = &core_if->dev_if->dev_global_regs->dvbuspulse;
+	DWC_PRINT("DVBUSPULSE   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+
+	if (core_if->hwcfg2.b.dev_token_q_depth > 14) {
+		addr = &core_if->dev_if->dev_global_regs->dtknqr3;
+		DWC_PRINT("DTKNQR3   @%p : 0x%08X\n",
+			  addr, dwc_read_reg32(addr));
+	}
+
+	if (core_if->hwcfg2.b.dev_token_q_depth > 22) {
+		addr = &core_if->dev_if->dev_global_regs->dtknqr4;
+		DWC_PRINT("DTKNQR4   @%p : 0x%08X\n",
+			  addr, dwc_read_reg32(addr));
+	}
+
+	for (i = 0; i < core_if->dev_if->num_eps; i++) {
+		DWC_PRINT("Device IN EP %d Registers\n", i);
+		addr = &core_if->dev_if->in_ep_regs[i]->diepctl;
+		DWC_PRINT("DIEPCTL   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->in_ep_regs[i]->diepint;
+		DWC_PRINT("DIEPINT   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->in_ep_regs[i]->dieptsiz;
+		DWC_PRINT("DIETSIZ   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->in_ep_regs[i]->diepdma;
+		DWC_PRINT("DIEPDMA   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+
+		DWC_PRINT("Device OUT EP %d Registers\n", i);
+		addr = &core_if->dev_if->out_ep_regs[i]->doepctl;
+		DWC_PRINT("DOEPCTL   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->out_ep_regs[i]->doepfn;
+		DWC_PRINT("DOEPFN    @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->out_ep_regs[i]->doepint;
+		DWC_PRINT("DOEPINT   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->out_ep_regs[i]->doeptsiz;
+		DWC_PRINT("DOETSIZ   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->dev_if->out_ep_regs[i]->doepdma;
+		DWC_PRINT("DOEPDMA   @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+	}
+	return;
+}
+
+/**
+ * This function reads the host registers and prints them
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+void dwc_otg_dump_host_registers(struct dwc_otg_core_if *core_if)
+{
+	int i;
+	uint32_t *addr;
+
+	DWC_PRINT("Host Global Registers\n");
+	addr = &core_if->host_if->host_global_regs->hcfg;
+	DWC_PRINT("HCFG      @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->host_if->host_global_regs->hfir;
+	DWC_PRINT("HFIR      @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->host_if->host_global_regs->hfnum;
+	DWC_PRINT("HFNUM     @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->host_if->host_global_regs->hptxsts;
+	DWC_PRINT("HPTXSTS   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->host_if->host_global_regs->haint;
+	DWC_PRINT("HAINT     @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->host_if->host_global_regs->haintmsk;
+	DWC_PRINT("HAINTMSK  @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = core_if->host_if->hprt0;
+	DWC_PRINT("HPRT0     @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+
+	for (i = 0; i < core_if->core_params->host_channels; i++) {
+		DWC_PRINT("Host Channel %d Specific Registers\n", i);
+		addr = &core_if->host_if->hc_regs[i]->hcchar;
+		DWC_PRINT("HCCHAR    @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->host_if->hc_regs[i]->hcsplt;
+		DWC_PRINT("HCSPLT    @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->host_if->hc_regs[i]->hcint;
+		DWC_PRINT("HCINT     @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->host_if->hc_regs[i]->hcintmsk;
+		DWC_PRINT("HCINTMSK  @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->host_if->hc_regs[i]->hctsiz;
+		DWC_PRINT("HCTSIZ    @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+		addr = &core_if->host_if->hc_regs[i]->hcdma;
+		DWC_PRINT("HCDMA     @%p : 0x%08X\n", addr,
+			  dwc_read_reg32(addr));
+
+	}
+	return;
+}
+
+/**
+ * This function reads the core global registers and prints them
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+void dwc_otg_dump_global_registers(struct dwc_otg_core_if *core_if)
+{
+	int i;
+	uint32_t *addr;
+
+	DWC_PRINT("Core Global Registers\n");
+	addr = &core_if->core_global_regs->gotgctl;
+	DWC_PRINT("GOTGCTL   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gotgint;
+	DWC_PRINT("GOTGINT   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gahbcfg;
+	DWC_PRINT("GAHBCFG   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gusbcfg;
+	DWC_PRINT("GUSBCFG   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->grstctl;
+	DWC_PRINT("GRSTCTL   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gintsts;
+	DWC_PRINT("GINTSTS   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gintmsk;
+	DWC_PRINT("GINTMSK   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->grxstsr;
+	DWC_PRINT("GRXSTSR   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->grxfsiz;
+	DWC_PRINT("GRXFSIZ   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gnptxfsiz;
+	DWC_PRINT("GNPTXFSIZ @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gnptxsts;
+	DWC_PRINT("GNPTXSTS  @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gi2cctl;
+	DWC_PRINT("GI2CCTL   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gpvndctl;
+	DWC_PRINT("GPVNDCTL  @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->ggpio;
+	DWC_PRINT("GGPIO     @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->guid;
+	DWC_PRINT("GUID      @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->gsnpsid;
+	DWC_PRINT("GSNPSID   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->ghwcfg1;
+	DWC_PRINT("GHWCFG1   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->ghwcfg2;
+	DWC_PRINT("GHWCFG2   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->ghwcfg3;
+	DWC_PRINT("GHWCFG3   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->ghwcfg4;
+	DWC_PRINT("GHWCFG4   @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+	addr = &core_if->core_global_regs->hptxfsiz;
+	DWC_PRINT("HPTXFSIZ  @%p : 0x%08X\n", addr, dwc_read_reg32(addr));
+
+	for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+		addr = &core_if->core_global_regs->dptxfsiz[i];
+		DWC_PRINT("DPTXFSIZ[%d] @%p : 0x%08X\n", i, addr,
+			  dwc_read_reg32(addr));
+	}
+
+}
+
+/**
+ * Flush a Tx FIFO.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @_num: Tx FIFO to flush.
+ */
+extern void dwc_otg_flush_tx_fifo(struct dwc_otg_core_if *core_if, const int _num)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	DWC_DEBUGPL((DBG_CIL | DBG_PCDV), "Flush Tx FIFO %d\n", _num);
+
+	greset.b.txfflsh = 1;
+	greset.b.txfnum = _num;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			DWC_WARN("%s() HANG! GRSTCTL=%0x GNPTXSTS=0x%08x\n",
+				 __func__, greset.d32,
+				 dwc_read_reg32(&global_regs->gnptxsts));
+			break;
+		}
+
+	} while (greset.b.txfflsh == 1);
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+/**
+ * Flush Rx FIFO.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+extern void dwc_otg_flush_rx_fifo(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	DWC_DEBUGPL((DBG_CIL | DBG_PCDV), "%s\n", __func__);
+	/*
+	 *
+	 */
+	greset.b.rxfflsh = 1;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			DWC_WARN("%s() HANG! GRSTCTL=%0x\n", __func__,
+				 greset.d32);
+			break;
+		}
+	} while (greset.b.rxfflsh == 1);
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+/**
+ * Do core a soft reset of the core.  Be careful with this because it
+ * resets all the internal state machines of the core.
+ */
+void dwc_otg_core_reset(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	DWC_DEBUGPL(DBG_CILV, "%s\n", __func__);
+	/* Wait for AHB master IDLE state. */
+	do {
+		udelay(10);
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 100000) {
+			DWC_WARN("%s() HANG! AHB Idle GRSTCTL=%0x\n", __func__,
+				 greset.d32);
+			return;
+		}
+	} while (greset.b.ahbidle == 0);
+
+	/* Core Soft Reset */
+	count = 0;
+	greset.b.csftrst = 1;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			DWC_WARN("%s() HANG! Soft Reset GRSTCTL=%0x\n",
+				 __func__, greset.d32);
+			break;
+		}
+	} while (greset.b.csftrst == 1);
+	/* Wait for 3 PHY Clocks */
+	mdelay(100);
+}
+
+/**
+ * Register HCD callbacks.  The callbacks are used to start and stop
+ * the HCD for interrupt processing.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @_cb: the HCD callback structure.
+ * @_p: pointer to be passed to callback function (usb_hcd*).
+ */
+extern void dwc_otg_cil_register_hcd_callbacks(struct dwc_otg_core_if *core_if,
+					       struct dwc_otg_cil_callbacks *_cb,
+					       void *_p)
+{
+	core_if->hcd_cb = _cb;
+	_cb->p = _p;
+}
+
+/**
+ * Register PCD callbacks.  The callbacks are used to start and stop
+ * the PCD for interrupt processing.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ * @_cb: the PCD callback structure.
+ * @_p: pointer to be passed to callback function (pcd*).
+ */
+extern void dwc_otg_cil_register_pcd_callbacks(struct dwc_otg_core_if *core_if,
+					       struct dwc_otg_cil_callbacks *_cb,
+					       void *_p)
+{
+	core_if->pcd_cb = _cb;
+	_cb->p = _p;
+}
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_cil.h b/drivers/usb/host/dwc_otg/dwc_otg_cil.h
new file mode 100644
index 0000000..36ef561
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_cil.h
@@ -0,0 +1,866 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+#if !defined(__DWC_CIL_H__)
+#define __DWC_CIL_H__
+
+#include "dwc_otg_plat.h"
+#include "dwc_otg_regs.h"
+#ifdef DEBUG
+#include "linux/timer.h"
+#endif
+
+/*
+ * This file contains the interface to the Core Interface Layer.
+ */
+
+/**
+ * The <code>dwc_ep</code> structure represents the state of a single
+ * endpoint when acting in device mode. It contains the data items
+ * needed for an endpoint to be activated and transfer packets.
+ */
+struct dwc_ep {
+	/** EP number used for register address lookup */
+	uint8_t num;
+	/** EP direction 0 = OUT */
+	unsigned is_in:1;
+	/** EP active. */
+	unsigned active:1;
+
+	/*
+	 * Periodic Tx FIFO # for IN EPs For INTR EP set to 0 to use
+	 * non-periodic Tx FIFO
+	 */
+	unsigned tx_fifo_num:4;
+	/** EP type: 0 - Control, 1 - ISOC,  2 - BULK,  3 - INTR */
+	unsigned type:2;
+#define DWC_OTG_EP_TYPE_CONTROL    0
+#define DWC_OTG_EP_TYPE_ISOC       1
+#define DWC_OTG_EP_TYPE_BULK       2
+#define DWC_OTG_EP_TYPE_INTR       3
+
+	/** DATA start PID for INTR and BULK EP */
+	unsigned data_pid_start:1;
+	/** Frame (even/odd) for ISOC EP */
+	unsigned even_odd_frame:1;
+	/** Max Packet bytes */
+	unsigned maxpacket:11;
+
+	/** @name Transfer state */
+	/** @{ */
+
+	/**
+	 * Pointer to the beginning of the transfer buffer -- do not modify
+	 * during transfer.
+	 */
+
+	uint32_t dma_addr;
+
+	uint8_t *start_xfer_buff;
+	/** pointer to the transfer buffer */
+	uint8_t *xfer_buff;
+	/** Number of bytes to transfer */
+	unsigned xfer_len:19;
+	/** Number of bytes transferred. */
+	unsigned xfer_count:19;
+	/** Sent ZLP */
+	unsigned sent_zlp:1;
+	/** Total len for control transfer */
+	unsigned total_len:19;
+
+	/** @} */
+};
+
+/*
+ * Reasons for halting a host channel.
+ */
+enum dwc_otg_halt_status {
+	DWC_OTG_HC_XFER_NO_HALT_STATUS,
+	DWC_OTG_HC_XFER_COMPLETE,
+	DWC_OTG_HC_XFER_URB_COMPLETE,
+	DWC_OTG_HC_XFER_ACK,
+	DWC_OTG_HC_XFER_NAK,
+	DWC_OTG_HC_XFER_NYET,
+	DWC_OTG_HC_XFER_STALL,
+	DWC_OTG_HC_XFER_XACT_ERR,
+	DWC_OTG_HC_XFER_FRAME_OVERRUN,
+	DWC_OTG_HC_XFER_BABBLE_ERR,
+	DWC_OTG_HC_XFER_DATA_TOGGLE_ERR,
+	DWC_OTG_HC_XFER_AHB_ERR,
+	DWC_OTG_HC_XFER_PERIODIC_INCOMPLETE,
+	DWC_OTG_HC_XFER_URB_DEQUEUE
+};
+
+/**
+ * Host channel descriptor. This structure represents the state of a single
+ * host channel when acting in host mode. It contains the data items needed to
+ * transfer packets to an endpoint via a host channel.
+ */
+struct dwc_hc {
+	/** Host channel number used for register address lookup */
+	uint8_t hc_num;
+
+	/** Device to access */
+	unsigned dev_addr:7;
+
+	/** EP to access */
+	unsigned ep_num:4;
+
+	/** EP direction. 0: OUT, 1: IN */
+	unsigned ep_is_in:1;
+
+	/**
+	 * EP speed.
+	 * One of the following values:
+	 * 	- DWC_OTG_EP_SPEED_LOW
+	 *	- DWC_OTG_EP_SPEED_FULL
+	 *	- DWC_OTG_EP_SPEED_HIGH
+	 */
+	unsigned speed:2;
+#define DWC_OTG_EP_SPEED_LOW	0
+#define DWC_OTG_EP_SPEED_FULL	1
+#define DWC_OTG_EP_SPEED_HIGH	2
+
+	/**
+	 * Endpoint type.
+	 * One of the following values:
+	 *	- DWC_OTG_EP_TYPE_CONTROL: 0
+	 *	- DWC_OTG_EP_TYPE_ISOC: 1
+	 *	- DWC_OTG_EP_TYPE_BULK: 2
+	 *	- DWC_OTG_EP_TYPE_INTR: 3
+	 */
+	unsigned ep_type:2;
+
+	/** Max packet size in bytes */
+	unsigned max_packet:11;
+
+	/**
+	 * PID for initial transaction.
+	 * 0: DATA0,<br>
+	 * 1: DATA2,<br>
+	 * 2: DATA1,<br>
+	 * 3: MDATA (non-Control EP),
+	 *    SETUP (Control EP)
+	 */
+	unsigned data_pid_start:2;
+#define DWC_OTG_HC_PID_DATA0 0
+#define DWC_OTG_HC_PID_DATA2 1
+#define DWC_OTG_HC_PID_DATA1 2
+#define DWC_OTG_HC_PID_MDATA 3
+#define DWC_OTG_HC_PID_SETUP 3
+
+	/** Number of periodic transactions per (micro)frame */
+	unsigned multi_count:2;
+
+	/** @name Transfer State */
+	/** @{ */
+
+	/** Pointer to the current transfer buffer position. */
+	uint8_t *xfer_buff;
+	/** Total number of bytes to transfer. */
+	uint32_t xfer_len;
+	/** Number of bytes transferred so far. */
+	uint32_t xfer_count;
+	/** Packet count at start of transfer.*/
+	uint16_t start_pkt_count;
+
+	/**
+	 * Flag to indicate whether the transfer has been started. Set to 1 if
+	 * it has been started, 0 otherwise.
+	 */
+	uint8_t xfer_started;
+
+	/**
+	 * Set to 1 to indicate that a PING request should be issued on this
+	 * channel. If 0, process normally.
+	 */
+	uint8_t do_ping;
+
+	/**
+	 * Set to 1 to indicate that the error count for this transaction is
+	 * non-zero. Set to 0 if the error count is 0.
+	 */
+	uint8_t error_state;
+
+	/**
+	 * Set to 1 to indicate that this channel should be halted the next
+	 * time a request is queued for the channel. This is necessary in
+	 * slave mode if no request queue space is available when an attempt
+	 * is made to halt the channel.
+	 */
+	uint8_t halt_on_queue;
+
+	/**
+	 * Set to 1 if the host channel has been halted, but the core is not
+	 * finished flushing queued requests. Otherwise 0.
+	 */
+	uint8_t halt_pending;
+
+	/**
+	 * Reason for halting the host channel.
+	 */
+	enum dwc_otg_halt_status halt_status;
+
+	/*
+	 * Split settings for the host channel
+	 */
+	uint8_t do_split;	   /**< Enable split for the channel */
+	uint8_t complete_split;	   /**< Enable complete split */
+	uint8_t hub_addr;	   /**< Address of high speed hub */
+
+	uint8_t port_addr;	   /**< Port of the low/full speed device */
+	/** Split transaction position
+	 * One of the following values:
+	 *    - DWC_HCSPLIT_XACTPOS_MID
+	 *    - DWC_HCSPLIT_XACTPOS_BEGIN
+	 *    - DWC_HCSPLIT_XACTPOS_END
+	 *    - DWC_HCSPLIT_XACTPOS_ALL */
+	uint8_t xact_pos;
+
+	/** Set when the host channel does a short read. */
+	uint8_t short_read;
+
+	/**
+	 * Number of requests issued for this channel since it was assigned to
+	 * the current transfer (not counting PINGs).
+	 */
+	uint8_t requests;
+
+	/**
+	 * Queue Head for the transfer being processed by this channel.
+	 */
+	struct dwc_otg_qh *qh;
+
+	/** @} */
+
+	/** Entry in list of host channels. */
+	struct list_head hc_list_entry;
+};
+
+/**
+ * The following parameters may be specified when starting the module. These
+ * parameters define how the DWC_otg controller should be configured.
+ * Parameter values are passed to the CIL initialization function
+ * dwc_otg_cil_init.
+ */
+struct dwc_otg_core_params {
+	int32_t opt;
+#define dwc_param_opt_default 1
+
+	/*
+	 * Specifies the OTG capabilities. The driver will automatically
+	 * detect the value for this parameter if none is specified.
+	 * 0 - HNP and SRP capable (default)
+	 * 1 - SRP Only capable
+	 * 2 - No HNP/SRP capable
+	 */
+	int32_t otg_cap;
+#define DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE 0
+#define DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE 1
+#define DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE 2
+#define dwc_param_otg_cap_default DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE
+
+	/*
+	 * Specifies whether to use slave or DMA mode for accessing the data
+	 * FIFOs. The driver will automatically detect the value for this
+	 * parameter if none is specified.
+	 * 0 - Slave
+	 * 1 - DMA (default, if available)
+	 */
+	int32_t dma_enable;
+#define dwc_param_dma_enable_default 1
+
+	/*
+	 * The DMA Burst size (applicable only for External DMA
+	 * Mode). 1, 4, 8 16, 32, 64, 128, 256 (default 32)
+	 */
+	int32_t dma_burst_size;	/* Translate this to GAHBCFG values */
+#define dwc_param_dma_burst_size_default 32
+
+	/*
+	 * Specifies the maximum speed of operation in host and device mode.
+	 * The actual speed depends on the speed of the attached device and
+	 * the value of phy_type. The actual speed depends on the speed of the
+	 * attached device.
+	 * 0 - High Speed (default)
+	 * 1 - Full Speed
+	 */
+	int32_t speed;
+#define dwc_param_speed_default 0
+#define DWC_SPEED_PARAM_HIGH 0
+#define DWC_SPEED_PARAM_FULL 1
+
+	/** Specifies whether low power mode is supported when attached
+	 *  to a Full Speed or Low Speed device in host mode.
+	 * 0 - Don't support low power mode (default)
+	 * 1 - Support low power mode
+	 */
+	int32_t host_support_fs_ls_low_power;
+#define dwc_param_host_support_fs_ls_low_power_default 0
+
+	/** Specifies the PHY clock rate in low power mode when connected to a
+	 * Low Speed device in host mode. This parameter is applicable only if
+	 * HOST_SUPPORT_FS_LS_LOW_POWER is enabled.  If PHY_TYPE is set to FS
+	 * then defaults to 6 MHZ otherwise 48 MHZ.
+	 *
+	 * 0 - 48 MHz
+	 * 1 - 6 MHz
+	 */
+	int32_t host_ls_low_power_phy_clk;
+#define dwc_param_host_ls_low_power_phy_clk_default 0
+#define DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ 0
+#define DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ 1
+
+	/**
+	 * 0 - Use cC FIFO size parameters
+	 * 1 - Allow dynamic FIFO sizing (default)
+	 */
+	int32_t enable_dynamic_fifo;
+#define dwc_param_enable_dynamic_fifo_default 1
+
+	/** Total number of 4-byte words in the data FIFO memory. This
+	 * memory includes the Rx FIFO, non-periodic Tx FIFO, and periodic
+	 * Tx FIFOs.
+	 * 32 to 32768 (default 8192)
+	 * Note: The total FIFO memory depth in the FPGA configuration is 8192.
+	 */
+	int32_t data_fifo_size;
+#define dwc_param_data_fifo_size_default 8192
+
+	/** Number of 4-byte words in the Rx FIFO in device mode when dynamic
+	 * FIFO sizing is enabled.
+	 * 16 to 32768 (default 1064)
+	 */
+	int32_t dev_rx_fifo_size;
+#define dwc_param_dev_rx_fifo_size_default 1064
+
+	/** Number of 4-byte words in the non-periodic Tx FIFO in device mode
+	 * when dynamic FIFO sizing is enabled.
+	 * 16 to 32768 (default 1024)
+	 */
+	int32_t dev_nperio_tx_fifo_size;
+#define dwc_param_dev_nperio_tx_fifo_size_default 1024
+
+	/** Number of 4-byte words in each of the periodic Tx FIFOs in device
+	 * mode when dynamic FIFO sizing is enabled.
+	 * 4 to 768 (default 256)
+	 */
+	uint32_t dev_perio_tx_fifo_size[MAX_PERIO_FIFOS];
+#define dwc_param_dev_perio_tx_fifo_size_default 256
+
+	/** Number of 4-byte words in the Rx FIFO in host mode when dynamic
+	 * FIFO sizing is enabled.
+	 * 16 to 32768 (default 1024)
+	 */
+	int32_t host_rx_fifo_size;
+#define dwc_param_host_rx_fifo_size_default 1024
+#define dwc_param_host_rx_fifo_size_percentage 30
+
+	/** Number of 4-byte words in the non-periodic Tx FIFO in host mode
+	 * when Dynamic FIFO sizing is enabled in the core.
+	 * 16 to 32768 (default 1024)
+	 */
+	int32_t host_nperio_tx_fifo_size;
+#define dwc_param_host_nperio_tx_fifo_size_default 1024
+#define dwc_param_host_nperio_tx_fifo_size_percentage 40
+
+	/*
+	 * Number of 4-byte words in the host periodic Tx FIFO when dynamic
+	 * FIFO sizing is enabled.
+	 * 16 to 32768 (default 1024)
+	 */
+	int32_t host_perio_tx_fifo_size;
+#define dwc_param_host_perio_tx_fifo_size_default 1024
+#define dwc_param_host_perio_tx_fifo_size_percentage 30
+
+	/*
+	 * The maximum transfer size supported in bytes.
+	 * 2047 to 65,535  (default 65,535)
+	 */
+	int32_t max_transfer_size;
+#define dwc_param_max_transfer_size_default 65535
+
+	/*
+	 * The maximum number of packets in a transfer.
+	 * 15 to 511  (default 511)
+	 */
+	int32_t max_packet_count;
+#define dwc_param_max_packet_count_default 511
+
+	/*
+	 * The number of host channel registers to use.
+	 * 1 to 16 (default 12)
+	 * Note: The FPGA configuration supports a maximum of 12 host channels.
+	 */
+	int32_t host_channels;
+#define dwc_param_host_channels_default 12
+
+	/*
+	 * The number of endpoints in addition to EP0 available for device
+	 * mode operations.
+	 * 1 to 15 (default 6 IN and OUT)
+	 * Note: The FPGA configuration supports a maximum of 6 IN and OUT
+	 * endpoints in addition to EP0.
+	 */
+	int32_t dev_endpoints;
+#define dwc_param_dev_endpoints_default 6
+
+	/*
+	 * Specifies the type of PHY interface to use. By default, the driver
+	 * will automatically detect the phy_type.
+	 *
+	 * 0 - Full Speed PHY
+	 * 1 - UTMI+ (default)
+	 * 2 - ULPI
+	 */
+	int32_t phy_type;
+#define DWC_PHY_TYPE_PARAM_FS 0
+#define DWC_PHY_TYPE_PARAM_UTMI 1
+#define DWC_PHY_TYPE_PARAM_ULPI 2
+#define dwc_param_phy_type_default DWC_PHY_TYPE_PARAM_UTMI
+
+	/*
+	 * Specifies the UTMI+ Data Width.  This parameter is
+	 * applicable for a PHY_TYPE of UTMI+ or ULPI. (For a ULPI
+	 * PHY_TYPE, this parameter indicates the data width between
+	 * the MAC and the ULPI Wrapper.) Also, this parameter is
+	 * applicable only if the OTG_HSPHY_WIDTH cC parameter was set
+	 * to "8 and 16 bits", meaning that the core has been
+	 * configured to work at either data path width.
+	 *
+	 * 8 or 16 bits (default 16)
+	 */
+	int32_t phy_utmi_width;
+#define dwc_param_phy_utmi_width_default 16
+
+	/*
+	 * Specifies whether the ULPI operates at double or single
+	 * data rate. This parameter is only applicable if PHY_TYPE is
+	 * ULPI.
+	 *
+	 * 0 - single data rate ULPI interface with 8 bit wide data
+	 * bus (default)
+	 * 1 - double data rate ULPI interface with 4 bit wide data
+	 * bus
+	 */
+	int32_t phy_ulpi_ddr;
+#define dwc_param_phy_ulpi_ddr_default 0
+
+	/*
+	 * Specifies whether to use the internal or external supply to
+	 * drive the vbus with a ULPI phy.
+	 */
+	int32_t phy_ulpi_ext_vbus;
+#define DWC_PHY_ULPI_INTERNAL_VBUS 0
+#define DWC_PHY_ULPI_EXTERNAL_VBUS 1
+#define dwc_param_phy_ulpi_ext_vbus_default DWC_PHY_ULPI_INTERNAL_VBUS
+
+	/*
+	 * Specifies whether to use the I2Cinterface for full speed PHY. This
+	 * parameter is only applicable if PHY_TYPE is FS.
+	 * 0 - No (default)
+	 * 1 - Yes
+	 */
+	int32_t i2c_enable;
+#define dwc_param_i2c_enable_default 0
+
+	int32_t ulpi_fs_ls;
+#define dwc_param_ulpi_fs_ls_default 0
+
+	int32_t ts_dline;
+#define dwc_param_ts_dline_default 0
+
+};
+
+/**
+ * The FIFOs are established based on a default percentage of the total
+ * FIFO depth. This check insures that the defaults are reasonable.
+ */
+#if (((dwc_param_host_rx_fifo_size_percentage) \
+     +(dwc_param_host_nperio_tx_fifo_size_percentage) \
+     +(dwc_param_host_perio_tx_fifo_size_percentage)) > 100)
+#error Invalid FIFO allocation
+#endif
+
+#ifdef DEBUG
+struct dwc_otg_core_if;
+struct hc_xfer_info {
+	struct dwc_otg_core_if *core_if;
+	struct dwc_hc *hc;
+};
+#endif
+
+/*
+ * The <code>dwc_otg_core_if</code> structure contains information
+ * needed to manage the DWC_otg controller acting in either host or
+ * device mode. It represents the programming view of the controller
+ * as a whole.
+ */
+struct dwc_otg_core_if {
+	/** USB block index number for Octeon's that support multiple */
+	int usb_num;
+
+	/** Parameters that define how the core should be configured.*/
+	struct dwc_otg_core_params *core_params;
+
+	/** Core Global registers starting at offset 000h. */
+	struct dwc_otg_core_global_regs *core_global_regs;
+
+	/** Device-specific information */
+	struct dwc_otg_dev_if *dev_if;
+	/** Host-specific information */
+	struct dwc_otg_host_if *host_if;
+
+	/*
+	 * Set to 1 if the core PHY interface bits in USBCFG have been
+	 * initialized.
+	 */
+	uint8_t phy_init_done;
+
+	/*
+	 * SRP Success flag, set by srp success interrupt in FS I2C mode
+	 */
+	uint8_t srp_success;
+	uint8_t srp_timer_started;
+
+	/* Common configuration information */
+	/** Power and Clock Gating Control Register */
+	uint32_t *pcgcctl;
+#define DWC_OTG_PCGCCTL_OFFSET 0xE00
+
+	/** Push/pop addresses for endpoints or host channels.*/
+	uint32_t *data_fifo[MAX_EPS_CHANNELS];
+#define DWC_OTG_DATA_FIFO_OFFSET 0x1000
+#define DWC_OTG_DATA_FIFO_SIZE 0x1000
+
+	/** Total RAM for FIFOs (Bytes) */
+	uint16_t total_fifo_size;
+	/** Size of Rx FIFO (Bytes) */
+	uint16_t rx_fifo_size;
+	/** Size of Non-periodic Tx FIFO (Bytes) */
+	uint16_t nperio_tx_fifo_size;
+
+	/** 1 if DMA is enabled, 0 otherwise. */
+	uint8_t dma_enable;
+
+	/** Set to 1 if multiple packets of a high-bandwidth transfer is in
+	 * process of being queued */
+	uint8_t queuing_high_bandwidth;
+
+	/** Hardware Configuration -- stored here for convenience.*/
+	union hwcfg1_data hwcfg1;
+	union hwcfg2_data hwcfg2;
+	union hwcfg3_data hwcfg3;
+	union hwcfg4_data hwcfg4;
+
+	/*
+	 * The operational State, during transations
+	 * (a_host>>a_peripherial and b_device=>b_host) this may not
+	 * match the core but allows the software to determine
+	 * transitions.
+	 */
+	uint8_t op_state;
+
+	/*
+	 * Set to 1 if the HCD needs to be restarted on a session request
+	 * interrupt. This is required if no connector ID status change has
+	 * occurred since the HCD was last disconnected.
+	 */
+	uint8_t restart_hcd_on_session_req;
+
+	/** HCD callbacks */
+	/** A-Device is a_host */
+#define A_HOST 		(1)
+	/** A-Device is a_suspend */
+#define A_SUSPEND 	(2)
+	/** A-Device is a_peripherial */
+#define A_PERIPHERAL 	(3)
+	/** B-Device is operating as a Peripheral. */
+#define B_PERIPHERAL	(4)
+	/** B-Device is operating as a Host. */
+#define B_HOST 		(5)
+
+	/** HCD callbacks */
+	struct dwc_otg_cil_callbacks *hcd_cb;
+	/** PCD callbacks */
+	struct dwc_otg_cil_callbacks *pcd_cb;
+
+#ifdef DEBUG
+	uint32_t start_hcchar_val[MAX_EPS_CHANNELS];
+
+	struct hc_xfer_info hc_xfer_info[MAX_EPS_CHANNELS];
+	struct timer_list hc_xfer_timer[MAX_EPS_CHANNELS];
+
+	uint32_t hfnum_7_samples;
+	uint64_t hfnum_7_frrem_accum;
+	uint32_t hfnum_0_samples;
+	uint64_t hfnum_0_frrem_accum;
+	uint32_t hfnum_other_samples;
+	uint64_t hfnum_other_frrem_accum;
+#endif
+
+};
+
+/*
+ * The following functions support initialization of the CIL driver component
+ * and the DWC_otg controller.
+ */
+extern struct dwc_otg_core_if *dwc_otg_cil_init(const uint32_t *reg_base_addr,
+					   struct dwc_otg_core_params *
+					   _core_params);
+extern void dwc_otg_cil_remove(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_core_init(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_core_host_init(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_core_dev_init(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_enable_global_interrupts(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_disable_global_interrupts(struct dwc_otg_core_if *core_if);
+
+/* Device CIL Functions
+ * The following functions support managing the DWC_otg controller in device
+ * mode.
+ */
+
+extern void dwc_otg_wakeup(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_read_setup_packet(struct dwc_otg_core_if *core_if,
+				      uint32_t *dest);
+extern uint32_t dwc_otg_get_frame_number(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_ep0_activate(struct dwc_otg_core_if *core_if,
+				 struct dwc_ep *ep);
+extern void dwc_otg_ep_activate(struct dwc_otg_core_if *core_if,
+				struct dwc_ep *ep);
+extern void dwc_otg_ep_deactivate(struct dwc_otg_core_if *core_if,
+				  struct dwc_ep *ep);
+extern void dwc_otg_ep_start_transfer(struct dwc_otg_core_if *core_if,
+				      struct dwc_ep *ep);
+extern void dwc_otg_ep0_start_transfer(struct dwc_otg_core_if *core_if,
+				       struct dwc_ep *ep);
+extern void dwc_otg_ep0_continue_transfer(struct dwc_otg_core_if *core_if,
+					  struct dwc_ep *ep);
+extern void dwc_otg_ep_write_packet(struct dwc_otg_core_if *core_if,
+				    struct dwc_ep *ep, int _dma);
+extern void dwc_otg_ep_set_stall(struct dwc_otg_core_if *core_if,
+				 struct dwc_ep *ep);
+extern void dwc_otg_ep_clear_stall(struct dwc_otg_core_if *core_if,
+				   struct dwc_ep *ep);
+extern void dwc_otg_enable_device_interrupts(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_dump_dev_registers(struct dwc_otg_core_if *core_if);
+
+/* Host CIL Functions
+ * The following functions support managing the DWC_otg controller in host
+ * mode.
+ */
+
+extern void dwc_otg_hc_init(struct dwc_otg_core_if *core_if, struct dwc_hc *hc);
+extern void dwc_otg_hc_halt(struct dwc_otg_core_if *core_if,
+			    struct dwc_hc *hc,
+			    enum dwc_otg_halt_status halt_status);
+extern void dwc_otg_hc_cleanup(struct dwc_otg_core_if *core_if,
+			       struct dwc_hc *hc);
+extern void dwc_otg_hc_start_transfer(struct dwc_otg_core_if *core_if,
+				      struct dwc_hc *hc);
+extern int dwc_otg_hc_continue_transfer(struct dwc_otg_core_if *core_if,
+					struct dwc_hc *hc);
+extern void dwc_otg_hc_do_ping(struct dwc_otg_core_if *core_if,
+			       struct dwc_hc *hc);
+extern void dwc_otg_hc_write_packet(struct dwc_otg_core_if *core_if,
+				    struct dwc_hc *hc);
+extern void dwc_otg_enable_host_interrupts(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_disable_host_interrupts(struct dwc_otg_core_if *core_if);
+
+/**
+ * This function Reads HPRT0 in preparation to modify.  It keeps the
+ * WC bits 0 so that if they are read as 1, they won't clear when you
+ * write it back
+ */
+static inline uint32_t dwc_otg_read_hprt0(struct dwc_otg_core_if *core_if)
+{
+	union hprt0_data hprt0;
+	hprt0.d32 = dwc_read_reg32(core_if->host_if->hprt0);
+	hprt0.b.prtena = 0;
+	hprt0.b.prtconndet = 0;
+	hprt0.b.prtenchng = 0;
+	hprt0.b.prtovrcurrchng = 0;
+	return hprt0.d32;
+}
+
+extern void dwc_otg_dump_host_registers(struct dwc_otg_core_if *core_if);
+
+/* Common CIL Functions
+ * The following functions support managing the DWC_otg controller in either
+ * device or host mode.
+ */
+
+
+extern void dwc_otg_read_packet(struct dwc_otg_core_if *core_if,
+				uint8_t *dest, uint16_t bytes);
+
+extern void dwc_otg_dump_global_registers(struct dwc_otg_core_if *core_if);
+
+extern void dwc_otg_flush_tx_fifo(struct dwc_otg_core_if *core_if,
+				  const int _num);
+extern void dwc_otg_flush_rx_fifo(struct dwc_otg_core_if *core_if);
+extern void dwc_otg_core_reset(struct dwc_otg_core_if *core_if);
+
+/**
+ * This function returns the Core Interrupt register.
+ */
+static inline uint32_t dwc_otg_read_core_intr(struct dwc_otg_core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gintsts) &
+		dwc_read_reg32(&core_if->core_global_regs->gintmsk);
+}
+
+/**
+ * This function returns the OTG Interrupt register.
+ */
+static inline uint32_t dwc_otg_read_otg_intr(struct dwc_otg_core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gotgint);
+}
+
+/**
+ * This function reads the Device All Endpoints Interrupt register and
+ * returns the IN endpoint interrupt bits.
+ */
+static inline uint32_t dwc_otg_read_dev_all_in_ep_intr(struct dwc_otg_core_if *
+						       core_if)
+{
+	uint32_t v;
+	v = dwc_read_reg32(&core_if->dev_if->dev_global_regs->daint) &
+	    dwc_read_reg32(&core_if->dev_if->dev_global_regs->daintmsk);
+	return v & 0xffff;
+
+}
+
+/**
+ * This function reads the Device All Endpoints Interrupt register and
+ * returns the OUT endpoint interrupt bits.
+ */
+static inline uint32_t
+dwc_otg_read_dev_all_out_ep_intr(struct dwc_otg_core_if *core_if)
+{
+	uint32_t v;
+	v = dwc_read_reg32(&core_if->dev_if->dev_global_regs->daint) &
+	    dwc_read_reg32(&core_if->dev_if->dev_global_regs->daintmsk);
+	return (v & 0xffff0000) >> 16;
+}
+
+/**
+ * This function returns the Device IN EP Interrupt register
+ */
+static inline uint32_t
+dwc_otg_read_dev_in_ep_intr(struct dwc_otg_core_if *core_if, struct dwc_ep *ep)
+{
+	struct dwc_otg_dev_if *dev_if = core_if->dev_if;
+	uint32_t v;
+	v = dwc_read_reg32(&dev_if->in_ep_regs[ep->num]->diepint) &
+	    dwc_read_reg32(&dev_if->dev_global_regs->diepmsk);
+	return v;
+}
+
+/**
+ * This function returns the Device OUT EP Interrupt register
+ */
+static inline uint32_t dwc_otg_read_dev_out_ep_intr(struct dwc_otg_core_if *
+						    core_if, struct dwc_ep *ep)
+{
+	struct dwc_otg_dev_if *dev_if = core_if->dev_if;
+	uint32_t v;
+	v = dwc_read_reg32(&dev_if->out_ep_regs[ep->num]->doepint) &
+	    dwc_read_reg32(&dev_if->dev_global_regs->diepmsk);
+	return v;
+}
+
+/**
+ * This function returns the Host All Channel Interrupt register
+ */
+static inline uint32_t
+dwc_otg_read_host_all_channels_intr(struct dwc_otg_core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->host_if->host_global_regs->haint);
+}
+
+static inline uint32_t
+dwc_otg_read_host_channel_intr(struct dwc_otg_core_if *core_if,
+			       struct dwc_hc *hc)
+{
+	return dwc_read_reg32(&core_if->host_if->hc_regs[hc->hc_num]->hcint);
+}
+
+/**
+ * This function returns the mode of the operation, host or device.
+ *
+ * Returns 0 - Device Mode, 1 - Host Mode
+ */
+static inline uint32_t dwc_otg_mode(struct dwc_otg_core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gintsts) & 0x1;
+}
+
+static inline uint8_t dwc_otg_is_device_mode(struct dwc_otg_core_if *core_if)
+{
+	return dwc_otg_mode(core_if) != DWC_HOST_MODE;
+}
+
+static inline uint8_t dwc_otg_is_host_mode(struct dwc_otg_core_if *core_if)
+{
+	return dwc_otg_mode(core_if) == DWC_HOST_MODE;
+}
+
+extern int32_t dwc_otg_handle_common_intr(struct dwc_otg_core_if *core_if);
+
+/*
+ * DWC_otg CIL callback structure.  This structure allows the HCD and
+ * PCD to register functions used for starting and stopping the PCD
+ * and HCD for role change on for a DRD.
+ */
+struct dwc_otg_cil_callbacks {
+	/* Start function for role change */
+	int (*start) (void *p);
+	/* Stop Function for role change */
+	int (*stop) (void *p);
+	/* Disconnect Function for role change */
+	int (*disconnect) (void *p);
+	/* Resume/Remote wakeup Function */
+	int (*resume_wakeup) (void *p);
+	/* Suspend function */
+	int (*suspend) (void *p);
+	/* Session Start (SRP) */
+	int (*session_start) (void *p);
+	/* Pointer passed to start() and stop() */
+	void *p;
+};
+
+extern void dwc_otg_cil_register_pcd_callbacks(struct dwc_otg_core_if *core_if,
+					       struct dwc_otg_cil_callbacks *cb,
+					       void *p);
+extern void dwc_otg_cil_register_hcd_callbacks(struct dwc_otg_core_if *core_if,
+					       struct dwc_otg_cil_callbacks *cb,
+					       void *p);
+#endif
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c b/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
new file mode 100644
index 0000000..38c46df
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
@@ -0,0 +1,689 @@
+/* ==========================================================================
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+/**
+ *
+ * The Core Interface Layer provides basic services for accessing and
+ * managing the DWC_otg hardware. These services are used by both the
+ * Host Controller Driver and the Peripheral Controller Driver.
+ *
+ * This file contains the Common Interrupt handlers.
+ */
+#include "dwc_otg_plat.h"
+#include "dwc_otg_regs.h"
+#include "dwc_otg_cil.h"
+
+#ifdef DEBUG
+inline const char *op_state_str(struct dwc_otg_core_if *core_if)
+{
+	return (core_if->op_state == A_HOST ? "a_host" :
+		(core_if->op_state == A_SUSPEND ? "a_suspend" :
+		 (core_if->op_state == A_PERIPHERAL ? "a_peripheral" :
+		  (core_if->op_state == B_PERIPHERAL ? "b_peripheral" :
+		   (core_if->op_state == B_HOST ? "b_host" : "unknown")))));
+}
+#endif
+
+/** This function will log a debug message
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+int32_t dwc_otg_handle_mode_mismatch_intr(struct dwc_otg_core_if *core_if)
+{
+	union gintsts_data gintsts;
+	DWC_WARN("Mode Mismatch Interrupt: currently in %s mode\n",
+		 dwc_otg_mode(core_if) ? "Host" : "Device");
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.modemismatch = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/** Start the HCD.  Helper function for using the HCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void hcd_start(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->start)
+		core_if->hcd_cb->start(core_if->hcd_cb->p);
+}
+
+/** Stop the HCD.  Helper function for using the HCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void hcd_stop(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->stop)
+		core_if->hcd_cb->stop(core_if->hcd_cb->p);
+}
+
+/** Disconnect the HCD.  Helper function for using the HCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void hcd_disconnect(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->disconnect)
+		core_if->hcd_cb->disconnect(core_if->hcd_cb->p);
+}
+
+/** Inform the HCD the a New Session has begun.  Helper function for
+ * using the HCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void hcd_session_start(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->session_start)
+		core_if->hcd_cb->session_start(core_if->hcd_cb->p);
+}
+
+/** Start the PCD.  Helper function for using the PCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void pcd_start(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->start)
+		core_if->pcd_cb->start(core_if->pcd_cb->p);
+}
+
+/** Stop the PCD.  Helper function for using the PCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void pcd_stop(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->stop)
+		core_if->pcd_cb->stop(core_if->pcd_cb->p);
+}
+
+/** Suspend the PCD.  Helper function for using the PCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void pcd_suspend(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->suspend)
+		core_if->pcd_cb->suspend(core_if->pcd_cb->p);
+}
+
+/** Resume the PCD.  Helper function for using the PCD callbacks.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+static inline void pcd_resume(struct dwc_otg_core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->resume_wakeup)
+		core_if->pcd_cb->resume_wakeup(core_if->pcd_cb->p);
+}
+
+/**
+ * This function handles the OTG Interrupts. It reads the OTG
+ * Interrupt Register (GOTGINT) to determine what interrupt has
+ * occurred.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+int32_t dwc_otg_handle_otg_intr(struct dwc_otg_core_if *core_if)
+{
+	struct dwc_otg_core_global_regs *global_regs = core_if->core_global_regs;
+	union gotgint_data gotgint;
+	union gotgctl_data gotgctl;
+	union gintmsk_data gintmsk;
+
+	gotgint.d32 = dwc_read_reg32(&global_regs->gotgint);
+	gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+	DWC_DEBUGPL(DBG_CIL, "++OTG Interrupt gotgint=%0x [%s]\n", gotgint.d32,
+		    op_state_str(core_if));
+
+	if (gotgint.b.sesenddet) {
+		DWC_DEBUGPL(DBG_ANY, " ++OTG Interrupt: "
+			    "Session End Detected++ (%s)\n",
+			    op_state_str(core_if));
+		gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+
+		if (core_if->op_state == B_HOST) {
+			pcd_start(core_if);
+			core_if->op_state = B_PERIPHERAL;
+		} else {
+			/* If not B_HOST and Device HNP still set. HNP
+			 * Did not succeed!*/
+			if (gotgctl.b.devhnpen) {
+				DWC_DEBUGPL(DBG_ANY, "Session End Detected\n");
+				DWC_ERROR("Device Not Connected/Responding!\n");
+			}
+
+			/* If Session End Detected the B-Cable has
+			 * been disconnected. */
+			/* Reset PCD and Gadget driver to a
+			 * clean state. */
+			pcd_stop(core_if);
+		}
+		gotgctl.d32 = 0;
+		gotgctl.b.devhnpen = 1;
+		dwc_modify_reg32(&global_regs->gotgctl, gotgctl.d32, 0);
+	}
+	if (gotgint.b.sesreqsucstschng) {
+		DWC_DEBUGPL(DBG_ANY, " ++OTG Interrupt: "
+			    "Session Reqeust Success Status Change++\n");
+		gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+		if (gotgctl.b.sesreqscs) {
+			if ((core_if->core_params->phy_type ==
+			     DWC_PHY_TYPE_PARAM_FS)
+			    && (core_if->core_params->i2c_enable)) {
+				core_if->srp_success = 1;
+			} else {
+				pcd_resume(core_if);
+				/* Clear Session Request */
+				gotgctl.d32 = 0;
+				gotgctl.b.sesreq = 1;
+				dwc_modify_reg32(&global_regs->gotgctl,
+						 gotgctl.d32, 0);
+			}
+		}
+	}
+	if (gotgint.b.hstnegsucstschng) {
+		/* Print statements during the HNP interrupt handling
+		 * can cause it to fail.*/
+		gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+		if (gotgctl.b.hstnegscs) {
+			if (dwc_otg_is_host_mode(core_if)) {
+				core_if->op_state = B_HOST;
+				/*
+				 * Need to disable SOF interrupt immediately.
+				 * When switching from device to host, the PCD
+				 * interrupt handler won't handle the
+				 * interrupt if host mode is already set. The
+				 * HCD interrupt handler won't get called if
+				 * the HCD state is HALT. This means that the
+				 * interrupt does not get handled and Linux
+				 * complains loudly.
+				 */
+				gintmsk.d32 = 0;
+				gintmsk.b.sofintr = 1;
+				dwc_modify_reg32(&global_regs->gintmsk,
+						 gintmsk.d32, 0);
+				pcd_stop(core_if);
+				/*
+				 * Initialize the Core for Host mode.
+				 */
+				hcd_start(core_if);
+				core_if->op_state = B_HOST;
+			}
+		} else {
+			gotgctl.d32 = 0;
+			gotgctl.b.hnpreq = 1;
+			gotgctl.b.devhnpen = 1;
+			dwc_modify_reg32(&global_regs->gotgctl, gotgctl.d32, 0);
+			DWC_DEBUGPL(DBG_ANY, "HNP Failed\n");
+			DWC_ERROR("Device Not Connected/Responding\n");
+		}
+	}
+	if (gotgint.b.hstnegdet) {
+		/* The disconnect interrupt is set at the same time as
+		 * Host Negotiation Detected.  During the mode
+		 * switch all interrupts are cleared so the disconnect
+		 * interrupt handler will not get executed.
+		 */
+		DWC_DEBUGPL(DBG_ANY, " ++OTG Interrupt: "
+			    "Host Negotiation Detected++ (%s)\n",
+			    (dwc_otg_is_host_mode(core_if) ? "Host" :
+			     "Device"));
+		if (dwc_otg_is_device_mode(core_if)) {
+			DWC_DEBUGPL(DBG_ANY, "a_suspend->a_peripheral (%d)\n",
+				    core_if->op_state);
+			hcd_disconnect(core_if);
+			pcd_start(core_if);
+			core_if->op_state = A_PERIPHERAL;
+		} else {
+			/*
+			 * Need to disable SOF interrupt immediately. When
+			 * switching from device to host, the PCD interrupt
+			 * handler won't handle the interrupt if host mode is
+			 * already set. The HCD interrupt handler won't get
+			 * called if the HCD state is HALT. This means that
+			 * the interrupt does not get handled and Linux
+			 * complains loudly.
+			 */
+			gintmsk.d32 = 0;
+			gintmsk.b.sofintr = 1;
+			dwc_modify_reg32(&global_regs->gintmsk, gintmsk.d32, 0);
+			pcd_stop(core_if);
+			hcd_start(core_if);
+			core_if->op_state = A_HOST;
+		}
+	}
+	if (gotgint.b.adevtoutchng)
+		DWC_DEBUGPL(DBG_ANY, " ++OTG Interrupt: "
+			    "A-Device Timeout Change++\n");
+	if (gotgint.b.debdone)
+		DWC_DEBUGPL(DBG_ANY, " ++OTG Interrupt: " "Debounce Done++\n");
+
+	/* Clear GOTGINT */
+	dwc_write_reg32(&core_if->core_global_regs->gotgint, gotgint.d32);
+
+	return 1;
+}
+
+/**
+ * This function handles the Connector ID Status Change Interrupt.  It
+ * reads the OTG Interrupt Register (GOTCTL) to determine whether this
+ * is a Device to Host Mode transition or a Host Mode to Device
+ * Transition.
+ *
+ * This only occurs when the cable is connected/removed from the PHY
+ * connector.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+int32_t dwc_otg_handle_conn_id_status_change_intr(struct dwc_otg_core_if *core_if)
+{
+	uint32_t count = 0;
+
+	union gintsts_data gintsts = {.d32 = 0 };
+	union gintmsk_data gintmsk = {.d32 = 0 };
+	union gotgctl_data gotgctl = {.d32 = 0 };
+
+	/*
+	 * Need to disable SOF interrupt immediately. If switching from device
+	 * to host, the PCD interrupt handler won't handle the interrupt if
+	 * host mode is already set. The HCD interrupt handler won't get
+	 * called if the HCD state is HALT. This means that the interrupt does
+	 * not get handled and Linux complains loudly.
+	 */
+	gintmsk.b.sofintr = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gintmsk, gintmsk.d32, 0);
+
+	DWC_DEBUGPL(DBG_CIL,
+		    " ++Connector ID Status Change Interrupt++  (%s)\n",
+		    (dwc_otg_is_host_mode(core_if) ? "Host" : "Device"));
+	gotgctl.d32 = dwc_read_reg32(&core_if->core_global_regs->gotgctl);
+	DWC_DEBUGPL(DBG_CIL, "gotgctl=%0x\n", gotgctl.d32);
+	DWC_DEBUGPL(DBG_CIL, "gotgctl.b.conidsts=%d\n", gotgctl.b.conidsts);
+
+	/* B-Device connector (Device Mode) */
+	if (gotgctl.b.conidsts) {
+		/* Wait for switch to device mode. */
+		while (!dwc_otg_is_device_mode(core_if)) {
+			DWC_PRINT("Waiting for Peripheral Mode, Mode=%s\n",
+				  (dwc_otg_is_host_mode(core_if) ? "Host" :
+				   "Peripheral"));
+			mdelay(100);
+			if (++count > 10000)
+				*(uint32_t *) NULL = 0;
+		}
+		core_if->op_state = B_PERIPHERAL;
+		dwc_otg_core_init(core_if);
+		dwc_otg_enable_global_interrupts(core_if);
+		pcd_start(core_if);
+	} else {
+		/* A-Device connector (Host Mode) */
+		while (!dwc_otg_is_host_mode(core_if)) {
+			DWC_PRINT("Waiting for Host Mode, Mode=%s\n",
+				  (dwc_otg_is_host_mode(core_if) ? "Host" :
+				   "Peripheral"));
+			mdelay(100);
+			if (++count > 10000)
+				*(uint32_t *) NULL = 0;
+		}
+		core_if->op_state = A_HOST;
+		/*
+		 * Initialize the Core for Host mode.
+		 */
+		dwc_otg_core_init(core_if);
+		dwc_otg_enable_global_interrupts(core_if);
+		hcd_start(core_if);
+	}
+
+	/* Set flag and clear interrupt */
+	gintsts.b.conidstschng = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates that a device is initiating the Session
+ * Request Protocol to request the host to turn on bus power so a new
+ * session can begin. The handler responds by turning on bus power. If
+ * the DWC_otg controller is in low power mode, the handler brings the
+ * controller out of low power mode before turning on bus power.
+ *
+ * @core_if: Programming view of DWC_otg controller.
+ */
+int32_t dwc_otg_handle_session_req_intr(struct dwc_otg_core_if *core_if)
+{
+	union gintsts_data gintsts;
+#ifndef DWC_HOST_ONLY
+	union hprt0_data hprt0;
+
+	DWC_DEBUGPL(DBG_ANY, "++Session Request Interrupt++\n");
+
+	if (dwc_otg_is_device_mode(core_if)) {
+		DWC_PRINT("SRP: Device mode\n");
+	} else {
+		DWC_PRINT("SRP: Host mode\n");
+
+		/* Turn on the port power bit. */
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtpwr = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+
+		/* Start the Connection timer. So a message can be displayed
+		 * if connect does not occur within 10 seconds. */
+		hcd_session_start(core_if);
+	}
+#endif
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.sessreqintr = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates that the DWC_otg controller has detected a
+ * resume or remote wakeup sequence. If the DWC_otg controller is in
+ * low power mode, the handler must brings the controller out of low
+ * power mode. The controller automatically begins resume
+ * signaling. The handler schedules a time to stop resume signaling.
+ */
+int32_t dwc_otg_handle_wakeup_detected_intr(struct dwc_otg_core_if *core_if)
+{
+	union gintsts_data gintsts;
+
+	DWC_DEBUGPL(DBG_ANY,
+		    "++Resume and Remote Wakeup Detected Interrupt++\n");
+
+	if (dwc_otg_is_device_mode(core_if)) {
+		union dctl_data dctl = {.d32 = 0 };
+		DWC_DEBUGPL(DBG_PCD, "DSTS=0x%0x\n",
+			    dwc_read_reg32(&core_if->dev_if->dev_global_regs->
+					   dsts));
+#ifdef PARTIAL_POWER_DOWN
+		if (core_if->hwcfg4.b.power_optimiz) {
+			union pcgcctl_data power = {.d32 = 0 };
+
+			power.d32 = dwc_read_reg32(core_if->pcgcctl);
+			DWC_DEBUGPL(DBG_CIL, "PCGCCTL=%0x\n", power.d32);
+
+			power.b.stoppclk = 0;
+			dwc_write_reg32(core_if->pcgcctl, power.d32);
+
+			power.b.pwrclmp = 0;
+			dwc_write_reg32(core_if->pcgcctl, power.d32);
+
+			power.b.rstpdwnmodule = 0;
+			dwc_write_reg32(core_if->pcgcctl, power.d32);
+		}
+#endif
+		/* Clear the Remote Wakeup Signalling */
+		dctl.b.rmtwkupsig = 1;
+		dwc_modify_reg32(&core_if->dev_if->dev_global_regs->dctl,
+				 dctl.d32, 0);
+
+		if (core_if->pcd_cb && core_if->pcd_cb->resume_wakeup)
+			core_if->pcd_cb->resume_wakeup(core_if->pcd_cb->p);
+	} else {
+		/*
+		 * Clear the Resume after 70ms. (Need 20 ms minimum. Use 70 ms
+		 * so that OPT tests pass with all PHYs).
+		 */
+		union hprt0_data hprt0 = {.d32 = 0 };
+		union pcgcctl_data pcgcctl = {.d32 = 0 };
+		/* Restart the Phy Clock */
+		pcgcctl.b.stoppclk = 1;
+		dwc_modify_reg32(core_if->pcgcctl, pcgcctl.d32, 0);
+		udelay(10);
+
+		/* Now wait for 70 ms. */
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		DWC_DEBUGPL(DBG_ANY, "Resume: HPRT0=%0x\n", hprt0.d32);
+		mdelay(70);
+		hprt0.b.prtres = 0;	/* Resume */
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		DWC_DEBUGPL(DBG_ANY, "Clear Resume: HPRT0=%0x\n",
+			    dwc_read_reg32(core_if->host_if->hprt0));
+	}
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.wkupintr = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates that a device has been disconnected from
+ * the root port.
+ */
+int32_t dwc_otg_handle_disconnect_intr(struct dwc_otg_core_if *core_if)
+{
+	union gintsts_data gintsts;
+
+	DWC_DEBUGPL(DBG_ANY, "++Disconnect Detected Interrupt++ (%s) %s\n",
+		    (dwc_otg_is_host_mode(core_if) ? "Host" : "Device"),
+		    op_state_str(core_if));
+
+/** @todo Consolidate this if statement. */
+#ifndef DWC_HOST_ONLY
+	if (core_if->op_state == B_HOST) {
+		/* If in device mode Disconnect and stop the HCD, then
+		 * start the PCD. */
+		hcd_disconnect(core_if);
+		pcd_start(core_if);
+		core_if->op_state = B_PERIPHERAL;
+	} else if (dwc_otg_is_device_mode(core_if)) {
+		union gotgctl_data gotgctl = {.d32 = 0 };
+		gotgctl.d32 =
+		    dwc_read_reg32(&core_if->core_global_regs->gotgctl);
+		if (gotgctl.b.hstsethnpen == 1) {
+			/* Do nothing, if HNP in process the OTG
+			 * interrupt "Host Negotiation Detected"
+			 * interrupt will do the mode switch.
+			 */
+		} else if (gotgctl.b.devhnpen == 0) {
+			/* If in device mode Disconnect and stop the HCD, then
+			 * start the PCD. */
+			hcd_disconnect(core_if);
+			pcd_start(core_if);
+			core_if->op_state = B_PERIPHERAL;
+		} else {
+			DWC_DEBUGPL(DBG_ANY, "!a_peripheral && !devhnpen\n");
+		}
+	} else {
+		if (core_if->op_state == A_HOST) {
+			/* A-Cable still connected but device disconnected. */
+			hcd_disconnect(core_if);
+		}
+	}
+#endif
+
+	gintsts.d32 = 0;
+	gintsts.b.disconnect = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This interrupt indicates that SUSPEND state has been detected on
+ * the USB.
+ *
+ * For HNP the USB Suspend interrupt signals the change from
+ * "a_peripheral" to "a_host".
+ *
+ * When power management is enabled the core will be put in low power
+ * mode.
+ */
+int32_t dwc_otg_handle_usb_suspend_intr(struct dwc_otg_core_if *core_if)
+{
+	union dsts_data dsts;
+	union gintsts_data gintsts;
+
+	DWC_DEBUGPL(DBG_ANY, "USB SUSPEND\n");
+
+	if (dwc_otg_is_device_mode(core_if)) {
+		/* Check the Device status register to determine if the Suspend
+		 * state is active. */
+		dsts.d32 =
+		    dwc_read_reg32(&core_if->dev_if->dev_global_regs->dsts);
+		DWC_DEBUGPL(DBG_PCD, "DSTS=0x%0x\n", dsts.d32);
+		DWC_DEBUGPL(DBG_PCD, "DSTS.Suspend Status=%d "
+			    "HWCFG4.power Optimize=%d\n",
+			    dsts.b.suspsts, core_if->hwcfg4.b.power_optimiz);
+
+#ifdef PARTIAL_POWER_DOWN
+/** @todo Add a module parameter for power management. */
+
+		if (dsts.b.suspsts && core_if->hwcfg4.b.power_optimiz) {
+			union pcgcctl_data_t power = {.d32 = 0 };
+			DWC_DEBUGPL(DBG_CIL, "suspend\n");
+
+			power.b.pwrclmp = 1;
+			dwc_write_reg32(core_if->pcgcctl, power.d32);
+
+			power.b.rstpdwnmodule = 1;
+			dwc_modify_reg32(core_if->pcgcctl, 0, power.d32);
+
+			power.b.stoppclk = 1;
+			dwc_modify_reg32(core_if->pcgcctl, 0, power.d32);
+
+		} else {
+			DWC_DEBUGPL(DBG_ANY, "disconnect?\n");
+		}
+#endif
+		/* PCD callback for suspend. */
+		pcd_suspend(core_if);
+	} else {
+		if (core_if->op_state == A_PERIPHERAL) {
+			DWC_DEBUGPL(DBG_ANY, "a_peripheral->a_host\n");
+			/* Clear the a_peripheral flag, back to a_host. */
+			pcd_stop(core_if);
+			hcd_start(core_if);
+			core_if->op_state = A_HOST;
+		}
+	}
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.usbsuspend = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This function returns the Core Interrupt register.
+ */
+static inline uint32_t dwc_otg_read_common_intr(struct dwc_otg_core_if *core_if)
+{
+	union gintsts_data gintsts;
+	union gintmsk_data gintmsk;
+	union gintmsk_data gintmsk_common = {.d32 = 0 };
+	gintmsk_common.b.wkupintr = 1;
+	gintmsk_common.b.sessreqintr = 1;
+	gintmsk_common.b.conidstschng = 1;
+	gintmsk_common.b.otgintr = 1;
+	gintmsk_common.b.modemismatch = 1;
+	gintmsk_common.b.disconnect = 1;
+	gintmsk_common.b.usbsuspend = 1;
+	/*
+	 * @todo: The port interrupt occurs while in device
+	 * mode. Added code to CIL to clear the interrupt for now!
+	 */
+	gintmsk_common.b.portintr = 1;
+
+	gintsts.d32 = dwc_read_reg32(&core_if->core_global_regs->gintsts);
+	gintmsk.d32 = dwc_read_reg32(&core_if->core_global_regs->gintmsk);
+#ifdef DEBUG
+	/* if any common interrupts set */
+	if (gintsts.d32 & gintmsk_common.d32) {
+		DWC_DEBUGPL(DBG_ANY, "gintsts=%08x  gintmsk=%08x\n",
+			    gintsts.d32, gintmsk.d32);
+	}
+#endif
+
+	return (gintsts.d32 & gintmsk.d32) & gintmsk_common.d32;
+
+}
+
+/**
+ * Common interrupt handler.
+ *
+ * The common interrupts are those that occur in both Host and Device mode.
+ * This handler handles the following interrupts:
+ * - Mode Mismatch Interrupt
+ * - Disconnect Interrupt
+ * - OTG Interrupt
+ * - Connector ID Status Change Interrupt
+ * - Session Request Interrupt.
+ * - Resume / Remote Wakeup Detected Interrupt.
+ *
+ */
+extern int32_t dwc_otg_handle_common_intr(struct dwc_otg_core_if *core_if)
+{
+	int retval = 0;
+	union gintsts_data gintsts;
+
+	gintsts.d32 = dwc_otg_read_common_intr(core_if);
+
+	if (gintsts.b.modemismatch)
+		retval |= dwc_otg_handle_mode_mismatch_intr(core_if);
+	if (gintsts.b.otgintr)
+		retval |= dwc_otg_handle_otg_intr(core_if);
+	if (gintsts.b.conidstschng)
+		retval |= dwc_otg_handle_conn_id_status_change_intr(core_if);
+	if (gintsts.b.disconnect)
+		retval |= dwc_otg_handle_disconnect_intr(core_if);
+	if (gintsts.b.sessreqintr)
+		retval |= dwc_otg_handle_session_req_intr(core_if);
+	if (gintsts.b.wkupintr)
+		retval |= dwc_otg_handle_wakeup_detected_intr(core_if);
+	if (gintsts.b.usbsuspend)
+		retval |= dwc_otg_handle_usb_suspend_intr(core_if);
+	if (gintsts.b.portintr && dwc_otg_is_device_mode(core_if)) {
+		/* The port interrupt occurs while in device mode with HPRT0
+		 * Port Enable/Disable.
+		 */
+		gintsts.d32 = 0;
+		gintsts.b.portintr = 1;
+		dwc_write_reg32(&core_if->core_global_regs->gintsts,
+				gintsts.d32);
+		retval |= 1;
+
+	}
+	return retval;
+}
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_driver.h b/drivers/usb/host/dwc_otg/dwc_otg_driver.h
new file mode 100644
index 0000000..1cc116d
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_driver.h
@@ -0,0 +1,63 @@
+/* ==========================================================================
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+#ifndef __DWC_OTG_DRIVER_H__
+#define __DWC_OTG_DRIVER_H__
+
+#include "dwc_otg_cil.h"
+
+/* Type declarations */
+struct dwc_otg_pcd;
+struct dwc_otg_hcd;
+
+/**
+ * This structure is a wrapper that encapsulates the driver components used to
+ * manage a single DWC_otg controller.
+ */
+struct dwc_otg_device {
+	/** Base address returned from ioremap() */
+	void *base;
+
+	/** Pointer to the core interface structure. */
+	struct dwc_otg_core_if *core_if;
+
+	/** Register offset for Diagnostic API.*/
+	uint32_t reg_offset;
+
+	/** Pointer to the PCD structure. */
+	struct dwc_otg_pcd *pcd;
+
+	/** Pointer to the HCD structure. */
+	struct dwc_otg_hcd *hcd;
+
+	/** Flag to indicate whether the common IRQ handler is installed. */
+	uint8_t common_irq_installed;
+
+};
+
+#endif
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd.c b/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
new file mode 100644
index 0000000..a4392f5
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
@@ -0,0 +1,2878 @@
+/* ==========================================================================
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+#ifndef DWC_DEVICE_ONLY
+
+/**
+ *
+ * This file contains the implementation of the HCD. In Linux, the HCD
+ * implements the hc_driver API.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/dma-mapping.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+
+#include "dwc_otg_driver.h"
+#include "dwc_otg_hcd.h"
+#include "dwc_otg_regs.h"
+
+static const char dwc_otg_hcd_name[] = "dwc_otg_hcd";
+
+static const struct hc_driver dwc_otg_hc_driver = {
+
+	.description = dwc_otg_hcd_name,
+	.product_desc = "DWC OTG Controller",
+	.hcd_priv_size = sizeof(struct dwc_otg_hcd),
+
+	.irq = dwc_otg_hcd_irq,
+
+	.flags = HCD_MEMORY | HCD_USB2,
+
+	.start = dwc_otg_hcd_start,
+	.stop = dwc_otg_hcd_stop,
+
+	.urb_enqueue = dwc_otg_hcd_urb_enqueue,
+	.urb_dequeue = dwc_otg_hcd_urb_dequeue,
+	.endpoint_disable = dwc_otg_hcd_endpoint_disable,
+
+	.get_frame_number = dwc_otg_hcd_get_frame_number,
+
+	.hub_status_data = dwc_otg_hcd_hub_status_data,
+	.hub_control = dwc_otg_hcd_hub_control,
+};
+
+/**
+ * Work queue function for starting the HCD when A-Cable is connected.
+ * The dwc_otg_hcd_start() must be called in a process context.
+ */
+static void hcd_start_func(struct work_struct *work)
+{
+	void *_vp =
+	    (void *)(atomic_long_read(&work->data) & WORK_STRUCT_WQ_DATA_MASK);
+	struct usb_hcd *usb_hcd = (struct usb_hcd *)_vp;
+	DWC_DEBUGPL(DBG_HCDV, "%s() %p\n", __func__, usb_hcd);
+	if (usb_hcd)
+		dwc_otg_hcd_start(usb_hcd);
+}
+
+/**
+ * HCD Callback function for starting the HCD when A-Cable is
+ * connected.
+ *
+ * @_p: void pointer to the <code>struct usb_hcd</code>
+ */
+static int32_t dwc_otg_hcd_start_cb(void *_p)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(_p);
+	struct dwc_otg_core_if *core_if = dwc_otg_hcd->core_if;
+	union hprt0_data hprt0;
+
+	if (core_if->op_state == B_HOST) {
+		/*
+		 * Reset the port.  During a HNP mode switch the reset
+		 * needs to occur within 1ms and have a duration of at
+		 * least 50ms.
+		 */
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtrst = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		((struct usb_hcd *)_p)->self.is_b_host = 1;
+	} else {
+		((struct usb_hcd *)_p)->self.is_b_host = 0;
+	}
+
+	/* Need to start the HCD in a non-interrupt context. */
+	INIT_WORK(&dwc_otg_hcd->start_work, hcd_start_func);
+	atomic_long_set(&dwc_otg_hcd->start_work.data, (long)_p);
+	schedule_work(&dwc_otg_hcd->start_work);
+
+	return 1;
+}
+
+/**
+ * HCD Callback function for stopping the HCD.
+ *
+ * @_p: void pointer to the <code>struct usb_hcd</code>
+ */
+static int32_t dwc_otg_hcd_stop_cb(void *_p)
+{
+	struct usb_hcd *usb_hcd = (struct usb_hcd *)_p;
+	DWC_DEBUGPL(DBG_HCDV, "%s(%p)\n", __func__, _p);
+	dwc_otg_hcd_stop(usb_hcd);
+	return 1;
+}
+
+static void del_xfer_timers(struct dwc_otg_hcd *hcd)
+{
+#ifdef DEBUG
+	int i;
+	int num_channels = hcd->core_if->core_params->host_channels;
+	for (i = 0; i < num_channels; i++)
+		del_timer(&hcd->core_if->hc_xfer_timer[i]);
+#endif
+}
+
+static void del_timers(struct dwc_otg_hcd *hcd)
+{
+	del_xfer_timers(hcd);
+	del_timer(&hcd->conn_timer);
+}
+
+/**
+ * Processes all the URBs in a single list of QHs. Completes them with
+ * -ETIMEDOUT and frees the QTD.
+ */
+static void kill_urbs_in_qh_list(struct dwc_otg_hcd *hcd,
+				 struct list_head *_qh_list)
+{
+	struct dwc_otg_qh *qh;
+	struct dwc_otg_qtd *qtd;
+	struct dwc_otg_qtd *qtd_next;
+
+	list_for_each_entry(qh, _qh_list, qh_list_entry) {
+		list_for_each_entry_safe(qtd, qtd_next, &qh->qtd_list,
+					 qtd_list_entry) {
+			if (qtd->urb != NULL) {
+				dwc_otg_hcd_complete_urb(hcd, qtd->urb,
+							 -ETIMEDOUT);
+				qtd->urb = NULL;
+			}
+			dwc_otg_hcd_qtd_remove_and_free(qtd);
+		}
+	}
+}
+
+/**
+ * Responds with an error status of ETIMEDOUT to all URBs in the non-periodic
+ * and periodic schedules. The QTD associated with each URB is removed from
+ * the schedule and freed. This function may be called when a disconnect is
+ * detected or when the HCD is being stopped.
+ */
+static void kill_all_urbs(struct dwc_otg_hcd *hcd)
+{
+	kill_urbs_in_qh_list(hcd, &hcd->non_periodic_sched_inactive);
+	kill_urbs_in_qh_list(hcd, &hcd->non_periodic_sched_active);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_inactive);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_ready);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_assigned);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_queued);
+}
+
+/**
+ * HCD Callback function for disconnect of the HCD.
+ *
+ * @_p: void pointer to the <code>struct usb_hcd</code>
+ */
+static int32_t dwc_otg_hcd_disconnect_cb(void *_p)
+{
+	union gintsts_data intr;
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(_p);
+
+	/*
+	 * Set status flags for the hub driver.
+	 */
+	dwc_otg_hcd->flags.b.port_connect_status_change = 1;
+	dwc_otg_hcd->flags.b.port_connect_status = 0;
+
+	/*
+	 * Shutdown any transfers in process by clearing the Tx FIFO Empty
+	 * interrupt mask and status bits and disabling subsequent host
+	 * channel interrupts.
+	 */
+	intr.d32 = 0;
+	intr.b.nptxfempty = 1;
+	intr.b.ptxfempty = 1;
+	intr.b.hcintr = 1;
+	dwc_modify_reg32(&dwc_otg_hcd->core_if->core_global_regs->gintmsk,
+			 intr.d32, 0);
+	dwc_modify_reg32(&dwc_otg_hcd->core_if->core_global_regs->gintsts,
+			 intr.d32, 0);
+
+	del_timers(dwc_otg_hcd);
+
+	/*
+	 * Turn off the vbus power only if the core has transitioned to device
+	 * mode. If still in host mode, need to keep power on to detect a
+	 * reconnection.
+	 */
+	if (dwc_otg_is_device_mode(dwc_otg_hcd->core_if)) {
+		if (dwc_otg_hcd->core_if->op_state != A_SUSPEND) {
+			union hprt0_data hprt0 = {.d32 = 0 };
+			DWC_PRINT("Disconnect: PortPower off\n");
+			hprt0.b.prtpwr = 0;
+			dwc_write_reg32(dwc_otg_hcd->core_if->host_if->hprt0,
+					hprt0.d32);
+		}
+
+		dwc_otg_disable_host_interrupts(dwc_otg_hcd->core_if);
+	}
+
+	/* Respond with an error status to all URBs in the schedule. */
+	kill_all_urbs(dwc_otg_hcd);
+
+	if (dwc_otg_is_host_mode(dwc_otg_hcd->core_if)) {
+		/* Clean up any host channels that were in use. */
+		int num_channels;
+		int i;
+		struct dwc_hc *channel;
+		struct dwc_otg_hc_regs *hc_regs;
+		union hcchar_data hcchar;
+
+		num_channels = dwc_otg_hcd->core_if->core_params->host_channels;
+
+		if (!dwc_otg_hcd->core_if->dma_enable) {
+			/* Flush out any channel requests in slave mode. */
+			for (i = 0; i < num_channels; i++) {
+				channel = dwc_otg_hcd->hc_ptr_array[i];
+				if (list_empty(&channel->hc_list_entry)) {
+					hc_regs =
+					    dwc_otg_hcd->core_if->host_if->
+					    hc_regs[i];
+					hcchar.d32 =
+					    dwc_read_reg32(&hc_regs->hcchar);
+					if (hcchar.b.chen) {
+						hcchar.b.chen = 0;
+						hcchar.b.chdis = 1;
+						hcchar.b.epdir = 0;
+						dwc_write_reg32(&hc_regs->
+								hcchar,
+								hcchar.d32);
+					}
+				}
+			}
+		}
+
+		for (i = 0; i < num_channels; i++) {
+			channel = dwc_otg_hcd->hc_ptr_array[i];
+			if (list_empty(&channel->hc_list_entry)) {
+				hc_regs =
+				    dwc_otg_hcd->core_if->host_if->hc_regs[i];
+				hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+				if (hcchar.b.chen) {
+					/* Halt the channel. */
+					hcchar.b.chdis = 1;
+					dwc_write_reg32(&hc_regs->hcchar,
+							hcchar.d32);
+				}
+
+				dwc_otg_hc_cleanup(dwc_otg_hcd->core_if,
+						   channel);
+				list_add_tail(&channel->hc_list_entry,
+					      &dwc_otg_hcd->free_hc_list);
+			}
+		}
+	}
+
+	/* A disconnect will end the session so the B-Device is no
+	 * longer a B-host. */
+	((struct usb_hcd *)_p)->self.is_b_host = 0;
+	return 1;
+}
+
+/**
+ * Connection timeout function.  An OTG host is required to display a
+ * message if the device does not connect within 10 seconds.
+ */
+void dwc_otg_hcd_connect_timeout(unsigned long _ptr)
+{
+	DWC_DEBUGPL(DBG_HCDV, "%s(%x)\n", __func__, (int)_ptr);
+	DWC_PRINT("Connect Timeout\n");
+	DWC_ERROR("Device Not Connected/Responding\n");
+}
+
+/**
+ * Start the connection timer.  An OTG host is required to display a
+ * message if the device does not connect within 10 seconds.  The
+ * timer is deleted if a port connect interrupt occurs before the
+ * timer expires.
+ */
+static void dwc_otg_hcd_start_connect_timer(struct dwc_otg_hcd *hcd)
+{
+	init_timer(&hcd->conn_timer);
+	hcd->conn_timer.function = dwc_otg_hcd_connect_timeout;
+	hcd->conn_timer.data = (unsigned long)0;
+	hcd->conn_timer.expires = jiffies + (HZ * 10);
+	add_timer(&hcd->conn_timer);
+}
+
+/**
+ * HCD Callback function for disconnect of the HCD.
+ *
+ * @_p: void pointer to the <code>struct usb_hcd</code>
+ */
+static int32_t dwc_otg_hcd_session_start_cb(void *_p)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(_p);
+	DWC_DEBUGPL(DBG_HCDV, "%s(%p)\n", __func__, _p);
+	dwc_otg_hcd_start_connect_timer(dwc_otg_hcd);
+	return 1;
+}
+
+/**
+ * HCD Callback structure for handling mode switching.
+ */
+static struct dwc_otg_cil_callbacks hcd_cil_callbacks = {
+	.start = dwc_otg_hcd_start_cb,
+	.stop = dwc_otg_hcd_stop_cb,
+	.disconnect = dwc_otg_hcd_disconnect_cb,
+	.session_start = dwc_otg_hcd_session_start_cb,
+	.p = 0,
+};
+
+/**
+ * Reset tasklet function
+ */
+static void reset_tasklet_func(unsigned long data)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = (struct dwc_otg_hcd *)data;
+	struct dwc_otg_core_if *core_if = dwc_otg_hcd->core_if;
+	union hprt0_data hprt0;
+
+	DWC_DEBUGPL(DBG_HCDV, "USB RESET tasklet called\n");
+
+	hprt0.d32 = dwc_otg_read_hprt0(core_if);
+	hprt0.b.prtrst = 1;
+	dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+	mdelay(60);
+
+	hprt0.b.prtrst = 0;
+	dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+	dwc_otg_hcd->flags.b.port_reset_change = 1;
+
+	return;
+}
+
+static struct tasklet_struct reset_tasklet = {
+	.next = NULL,
+	.state = 0,
+	.count = ATOMIC_INIT(0),
+	.func = reset_tasklet_func,
+	.data = 0,
+};
+
+static enum hrtimer_restart delayed_enable(struct hrtimer *t)
+{
+	struct dwc_otg_hcd *hcd = container_of(t, struct dwc_otg_hcd,
+					       poll_rate_limit);
+	struct dwc_otg_core_global_regs *global_regs =
+	    hcd->core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0 };
+	intr_mask.b.nptxfempty = 1;
+	dwc_modify_reg32(&global_regs->gintmsk, 0, intr_mask.d32);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * Initializes the HCD. This function allocates memory for and initializes the
+ * static parts of the usb_hcd and dwc_otg_hcd structures. It also registers the
+ * USB bus with the core and calls the hc_driver->start() function. It returns
+ * a negative error on failure.
+ */
+int __devinit dwc_otg_hcd_init(struct device *dev)
+{
+	struct usb_hcd *hcd = NULL;
+	struct dwc_otg_hcd *dwc_otg_hcd = NULL;
+	struct dwc_otg_device *otg_dev = dev->platform_data;
+
+	int num_channels;
+	int i;
+	struct dwc_hc *channel;
+
+	int retval = 0;
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD INIT\n");
+
+	/* Set device flags indicating whether the HCD supports DMA. */
+	if (otg_dev->core_if->dma_enable) {
+		DWC_PRINT("Using DMA mode\n");
+		dev->coherent_dma_mask = ~0;
+		dev->dma_mask = &dev->coherent_dma_mask;
+	} else {
+		DWC_PRINT("Using Slave mode\n");
+		dev->coherent_dma_mask = 0;
+		dev->dma_mask = NULL;
+	}
+
+	/*
+	 * Allocate memory for the base HCD plus the DWC OTG HCD.
+	 * Initialize the base HCD.
+	 */
+	hcd = usb_create_hcd(&dwc_otg_hc_driver, dev, dev_name(dev));
+	if (hcd == NULL) {
+		retval = -ENOMEM;
+		goto error1;
+	}
+	hcd->regs = otg_dev->base;
+	hcd->self.otg_port = 1;
+
+	/* Integrate TT in root hub, by default this is disbled. */
+	hcd->has_tt = 1;
+
+	/* Initialize the DWC OTG HCD. */
+	dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+
+	spin_lock_init(&dwc_otg_hcd->global_lock);
+
+	dwc_otg_hcd->core_if = otg_dev->core_if;
+	otg_dev->hcd = dwc_otg_hcd;
+
+	/* Register the HCD CIL Callbacks */
+	dwc_otg_cil_register_hcd_callbacks(otg_dev->core_if,
+					   &hcd_cil_callbacks, hcd);
+
+	/* Initialize the non-periodic schedule. */
+	INIT_LIST_HEAD(&dwc_otg_hcd->non_periodic_sched_inactive);
+	INIT_LIST_HEAD(&dwc_otg_hcd->non_periodic_sched_active);
+
+	/* Initialize the periodic schedule. */
+	INIT_LIST_HEAD(&dwc_otg_hcd->periodic_sched_inactive);
+	INIT_LIST_HEAD(&dwc_otg_hcd->periodic_sched_ready);
+	INIT_LIST_HEAD(&dwc_otg_hcd->periodic_sched_assigned);
+	INIT_LIST_HEAD(&dwc_otg_hcd->periodic_sched_queued);
+
+	/*
+	 * Create a host channel descriptor for each host channel implemented
+	 * in the controller. Initialize the channel descriptor array.
+	 */
+	INIT_LIST_HEAD(&dwc_otg_hcd->free_hc_list);
+	num_channels = dwc_otg_hcd->core_if->core_params->host_channels;
+	for (i = 0; i < num_channels; i++) {
+		channel = kmalloc(sizeof(struct dwc_hc), GFP_KERNEL);
+		if (channel == NULL) {
+			retval = -ENOMEM;
+			DWC_ERROR("%s: host channel allocation failed\n",
+				  __func__);
+			goto error2;
+		}
+		memset(channel, 0, sizeof(struct dwc_hc));
+		channel->hc_num = i;
+		dwc_otg_hcd->hc_ptr_array[i] = channel;
+#ifdef DEBUG
+		init_timer(&dwc_otg_hcd->core_if->hc_xfer_timer[i]);
+#endif
+
+		DWC_DEBUGPL(DBG_HCDV, "HCD Added channel #%d, hc=%p\n", i,
+			    channel);
+	}
+
+	/* Initialize the Connection timeout timer. */
+	init_timer(&dwc_otg_hcd->conn_timer);
+
+	/* Initialize reset tasklet. */
+	reset_tasklet.data = (unsigned long)dwc_otg_hcd;
+	dwc_otg_hcd->reset_tasklet = &reset_tasklet;
+
+	hrtimer_init(&dwc_otg_hcd->poll_rate_limit, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	dwc_otg_hcd->poll_rate_limit.function = delayed_enable;
+
+	/*
+	 * Finish generic HCD initialization and start the HCD. This function
+	 * allocates the DMA buffer pool, registers the USB bus, requests the
+	 * IRQ line, and calls dwc_otg_hcd_start method.
+	 */
+	retval =
+	    usb_add_hcd(hcd, platform_get_irq(to_platform_device(dev), 0),
+			IRQF_SHARED);
+	if (retval < 0)
+		goto error2;
+
+	/*
+	 * Allocate space for storing data on status transactions. Normally no
+	 * data is sent, but this space acts as a bit bucket. This must be
+	 * done after usb_add_hcd since that function allocates the DMA buffer
+	 * pool.
+	 */
+	if (otg_dev->core_if->dma_enable) {
+		dwc_otg_hcd->status_buf =
+		    dma_alloc_coherent(dev,
+				       DWC_OTG_HCD_STATUS_BUF_SIZE,
+				       &dwc_otg_hcd->status_buf_dma,
+				       GFP_KERNEL | GFP_DMA);
+	} else {
+		dwc_otg_hcd->status_buf = kmalloc(DWC_OTG_HCD_STATUS_BUF_SIZE,
+						  GFP_KERNEL);
+	}
+	if (dwc_otg_hcd->status_buf == NULL) {
+		retval = -ENOMEM;
+		DWC_ERROR("%s: status_buf allocation failed\n", __func__);
+		goto error3;
+	}
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD Initialized HCD, usbbus=%d\n",
+		    hcd->self.busnum);
+
+	return 0;
+
+	/* Error conditions */
+error3:
+	usb_remove_hcd(hcd);
+error2:
+	dwc_otg_hcd_free(hcd);
+	usb_put_hcd(hcd);
+error1:
+	return retval;
+}
+
+/**
+ * Removes the HCD.
+ * Frees memory and resources associated with the HCD and deregisters the bus.
+ */
+void dwc_otg_hcd_remove(struct device *dev)
+{
+	struct dwc_otg_device *otg_dev = dev->platform_data;
+	struct dwc_otg_hcd *dwc_otg_hcd = otg_dev->hcd;
+	struct usb_hcd *hcd = dwc_otg_hcd_to_hcd(dwc_otg_hcd);
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD REMOVE\n");
+
+	/* Turn off all interrupts */
+	dwc_write_reg32(&dwc_otg_hcd->core_if->core_global_regs->gintmsk, 0);
+	dwc_modify_reg32(&dwc_otg_hcd->core_if->core_global_regs->gahbcfg, 1,
+			 0);
+
+	usb_remove_hcd(hcd);
+	dwc_otg_hcd_free(hcd);
+	usb_put_hcd(hcd);
+
+	return;
+}
+
+/* =========================================================================
+ *  Linux HC Driver Functions
+ * ========================================================================= */
+
+/**
+ * Initializes dynamic portions of the DWC_otg HCD state.
+ */
+static void hcd_reinit(struct dwc_otg_hcd *hcd)
+{
+	struct list_head *item;
+	int num_channels;
+	int i;
+	struct dwc_hc *channel;
+
+	hcd->flags.d32 = 0;
+
+	hcd->non_periodic_qh_ptr = &hcd->non_periodic_sched_active;
+	hcd->non_periodic_channels = 0;
+	hcd->periodic_channels = 0;
+
+	/*
+	 * Put all channels in the free channel list and clean up channel
+	 * states.
+	 */
+	item = hcd->free_hc_list.next;
+	while (item != &hcd->free_hc_list) {
+		list_del(item);
+		item = hcd->free_hc_list.next;
+	}
+	num_channels = hcd->core_if->core_params->host_channels;
+	for (i = 0; i < num_channels; i++) {
+		channel = hcd->hc_ptr_array[i];
+		list_add_tail(&channel->hc_list_entry, &hcd->free_hc_list);
+		dwc_otg_hc_cleanup(hcd->core_if, channel);
+	}
+
+	/* Initialize the DWC core for host mode operation. */
+	dwc_otg_core_host_init(hcd->core_if);
+}
+
+/** Initializes the DWC_otg controller and its root hub and prepares it for host
+ * mode operation. Activates the root port. Returns 0 on success and a negative
+ * error code on failure. */
+int dwc_otg_hcd_start(struct usb_hcd *hcd)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+	struct dwc_otg_core_if *core_if = dwc_otg_hcd->core_if;
+	unsigned long flags;
+
+	struct usb_bus *bus;
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD START\n");
+
+	spin_lock_irqsave(&dwc_otg_hcd->global_lock, flags);
+
+	bus = hcd_to_bus(hcd);
+
+	/* Initialize the bus state.  If the core is in Device Mode
+	 * HALT the USB bus and return. */
+	if (dwc_otg_is_device_mode(core_if)) {
+		hcd->state = HC_STATE_HALT;
+		goto out;
+	}
+	hcd->state = HC_STATE_RUNNING;
+
+	hcd_reinit(dwc_otg_hcd);
+out:
+	spin_unlock_irqrestore(&dwc_otg_hcd->global_lock, flags);
+
+	return 0;
+}
+
+static void qh_list_free(struct dwc_otg_hcd *hcd, struct list_head *_qh_list)
+{
+	struct list_head *item;
+	struct dwc_otg_qh *qh;
+
+	if (_qh_list->next == NULL) {
+		/* The list hasn't been initialized yet. */
+		return;
+	}
+
+	/* Ensure there are no QTDs or URBs left. */
+	kill_urbs_in_qh_list(hcd, _qh_list);
+
+	for (item = _qh_list->next; item != _qh_list; item = _qh_list->next) {
+		qh = list_entry(item, struct dwc_otg_qh, qh_list_entry);
+		dwc_otg_hcd_qh_remove_and_free(hcd, qh);
+	}
+}
+
+/**
+ * Halts the DWC_otg host mode operations in a clean manner. USB transfers are
+ * stopped.
+ */
+void dwc_otg_hcd_stop(struct usb_hcd *hcd)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+	union hprt0_data hprt0 = {.d32 = 0 };
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD STOP\n");
+
+	/* Turn off all host-specific interrupts. */
+	dwc_otg_disable_host_interrupts(dwc_otg_hcd->core_if);
+
+	/*
+	 * The root hub should be disconnected before this function is called.
+	 * The disconnect will clear the QTD lists (via ..._hcd_urb_dequeue)
+	 * and the QH lists (via ..._hcd_endpoint_disable).
+	 */
+
+	/* Turn off the vbus power */
+	DWC_PRINT("PortPower off\n");
+	hprt0.b.prtpwr = 0;
+	dwc_write_reg32(dwc_otg_hcd->core_if->host_if->hprt0, hprt0.d32);
+
+	return;
+}
+
+/** Returns the current frame number. */
+int dwc_otg_hcd_get_frame_number(struct usb_hcd *hcd)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+	union hfnum_data hfnum;
+
+	hfnum.d32 =
+	    dwc_read_reg32(&dwc_otg_hcd->core_if->host_if->host_global_regs->
+			   hfnum);
+
+#ifdef DEBUG_SOF
+	DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD GET FRAME NUMBER %d\n",
+		    hfnum.b.frnum);
+#endif
+	return hfnum.b.frnum;
+}
+
+/**
+ * Frees secondary storage associated with the dwc_otg_hcd structure contained
+ * in the struct usb_hcd field.
+ */
+void dwc_otg_hcd_free(struct usb_hcd *hcd)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+	int i;
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD FREE\n");
+
+	del_timers(dwc_otg_hcd);
+
+	/* Free memory for QH/QTD lists */
+	qh_list_free(dwc_otg_hcd, &dwc_otg_hcd->non_periodic_sched_inactive);
+	qh_list_free(dwc_otg_hcd, &dwc_otg_hcd->non_periodic_sched_active);
+	qh_list_free(dwc_otg_hcd, &dwc_otg_hcd->periodic_sched_inactive);
+	qh_list_free(dwc_otg_hcd, &dwc_otg_hcd->periodic_sched_ready);
+	qh_list_free(dwc_otg_hcd, &dwc_otg_hcd->periodic_sched_assigned);
+	qh_list_free(dwc_otg_hcd, &dwc_otg_hcd->periodic_sched_queued);
+
+	/* Free memory for the host channels. */
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		struct dwc_hc *hc = dwc_otg_hcd->hc_ptr_array[i];
+		if (hc != NULL) {
+			DWC_DEBUGPL(DBG_HCDV, "HCD Free channel #%i, hc=%p\n",
+				    i, hc);
+			kfree(hc);
+		}
+	}
+
+	if (dwc_otg_hcd->core_if->dma_enable) {
+		if (dwc_otg_hcd->status_buf_dma) {
+			dma_free_coherent(hcd->self.controller,
+					  DWC_OTG_HCD_STATUS_BUF_SIZE,
+					  dwc_otg_hcd->status_buf,
+					  dwc_otg_hcd->status_buf_dma);
+		}
+	} else if (dwc_otg_hcd->status_buf != NULL) {
+		kfree(dwc_otg_hcd->status_buf);
+	}
+
+	return;
+}
+
+#ifdef DEBUG
+static void dump_urb_info(struct urb *urb, char *_fn_name)
+{
+	DWC_PRINT("%s, urb %p\n", _fn_name, urb);
+	DWC_PRINT("  Device address: %d\n", usb_pipedevice(urb->pipe));
+	DWC_PRINT("  Endpoint: %d, %s\n", usb_pipeendpoint(urb->pipe),
+		  (usb_pipein(urb->pipe) ? "IN" : "OUT"));
+	DWC_PRINT("  Endpoint type: %s\n",
+		({
+			char *pipetype;
+			switch (usb_pipetype(urb->pipe)) {
+			case PIPE_CONTROL:
+				pipetype = "CONTROL";
+				break;
+			case PIPE_BULK:
+				pipetype = "BULK";
+				break;
+			case PIPE_INTERRUPT:
+				pipetype = "INTERRUPT";
+				break;
+			case PIPE_ISOCHRONOUS:
+				pipetype = "ISOCHRONOUS";
+				break;
+			default:
+				pipetype = "UNKNOWN";
+				break;
+			}
+			pipetype;
+		})) ;
+	DWC_PRINT("  Speed: %s\n",
+		({
+			char *speed;
+			switch (urb->dev->speed) {
+			case USB_SPEED_HIGH:
+				speed = "HIGH";
+				break;
+			case USB_SPEED_FULL:
+				speed = "FULL";
+				break;
+			case USB_SPEED_LOW:
+				speed = "LOW";
+				break;
+			default:
+				speed = "UNKNOWN";
+				break;
+			}
+			speed;
+		}));
+	DWC_PRINT("  Max packet size: %d\n",
+		  usb_maxpacket(urb->dev, urb->pipe,
+				usb_pipeout(urb->pipe)));
+	DWC_PRINT("  Data buffer length: %d\n", urb->transfer_buffer_length);
+	DWC_PRINT("  Transfer buffer: %p, Transfer DMA: %p\n",
+		  urb->transfer_buffer, (void *)urb->transfer_dma);
+	DWC_PRINT("  Setup buffer: %p, Setup DMA: %p\n",
+		  urb->setup_packet, (void *)urb->setup_dma);
+	DWC_PRINT("  Interval: %d\n", urb->interval);
+	if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
+		int i;
+		for (i = 0; i < urb->number_of_packets; i++) {
+			DWC_PRINT("  ISO Desc %d:\n", i);
+			DWC_PRINT("    offset: %d, length %d\n",
+				  urb->iso_frame_desc[i].offset,
+				  urb->iso_frame_desc[i].length);
+		}
+	}
+}
+
+static void dump_channel_info(struct dwc_otg_hcd *hcd, struct dwc_otg_qh * qh)
+{
+	if (qh->channel != NULL) {
+		struct dwc_hc *hc = qh->channel;
+		struct list_head *item;
+		struct dwc_otg_qh *qh_item;
+		int num_channels = hcd->core_if->core_params->host_channels;
+		int i;
+
+		struct dwc_otg_hc_regs *hc_regs;
+		union hcchar_data hcchar;
+		union hcsplt_data hcsplt;
+		union hctsiz_data hctsiz;
+		uint32_t hcdma;
+
+		hc_regs = hcd->core_if->host_if->hc_regs[hc->hc_num];
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hcsplt.d32 = dwc_read_reg32(&hc_regs->hcsplt);
+		hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+		hcdma = dwc_read_reg32(&hc_regs->hcdma);
+
+		DWC_PRINT("  Assigned to channel %p:\n", hc);
+		DWC_PRINT("    hcchar 0x%08x, hcsplt 0x%08x\n", hcchar.d32,
+			  hcsplt.d32);
+		DWC_PRINT("    hctsiz 0x%08x, hcdma 0x%08x\n", hctsiz.d32,
+			  hcdma);
+		DWC_PRINT("    dev_addr: %d, ep_num: %d, ep_is_in: %d\n",
+			  hc->dev_addr, hc->ep_num, hc->ep_is_in);
+		DWC_PRINT("    ep_type: %d\n", hc->ep_type);
+		DWC_PRINT("    max_packet: %d\n", hc->max_packet);
+		DWC_PRINT("    data_pid_start: %d\n", hc->data_pid_start);
+		DWC_PRINT("    xfer_started: %d\n", hc->xfer_started);
+		DWC_PRINT("    halt_status: %d\n", hc->halt_status);
+		DWC_PRINT("    xfer_buff: %p\n", hc->xfer_buff);
+		DWC_PRINT("    xfer_len: %d\n", hc->xfer_len);
+		DWC_PRINT("    qh: %p\n", hc->qh);
+		DWC_PRINT("  NP inactive sched:\n");
+		list_for_each(item, &hcd->non_periodic_sched_inactive) {
+			qh_item = list_entry(item, struct dwc_otg_qh,
+					     qh_list_entry);
+			DWC_PRINT("    %p\n", qh_item);
+		}
+		DWC_PRINT("  NP active sched:\n");
+		list_for_each(item, &hcd->non_periodic_sched_active) {
+			qh_item = list_entry(item, struct dwc_otg_qh,
+					     qh_list_entry);
+			DWC_PRINT("    %p\n", qh_item);
+		}
+		DWC_PRINT("  Channels: \n");
+		for (i = 0; i < num_channels; i++) {
+			struct dwc_hc *hc = hcd->hc_ptr_array[i];
+			DWC_PRINT("    %2d: %p\n", i, hc);
+		}
+	}
+}
+#endif
+
+/* Starts processing a USB transfer request specified by a USB Request Block
+ * (URB). mem_flags indicates the type of memory allocation to use while
+ * processing this URB. */
+int dwc_otg_hcd_urb_enqueue(struct usb_hcd *hcd,
+			    struct urb *urb, unsigned _mem_flags)
+{
+	unsigned long flags;
+	int retval = 0;
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+	struct dwc_otg_qtd *qtd;
+
+	spin_lock_irqsave(&dwc_otg_hcd->global_lock, flags);
+
+	/*
+	 * Make sure the start of frame interrupt is enabled now that
+	 * we know we should have queued data. The SOF interrupt
+	 * handler automatically disables itself when idle to reduce
+	 * the number of interrupts. See dwc_otg_hcd_handle_sof_intr()
+	 * for the disable
+	 */
+	dwc_modify_reg32(&dwc_otg_hcd->core_if->core_global_regs->gintmsk, 0,
+			 DWC_SOF_INTR_MASK);
+
+#ifdef DEBUG
+	if (CHK_DEBUG_LEVEL(DBG_HCDV | DBG_HCD_URB))
+		dump_urb_info(urb, "dwc_otg_hcd_urb_enqueue");
+#endif
+	if (!dwc_otg_hcd->flags.b.port_connect_status) {
+		/* No longer connected. */
+		retval =  -ENODEV;
+		goto out;
+	}
+
+	qtd = dwc_otg_hcd_qtd_create(urb);
+	if (qtd == NULL) {
+		DWC_ERROR("DWC OTG HCD URB Enqueue failed creating QTD\n");
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	retval = dwc_otg_hcd_qtd_add(qtd, dwc_otg_hcd);
+	if (retval < 0) {
+		DWC_ERROR("DWC OTG HCD URB Enqueue failed adding QTD. "
+			  "Error status %d\n", retval);
+		dwc_otg_hcd_qtd_free(qtd);
+	}
+out:
+	spin_unlock_irqrestore(&dwc_otg_hcd->global_lock, flags);
+
+	return retval;
+}
+
+/** Aborts/cancels a USB transfer request. Always returns 0 to indicate
+ * success.  */
+int dwc_otg_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
+{
+	unsigned long flags;
+	struct dwc_otg_hcd *dwc_otg_hcd;
+	struct dwc_otg_qtd *urb_qtd;
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD URB Dequeue\n");
+
+	dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+
+	spin_lock_irqsave(&dwc_otg_hcd->global_lock, flags);
+
+	urb_qtd = urb->hcpriv;
+
+#ifdef DEBUG
+	if (CHK_DEBUG_LEVEL(DBG_HCDV | DBG_HCD_URB)) {
+		dump_urb_info(urb, "dwc_otg_hcd_urb_dequeue");
+		if (urb_qtd == urb_qtd->qh->qtd_in_process)
+			dump_channel_info(dwc_otg_hcd, urb_qtd->qh);
+	}
+#endif
+
+	if (urb_qtd == urb_qtd->qh->qtd_in_process) {
+		/* The QTD is in process (it has been assigned to a channel). */
+
+		if (dwc_otg_hcd->flags.b.port_connect_status) {
+			/*
+			 * If still connected (i.e. in host mode), halt the
+			 * channel so it can be used for other transfers. If
+			 * no longer connected, the host registers can't be
+			 * written to halt the channel since the core is in
+			 * device mode.
+			 */
+			dwc_otg_hc_halt(dwc_otg_hcd->core_if,
+					urb_qtd->qh->channel,
+					DWC_OTG_HC_XFER_URB_DEQUEUE);
+		}
+	}
+
+	/*
+	 * Free the QTD and clean up the associated QH. Leave the QH in the
+	 * schedule if it has any remaining QTDs.
+	 */
+	dwc_otg_hcd_qtd_remove_and_free(urb_qtd);
+	if (urb_qtd == urb_qtd->qh->qtd_in_process) {
+		dwc_otg_hcd_qh_deactivate(dwc_otg_hcd, urb_qtd->qh, 0);
+		urb_qtd->qh->channel = NULL;
+		urb_qtd->qh->qtd_in_process = NULL;
+	} else if (list_empty(&urb_qtd->qh->qtd_list)) {
+		dwc_otg_hcd_qh_remove(dwc_otg_hcd, urb_qtd->qh);
+	}
+
+	spin_unlock_irqrestore(&dwc_otg_hcd->global_lock, flags);
+
+	urb->hcpriv = NULL;
+
+	/* Higher layer software sets URB status. */
+	usb_hcd_giveback_urb(hcd, urb, status);
+	if (CHK_DEBUG_LEVEL(DBG_HCDV | DBG_HCD_URB)) {
+		DWC_PRINT("Called usb_hcd_giveback_urb()\n");
+		DWC_PRINT("  urb->status = %d\n", urb->status);
+	}
+
+	return 0;
+}
+
+/* Frees resources in the DWC_otg controller related to a given endpoint. Also
+ * clears state in the HCD related to the endpoint. Any URBs for the endpoint
+ * must already be dequeued. */
+void dwc_otg_hcd_endpoint_disable(struct usb_hcd *hcd,
+				  struct usb_host_endpoint *_ep)
+{
+	unsigned long flags;
+	struct dwc_otg_qh *qh;
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+
+	spin_lock_irqsave(&dwc_otg_hcd->global_lock, flags);
+
+	DWC_DEBUGPL(DBG_HCD,
+		    "DWC OTG HCD EP DISABLE: _bEndpointAddress=0x%02x, "
+		    "endpoint=%d\n", _ep->desc.bEndpointAddress,
+		    dwc_ep_addr_to_endpoint(_ep->desc.bEndpointAddress));
+
+	qh = _ep->hcpriv;
+	if (qh != NULL) {
+#if 1
+		/*
+		 * FIXME: Kludge to not crash on Octeon in SMP
+		 * mode. Normally dwc_otg_hcd_qh_remove_and_free() is
+		 * called even if the list isn't empty. This causes a
+		 * crash on SMP, so we don't call it now. It works
+		 * better, but probably does evil things I don't know
+		 * about.
+		 */
+		/* Check that the QTD list is really empty */
+		if (!list_empty(&qh->qtd_list)) {
+			pr_err("DWC OTG HCD EP DISABLE:"
+			       " QTD List for this endpoint is not empty\n");
+		} else
+#endif
+		{
+			dwc_otg_hcd_qh_remove_and_free(dwc_otg_hcd, qh);
+			_ep->hcpriv = NULL;
+		}
+	}
+
+	spin_unlock_irqrestore(&dwc_otg_hcd->global_lock, flags);
+
+	return;
+}
+
+/* Handles host mode interrupts for the DWC_otg controller. Returns IRQ_NONE if
+ * there was no interrupt to handle. Returns IRQ_HANDLED if there was a valid
+ * interrupt.
+ *
+ * This function is called by the USB core when an interrupt occurs */
+irqreturn_t dwc_otg_hcd_irq(struct usb_hcd *hcd)
+{
+	irqreturn_t result;
+	unsigned long flags;
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+
+	spin_lock_irqsave(&dwc_otg_hcd->global_lock, flags);
+
+	result = IRQ_RETVAL(dwc_otg_hcd_handle_intr(dwc_otg_hcd));
+
+	spin_unlock_irqrestore(&dwc_otg_hcd->global_lock, flags);
+
+	return result;
+}
+
+/** Creates Status Change bitmap for the root hub and root port. The bitmap is
+ * returned in buf. Bit 0 is the status change indicator for the root hub. Bit 1
+ * is the status change indicator for the single root port. Returns 1 if either
+ * change indicator is 1, otherwise returns 0. */
+int dwc_otg_hcd_hub_status_data(struct usb_hcd *hcd, char *_buf)
+{
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+
+	_buf[0] = 0;
+	_buf[0] |= (dwc_otg_hcd->flags.b.port_connect_status_change ||
+		    dwc_otg_hcd->flags.b.port_reset_change ||
+		    dwc_otg_hcd->flags.b.port_enable_change ||
+		    dwc_otg_hcd->flags.b.port_suspend_change ||
+		    dwc_otg_hcd->flags.b.port_over_current_change) << 1;
+
+#ifdef DEBUG
+	if (_buf[0]) {
+		DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB STATUS DATA:"
+			    " Root port status changed\n");
+		DWC_DEBUGPL(DBG_HCDV, "  port_connect_status_change: %d\n",
+			    dwc_otg_hcd->flags.b.port_connect_status_change);
+		DWC_DEBUGPL(DBG_HCDV, "  port_reset_change: %d\n",
+			    dwc_otg_hcd->flags.b.port_reset_change);
+		DWC_DEBUGPL(DBG_HCDV, "  port_enable_change: %d\n",
+			    dwc_otg_hcd->flags.b.port_enable_change);
+		DWC_DEBUGPL(DBG_HCDV, "  port_suspend_change: %d\n",
+			    dwc_otg_hcd->flags.b.port_suspend_change);
+		DWC_DEBUGPL(DBG_HCDV, "  port_over_current_change: %d\n",
+			    dwc_otg_hcd->flags.b.port_over_current_change);
+	}
+#endif
+	return (_buf[0] != 0);
+}
+
+#ifdef DWC_HS_ELECT_TST
+/*
+ * Quick and dirty hack to implement the HS Electrical Test
+ * SINGLE_STEP_GET_DEVICE_DESCRIPTOR feature.
+ *
+ * This code was copied from our userspace app "hset". It sends a
+ * Get Device Descriptor control sequence in two parts, first the
+ * Setup packet by itself, followed some time later by the In and
+ * Ack packets. Rather than trying to figure out how to add this
+ * functionality to the normal driver code, we just hijack the
+ * hardware, using these two function to drive the hardware
+ * directly.
+ */
+
+struct dwc_otg_core_global_regs *global_regs;
+struct dwc_otg_host_global_regs *hc_global_regs;
+struct dwc_otg_hc_regs *hc_regs;
+uint32_t *data_fifo;
+
+static void do_setup(void)
+{
+	union gintsts_data gintsts;
+	union hctsiz_data hctsiz;
+	union hcchar_data hcchar;
+	union haint_data haint;
+	union hcint_data hcint;
+
+	/* Enable HAINTs */
+	dwc_write_reg32(&hc_global_regs->haintmsk, 0x0001);
+
+	/* Enable HCINTs */
+	dwc_write_reg32(&hc_regs->hcintmsk, 0x04a3);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Read HAINT */
+	haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+	/* Read HCINT */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+	/* Read HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+	/* Clear HCINT */
+	dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+	/* Clear HAINT */
+	dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+	/* Clear GINTSTS */
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/*
+	 * Send Setup packet (Get Device Descriptor)
+	 */
+
+	/* Make sure channel is disabled */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	if (hcchar.b.chen) {
+		hcchar.b.chdis = 1;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+		mdelay(1000);
+
+		/* Read GINTSTS */
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+		/* Read HAINT */
+		haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+		/* Read HCINT */
+		hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+		/* Read HCCHAR */
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+		/* Clear HCINT */
+		dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+		/* Clear HAINT */
+		dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+		/* Clear GINTSTS */
+		dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	}
+
+	/* Set HCTSIZ */
+	hctsiz.d32 = 0;
+	hctsiz.b.xfersize = 8;
+	hctsiz.b.pktcnt = 1;
+	hctsiz.b.pid = DWC_OTG_HC_PID_SETUP;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	/* Set HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.eptype = DWC_OTG_EP_TYPE_CONTROL;
+	hcchar.b.epdir = 0;
+	hcchar.b.epnum = 0;
+	hcchar.b.mps = 8;
+	hcchar.b.chen = 1;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	/* Fill FIFO with Setup data for Get Device Descriptor */
+	data_fifo = (uint32_t *) ((char *)global_regs + 0x1000);
+	dwc_write_reg32(data_fifo++, 0x01000680);
+	dwc_write_reg32(data_fifo++, 0x00080000);
+
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Wait for host channel interrupt */
+	do {
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+	} while (gintsts.b.hcintr == 0);
+
+
+	/* Disable HCINTs */
+	dwc_write_reg32(&hc_regs->hcintmsk, 0x0000);
+
+	/* Disable HAINTs */
+	dwc_write_reg32(&hc_global_regs->haintmsk, 0x0000);
+
+	/* Read HAINT */
+	haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+	/* Read HCINT */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+	/* Read HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+	/* Clear HCINT */
+	dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+	/* Clear HAINT */
+	dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+	/* Clear GINTSTS */
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+}
+
+static void do_in_ack(void)
+{
+	union gintsts_data gintsts;
+	union hctsiz_data hctsiz;
+	union hcchar_data hcchar;
+	union haint_data haint;
+	union hcint_data hcint;
+	union host_grxsts_data grxsts;
+
+	/* Enable HAINTs */
+	dwc_write_reg32(&hc_global_regs->haintmsk, 0x0001);
+
+	/* Enable HCINTs */
+	dwc_write_reg32(&hc_regs->hcintmsk, 0x04a3);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Read HAINT */
+	haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+	/* Read HCINT */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+	/* Read HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+	/* Clear HCINT */
+	dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+	/* Clear HAINT */
+	dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+	/* Clear GINTSTS */
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/*
+	 * Receive Control In packet
+	 */
+
+	/* Make sure channel is disabled */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	if (hcchar.b.chen) {
+		hcchar.b.chdis = 1;
+		hcchar.b.chen = 1;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+		mdelay(1000);
+
+		/* Read GINTSTS */
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+		/* Read HAINT */
+		haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+		/* Read HCINT */
+		hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+		/* Read HCCHAR */
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+		/* Clear HCINT */
+		dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+		/* Clear HAINT */
+		dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+		/* Clear GINTSTS */
+		dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	}
+
+	/* Set HCTSIZ */
+	hctsiz.d32 = 0;
+	hctsiz.b.xfersize = 8;
+	hctsiz.b.pktcnt = 1;
+	hctsiz.b.pid = DWC_OTG_HC_PID_DATA1;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	/* Set HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.eptype = DWC_OTG_EP_TYPE_CONTROL;
+	hcchar.b.epdir = 1;
+	hcchar.b.epnum = 0;
+	hcchar.b.mps = 8;
+	hcchar.b.chen = 1;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Wait for receive status queue interrupt */
+	do {
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+	} while (gintsts.b.rxstsqlvl == 0);
+
+	/* Read RXSTS */
+	grxsts.d32 = dwc_read_reg32(&global_regs->grxstsp);
+
+	/* Clear RXSTSQLVL in GINTSTS */
+	gintsts.d32 = 0;
+	gintsts.b.rxstsqlvl = 1;
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	switch (grxsts.b.pktsts) {
+	case DWC_GRXSTS_PKTSTS_IN:
+		/* Read the data into the host buffer */
+		if (grxsts.b.bcnt > 0) {
+			int i;
+			int word_count = (grxsts.b.bcnt + 3) / 4;
+
+			data_fifo = (uint32_t *) ((char *)global_regs + 0x1000);
+
+			for (i = 0; i < word_count; i++)
+				(void)dwc_read_reg32(data_fifo++);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Wait for receive status queue interrupt */
+	do {
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+	} while (gintsts.b.rxstsqlvl == 0);
+
+
+	/* Read RXSTS */
+	grxsts.d32 = dwc_read_reg32(&global_regs->grxstsp);
+
+	/* Clear RXSTSQLVL in GINTSTS */
+	gintsts.d32 = 0;
+	gintsts.b.rxstsqlvl = 1;
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	switch (grxsts.b.pktsts) {
+	case DWC_GRXSTS_PKTSTS_IN_XFER_COMP:
+		break;
+
+	default:
+		break;
+	}
+
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Wait for host channel interrupt */
+	do {
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+	} while (gintsts.b.hcintr == 0);
+
+
+	/* Read HAINT */
+	haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+	/* Read HCINT */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+	/* Read HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+	/* Clear HCINT */
+	dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+	/* Clear HAINT */
+	dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+	/* Clear GINTSTS */
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	mdelay(1);
+
+	/*
+	 * Send handshake packet
+	 */
+
+	/* Read HAINT */
+	haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+	/* Read HCINT */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+	/* Read HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+	/* Clear HCINT */
+	dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+	/* Clear HAINT */
+	dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+	/* Clear GINTSTS */
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Make sure channel is disabled */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	if (hcchar.b.chen) {
+		hcchar.b.chdis = 1;
+		hcchar.b.chen = 1;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+		mdelay(1000);
+
+		/* Read GINTSTS */
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+		/* Read HAINT */
+		haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+		/* Read HCINT */
+		hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+		/* Read HCCHAR */
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+		/* Clear HCINT */
+		dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+		/* Clear HAINT */
+		dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+		/* Clear GINTSTS */
+		dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	}
+
+	/* Set HCTSIZ */
+	hctsiz.d32 = 0;
+	hctsiz.b.xfersize = 0;
+	hctsiz.b.pktcnt = 1;
+	hctsiz.b.pid = DWC_OTG_HC_PID_DATA1;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	/* Set HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.eptype = DWC_OTG_EP_TYPE_CONTROL;
+	hcchar.b.epdir = 0;
+	hcchar.b.epnum = 0;
+	hcchar.b.mps = 8;
+	hcchar.b.chen = 1;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+
+	/* Wait for host channel interrupt */
+	do {
+		gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+	} while (gintsts.b.hcintr == 0);
+
+
+	/* Disable HCINTs */
+	dwc_write_reg32(&hc_regs->hcintmsk, 0x0000);
+
+	/* Disable HAINTs */
+	dwc_write_reg32(&hc_global_regs->haintmsk, 0x0000);
+
+	/* Read HAINT */
+	haint.d32 = dwc_read_reg32(&hc_global_regs->haint);
+
+	/* Read HCINT */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+
+	/* Read HCCHAR */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+
+	/* Clear HCINT */
+	dwc_write_reg32(&hc_regs->hcint, hcint.d32);
+
+	/* Clear HAINT */
+	dwc_write_reg32(&hc_global_regs->haint, haint.d32);
+
+	/* Clear GINTSTS */
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Read GINTSTS */
+	gintsts.d32 = dwc_read_reg32(&global_regs->gintsts);
+}
+#endif /* DWC_HS_ELECT_TST */
+
+/* Handles hub class-specific requests.*/
+int dwc_otg_hcd_hub_control(struct usb_hcd *hcd,
+			    u16 _typeReq,
+			    u16 _wValue, u16 _wIndex, char *_buf, u16 _wLength)
+{
+	int retval = 0;
+	unsigned long flags;
+
+	struct dwc_otg_hcd *dwc_otg_hcd = hcd_to_dwc_otg_hcd(hcd);
+	struct dwc_otg_core_if *core_if = hcd_to_dwc_otg_hcd(hcd)->core_if;
+	struct usb_hub_descriptor *desc;
+	union hprt0_data hprt0 = {.d32 = 0 };
+
+	uint32_t port_status;
+#ifdef DWC_HS_ELECT_TST
+	uint32_t t;
+	union gintmsk_data gintmsk;
+#endif
+	spin_lock_irqsave(&dwc_otg_hcd->global_lock, flags);
+
+	switch (_typeReq) {
+	case ClearHubFeature:
+		DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+			    "ClearHubFeature 0x%x\n", _wValue);
+		switch (_wValue) {
+		case C_HUB_LOCAL_POWER:
+		case C_HUB_OVER_CURRENT:
+			/* Nothing required here */
+			break;
+		default:
+			retval = -EINVAL;
+			DWC_ERROR("DWC OTG HCD - "
+				  "ClearHubFeature request %xh unknown\n",
+				  _wValue);
+		}
+		break;
+	case ClearPortFeature:
+		if (!_wIndex || _wIndex > 1)
+			goto error;
+
+		switch (_wValue) {
+		case USB_PORT_FEAT_ENABLE:
+			DWC_DEBUGPL(DBG_ANY, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_ENABLE\n");
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			hprt0.b.prtena = 1;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			break;
+		case USB_PORT_FEAT_SUSPEND:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_SUSPEND\n");
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			hprt0.b.prtres = 1;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			/* Clear Resume bit */
+			mdelay(100);
+			hprt0.b.prtres = 0;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			break;
+		case USB_PORT_FEAT_POWER:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_POWER\n");
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			hprt0.b.prtpwr = 0;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			break;
+		case USB_PORT_FEAT_INDICATOR:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_INDICATOR\n");
+			/* Port inidicator not supported */
+			break;
+		case USB_PORT_FEAT_C_CONNECTION:
+			/* Clears drivers internal connect status change
+			 * flag */
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_C_CONNECTION\n");
+			dwc_otg_hcd->flags.b.port_connect_status_change = 0;
+			break;
+		case USB_PORT_FEAT_C_RESET:
+			/* Clears the driver's internal Port Reset Change
+			 * flag */
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_C_RESET\n");
+			dwc_otg_hcd->flags.b.port_reset_change = 0;
+			break;
+		case USB_PORT_FEAT_C_ENABLE:
+			/* Clears the driver's internal Port
+			 * Enable/Disable Change flag */
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_C_ENABLE\n");
+			dwc_otg_hcd->flags.b.port_enable_change = 0;
+			break;
+		case USB_PORT_FEAT_C_SUSPEND:
+			/* Clears the driver's internal Port Suspend
+			 * Change flag, which is set when resume signaling on
+			 * the host port is complete */
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_C_SUSPEND\n");
+			dwc_otg_hcd->flags.b.port_suspend_change = 0;
+			break;
+		case USB_PORT_FEAT_C_OVER_CURRENT:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "ClearPortFeature USB_PORT_FEAT_C_OVER_CURRENT\n");
+			dwc_otg_hcd->flags.b.port_over_current_change = 0;
+			break;
+		default:
+			retval = -EINVAL;
+			DWC_ERROR("DWC OTG HCD - "
+				  "ClearPortFeature request %xh "
+				  "unknown or unsupported\n", _wValue);
+		}
+		break;
+	case GetHubDescriptor:
+		DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+			    "GetHubDescriptor\n");
+		desc = (struct usb_hub_descriptor *)_buf;
+		desc->bDescLength = 9;
+		desc->bDescriptorType = 0x29;
+		desc->bNbrPorts = 1;
+		desc->wHubCharacteristics = 0x08;
+		desc->bPwrOn2PwrGood = 1;
+		desc->bHubContrCurrent = 0;
+		desc->bitmap[0] = 0;
+		desc->bitmap[1] = 0xff;
+		break;
+	case GetHubStatus:
+		DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+			    "GetHubStatus\n");
+		memset(_buf, 0, 4);
+		break;
+	case GetPortStatus:
+		DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+			    "GetPortStatus\n");
+
+		if (!_wIndex || _wIndex > 1)
+			goto error;
+
+		port_status = 0;
+
+		if (dwc_otg_hcd->flags.b.port_connect_status_change)
+			port_status |= (1 << USB_PORT_FEAT_C_CONNECTION);
+
+		if (dwc_otg_hcd->flags.b.port_enable_change)
+			port_status |= (1 << USB_PORT_FEAT_C_ENABLE);
+
+		if (dwc_otg_hcd->flags.b.port_suspend_change)
+			port_status |= (1 << USB_PORT_FEAT_C_SUSPEND);
+
+		if (dwc_otg_hcd->flags.b.port_reset_change)
+			port_status |= (1 << USB_PORT_FEAT_C_RESET);
+
+		if (dwc_otg_hcd->flags.b.port_over_current_change) {
+			DWC_ERROR("Device Not Supported\n");
+			port_status |= (1 << USB_PORT_FEAT_C_OVER_CURRENT);
+		}
+
+		if (!dwc_otg_hcd->flags.b.port_connect_status) {
+			/*
+			 * The port is disconnected, which means the core is
+			 * either in device mode or it soon will be. Just
+			 * return 0's for the remainder of the port status
+			 * since the port register can't be read if the core
+			 * is in device mode.
+			 */
+			*((__le32 *) _buf) = cpu_to_le32(port_status);
+			break;
+		}
+
+		hprt0.d32 = dwc_read_reg32(core_if->host_if->hprt0);
+		DWC_DEBUGPL(DBG_HCDV, "  HPRT0: 0x%08x\n", hprt0.d32);
+
+		if (hprt0.b.prtconnsts)
+			port_status |= (1 << USB_PORT_FEAT_CONNECTION);
+
+		if (hprt0.b.prtena)
+			port_status |= (1 << USB_PORT_FEAT_ENABLE);
+
+		if (hprt0.b.prtsusp)
+			port_status |= (1 << USB_PORT_FEAT_SUSPEND);
+
+		if (hprt0.b.prtovrcurract)
+			port_status |= (1 << USB_PORT_FEAT_OVER_CURRENT);
+
+		if (hprt0.b.prtrst)
+			port_status |= (1 << USB_PORT_FEAT_RESET);
+
+		if (hprt0.b.prtpwr)
+			port_status |= (1 << USB_PORT_FEAT_POWER);
+
+		if (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_HIGH_SPEED)
+			port_status |= (1 << USB_PORT_FEAT_HIGHSPEED);
+		else if (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_LOW_SPEED)
+			port_status |= (1 << USB_PORT_FEAT_LOWSPEED);
+
+		if (hprt0.b.prttstctl)
+			port_status |= (1 << USB_PORT_FEAT_TEST);
+
+		/* USB_PORT_FEAT_INDICATOR unsupported always 0 */
+
+		*((__le32 *) _buf) = cpu_to_le32(port_status);
+
+		break;
+	case SetHubFeature:
+		DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+			    "SetHubFeature\n");
+		/* No HUB features supported */
+		break;
+	case SetPortFeature:
+		if (_wValue != USB_PORT_FEAT_TEST && (!_wIndex || _wIndex > 1))
+			goto error;
+
+		if (!dwc_otg_hcd->flags.b.port_connect_status) {
+			/*
+			 * The port is disconnected, which means the core is
+			 * either in device mode or it soon will be. Just
+			 * return without doing anything since the port
+			 * register can't be written if the core is in device
+			 * mode.
+			 */
+			break;
+		}
+
+		switch (_wValue) {
+		case USB_PORT_FEAT_SUSPEND:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "SetPortFeature - USB_PORT_FEAT_SUSPEND\n");
+			if (hcd->self.otg_port == _wIndex &&
+			    hcd->self.b_hnp_enable) {
+				union gotgctl_data gotgctl = {.d32 = 0 };
+				gotgctl.b.hstsethnpen = 1;
+				dwc_modify_reg32(&core_if->core_global_regs->
+						 gotgctl, 0, gotgctl.d32);
+				core_if->op_state = A_SUSPEND;
+			}
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			hprt0.b.prtsusp = 1;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			/* Suspend the Phy Clock */
+			{
+				union pcgcctl_data pcgcctl = {.d32 = 0 };
+				pcgcctl.b.stoppclk = 1;
+				dwc_write_reg32(core_if->pcgcctl, pcgcctl.d32);
+			}
+
+			/*
+			 * For HNP the bus must be suspended for at
+			 * least 200ms.
+			 */
+			if (hcd->self.b_hnp_enable)
+				mdelay(200);
+			break;
+		case USB_PORT_FEAT_POWER:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "SetPortFeature - USB_PORT_FEAT_POWER\n");
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			hprt0.b.prtpwr = 1;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			break;
+		case USB_PORT_FEAT_RESET:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "SetPortFeature - USB_PORT_FEAT_RESET\n");
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			/* When B-Host the Port reset bit is set in
+			 * the Start HCD Callback function, so that
+			 * the reset is started within 1ms of the HNP
+			 * success interrupt. */
+			if (!hcd->self.is_b_host) {
+				hprt0.b.prtrst = 1;
+				dwc_write_reg32(core_if->host_if->hprt0,
+						hprt0.d32);
+			}
+			/* Clear reset bit in 10ms (FS/LS) or 50ms (HS) */
+			mdelay(60);
+			hprt0.b.prtrst = 0;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+			break;
+
+#ifdef DWC_HS_ELECT_TST
+		case USB_PORT_FEAT_TEST:
+			t = (_wIndex >> 8);	/* MSB wIndex USB */
+			DWC_DEBUGPL(DBG_HCD,
+				"DWC OTG HCD HUB CONTROL - "
+				"SetPortFeature - USB_PORT_FEAT_TEST %d\n", t);
+			warn("USB_PORT_FEAT_TEST %d\n", t);
+			if (t < 6) {
+				hprt0.d32 = dwc_otg_read_hprt0(core_if);
+				hprt0.b.prttstctl = t;
+				dwc_write_reg32(core_if->host_if->hprt0,
+						hprt0.d32);
+			} else {
+				/* Setup global vars with reg
+				 * addresses (quick and dirty hack,
+				 * should be cleaned up)
+				 */
+				global_regs = core_if->core_global_regs;
+				hc_global_regs =
+					core_if->host_if->host_global_regs;
+				hc_regs =
+					(struct dwc_otg_hc_regs *) ((char *)
+								global_regs +
+								0x500);
+				data_fifo =
+					(uint32_t *) ((char *)global_regs +
+						0x1000);
+
+				if (t == 6) {	/* HS_HOST_PORT_SUSPEND_RESUME */
+						/* Save current interrupt mask */
+					gintmsk.d32 =
+						dwc_read_reg32(&global_regs->gintmsk);
+
+					/* Disable all interrupts
+					 * while we muck with the
+					 * hardware directly
+					 */
+					dwc_write_reg32(&global_regs->gintmsk,
+							0);
+
+					/* 15 second delay per the test spec */
+					mdelay(15000);
+
+					/* Drive suspend on the root port */
+					hprt0.d32 =
+						dwc_otg_read_hprt0(core_if);
+					hprt0.b.prtsusp = 1;
+					hprt0.b.prtres = 0;
+					dwc_write_reg32(core_if->host_if->hprt0,
+							hprt0.d32);
+
+					/* 15 second delay per the test spec */
+					mdelay(15000);
+
+					/* Drive resume on the root port */
+					hprt0.d32 = dwc_otg_read_hprt0(core_if);
+					hprt0.b.prtsusp = 0;
+					hprt0.b.prtres = 1;
+					dwc_write_reg32(core_if->host_if->hprt0,
+							hprt0.d32);
+					mdelay(100);
+
+					/* Clear the resume bit */
+					hprt0.b.prtres = 0;
+					dwc_write_reg32(core_if->host_if->hprt0,
+							hprt0.d32);
+
+					/* Restore interrupts */
+					dwc_write_reg32(&global_regs->gintmsk,
+							gintmsk.d32);
+				} else if (t == 7) {
+					/* SINGLE_STEP_GET_DEVICE_DESCRIPTOR setup */
+					/* Save current interrupt mask */
+					gintmsk.d32 =
+						dwc_read_reg32(&global_regs->gintmsk);
+
+					/*
+					 * Disable all interrupts
+					 * while we muck with the
+					 * hardware directly
+					 */
+					dwc_write_reg32(&global_regs->gintmsk,
+							0);
+
+					/* 15 second delay per the test spec */
+					mdelay(15000);
+
+					/* Send the Setup packet */
+					do_setup();
+
+					/*
+					 * 15 second delay so nothing
+					 * else happens for awhile.
+					 */
+					mdelay(15000);
+
+					/* Restore interrupts */
+					dwc_write_reg32(&global_regs->gintmsk,
+							gintmsk.d32);
+				} else if (t == 8) {
+					/* SINGLE_STEP_GET_DEVICE_DESCRIPTOR execute */
+					/* Save current interrupt mask */
+					gintmsk.d32 =
+						dwc_read_reg32(&global_regs->gintmsk);
+
+					/*
+					 * Disable all interrupts
+					 * while we muck with the
+					 * hardware directly
+					 */
+					dwc_write_reg32(&global_regs->gintmsk,
+							0);
+
+					/* Send the Setup packet */
+					do_setup();
+
+					/* 15 second delay so nothing else happens for awhile */
+					mdelay(15000);
+
+					/* Send the In and Ack packets */
+					do_in_ack();
+
+					/* 15 second delay so nothing else happens for awhile */
+					mdelay(15000);
+
+					/* Restore interrupts */
+					dwc_write_reg32(&global_regs->gintmsk,
+							gintmsk.d32);
+				}
+			}
+			break;
+#endif /* DWC_HS_ELECT_TST */
+
+		case USB_PORT_FEAT_INDICATOR:
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD HUB CONTROL - "
+				    "SetPortFeature - USB_PORT_FEAT_INDICATOR\n");
+			/* Not supported */
+			break;
+		default:
+			retval = -EINVAL;
+			DWC_ERROR("DWC OTG HCD - "
+				  "SetPortFeature request %xh "
+				  "unknown or unsupported\n", _wValue);
+			break;
+		}
+		break;
+	default:
+error:
+		retval = -EINVAL;
+		DWC_WARN("DWC OTG HCD - Unknown hub control request type or "
+			 "invalid typeReq: %xh wIndex: %xh wValue: %xh\n",
+			 _typeReq, _wIndex, _wValue);
+		break;
+	}
+
+	spin_unlock_irqrestore(&dwc_otg_hcd->global_lock, flags);
+
+	return retval;
+}
+
+/**
+ * Assigns transactions from a QTD to a free host channel and initializes the
+ * host channel to perform the transactions. The host channel is removed from
+ * the free list.
+ *
+ * @hcd: The HCD state structure.
+ * @_qh: Transactions from the first QTD for this QH are selected and
+ * assigned to a free host channel.
+ */
+static void assign_and_init_hc(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *_qh)
+{
+	struct dwc_hc *hc;
+	struct dwc_otg_qtd *qtd;
+	struct urb *urb;
+
+	DWC_DEBUGPL(DBG_HCDV, "%s(%p,%p)\n", __func__, hcd, _qh);
+
+	hc = list_entry(hcd->free_hc_list.next, struct dwc_hc, hc_list_entry);
+
+	/* Remove the host channel from the free list. */
+	list_del_init(&hc->hc_list_entry);
+
+	qtd = list_entry(_qh->qtd_list.next, struct dwc_otg_qtd,
+			 qtd_list_entry);
+	urb = qtd->urb;
+	_qh->channel = hc;
+	_qh->qtd_in_process = qtd;
+
+	/*
+	 * Use usb_pipedevice to determine device address. This address is
+	 * 0 before the SET_ADDRESS command and the correct address afterward.
+	 */
+	hc->dev_addr = usb_pipedevice(urb->pipe);
+	hc->ep_num = usb_pipeendpoint(urb->pipe);
+
+	if (urb->dev->speed == USB_SPEED_LOW)
+		hc->speed = DWC_OTG_EP_SPEED_LOW;
+	else if (urb->dev->speed == USB_SPEED_FULL)
+		hc->speed = DWC_OTG_EP_SPEED_FULL;
+	else
+		hc->speed = DWC_OTG_EP_SPEED_HIGH;
+
+	hc->max_packet = dwc_max_packet(_qh->maxp);
+
+	hc->xfer_started = 0;
+	hc->halt_status = DWC_OTG_HC_XFER_NO_HALT_STATUS;
+	hc->error_state = (qtd->error_count > 0);
+	hc->halt_on_queue = 0;
+	hc->halt_pending = 0;
+	hc->requests = 0;
+
+	/*
+	 * The following values may be modified in the transfer type section
+	 * below. The xfer_len value may be reduced when the transfer is
+	 * started to accommodate the max widths of the XferSize and PktCnt
+	 * fields in the HCTSIZn register.
+	 */
+	hc->do_ping = _qh->ping_state;
+	hc->ep_is_in = (usb_pipein(urb->pipe) != 0);
+	hc->data_pid_start = _qh->data_toggle;
+	hc->multi_count = 1;
+
+	if (hcd->core_if->dma_enable) {
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		const uint64_t USBN_DMA0_INB_CHN0 =
+		    CVMX_USBNX_DMA0_INB_CHN0(hcd->core_if->usb_num);
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
+		hc->xfer_buff =
+		    (uint8_t *) (unsigned long)urb->transfer_dma +
+		    urb->actual_length;
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		/* Octeon uses external DMA */
+		wmb();
+		cvmx_write_csr(USBN_DMA0_INB_CHN0 + hc->hc_num * 8,
+			       (unsigned long)hc->xfer_buff);
+		cvmx_read_csr(USBN_DMA0_INB_CHN0 + hc->hc_num * 8);
+		DWC_DEBUGPL(DBG_HCDV,
+			    "IN: hc->hc_num = %d, hc->xfer_buff = %p\n",
+			    hc->hc_num, hc->xfer_buff);
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
+	} else {
+		hc->xfer_buff =
+		    (uint8_t *) urb->transfer_buffer + urb->actual_length;
+	}
+	hc->xfer_len = urb->transfer_buffer_length - urb->actual_length;
+	hc->xfer_count = 0;
+
+	/*
+	 * Set the split attributes
+	 */
+	hc->do_split = 0;
+	if (_qh->do_split) {
+		hc->do_split = 1;
+		hc->xact_pos = qtd->isoc_split_pos;
+		hc->complete_split = qtd->complete_split;
+		hc->hub_addr = urb->dev->tt->hub->devnum;
+		hc->port_addr = urb->dev->ttport;
+	}
+
+	switch (usb_pipetype(urb->pipe)) {
+	case PIPE_CONTROL:
+		hc->ep_type = DWC_OTG_EP_TYPE_CONTROL;
+		switch (qtd->control_phase) {
+		case DWC_OTG_CONTROL_SETUP:
+			DWC_DEBUGPL(DBG_HCDV, "  Control setup transaction\n");
+			hc->do_ping = 0;
+			hc->ep_is_in = 0;
+			hc->data_pid_start = DWC_OTG_HC_PID_SETUP;
+			if (hcd->core_if->dma_enable) {
+				hc->xfer_buff =
+				    (uint8_t *) (unsigned long)urb->setup_dma;
+			} else {
+				hc->xfer_buff = (uint8_t *) urb->setup_packet;
+			}
+			hc->xfer_len = 8;
+			break;
+		case DWC_OTG_CONTROL_DATA:
+			DWC_DEBUGPL(DBG_HCDV, "  Control data transaction\n");
+			hc->data_pid_start = qtd->data_toggle;
+			break;
+		case DWC_OTG_CONTROL_STATUS:
+			/*
+			 * Direction is opposite of data direction or IN if no
+			 * data.
+			 */
+			DWC_DEBUGPL(DBG_HCDV, "  Control status transaction\n");
+			if (urb->transfer_buffer_length == 0) {
+				hc->ep_is_in = 1;
+			} else {
+				hc->ep_is_in =
+				    (usb_pipein(urb->pipe) != USB_DIR_IN);
+			}
+			if (hc->ep_is_in)
+				hc->do_ping = 0;
+			hc->data_pid_start = DWC_OTG_HC_PID_DATA1;
+			hc->xfer_len = 0;
+			if (hcd->core_if->dma_enable) {
+				hc->xfer_buff =
+				    (uint8_t *) (unsigned long)hcd->
+				    status_buf_dma;
+			} else {
+				hc->xfer_buff = (uint8_t *) hcd->status_buf;
+			}
+			break;
+		}
+		break;
+	case PIPE_BULK:
+		hc->ep_type = DWC_OTG_EP_TYPE_BULK;
+		break;
+	case PIPE_INTERRUPT:
+		hc->ep_type = DWC_OTG_EP_TYPE_INTR;
+		break;
+	case PIPE_ISOCHRONOUS:
+		{
+			struct usb_iso_packet_descriptor *frame_desc;
+			frame_desc =
+			    &urb->iso_frame_desc[qtd->isoc_frame_index];
+			hc->ep_type = DWC_OTG_EP_TYPE_ISOC;
+			if (hcd->core_if->dma_enable) {
+				hc->xfer_buff =
+				    (uint8_t *) (unsigned long)urb->
+				    transfer_dma;
+			} else {
+				hc->xfer_buff =
+				    (uint8_t *) urb->transfer_buffer;
+			}
+			hc->xfer_buff +=
+			    frame_desc->offset + qtd->isoc_split_offset;
+			hc->xfer_len =
+			    frame_desc->length - qtd->isoc_split_offset;
+
+			if (hc->xact_pos == DWC_HCSPLIT_XACTPOS_ALL) {
+				if (hc->xfer_len <= 188) {
+					hc->xact_pos = DWC_HCSPLIT_XACTPOS_ALL;
+				} else {
+					hc->xact_pos =
+					    DWC_HCSPLIT_XACTPOS_BEGIN;
+				}
+			}
+		}
+		break;
+	}
+
+	if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+	    hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+		/*
+		 * This value may be modified when the transfer is started to
+		 * reflect the actual transfer length.
+		 */
+		hc->multi_count = dwc_hb_mult(_qh->maxp);
+	}
+
+	dwc_otg_hc_init(hcd->core_if, hc);
+	hc->qh = _qh;
+}
+
+/**
+ * This function selects transactions from the HCD transfer schedule and
+ * assigns them to available host channels. It is called from HCD interrupt
+ * handler functions.
+ *
+ * @hcd: The HCD state structure.
+ *
+ * Returns The types of new transactions that were assigned to host channels.
+ */
+enum dwc_otg_transaction_type dwc_otg_hcd_select_transactions(struct dwc_otg_hcd
+							   *hcd)
+{
+	struct list_head *qh_ptr;
+	struct dwc_otg_qh *qh;
+	int num_channels;
+	enum dwc_otg_transaction_type ret_val = DWC_OTG_TRANSACTION_NONE;
+
+#ifdef DEBUG_SOF
+	DWC_DEBUGPL(DBG_HCD, "  Select Transactions\n");
+#endif
+
+	/* Process entries in the periodic ready list. */
+	qh_ptr = hcd->periodic_sched_ready.next;
+	while (qh_ptr != &hcd->periodic_sched_ready &&
+	       !list_empty(&hcd->free_hc_list)) {
+
+		qh = list_entry(qh_ptr, struct dwc_otg_qh, qh_list_entry);
+		assign_and_init_hc(hcd, qh);
+
+		/*
+		 * Move the QH from the periodic ready schedule to the
+		 * periodic assigned schedule.
+		 */
+		qh_ptr = qh_ptr->next;
+		list_move(&qh->qh_list_entry, &hcd->periodic_sched_assigned);
+
+		ret_val = DWC_OTG_TRANSACTION_PERIODIC;
+	}
+
+	/*
+	 * Process entries in the inactive portion of the non-periodic
+	 * schedule. Some free host channels may not be used if they are
+	 * reserved for periodic transfers.
+	 */
+	qh_ptr = hcd->non_periodic_sched_inactive.next;
+	num_channels = hcd->core_if->core_params->host_channels;
+	while (qh_ptr != &hcd->non_periodic_sched_inactive &&
+	       (hcd->non_periodic_channels <
+		num_channels - hcd->periodic_channels) &&
+	       !list_empty(&hcd->free_hc_list)) {
+
+		qh = list_entry(qh_ptr, struct dwc_otg_qh, qh_list_entry);
+		assign_and_init_hc(hcd, qh);
+
+		/*
+		 * Move the QH from the non-periodic inactive schedule to the
+		 * non-periodic active schedule.
+		 */
+		qh_ptr = qh_ptr->next;
+		list_move(&qh->qh_list_entry, &hcd->non_periodic_sched_active);
+
+		if (ret_val == DWC_OTG_TRANSACTION_NONE)
+			ret_val = DWC_OTG_TRANSACTION_NON_PERIODIC;
+		else
+			ret_val = DWC_OTG_TRANSACTION_ALL;
+
+		hcd->non_periodic_channels++;
+	}
+
+	return ret_val;
+}
+
+/**
+ * Attempts to queue a single transaction request for a host channel
+ * associated with either a periodic or non-periodic transfer. This function
+ * assumes that there is space available in the appropriate request queue. For
+ * an OUT transfer or SETUP transaction in Slave mode, it checks whether space
+ * is available in the appropriate Tx FIFO.
+ *
+ * @hcd: The HCD state structure.
+ * @_hc: Host channel descriptor associated with either a periodic or
+ * non-periodic transfer.
+ * @_fifo_dwords_avail: Number of DWORDs available in the periodic Tx
+ * FIFO for periodic transfers or the non-periodic Tx FIFO for non-periodic
+ * transfers.
+ *
+ * Returns 1 if a request is queued and more requests may be needed to
+ * complete the transfer, 0 if no more requests are required for this
+ * transfer, -1 if there is insufficient space in the Tx FIFO.
+ */
+static int queue_transaction(struct dwc_otg_hcd *hcd,
+			     struct dwc_hc *_hc, uint16_t _fifo_dwords_avail)
+{
+	int retval;
+
+	if (hcd->core_if->dma_enable) {
+		if (!_hc->xfer_started) {
+			dwc_otg_hc_start_transfer(hcd->core_if, _hc);
+			_hc->qh->ping_state = 0;
+		}
+		retval = 0;
+	} else if (_hc->halt_pending) {
+		/* Don't queue a request if the channel has been halted. */
+		retval = 0;
+	} else if (_hc->halt_on_queue) {
+		dwc_otg_hc_halt(hcd->core_if, _hc, _hc->halt_status);
+		retval = 0;
+	} else if (_hc->do_ping) {
+		if (!_hc->xfer_started)
+			dwc_otg_hc_start_transfer(hcd->core_if, _hc);
+		retval = 0;
+	} else if (!_hc->ep_is_in ||
+		   _hc->data_pid_start == DWC_OTG_HC_PID_SETUP) {
+		if ((_fifo_dwords_avail * 4) >= _hc->max_packet) {
+			if (!_hc->xfer_started) {
+				dwc_otg_hc_start_transfer(hcd->core_if, _hc);
+				retval = 1;
+			} else {
+				retval =
+				    dwc_otg_hc_continue_transfer(hcd->core_if,
+								 _hc);
+			}
+		} else {
+			retval = -1;
+		}
+	} else {
+		if (!_hc->xfer_started) {
+			dwc_otg_hc_start_transfer(hcd->core_if, _hc);
+			retval = 1;
+		} else {
+			retval =
+			    dwc_otg_hc_continue_transfer(hcd->core_if, _hc);
+		}
+	}
+
+	return retval;
+}
+
+/**
+ * Processes active non-periodic channels and queues transactions for these
+ * channels to the DWC_otg controller. After queueing transactions, the NP Tx
+ * FIFO Empty interrupt is enabled if there are more transactions to queue as
+ * NP Tx FIFO or request queue space becomes available. Otherwise, the NP Tx
+ * FIFO Empty interrupt is disabled.
+ */
+static void process_non_periodic_channels(struct dwc_otg_hcd *hcd)
+{
+	union gnptxsts_data tx_status;
+	struct list_head *orig_qh_ptr;
+	struct dwc_otg_qh *qh;
+	int status;
+	int no_queue_space = 0;
+	int no_fifo_space = 0;
+	int more_to_do = 0;
+
+	struct dwc_otg_core_global_regs *global_regs =
+	    hcd->core_if->core_global_regs;
+
+	DWC_DEBUGPL(DBG_HCDV, "Queue non-periodic transactions\n");
+#ifdef DEBUG
+	tx_status.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+	DWC_DEBUGPL(DBG_HCDV,
+		    "  NP Tx Req Queue Space Avail (before queue): %d\n",
+		    tx_status.b.nptxqspcavail);
+	DWC_DEBUGPL(DBG_HCDV, "  NP Tx FIFO Space Avail (before queue): %d\n",
+		    tx_status.b.nptxfspcavail);
+#endif
+	/*
+	 * Keep track of the starting point. Skip over the start-of-list
+	 * entry.
+	 */
+	if (hcd->non_periodic_qh_ptr == &hcd->non_periodic_sched_active)
+		hcd->non_periodic_qh_ptr = hcd->non_periodic_qh_ptr->next;
+
+	orig_qh_ptr = hcd->non_periodic_qh_ptr;
+
+	/*
+	 * Process once through the active list or until no more space is
+	 * available in the request queue or the Tx FIFO.
+	 */
+	do {
+		tx_status.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+		if (!hcd->core_if->dma_enable
+		    && tx_status.b.nptxqspcavail == 0) {
+			no_queue_space = 1;
+			break;
+		}
+
+		qh = list_entry(hcd->non_periodic_qh_ptr, struct dwc_otg_qh,
+				qh_list_entry);
+		status =
+		    queue_transaction(hcd, qh->channel,
+				      tx_status.b.nptxfspcavail);
+
+		if (status > 0) {
+			more_to_do = 1;
+		} else if (status < 0) {
+			no_fifo_space = 1;
+			break;
+		}
+
+		/* Advance to next QH, skipping start-of-list entry. */
+		hcd->non_periodic_qh_ptr = hcd->non_periodic_qh_ptr->next;
+		if (hcd->non_periodic_qh_ptr ==
+		    &hcd->non_periodic_sched_active) {
+			hcd->non_periodic_qh_ptr =
+			    hcd->non_periodic_qh_ptr->next;
+		}
+
+	} while (hcd->non_periodic_qh_ptr != orig_qh_ptr);
+
+	if (!hcd->core_if->dma_enable) {
+		union gintmsk_data intr_mask = {.d32 = 0 };
+		intr_mask.b.nptxfempty = 1;
+
+#ifdef DEBUG
+		tx_status.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+		DWC_DEBUGPL(DBG_HCDV,
+			    "  NP Tx Req Queue Space Avail (after queue): %d\n",
+			    tx_status.b.nptxqspcavail);
+		DWC_DEBUGPL(DBG_HCDV,
+			    "  NP Tx FIFO Space Avail (after queue): %d\n",
+			    tx_status.b.nptxfspcavail);
+#endif
+		if (no_queue_space || no_fifo_space) {
+			/*
+			 * May need to queue more transactions as the request
+			 * queue or Tx FIFO empties. Enable the non-periodic
+			 * Tx FIFO empty interrupt. (Always use the half-empty
+			 * level to ensure that new requests are loaded as
+			 * soon as possible.)
+			 */
+			dwc_modify_reg32(&global_regs->gintmsk, 0,
+					 intr_mask.d32);
+		} else {
+			/*
+			 * Disable the Tx FIFO empty interrupt since there are
+			 * no more transactions that need to be queued right
+			 * now. This function is called from interrupt
+			 * handlers to queue more transactions as transfer
+			 * states change.
+			 */
+			dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32,
+					 0);
+			if (more_to_do) {
+				/* When not using DMA, many USB
+				 * devices cause excessive loads on
+				 * the serial bus simply because they
+				 * continuously poll the device for
+				 * status. Here we use the timer to
+				 * rate limit how fast we can get the
+				 * the NP TX fifo empty interrupt. We
+				 * leave the interrupt disable until
+				 * the timer fires and reenables it */
+
+				/* We'll rate limit the interrupt at
+				 * 20000 per second. Making this
+				 * faster improves USB performance but
+				 * uses more CPU */
+				hrtimer_start_range_ns(&hcd->poll_rate_limit,
+						       ktime_set(0, 50000),
+						       5000, HRTIMER_MODE_REL);
+			}
+		}
+	}
+}
+
+/**
+ * Processes periodic channels for the next frame and queues transactions for
+ * these channels to the DWC_otg controller. After queueing transactions, the
+ * Periodic Tx FIFO Empty interrupt is enabled if there are more transactions
+ * to queue as Periodic Tx FIFO or request queue space becomes available.
+ * Otherwise, the Periodic Tx FIFO Empty interrupt is disabled.
+ */
+static void process_periodic_channels(struct dwc_otg_hcd *hcd)
+{
+	union hptxsts_data tx_status;
+	struct list_head *qh_ptr;
+	struct dwc_otg_qh *qh;
+	int status;
+	int no_queue_space = 0;
+	int no_fifo_space = 0;
+
+	struct dwc_otg_host_global_regs *host_regs;
+	host_regs = hcd->core_if->host_if->host_global_regs;
+
+	DWC_DEBUGPL(DBG_HCDV, "Queue periodic transactions\n");
+#ifdef DEBUG
+	tx_status.d32 = dwc_read_reg32(&host_regs->hptxsts);
+	DWC_DEBUGPL(DBG_HCDV,
+		    "  P Tx Req Queue Space Avail (before queue): %d\n",
+		    tx_status.b.ptxqspcavail);
+	DWC_DEBUGPL(DBG_HCDV, "  P Tx FIFO Space Avail (before queue): %d\n",
+		    tx_status.b.ptxfspcavail);
+#endif
+
+	qh_ptr = hcd->periodic_sched_assigned.next;
+	while (qh_ptr != &hcd->periodic_sched_assigned) {
+		tx_status.d32 = dwc_read_reg32(&host_regs->hptxsts);
+		if (tx_status.b.ptxqspcavail == 0) {
+			no_queue_space = 1;
+			break;
+		}
+
+		qh = list_entry(qh_ptr, struct dwc_otg_qh, qh_list_entry);
+
+		/*
+		 * Set a flag if we're queuing high-bandwidth in slave mode.
+		 * The flag prevents any halts to get into the request queue in
+		 * the middle of multiple high-bandwidth packets getting queued.
+		 */
+		if ((!hcd->core_if->dma_enable) &&
+		    (qh->channel->multi_count > 1)) {
+			hcd->core_if->queuing_high_bandwidth = 1;
+		}
+
+		status =
+		    queue_transaction(hcd, qh->channel,
+				      tx_status.b.ptxfspcavail);
+		if (status < 0) {
+			no_fifo_space = 1;
+			break;
+		}
+
+		/*
+		 * In Slave mode, stay on the current transfer until there is
+		 * nothing more to do or the high-bandwidth request count is
+		 * reached. In DMA mode, only need to queue one request. The
+		 * controller automatically handles multiple packets for
+		 * high-bandwidth transfers.
+		 */
+		if (hcd->core_if->dma_enable ||
+		    (status == 0 ||
+		     qh->channel->requests == qh->channel->multi_count)) {
+			qh_ptr = qh_ptr->next;
+			/*
+			 * Move the QH from the periodic assigned schedule to
+			 * the periodic queued schedule.
+			 */
+			list_move(&qh->qh_list_entry,
+				  &hcd->periodic_sched_queued);
+
+			/* done queuing high bandwidth */
+			hcd->core_if->queuing_high_bandwidth = 0;
+		}
+	}
+
+	if (!hcd->core_if->dma_enable) {
+		struct dwc_otg_core_global_regs *global_regs;
+		union gintmsk_data intr_mask = {.d32 = 0 };
+
+		global_regs = hcd->core_if->core_global_regs;
+		intr_mask.b.ptxfempty = 1;
+#ifdef DEBUG
+		tx_status.d32 = dwc_read_reg32(&host_regs->hptxsts);
+		DWC_DEBUGPL(DBG_HCDV,
+			    "  P Tx Req Queue Space Avail (after queue): %d\n",
+			    tx_status.b.ptxqspcavail);
+		DWC_DEBUGPL(DBG_HCDV,
+			    "  P Tx FIFO Space Avail (after queue): %d\n",
+			    tx_status.b.ptxfspcavail);
+#endif
+		if (!(list_empty(&hcd->periodic_sched_assigned)) ||
+		    no_queue_space || no_fifo_space) {
+			/*
+			 * May need to queue more transactions as the request
+			 * queue or Tx FIFO empties. Enable the periodic Tx
+			 * FIFO empty interrupt. (Always use the half-empty
+			 * level to ensure that new requests are loaded as
+			 * soon as possible.)
+			 */
+			dwc_modify_reg32(&global_regs->gintmsk, 0,
+					 intr_mask.d32);
+		} else {
+			/*
+			 * Disable the Tx FIFO empty interrupt since there are
+			 * no more transactions that need to be queued right
+			 * now. This function is called from interrupt
+			 * handlers to queue more transactions as transfer
+			 * states change.
+			 */
+			dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32,
+					 0);
+		}
+	}
+}
+
+/**
+ * This function processes the currently active host channels and queues
+ * transactions for these channels to the DWC_otg controller. It is called
+ * from HCD interrupt handler functions.
+ *
+ * @hcd: The HCD state structure.
+ * @_tr_type: The type(s) of transactions to queue (non-periodic,
+ * periodic, or both).
+ */
+void dwc_otg_hcd_queue_transactions(struct dwc_otg_hcd *hcd,
+				    enum dwc_otg_transaction_type _tr_type)
+{
+#ifdef DEBUG_SOF
+	DWC_DEBUGPL(DBG_HCD, "Queue Transactions\n");
+#endif
+	/* Process host channels associated with periodic transfers. */
+	if ((_tr_type == DWC_OTG_TRANSACTION_PERIODIC ||
+	     _tr_type == DWC_OTG_TRANSACTION_ALL) &&
+	    !list_empty(&hcd->periodic_sched_assigned)) {
+
+		process_periodic_channels(hcd);
+	}
+
+	/* Process host channels associated with non-periodic transfers. */
+	if ((_tr_type == DWC_OTG_TRANSACTION_NON_PERIODIC ||
+	     _tr_type == DWC_OTG_TRANSACTION_ALL)) {
+		if (!list_empty(&hcd->non_periodic_sched_active)) {
+			process_non_periodic_channels(hcd);
+		} else {
+			/*
+			 * Ensure NP Tx FIFO empty interrupt is disabled when
+			 * there are no non-periodic transfers to process.
+			 */
+			union gintmsk_data gintmsk = {.d32 = 0 };
+			gintmsk.b.nptxfempty = 1;
+			dwc_modify_reg32(&hcd->core_if->core_global_regs->
+					 gintmsk, gintmsk.d32, 0);
+		}
+	}
+}
+
+/**
+ * Sets the final status of an URB and returns it to the device driver. Any
+ * required cleanup of the URB is performed.
+ */
+void dwc_otg_hcd_complete_urb(struct dwc_otg_hcd *hcd, struct urb *urb,
+			      int status)
+{
+#ifdef DEBUG
+	if (CHK_DEBUG_LEVEL(DBG_HCDV | DBG_HCD_URB)) {
+		DWC_PRINT("%s: urb %p, device %d, ep %d %s, status=%d\n",
+			  __func__, urb, usb_pipedevice(urb->pipe),
+			  usb_pipeendpoint(urb->pipe),
+			  usb_pipein(urb->pipe) ? "IN" : "OUT", status);
+		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
+			int i;
+			for (i = 0; i < urb->number_of_packets; i++) {
+				DWC_PRINT("  ISO Desc %d status: %d\n",
+					  i, urb->iso_frame_desc[i].status);
+			}
+		}
+	}
+#endif
+
+	urb->status = status;
+	urb->hcpriv = NULL;
+
+	usb_hcd_giveback_urb(dwc_otg_hcd_to_hcd(hcd), urb, status);
+}
+
+/*
+ * Returns the Queue Head for an URB.
+ */
+struct dwc_otg_qh *dwc_urb_to_qh(struct urb *urb)
+{
+	struct usb_host_endpoint *ep = dwc_urb_to_endpoint(urb);
+	return ep->hcpriv;
+}
+
+#ifdef DEBUG
+void dwc_print_setup_data(uint8_t *setup)
+{
+	int i;
+	if (CHK_DEBUG_LEVEL(DBG_HCD)) {
+		DWC_PRINT("Setup Data = MSB ");
+		for (i = 7; i >= 0; i--)
+			DWC_PRINT("%02x ", setup[i]);
+		DWC_PRINT("\n");
+		DWC_PRINT("  bmRequestType Tranfer = %s\n",
+			  (setup[0] & 0x80) ? "Device-to-Host" :
+			  "Host-to-Device");
+		DWC_PRINT("  bmRequestType Type = ");
+		switch ((setup[0] & 0x60) >> 5) {
+		case 0:
+			DWC_PRINT("Standard\n");
+			break;
+		case 1:
+			DWC_PRINT("Class\n");
+			break;
+		case 2:
+			DWC_PRINT("Vendor\n");
+			break;
+		case 3:
+			DWC_PRINT("Reserved\n");
+			break;
+		}
+		DWC_PRINT("  bmRequestType Recipient = ");
+		switch (setup[0] & 0x1f) {
+		case 0:
+			DWC_PRINT("Device\n");
+			break;
+		case 1:
+			DWC_PRINT("Interface\n");
+			break;
+		case 2:
+			DWC_PRINT("Endpoint\n");
+			break;
+		case 3:
+			DWC_PRINT("Other\n");
+			break;
+		default:
+			DWC_PRINT("Reserved\n");
+			break;
+		}
+		DWC_PRINT("  bRequest = 0x%0x\n", setup[1]);
+		DWC_PRINT("  wValue = 0x%0x\n", *((uint16_t *) &setup[2]));
+		DWC_PRINT("  wIndex = 0x%0x\n", *((uint16_t *) &setup[4]));
+		DWC_PRINT("  wLength = 0x%0x\n\n", *((uint16_t *) &setup[6]));
+	}
+}
+#endif
+
+void dwc_otg_hcd_dump_frrem(struct dwc_otg_hcd *hcd)
+{
+#ifdef DEBUG
+	DWC_PRINT("Frame remaining at SOF:\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->frrem_samples, hcd->frrem_accum,
+		  (hcd->frrem_samples > 0) ?
+		  hcd->frrem_accum / hcd->frrem_samples : 0);
+
+	DWC_PRINT("\n");
+	DWC_PRINT("Frame remaining at start_transfer (uframe 7):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->core_if->hfnum_7_samples,
+		  hcd->core_if->hfnum_7_frrem_accum,
+		  (hcd->core_if->hfnum_7_samples >
+		   0) ? hcd->core_if->hfnum_7_frrem_accum /
+		  hcd->core_if->hfnum_7_samples : 0);
+	DWC_PRINT("Frame remaining at start_transfer (uframe 0):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->core_if->hfnum_0_samples,
+		  hcd->core_if->hfnum_0_frrem_accum,
+		  (hcd->core_if->hfnum_0_samples >
+		   0) ? hcd->core_if->hfnum_0_frrem_accum /
+		  hcd->core_if->hfnum_0_samples : 0);
+	DWC_PRINT("Frame remaining at start_transfer (uframe 1-6):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->core_if->hfnum_other_samples,
+		  hcd->core_if->hfnum_other_frrem_accum,
+		  (hcd->core_if->hfnum_other_samples >
+		   0) ? hcd->core_if->hfnum_other_frrem_accum /
+		  hcd->core_if->hfnum_other_samples : 0);
+
+	DWC_PRINT("\n");
+	DWC_PRINT("Frame remaining at sample point A (uframe 7):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->hfnum_7_samples_a, hcd->hfnum_7_frrem_accum_a,
+		  (hcd->hfnum_7_samples_a > 0) ?
+		  hcd->hfnum_7_frrem_accum_a / hcd->hfnum_7_samples_a : 0);
+	DWC_PRINT("Frame remaining at sample point A (uframe 0):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->hfnum_0_samples_a, hcd->hfnum_0_frrem_accum_a,
+		  (hcd->hfnum_0_samples_a > 0) ?
+		  hcd->hfnum_0_frrem_accum_a / hcd->hfnum_0_samples_a : 0);
+	DWC_PRINT("Frame remaining at sample point A (uframe 1-6):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->hfnum_other_samples_a, hcd->hfnum_other_frrem_accum_a,
+		  (hcd->hfnum_other_samples_a > 0) ?
+		  hcd->hfnum_other_frrem_accum_a /
+		  hcd->hfnum_other_samples_a : 0);
+
+	DWC_PRINT("\n");
+	DWC_PRINT("Frame remaining at sample point B (uframe 7):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->hfnum_7_samples_b, hcd->hfnum_7_frrem_accum_b,
+		  (hcd->hfnum_7_samples_b > 0) ?
+		  hcd->hfnum_7_frrem_accum_b / hcd->hfnum_7_samples_b : 0);
+	DWC_PRINT("Frame remaining at sample point B (uframe 0):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->hfnum_0_samples_b, hcd->hfnum_0_frrem_accum_b,
+		  (hcd->hfnum_0_samples_b > 0) ?
+		  hcd->hfnum_0_frrem_accum_b / hcd->hfnum_0_samples_b : 0);
+	DWC_PRINT("Frame remaining at sample point B (uframe 1-6):\n");
+	DWC_PRINT("  samples %u, accum %lu, avg %lu\n",
+		  hcd->hfnum_other_samples_b, hcd->hfnum_other_frrem_accum_b,
+		  (hcd->hfnum_other_samples_b > 0) ?
+		  hcd->hfnum_other_frrem_accum_b /
+		  hcd->hfnum_other_samples_b : 0);
+#endif
+}
+
+void dwc_otg_hcd_dump_state(struct dwc_otg_hcd *hcd)
+{
+#ifdef DEBUG
+	int num_channels;
+	int i;
+	union gnptxsts_data np_tx_status;
+	union hptxsts_data p_tx_status;
+
+	num_channels = hcd->core_if->core_params->host_channels;
+	DWC_PRINT("\n");
+	DWC_PRINT
+	    ("************************************************************\n");
+	DWC_PRINT("HCD State:\n");
+	DWC_PRINT("  Num channels: %d\n", num_channels);
+	for (i = 0; i < num_channels; i++) {
+		struct dwc_hc *hc = hcd->hc_ptr_array[i];
+		DWC_PRINT("  Channel %d:\n", i);
+		DWC_PRINT("    dev_addr: %d, ep_num: %d, ep_is_in: %d\n",
+			  hc->dev_addr, hc->ep_num, hc->ep_is_in);
+		DWC_PRINT("    speed: %d\n", hc->speed);
+		DWC_PRINT("    ep_type: %d\n", hc->ep_type);
+		DWC_PRINT("    max_packet: %d\n", hc->max_packet);
+		DWC_PRINT("    data_pid_start: %d\n", hc->data_pid_start);
+		DWC_PRINT("    multi_count: %d\n", hc->multi_count);
+		DWC_PRINT("    xfer_started: %d\n", hc->xfer_started);
+		DWC_PRINT("    xfer_buff: %p\n", hc->xfer_buff);
+		DWC_PRINT("    xfer_len: %d\n", hc->xfer_len);
+		DWC_PRINT("    xfer_count: %d\n", hc->xfer_count);
+		DWC_PRINT("    halt_on_queue: %d\n", hc->halt_on_queue);
+		DWC_PRINT("    halt_pending: %d\n", hc->halt_pending);
+		DWC_PRINT("    halt_status: %d\n", hc->halt_status);
+		DWC_PRINT("    do_split: %d\n", hc->do_split);
+		DWC_PRINT("    complete_split: %d\n", hc->complete_split);
+		DWC_PRINT("    hub_addr: %d\n", hc->hub_addr);
+		DWC_PRINT("    port_addr: %d\n", hc->port_addr);
+		DWC_PRINT("    xact_pos: %d\n", hc->xact_pos);
+		DWC_PRINT("    requests: %d\n", hc->requests);
+		DWC_PRINT("    qh: %p\n", hc->qh);
+		if (hc->xfer_started) {
+			union hfnum_data hfnum;
+			union hcchar_data hcchar;
+			union hctsiz_data hctsiz;
+			union hcint_data hcint;
+			union hcintmsk_data hcintmsk;
+			hfnum.d32 =
+			    dwc_read_reg32(&hcd->core_if->host_if->
+					   host_global_regs->hfnum);
+			hcchar.d32 =
+			    dwc_read_reg32(&hcd->core_if->host_if->hc_regs[i]->
+					   hcchar);
+			hctsiz.d32 =
+			    dwc_read_reg32(&hcd->core_if->host_if->hc_regs[i]->
+					   hctsiz);
+			hcint.d32 =
+			    dwc_read_reg32(&hcd->core_if->host_if->hc_regs[i]->
+					   hcint);
+			hcintmsk.d32 =
+			    dwc_read_reg32(&hcd->core_if->host_if->hc_regs[i]->
+					   hcintmsk);
+			DWC_PRINT("    hfnum: 0x%08x\n", hfnum.d32);
+			DWC_PRINT("    hcchar: 0x%08x\n", hcchar.d32);
+			DWC_PRINT("    hctsiz: 0x%08x\n", hctsiz.d32);
+			DWC_PRINT("    hcint: 0x%08x\n", hcint.d32);
+			DWC_PRINT("    hcintmsk: 0x%08x\n", hcintmsk.d32);
+		}
+		if (hc->xfer_started && (hc->qh != NULL)
+		    && (hc->qh->qtd_in_process != NULL)) {
+			struct dwc_otg_qtd *qtd;
+			struct urb *urb;
+			qtd = hc->qh->qtd_in_process;
+			urb = qtd->urb;
+			DWC_PRINT("    URB Info:\n");
+			DWC_PRINT("      qtd: %p, urb: %p\n", qtd, urb);
+			if (urb != NULL) {
+				DWC_PRINT("      Dev: %d, EP: %d %s\n",
+					  usb_pipedevice(urb->pipe),
+					  usb_pipeendpoint(urb->pipe),
+					  usb_pipein(urb->pipe) ? "IN" : "OUT");
+				DWC_PRINT("      Max packet size: %d\n",
+					  usb_maxpacket(urb->dev, urb->pipe,
+							usb_pipeout(urb->
+								    pipe)));
+				DWC_PRINT("      transfer_buffer: %p\n",
+					  urb->transfer_buffer);
+				DWC_PRINT("      transfer_dma: %p\n",
+					  (void *)urb->transfer_dma);
+				DWC_PRINT("      transfer_buffer_length: %d\n",
+					  urb->transfer_buffer_length);
+				DWC_PRINT("      actual_length: %d\n",
+					  urb->actual_length);
+			}
+		}
+	}
+	DWC_PRINT("  non_periodic_channels: %d\n", hcd->non_periodic_channels);
+	DWC_PRINT("  periodic_channels: %d\n", hcd->periodic_channels);
+	DWC_PRINT("  periodic_usecs: %d\n", hcd->periodic_usecs);
+	np_tx_status.d32 =
+	    dwc_read_reg32(&hcd->core_if->core_global_regs->gnptxsts);
+	DWC_PRINT("  NP Tx Req Queue Space Avail: %d\n",
+		  np_tx_status.b.nptxqspcavail);
+	DWC_PRINT("  NP Tx FIFO Space Avail: %d\n",
+		  np_tx_status.b.nptxfspcavail);
+	p_tx_status.d32 =
+	    dwc_read_reg32(&hcd->core_if->host_if->host_global_regs->hptxsts);
+	DWC_PRINT("  P Tx Req Queue Space Avail: %d\n",
+		  p_tx_status.b.ptxqspcavail);
+	DWC_PRINT("  P Tx FIFO Space Avail: %d\n", p_tx_status.b.ptxfspcavail);
+	dwc_otg_hcd_dump_frrem(hcd);
+	dwc_otg_dump_global_registers(hcd->core_if);
+	dwc_otg_dump_host_registers(hcd->core_if);
+	DWC_PRINT
+	    ("************************************************************\n");
+	DWC_PRINT("\n");
+#endif
+}
+#endif /* DWC_DEVICE_ONLY */
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd.h b/drivers/usb/host/dwc_otg/dwc_otg_hcd.h
new file mode 100644
index 0000000..6dcf1f5
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd.h
@@ -0,0 +1,661 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+#ifndef DWC_DEVICE_ONLY
+#if !defined(__DWC_HCD_H__)
+#define __DWC_HCD_H__
+
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <linux/hrtimer.h>
+
+#include <../drivers/usb/core/hcd.h>
+
+struct dwc_otg_device;
+
+#include "dwc_otg_cil.h"
+
+/**
+ *
+ * This file contains the structures, constants, and interfaces for
+ * the Host Contoller Driver (HCD).
+ *
+ * The Host Controller Driver (HCD) is responsible for translating requests
+ * from the USB Driver into the appropriate actions on the DWC_otg controller.
+ * It isolates the USBD from the specifics of the controller by providing an
+ * API to the USBD.
+ */
+
+/**
+ * Phases for control transfers.
+ */
+enum dwc_otg_control_phase {
+	DWC_OTG_CONTROL_SETUP,
+	DWC_OTG_CONTROL_DATA,
+	DWC_OTG_CONTROL_STATUS
+};
+
+/** Transaction types. */
+enum dwc_otg_transaction_type {
+	DWC_OTG_TRANSACTION_NONE,
+	DWC_OTG_TRANSACTION_PERIODIC,
+	DWC_OTG_TRANSACTION_NON_PERIODIC,
+	DWC_OTG_TRANSACTION_ALL
+};
+
+struct dwc_otg_qh;
+
+/*
+ * A Queue Transfer Descriptor (QTD) holds the state of a bulk, control,
+ * interrupt, or isochronous transfer. A single QTD is created for each URB
+ * (of one of these types) submitted to the HCD. The transfer associated with
+ * a QTD may require one or multiple transactions.
+ *
+ * A QTD is linked to a Queue Head, which is entered in either the
+ * non-periodic or periodic schedule for execution. When a QTD is chosen for
+ * execution, some or all of its transactions may be executed. After
+ * execution, the state of the QTD is updated. The QTD may be retired if all
+ * its transactions are complete or if an error occurred. Otherwise, it
+ * remains in the schedule so more transactions can be executed later.
+ */
+struct dwc_otg_qtd {
+	/*
+	 * Determines the PID of the next data packet for the data phase of
+	 * control transfers. Ignored for other transfer types.<br>
+	 * One of the following values:
+	 *	- DWC_OTG_HC_PID_DATA0
+	 *	- DWC_OTG_HC_PID_DATA1
+	 */
+	uint8_t data_toggle;
+
+	/** Current phase for control transfers (Setup, Data, or Status). */
+	enum dwc_otg_control_phase control_phase;
+
+	/** Keep track of the current split type
+	 * for FS/LS endpoints on a HS Hub */
+	uint8_t complete_split;
+
+	/** How many bytes transferred during SSPLIT OUT */
+	uint32_t ssplit_out_xfer_count;
+
+	/**
+	 * Holds the number of bus errors that have occurred for a transaction
+	 * within this transfer.
+	 */
+	uint8_t error_count;
+
+	/**
+	 * Index of the next frame descriptor for an isochronous transfer. A
+	 * frame descriptor describes the buffer position and length of the
+	 * data to be transferred in the next scheduled (micro)frame of an
+	 * isochronous transfer. It also holds status for that transaction.
+	 * The frame index starts at 0.
+	 */
+	int isoc_frame_index;
+
+	/** Position of the ISOC split on full/low speed */
+	uint8_t isoc_split_pos;
+
+	/** Position of the ISOC split in the buffer for the current frame */
+	uint16_t isoc_split_offset;
+
+	/** URB for this transfer */
+	struct urb *urb;
+
+	/* The queue head for this transfer. */
+	struct dwc_otg_qh *qh;
+
+	/** This list of QTDs */
+	struct list_head qtd_list_entry;
+
+};
+
+/**
+ * A Queue Head (QH) holds the static characteristics of an endpoint and
+ * maintains a list of transfers (QTDs) for that endpoint. A QH structure may
+ * be entered in either the non-periodic or periodic schedule.
+ */
+struct dwc_otg_qh {
+	/**
+	 * Endpoint type.
+	 * One of the following values:
+	 * 	- USB_ENDPOINT_XFER_CONTROL
+	 *	- USB_ENDPOINT_XFER_ISOC
+	 *	- USB_ENDPOINT_XFER_BULK
+	 *	- USB_ENDPOINT_XFER_INT
+	 */
+	uint8_t ep_type;
+	uint8_t ep_is_in;
+
+	/** wMaxPacketSize Field of Endpoint Descriptor. */
+	uint16_t maxp;
+
+	/**
+	 * Determines the PID of the next data packet for non-control
+	 * transfers. Ignored for control transfers.<br>
+	 * One of the following values:
+	 *	- DWC_OTG_HC_PID_DATA0
+	 * 	- DWC_OTG_HC_PID_DATA1
+	 */
+	uint8_t data_toggle;
+
+	/** Ping state if 1. */
+	uint8_t ping_state;
+
+	/**
+	 * List of QTDs for this QH.
+	 */
+	struct list_head qtd_list;
+
+	/** Host channel currently processing transfers for this QH. */
+	struct dwc_hc *channel;
+
+	/** QTD currently assigned to a host channel for this QH. */
+	struct dwc_otg_qtd *qtd_in_process;
+
+	/** Full/low speed endpoint on high-speed hub requires split. */
+	uint8_t do_split;
+
+	/** @name Periodic schedule information */
+	/** @{ */
+
+	/** Bandwidth in microseconds per (micro)frame. */
+	uint8_t usecs;
+
+	/** Interval between transfers in (micro)frames. */
+	uint16_t interval;
+
+	/**
+	 * (micro)frame to initialize a periodic transfer. The transfer
+	 * executes in the following (micro)frame.
+	 */
+	uint16_t sched_frame;
+
+	/** (micro)frame at which last start split was initialized. */
+	uint16_t start_split_frame;
+
+	/** @} */
+
+	/** Entry for QH in either the periodic or non-periodic schedule. */
+	struct list_head qh_list_entry;
+};
+
+/**
+ * This structure holds the state of the HCD, including the non-periodic and
+ * periodic schedules.
+ */
+struct dwc_otg_hcd {
+
+	/** DWC OTG Core Interface Layer */
+	struct dwc_otg_core_if *core_if;
+
+	/** Internal DWC HCD Flags */
+	union dwc_otg_hcd_internal_flags {
+		uint32_t d32;
+		struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+			unsigned reserved:26;
+			unsigned port_over_current_change:1;
+			unsigned port_suspend_change:1;
+			unsigned port_enable_change:1;
+			unsigned port_reset_change:1;
+			unsigned port_connect_status:1;
+			unsigned port_connect_status_change:1;
+#else
+			unsigned port_connect_status_change:1;
+			unsigned port_connect_status:1;
+			unsigned port_reset_change:1;
+			unsigned port_enable_change:1;
+			unsigned port_suspend_change:1;
+			unsigned port_over_current_change:1;
+			unsigned reserved:26;
+#endif
+		} b;
+	} flags;
+
+	/**
+	 * Inactive items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are not
+	 * currently assigned to a host channel.
+	 */
+	struct list_head non_periodic_sched_inactive;
+
+	/**
+	 * Active items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are
+	 * currently assigned to a host channel.
+	 */
+	struct list_head non_periodic_sched_active;
+
+	/**
+	 * Pointer to the next Queue Head to process in the active
+	 * non-periodic schedule.
+	 */
+	struct list_head *non_periodic_qh_ptr;
+
+	/**
+	 * Inactive items in the periodic schedule. This is a list of QHs for
+	 * periodic transfers that are _not_ scheduled for the next frame.
+	 * Each QH in the list has an interval counter that determines when it
+	 * needs to be scheduled for execution. This scheduling mechanism
+	 * allows only a simple calculation for periodic bandwidth used (i.e.
+	 * must assume that all periodic transfers may need to execute in the
+	 * same frame). However, it greatly simplifies scheduling and should
+	 * be sufficient for the vast majority of OTG hosts, which need to
+	 * connect to a small number of peripherals at one time.
+	 *
+	 * Items move from this list to periodic_sched_ready when the QH
+	 * interval counter is 0 at SOF.
+	 */
+	struct list_head periodic_sched_inactive;
+
+	/**
+	 * List of periodic QHs that are ready for execution in the next
+	 * frame, but have not yet been assigned to host channels.
+	 *
+	 * Items move from this list to periodic_sched_assigned as host
+	 * channels become available during the current frame.
+	 */
+	struct list_head periodic_sched_ready;
+
+	/**
+	 * List of periodic QHs to be executed in the next frame that are
+	 * assigned to host channels.
+	 *
+	 * Items move from this list to periodic_sched_queued as the
+	 * transactions for the QH are queued to the DWC_otg controller.
+	 */
+	struct list_head periodic_sched_assigned;
+
+	/**
+	 * List of periodic QHs that have been queued for execution.
+	 *
+	 * Items move from this list to either periodic_sched_inactive or
+	 * periodic_sched_ready when the channel associated with the transfer
+	 * is released. If the interval for the QH is 1, the item moves to
+	 * periodic_sched_ready because it must be rescheduled for the next
+	 * frame. Otherwise, the item moves to periodic_sched_inactive.
+	 */
+	struct list_head periodic_sched_queued;
+
+	/**
+	 * Total bandwidth claimed so far for periodic transfers. This value
+	 * is in microseconds per (micro)frame. The assumption is that all
+	 * periodic transfers may occur in the same (micro)frame.
+	 */
+	uint16_t periodic_usecs;
+
+	/**
+	 * Frame number read from the core at SOF. The value ranges from 0 to
+	 * DWC_HFNUM_MAX_FRNUM.
+	 */
+	uint16_t frame_number;
+
+	/**
+	 * Free host channels in the controller. This is a list of
+	 * struct dwc_hc items.
+	 */
+	struct list_head free_hc_list;
+
+	/**
+	 * Number of host channels assigned to periodic transfers. Currently
+	 * assuming that there is a dedicated host channel for each periodic
+	 * transaction and at least one host channel available for
+	 * non-periodic transactions.
+	 */
+	int periodic_channels;
+
+	/**
+	 * Number of host channels assigned to non-periodic transfers.
+	 */
+	int non_periodic_channels;
+
+	/**
+	 * Array of pointers to the host channel descriptors. Allows accessing
+	 * a host channel descriptor given the host channel number. This is
+	 * useful in interrupt handlers.
+	 */
+	struct dwc_hc *hc_ptr_array[MAX_EPS_CHANNELS];
+
+	/**
+	 * Buffer to use for any data received during the status phase of a
+	 * control transfer. Normally no data is transferred during the status
+	 * phase. This buffer is used as a bit bucket.
+	 */
+	uint8_t *status_buf;
+
+	/**
+	 * DMA address for status_buf.
+	 */
+	dma_addr_t status_buf_dma;
+#define DWC_OTG_HCD_STATUS_BUF_SIZE 64
+
+	/**
+	 * Structure to allow starting the HCD in a non-interrupt context
+	 * during an OTG role change.
+	 */
+	struct work_struct start_work;
+
+	/**
+	 * Connection timer. An OTG host must display a message if the device
+	 * does not connect. Started when the VBus power is turned on via
+	 * sysfs attribute "buspower".
+	 */
+	struct timer_list conn_timer;
+
+	/* Tasket to do a reset */
+	struct tasklet_struct *reset_tasklet;
+
+	struct hrtimer poll_rate_limit;
+
+	spinlock_t global_lock;
+
+#ifdef DEBUG
+	uint32_t frrem_samples;
+	uint64_t frrem_accum;
+
+	uint32_t hfnum_7_samples_a;
+	uint64_t hfnum_7_frrem_accum_a;
+	uint32_t hfnum_0_samples_a;
+	uint64_t hfnum_0_frrem_accum_a;
+	uint32_t hfnum_other_samples_a;
+	uint64_t hfnum_other_frrem_accum_a;
+
+	uint32_t hfnum_7_samples_b;
+	uint64_t hfnum_7_frrem_accum_b;
+	uint32_t hfnum_0_samples_b;
+	uint64_t hfnum_0_frrem_accum_b;
+	uint32_t hfnum_other_samples_b;
+	uint64_t hfnum_other_frrem_accum_b;
+#endif
+
+};
+
+/** Gets the dwc_otg_hcd from a struct usb_hcd */
+static inline struct dwc_otg_hcd *hcd_to_dwc_otg_hcd(struct usb_hcd *hcd)
+{
+	return (struct dwc_otg_hcd *)(hcd->hcd_priv);
+}
+
+/** Gets the struct usb_hcd that contains a struct dwc_otg_hcd. */
+static inline struct usb_hcd *dwc_otg_hcd_to_hcd(struct dwc_otg_hcd
+						 *dwc_otg_hcd)
+{
+	return container_of((void *)dwc_otg_hcd, struct usb_hcd, hcd_priv);
+}
+
+/** @name HCD Create/Destroy Functions */
+/** @{ */
+extern int __init dwc_otg_hcd_init(struct device *_dev);
+extern void dwc_otg_hcd_remove(struct device *_dev);
+/** @} */
+
+/** @name Linux HC Driver API Functions */
+
+extern int dwc_otg_hcd_start(struct usb_hcd *hcd);
+extern void dwc_otg_hcd_stop(struct usb_hcd *hcd);
+extern int dwc_otg_hcd_get_frame_number(struct usb_hcd *hcd);
+extern void dwc_otg_hcd_free(struct usb_hcd *hcd);
+extern int dwc_otg_hcd_urb_enqueue(struct usb_hcd *hcd,
+				   struct urb *urb, unsigned mem_flags);
+extern int dwc_otg_hcd_urb_dequeue(struct usb_hcd *hcd,
+				   struct urb *urb, int status);
+extern void dwc_otg_hcd_endpoint_disable(struct usb_hcd *hcd,
+					 struct usb_host_endpoint *ep);
+extern irqreturn_t dwc_otg_hcd_irq(struct usb_hcd *hcd);
+extern int dwc_otg_hcd_hub_status_data(struct usb_hcd *hcd, char *buf);
+extern int dwc_otg_hcd_hub_control(struct usb_hcd *hcd,
+				   u16 typeReq,
+				   u16 wValue,
+				   u16 wIndex, char *buf, u16 wLength);
+
+
+/** @name Transaction Execution Functions */
+extern enum dwc_otg_transaction_type dwc_otg_hcd_select_transactions(struct
+								  dwc_otg_hcd
+								  *hcd);
+extern void dwc_otg_hcd_queue_transactions(struct dwc_otg_hcd *hcd,
+					   enum dwc_otg_transaction_type tr_type);
+extern void dwc_otg_hcd_complete_urb(struct dwc_otg_hcd *hcd, struct urb *urb,
+				     int status);
+
+/** @name Interrupt Handler Functions */
+extern int32_t dwc_otg_hcd_handle_intr(struct dwc_otg_hcd *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_sof_intr(struct dwc_otg_hcd *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_rx_status_q_level_intr(struct dwc_otg_hcd
+							 *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_np_tx_fifo_empty_intr(struct dwc_otg_hcd
+							*dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_perio_tx_fifo_empty_intr(struct dwc_otg_hcd
+							   *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_incomplete_periodic_intr(struct dwc_otg_hcd
+							   *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_port_intr(struct dwc_otg_hcd *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_conn_id_status_change_intr(struct dwc_otg_hcd
+							     *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_disconnect_intr(struct dwc_otg_hcd
+						  *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_hc_intr(struct dwc_otg_hcd *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_hc_n_intr(struct dwc_otg_hcd *dwc_otg_hcd,
+					    uint32_t num);
+extern int32_t dwc_otg_hcd_handle_session_req_intr(struct dwc_otg_hcd
+						   *dwc_otg_hcd);
+extern int32_t dwc_otg_hcd_handle_wakeup_detected_intr(struct dwc_otg_hcd
+						       *dwc_otg_hcd);
+
+/** @name Schedule Queue Functions */
+
+/* Implemented in dwc_otg_hcd_queue.c */
+extern struct dwc_otg_qh *dwc_otg_hcd_qh_create(struct dwc_otg_hcd *hcd,
+					   struct urb *urb);
+extern void dwc_otg_hcd_qh_init(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh,
+				struct urb *urb);
+extern void dwc_otg_hcd_qh_free(struct dwc_otg_qh *qh);
+extern int dwc_otg_hcd_qh_add(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh);
+extern void dwc_otg_hcd_qh_remove(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh);
+extern void dwc_otg_hcd_qh_deactivate(struct dwc_otg_hcd *hcd,
+				      struct dwc_otg_qh *qh, int sched_csplit);
+
+/** Remove and free a QH */
+static inline void dwc_otg_hcd_qh_remove_and_free(struct dwc_otg_hcd *hcd,
+						  struct dwc_otg_qh *qh)
+{
+	dwc_otg_hcd_qh_remove(hcd, qh);
+	dwc_otg_hcd_qh_free(qh);
+}
+
+/** Allocates memory for a QH structure.
+ * Returns Returns the memory allocate or NULL on error. */
+static inline struct dwc_otg_qh *dwc_otg_hcd_qh_alloc(void)
+{
+	return kmalloc(sizeof(struct dwc_otg_qh), GFP_ATOMIC);
+}
+
+extern struct dwc_otg_qtd *dwc_otg_hcd_qtd_create(struct urb *urb);
+extern void dwc_otg_hcd_qtd_init(struct dwc_otg_qtd *qtd, struct urb *urb);
+extern int dwc_otg_hcd_qtd_add(struct dwc_otg_qtd *qtd,
+			       struct dwc_otg_hcd *dwc_otg_hcd);
+
+/** Allocates memory for a QTD structure.
+ * Returns Returns the memory allocate or NULL on error. */
+static inline struct dwc_otg_qtd *dwc_otg_hcd_qtd_alloc(void)
+{
+	return kmalloc(sizeof(struct dwc_otg_qtd), GFP_ATOMIC);
+}
+
+/**
+ * Frees the memory for a QTD structure.  QTD should already be removed from
+ * list.
+ * @qtd: QTD to free.
+ */
+static inline void dwc_otg_hcd_qtd_free(struct dwc_otg_qtd *qtd)
+{
+	kfree(qtd);
+}
+
+/**
+ * Removes a QTD from list.
+ * @qtd: QTD to remove from list.
+ */
+static inline void dwc_otg_hcd_qtd_remove(struct dwc_otg_qtd *qtd)
+{
+	list_del(&qtd->qtd_list_entry);
+}
+
+/** Remove and free a QTD */
+static inline void dwc_otg_hcd_qtd_remove_and_free(struct dwc_otg_qtd *qtd)
+{
+	dwc_otg_hcd_qtd_remove(qtd);
+	dwc_otg_hcd_qtd_free(qtd);
+}
+
+/** @name Internal Functions */
+struct dwc_otg_qh *dwc_urb_to_qh(struct urb *urb);
+void dwc_otg_hcd_dump_frrem(struct dwc_otg_hcd *hcd);
+void dwc_otg_hcd_dump_state(struct dwc_otg_hcd *hcd);
+
+/** Gets the usb_host_endpoint associated with an URB. */
+static inline struct usb_host_endpoint *dwc_urb_to_endpoint(struct urb *urb)
+{
+	struct usb_device *dev = urb->dev;
+	int ep_num = usb_pipeendpoint(urb->pipe);
+
+	if (usb_pipein(urb->pipe))
+		return dev->ep_in[ep_num];
+	else
+		return dev->ep_out[ep_num];
+}
+
+/*
+ * Gets the endpoint number from a bEndpointAddress argument. The endpoint is
+ * qualified with its direction (possible 32 endpoints per device).
+ */
+#define dwc_ep_addr_to_endpoint(_bEndpointAddress_)	\
+	((_bEndpointAddress_ & USB_ENDPOINT_NUMBER_MASK) |		\
+		((_bEndpointAddress_ & USB_DIR_IN) != 0) << 4)
+
+/** Gets the QH that contains the list_head */
+#define dwc_list_to_qh(_list_head_ptr_)					\
+	(container_of(_list_head_ptr_, struct dwc_otg_qh, qh_list_entry))
+
+/** Gets the QTD that contains the list_head */
+#define dwc_list_to_qtd(_list_head_ptr_)				\
+	(container_of(_list_head_ptr_, struct dwc_otg_qtd, qtd_list_entry))
+
+/** Check if QH is non-periodic  */
+#define dwc_qh_is_non_per(_qh_ptr_)					\
+	((_qh_ptr_->ep_type == USB_ENDPOINT_XFER_BULK) ||		\
+		(_qh_ptr_->ep_type == USB_ENDPOINT_XFER_CONTROL))
+
+/** High bandwidth multiplier as encoded in highspeed endpoint descriptors */
+#define dwc_hb_mult(wMaxPacketSize) (1 + (((wMaxPacketSize) >> 11) & 0x03))
+
+/** Packet size for any kind of endpoint descriptor */
+#define dwc_max_packet(wMaxPacketSize) ((wMaxPacketSize) & 0x07ff)
+
+/**
+ * Returns true if frame1 is less than or equal to frame2. The comparison is
+ * done modulo DWC_HFNUM_MAX_FRNUM. This accounts for the rollover of the
+ * frame number when the max frame number is reached.
+ */
+static inline int dwc_frame_num_le(uint16_t frame1, uint16_t frame2)
+{
+	return ((frame2 - frame1) & DWC_HFNUM_MAX_FRNUM) <=
+	    (DWC_HFNUM_MAX_FRNUM >> 1);
+}
+
+/**
+ * Returns true if frame1 is greater than frame2. The comparison is done
+ * modulo DWC_HFNUM_MAX_FRNUM. This accounts for the rollover of the frame
+ * number when the max frame number is reached.
+ */
+static inline int dwc_frame_num_gt(uint16_t frame1, uint16_t frame2)
+{
+	return (frame1 != frame2) &&
+		(((frame1 - frame2) & DWC_HFNUM_MAX_FRNUM) <
+			(DWC_HFNUM_MAX_FRNUM >> 1));
+}
+
+/**
+ * Increments frame by the amount specified by inc. The addition is done
+ * modulo DWC_HFNUM_MAX_FRNUM. Returns the incremented value.
+ */
+static inline uint16_t dwc_frame_num_inc(uint16_t frame, uint16_t inc)
+{
+	return (frame + inc) & DWC_HFNUM_MAX_FRNUM;
+}
+
+static inline uint16_t dwc_full_frame_num(uint16_t frame)
+{
+	return (frame & DWC_HFNUM_MAX_FRNUM) >> 3;
+}
+
+static inline uint16_t dwc_micro_frame_num(uint16_t frame)
+{
+	return frame & 0x7;
+}
+
+#ifdef DEBUG
+/**
+ * Macro to sample the remaining PHY clocks left in the current frame. This
+ * may be used during debugging to determine the average time it takes to
+ * execute sections of code. There are two possible sample points, "a" and
+ * "b", so the letter argument must be one of these values.
+ *
+ * To dump the average sample times, read the "hcd_frrem" sysfs attribute. For
+ * example, "cat /sys/devices/lm0/hcd_frrem".
+ */
+#define dwc_sample_frrem(_hcd, _qh, _letter) \
+{ \
+	union hfnum_data hfnum; \
+	struct dwc_otg_qtd *qtd; \
+	qtd = list_entry(_qh->qtd_list.next, struct dwc_otg_qtd, qtd_list_entry); \
+	if (usb_pipeint(qtd->urb->pipe) && qh->start_split_frame != 0 && !qtd->complete_split) { \
+		hfnum.d32 = dwc_read_reg32(&_hcd->core_if->host_if->host_global_regs->hfnum); \
+		switch (hfnum.b.frnum & 0x7) { \
+		case 7: \
+			_hcd->hfnum_7_samples_##_letter++; \
+			_hcd->hfnum_7_frrem_accum_##_letter += hfnum.b.frrem; \
+			break; \
+		case 0: \
+			_hcd->hfnum_0_samples_##_letter++; \
+			_hcd->hfnum_0_frrem_accum_##_letter += hfnum.b.frrem; \
+			break; \
+		default: \
+			_hcd->hfnum_other_samples_##_letter++; \
+			_hcd->hfnum_other_frrem_accum_##_letter += \
+				hfnum.b.frrem;			   \
+			break; \
+		} \
+	} \
+}
+#else
+#define dwc_sample_frrem(hcd, qh, letter)
+#endif
+#endif
+#endif /* DWC_DEVICE_ONLY */
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
new file mode 100644
index 0000000..2c4266f
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
@@ -0,0 +1,1890 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+#ifndef DWC_DEVICE_ONLY
+
+#include "dwc_otg_driver.h"
+#include "dwc_otg_hcd.h"
+#include "dwc_otg_regs.h"
+
+/*
+ * This file contains the implementation of the HCD Interrupt handlers.
+ */
+
+/* This function handles interrupts for the HCD. */
+int32_t dwc_otg_hcd_handle_intr(struct dwc_otg_hcd *dwc_otg_hcd)
+{
+	int retval = 0;
+
+	struct dwc_otg_core_if *core_if = dwc_otg_hcd->core_if;
+	union gintsts_data gintsts;
+#ifdef DEBUG
+	struct dwc_otg_core_global_regs *global_regs =
+		core_if->core_global_regs;
+#endif
+
+	/* Check if HOST Mode */
+	if (dwc_otg_is_host_mode(core_if)) {
+		gintsts.d32 = dwc_otg_read_core_intr(core_if);
+		if (!gintsts.d32)
+			return 0;
+#ifdef DEBUG
+		/* Don't print debug message in the interrupt handler on SOF */
+#  ifndef DEBUG_SOF
+		if (gintsts.d32 != DWC_SOF_INTR_MASK)
+#  endif
+			DWC_DEBUGPL(DBG_HCD, "\n");
+#endif
+
+#ifdef DEBUG
+#  ifndef DEBUG_SOF
+		if (gintsts.d32 != DWC_SOF_INTR_MASK)
+#  endif
+			DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD Interrupt Detected "
+				    "gintsts&gintmsk=0x%08x\n",
+				    gintsts.d32);
+#endif
+
+		if (gintsts.b.sofintr)
+			retval |= dwc_otg_hcd_handle_sof_intr(dwc_otg_hcd);
+
+		if (gintsts.b.rxstsqlvl)
+			retval |=
+				dwc_otg_hcd_handle_rx_status_q_level_intr(dwc_otg_hcd);
+
+		if (gintsts.b.nptxfempty)
+			retval |=
+				dwc_otg_hcd_handle_np_tx_fifo_empty_intr(dwc_otg_hcd);
+
+		if (gintsts.b.i2cintr)
+			;/** @todo Implement i2cintr handler. */
+
+		if (gintsts.b.portintr)
+			retval |= dwc_otg_hcd_handle_port_intr(dwc_otg_hcd);
+
+		if (gintsts.b.hcintr)
+			retval |= dwc_otg_hcd_handle_hc_intr(dwc_otg_hcd);
+
+		if (gintsts.b.ptxfempty) {
+			retval |=
+			    dwc_otg_hcd_handle_perio_tx_fifo_empty_intr
+			    (dwc_otg_hcd);
+		}
+#ifdef DEBUG
+#  ifndef DEBUG_SOF
+		if (gintsts.d32 != DWC_SOF_INTR_MASK)
+#  endif
+		{
+			DWC_DEBUGPL(DBG_HCD,
+				    "DWC OTG HCD Finished Servicing Interrupts\n");
+			DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD gintsts=0x%08x\n",
+				    dwc_read_reg32(&global_regs->gintsts));
+			DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD gintmsk=0x%08x\n",
+				    dwc_read_reg32(&global_regs->gintmsk));
+		}
+#endif
+
+#ifdef DEBUG
+#  ifndef DEBUG_SOF
+		if (gintsts.d32 != DWC_SOF_INTR_MASK)
+#  endif
+			DWC_DEBUGPL(DBG_HCD, "\n");
+#endif
+
+	}
+
+	return retval;
+}
+
+#ifdef DWC_TRACK_MISSED_SOFS
+#warning Compiling code to track missed SOFs
+#define FRAME_NUM_ARRAY_SIZE 1000
+/**
+ * This function is for debug only.
+ */
+static inline void track_missed_sofs(uint16_t _curr_frame_number)
+{
+	static uint16_t frame_num_array[FRAME_NUM_ARRAY_SIZE];
+	static uint16_t last_frame_num_array[FRAME_NUM_ARRAY_SIZE];
+	static int frame_num_idx;
+	static uint16_t last_frame_num = DWC_HFNUM_MAX_FRNUM;
+	static int dumped_frame_num_array;
+
+	if (frame_num_idx < FRAME_NUM_ARRAY_SIZE) {
+		if ((((last_frame_num + 1) & DWC_HFNUM_MAX_FRNUM) !=
+		     _curr_frame_number)) {
+			frame_num_array[frame_num_idx] = _curr_frame_number;
+			last_frame_num_array[frame_num_idx++] = last_frame_num;
+		}
+	} else if (!dumped_frame_num_array) {
+		int i;
+		printk(KERN_EMERG USB_DWC "Frame     Last Frame\n");
+		printk(KERN_EMERG USB_DWC "-----     ----------\n");
+		for (i = 0; i < FRAME_NUM_ARRAY_SIZE; i++) {
+			printk(KERN_EMERG USB_DWC "0x%04x    0x%04x\n",
+			       frame_num_array[i], last_frame_num_array[i]);
+		}
+		dumped_frame_num_array = 1;
+	}
+	last_frame_num = _curr_frame_number;
+}
+#endif
+
+/**
+ * Handles the start-of-frame interrupt in host mode. Non-periodic
+ * transactions may be queued to the DWC_otg controller for the current
+ * (micro)frame. Periodic transactions may be queued to the controller for the
+ * next (micro)frame.
+ */
+int32_t dwc_otg_hcd_handle_sof_intr(struct dwc_otg_hcd *hcd)
+{
+	union hfnum_data hfnum;
+	struct list_head *qh_entry;
+	struct dwc_otg_qh *qh;
+	enum dwc_otg_transaction_type tr_type;
+	union gintsts_data gintsts = {.d32 = 0 };
+
+	hfnum.d32 =
+	    dwc_read_reg32(&hcd->core_if->host_if->host_global_regs->hfnum);
+
+#ifdef DEBUG_SOF
+	DWC_DEBUGPL(DBG_HCD, "--Start of Frame Interrupt--\n");
+#endif
+
+	hcd->frame_number = hfnum.b.frnum;
+
+#ifdef DEBUG
+	hcd->frrem_accum += hfnum.b.frrem;
+	hcd->frrem_samples++;
+#endif
+
+#ifdef DWC_TRACK_MISSED_SOFS
+	track_missed_sofs(hcd->frame_number);
+#endif
+
+	/* Determine whether any periodic QHs should be executed. */
+	qh_entry = hcd->periodic_sched_inactive.next;
+	while (qh_entry != &hcd->periodic_sched_inactive) {
+		qh = list_entry(qh_entry, struct dwc_otg_qh, qh_list_entry);
+		qh_entry = qh_entry->next;
+		if (dwc_frame_num_le(qh->sched_frame, hcd->frame_number)) {
+			/*
+			 * Move QH to the ready list to be executed next
+			 * (micro)frame.
+			 */
+			list_move(&qh->qh_list_entry,
+				  &hcd->periodic_sched_ready);
+		}
+	}
+
+	tr_type = dwc_otg_hcd_select_transactions(hcd);
+	if (tr_type != DWC_OTG_TRANSACTION_NONE) {
+		dwc_otg_hcd_queue_transactions(hcd, tr_type);
+	} else if (list_empty(&hcd->periodic_sched_inactive) &&
+		   list_empty(&hcd->periodic_sched_ready) &&
+		   list_empty(&hcd->periodic_sched_assigned) &&
+		   list_empty(&hcd->periodic_sched_queued)) {
+		/*
+		 * We don't have USB data to send. Unfortunately the
+		 * Synopsis block continues to generate interrupts at
+		 * about 8k/sec. In order not waste time on these
+		 * useless interrupts, we're going to disable the SOF
+		 * interrupt. It will be re-enabled when a new packet
+		 * is enqueued in dwc_otg_hcd_urb_enqueue()
+		 */
+		dwc_modify_reg32(&hcd->core_if->core_global_regs->gintmsk,
+				 DWC_SOF_INTR_MASK, 0);
+	}
+
+	/* Clear interrupt */
+	gintsts.b.sofintr = 1;
+	dwc_write_reg32(&hcd->core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/* Handles the Rx Status Queue Level Interrupt, which indicates that
+ * there is at least one packet in the Rx FIFO.  The packets are moved
+ * from the FIFO to memory if the DWC_otg controller is operating in
+ * Slave mode. */
+int32_t
+dwc_otg_hcd_handle_rx_status_q_level_intr(struct dwc_otg_hcd *dwc_otg_hcd)
+{
+	union host_grxsts_data grxsts;
+	struct dwc_hc *hc = NULL;
+
+	DWC_DEBUGPL(DBG_HCD, "--RxStsQ Level Interrupt--\n");
+
+	grxsts.d32 =
+	    dwc_read_reg32(&dwc_otg_hcd->core_if->core_global_regs->grxstsp);
+
+	hc = dwc_otg_hcd->hc_ptr_array[grxsts.b.chnum];
+
+	/* Packet Status */
+	DWC_DEBUGPL(DBG_HCDV, "    Ch num = %d\n", grxsts.b.chnum);
+	DWC_DEBUGPL(DBG_HCDV, "    Count = %d\n", grxsts.b.bcnt);
+	DWC_DEBUGPL(DBG_HCDV, "    DPID = %d, hc.dpid = %d\n", grxsts.b.dpid,
+		    hc->data_pid_start);
+	DWC_DEBUGPL(DBG_HCDV, "    PStatus = %d\n", grxsts.b.pktsts);
+
+	switch (grxsts.b.pktsts) {
+	case DWC_GRXSTS_PKTSTS_IN:
+		/* Read the data into the host buffer. */
+		if (grxsts.b.bcnt > 0) {
+			dwc_otg_read_packet(dwc_otg_hcd->core_if,
+					    hc->xfer_buff, grxsts.b.bcnt);
+
+			/* Update the HC fields for the next packet received. */
+			hc->xfer_count += grxsts.b.bcnt;
+			hc->xfer_buff += grxsts.b.bcnt;
+		}
+
+	case DWC_GRXSTS_PKTSTS_IN_XFER_COMP:
+	case DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR:
+	case DWC_GRXSTS_PKTSTS_CH_HALTED:
+		/* Handled in interrupt, just ignore data */
+		break;
+	default:
+		DWC_ERROR("RX_STS_Q Interrupt: Unknown status %d\n",
+			  grxsts.b.pktsts);
+		break;
+	}
+
+	return 1;
+}
+
+/* This interrupt occurs when the non-periodic Tx FIFO is
+ * half-empty. More data packets may be written to the FIFO for OUT
+ * transfers. More requests may be written to the non-periodic request
+ * queue for IN transfers. This interrupt is enabled only in Slave
+ * mode. */
+int32_t dwc_otg_hcd_handle_np_tx_fifo_empty_intr(struct dwc_otg_hcd *
+						 dwc_otg_hcd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Non-Periodic TxFIFO Empty Interrupt--\n");
+	dwc_otg_hcd_queue_transactions(dwc_otg_hcd,
+				       DWC_OTG_TRANSACTION_NON_PERIODIC);
+	return 1;
+}
+
+/* This interrupt occurs when the periodic Tx FIFO is half-empty. More
+ * data packets may be written to the FIFO for OUT transfers. More
+ * requests may be written to the periodic request queue for IN
+ * transfers. This interrupt is enabled only in Slave mode. */
+int32_t dwc_otg_hcd_handle_perio_tx_fifo_empty_intr(struct dwc_otg_hcd *
+						    dwc_otg_hcd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Periodic TxFIFO Empty Interrupt--\n");
+	dwc_otg_hcd_queue_transactions(dwc_otg_hcd,
+				       DWC_OTG_TRANSACTION_PERIODIC);
+	return 1;
+}
+
+/* There are multiple conditions that can cause a port interrupt. This
+ * function determines which interrupt conditions have occurred and
+ * handles them appropriately. */
+int32_t dwc_otg_hcd_handle_port_intr(struct dwc_otg_hcd *dwc_otg_hcd)
+{
+	int retval = 0;
+	union hprt0_data hprt0;
+	union hprt0_data hprt0_modify;
+
+	hprt0.d32 = dwc_read_reg32(dwc_otg_hcd->core_if->host_if->hprt0);
+	hprt0_modify.d32 =
+	    dwc_read_reg32(dwc_otg_hcd->core_if->host_if->hprt0);
+
+	/* Clear appropriate bits in HPRT0 to clear the interrupt bit in
+	 * GINTSTS */
+
+	hprt0_modify.b.prtena = 0;
+	hprt0_modify.b.prtconndet = 0;
+	hprt0_modify.b.prtenchng = 0;
+	hprt0_modify.b.prtovrcurrchng = 0;
+
+	/* Port Connect Detected
+	 * Set flag and clear if detected */
+	if (hprt0.b.prtconndet) {
+		DWC_DEBUGPL(DBG_HCD, "--Port Interrupt HPRT0=0x%08x "
+			    "Port Connect Detected--\n", hprt0.d32);
+		dwc_otg_hcd->flags.b.port_connect_status_change = 1;
+		dwc_otg_hcd->flags.b.port_connect_status = 1;
+		hprt0_modify.b.prtconndet = 1;
+
+		/* B-Device has connected, Delete the connection timer.  */
+		del_timer(&dwc_otg_hcd->conn_timer);
+
+		/* The Hub driver asserts a reset when it sees port connect
+		 * status change flag */
+		retval |= 1;
+	}
+
+	/* Port Enable Changed
+	 * Clear if detected - Set internal flag if disabled */
+	if (hprt0.b.prtenchng) {
+		DWC_DEBUGPL(DBG_HCD, "  --Port Interrupt HPRT0=0x%08x "
+			    "Port Enable Changed--\n", hprt0.d32);
+		hprt0_modify.b.prtenchng = 1;
+		if (hprt0.b.prtena == 1) {
+			int do_reset = 0;
+			struct dwc_otg_core_params *params =
+			    dwc_otg_hcd->core_if->core_params;
+			struct dwc_otg_core_global_regs *global_regs =
+			    dwc_otg_hcd->core_if->core_global_regs;
+			struct dwc_otg_host_if *host_if =
+			    dwc_otg_hcd->core_if->host_if;
+
+			/* Check if we need to adjust the PHY clock speed for
+			 * low power and adjust it */
+			if (params->host_support_fs_ls_low_power) {
+				union gusbcfg_data usbcfg;
+
+				usbcfg.d32 =
+				    dwc_read_reg32(&global_regs->gusbcfg);
+
+				if ((hprt0.b.prtspd == DWC_HPRT0_PRTSPD_LOW_SPEED)
+				    || (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_FULL_SPEED)) {
+					/*
+					 * Low power
+					 */
+					union hcfg_data hcfg;
+					if (usbcfg.b.phylpwrclksel == 0) {
+						/* Set PHY low power clock select for FS/LS devices */
+						usbcfg.b.phylpwrclksel = 1;
+						dwc_write_reg32(&global_regs->gusbcfg,
+								usbcfg.d32);
+						do_reset = 1;
+					}
+
+					hcfg.d32 =
+					    dwc_read_reg32(&host_if->host_global_regs->hcfg);
+
+					if ((hprt0.b.prtspd ==
+					     DWC_HPRT0_PRTSPD_LOW_SPEED)
+					    && (params->
+						host_ls_low_power_phy_clk ==
+						DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ)) {
+						/* 6 MHZ */
+						DWC_DEBUGPL(DBG_CIL,
+							    "FS_PHY programming HCFG to 6 MHz (Low Power)\n");
+						if (hcfg.b.fslspclksel !=
+						    DWC_HCFG_6_MHZ) {
+							hcfg.b.fslspclksel =
+							    DWC_HCFG_6_MHZ;
+							dwc_write_reg32(&host_if->host_global_regs->hcfg,
+									hcfg.d32);
+							do_reset = 1;
+						}
+					} else {
+						/* 48 MHZ */
+						DWC_DEBUGPL(DBG_CIL,
+							    "FS_PHY programming HCFG to 48 MHz ()\n");
+						if (hcfg.b.fslspclksel !=
+						    DWC_HCFG_48_MHZ) {
+							hcfg.b.fslspclksel = DWC_HCFG_48_MHZ;
+							dwc_write_reg32(&host_if->host_global_regs->hcfg,
+									hcfg.d32);
+							do_reset = 1;
+						}
+					}
+				} else {
+					/*
+					 * Not low power
+					 */
+					if (usbcfg.b.phylpwrclksel == 1) {
+						usbcfg.b.phylpwrclksel = 0;
+						dwc_write_reg32(&global_regs->gusbcfg,
+								usbcfg.d32);
+						do_reset = 1;
+					}
+				}
+				if (do_reset)
+					tasklet_schedule(dwc_otg_hcd->reset_tasklet);
+			}
+			if (!do_reset)
+				/*
+				 * Port has been enabled set the reset
+				 * change flag
+				 */
+				dwc_otg_hcd->flags.b.port_reset_change = 1;
+		} else {
+			dwc_otg_hcd->flags.b.port_enable_change = 1;
+		}
+		retval |= 1;
+	}
+
+	/** Overcurrent Change Interrupt */
+	if (hprt0.b.prtovrcurrchng) {
+		DWC_DEBUGPL(DBG_HCD, "  --Port Interrupt HPRT0=0x%08x "
+			    "Port Overcurrent Changed--\n", hprt0.d32);
+		dwc_otg_hcd->flags.b.port_over_current_change = 1;
+		hprt0_modify.b.prtovrcurrchng = 1;
+		retval |= 1;
+	}
+
+	/* Clear Port Interrupts */
+	dwc_write_reg32(dwc_otg_hcd->core_if->host_if->hprt0,
+			hprt0_modify.d32);
+
+	return retval;
+}
+
+/** This interrupt indicates that one or more host channels has a pending
+ * interrupt. There are multiple conditions that can cause each host channel
+ * interrupt. This function determines which conditions have occurred for each
+ * host channel interrupt and handles them appropriately. */
+int32_t dwc_otg_hcd_handle_hc_intr(struct dwc_otg_hcd *dwc_otg_hcd)
+{
+	int i;
+	int retval = 0;
+	union haint_data haint;
+
+	/* Clear appropriate bits in HCINTn to clear the interrupt bit in
+	 * GINTSTS */
+
+	haint.d32 = dwc_otg_read_host_all_channels_intr(dwc_otg_hcd->core_if);
+
+	for (i = 0; i < dwc_otg_hcd->core_if->core_params->host_channels; i++) {
+		if (haint.b2.chint & (1 << i))
+			retval |= dwc_otg_hcd_handle_hc_n_intr(dwc_otg_hcd, i);
+	}
+
+	return retval;
+}
+
+/* Macro used to clear one channel interrupt */
+#define clear_hc_int(_hc_regs_, _intr_) \
+do { \
+	union hcint_data hcint_clear = {.d32 = 0}; \
+	hcint_clear.b._intr_ = 1; \
+	dwc_write_reg32(&((_hc_regs_)->hcint), hcint_clear.d32); \
+} while (0)
+
+/*
+ * Macro used to disable one channel interrupt. Channel interrupts are
+ * disabled when the channel is halted or released by the interrupt handler.
+ * There is no need to handle further interrupts of that type until the
+ * channel is re-assigned. In fact, subsequent handling may cause crashes
+ * because the channel structures are cleaned up when the channel is released.
+ */
+#define disable_hc_int(_hc_regs_, _intr_)				\
+	do {								\
+		union hcintmsk_data hcintmsk = {.d32 = 0};		\
+		hcintmsk.b._intr_ = 1;					\
+		dwc_modify_reg32(&((_hc_regs_)->hcintmsk), hcintmsk.d32, 0); \
+	} while (0)
+
+/**
+ * Gets the actual length of a transfer after the transfer halts. _halt_status
+ * holds the reason for the halt.
+ *
+ * For IN transfers where _halt_status is DWC_OTG_HC_XFER_COMPLETE,
+ * *_short_read is set to 1 upon return if less than the requested
+ * number of bytes were transferred. Otherwise, *_short_read is set to 0 upon
+ * return. _short_read may also be NULL on entry, in which case it remains
+ * unchanged.
+ */
+static uint32_t get_actual_xfer_length(struct dwc_hc *hc,
+				       struct dwc_otg_hc_regs *hc_regs,
+				       struct dwc_otg_qtd *qtd,
+				       enum dwc_otg_halt_status _halt_status,
+				       int *_short_read)
+{
+	union hctsiz_data hctsiz;
+	uint32_t length;
+
+	if (_short_read != NULL)
+		*_short_read = 0;
+
+	hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+
+	if (_halt_status == DWC_OTG_HC_XFER_COMPLETE) {
+		if (hc->ep_is_in) {
+			length = hc->xfer_len - hctsiz.b.xfersize;
+			if (_short_read != NULL)
+				*_short_read = (hctsiz.b.xfersize != 0);
+		} else if (hc->qh->do_split) {
+			length = qtd->ssplit_out_xfer_count;
+		} else {
+			length = hc->xfer_len;
+		}
+	} else {
+		/*
+		 * Must use the hctsiz.pktcnt field to determine how much data
+		 * has been transferred. This field reflects the number of
+		 * packets that have been transferred via the USB. This is
+		 * always an integral number of packets if the transfer was
+		 * halted before its normal completion. (Can't use the
+		 * hctsiz.xfersize field because that reflects the number of
+		 * bytes transferred via the AHB, not the USB).
+		 */
+		length =
+		    (hc->start_pkt_count - hctsiz.b.pktcnt) * hc->max_packet;
+	}
+
+	return length;
+}
+
+/**
+ * Updates the state of the URB after a Transfer Complete interrupt on the
+ * host channel. Updates the actual_length field of the URB based on the
+ * number of bytes transferred via the host channel. Sets the URB status
+ * if the data transfer is finished.
+ *
+ * Returns 1 if the data transfer specified by the URB is completely finished,
+ * 0 otherwise.
+ */
+static int update_urb_state_xfer_comp(struct dwc_hc *hc,
+				      struct dwc_otg_hc_regs *hc_regs,
+				      struct urb *urb, struct dwc_otg_qtd *qtd)
+{
+	int xfer_done = 0;
+	int short_read = 0;
+
+	urb->actual_length += get_actual_xfer_length(hc, hc_regs, qtd,
+						     DWC_OTG_HC_XFER_COMPLETE,
+						     &short_read);
+
+	if (short_read || (urb->actual_length == urb->transfer_buffer_length)) {
+		xfer_done = 1;
+		if (short_read && (urb->transfer_flags & URB_SHORT_NOT_OK))
+			urb->status = -EREMOTEIO;
+		else
+			urb->status = 0;
+	}
+#ifdef DEBUG
+	{
+		union hctsiz_data hctsiz;
+		hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+		DWC_DEBUGPL(DBG_HCDV, "DWC_otg: %s: %s, channel %d\n",
+			    __func__, (hc->ep_is_in ? "IN" : "OUT"),
+			    hc->hc_num);
+		DWC_DEBUGPL(DBG_HCDV, "  hc->xfer_len %d\n", hc->xfer_len);
+		DWC_DEBUGPL(DBG_HCDV, "  hctsiz.xfersize %d\n",
+			    hctsiz.b.xfersize);
+		DWC_DEBUGPL(DBG_HCDV, "  urb->transfer_buffer_length %d\n",
+			    urb->transfer_buffer_length);
+		DWC_DEBUGPL(DBG_HCDV, "  urb->actual_length %d\n",
+			    urb->actual_length);
+		DWC_DEBUGPL(DBG_HCDV, "  short_read %d, xfer_done %d\n",
+			    short_read, xfer_done);
+	}
+#endif
+
+	return xfer_done;
+}
+
+/*
+ * Save the starting data toggle for the next transfer. The data toggle is
+ * saved in the QH for non-control transfers and it's saved in the QTD for
+ * control transfers.
+ */
+static void save_data_toggle(struct dwc_hc *hc,
+			     struct dwc_otg_hc_regs *hc_regs,
+			     struct dwc_otg_qtd *qtd)
+{
+	union hctsiz_data hctsiz;
+	hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+
+	if (hc->ep_type != DWC_OTG_EP_TYPE_CONTROL) {
+		struct dwc_otg_qh *qh = hc->qh;
+		if (hctsiz.b.pid == DWC_HCTSIZ_DATA0)
+			qh->data_toggle = DWC_OTG_HC_PID_DATA0;
+		else
+			qh->data_toggle = DWC_OTG_HC_PID_DATA1;
+	} else {
+		if (hctsiz.b.pid == DWC_HCTSIZ_DATA0)
+			qtd->data_toggle = DWC_OTG_HC_PID_DATA0;
+		else
+			qtd->data_toggle = DWC_OTG_HC_PID_DATA1;
+	}
+}
+
+/**
+ * Frees the first QTD in the QH's list if free_qtd is 1. For non-periodic
+ * QHs, removes the QH from the active non-periodic schedule. If any QTDs are
+ * still linked to the QH, the QH is added to the end of the inactive
+ * non-periodic schedule. For periodic QHs, removes the QH from the periodic
+ * schedule if no more QTDs are linked to the QH.
+ */
+static void deactivate_qh(struct dwc_otg_hcd *hcd,
+			  struct dwc_otg_qh *qh, int free_qtd)
+{
+	int continue_split = 0;
+	struct dwc_otg_qtd *qtd;
+
+	DWC_DEBUGPL(DBG_HCDV, "  %s(%p,%p,%d)\n", __func__, hcd, qh, free_qtd);
+
+	qtd = list_entry(qh->qtd_list.next, struct dwc_otg_qtd, qtd_list_entry);
+
+	if (qtd->complete_split) {
+		continue_split = 1;
+	} else if ((qtd->isoc_split_pos == DWC_HCSPLIT_XACTPOS_MID) ||
+		   (qtd->isoc_split_pos == DWC_HCSPLIT_XACTPOS_END)) {
+		continue_split = 1;
+	}
+
+	if (free_qtd) {
+		dwc_otg_hcd_qtd_remove_and_free(qtd);
+		continue_split = 0;
+	}
+
+	qh->channel = NULL;
+	qh->qtd_in_process = NULL;
+	dwc_otg_hcd_qh_deactivate(hcd, qh, continue_split);
+}
+
+/**
+ * Updates the state of an Isochronous URB when the transfer is stopped for
+ * any reason. The fields of the current entry in the frame descriptor array
+ * are set based on the transfer state and the input _halt_status. Completes
+ * the Isochronous URB if all the URB frames have been completed.
+ *
+ * Returns DWC_OTG_HC_XFER_COMPLETE if there are more frames remaining to be
+ * transferred in the URB. Otherwise return DWC_OTG_HC_XFER_URB_COMPLETE.
+ */
+static enum dwc_otg_halt_status
+update_isoc_urb_state(struct dwc_otg_hcd *hcd,
+		      struct dwc_hc *hc,
+		      struct dwc_otg_hc_regs *hc_regs,
+		      struct dwc_otg_qtd *qtd,
+		      enum dwc_otg_halt_status halt_status)
+{
+	struct urb *urb = qtd->urb;
+	enum dwc_otg_halt_status ret_val = halt_status;
+	struct usb_iso_packet_descriptor *frame_desc;
+
+	frame_desc = &urb->iso_frame_desc[qtd->isoc_frame_index];
+	switch (halt_status) {
+	case DWC_OTG_HC_XFER_COMPLETE:
+		frame_desc->status = 0;
+		frame_desc->actual_length =
+		    get_actual_xfer_length(hc, hc_regs, qtd,
+					   halt_status, NULL);
+		break;
+	case DWC_OTG_HC_XFER_FRAME_OVERRUN:
+		urb->error_count++;
+		if (hc->ep_is_in)
+			frame_desc->status = -ENOSR;
+		else
+			frame_desc->status = -ECOMM;
+		frame_desc->actual_length = 0;
+		break;
+	case DWC_OTG_HC_XFER_BABBLE_ERR:
+		urb->error_count++;
+		frame_desc->status = -EOVERFLOW;
+		/* Don't need to update actual_length in this case. */
+		break;
+	case DWC_OTG_HC_XFER_XACT_ERR:
+		urb->error_count++;
+		frame_desc->status = -EPROTO;
+		frame_desc->actual_length =
+		    get_actual_xfer_length(hc, hc_regs, qtd,
+					   halt_status, NULL);
+		break;
+	default:
+		DWC_ERROR("%s: Unhandled halt_status (%d)\n", __func__,
+			  halt_status);
+		BUG();
+		break;
+	}
+
+	if (++qtd->isoc_frame_index == urb->number_of_packets) {
+		/*
+		 * urb->status is not used for isoc transfers.
+		 * The individual frame_desc statuses are used instead.
+		 */
+		dwc_otg_hcd_complete_urb(hcd, urb, 0);
+		qtd->urb = NULL;
+		ret_val = DWC_OTG_HC_XFER_URB_COMPLETE;
+	} else {
+		ret_val = DWC_OTG_HC_XFER_COMPLETE;
+	}
+
+	return ret_val;
+}
+
+/**
+ * Releases a host channel for use by other transfers. Attempts to select and
+ * queue more transactions since at least one host channel is available.
+ *
+ * @hcd: The HCD state structure.
+ * @hc: The host channel to release.
+ * @qtd: The QTD associated with the host channel. This QTD may be freed
+ * if the transfer is complete or an error has occurred.
+ * @_halt_status: Reason the channel is being released. This status
+ * determines the actions taken by this function.
+ */
+static void release_channel(struct dwc_otg_hcd *hcd,
+			    struct dwc_hc *hc,
+			    struct dwc_otg_qtd *qtd,
+			    enum dwc_otg_halt_status halt_status)
+{
+	enum dwc_otg_transaction_type tr_type;
+	int free_qtd;
+
+	DWC_DEBUGPL(DBG_HCDV, "  %s: channel %d, halt_status %d\n",
+		    __func__, hc->hc_num, halt_status);
+
+	switch (halt_status) {
+	case DWC_OTG_HC_XFER_URB_COMPLETE:
+		free_qtd = 1;
+		break;
+	case DWC_OTG_HC_XFER_AHB_ERR:
+	case DWC_OTG_HC_XFER_STALL:
+	case DWC_OTG_HC_XFER_BABBLE_ERR:
+		free_qtd = 1;
+		break;
+	case DWC_OTG_HC_XFER_XACT_ERR:
+		if (qtd->error_count >= 3) {
+			DWC_DEBUGPL(DBG_HCDV,
+				    "  Complete URB with transaction error\n");
+			free_qtd = 1;
+			qtd->urb->status = -EPROTO;
+			dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EPROTO);
+			qtd->urb = NULL;
+		} else {
+			free_qtd = 0;
+		}
+		break;
+	case DWC_OTG_HC_XFER_URB_DEQUEUE:
+		/*
+		 * The QTD has already been removed and the QH has been
+		 * deactivated. Don't want to do anything except release the
+		 * host channel and try to queue more transfers.
+		 */
+		goto cleanup;
+	case DWC_OTG_HC_XFER_NO_HALT_STATUS:
+		DWC_ERROR("%s: No halt_status, channel %d\n", __func__,
+			  hc->hc_num);
+		free_qtd = 0;
+		break;
+	default:
+		free_qtd = 0;
+		break;
+	}
+
+	deactivate_qh(hcd, hc->qh, free_qtd);
+
+cleanup:
+	/*
+	 * Release the host channel for use by other transfers. The cleanup
+	 * function clears the channel interrupt enables and conditions, so
+	 * there's no need to clear the Channel Halted interrupt separately.
+	 */
+	dwc_otg_hc_cleanup(hcd->core_if, hc);
+	list_add_tail(&hc->hc_list_entry, &hcd->free_hc_list);
+
+	switch (hc->ep_type) {
+	case DWC_OTG_EP_TYPE_CONTROL:
+	case DWC_OTG_EP_TYPE_BULK:
+		hcd->non_periodic_channels--;
+		break;
+
+	default:
+		/*
+		 * Don't release reservations for periodic channels here.
+		 * That's done when a periodic transfer is descheduled (i.e.
+		 * when the QH is removed from the periodic schedule).
+		 */
+		break;
+	}
+
+	/* Try to queue more transfers now that there's a free channel. */
+	tr_type = dwc_otg_hcd_select_transactions(hcd);
+	if (tr_type != DWC_OTG_TRANSACTION_NONE)
+		dwc_otg_hcd_queue_transactions(hcd, tr_type);
+}
+
+/**
+ * Halts a host channel. If the channel cannot be halted immediately because
+ * the request queue is full, this function ensures that the FIFO empty
+ * interrupt for the appropriate queue is enabled so that the halt request can
+ * be queued when there is space in the request queue.
+ *
+ * This function may also be called in DMA mode. In that case, the channel is
+ * simply released since the core always halts the channel automatically in
+ * DMA mode.
+ */
+static void halt_channel(struct dwc_otg_hcd *hcd,
+			 struct dwc_hc *hc,
+			 struct dwc_otg_qtd *qtd,
+			 enum dwc_otg_halt_status halt_status)
+{
+	if (hcd->core_if->dma_enable) {
+		release_channel(hcd, hc, qtd, halt_status);
+		return;
+	}
+
+	/* Slave mode processing... */
+	dwc_otg_hc_halt(hcd->core_if, hc, halt_status);
+
+	if (hc->halt_on_queue) {
+		union gintmsk_data gintmsk = {.d32 = 0 };
+		struct dwc_otg_core_global_regs *global_regs;
+		global_regs = hcd->core_if->core_global_regs;
+
+		if (hc->ep_type == DWC_OTG_EP_TYPE_CONTROL ||
+		    hc->ep_type == DWC_OTG_EP_TYPE_BULK) {
+			/*
+			 * Make sure the Non-periodic Tx FIFO empty interrupt
+			 * is enabled so that the non-periodic schedule will
+			 * be processed.
+			 */
+			gintmsk.b.nptxfempty = 1;
+			dwc_modify_reg32(&global_regs->gintmsk, 0, gintmsk.d32);
+		} else {
+			/*
+			 * Move the QH from the periodic queued schedule to
+			 * the periodic assigned schedule. This allows the
+			 * halt to be queued when the periodic schedule is
+			 * processed.
+			 */
+			list_move(&hc->qh->qh_list_entry,
+				  &hcd->periodic_sched_assigned);
+
+			/*
+			 * Make sure the Periodic Tx FIFO Empty interrupt is
+			 * enabled so that the periodic schedule will be
+			 * processed.
+			 */
+			gintmsk.b.ptxfempty = 1;
+			dwc_modify_reg32(&global_regs->gintmsk, 0, gintmsk.d32);
+		}
+	}
+}
+
+/**
+ * Performs common cleanup for non-periodic transfers after a Transfer
+ * Complete interrupt. This function should be called after any endpoint type
+ * specific handling is finished to release the host channel.
+ */
+static void complete_non_periodic_xfer(struct dwc_otg_hcd *hcd,
+				       struct dwc_hc *hc,
+				       struct dwc_otg_hc_regs *hc_regs,
+				       struct dwc_otg_qtd *qtd,
+				       enum dwc_otg_halt_status halt_status)
+{
+	union hcint_data hcint;
+
+	qtd->error_count = 0;
+
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+	if (hcint.b.nyet) {
+		/*
+		 * Got a NYET on the last transaction of the transfer. This
+		 * means that the endpoint should be in the PING state at the
+		 * beginning of the next transfer.
+		 */
+		hc->qh->ping_state = 1;
+		clear_hc_int(hc_regs, nyet);
+	}
+
+	/*
+	 * Always halt and release the host channel to make it available for
+	 * more transfers. There may still be more phases for a control
+	 * transfer or more data packets for a bulk transfer at this point,
+	 * but the host channel is still halted. A channel will be reassigned
+	 * to the transfer when the non-periodic schedule is processed after
+	 * the channel is released. This allows transactions to be queued
+	 * properly via dwc_otg_hcd_queue_transactions, which also enables the
+	 * Tx FIFO Empty interrupt if necessary.
+	 */
+	if (hc->ep_is_in) {
+		/*
+		 * IN transfers in Slave mode require an explicit disable to
+		 * halt the channel. (In DMA mode, this call simply releases
+		 * the channel.)
+		 */
+		halt_channel(hcd, hc, qtd, halt_status);
+	} else {
+		/*
+		 * The channel is automatically disabled by the core for OUT
+		 * transfers in Slave mode.
+		 */
+		release_channel(hcd, hc, qtd, halt_status);
+	}
+}
+
+/**
+ * Performs common cleanup for periodic transfers after a Transfer Complete
+ * interrupt. This function should be called after any endpoint type specific
+ * handling is finished to release the host channel.
+ */
+static void complete_periodic_xfer(struct dwc_otg_hcd *hcd,
+				   struct dwc_hc *hc,
+				   struct dwc_otg_hc_regs *hc_regs,
+				   struct dwc_otg_qtd *qtd,
+				   enum dwc_otg_halt_status halt_status)
+{
+	union hctsiz_data hctsiz;
+	qtd->error_count = 0;
+
+	hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+	if (!hc->ep_is_in || hctsiz.b.pktcnt == 0) {
+		/* Core halts channel in these cases. */
+		release_channel(hcd, hc, qtd, halt_status);
+	} else {
+		/* Flush any outstanding requests from the Tx queue. */
+		halt_channel(hcd, hc, qtd, halt_status);
+	}
+}
+
+/**
+ * Handles a host channel Transfer Complete interrupt. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_xfercomp_intr(struct dwc_otg_hcd *hcd,
+				       struct dwc_hc *hc,
+				       struct dwc_otg_hc_regs *hc_regs,
+				       struct dwc_otg_qtd *qtd)
+{
+	int urb_xfer_done;
+	enum dwc_otg_halt_status halt_status = DWC_OTG_HC_XFER_COMPLETE;
+	struct urb *urb = qtd->urb;
+	int pipe_type = usb_pipetype(urb->pipe);
+
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "Transfer Complete--\n", hc->hc_num);
+
+	/*
+	 * Handle xfer complete on CSPLIT.
+	 */
+	if (hc->qh->do_split)
+		qtd->complete_split = 0;
+
+	/* Update the QTD and URB states. */
+	switch (pipe_type) {
+	case PIPE_CONTROL:
+		switch (qtd->control_phase) {
+		case DWC_OTG_CONTROL_SETUP:
+			if (urb->transfer_buffer_length > 0)
+				qtd->control_phase = DWC_OTG_CONTROL_DATA;
+			else
+				qtd->control_phase = DWC_OTG_CONTROL_STATUS;
+			DWC_DEBUGPL(DBG_HCDV,
+				    "  Control setup transaction done\n");
+			halt_status = DWC_OTG_HC_XFER_COMPLETE;
+			break;
+		case DWC_OTG_CONTROL_DATA:{
+				urb_xfer_done =
+				    update_urb_state_xfer_comp(hc, hc_regs,
+							       urb, qtd);
+				if (urb_xfer_done) {
+					qtd->control_phase =
+					    DWC_OTG_CONTROL_STATUS;
+					DWC_DEBUGPL(DBG_HCDV,
+						    " Control data transfer done\n");
+				} else {
+					save_data_toggle(hc, hc_regs, qtd);
+				}
+				halt_status = DWC_OTG_HC_XFER_COMPLETE;
+				break;
+			}
+		case DWC_OTG_CONTROL_STATUS:
+			DWC_DEBUGPL(DBG_HCDV, "  Control transfer complete\n");
+			if (urb->status == -EINPROGRESS)
+				urb->status = 0;
+			dwc_otg_hcd_complete_urb(hcd, urb, urb->status);
+			qtd->urb = NULL;
+			halt_status = DWC_OTG_HC_XFER_URB_COMPLETE;
+			break;
+		}
+
+		complete_non_periodic_xfer(hcd, hc, hc_regs, qtd,
+					   halt_status);
+		break;
+	case PIPE_BULK:
+		DWC_DEBUGPL(DBG_HCDV, "  Bulk transfer complete\n");
+		urb_xfer_done =
+		    update_urb_state_xfer_comp(hc, hc_regs, urb, qtd);
+		if (urb_xfer_done) {
+			dwc_otg_hcd_complete_urb(hcd, urb, urb->status);
+			qtd->urb = NULL;
+			halt_status = DWC_OTG_HC_XFER_URB_COMPLETE;
+		} else {
+			halt_status = DWC_OTG_HC_XFER_COMPLETE;
+		}
+
+		save_data_toggle(hc, hc_regs, qtd);
+		complete_non_periodic_xfer(hcd, hc, hc_regs, qtd,
+					   halt_status);
+		break;
+	case PIPE_INTERRUPT:
+		DWC_DEBUGPL(DBG_HCDV, "  Interrupt transfer complete\n");
+		update_urb_state_xfer_comp(hc, hc_regs, urb, qtd);
+
+		/*
+		 * Interrupt URB is done on the first transfer complete
+		 * interrupt.
+		 */
+		dwc_otg_hcd_complete_urb(hcd, urb, urb->status);
+		qtd->urb = NULL;
+		save_data_toggle(hc, hc_regs, qtd);
+		complete_periodic_xfer(hcd, hc, hc_regs, qtd,
+				       DWC_OTG_HC_XFER_URB_COMPLETE);
+		break;
+	case PIPE_ISOCHRONOUS:
+		DWC_DEBUGPL(DBG_HCDV, "  Isochronous transfer complete\n");
+		if (qtd->isoc_split_pos == DWC_HCSPLIT_XACTPOS_ALL) {
+			halt_status =
+			    update_isoc_urb_state(hcd, hc, hc_regs, qtd,
+						  DWC_OTG_HC_XFER_COMPLETE);
+		}
+		complete_periodic_xfer(hcd, hc, hc_regs, qtd, halt_status);
+		break;
+	}
+
+	disable_hc_int(hc_regs, xfercompl);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel STALL interrupt. This handler may be called in
+ * either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_stall_intr(struct dwc_otg_hcd *hcd,
+				    struct dwc_hc *hc,
+				    struct dwc_otg_hc_regs *hc_regs,
+				    struct dwc_otg_qtd *qtd)
+{
+	struct urb *urb = qtd->urb;
+	int pipe_type = usb_pipetype(urb->pipe);
+
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "STALL Received--\n", hc->hc_num);
+
+	if (pipe_type == PIPE_CONTROL) {
+		dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EPIPE);
+		qtd->urb = NULL;
+	}
+
+	if (pipe_type == PIPE_BULK || pipe_type == PIPE_INTERRUPT) {
+		dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EPIPE);
+		qtd->urb = NULL;
+		/*
+		 * USB protocol requires resetting the data toggle for bulk
+		 * and interrupt endpoints when a CLEAR_FEATURE(ENDPOINT_HALT)
+		 * setup command is issued to the endpoint. Anticipate the
+		 * CLEAR_FEATURE command since a STALL has occurred and reset
+		 * the data toggle now.
+		 */
+		hc->qh->data_toggle = 0;
+	}
+
+	halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_STALL);
+
+	disable_hc_int(hc_regs, stall);
+
+	return 1;
+}
+
+/*
+ * Updates the state of the URB when a transfer has been stopped due to an
+ * abnormal condition before the transfer completes. Modifies the
+ * actual_length field of the URB to reflect the number of bytes that have
+ * actually been transferred via the host channel.
+ */
+static void update_urb_state_xfer_intr(struct dwc_hc *hc,
+				       struct dwc_otg_hc_regs *hc_regs,
+				       struct urb *urb,
+				       struct dwc_otg_qtd *qtd,
+				       enum dwc_otg_halt_status halt_status)
+{
+	uint32_t bytes_transferred = get_actual_xfer_length(hc, hc_regs, qtd,
+							    halt_status, NULL);
+	urb->actual_length += bytes_transferred;
+
+#ifdef DEBUG
+	{
+		union hctsiz_data hctsiz;
+		hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+		DWC_DEBUGPL(DBG_HCDV, "DWC_otg: %s: %s, channel %d\n",
+			    __func__, (hc->ep_is_in ? "IN" : "OUT"),
+			    hc->hc_num);
+		DWC_DEBUGPL(DBG_HCDV, "  hc->start_pkt_count %d\n",
+			    hc->start_pkt_count);
+		DWC_DEBUGPL(DBG_HCDV, "  hctsiz.pktcnt %d\n", hctsiz.b.pktcnt);
+		DWC_DEBUGPL(DBG_HCDV, "  hc->max_packet %d\n",
+			    hc->max_packet);
+		DWC_DEBUGPL(DBG_HCDV, "  bytes_transferred %d\n",
+			    bytes_transferred);
+		DWC_DEBUGPL(DBG_HCDV, "  urb->actual_length %d\n",
+			    urb->actual_length);
+		DWC_DEBUGPL(DBG_HCDV, "  urb->transfer_buffer_length %d\n",
+			    urb->transfer_buffer_length);
+	}
+#endif
+}
+
+/**
+ * Handles a host channel NAK interrupt. This handler may be called in either
+ * DMA mode or Slave mode.
+ */
+static int32_t handle_hc_nak_intr(struct dwc_otg_hcd *hcd,
+				  struct dwc_hc *hc,
+				  struct dwc_otg_hc_regs *hc_regs,
+				  struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "NAK Received--\n", hc->hc_num);
+
+	/*
+	 * Handle NAK for IN/OUT SSPLIT/CSPLIT transfers, bulk, control, and
+	 * interrupt.  Re-start the SSPLIT transfer.
+	 */
+	if (hc->do_split) {
+		if (hc->complete_split)
+			qtd->error_count = 0;
+		qtd->complete_split = 0;
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NAK);
+		goto handle_nak_done;
+	}
+
+	switch (usb_pipetype(qtd->urb->pipe)) {
+	case PIPE_CONTROL:
+	case PIPE_BULK:
+		if (hcd->core_if->dma_enable && hc->ep_is_in) {
+			/*
+			 * NAK interrupts are enabled on bulk/control IN
+			 * transfers in DMA mode for the sole purpose of
+			 * resetting the error count after a transaction error
+			 * occurs. The core will continue transferring data.
+			 */
+			qtd->error_count = 0;
+			goto handle_nak_done;
+		}
+
+		/*
+		 * NAK interrupts normally occur during OUT transfers in DMA
+		 * or Slave mode. For IN transfers, more requests will be
+		 * queued as request queue space is available.
+		 */
+		qtd->error_count = 0;
+
+		if (!hc->qh->ping_state) {
+			update_urb_state_xfer_intr(hc, hc_regs, qtd->urb,
+						   qtd, DWC_OTG_HC_XFER_NAK);
+			save_data_toggle(hc, hc_regs, qtd);
+			if (qtd->urb->dev->speed == USB_SPEED_HIGH)
+				hc->qh->ping_state = 1;
+		}
+
+		/*
+		 * Halt the channel so the transfer can be re-started from
+		 * the appropriate point or the PING protocol will
+		 * start/continue.
+		 */
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NAK);
+		break;
+	case PIPE_INTERRUPT:
+		qtd->error_count = 0;
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NAK);
+		break;
+	case PIPE_ISOCHRONOUS:
+		/* Should never get called for isochronous transfers. */
+		BUG();
+		break;
+	}
+
+handle_nak_done:
+	disable_hc_int(hc_regs, nak);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel ACK interrupt. This interrupt is enabled when
+ * performing the PING protocol in Slave mode, when errors occur during
+ * either Slave mode or DMA mode, and during Start Split transactions.
+ */
+static int32_t handle_hc_ack_intr(struct dwc_otg_hcd *hcd,
+				  struct dwc_hc *hc,
+				  struct dwc_otg_hc_regs *hc_regs,
+				  struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "ACK Received--\n", hc->hc_num);
+
+	if (hc->do_split) {
+		/*
+		 * Handle ACK on SSPLIT.
+		 * ACK should not occur in CSPLIT.
+		 */
+		if ((!hc->ep_is_in)
+		    && (hc->data_pid_start != DWC_OTG_HC_PID_SETUP)) {
+			qtd->ssplit_out_xfer_count = hc->xfer_len;
+		}
+		if (!(hc->ep_type == DWC_OTG_EP_TYPE_ISOC && !hc->ep_is_in)) {
+			/* Don't need complete for isochronous out transfers. */
+			qtd->complete_split = 1;
+		}
+
+		/* ISOC OUT */
+		if ((hc->ep_type == DWC_OTG_EP_TYPE_ISOC) && !hc->ep_is_in) {
+			switch (hc->xact_pos) {
+			case DWC_HCSPLIT_XACTPOS_ALL:
+				break;
+			case DWC_HCSPLIT_XACTPOS_END:
+				qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_ALL;
+				qtd->isoc_split_offset = 0;
+				break;
+			case DWC_HCSPLIT_XACTPOS_BEGIN:
+			case DWC_HCSPLIT_XACTPOS_MID:
+				/*
+				 * For BEGIN or MID, calculate the length for
+				 * the next microframe to determine the correct
+				 * SSPLIT token, either MID or END.
+				 */
+				do {
+					struct usb_iso_packet_descriptor
+					    *frame_desc;
+
+					frame_desc =
+					    &qtd->urb->iso_frame_desc[qtd->isoc_frame_index];
+					qtd->isoc_split_offset += 188;
+
+					if ((frame_desc->length -
+					     qtd->isoc_split_offset) <= 188) {
+						qtd->isoc_split_pos =
+						    DWC_HCSPLIT_XACTPOS_END;
+					} else {
+						qtd->isoc_split_pos =
+						    DWC_HCSPLIT_XACTPOS_MID;
+					}
+
+				} while (0);
+				break;
+			}
+		} else {
+			halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_ACK);
+		}
+	} else {
+		qtd->error_count = 0;
+
+		if (hc->qh->ping_state) {
+			hc->qh->ping_state = 0;
+			/*
+			 * Halt the channel so the transfer can be re-started
+			 * from the appropriate point. This only happens in
+			 * Slave mode. In DMA mode, the ping_state is cleared
+			 * when the transfer is started because the core
+			 * automatically executes the PING, then the transfer.
+			 */
+			halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_ACK);
+		}
+	}
+
+	/*
+	 * If the ACK occurred when _not_ in the PING state, let the channel
+	 * continue transferring data after clearing the error count.
+	 */
+
+	disable_hc_int(hc_regs, ack);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel NYET interrupt. This interrupt should only occur on
+ * Bulk and Control OUT endpoints and for complete split transactions. If a
+ * NYET occurs at the same time as a Transfer Complete interrupt, it is
+ * handled in the xfercomp interrupt handler, not here. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_nyet_intr(struct dwc_otg_hcd *hcd,
+				   struct dwc_hc *hc,
+				   struct dwc_otg_hc_regs *hc_regs,
+				   struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "NYET Received--\n", hc->hc_num);
+
+	/*
+	 * NYET on CSPLIT
+	 * re-do the CSPLIT immediately on non-periodic
+	 */
+	if ((hc->do_split) && (hc->complete_split)) {
+		if ((hc->ep_type == DWC_OTG_EP_TYPE_INTR) ||
+		    (hc->ep_type == DWC_OTG_EP_TYPE_ISOC)) {
+			int frnum =
+			    dwc_otg_hcd_get_frame_number(dwc_otg_hcd_to_hcd
+							 (hcd));
+
+			if (dwc_full_frame_num(frnum) !=
+			    dwc_full_frame_num(hc->qh->sched_frame)) {
+				/*
+				 * No longer in the same full speed frame.
+				 * Treat this as a transaction error.
+				 */
+#if 0
+				/** @todo Fix system performance so this can
+				 * be treated as an error. Right now complete
+				 * splits cannot be scheduled precisely enough
+				 * due to other system activity, so this error
+				 * occurs regularly in Slave mode.
+				 */
+				qtd->error_count++;
+#endif
+				qtd->complete_split = 0;
+				halt_channel(hcd, hc, qtd,
+					     DWC_OTG_HC_XFER_XACT_ERR);
+				/** @todo add support for isoc release */
+				goto handle_nyet_done;
+			}
+		}
+
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NYET);
+		goto handle_nyet_done;
+	}
+
+	hc->qh->ping_state = 1;
+	qtd->error_count = 0;
+
+	update_urb_state_xfer_intr(hc, hc_regs, qtd->urb, qtd,
+				   DWC_OTG_HC_XFER_NYET);
+	save_data_toggle(hc, hc_regs, qtd);
+
+	/*
+	 * Halt the channel and re-start the transfer so the PING
+	 * protocol will start.
+	 */
+	halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NYET);
+
+handle_nyet_done:
+	disable_hc_int(hc_regs, nyet);
+	return 1;
+}
+
+/**
+ * Handles a host channel babble interrupt. This handler may be called in
+ * either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_babble_intr(struct dwc_otg_hcd *hcd,
+				     struct dwc_hc *hc,
+				     struct dwc_otg_hc_regs *hc_regs,
+				     struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "Babble Error--\n", hc->hc_num);
+	if (hc->ep_type != DWC_OTG_EP_TYPE_ISOC) {
+		dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EOVERFLOW);
+		qtd->urb = NULL;
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_BABBLE_ERR);
+	} else {
+		enum dwc_otg_halt_status halt_status;
+		halt_status = update_isoc_urb_state(hcd, hc, hc_regs, qtd,
+						    DWC_OTG_HC_XFER_BABBLE_ERR);
+		halt_channel(hcd, hc, qtd, halt_status);
+	}
+	disable_hc_int(hc_regs, bblerr);
+	return 1;
+}
+
+/**
+ * Handles a host channel AHB error interrupt. This handler is only called in
+ * DMA mode.
+ */
+static int32_t handle_hc_ahberr_intr(struct dwc_otg_hcd *hcd,
+				     struct dwc_hc *hc,
+				     struct dwc_otg_hc_regs *hc_regs,
+				     struct dwc_otg_qtd *qtd)
+{
+	union hcchar_data hcchar;
+	union hcsplt_data hcsplt;
+	union hctsiz_data hctsiz;
+	uint32_t hcdma;
+	struct urb *urb = qtd->urb;
+
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "AHB Error--\n", hc->hc_num);
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcsplt.d32 = dwc_read_reg32(&hc_regs->hcsplt);
+	hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+	hcdma = dwc_read_reg32(&hc_regs->hcdma);
+
+	DWC_ERROR("AHB ERROR, Channel %d\n", hc->hc_num);
+	DWC_ERROR("  hcchar 0x%08x, hcsplt 0x%08x\n", hcchar.d32, hcsplt.d32);
+	DWC_ERROR("  hctsiz 0x%08x, hcdma 0x%08x\n", hctsiz.d32, hcdma);
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD URB Enqueue\n");
+	DWC_ERROR("  Device address: %d\n", usb_pipedevice(urb->pipe));
+	DWC_ERROR("  Endpoint: %d, %s\n", usb_pipeendpoint(urb->pipe),
+		  (usb_pipein(urb->pipe) ? "IN" : "OUT"));
+	DWC_ERROR("  Endpoint type: %s\n",
+		({
+			char *pipetype;
+			switch (usb_pipetype(urb->pipe)) {
+			case PIPE_CONTROL:
+				pipetype = "CONTROL";
+				break;
+			case PIPE_BULK:
+				pipetype = "BULK";
+				break;
+			case PIPE_INTERRUPT:
+				pipetype = "INTERRUPT";
+				break;
+			case PIPE_ISOCHRONOUS:
+				pipetype = "ISOCHRONOUS";
+				break;
+			default:
+				pipetype = "UNKNOWN";
+				break;
+			}
+			pipetype;
+		}));
+	DWC_ERROR("  Speed: %s\n",
+		({
+			char *speed;
+			switch (urb->dev->speed) {
+			case USB_SPEED_HIGH:
+				speed = "HIGH";
+				break;
+			case USB_SPEED_FULL:
+				speed = "FULL";
+				break;
+			case USB_SPEED_LOW:
+				speed = "LOW";
+				break;
+			default:
+				speed = "UNKNOWN";
+				break;
+			}
+			speed;
+		}));
+	DWC_ERROR("  Max packet size: %d\n",
+		  usb_maxpacket(urb->dev, urb->pipe, usb_pipeout(urb->pipe)));
+	DWC_ERROR("  Data buffer length: %d\n", urb->transfer_buffer_length);
+	DWC_ERROR("  Transfer buffer: %p, Transfer DMA: 0x%llx\n",
+		  urb->transfer_buffer, (unsigned long long)urb->transfer_dma);
+	DWC_ERROR("  Setup buffer: %p, Setup DMA: 0x%llx\n",
+		  urb->setup_packet, (unsigned long long)urb->setup_dma);
+	DWC_ERROR("  Interval: %d\n", urb->interval);
+
+	dwc_otg_hcd_complete_urb(hcd, urb, -EIO);
+	qtd->urb = NULL;
+
+	/*
+	 * Force a channel halt. Don't call halt_channel because that won't
+	 * write to the HCCHARn register in DMA mode to force the halt.
+	 */
+	dwc_otg_hc_halt(hcd->core_if, hc, DWC_OTG_HC_XFER_AHB_ERR);
+
+	disable_hc_int(hc_regs, ahberr);
+	return 1;
+}
+
+/**
+ * Handles a host channel transaction error interrupt. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_xacterr_intr(struct dwc_otg_hcd *hcd,
+				      struct dwc_hc *hc,
+				      struct dwc_otg_hc_regs *hc_regs,
+				      struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "Transaction Error--\n", hc->hc_num);
+
+	switch (usb_pipetype(qtd->urb->pipe)) {
+	case PIPE_CONTROL:
+	case PIPE_BULK:
+		qtd->error_count++;
+		if (!hc->qh->ping_state) {
+			update_urb_state_xfer_intr(hc, hc_regs, qtd->urb,
+						   qtd,
+						   DWC_OTG_HC_XFER_XACT_ERR);
+			save_data_toggle(hc, hc_regs, qtd);
+			if (!hc->ep_is_in
+			    && qtd->urb->dev->speed == USB_SPEED_HIGH) {
+				hc->qh->ping_state = 1;
+			}
+		}
+
+		/*
+		 * Halt the channel so the transfer can be re-started from
+		 * the appropriate point or the PING protocol will start.
+		 */
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_XACT_ERR);
+		break;
+	case PIPE_INTERRUPT:
+		qtd->error_count++;
+		if ((hc->do_split) && (hc->complete_split))
+			qtd->complete_split = 0;
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_XACT_ERR);
+		break;
+	case PIPE_ISOCHRONOUS:
+		{
+			enum dwc_otg_halt_status halt_status;
+			halt_status =
+			    update_isoc_urb_state(hcd, hc, hc_regs, qtd,
+						  DWC_OTG_HC_XFER_XACT_ERR);
+
+			halt_channel(hcd, hc, qtd, halt_status);
+		}
+		break;
+	}
+
+	disable_hc_int(hc_regs, xacterr);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel frame overrun interrupt. This handler may be called
+ * in either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_frmovrun_intr(struct dwc_otg_hcd *hcd,
+				       struct dwc_hc *hc,
+				       struct dwc_otg_hc_regs *hc_regs,
+				       struct dwc_otg_qtd *qtd)
+{
+	enum dwc_otg_halt_status halt_status;
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "Frame Overrun--\n", hc->hc_num);
+
+	switch (usb_pipetype(qtd->urb->pipe)) {
+	case PIPE_CONTROL:
+	case PIPE_BULK:
+		break;
+	case PIPE_INTERRUPT:
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_FRAME_OVERRUN);
+		break;
+	case PIPE_ISOCHRONOUS:
+		halt_status =
+			update_isoc_urb_state(hcd, hc, hc_regs, qtd,
+					      DWC_OTG_HC_XFER_FRAME_OVERRUN);
+			halt_channel(hcd, hc, qtd, halt_status);
+		break;
+	}
+
+	disable_hc_int(hc_regs, frmovrun);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel data toggle error interrupt. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int32_t handle_hc_datatglerr_intr(struct dwc_otg_hcd *hcd,
+					 struct dwc_hc *hc,
+					 struct dwc_otg_hc_regs *hc_regs,
+					 struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "Data Toggle Error--\n", hc->hc_num);
+
+	if (hc->ep_is_in) {
+		qtd->error_count = 0;
+	} else {
+		DWC_ERROR("Data Toggle Error on OUT transfer,"
+			  "channel %d\n", hc->hc_num);
+	}
+
+	disable_hc_int(hc_regs, datatglerr);
+
+	return 1;
+}
+
+#ifdef DEBUG
+/**
+ * This function is for debug only. It checks that a valid halt status is set
+ * and that HCCHARn.chdis is clear. If there's a problem, corrective action is
+ * taken and a warning is issued.
+ * Returns 1 if halt status is ok, 0 otherwise.
+ */
+static inline int halt_status_ok(struct dwc_otg_hcd *hcd,
+				 struct dwc_hc *hc,
+				 struct dwc_otg_hc_regs *hc_regs,
+				 struct dwc_otg_qtd *qtd)
+{
+	union hcchar_data hcchar;
+	union hctsiz_data hctsiz;
+	union hcint_data hcint;
+	union hcintmsk_data hcintmsk;
+	union hcsplt_data hcsplt;
+
+	if (hc->halt_status == DWC_OTG_HC_XFER_NO_HALT_STATUS) {
+		/*
+		 * This code is here only as a check. This condition should
+		 * never happen. Ignore the halt if it does occur.
+		 */
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hctsiz.d32 = dwc_read_reg32(&hc_regs->hctsiz);
+		hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+		hcintmsk.d32 = dwc_read_reg32(&hc_regs->hcintmsk);
+		hcsplt.d32 = dwc_read_reg32(&hc_regs->hcsplt);
+		DWC_WARN
+		    ("%s: hc->halt_status == DWC_OTG_HC_XFER_NO_HALT_STATUS, "
+		     "channel %d, hcchar 0x%08x, hctsiz 0x%08x, "
+		     "hcint 0x%08x, hcintmsk 0x%08x, "
+		     "hcsplt 0x%08x, qtd->complete_split %d\n", __func__,
+		     hc->hc_num, hcchar.d32, hctsiz.d32, hcint.d32,
+		     hcintmsk.d32, hcsplt.d32, qtd->complete_split);
+
+		DWC_WARN("%s: no halt status, channel %d, ignoring interrupt\n",
+			 __func__, hc->hc_num);
+		DWC_WARN("\n");
+		clear_hc_int(hc_regs, chhltd);
+		return 0;
+	}
+
+	/*
+	 * This code is here only as a check. hcchar.chdis should
+	 * never be set when the halt interrupt occurs. Halt the
+	 * channel again if it does occur.
+	 */
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	if (hcchar.b.chdis) {
+		DWC_WARN("%s: hcchar.chdis set unexpectedly, "
+			 "hcchar 0x%08x, trying to halt again\n",
+			 __func__, hcchar.d32);
+		clear_hc_int(hc_regs, chhltd);
+		hc->halt_pending = 0;
+		halt_channel(hcd, hc, qtd, hc->halt_status);
+		return 0;
+	}
+
+	return 1;
+}
+#endif
+
+/**
+ * Handles a host Channel Halted interrupt in DMA mode. This handler
+ * determines the reason the channel halted and proceeds accordingly.
+ */
+static void handle_hc_chhltd_intr_dma(struct dwc_otg_hcd *hcd,
+				      struct dwc_hc *hc,
+				      struct dwc_otg_hc_regs *hc_regs,
+				      struct dwc_otg_qtd *qtd)
+{
+	union hcint_data hcint;
+	union hcintmsk_data hcintmsk;
+
+	if (hc->halt_status == DWC_OTG_HC_XFER_URB_DEQUEUE ||
+	    hc->halt_status == DWC_OTG_HC_XFER_AHB_ERR) {
+		/*
+		 * Just release the channel. A dequeue can happen on a
+		 * transfer timeout. In the case of an AHB Error, the channel
+		 * was forced to halt because there's no way to gracefully
+		 * recover.
+		 */
+		release_channel(hcd, hc, qtd, hc->halt_status);
+		return;
+	}
+
+	/* Read the HCINTn register to determine the cause for the halt. */
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+	hcintmsk.d32 = dwc_read_reg32(&hc_regs->hcintmsk);
+
+	if (hcint.b.xfercomp) {
+		/*
+		 * @todo This is here because of a possible hardware
+		 * bug.  Spec says that on SPLIT-ISOC OUT transfers in
+		 * DMA mode that a HALT interrupt w/ACK bit set should
+		 * occur, but I only see the XFERCOMP bit, even with
+		 * it masked out.  This is a workaround for that
+		 * behavior.  Should fix this when hardware is fixed.
+		 */
+		if ((hc->ep_type == DWC_OTG_EP_TYPE_ISOC) && (!hc->ep_is_in))
+			handle_hc_ack_intr(hcd, hc, hc_regs, qtd);
+		handle_hc_xfercomp_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.stall) {
+		handle_hc_stall_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.xacterr) {
+		/*
+		 * Must handle xacterr before nak or ack. Could get a xacterr
+		 * at the same time as either of these on a BULK/CONTROL OUT
+		 * that started with a PING. The xacterr takes precedence.
+		 */
+		handle_hc_xacterr_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.nyet) {
+		/*
+		 * Must handle nyet before nak or ack. Could get a nyet at the
+		 * same time as either of those on a BULK/CONTROL OUT that
+		 * started with a PING. The nyet takes precedence.
+		 */
+		handle_hc_nyet_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.bblerr) {
+		handle_hc_babble_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.frmovrun) {
+		handle_hc_frmovrun_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.nak && !hcintmsk.b.nak) {
+		/*
+		 * If nak is not masked, it's because a non-split IN transfer
+		 * is in an error state. In that case, the nak is handled by
+		 * the nak interrupt handler, not here. Handle nak here for
+		 * BULK/CONTROL OUT transfers, which halt on a NAK to allow
+		 * rewinding the buffer pointer.
+		 */
+		handle_hc_nak_intr(hcd, hc, hc_regs, qtd);
+	} else if (hcint.b.ack && !hcintmsk.b.ack) {
+		/*
+		 * If ack is not masked, it's because a non-split IN transfer
+		 * is in an error state. In that case, the ack is handled by
+		 * the ack interrupt handler, not here. Handle ack here for
+		 * split transfers. Start splits halt on ACK.
+		 */
+		handle_hc_ack_intr(hcd, hc, hc_regs, qtd);
+	} else {
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+		    hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			/*
+			 * A periodic transfer halted with no other channel
+			 * interrupts set. Assume it was halted by the core
+			 * because it could not be completed in its scheduled
+			 * (micro)frame.
+			 */
+#ifdef DEBUG
+			DWC_PRINT("%s: Halt channel %d (assume incomplete "
+				  "periodic transfer)\n",
+				__func__, hc->hc_num);
+#endif
+			halt_channel(hcd, hc, qtd,
+				     DWC_OTG_HC_XFER_PERIODIC_INCOMPLETE);
+		} else {
+			DWC_ERROR("%s: Channel %d, DMA Mode -- ChHltd set, "
+				  "but reason for halting is unknown, hcint "
+				  "0x%08x, intsts 0x%08x\n",
+				__func__, hc->hc_num, hcint.d32,
+				dwc_read_reg32(&hcd->core_if->core_global_regs->
+					gintsts));
+		}
+	}
+}
+
+/**
+ * Handles a host channel Channel Halted interrupt.
+ *
+ * In slave mode, this handler is called only when the driver specifically
+ * requests a halt. This occurs during handling other host channel interrupts
+ * (e.g. nak, xacterr, stall, nyet, etc.).
+ *
+ * In DMA mode, this is the interrupt that occurs when the core has finished
+ * processing a transfer on a channel. Other host channel interrupts (except
+ * ahberr) are disabled in DMA mode.
+ */
+static int32_t handle_hc_chhltd_intr(struct dwc_otg_hcd *hcd,
+				     struct dwc_hc *hc,
+				     struct dwc_otg_hc_regs *hc_regs,
+				     struct dwc_otg_qtd *qtd)
+{
+	DWC_DEBUGPL(DBG_HCD, "--Host Channel %d Interrupt: "
+		    "Channel Halted--\n", hc->hc_num);
+
+	if (hcd->core_if->dma_enable) {
+		handle_hc_chhltd_intr_dma(hcd, hc, hc_regs, qtd);
+	} else {
+#ifdef DEBUG
+		if (!halt_status_ok(hcd, hc, hc_regs, qtd))
+			return 1;
+#endif
+		release_channel(hcd, hc, qtd, hc->halt_status);
+	}
+
+	return 1;
+}
+
+/** Handles interrupt for a specific Host Channel */
+int32_t dwc_otg_hcd_handle_hc_n_intr(struct dwc_otg_hcd *dwc_otg_hcd,
+				     uint32_t _num)
+{
+	int retval = 0;
+	union hcint_data hcint;
+	union hcintmsk_data hcintmsk;
+	struct dwc_hc *hc;
+	struct dwc_otg_hc_regs *hc_regs;
+	struct dwc_otg_qtd *qtd;
+
+	DWC_DEBUGPL(DBG_HCDV, "--Host Channel Interrupt--, Channel %d\n", _num);
+
+	hc = dwc_otg_hcd->hc_ptr_array[_num];
+	hc_regs = dwc_otg_hcd->core_if->host_if->hc_regs[_num];
+	qtd = list_entry(hc->qh->qtd_list.next, struct dwc_otg_qtd,
+			 qtd_list_entry);
+
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+	hcintmsk.d32 = dwc_read_reg32(&hc_regs->hcintmsk);
+	DWC_DEBUGPL(DBG_HCDV,
+		    "  hcint 0x%08x, hcintmsk 0x%08x, hcint&hcintmsk 0x%08x\n",
+		    hcint.d32, hcintmsk.d32, (hcint.d32 & hcintmsk.d32));
+	hcint.d32 = hcint.d32 & hcintmsk.d32;
+
+	if (!dwc_otg_hcd->core_if->dma_enable) {
+		if ((hcint.b.chhltd) && (hcint.d32 != 0x2))
+			hcint.b.chhltd = 0;
+	}
+
+	if (hcint.b.xfercomp) {
+		retval |=
+		    handle_hc_xfercomp_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+		/*
+		 * If NYET occurred at same time as Xfer Complete, the NYET is
+		 * handled by the Xfer Complete interrupt handler. Don't want
+		 * to call the NYET interrupt handler in this case.
+		 */
+		hcint.b.nyet = 0;
+	}
+	if (hcint.b.chhltd)
+		retval |= handle_hc_chhltd_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.ahberr)
+		retval |= handle_hc_ahberr_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.stall)
+		retval |= handle_hc_stall_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.nak)
+		retval |= handle_hc_nak_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.ack)
+		retval |= handle_hc_ack_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.nyet)
+		retval |= handle_hc_nyet_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.xacterr)
+		retval |=
+		    handle_hc_xacterr_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.bblerr)
+		retval |= handle_hc_babble_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.frmovrun)
+		retval |=
+		    handle_hc_frmovrun_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	if (hcint.b.datatglerr)
+		retval |=
+		    handle_hc_datatglerr_intr(dwc_otg_hcd, hc, hc_regs, qtd);
+
+	return retval;
+}
+
+#endif /* DWC_DEVICE_ONLY */
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c b/drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
new file mode 100644
index 0000000..e4c96f2
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
@@ -0,0 +1,695 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+#ifndef DWC_DEVICE_ONLY
+
+/*
+ *
+ * This file contains the functions to manage Queue Heads and Queue
+ * Transfer Descriptors.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+
+#include "dwc_otg_driver.h"
+#include "dwc_otg_hcd.h"
+#include "dwc_otg_regs.h"
+
+/**
+ * This function allocates and initializes a QH.
+ *
+ * @hcd: The HCD state structure for the DWC OTG controller.
+ * @urb: Holds the information about the device/endpoint that we need
+ * to initialize the QH.
+ *
+ * Returns Returns pointer to the newly allocated QH, or NULL on error. */
+struct dwc_otg_qh *dwc_otg_hcd_qh_create(struct dwc_otg_hcd *hcd,
+				    struct urb *urb)
+{
+	struct dwc_otg_qh *qh;
+
+	/* Allocate memory */
+	/** @todo add memflags argument */
+	qh = dwc_otg_hcd_qh_alloc();
+	if (qh == NULL)
+		return NULL;
+
+	dwc_otg_hcd_qh_init(hcd, qh, urb);
+	return qh;
+}
+
+/** Free each QTD in the QH's QTD-list then free the QH.  QH should already be
+ * removed from a list.  QTD list should already be empty if called from URB
+ * Dequeue.
+ *
+ * @qh: The QH to free.
+ */
+void dwc_otg_hcd_qh_free(struct dwc_otg_qh *qh)
+{
+	struct dwc_otg_qtd *qtd;
+	struct list_head *pos;
+
+	/* Free each QTD in the QTD list */
+	for (pos = qh->qtd_list.next;
+	     pos != &qh->qtd_list; pos = qh->qtd_list.next) {
+		list_del(pos);
+		qtd = dwc_list_to_qtd(pos);
+		dwc_otg_hcd_qtd_free(qtd);
+	}
+
+	kfree(qh);
+	return;
+}
+
+/** Initializes a QH structure.
+ *
+ * @hcd: The HCD state structure for the DWC OTG controller.
+ * @qh: The QH to init.
+ * @urb: Holds the information about the device/endpoint that we need
+ * to initialize the QH. */
+#define SCHEDULE_SLOP 10
+void dwc_otg_hcd_qh_init(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh,
+			 struct urb *urb)
+{
+	memset(qh, 0, sizeof(struct dwc_otg_qh));
+
+	/* Initialize QH */
+	switch (usb_pipetype(urb->pipe)) {
+	case PIPE_CONTROL:
+		qh->ep_type = USB_ENDPOINT_XFER_CONTROL;
+		break;
+	case PIPE_BULK:
+		qh->ep_type = USB_ENDPOINT_XFER_BULK;
+		break;
+	case PIPE_ISOCHRONOUS:
+		qh->ep_type = USB_ENDPOINT_XFER_ISOC;
+		break;
+	case PIPE_INTERRUPT:
+		qh->ep_type = USB_ENDPOINT_XFER_INT;
+		break;
+	}
+
+	qh->ep_is_in = usb_pipein(urb->pipe) ? 1 : 0;
+
+	qh->data_toggle = DWC_OTG_HC_PID_DATA0;
+	qh->maxp =
+	    usb_maxpacket(urb->dev, urb->pipe, !(usb_pipein(urb->pipe)));
+	INIT_LIST_HEAD(&qh->qtd_list);
+	INIT_LIST_HEAD(&qh->qh_list_entry);
+	qh->channel = NULL;
+
+	/* FS/LS Enpoint on HS Hub
+	 * NOT virtual root hub */
+	qh->do_split = 0;
+	if (((urb->dev->speed == USB_SPEED_LOW) ||
+	     (urb->dev->speed == USB_SPEED_FULL)) &&
+	    (urb->dev->tt) && (urb->dev->tt->hub->devnum != 1)) {
+		DWC_DEBUGPL(DBG_HCD,
+			    "QH init: EP %d: TT found at hub addr %d, for "
+			    "port %d\n",
+			    usb_pipeendpoint(urb->pipe),
+			    urb->dev->tt->hub->devnum, urb->dev->ttport);
+		qh->do_split = 1;
+	}
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT ||
+	    qh->ep_type == USB_ENDPOINT_XFER_ISOC) {
+		/* Compute scheduling parameters once and save them. */
+		union hprt0_data hprt;
+
+		/* todo Account for split transfers in the bus time. */
+		int bytecount =
+		    dwc_hb_mult(qh->maxp) * dwc_max_packet(qh->maxp);
+		/*
+		 * The results from usb_calc_bus_time are in nanosecs,
+		 * so divide the result by 1000 to convert to
+		 * microsecs expected by this driver
+		 */
+		qh->usecs = usb_calc_bus_time(urb->dev->speed,
+					       usb_pipein(urb->pipe),
+					       (qh->ep_type ==
+						USB_ENDPOINT_XFER_ISOC),
+					       bytecount) / 1000;
+
+		/* Start in a slightly future (micro)frame. */
+		qh->sched_frame = dwc_frame_num_inc(hcd->frame_number,
+						     SCHEDULE_SLOP);
+		qh->interval = urb->interval;
+#if 0
+		/* Increase interrupt polling rate for debugging. */
+		if (qh->ep_type == USB_ENDPOINT_XFER_INT)
+			qh->interval = 8;
+#endif
+		hprt.d32 = dwc_read_reg32(hcd->core_if->host_if->hprt0);
+		if ((hprt.b.prtspd == DWC_HPRT0_PRTSPD_HIGH_SPEED) &&
+		    ((urb->dev->speed == USB_SPEED_LOW) ||
+		     (urb->dev->speed == USB_SPEED_FULL))) {
+			qh->interval *= 8;
+			qh->sched_frame |= 0x7;
+			qh->start_split_frame = qh->sched_frame;
+		}
+
+	}
+
+	DWC_DEBUGPL(DBG_HCD, "DWC OTG HCD QH Initialized\n");
+	DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH  - qh = %p\n", qh);
+	DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH  - Device Address = %d\n",
+		    urb->dev->devnum);
+	DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH  - Endpoint %d, %s\n",
+		    usb_pipeendpoint(urb->pipe),
+		    usb_pipein(urb->pipe) == USB_DIR_IN ? "IN" : "OUT");
+	DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH  - Speed = %s\n",
+		({
+			char *speed;
+			switch (urb->dev->speed) {
+			case USB_SPEED_LOW:
+				speed = "low";
+				break;
+			case USB_SPEED_FULL:
+				speed = "full";
+				break;
+			case USB_SPEED_HIGH:
+				speed = "high";
+				break;
+			default:
+				speed = "?";
+				break;
+			}
+			speed;
+		}));
+	DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH  - Type = %s\n",
+		({
+			char *type;
+			switch (qh->ep_type) {
+			case USB_ENDPOINT_XFER_ISOC:
+				type = "isochronous";
+				break;
+			case USB_ENDPOINT_XFER_INT:
+				type = "interrupt";
+				break;
+			case USB_ENDPOINT_XFER_CONTROL:
+				type = "control";
+				break;
+			case USB_ENDPOINT_XFER_BULK:
+				type = "bulk";
+				break;
+			default:
+				type = "?";
+				break;
+			}
+			type;
+		}));
+#ifdef DEBUG
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT) {
+		DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH - usecs = %d\n",
+			    qh->usecs);
+		DWC_DEBUGPL(DBG_HCDV, "DWC OTG HCD QH - interval = %d\n",
+			    qh->interval);
+	}
+#endif
+
+	return;
+}
+
+/**
+ * Checks that a channel is available for a periodic transfer.
+ *
+ * Returns 0 if successful, negative error code otherise.
+ */
+static int periodic_channel_available(struct dwc_otg_hcd *hcd)
+{
+	/*
+	 * Currently assuming that there is a dedicated host channnel for each
+	 * periodic transaction plus at least one host channel for
+	 * non-periodic transactions.
+	 */
+	int status;
+	int num_channels;
+
+	num_channels = hcd->core_if->core_params->host_channels;
+	if ((hcd->periodic_channels + hcd->non_periodic_channels <
+	     num_channels) && (hcd->periodic_channels < num_channels - 1)) {
+		status = 0;
+	} else {
+		DWC_NOTICE
+		    ("%s: Total channels: %d, Periodic: %d, Non-periodic: %d\n",
+		     __func__, num_channels, hcd->periodic_channels,
+		     hcd->non_periodic_channels);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Checks that there is sufficient bandwidth for the specified QH in the
+ * periodic schedule. For simplicity, this calculation assumes that all the
+ * transfers in the periodic schedule may occur in the same (micro)frame.
+ *
+ * @hcd: The HCD state structure for the DWC OTG controller.
+ * @qh: QH containing periodic bandwidth required.
+ *
+ * Returns 0 if successful, negative error code otherwise.
+ */
+static int check_periodic_bandwidth(struct dwc_otg_hcd *hcd,
+				    struct dwc_otg_qh *qh)
+{
+	int status;
+	uint16_t max_claimed_usecs;
+
+	status = 0;
+
+	if (hcd->core_if->core_params->speed == DWC_SPEED_PARAM_HIGH) {
+		/*
+		 * High speed mode.
+		 * Max periodic usecs is 80% x 125 usec = 100 usec.
+		 */
+		max_claimed_usecs = 100 - qh->usecs;
+	} else {
+		/*
+		 * Full speed mode.
+		 * Max periodic usecs is 90% x 1000 usec = 900 usec.
+		 */
+		max_claimed_usecs = 900 - qh->usecs;
+	}
+
+	if (hcd->periodic_usecs > max_claimed_usecs) {
+		DWC_NOTICE("%s: already claimed usecs %d, required usecs %d\n",
+			   __func__, hcd->periodic_usecs, qh->usecs);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Checks that the max transfer size allowed in a host channel is large enough
+ * to handle the maximum data transfer in a single (micro)frame for a periodic
+ * transfer.
+ *
+ * @hcd: The HCD state structure for the DWC OTG controller.
+ * @qh: QH for a periodic endpoint.
+ *
+ * Returns 0 if successful, negative error code otherwise.
+ */
+static int check_max_xfer_size(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh)
+{
+	int status;
+	uint32_t max_xfer_size;
+	uint32_t max_channel_xfer_size;
+
+	status = 0;
+
+	max_xfer_size = dwc_max_packet(qh->maxp) * dwc_hb_mult(qh->maxp);
+	max_channel_xfer_size = hcd->core_if->core_params->max_transfer_size;
+
+	if (max_xfer_size > max_channel_xfer_size) {
+		DWC_NOTICE("%s: Periodic xfer length %d > "
+			   "max xfer length for channel %d\n",
+			   __func__, max_xfer_size, max_channel_xfer_size);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Schedules an interrupt or isochronous transfer in the periodic schedule.
+ *
+ * @hcd: The HCD state structure for the DWC OTG controller.
+ * @qh: QH for the periodic transfer. The QH should already contain the
+ * scheduling information.
+ *
+ * Returns 0 if successful, negative error code otherwise.
+ */
+static int schedule_periodic(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh)
+{
+	int status = 0;
+
+	status = periodic_channel_available(hcd);
+	if (status) {
+		DWC_NOTICE("%s: No host channel available for periodic "
+			   "transfer.\n", __func__);
+		return status;
+	}
+
+	status = check_periodic_bandwidth(hcd, qh);
+	if (status) {
+		DWC_NOTICE("%s: Insufficient periodic bandwidth for "
+			   "periodic transfer.\n", __func__);
+		return status;
+	}
+
+	status = check_max_xfer_size(hcd, qh);
+	if (status) {
+		DWC_NOTICE("%s: Channel max transfer size too small "
+			   "for periodic transfer.\n", __func__);
+		return status;
+	}
+
+	/* Always start in the inactive schedule. */
+	list_add_tail(&qh->qh_list_entry, &hcd->periodic_sched_inactive);
+
+	/* Reserve the periodic channel. */
+	hcd->periodic_channels++;
+
+	/* Update claimed usecs per (micro)frame. */
+	hcd->periodic_usecs += qh->usecs;
+
+	/*
+	 * Update average periodic bandwidth claimed and # periodic
+	 * reqs for usbfs.
+	 */
+	hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))->bandwidth_allocated +=
+	    qh->usecs / qh->interval;
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT) {
+		hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))->bandwidth_int_reqs++;
+		DWC_DEBUGPL(DBG_HCD,
+			    "Scheduled intr: qh %p, usecs %d, period %d\n", qh,
+			    qh->usecs, qh->interval);
+	} else {
+		hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))->bandwidth_isoc_reqs++;
+		DWC_DEBUGPL(DBG_HCD,
+			    "Scheduled isoc: qh %p, usecs %d, period %d\n", qh,
+			    qh->usecs, qh->interval);
+	}
+
+	return status;
+}
+
+/**
+ * This function adds a QH to either the non periodic or periodic schedule if
+ * it is not already in the schedule. If the QH is already in the schedule, no
+ * action is taken.
+ *
+ * Returns 0 if successful, negative error code otherwise.
+ */
+int dwc_otg_hcd_qh_add(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh)
+{
+	int status = 0;
+
+	if (!spin_is_locked(&hcd->global_lock))	{
+		pr_err("%s don't have hcd->global_lock", __func__);
+		BUG();
+	}
+
+	if (!list_empty(&qh->qh_list_entry)) {
+		/* QH already in a schedule. */
+		goto done;
+	}
+
+	/* Add the new QH to the appropriate schedule */
+	if (dwc_qh_is_non_per(qh)) {
+		/* Always start in the inactive schedule. */
+		list_add_tail(&qh->qh_list_entry,
+			      &hcd->non_periodic_sched_inactive);
+	} else {
+		status = schedule_periodic(hcd, qh);
+	}
+
+done:
+	return status;
+}
+
+/**
+ * Removes an interrupt or isochronous transfer from the periodic schedule.
+ *
+ * @hcd: The HCD state structure for the DWC OTG controller.
+ * @qh: QH for the periodic transfer.
+ */
+static void deschedule_periodic(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh)
+{
+	list_del_init(&qh->qh_list_entry);
+
+	/* Release the periodic channel reservation. */
+	hcd->periodic_channels--;
+
+	/* Update claimed usecs per (micro)frame. */
+	hcd->periodic_usecs -= qh->usecs;
+
+	/*
+	 * Update average periodic bandwidth claimed and # periodic
+	 * reqs for usbfs.
+	 */
+	hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))->bandwidth_allocated -=
+	    qh->usecs / qh->interval;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT) {
+		hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))->bandwidth_int_reqs--;
+		DWC_DEBUGPL(DBG_HCD,
+			    "Descheduled intr: qh %p, usecs %d, period %d\n",
+			    qh, qh->usecs, qh->interval);
+	} else {
+		hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))->bandwidth_isoc_reqs--;
+		DWC_DEBUGPL(DBG_HCD,
+			    "Descheduled isoc: qh %p, usecs %d, period %d\n",
+			    qh, qh->usecs, qh->interval);
+	}
+}
+
+/**
+ * Removes a QH from either the non-periodic or periodic schedule.  Memory is
+ * not freed.
+ *
+ * @hcd: The HCD state structure.
+ * @qh: QH to remove from schedule. */
+void dwc_otg_hcd_qh_remove(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh)
+{
+	if (!spin_is_locked(&hcd->global_lock))	{
+		pr_err("%s don't have hcd->global_lock", __func__);
+		BUG();
+	}
+
+	if (list_empty(&qh->qh_list_entry)) {
+		/* QH is not in a schedule. */
+		goto done;
+	}
+
+	if (dwc_qh_is_non_per(qh)) {
+		if (hcd->non_periodic_qh_ptr == &qh->qh_list_entry) {
+			hcd->non_periodic_qh_ptr =
+			    hcd->non_periodic_qh_ptr->next;
+		}
+		list_del_init(&qh->qh_list_entry);
+	} else {
+		deschedule_periodic(hcd, qh);
+	}
+
+done:
+	;
+}
+
+/**
+ * Deactivates a QH. For non-periodic QHs, removes the QH from the active
+ * non-periodic schedule. The QH is added to the inactive non-periodic
+ * schedule if any QTDs are still attached to the QH.
+ *
+ * For periodic QHs, the QH is removed from the periodic queued schedule. If
+ * there are any QTDs still attached to the QH, the QH is added to either the
+ * periodic inactive schedule or the periodic ready schedule and its next
+ * scheduled frame is calculated. The QH is placed in the ready schedule if
+ * the scheduled frame has been reached already. Otherwise it's placed in the
+ * inactive schedule. If there are no QTDs attached to the QH, the QH is
+ * completely removed from the periodic schedule.
+ */
+void dwc_otg_hcd_qh_deactivate(struct dwc_otg_hcd *hcd, struct dwc_otg_qh *qh,
+			       int sched_next_periodic_split)
+{
+	uint16_t frame_number;
+
+	if (!spin_is_locked(&hcd->global_lock))	{
+		pr_err("%s don't have hcd->global_lock", __func__);
+		BUG();
+	}
+
+	if (dwc_qh_is_non_per(qh)) {
+		dwc_otg_hcd_qh_remove(hcd, qh);
+		if (!list_empty(&qh->qtd_list))
+			/* Add back to inactive non-periodic schedule. */
+			dwc_otg_hcd_qh_add(hcd, qh);
+		return;
+	}
+
+	frame_number = dwc_otg_hcd_get_frame_number(dwc_otg_hcd_to_hcd(hcd));
+
+	if (qh->do_split) {
+		/* Schedule the next continuing periodic split transfer */
+		if (sched_next_periodic_split) {
+
+			qh->sched_frame = frame_number;
+			if (dwc_frame_num_le(frame_number,
+				dwc_frame_num_inc(qh->start_split_frame,
+						  1))) {
+				/*
+				 * Allow one frame to elapse after
+				 * start split microframe before
+				 * scheduling complete split, but DONT
+				 * if we are doing the next start
+				 * split in the same frame for an ISOC
+				 * out.
+				 */
+				if ((qh->ep_type != USB_ENDPOINT_XFER_ISOC)
+				     || (qh->ep_is_in != 0)) {
+					qh->sched_frame =
+						dwc_frame_num_inc(qh->sched_frame,
+								  1);
+				}
+			}
+		} else {
+			qh->sched_frame =
+				dwc_frame_num_inc(qh->start_split_frame,
+						  qh->interval);
+			if (dwc_frame_num_le(qh->sched_frame, frame_number))
+				qh->sched_frame = frame_number;
+
+			qh->sched_frame |= 0x7;
+			qh->start_split_frame = qh->sched_frame;
+		}
+	} else {
+		qh->sched_frame = dwc_frame_num_inc(qh->sched_frame,
+						    qh->interval);
+		if (dwc_frame_num_le(qh->sched_frame, frame_number))
+			qh->sched_frame = frame_number;
+	}
+
+	if (list_empty(&qh->qtd_list)) {
+		dwc_otg_hcd_qh_remove(hcd, qh);
+	} else {
+		/*
+		 * Remove from periodic_sched_queued and move to
+		 * appropriate queue.
+		 */
+		if (qh->sched_frame == frame_number) {
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_ready);
+		} else {
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_inactive);
+		}
+	}
+}
+
+/**
+ * This function allocates and initializes a QTD.
+ *
+ * @urb: The URB to create a QTD from.  Each URB-QTD pair will end up
+ * pointing to each other so each pair should have a unique correlation.
+ *
+ * Returns Returns pointer to the newly allocated QTD, or NULL on error. */
+struct dwc_otg_qtd *dwc_otg_hcd_qtd_create(struct urb *urb)
+{
+	struct dwc_otg_qtd *qtd;
+
+	qtd = dwc_otg_hcd_qtd_alloc();
+	if (qtd == NULL)
+		return NULL;
+
+	dwc_otg_hcd_qtd_init(qtd, urb);
+	return qtd;
+}
+
+/**
+ * Initializes a QTD structure.
+ *
+ * @qtd: The QTD to initialize.
+ * @urb: The URB to use for initialization.
+ */
+void dwc_otg_hcd_qtd_init(struct dwc_otg_qtd *qtd, struct urb *urb)
+{
+	memset(qtd, 0, sizeof(struct dwc_otg_qtd));
+	qtd->urb = urb;
+	if (usb_pipecontrol(urb->pipe)) {
+		/*
+		 * The only time the QTD data toggle is used is on the data
+		 * phase of control transfers. This phase always starts with
+		 * DATA1.
+		 */
+		qtd->data_toggle = DWC_OTG_HC_PID_DATA1;
+		qtd->control_phase = DWC_OTG_CONTROL_SETUP;
+	}
+
+	/* start split */
+	qtd->complete_split = 0;
+	qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_ALL;
+	qtd->isoc_split_offset = 0;
+
+	/* Store the qtd ptr in the urb to reference what QTD. */
+	urb->hcpriv = qtd;
+	return;
+}
+
+/**
+ * This function adds a QTD to the QTD-list of a QH.  It will find the correct
+ * QH to place the QTD into.  If it does not find a QH, then it will create a
+ * new QH. If the QH to which the QTD is added is not currently scheduled, it
+ * is placed into the proper schedule based on its EP type.
+ *
+ * @qtd: The QTD to add
+ * @dwc_otg_hcd: The DWC HCD structure
+ *
+ * Returns 0 if successful, negative error code otherwise.
+ */
+int dwc_otg_hcd_qtd_add(struct dwc_otg_qtd *qtd,
+			struct dwc_otg_hcd *dwc_otg_hcd)
+{
+	struct usb_host_endpoint *ep;
+	struct dwc_otg_qh *qh;
+	int retval = 0;
+
+	struct urb *urb = qtd->urb;
+
+	/*
+	 * Get the QH which holds the QTD-list to insert to. Create QH if it
+	 * doesn't exist.
+	 */
+	ep = dwc_urb_to_endpoint(urb);
+	qh = ep->hcpriv;
+	if (qh == NULL) {
+		qh = dwc_otg_hcd_qh_create(dwc_otg_hcd, urb);
+		if (qh == NULL) {
+			retval = -ENOMEM;
+			goto done;
+		}
+		ep->hcpriv = qh;
+	}
+	qtd->qh = qh;
+	retval = dwc_otg_hcd_qh_add(dwc_otg_hcd, qh);
+	if (retval == 0)
+		list_add_tail(&qtd->qtd_list_entry, &qh->qtd_list);
+done:
+	return retval;
+}
+
+#endif /* DWC_DEVICE_ONLY */
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_octeon.c b/drivers/usb/host/dwc_otg/dwc_otg_octeon.c
new file mode 100644
index 0000000..5e92b3c
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_octeon.c
@@ -0,0 +1,1078 @@
+/* ==========================================================================
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/stat.h>		/* permission constants */
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include "dwc_otg_plat.h"
+#include "dwc_otg_attr.h"
+#include "dwc_otg_driver.h"
+#include "dwc_otg_cil.h"
+#ifndef DWC_HOST_ONLY
+#include "dwc_otg_pcd.h"
+#endif
+#include "dwc_otg_hcd.h"
+
+#define	DWC_DRIVER_VERSION	"2.40a 10-APR-2006"
+#define	DWC_DRIVER_DESC		"HS OTG USB Controller driver"
+
+static const char dwc_driver_name[] = "dwc_otg";
+int dwc_errata_write_count;	/* See dwc_otg_plat.h, dwc_write_reg32 */
+
+/*-------------------------------------------------------------------------*/
+/* Encapsulate the module parameter settings */
+
+static struct dwc_otg_core_params dwc_otg_module_params = {
+	.opt = -1,
+	.otg_cap = -1,
+	.dma_enable = -1,
+	.dma_burst_size = -1,
+	.speed = -1,
+	.host_support_fs_ls_low_power = -1,
+	.host_ls_low_power_phy_clk = -1,
+	.enable_dynamic_fifo = -1,
+	.data_fifo_size = -1,
+	.dev_rx_fifo_size = -1,
+	.dev_nperio_tx_fifo_size = -1,
+	.dev_perio_tx_fifo_size = {-1,	/* dev_perio_tx_fifo_size_1 */
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1,
+				   -1},	/* 15 */
+	.host_rx_fifo_size = -1,
+	.host_nperio_tx_fifo_size = -1,
+	.host_perio_tx_fifo_size = -1,
+	.max_transfer_size = -1,
+	.max_packet_count = -1,
+	.host_channels = -1,
+	.dev_endpoints = -1,
+	.phy_type = -1,
+	.phy_utmi_width = -1,
+	.phy_ulpi_ddr = -1,
+	.phy_ulpi_ext_vbus = -1,
+	.i2c_enable = -1,
+	.ulpi_fs_ls = -1,
+	.ts_dline = -1,
+};
+
+/**
+ * Global Debug Level Mask.
+ */
+uint32_t g_dbg_lvl;		/* 0 -> OFF */
+
+/**
+ * This function shows the Driver Version.
+ */
+static ssize_t version_show(struct device_driver *dev, char *buf)
+{
+	return snprintf(buf, sizeof(DWC_DRIVER_VERSION) + 2, "%s\n",
+			DWC_DRIVER_VERSION);
+}
+
+static DRIVER_ATTR(version, S_IRUGO, version_show, NULL);
+
+/**
+ * This function is called during module intialization to verify that
+ * the module parameters are in a valid state.
+ */
+static int check_parameters(struct dwc_otg_core_if *core_if)
+{
+	int i;
+	int retval = 0;
+
+/* Checks if the parameter is outside of its valid range of values */
+#define DWC_OTG_PARAM_TEST(_param_, _low_, _high_)    \
+	((dwc_otg_module_params._param_ < (_low_)) || \
+		(dwc_otg_module_params._param_ > (_high_)))
+
+/* If the parameter has been set by the user, check that the parameter value is
+ * within the value range of values.  If not, report a module error. */
+#define DWC_OTG_PARAM_ERR(_param_, _low_, _high_, _string_)	\
+	do {								\
+		if (dwc_otg_module_params._param_ != -1) {		\
+			if (DWC_OTG_PARAM_TEST(_param_, (_low_), (_high_))) { \
+				DWC_ERROR("`%d' invalid for parameter `%s'\n", \
+					dwc_otg_module_params._param_, _string_); \
+				dwc_otg_module_params._param_ = dwc_param_##_param_##_default; \
+				retval++; \
+			} \
+		} \
+	} while (0)
+
+	DWC_OTG_PARAM_ERR(opt, 0, 1, "opt");
+	DWC_OTG_PARAM_ERR(otg_cap, 0, 2, "otg_cap");
+	DWC_OTG_PARAM_ERR(dma_enable, 0, 1, "dma_enable");
+	DWC_OTG_PARAM_ERR(speed, 0, 1, "speed");
+	DWC_OTG_PARAM_ERR(host_support_fs_ls_low_power, 0, 1,
+			  "host_support_fs_ls_low_power");
+	DWC_OTG_PARAM_ERR(host_ls_low_power_phy_clk, 0, 1,
+			  "host_ls_low_power_phy_clk");
+	DWC_OTG_PARAM_ERR(enable_dynamic_fifo, 0, 1, "enable_dynamic_fifo");
+	DWC_OTG_PARAM_ERR(data_fifo_size, 32, 32768, "data_fifo_size");
+	DWC_OTG_PARAM_ERR(dev_rx_fifo_size, 16, 32768, "dev_rx_fifo_size");
+	DWC_OTG_PARAM_ERR(dev_nperio_tx_fifo_size, 16, 32768,
+			  "dev_nperio_tx_fifo_size");
+	DWC_OTG_PARAM_ERR(host_rx_fifo_size, 16, 32768, "host_rx_fifo_size");
+	DWC_OTG_PARAM_ERR(host_nperio_tx_fifo_size, 16, 32768,
+			  "host_nperio_tx_fifo_size");
+	DWC_OTG_PARAM_ERR(host_perio_tx_fifo_size, 16, 32768,
+			  "host_perio_tx_fifo_size");
+	DWC_OTG_PARAM_ERR(max_transfer_size, 2047, 524288, "max_transfer_size");
+	DWC_OTG_PARAM_ERR(max_packet_count, 15, 511, "max_packet_count");
+	DWC_OTG_PARAM_ERR(host_channels, 1, 16, "host_channels");
+	DWC_OTG_PARAM_ERR(dev_endpoints, 1, 15, "dev_endpoints");
+	DWC_OTG_PARAM_ERR(phy_type, 0, 2, "phy_type");
+	DWC_OTG_PARAM_ERR(phy_ulpi_ddr, 0, 1, "phy_ulpi_ddr");
+	DWC_OTG_PARAM_ERR(phy_ulpi_ext_vbus, 0, 1, "phy_ulpi_ext_vbus");
+	DWC_OTG_PARAM_ERR(i2c_enable, 0, 1, "i2c_enable");
+	DWC_OTG_PARAM_ERR(ulpi_fs_ls, 0, 1, "ulpi_fs_ls");
+	DWC_OTG_PARAM_ERR(ts_dline, 0, 1, "ts_dline");
+
+	if (dwc_otg_module_params.dma_burst_size != -1) {
+		if (DWC_OTG_PARAM_TEST(dma_burst_size, 1, 1) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 4, 4) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 8, 8) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 16, 16) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 32, 32) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 64, 64) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 128, 128) &&
+		    DWC_OTG_PARAM_TEST(dma_burst_size, 256, 256)) {
+			DWC_ERROR
+			    ("`%d' invalid for parameter `dma_burst_size'\n",
+			     dwc_otg_module_params.dma_burst_size);
+			dwc_otg_module_params.dma_burst_size = 32;
+			retval++;
+		}
+	}
+
+	if (dwc_otg_module_params.phy_utmi_width != -1) {
+		if (DWC_OTG_PARAM_TEST(phy_utmi_width, 8, 8) &&
+		    DWC_OTG_PARAM_TEST(phy_utmi_width, 16, 16)) {
+			DWC_ERROR
+			    ("`%d' invalid for parameter `phy_utmi_width'\n",
+			     dwc_otg_module_params.phy_utmi_width);
+			dwc_otg_module_params.phy_utmi_width = 16;
+			retval++;
+		}
+	}
+
+	for (i = 0; i < 15; i++) {
+		/* @todo should be like above */
+		if (dwc_otg_module_params.dev_perio_tx_fifo_size[i] !=
+		    (unsigned)-1) {
+			if (DWC_OTG_PARAM_TEST
+			    (dev_perio_tx_fifo_size[i], 4, 768)) {
+				DWC_ERROR
+				    ("`%d' invalid for parameter `%s_%d'\n",
+				     dwc_otg_module_params.
+				     dev_perio_tx_fifo_size[i],
+				     "dev_perio_tx_fifo_size", i);
+				dwc_otg_module_params.
+				    dev_perio_tx_fifo_size[i] =
+				    dwc_param_dev_perio_tx_fifo_size_default;
+				retval++;
+			}
+		}
+	}
+
+	/* At this point, all module parameters that have been set by the user
+	 * are valid, and those that have not are left unset.  Now set their
+	 * default values and/or check the parameters against the hardware
+	 * configurations of the OTG core. */
+
+/* This sets the parameter to the default value if it has not been set by the
+ * user */
+#define PARAM_SET_DEFAULT(_param_) \
+	({ \
+		int changed = 1; \
+		if (dwc_otg_module_params._param_ == -1) { \
+			changed = 0; \
+			dwc_otg_module_params._param_ = dwc_param_##_param_##_default; \
+		} \
+		changed; \
+	})
+
+/* This checks the macro agains the hardware configuration to see if it is
+ * valid.  It is possible that the default value could be invalid.  In this
+ * case, it will report a module error if the user touched the parameter.
+ * Otherwise it will adjust the value without any error. */
+#define PARAM_CHECK_VALID(_param_, _str_, _is_valid_, _set_valid_) \
+	({								\
+		int changed = PARAM_SET_DEFAULT(_param_);	\
+		int error = 0;						\
+		if (!(_is_valid_)) {					\
+			if (changed) {					\
+				DWC_ERROR("`%d' invalid for parameter `%s'.  Check HW configuration.\n", dwc_otg_module_params._param_, _str_); \
+				error = 1;				\
+			}						\
+			dwc_otg_module_params._param_ = (_set_valid_);	\
+		}							\
+		error;							\
+	})
+
+	/* OTG Cap */
+	retval += PARAM_CHECK_VALID(otg_cap, "otg_cap",
+		({
+			int valid;
+			valid = 1;
+			switch (dwc_otg_module_params.otg_cap) {
+			case DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE:
+				if (core_if->hwcfg2.b.op_mode != DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG)
+					valid = 0;
+				break;
+			case DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE:
+				if ((core_if->hwcfg2.b.op_mode != DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG)
+					&& (core_if->hwcfg2.b.op_mode != DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG)
+					&& (core_if->hwcfg2.b.op_mode != DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE)
+					&& (core_if->hwcfg2.b.op_mode != DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST))
+					valid = 0;
+				break;
+			case DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE:
+				/* always valid */
+				break;
+			}
+			valid;
+		}),
+		(((core_if->hwcfg2.b.op_mode == DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG)
+			|| (core_if->hwcfg2.b.op_mode == DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG)
+			|| (core_if->hwcfg2.b.op_mode == DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE)
+			|| (core_if->hwcfg2.b.op_mode == DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST))
+			?
+			DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE : DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE));
+
+	retval += PARAM_CHECK_VALID(dma_enable, "dma_enable",
+					((dwc_otg_module_params.
+						dma_enable == 1)
+						&& (core_if->hwcfg2.b.
+							architecture == 0)) ? 0 : 1,
+					0);
+
+	retval += PARAM_CHECK_VALID(opt, "opt", 1, 0);
+
+	PARAM_SET_DEFAULT(dma_burst_size);
+
+	retval += PARAM_CHECK_VALID(host_support_fs_ls_low_power,
+					    "host_support_fs_ls_low_power",
+					    1, 0);
+
+	retval += PARAM_CHECK_VALID(enable_dynamic_fifo,
+				    "enable_dynamic_fifo",
+				    ((dwc_otg_module_params.enable_dynamic_fifo == 0)
+				     || (core_if->hwcfg2.b.dynamic_fifo == 1)), 0);
+
+	retval += PARAM_CHECK_VALID(data_fifo_size,
+				    "data_fifo_size",
+				    dwc_otg_module_params.data_fifo_size <= core_if->hwcfg3.b.dfifo_depth,
+				    core_if->hwcfg3.b.dfifo_depth);
+
+	retval += PARAM_CHECK_VALID(dev_rx_fifo_size,
+				    "dev_rx_fifo_size",
+				    (dwc_otg_module_params.dev_rx_fifo_size <=
+					    dwc_read_reg32(&core_if->core_global_regs->grxfsiz)),
+				    dwc_read_reg32(&core_if->core_global_regs->grxfsiz));
+
+	retval += PARAM_CHECK_VALID(dev_nperio_tx_fifo_size,
+				    "dev_nperio_tx_fifo_size",
+				    dwc_otg_module_params.dev_nperio_tx_fifo_size <=
+					     (dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz) >> 16),
+				    dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz) >> 16);
+
+	retval += PARAM_CHECK_VALID(host_rx_fifo_size,
+				    "host_rx_fifo_size",
+				    dwc_otg_module_params.host_rx_fifo_size <=
+					dwc_read_reg32(&core_if->core_global_regs->grxfsiz),
+				    dwc_read_reg32(&core_if->core_global_regs->grxfsiz));
+
+	retval += PARAM_CHECK_VALID(host_nperio_tx_fifo_size,
+				    "host_nperio_tx_fifo_size",
+				    dwc_otg_module_params.host_nperio_tx_fifo_size <=
+					(dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz) >> 16),
+				    dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz) >> 16);
+
+	retval += PARAM_CHECK_VALID(host_perio_tx_fifo_size,
+				    "host_perio_tx_fifo_size",
+				    dwc_otg_module_params.host_perio_tx_fifo_size <=
+					(dwc_read_reg32(&core_if->core_global_regs->hptxfsiz) >> 16),
+				    (dwc_read_reg32(&core_if->core_global_regs->hptxfsiz) >> 16));
+
+	retval += PARAM_CHECK_VALID(max_transfer_size,
+				    "max_transfer_size",
+				    dwc_otg_module_params.max_transfer_size <
+					(1 << (core_if->hwcfg3.b.xfer_size_cntr_width + 11)),
+				    (1 << (core_if->hwcfg3.b.xfer_size_cntr_width + 11)) - 1);
+
+	retval += PARAM_CHECK_VALID(max_packet_count,
+				    "max_packet_count",
+				    dwc_otg_module_params.max_packet_count <
+					(1 << (core_if->hwcfg3.b.packet_size_cntr_width + 4)),
+				    (1 << (core_if->hwcfg3.b.packet_size_cntr_width + 4)) - 1);
+
+	retval += PARAM_CHECK_VALID(host_channels,
+				    "host_channels",
+				    dwc_otg_module_params.host_channels <= (core_if->hwcfg2.b.num_host_chan + 1),
+				    core_if->hwcfg2.b.num_host_chan + 1);
+
+	retval += PARAM_CHECK_VALID(dev_endpoints,
+				    "dev_endpoints",
+				    dwc_otg_module_params.dev_endpoints <= core_if->hwcfg2.b.num_dev_ep,
+				    core_if->hwcfg2.b.num_dev_ep);
+
+/*
+ * Define the following to disable the FS PHY Hardware checking.  This is for
+ * internal testing only.
+ *
+ * #define NO_FS_PHY_HW_CHECKS
+ */
+
+#ifdef NO_FS_PHY_HW_CHECKS
+	retval += PARAM_CHECK_VALID(phy_type, "phy_type", 1, 0);
+#else
+	retval += PARAM_CHECK_VALID(phy_type, "phy_type",
+		({
+			int valid = 0;
+			if ((dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_UTMI) && ((core_if->hwcfg2.b.hs_phy_type == 1) || (core_if->hwcfg2.b.hs_phy_type == 3)))
+				valid = 1;
+			else if ((dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_ULPI) && ((core_if->hwcfg2.b.hs_phy_type == 2) || (core_if->hwcfg2.b.hs_phy_type == 3)))
+				valid = 1;
+			else if ((dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_FS) && (core_if->hwcfg2.b.fs_phy_type == 1))
+				valid = 1;
+			valid;
+		}),
+		({
+			int set = DWC_PHY_TYPE_PARAM_FS;
+			if (core_if->hwcfg2.b.hs_phy_type) {
+				if ((core_if->hwcfg2.b.hs_phy_type == 3)
+					|| (core_if->hwcfg2.b.hs_phy_type == 1))
+					set = DWC_PHY_TYPE_PARAM_UTMI;
+				else
+					set = DWC_PHY_TYPE_PARAM_ULPI;
+			}
+			set;
+		}));
+#endif
+
+	retval += PARAM_CHECK_VALID(speed, "speed",
+				    dwc_otg_module_params.speed == 0
+				     && (dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_FS) ? 0 : 1,
+				    dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_FS ? 1 : 0);
+
+	retval += PARAM_CHECK_VALID(host_ls_low_power_phy_clk,
+				    "host_ls_low_power_phy_clk",
+				    dwc_otg_module_params.host_ls_low_power_phy_clk == DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ
+				     && (dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_FS) ? 0 : 1,
+				    (dwc_otg_module_params.phy_type == DWC_PHY_TYPE_PARAM_FS) ?
+					DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ : DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ);
+
+	PARAM_SET_DEFAULT(phy_ulpi_ddr);
+	PARAM_SET_DEFAULT(phy_ulpi_ext_vbus);
+	PARAM_SET_DEFAULT(phy_utmi_width);
+	PARAM_SET_DEFAULT(ulpi_fs_ls);
+	PARAM_SET_DEFAULT(ts_dline);
+
+#ifdef NO_FS_PHY_HW_CHECKS
+	retval += PARAM_CHECK_VALID(i2c_enable, "i2c_enable", 1, 0);
+#else
+	retval += PARAM_CHECK_VALID(i2c_enable, "i2c_enable",
+				    dwc_otg_module_params.i2c_enable == 1
+				     && (core_if->hwcfg3.b.i2c == 0) ? 0 : 1, 0);
+#endif
+
+	for (i = 0; i < 15; i++) {
+
+		int changed = 1;
+		int error = 0;
+
+		if (dwc_otg_module_params.dev_perio_tx_fifo_size[i] == -1) {
+			changed = 0;
+			dwc_otg_module_params.dev_perio_tx_fifo_size[i] =
+			    dwc_param_dev_perio_tx_fifo_size_default;
+		}
+		if (!
+		    (dwc_otg_module_params.dev_perio_tx_fifo_size[i] <=
+		     (dwc_read_reg32(&core_if->core_global_regs->dptxfsiz[i])))) {
+			if (changed) {
+				DWC_ERROR("`%d' invalid for parameter "
+					  "`dev_perio_fifo_size_%d'.  "
+					  "Check HW configuration.\n",
+				     dwc_otg_module_params.
+				     dev_perio_tx_fifo_size[i], i);
+				error = 1;
+			}
+			dwc_otg_module_params.dev_perio_tx_fifo_size[i] =
+			    dwc_read_reg32(&core_if->core_global_regs->
+					   dptxfsiz[i]);
+		}
+		retval += error;
+	}
+
+	return retval;
+}
+
+/**
+ * This function is the top level interrupt handler for the Common
+ * (Device and host modes) interrupts.
+ */
+static irqreturn_t dwc_otg_common_irq(int _irq, void *_dev)
+{
+	struct dwc_otg_device *otg_dev = _dev;
+	int32_t retval = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&otg_dev->hcd->global_lock, flags);
+
+	retval = dwc_otg_handle_common_intr(otg_dev->core_if);
+
+	spin_unlock_irqrestore(&otg_dev->hcd->global_lock, flags);
+
+	return IRQ_RETVAL(retval);
+}
+
+/**
+ * This function is called when a device is unregistered with the
+ * dwc_otg_driver. This happens, for example, when the rmmod command is
+ * executed. The device may or may not be electrically present. If it is
+ * present, the driver stops device processing. Any resources used on behalf
+ * of this device are freed.
+ *
+ * @dev:
+ */
+static int dwc_otg_driver_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_otg_device *otg_dev = dev->platform_data;
+	DWC_DEBUGPL(DBG_ANY, "%s(%p)\n", __func__, dev);
+
+	if (otg_dev == NULL)
+		/* Memory allocation for the dwc_otg_device failed. */
+		return -ENOMEM;
+
+	/*
+	 * Free the IRQ
+	 */
+	if (otg_dev->common_irq_installed)
+		free_irq(platform_get_irq(to_platform_device(dev), 0), otg_dev);
+
+#ifndef DWC_DEVICE_ONLY
+	if (otg_dev->hcd != NULL)
+		dwc_otg_hcd_remove(dev);
+#endif
+
+#ifndef DWC_HOST_ONLY
+	if (otg_dev->pcd != NULL)
+		dwc_otg_pcd_remove(dev);
+#endif
+	if (otg_dev->core_if != NULL)
+		dwc_otg_cil_remove(otg_dev->core_if);
+
+	/*
+	 * Remove the device attributes
+	 */
+	dwc_otg_attr_remove(dev);
+
+	/*
+	 * Clear the platform_data pointer.
+	 */
+	dev->platform_data = 0;
+	return 0;
+}
+
+/**
+ * This function is called when an device is bound to a
+ * dwc_otg_driver. It creates the driver components required to
+ * control the device (CIL, HCD, and PCD) and it initializes the
+ * device. The driver components are stored in a dwc_otg_device
+ * structure. A reference to the dwc_otg_device is saved in the
+ * device. This allows the driver to access the dwc_otg_device
+ * structure on subsequent calls to driver methods for this device.
+ *
+ * @dev:  device definition
+ */
+static __devinit int dwc_otg_driver_probe(struct platform_device *pdev)
+{
+	struct resource *res_base;
+	struct device *dev = &pdev->dev;
+	struct dwc_otg_device *dwc_otg_device;
+	int32_t snpsid;
+	unsigned long flags;
+	int irq;
+	int retval;
+
+	dev_dbg(dev, "dwc_otg_driver_probe(%p)\n", dev);
+
+	dwc_otg_device = devm_kzalloc(&pdev->dev,
+				      sizeof(struct dwc_otg_device),
+				      GFP_KERNEL);
+	if (!dwc_otg_device) {
+		dev_err(dev, "kmalloc of dwc_otg_device failed\n");
+		return -ENOMEM;
+	}
+	dwc_otg_device->reg_offset = 0xFFFFFFFF;
+
+	/*
+	 * Map the DWC_otg Core memory into virtual address space.
+	 */
+	res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_base)
+		goto err_ports;
+
+	dwc_otg_device->base =
+		devm_ioremap_nocache(&pdev->dev,
+				     res_base->start,
+				     res_base->end - res_base->start);
+
+	if (!dwc_otg_device->base)
+		goto err_ports;
+
+	dev_dbg(dev, "base=%p\n", dwc_otg_device->base);
+
+	/*
+	 * Attempt to ensure this device is really a DWC_otg Controller.
+	 * Read and verify the SNPSID register contents. The value should be
+	 * 0x45F42XXX, which corresponds to "OT2", as in "OTG version 2.XX".
+	 */
+	snpsid =
+	    dwc_read_reg32((uint32_t *) ((uint8_t *) dwc_otg_device->base +
+					 0x40));
+	if ((snpsid & 0xFFFFF000) != 0x4F542000) {
+		dev_err(dev, "Bad value for SNPSID: 0x%08x\n", snpsid);
+		goto err_ports;
+	}
+
+	/*
+	 * Initialize driver data to point to the global DWC_otg
+	 * Device structure.
+	 */
+	dev->platform_data = dwc_otg_device;
+	dev_dbg(dev, "dwc_otg_device=0x%p\n", dwc_otg_device);
+
+	dwc_otg_device->core_if = dwc_otg_cil_init(dwc_otg_device->base,
+						   &dwc_otg_module_params);
+	if (dwc_otg_device->core_if == 0) {
+		dev_err(dev, "CIL initialization failed!\n");
+		goto err_ports;
+	}
+	dwc_otg_device->core_if->usb_num = to_platform_device(dev)->id;
+
+	/*
+	 * Validate parameter values.
+	 */
+	if (check_parameters(dwc_otg_device->core_if) != 0)
+		goto err_ports;
+
+	/*
+	 * Create Device Attributes in sysfs
+	 */
+	dwc_otg_attr_create(dev);
+
+	/*
+	 * Disable the global interrupt until all the interrupt
+	 * handlers are installed.
+	 */
+	dwc_otg_disable_global_interrupts(dwc_otg_device->core_if);
+	/*
+	 * Install the interrupt handler for the common interrupts before
+	 * enabling common interrupts in core_init below.
+	 */
+	irq = platform_get_irq(to_platform_device(dev), 0);
+	DWC_DEBUGPL(DBG_CIL, "registering (common) handler for irq%d\n", irq);
+	retval = request_irq(irq, dwc_otg_common_irq,
+			     IRQF_SHARED, "dwc_otg", dwc_otg_device);
+	if (retval != 0) {
+		DWC_ERROR("request of irq%d failed\n", irq);
+		goto err_ports;
+	} else {
+		dwc_otg_device->common_irq_installed = 1;
+	}
+
+	/*
+	 * Initialize the DWC_otg core.
+	 */
+	dwc_otg_core_init(dwc_otg_device->core_if);
+
+#ifndef DWC_HOST_ONLY
+	/*
+	 * Initialize the PCD
+	 */
+	retval = dwc_otg_pcd_init(dev);
+	if (retval != 0) {
+		DWC_ERROR("dwc_otg_pcd_init failed\n");
+		dwc_otg_device->pcd = NULL;
+		goto err_ports;
+	}
+#endif
+#ifndef DWC_DEVICE_ONLY
+	/*
+	 * Initialize the HCD
+	 */
+	retval = dwc_otg_hcd_init(dev);
+	if (retval != 0) {
+		DWC_ERROR("dwc_otg_hcd_init failed\n");
+		dwc_otg_device->hcd = NULL;
+		goto err_ports;
+	}
+#endif
+
+	/*
+	 * Enable the global interrupt after all the interrupt
+	 * handlers are installed.
+	 */
+	local_irq_save(flags);
+	dwc_otg_enable_global_interrupts(dwc_otg_device->core_if);
+	local_irq_restore(flags);
+
+	return 0;
+
+err_ports:
+	devm_kfree(&pdev->dev, dwc_otg_device);
+	return -ENOENT;
+}
+
+/**
+ * This structure defines the methods to be called by a bus driver
+ * during the lifecycle of a device on that bus. Both drivers and
+ * devices are registered with a bus driver. The bus driver matches
+ * devices to drivers based on information in the device and driver
+ * structures.
+ *
+ * The probe function is called when the bus driver matches a device
+ * to this driver. The remove function is called when a device is
+ * unregistered with the bus driver.
+ */
+static struct platform_driver dwc_otg_driver = {
+	.probe = dwc_otg_driver_probe,
+	.remove = dwc_otg_driver_remove,
+	.driver = {
+		   .name = dwc_driver_name,
+		   .owner = THIS_MODULE},
+};
+
+/**
+ * This function is called when the dwc_otg_driver is installed with the
+ * insmod command. It registers the dwc_otg_driver structure with the
+ * appropriate bus driver. This will cause the dwc_otg_driver_probe function
+ * to be called. In addition, the bus driver will automatically expose
+ * attributes defined for the device and driver in the special sysfs file
+ * system.
+ *
+ * Returns
+ */
+static int __init dwc_otg_driver_init(void)
+{
+	int retval;
+
+	pr_info("%s: version %s\n", dwc_driver_name, DWC_DRIVER_VERSION);
+
+	/* Though core was configured for external dma override that with slave
+	   mode only for CN31XX. DMA is broken in this chip */
+	if (OCTEON_IS_MODEL(OCTEON_CN31XX))
+		dwc_otg_module_params.dma_enable = 0;
+
+	retval = platform_driver_register(&dwc_otg_driver);
+
+	if (retval < 0) {
+		pr_err("%s retval=%d\n", __func__, retval);
+		return retval;
+	}
+	if (driver_create_file(&dwc_otg_driver.driver, &driver_attr_version))
+		pr_warning("DWC_OTG: Failed to create driver version file\n");
+
+	return retval;
+}
+module_init(dwc_otg_driver_init);
+
+/**
+ * This function is called when the driver is removed from the kernel
+ * with the rmmod command. The driver unregisters itself with its bus
+ * driver.
+ *
+ */
+static void __exit dwc_otg_driver_cleanup(void)
+{
+	printk(KERN_DEBUG "dwc_otg_driver_cleanup()\n");
+
+	driver_remove_file(&dwc_otg_driver.driver, &driver_attr_version);
+
+	platform_driver_unregister(&dwc_otg_driver);
+
+	printk(KERN_INFO "%s module removed\n", dwc_driver_name);
+}
+module_exit(dwc_otg_driver_cleanup);
+
+MODULE_DESCRIPTION(DWC_DRIVER_DESC);
+MODULE_AUTHOR("Synopsys Inc.");
+MODULE_LICENSE("GPL");
+
+module_param_named(otg_cap, dwc_otg_module_params.otg_cap, int, 0444);
+MODULE_PARM_DESC(otg_cap, "OTG Capabilities 0=HNP&SRP 1=SRP Only 2=None");
+module_param_named(opt, dwc_otg_module_params.opt, int, 0444);
+MODULE_PARM_DESC(opt, "OPT Mode");
+module_param_named(dma_enable, dwc_otg_module_params.dma_enable, int, 0444);
+MODULE_PARM_DESC(dma_enable, "DMA Mode 0=Slave 1=DMA enabled");
+module_param_named(dma_burst_size, dwc_otg_module_params.dma_burst_size, int,
+		   0444);
+MODULE_PARM_DESC(dma_burst_size,
+		 "DMA Burst Size 1, 4, 8, 16, 32, 64, 128, 256");
+module_param_named(speed, dwc_otg_module_params.speed, int, 0444);
+MODULE_PARM_DESC(speed, "Speed 0=High Speed 1=Full Speed");
+module_param_named(host_support_fs_ls_low_power,
+		   dwc_otg_module_params.host_support_fs_ls_low_power, int,
+		   0444);
+MODULE_PARM_DESC(host_support_fs_ls_low_power,
+		 "Support Low Power w/FS or LS 0=Support 1=Don't Support");
+module_param_named(host_ls_low_power_phy_clk,
+		   dwc_otg_module_params.host_ls_low_power_phy_clk, int, 0444);
+MODULE_PARM_DESC(host_ls_low_power_phy_clk,
+		 "Low Speed Low Power Clock 0=48Mhz 1=6Mhz");
+module_param_named(enable_dynamic_fifo,
+		   dwc_otg_module_params.enable_dynamic_fifo, int, 0444);
+MODULE_PARM_DESC(enable_dynamic_fifo, "0=cC Setting 1=Allow Dynamic Sizing");
+module_param_named(data_fifo_size, dwc_otg_module_params.data_fifo_size, int,
+		   0444);
+MODULE_PARM_DESC(data_fifo_size,
+		 "Total number of words in the data FIFO memory 32-32768");
+module_param_named(dev_rx_fifo_size, dwc_otg_module_params.dev_rx_fifo_size,
+		   int, 0444);
+MODULE_PARM_DESC(dev_rx_fifo_size, "Number of words in the Rx FIFO 16-32768");
+module_param_named(dev_nperio_tx_fifo_size,
+		   dwc_otg_module_params.dev_nperio_tx_fifo_size, int, 0444);
+MODULE_PARM_DESC(dev_nperio_tx_fifo_size,
+		 "Number of words in the non-periodic Tx FIFO 16-32768");
+module_param_named(dev_perio_tx_fifo_size_1,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[0], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_1,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_2,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[1], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_2,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_3,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[2], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_3,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_4,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[3], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_4,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_5,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[4], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_5,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_6,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[5], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_6,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_7,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[6], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_7,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_8,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[7], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_8,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_9,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[8], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_9,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_10,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[9], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_10,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_11,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[10], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_11,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_12,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[11], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_12,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_13,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[12], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_13,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_14,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[13], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_14,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_15,
+		   dwc_otg_module_params.dev_perio_tx_fifo_size[14], int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_15,
+		 "Number of words in the periodic Tx FIFO 4-768");
+module_param_named(host_rx_fifo_size, dwc_otg_module_params.host_rx_fifo_size,
+		   int, 0444);
+MODULE_PARM_DESC(host_rx_fifo_size, "Number of words in the Rx FIFO 16-32768");
+module_param_named(host_nperio_tx_fifo_size,
+		   dwc_otg_module_params.host_nperio_tx_fifo_size, int, 0444);
+MODULE_PARM_DESC(host_nperio_tx_fifo_size,
+		 "Number of words in the non-periodic Tx FIFO 16-32768");
+module_param_named(host_perio_tx_fifo_size,
+		   dwc_otg_module_params.host_perio_tx_fifo_size, int, 0444);
+MODULE_PARM_DESC(host_perio_tx_fifo_size,
+		 "Number of words in the host periodic Tx FIFO 16-32768");
+module_param_named(max_transfer_size, dwc_otg_module_params.max_transfer_size,
+		   int, 0444);
+/** @todo Set the max to 512K, modify checks */
+MODULE_PARM_DESC(max_transfer_size,
+		 "The maximum transfer size supported in bytes 2047-65535");
+module_param_named(max_packet_count, dwc_otg_module_params.max_packet_count,
+		   int, 0444);
+MODULE_PARM_DESC(max_packet_count,
+		 "The maximum number of packets in a transfer 15-511");
+module_param_named(host_channels, dwc_otg_module_params.host_channels, int,
+		   0444);
+MODULE_PARM_DESC(host_channels,
+		 "The number of host channel registers to use 1-16");
+module_param_named(dev_endpoints, dwc_otg_module_params.dev_endpoints, int,
+		   0444);
+MODULE_PARM_DESC(dev_endpoints,
+		 "The number of endpoints in addition to EP0 available "
+		 "for device mode 1-15");
+module_param_named(phy_type, dwc_otg_module_params.phy_type, int, 0444);
+MODULE_PARM_DESC(phy_type, "0=Reserved 1=UTMI+ 2=ULPI");
+module_param_named(phy_utmi_width, dwc_otg_module_params.phy_utmi_width, int,
+		   0444);
+MODULE_PARM_DESC(phy_utmi_width, "Specifies the UTMI+ Data Width 8 or 16 bits");
+module_param_named(phy_ulpi_ddr, dwc_otg_module_params.phy_ulpi_ddr, int, 0444);
+MODULE_PARM_DESC(phy_ulpi_ddr,
+		 "ULPI at double or single data rate 0=Single 1=Double");
+module_param_named(phy_ulpi_ext_vbus, dwc_otg_module_params.phy_ulpi_ext_vbus,
+		   int, 0444);
+MODULE_PARM_DESC(phy_ulpi_ext_vbus,
+		 "ULPI PHY using internal or external vbus 0=Internal");
+module_param_named(i2c_enable, dwc_otg_module_params.i2c_enable, int, 0444);
+MODULE_PARM_DESC(i2c_enable, "FS PHY Interface");
+module_param_named(ulpi_fs_ls, dwc_otg_module_params.ulpi_fs_ls, int, 0444);
+MODULE_PARM_DESC(ulpi_fs_ls, "ULPI PHY FS/LS mode only");
+module_param_named(ts_dline, dwc_otg_module_params.ts_dline, int, 0444);
+MODULE_PARM_DESC(ts_dline, "Term select Dline pulsing for all PHYs");
+module_param_named(debug, g_dbg_lvl, int, 0644);
+MODULE_PARM_DESC(debug, "");
+
+/** @page "Module Parameters"
+ *
+ * The following parameters may be specified when starting the module.
+ * These parameters define how the DWC_otg controller should be
+ * configured.  Parameter values are passed to the CIL initialization
+ * function dwc_otg_cil_init
+ *
+ * Example: <code>modprobe dwc_otg speed=1 otg_cap=1</code>
+ *
+
+ <table>
+ <tr><td>Parameter Name</td><td>Meaning</td></tr>
+
+ <tr>
+ <td>otg_cap</td>
+ <td>Specifies the OTG capabilities. The driver will automatically detect the
+ value for this parameter if none is specified.
+ - 0: HNP and SRP capable (default, if available)
+ - 1: SRP Only capable
+ - 2: No HNP/SRP capable
+ </td></tr>
+
+ <tr>
+ <td>dma_enable</td>
+ <td>Specifies whether to use slave or DMA mode for accessing the data FIFOs.
+ The driver will automatically detect the value for this parameter if none is
+ specified.
+ - 0: Slave
+ - 1: DMA (default, if available)
+ </td></tr>
+
+ <tr>
+ <td>dma_burst_size</td>
+ <td>The DMA Burst size (applicable only for External DMA Mode).
+ - Values: 1, 4, 8 16, 32, 64, 128, 256 (default 32)
+ </td></tr>
+
+ <tr>
+ <td>speed</td>
+ <td>Specifies the maximum speed of operation in host and device mode. The
+ actual speed depends on the speed of the attached device and the value of
+ phy_type.
+ - 0: High Speed (default)
+ - 1: Full Speed
+ </td></tr>
+
+ <tr>
+ <td>host_support_fs_ls_low_power</td>
+ <td>Specifies whether low power mode is supported when attached to a Full
+ Speed or Low Speed device in host mode.
+ - 0: Don't support low power mode (default)
+ - 1: Support low power mode
+ </td></tr>
+
+ <tr>
+ <td>host_ls_low_power_phy_clk</td>
+ <td>Specifies the PHY clock rate in low power mode when connected to a Low
+ Speed device in host mode. This parameter is applicable only if
+ HOST_SUPPORT_FS_LS_LOW_POWER is enabled.
+ - 0: 48 MHz (default)
+ - 1: 6 MHz
+ </td></tr>
+
+ <tr>
+ <td>enable_dynamic_fifo</td>
+ <td> Specifies whether FIFOs may be resized by the driver software.
+ - 0: Use cC FIFO size parameters
+ - 1: Allow dynamic FIFO sizing (default)
+ </td></tr>
+
+ <tr>
+ <td>data_fifo_size</td>
+ <td>Total number of 4-byte words in the data FIFO memory. This memory
+ includes the Rx FIFO, non-periodic Tx FIFO, and periodic Tx FIFOs.
+ - Values: 32 to 32768 (default 8192)
+
+ Note: The total FIFO memory depth in the FPGA configuration is 8192.
+ </td></tr>
+
+ <tr>
+ <td>dev_rx_fifo_size</td>
+ <td>Number of 4-byte words in the Rx FIFO in device mode when dynamic
+ FIFO sizing is enabled.
+ - Values: 16 to 32768 (default 1064)
+ </td></tr>
+
+ <tr>
+ <td>dev_nperio_tx_fifo_size</td>
+ <td>Number of 4-byte words in the non-periodic Tx FIFO in device mode when
+ dynamic FIFO sizing is enabled.
+ - Values: 16 to 32768 (default 1024)
+ </td></tr>
+
+ <tr>
+ <td>dev_perio_tx_fifo_size_n (n = 1 to 15)</td>
+ <td>Number of 4-byte words in each of the periodic Tx FIFOs in device mode
+ when dynamic FIFO sizing is enabled.
+ - Values: 4 to 768 (default 256)
+ </td></tr>
+
+ <tr>
+ <td>host_rx_fifo_size</td>
+ <td>Number of 4-byte words in the Rx FIFO in host mode when dynamic FIFO
+ sizing is enabled.
+ - Values: 16 to 32768 (default 1024)
+ </td></tr>
+
+ <tr>
+ <td>host_nperio_tx_fifo_size</td>
+ <td>Number of 4-byte words in the non-periodic Tx FIFO in host mode when
+ dynamic FIFO sizing is enabled in the core.
+ - Values: 16 to 32768 (default 1024)
+ </td></tr>
+
+ <tr>
+ <td>host_perio_tx_fifo_size</td>
+ <td>Number of 4-byte words in the host periodic Tx FIFO when dynamic FIFO
+ sizing is enabled.
+ - Values: 16 to 32768 (default 1024)
+ </td></tr>
+
+ <tr>
+ <td>max_transfer_size</td>
+ <td>The maximum transfer size supported in bytes.
+ - Values: 2047 to 65,535 (default 65,535)
+ </td></tr>
+
+ <tr>
+ <td>max_packet_count</td>
+ <td>The maximum number of packets in a transfer.
+ - Values: 15 to 511 (default 511)
+ </td></tr>
+
+ <tr>
+ <td>host_channels</td>
+ <td>The number of host channel registers to use.
+ - Values: 1 to 16 (default 12)
+
+ Note: The FPGA configuration supports a maximum of 12 host channels.
+ </td></tr>
+
+ <tr>
+ <td>dev_endpoints</td>
+ <td>The number of endpoints in addition to EP0 available for device mode
+ operations.
+ - Values: 1 to 15 (default 6 IN and OUT)
+
+ Note: The FPGA configuration supports a maximum of 6 IN and OUT endpoints in
+ addition to EP0.
+ </td></tr>
+
+ <tr>
+ <td>phy_type</td>
+ <td>Specifies the type of PHY interface to use. By default, the driver will
+ automatically detect the phy_type.
+ - 0: Full Speed
+ - 1: UTMI+ (default, if available)
+ - 2: ULPI
+ </td></tr>
+
+ <tr>
+ <td>phy_utmi_width</td>
+ <td>Specifies the UTMI+ Data Width. This parameter is applicable for a
+ phy_type of UTMI+. Also, this parameter is applicable only if the
+ OTG_HSPHY_WIDTH cC parameter was set to "8 and 16 bits", meaning that the
+ core has been configured to work at either data path width.
+ - Values: 8 or 16 bits (default 16)
+ </td></tr>
+
+ <tr>
+ <td>phy_ulpi_ddr</td>
+ <td>Specifies whether the ULPI operates at double or single data rate. This
+ parameter is only applicable if phy_type is ULPI.
+ - 0: single data rate ULPI interface with 8 bit wide data bus (default)
+ - 1: double data rate ULPI interface with 4 bit wide data bus
+ </td></tr>
+
+ <tr>
+ <td>i2c_enable</td>
+ <td>Specifies whether to use the I2C interface for full speed PHY. This
+ parameter is only applicable if PHY_TYPE is FS.
+ - 0: Disabled (default)
+ - 1: Enabled
+ </td></tr>
+
+*/
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_plat.h b/drivers/usb/host/dwc_otg/dwc_otg_plat.h
new file mode 100644
index 0000000..93ef282
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_plat.h
@@ -0,0 +1,236 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+#if !defined(__DWC_OTG_PLAT_H__)
+#define __DWC_OTG_PLAT_H__
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-usbnx-defs.h>
+
+#define SZ_256K 0x00040000
+#ifndef CONFIG_64BIT
+#define OCTEON_USB_BASE_ADDRESS 0x80016F0010000000ull
+#endif
+
+/**
+ * @file
+ *
+ * This file contains the Platform Specific constants, interfaces
+ * (functions and macros) for Linux.
+ *
+ */
+
+/**
+ * Reads the content of a register.
+ *
+ * @_reg: address of register to read.
+ * Returns contents of the register.
+ *
+
+ * Usage:<br>
+ * <code>uint32_t dev_ctl = dwc_read_reg32(&dev_regs->dctl);</code>
+ */
+static inline uint32_t dwc_read_reg32(uint32_t *_reg)
+{
+	uint32_t result;
+	/* USB device registers on Octeon are 32bit address swapped */
+#ifdef CONFIG_64BIT
+	uint64_t address = (unsigned long)_reg ^ 4;
+#else
+	uint64_t address = OCTEON_USB_BASE_ADDRESS | ((unsigned long)_reg ^ 4);
+#endif
+	result = cvmx_read64_uint32(address);
+	return result;
+};
+
+/**
+ * Writes a register with a 32 bit value.
+ *
+ * @_reg: address of register to read.
+ * @_value: to write to _reg.
+ *
+ * Usage:<br>
+ * <code>dwc_write_reg32(&dev_regs->dctl, 0); </code>
+ */
+static inline void dwc_write_reg32(uint32_t *_reg,
+				   const uint32_t _value)
+{
+	/* USB device registers on Octeon are 32bit address swapped */
+#ifdef CONFIG_64BIT
+	uint64_t address = (unsigned long)_reg ^ 4;
+#else
+	uint64_t address = OCTEON_USB_BASE_ADDRESS | ((unsigned long)_reg ^ 4);
+#endif
+	wmb();
+	cvmx_write64_uint32(address, _value);
+
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	/* O2P/O1P pass 1 bug workaround: A read must occur for at least
+	   every 3rd write to insure that the writes do not overrun the
+	   USBN. */
+	if (OCTEON_IS_MODEL(OCTEON_CN31XX) || OCTEON_IS_MODEL(OCTEON_CN30XX)) {
+		extern int dwc_errata_write_count;
+		if (++dwc_errata_write_count > 2) {
+			cvmx_read_csr(CVMX_USBNX_DMA0_INB_CHN0(0));
+			dwc_errata_write_count = 0;
+		}
+	}
+#endif
+};
+
+/**
+ * This function modifies bit values in a register.  Using the
+ * algorithm: (reg_contents & ~clear_mask) | set_mask.
+ *
+ * @_reg: address of register to read.
+ * @_clear_mask: bit mask to be cleared.
+ * @_set_mask: bit mask to be set.
+ *
+ * Usage:<br>
+ * <code> // Clear the SOF Interrupt Mask bit and <br>
+ * // set the OTG Interrupt mask bit, leaving all others as they were.
+ *    dwc_modify_reg32(&dev_regs->gintmsk, DWC_SOF_INT, DWC_OTG_INT);</code>
+ */
+static inline void dwc_modify_reg32(uint32_t *_reg,
+				    const uint32_t _clear_mask,
+				    const uint32_t _set_mask)
+{
+	uint32_t value = dwc_read_reg32(_reg);
+	value &= ~_clear_mask;
+	value |= _set_mask;
+	dwc_write_reg32(_reg, value);
+};
+
+/*
+ * Debugging support vanishes in non-debug builds.
+ */
+
+/**
+ * The Debug Level bit-mask variable.
+ */
+extern uint32_t g_dbg_lvl;
+/**
+ * Set the Debug Level variable.
+ */
+static inline uint32_t SET_DEBUG_LEVEL(const uint32_t _new)
+{
+	uint32_t old = g_dbg_lvl;
+	g_dbg_lvl = _new;
+	return old;
+}
+
+/** When debug level has the DBG_CIL bit set, display CIL Debug messages. */
+#define DBG_CIL		(0x2)
+/** When debug level has the DBG_CILV bit set, display CIL Verbose debug
+ * messages */
+#define DBG_CILV	(0x20)
+/**  When debug level has the DBG_PCD bit set, display PCD (Device) debug
+ *  messages */
+#define DBG_PCD		(0x4)
+/** When debug level has the DBG_PCDV set, display PCD (Device) Verbose debug
+ * messages */
+#define DBG_PCDV	(0x40)
+/** When debug level has the DBG_HCD bit set, display Host debug messages */
+#define DBG_HCD		(0x8)
+/** When debug level has the DBG_HCDV bit set, display Verbose Host debug
+ * messages */
+#define DBG_HCDV	(0x80)
+/** When debug level has the DBG_HCD_URB bit set, display enqueued URBs in host
+ *  mode. */
+#define DBG_HCD_URB	(0x800)
+
+/** When debug level has any bit set, display debug messages */
+#define DBG_ANY		(0xFF)
+
+/** All debug messages off */
+#define DBG_OFF		0
+
+/** Prefix string for DWC_DEBUG print macros. */
+#define USB_DWC "DWC_otg: "
+
+/**
+ * Print a debug message when the Global debug level variable contains
+ * the bit defined in <code>lvl</code>.
+ *
+ * @lvl: - Debug level, use one of the DBG_ constants above.
+ * @x: - like printf
+ *
+ *    Example:<p>
+ * <code>
+ *      DWC_DEBUGPL( DBG_ANY, "%s(%p)\n", __func__, _reg_base_addr);
+ * </code>
+ * <br>
+ * results in:<br>
+ * <code>
+ * usb-DWC_otg: dwc_otg_cil_init(ca867000)
+ * </code>
+ */
+#ifdef DEBUG
+
+# define DWC_DEBUGPL(lvl, x...)						\
+	do {								\
+		if ((lvl)&g_dbg_lvl)					\
+			printk(KERN_DEBUG USB_DWC x);			\
+	} while (0)
+# define DWC_DEBUGP(x...)	DWC_DEBUGPL(DBG_ANY, x)
+
+# define CHK_DEBUG_LEVEL(level) ((level) & g_dbg_lvl)
+
+#else
+
+# define DWC_DEBUGPL(lvl, x...) do { } while (0)
+# define DWC_DEBUGP(x...)
+
+# define CHK_DEBUG_LEVEL(level) (0)
+
+#endif /*DEBUG*/
+/*
+ * Print an Error message.
+ */
+#define DWC_ERROR(x...) printk(KERN_ERR USB_DWC x)
+/*
+ * Print a Warning message.
+ */
+#define DWC_WARN(x...) printk(KERN_WARNING USB_DWC x)
+/*
+ * Print a notice (normal but significant message).
+ */
+#define DWC_NOTICE(x...) printk(KERN_NOTICE USB_DWC x)
+/*
+ *  Basic message printing.
+ */
+#define DWC_PRINT(x...) printk(KERN_INFO USB_DWC x)
+#endif
diff --git a/drivers/usb/host/dwc_otg/dwc_otg_regs.h b/drivers/usb/host/dwc_otg/dwc_otg_regs.h
new file mode 100644
index 0000000..34cc4f7
--- /dev/null
+++ b/drivers/usb/host/dwc_otg/dwc_otg_regs.h
@@ -0,0 +1,2355 @@
+/* ==========================================================================
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ * ========================================================================== */
+
+#ifndef __DWC_OTG_REGS_H__
+#define __DWC_OTG_REGS_H__
+
+/*
+ *
+ * This file contains the data structures for accessing the DWC_otg
+ * core registers.
+ *
+ * The application interfaces with the HS OTG core by reading from and
+ * writing to the Control and Status Register (CSR) space through the
+ * AHB Slave interface. These registers are 32 bits wide, and the
+ * addresses are 32-bit-block aligned.
+ * CSRs are classified as follows:
+ * - Core Global Registers
+ * - Device Mode Registers
+ * - Device Global Registers
+ * - Device Endpoint Specific Registers
+ * - Host Mode Registers
+ * - Host Global Registers
+ * - Host Port CSRs
+ * - Host Channel Specific Registers
+ *
+ * Only the Core Global registers can be accessed in both Device and
+ * Host modes. When the HS OTG core is operating in one mode, either
+ * Device or Host, the application must not access registers from the
+ * other mode. When the core switches from one mode to another, the
+ * registers in the new mode of operation must be reprogrammed as they
+ * would be after a power-on reset.
+ */
+
+/****************************************************************************/
+/* DWC_otg Core registers .
+ * The dwc_otg_core_global_regs structure defines the size
+ * and relative field offsets for the Core Global registers.
+ */
+struct dwc_otg_core_global_regs {
+	/* OTG Control and Status Register.  Offset: 000h */
+	uint32_t gotgctl;
+	/* OTG Interrupt Register.  Offset: 004h */
+	uint32_t gotgint;
+	/* Core AHB Configuration Register.  Offset: 008h */
+	uint32_t gahbcfg;
+#define DWC_GLBINTRMASK 	0x0001
+#define DWC_DMAENABLE   	0x0020
+#define DWC_NPTXEMPTYLVL_EMPTY 	0x0080
+#define DWC_NPTXEMPTYLVL_HALFEMPTY 	0x0000
+#define DWC_PTXEMPTYLVL_EMPTY 	0x0100
+#define DWC_PTXEMPTYLVL_HALFEMPTY 	0x0000
+
+	/* Core USB Configuration Register.  Offset: 00Ch */
+	uint32_t gusbcfg;
+	/* Core Reset Register.  Offset: 010h */
+	uint32_t grstctl;
+	/* Core Interrupt Register.  Offset: 014h */
+	uint32_t gintsts;
+	/* Core Interrupt Mask Register.  Offset: 018h */
+	uint32_t gintmsk;
+	/* Receive Status Queue Read Register (Read Only).  Offset: 01Ch */
+	uint32_t grxstsr;
+	/* Receive Status Queue Read & POP Register (Read Only).  Offset: 020h*/
+	uint32_t grxstsp;
+	/* Receive FIFO Size Register.  Offset: 024h */
+	uint32_t grxfsiz;
+	/* Non Periodic Transmit FIFO Size Register.  Offset: 028h */
+	uint32_t gnptxfsiz;
+	/*
+	 *Non Periodic Transmit FIFO/Queue Status Register (Read
+	 * Only). Offset: 02Ch
+	 */
+	uint32_t gnptxsts;
+	/* I2C Access Register.  Offset: 030h */
+	uint32_t gi2cctl;
+	/* PHY Vendor Control Register.  Offset: 034h */
+	uint32_t gpvndctl;
+	/* General Purpose Input/Output Register.  Offset: 038h */
+	uint32_t ggpio;
+	/* User ID Register.  Offset: 03Ch */
+	uint32_t guid;
+	/* Synopsys ID Register (Read Only).  Offset: 040h */
+	uint32_t gsnpsid;
+	/* User HW Config1 Register (Read Only).  Offset: 044h */
+	uint32_t ghwcfg1;
+	/* User HW Config2 Register (Read Only).  Offset: 048h */
+	uint32_t ghwcfg2;
+#define DWC_SLAVE_ONLY_ARCH 0
+#define DWC_EXT_DMA_ARCH 1
+#define DWC_INT_DMA_ARCH 2
+
+#define DWC_MODE_HNP_SRP_CAPABLE 	0
+#define DWC_MODE_SRP_ONLY_CAPABLE 	1
+#define DWC_MODE_NO_HNP_SRP_CAPABLE 	2
+#define DWC_MODE_SRP_CAPABLE_DEVICE 	3
+#define DWC_MODE_NO_SRP_CAPABLE_DEVICE  4
+#define DWC_MODE_SRP_CAPABLE_HOST 	5
+#define DWC_MODE_NO_SRP_CAPABLE_HOST  	6
+
+	/* User HW Config3 Register (Read Only).  Offset: 04Ch */
+	uint32_t ghwcfg3;
+	/* User HW Config4 Register (Read Only).  Offset: 050h*/
+	uint32_t ghwcfg4;
+	/* Reserved  Offset: 054h-0FFh */
+	uint32_t reserved[43];
+	/* Host Periodic Transmit FIFO Size Register. Offset: 100h */
+	uint32_t hptxfsiz;
+	/*
+	 * Device Periodic Transmit FIFO#n Register.
+	 * Offset: 104h + (FIFO_Number-1)*04h,
+	 * 1 <= FIFO Number <= 15 (1<=n<=15).
+	 */
+	uint32_t dptxfsiz[15];
+};
+
+/*
+ * This union represents the bit fields of the Core OTG Control
+ * and Status Register (GOTGCTL).  Set the bits using the bit
+ * fields then write the d32 value to the register.
+ */
+union gotgctl_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved21_31:11;
+		unsigned currmod:1;
+		unsigned bsesvld:1;
+		unsigned asesvld:1;
+		unsigned reserved17:1;
+		unsigned conidsts:1;
+		unsigned reserved12_15:4;
+		unsigned devhnpen:1;
+		unsigned hstsethnpen:1;
+		unsigned hnpreq:1;
+		unsigned hstnegscs:1;
+		unsigned reserved2_7:6;
+		unsigned sesreq:1;
+		unsigned sesreqscs:1;
+#else
+		unsigned sesreqscs:1;
+		unsigned sesreq:1;
+		unsigned reserved2_7:6;
+		unsigned hstnegscs:1;
+		unsigned hnpreq:1;
+		unsigned hstsethnpen:1;
+		unsigned devhnpen:1;
+		unsigned reserved12_15:4;
+		unsigned conidsts:1;
+		unsigned reserved17:1;
+		unsigned asesvld:1;
+		unsigned bsesvld:1;
+		unsigned currmod:1;
+		unsigned reserved21_31:11;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core OTG Interrupt Register
+ * (GOTGINT).  Set/clear the bits using the bit fields then write the d32
+ * value to the register.
+ */
+union gotgint_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved31_20:12;
+		unsigned debdone:1;
+		unsigned adevtoutchng:1;
+		unsigned hstnegdet:1;
+		unsigned reserver10_16:7;
+		unsigned hstnegsucstschng:1;
+		unsigned sesreqsucstschng:1;
+		unsigned reserved3_7:5;
+		unsigned sesenddet:1;
+		unsigned reserved0_1:2;
+#else
+
+		/* Current Mode */
+		unsigned reserved0_1:2;
+
+		/* Session End Detected */
+		unsigned sesenddet:1;
+
+		unsigned reserved3_7:5;
+
+		/* Session Request Success Status Change */
+		unsigned sesreqsucstschng:1;
+		/* Host Negotiation Success Status Change */
+		unsigned hstnegsucstschng:1;
+
+		unsigned reserver10_16:7;
+
+		/* Host Negotiation Detected */
+		unsigned hstnegdet:1;
+		/* A-Device Timeout Change */
+		unsigned adevtoutchng:1;
+		/* Debounce Done */
+		unsigned debdone:1;
+
+		unsigned reserved31_20:12;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core AHB Configuration
+ * Register (GAHBCFG).  Set/clear the bits using the bit fields then
+ * write the d32 value to the register.
+ */
+union gahbcfg_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY	0
+#define DWC_GAHBCFG_TXFEMPTYLVL_EMPTY 		1
+#define DWC_GAHBCFG_DMAENABLE   		1
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR16 	7
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR8 	5
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR4 	3
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR 		1
+#define DWC_GAHBCFG_INT_DMA_BURST_SINGLE 	0
+#define DWC_GAHBCFG_GLBINT_ENABLE 		1
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved9_31:23;
+		unsigned ptxfemplvl:1;
+		unsigned nptxfemplvl:1;
+		unsigned reserved:1;
+		unsigned dmaenable:1;
+		unsigned hburstlen:4;
+		unsigned glblintrmsk:1;
+#else
+		unsigned glblintrmsk:1;
+		unsigned hburstlen:4;
+		unsigned dmaenable:1;
+		unsigned reserved:1;
+		unsigned nptxfemplvl:1;
+		unsigned ptxfemplvl:1;
+		unsigned reserved9_31:23;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core USB Configuration
+ * Register (GUSBCFG).  Set the bits using the bit fields then write
+ * the d32 value to the register.
+ */
+union gusbcfg_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:9;
+		unsigned term_sel_dl_pulse:1;
+		unsigned ulpi_int_vbus_indicator:1;
+		unsigned ulpi_ext_vbus_drv:1;
+		unsigned ulpi_clk_sus_m:1;
+		unsigned ulpi_auto_res:1;
+		unsigned ulpi_fsls:1;
+		unsigned otgutmifssel:1;
+		unsigned phylpwrclksel:1;
+		unsigned nptxfrwnden:1;
+		unsigned usbtrdtim:4;
+		unsigned hnpcap:1;
+		unsigned srpcap:1;
+		unsigned ddrsel:1;
+		unsigned physel:1;
+		unsigned fsintf:1;
+		unsigned ulpi_utmi_sel:1;
+		unsigned phyif:1;
+		unsigned toutcal:3;
+#else
+		unsigned toutcal:3;
+		unsigned phyif:1;
+		unsigned ulpi_utmi_sel:1;
+		unsigned fsintf:1;
+		unsigned physel:1;
+		unsigned ddrsel:1;
+		unsigned srpcap:1;
+		unsigned hnpcap:1;
+		unsigned usbtrdtim:4;
+		unsigned nptxfrwnden:1;
+		unsigned phylpwrclksel:1;
+		unsigned otgutmifssel:1;
+		unsigned ulpi_fsls:1;
+		unsigned ulpi_auto_res:1;
+		unsigned ulpi_clk_sus_m:1;
+		unsigned ulpi_ext_vbus_drv:1;
+		unsigned ulpi_int_vbus_indicator:1;
+		unsigned term_sel_dl_pulse:1;
+		unsigned reserved:9;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Reset Register
+ * (GRSTCTL).  Set/clear the bits using the bit fields then write the
+ * d32 value to the register.
+ */
+union grstctl_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned ahbidle:1;
+		unsigned dmareq:1;
+		unsigned reserved11_29:19;
+		unsigned txfnum:5;
+		unsigned txfflsh:1;
+		unsigned rxfflsh:1;
+		unsigned intknqflsh:1;
+		unsigned hstfrm:1;
+		unsigned hsftrst:1;
+		unsigned csftrst:1;
+#else
+
+		/*
+		 * Core Soft Reset (CSftRst) (Device and Host)
+		 *
+		 * The application can flush the control logic in the
+		 * entire core using this bit. This bit resets the
+		 * pipelines in the AHB Clock domain as well as the
+		 * PHY Clock domain.
+		 *
+		 * The state machines are reset to an IDLE state, the
+		 * control bits in the CSRs are cleared, all the
+		 * transmit FIFOs and the receive FIFO are flushed.
+		 *
+		 * The status mask bits that control the generation of
+		 * the interrupt, are cleared, to clear the
+		 * interrupt. The interrupt status bits are not
+		 * cleared, so the application can get the status of
+		 * any events that occurred in the core after it has
+		 * set this bit.
+		 *
+		 * Any transactions on the AHB are terminated as soon
+		 * as possible following the protocol. Any
+		 * transactions on the USB are terminated immediately.
+		 *
+		 * The configuration settings in the CSRs are
+		 * unchanged, so the software doesn't have to
+		 * reprogram these registers (Device
+		 * Configuration/Host Configuration/Core System
+		 * Configuration/Core PHY Configuration).
+		 *
+		 * The application can write to this bit, any time it
+		 * wants to reset the core. This is a self clearing
+		 * bit and the core clears this bit after all the
+		 * necessary logic is reset in the core, which may
+		 * take several clocks, depending on the current state
+		 * of the core.
+		 */
+		unsigned csftrst:1;
+		/*
+		 * Hclk Soft Reset
+		 *
+		 * The application uses this bit to reset the control logic in
+		 * the AHB clock domain. Only AHB clock domain pipelines are
+		 * reset.
+		 */
+		unsigned hsftrst:1;
+		/*
+		 * Host Frame Counter Reset (Host Only)<br>
+		 *
+		 * The application can reset the (micro)frame number
+		 * counter inside the core, using this bit. When the
+		 * (micro)frame counter is reset, the subsequent SOF
+		 * sent out by the core, will have a (micro)frame
+		 * number of 0.
+		 */
+		unsigned hstfrm:1;
+		/*
+		 * In Token Sequence Learning Queue Flush
+		 * (INTknQFlsh) (Device Only)
+		 */
+		unsigned intknqflsh:1;
+		/*
+		 * RxFIFO Flush (RxFFlsh) (Device and Host)
+		 *
+		 * The application can flush the entire Receive FIFO
+		 * using this bit.  <p>The application must first
+		 * ensure that the core is not in the middle of a
+		 * transaction.  <p>The application should write into
+		 * this bit, only after making sure that neither the
+		 * DMA engine is reading from the RxFIFO nor the MAC
+		 * is writing the data in to the FIFO.  <p>The
+		 * application should wait until the bit is cleared
+		 * before performing any other operations. This bit
+		 * will takes 8 clocks (slowest of PHY or AHB clock)
+		 * to clear.
+		 */
+		unsigned rxfflsh:1;
+		/*
+		 * TxFIFO Flush (TxFFlsh) (Device and Host).
+		 *
+		 * This bit is used to selectively flush a single or
+		 * all transmit FIFOs.  The application must first
+		 * ensure that the core is not in the middle of a
+		 * transaction.  <p>The application should write into
+		 * this bit, only after making sure that neither the
+		 * DMA engine is writing into the TxFIFO nor the MAC
+		 * is reading the data out of the FIFO.  <p>The
+		 * application should wait until the core clears this
+		 * bit, before performing any operations. This bit
+		 * will takes 8 clocks (slowest of PHY or AHB clock)
+		 * to clear.
+		 */
+		unsigned txfflsh:1;
+
+		/*
+		 * TxFIFO Number (TxFNum) (Device and Host).
+		 *
+		 * This is the FIFO number which needs to be flushed,
+		 * using the TxFIFO Flush bit. This field should not
+		 * be changed until the TxFIFO Flush bit is cleared by
+		 * the core.
+		 *   - 0x0:Non Periodic TxFIFO Flush
+		 *   - 0x1:Periodic TxFIFO #1 Flush in device mode
+		 *     or Periodic TxFIFO in host mode
+		 *   - 0x2:Periodic TxFIFO #2 Flush in device mode.
+		 *   - ...
+		 *   - 0xF:Periodic TxFIFO #15 Flush in device mode
+		 *   - 0x10: Flush all the Transmit NonPeriodic and
+		 *     Transmit Periodic FIFOs in the core
+		 */
+		unsigned txfnum:5;
+		/* Reserved */
+		unsigned reserved11_29:19;
+		/*
+		 * DMA Request Signal.  Indicated DMA request is in
+		 * probress.  Used for debug purpose.
+		 */
+		unsigned dmareq:1;
+		/*
+		 * AHB Master Idle.  Indicates the AHB Master State
+		 * Machine is in IDLE condition.
+		 */
+		unsigned ahbidle:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Interrupt Mask
+ * Register (GINTMSK).  Set/clear the bits using the bit fields then
+ * write the d32 value to the register.
+ */
+union gintmsk_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned wkupintr:1;
+		unsigned sessreqintr:1;
+		unsigned disconnect:1;
+		unsigned conidstschng:1;
+		unsigned reserved27:1;
+		unsigned ptxfempty:1;
+		unsigned hcintr:1;
+		unsigned portintr:1;
+		unsigned reserved22_23:2;
+		unsigned incomplisoout:1;
+		unsigned incomplisoin:1;
+		unsigned outepintr:1;
+		unsigned inepintr:1;
+		unsigned epmismatch:1;
+		unsigned reserved16:1;
+		unsigned eopframe:1;
+		unsigned isooutdrop:1;
+		unsigned enumdone:1;
+		unsigned usbreset:1;
+		unsigned usbsuspend:1;
+		unsigned erlysuspend:1;
+		unsigned i2cintr:1;
+		unsigned reserved8:1;
+		unsigned goutnakeff:1;
+		unsigned ginnakeff:1;
+		unsigned nptxfempty:1;
+		unsigned rxstsqlvl:1;
+		unsigned sofintr:1;
+		unsigned otgintr:1;
+		unsigned modemismatch:1;
+		unsigned reserved0:1;
+#else
+		unsigned reserved0:1;
+		unsigned modemismatch:1;
+		unsigned otgintr:1;
+		unsigned sofintr:1;
+		unsigned rxstsqlvl:1;
+		unsigned nptxfempty:1;
+		unsigned ginnakeff:1;
+		unsigned goutnakeff:1;
+		unsigned reserved8:1;
+		unsigned i2cintr:1;
+		unsigned erlysuspend:1;
+		unsigned usbsuspend:1;
+		unsigned usbreset:1;
+		unsigned enumdone:1;
+		unsigned isooutdrop:1;
+		unsigned eopframe:1;
+		unsigned reserved16:1;
+		unsigned epmismatch:1;
+		unsigned inepintr:1;
+		unsigned outepintr:1;
+		unsigned incomplisoin:1;
+		unsigned incomplisoout:1;
+		unsigned reserved22_23:2;
+		unsigned portintr:1;
+		unsigned hcintr:1;
+		unsigned ptxfempty:1;
+		unsigned reserved27:1;
+		unsigned conidstschng:1;
+		unsigned disconnect:1;
+		unsigned sessreqintr:1;
+		unsigned wkupintr:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Interrupt Register
+ * (GINTSTS).  Set/clear the bits using the bit fields then write the
+ * d32 value to the register.
+ */
+union gintsts_data {
+	/* raw register data */
+	uint32_t d32;
+#define DWC_SOF_INTR_MASK 0x0008
+
+	/* register bits */
+	struct {
+#define DWC_HOST_MODE 1
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned wkupintr:1;
+		unsigned sessreqintr:1;
+		unsigned disconnect:1;
+		unsigned conidstschng:1;
+		unsigned reserved27:1;
+		unsigned ptxfempty:1;
+		unsigned hcintr:1;
+		unsigned portintr:1;
+		unsigned reserved22_23:2;
+		unsigned incomplisoout:1;
+		unsigned incomplisoin:1;
+		unsigned outepintr:1;
+		unsigned inepint:1;
+		unsigned epmismatch:1;
+		unsigned intokenrx:1;
+		unsigned eopframe:1;
+		unsigned isooutdrop:1;
+		unsigned enumdone:1;
+		unsigned usbreset:1;
+		unsigned usbsuspend:1;
+		unsigned erlysuspend:1;
+		unsigned i2cintr:1;
+		unsigned reserved8:1;
+		unsigned goutnakeff:1;
+		unsigned ginnakeff:1;
+		unsigned nptxfempty:1;
+		unsigned rxstsqlvl:1;
+		unsigned sofintr:1;
+		unsigned otgintr:1;
+		unsigned modemismatch:1;
+		unsigned curmode:1;
+#else
+		unsigned curmode:1;
+		unsigned modemismatch:1;
+		unsigned otgintr:1;
+		unsigned sofintr:1;
+		unsigned rxstsqlvl:1;
+		unsigned nptxfempty:1;
+		unsigned ginnakeff:1;
+		unsigned goutnakeff:1;
+		unsigned reserved8:1;
+		unsigned i2cintr:1;
+		unsigned erlysuspend:1;
+		unsigned usbsuspend:1;
+		unsigned usbreset:1;
+		unsigned enumdone:1;
+		unsigned isooutdrop:1;
+		unsigned eopframe:1;
+		unsigned intokenrx:1;
+		unsigned epmismatch:1;
+		unsigned inepint:1;
+		unsigned outepintr:1;
+		unsigned incomplisoin:1;
+		unsigned incomplisoout:1;
+		unsigned reserved22_23:2;
+		unsigned portintr:1;
+		unsigned hcintr:1;
+		unsigned ptxfempty:1;
+		unsigned reserved27:1;
+		unsigned conidstschng:1;
+		unsigned disconnect:1;
+		unsigned sessreqintr:1;
+		unsigned wkupintr:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Receive Status Read and
+ * Pop Registers (GRXSTSR, GRXSTSP) Read the register into the d32
+ * element then read out the bits using the bit elements.
+ */
+union device_grxsts_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_DSTS_SETUP_UPDT	0x6	/* SETUP Packet */
+#define DWC_DSTS_SETUP_COMP 	0x4	/* Setup Phase Complete */
+#define DWC_DSTS_GOUT_NAK   	0x1	/* Global OUT NAK */
+#define DWC_STS_XFER_COMP   	0x3	/* OUT Data Transfer Complete */
+#define DWC_STS_DATA_UPDT   	0x2	/* OUT Data Packet */
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:7;
+		unsigned fn:4;
+		unsigned pktsts:4;
+		unsigned dpid:2;
+		unsigned bcnt:11;
+		unsigned epnum:4;
+#else
+		unsigned epnum:4;
+		unsigned bcnt:11;
+		unsigned dpid:2;
+		unsigned pktsts:4;
+		unsigned fn:4;
+		unsigned reserved:7;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Receive Status Read and
+ * Pop Registers (GRXSTSR, GRXSTSP) Read the register into the d32
+ * element then read out the bits using the bit elements.
+ */
+union host_grxsts_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_GRXSTS_PKTSTS_CH_HALTED       0x7
+#define DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR 0x5
+#define DWC_GRXSTS_PKTSTS_IN_XFER_COMP    0x3
+#define DWC_GRXSTS_PKTSTS_IN              0x2
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:11;
+		unsigned pktsts:4;
+		unsigned dpid:2;
+		unsigned bcnt:11;
+		unsigned chnum:4;
+#else
+		unsigned chnum:4;
+		unsigned bcnt:11;
+		unsigned dpid:2;
+		unsigned pktsts:4;
+		unsigned reserved:11;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the FIFO Size Registers (HPTXFSIZ,
+ * GNPTXFSIZ, DPTXFSIZn). Read the register into the d32 element then
+ * read out the bits using the bit elements.
+ */
+union fifosize_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned depth:16;
+		unsigned startaddr:16;
+#else
+		unsigned startaddr:16;
+		unsigned depth:16;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Non-Periodic Transmit
+ * FIFO/Queue Status Register (GNPTXSTS). Read the register into the
+ * d32 element then read out the bits using the bit
+ * elements.
+ */
+union gnptxsts_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:1;
+		unsigned nptxqtop_chnep:4;
+		unsigned nptxqtop_token:2;
+		unsigned nptxqtop_terminate:1;
+		unsigned nptxqspcavail:8;
+		unsigned nptxfspcavail:16;
+#else
+		unsigned nptxfspcavail:16;
+		unsigned nptxqspcavail:8;
+		/*
+		 * Top of the Non-Periodic Transmit Request Queue
+		 *  - bit 24 - Terminate (Last entry for the selected
+		 *    channel/EP)
+		 *  - bits 26:25 - Token Type
+		 *    - 2'b00 - IN/OUT
+		 *    - 2'b01 - Zero Length OUT
+		 *    - 2'b10 - PING/Complete Split
+		 *    - 2'b11 - Channel Halt
+		 *  - bits 30:27 - Channel/EP Number
+		 */
+		unsigned nptxqtop_terminate:1;
+		unsigned nptxqtop_token:2;
+		unsigned nptxqtop_chnep:4;
+		unsigned reserved:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the I2C Control Register
+ * (I2CCTL). Read the register into the d32 element then read out the
+ * bits using the bit elements.
+ */
+union gi2cctl_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned bsydne:1;
+		unsigned rw:1;
+		unsigned reserved:2;
+		unsigned i2cdevaddr:2;
+		unsigned i2csuspctl:1;
+		unsigned ack:1;
+		unsigned i2cen:1;
+		unsigned addr:7;
+		unsigned regaddr:8;
+		unsigned rwdata:8;
+#else
+		unsigned rwdata:8;
+		unsigned regaddr:8;
+		unsigned addr:7;
+		unsigned i2cen:1;
+		unsigned ack:1;
+		unsigned i2csuspctl:1;
+		unsigned i2cdevaddr:2;
+		unsigned reserved:2;
+		unsigned rw:1;
+		unsigned bsydne:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config1
+ * Register.  Read the register into the d32 element then read
+ * out the bits using the bit elements.
+ */
+union hwcfg1_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned ep_dir15:2;
+		unsigned ep_dir14:2;
+		unsigned ep_dir13:2;
+		unsigned ep_dir12:2;
+		unsigned ep_dir11:2;
+		unsigned ep_dir10:2;
+		unsigned ep_dir9:2;
+		unsigned ep_dir8:2;
+		unsigned ep_dir7:2;
+		unsigned ep_dir6:2;
+		unsigned ep_dir5:2;
+		unsigned ep_dir4:2;
+		unsigned ep_dir3:2;
+		unsigned ep_dir2:2;
+		unsigned ep_dir1:2;
+		unsigned ep_dir0:2;
+#else
+		unsigned ep_dir0:2;
+		unsigned ep_dir1:2;
+		unsigned ep_dir2:2;
+		unsigned ep_dir3:2;
+		unsigned ep_dir4:2;
+		unsigned ep_dir5:2;
+		unsigned ep_dir6:2;
+		unsigned ep_dir7:2;
+		unsigned ep_dir8:2;
+		unsigned ep_dir9:2;
+		unsigned ep_dir10:2;
+		unsigned ep_dir11:2;
+		unsigned ep_dir12:2;
+		unsigned ep_dir13:2;
+		unsigned ep_dir14:2;
+		unsigned ep_dir15:2;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config2
+ * Register.  Read the register into the d32 element then read
+ * out the bits using the bit elements.
+ */
+union hwcfg2_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI_ULPI 3
+#define DWC_HWCFG2_HS_PHY_TYPE_ULPI 2
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI 1
+#define DWC_HWCFG2_HS_PHY_TYPE_NOT_SUPPORTED 0
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST 6
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST 5
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE 4
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE 3
+#define DWC_HWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE_OTG 2
+#define DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG 1
+#define DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG 0
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved31:1;
+		unsigned dev_token_q_depth:5;
+		unsigned host_perio_tx_q_depth:2;
+		unsigned nonperio_tx_q_depth:2;
+		unsigned rx_status_q_depth:2;
+		unsigned dynamic_fifo:1;
+		unsigned perio_ep_supported:1;
+		unsigned num_host_chan:4;
+		unsigned num_dev_ep:4;
+		unsigned fs_phy_type:2;
+		unsigned hs_phy_type:2;
+		unsigned point2point:1;
+		unsigned architecture:2;
+		unsigned op_mode:3;
+#else
+		unsigned op_mode:3;
+		unsigned architecture:2;
+		unsigned point2point:1;
+		unsigned hs_phy_type:2;
+		unsigned fs_phy_type:2;
+		unsigned num_dev_ep:4;
+		unsigned num_host_chan:4;
+		unsigned perio_ep_supported:1;
+		unsigned dynamic_fifo:1;
+		unsigned rx_status_q_depth:2;
+		unsigned nonperio_tx_q_depth:2;
+		unsigned host_perio_tx_q_depth:2;
+		unsigned dev_token_q_depth:5;
+		unsigned reserved31:1;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the User HW Config3
+ * Register.  Read the register into the d32 element then read
+ * out the bits using the bit elements.
+ */
+union hwcfg3_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+		/* GHWCFG3 */
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned dfifo_depth:16;
+		unsigned reserved15_13:3;
+		unsigned ahb_phy_clock_synch:1;
+		unsigned synch_reset_type:1;
+		unsigned optional_features:1;
+		unsigned vendor_ctrl_if:1;
+		unsigned i2c:1;
+		unsigned otg_func:1;
+		unsigned packet_size_cntr_width:3;
+		unsigned xfer_size_cntr_width:4;
+#else
+		unsigned xfer_size_cntr_width:4;
+		unsigned packet_size_cntr_width:3;
+		unsigned otg_func:1;
+		unsigned i2c:1;
+		unsigned vendor_ctrl_if:1;
+		unsigned optional_features:1;
+		unsigned synch_reset_type:1;
+		unsigned ahb_phy_clock_synch:1;
+		unsigned reserved15_13:3;
+		unsigned dfifo_depth:16;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the User HW Config4
+ * Register.  Read the register into the d32 element then read
+ * out the bits using the bit elements.
+ */
+union hwcfg4_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved31_25:7;
+		unsigned session_end_filt_en:1;
+		unsigned b_valid_filt_en:1;
+		unsigned a_valid_filt_en:1;
+		unsigned vbus_valid_filt_en:1;
+		unsigned iddig_filt_en:1;
+		unsigned num_dev_mode_ctrl_ep:4;
+		unsigned utmi_phy_data_width:2;
+		unsigned min_ahb_freq:9;
+		unsigned power_optimiz:1;
+		unsigned num_dev_perio_in_ep:4;
+#else
+		unsigned num_dev_perio_in_ep:4;
+		unsigned power_optimiz:1;
+		unsigned min_ahb_freq:9;
+		unsigned utmi_phy_data_width:2;
+		unsigned num_dev_mode_ctrl_ep:4;
+		unsigned iddig_filt_en:1;
+		unsigned vbus_valid_filt_en:1;
+		unsigned a_valid_filt_en:1;
+		unsigned b_valid_filt_en:1;
+		unsigned session_end_filt_en:1;
+		unsigned reserved31_25:7;
+#endif
+	} b;
+};
+
+
+/*
+ * Device Global Registers. Offsets 800h-BFFh
+ *
+ * The following structures define the size and relative field offsets
+ * for the Device Mode Registers.
+ *
+ * These registers are visible only in Device mode and must not be
+ * accessed in Host mode, as the results are unknown.
+ */
+struct dwc_otg_dev_global_regs {
+	/* Device Configuration Register. Offset 800h */
+	uint32_t dcfg;
+	/* Device Control Register. Offset: 804h */
+	uint32_t dctl;
+	/* Device Status Register (Read Only). Offset: 808h */
+	uint32_t dsts;
+	/* Reserved. Offset: 80Ch */
+	uint32_t unused;
+	/*
+	 * Device IN Endpoint Common Interrupt Mask  Register. Offset: 810h
+	 */
+	uint32_t diepmsk;
+	/*
+	 * Device OUT Endpoint Common Interrupt Mask
+	 * Register. Offset: 814h
+	 */
+	uint32_t doepmsk;
+	/*
+	 * Device All Endpoints Interrupt Register.  Offset: 818h
+	 */
+	uint32_t daint;
+	/*
+	 * Device All Endpoints Interrupt Mask Register.  Offset:
+	 * 81Ch
+	 */
+	uint32_t daintmsk;
+	/*
+	 * Device IN Token Queue Read Register-1 (Read Only).
+	 * Offset: 820h
+	 */
+	uint32_t dtknqr1;
+	/*
+	 * Device IN Token Queue Read Register-2 (Read Only).
+	 * Offset: 824h
+	 */
+	uint32_t dtknqr2;
+	/*
+	 * Device VBUS  discharge Register.  Offset: 828h
+	 */
+	uint32_t dvbusdis;
+	/*
+	 * Device VBUS Pulse Register.  Offset: 82Ch
+	 */
+	uint32_t dvbuspulse;
+	/*
+	 * Device IN Token Queue Read Register-3 (Read Only).
+	 * Offset: 830h
+	 */
+	uint32_t dtknqr3;
+	/*
+	 * Device IN Token Queue Read Register-4 (Read Only).
+	 * Offset: 834h
+	 */
+	uint32_t dtknqr4;
+};
+
+/*
+ * This union represents the bit fields in the Device Configuration
+ * Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.  Write the
+ * d32 member to the dcfg register.
+ */
+union dcfg_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_DCFG_FRAME_INTERVAL_95 3
+#define DWC_DCFG_FRAME_INTERVAL_90 2
+#define DWC_DCFG_FRAME_INTERVAL_85 1
+#define DWC_DCFG_FRAME_INTERVAL_80 0
+#define DWC_DCFG_SEND_STALL 1
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved9:10;
+		unsigned epmscnt:4;
+		unsigned reserved13_17:5;
+		unsigned perfrint:2;
+		unsigned devaddr:7;
+		unsigned reserved3:1;
+		unsigned nzstsouthshk:1;
+		unsigned devspd:2;
+#else
+
+		/* Device Speed */
+		unsigned devspd:2;
+		/* Non Zero Length Status OUT Handshake */
+		unsigned nzstsouthshk:1;
+		unsigned reserved3:1;
+		/* Device Addresses */
+		unsigned devaddr:7;
+		/* Periodic Frame Interval */
+		unsigned perfrint:2;
+		unsigned reserved13_17:5;
+		/* In Endpoint Mis-match count */
+		unsigned epmscnt:4;
+		unsigned reserved9:10;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Device Control
+ * Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.
+ */
+union dctl_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:21;
+		unsigned cgoutnak:1;
+		unsigned sgoutnak:1;
+		unsigned cgnpinnak:1;
+		unsigned sgnpinnak:1;
+		unsigned tstctl:3;
+		unsigned goutnaksts:1;
+		unsigned gnpinnaksts:1;
+		unsigned sftdiscon:1;
+		unsigned rmtwkupsig:1;
+#else
+
+		/* Remote Wakeup */
+		unsigned rmtwkupsig:1;
+		/* Soft Disconnect */
+		unsigned sftdiscon:1;
+		/* Global Non-Periodic IN NAK Status */
+		unsigned gnpinnaksts:1;
+		/* Global OUT NAK Status */
+		unsigned goutnaksts:1;
+		/* Test Control */
+		unsigned tstctl:3;
+		/* Set Global Non-Periodic IN NAK */
+		unsigned sgnpinnak:1;
+		/* Clear Global Non-Periodic IN NAK */
+		unsigned cgnpinnak:1;
+		/* Set Global OUT NAK */
+		unsigned sgoutnak:1;
+		/* Clear Global OUT NAK */
+		unsigned cgoutnak:1;
+
+		unsigned reserved:21;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Status
+ * Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.
+ */
+union dsts_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_DSTS_ENUMSPD_FS_PHY_48MHZ          3
+#define DWC_DSTS_ENUMSPD_LS_PHY_6MHZ           2
+#define DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ 1
+#define DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ 0
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved22_31:10;
+		unsigned soffn:14;
+		unsigned reserved4_7:4;
+		unsigned errticerr:1;
+		unsigned enumspd:2;
+		unsigned suspsts:1;
+#else
+
+		/* Suspend Status */
+		unsigned suspsts:1;
+		/* Enumerated Speed */
+		unsigned enumspd:2;
+		/* Erratic Error */
+		unsigned errticerr:1;
+		unsigned reserved4_7:4;
+		/* Frame or Microframe Number of the received SOF */
+		unsigned soffn:14;
+		unsigned reserved22_31:10;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Device IN EP Interrupt
+ * Register and the Device IN EP Common Mask Register.
+ *
+ * It also represents the bit fields in the Device IN EP Common
+ * Interrupt Mask Register.
+
+ * - Read the register into the d32 member then set/clear the
+ *   bits using the bit elements.
+ */
+union diepint_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved07_31:25;
+		unsigned inepnakeff:1;
+		unsigned intknepmis:1;
+		unsigned intktxfemp:1;
+		unsigned timeout:1;
+		unsigned ahberr:1;
+		unsigned epdisabled:1;
+		unsigned xfercompl:1;
+#else
+
+y		/* Transfer complete mask */
+		unsigned xfercompl:1;
+		/* Endpoint disable mask */
+		unsigned epdisabled:1;
+		/* AHB Error mask */
+		unsigned ahberr:1;
+		/* TimeOUT Handshake mask (non-ISOC EPs) */
+		unsigned timeout:1;
+		/* IN Token received with TxF Empty mask */
+		unsigned intktxfemp:1;
+		/* IN Token Received with EP mismatch mask */
+		unsigned intknepmis:1;
+		/* IN Endpoint HAK Effective mask */
+		unsigned inepnakeff:1;
+		unsigned reserved07_31:25;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Device OUT EP Interrupt
+ * Registerand Device OUT EP Common Interrupt Mask Register.
+ *
+ * It also represents the bit fields in the Device OUT EP Common
+ * Interrupt Mask Register.
+ *
+ * - Read the register into the d32 member then set/clear the
+ *   bits using the bit elements.
+ */
+union doepint_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved04_31:28;
+		unsigned setup:1;
+		unsigned ahberr:1;
+		unsigned epdisabled:1;
+		unsigned xfercompl:1;
+#else
+
+	/* Transfer complete */
+		unsigned xfercompl:1;
+	/* Endpoint disable  */
+		unsigned epdisabled:1;
+	/* AHB Error */
+		unsigned ahberr:1;
+	/* Setup Phase Done (contorl EPs) */
+		unsigned setup:1;
+		unsigned reserved04_31:28;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device All EP Interrupt
+ * and Mask Registers.
+ * - Read the register into the d32 member then set/clear the
+ *   bits using the bit elements.
+ */
+union daint_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned out:16;
+		unsigned in:16;
+#else
+
+		/* IN Endpoint bits */
+		unsigned in:16;
+		/* OUT Endpoint bits */
+		unsigned out:16;
+#endif
+	} ep;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned outep15:1;
+		unsigned outep14:1;
+		unsigned outep13:1;
+		unsigned outep12:1;
+		unsigned outep11:1;
+		unsigned outep10:1;
+		unsigned outep9:1;
+		unsigned outep8:1;
+		unsigned outep7:1;
+		unsigned outep6:1;
+		unsigned outep5:1;
+		unsigned outep4:1;
+		unsigned outep3:1;
+		unsigned outep2:1;
+		unsigned outep1:1;
+		unsigned outep0:1;
+		unsigned inep15:1;
+		unsigned inep14:1;
+		unsigned inep13:1;
+		unsigned inep12:1;
+		unsigned inep11:1;
+		unsigned inep10:1;
+		unsigned inep9:1;
+		unsigned inep8:1;
+		unsigned inep7:1;
+		unsigned inep6:1;
+		unsigned inep5:1;
+		unsigned inep4:1;
+		unsigned inep3:1;
+		unsigned inep2:1;
+		unsigned inep1:1;
+		unsigned inep0:1;
+#else
+
+		/* IN Endpoint bits */
+		unsigned inep0:1;
+		unsigned inep1:1;
+		unsigned inep2:1;
+		unsigned inep3:1;
+		unsigned inep4:1;
+		unsigned inep5:1;
+		unsigned inep6:1;
+		unsigned inep7:1;
+		unsigned inep8:1;
+		unsigned inep9:1;
+		unsigned inep10:1;
+		unsigned inep11:1;
+		unsigned inep12:1;
+		unsigned inep13:1;
+		unsigned inep14:1;
+		unsigned inep15:1;
+		/* OUT Endpoint bits */
+		unsigned outep0:1;
+		unsigned outep1:1;
+		unsigned outep2:1;
+		unsigned outep3:1;
+		unsigned outep4:1;
+		unsigned outep5:1;
+		unsigned outep6:1;
+		unsigned outep7:1;
+		unsigned outep8:1;
+		unsigned outep9:1;
+		unsigned outep10:1;
+		unsigned outep11:1;
+		unsigned outep12:1;
+		unsigned outep13:1;
+		unsigned outep14:1;
+		unsigned outep15:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device IN Token Queue
+ * Read Registers.
+ * - Read the register into the d32 member.
+ * - READ-ONLY Register
+ */
+union dtknq1_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned epnums0_5:24;
+		unsigned wrap_bit:1;
+		unsigned reserved05_06:2;
+		unsigned intknwptr:5;
+#else
+
+		/* In Token Queue Write Pointer */
+		unsigned intknwptr:5;
+		/* Reserved */
+		unsigned reserved05_06:2;
+		/* write pointer has wrapped. */
+		unsigned wrap_bit:1;
+		/* EP Numbers of IN Tokens 0 ... 4 */
+		unsigned epnums0_5:24;
+#endif
+	} b;
+};
+
+/*
+ * Device Logical IN Endpoint-Specific Registers. Offsets
+ * 900h-AFCh
+ *
+ * There will be one set of endpoint registers per logical endpoint
+ * implemented.
+ *
+ * These registers are visible only in Device mode and must not be
+ * accessed in Host mode, as the results are unknown.
+ */
+struct dwc_otg_dev_in_ep_regs {
+	/*
+	 * Device IN Endpoint Control Register. Offset:900h +
+	 * (ep_num * 20h) + 00h
+	 */
+	uint32_t diepctl;
+	/* Reserved. Offset:900h + (ep_num * 20h) + 04h */
+	uint32_t reserved04;
+	/*
+	 * Device IN Endpoint Interrupt Register. Offset:900h +
+	 * (ep_num * 20h) + 08h
+	 */
+	uint32_t diepint;
+	/* Reserved. Offset:900h + (ep_num * 20h) + 0Ch */
+	uint32_t reserved0C;
+	/*
+	 * Device IN Endpoint Transfer Size
+	 * Register. Offset:900h + (ep_num * 20h) + 10h
+	 */
+	uint32_t dieptsiz;
+	/*
+	 * Device IN Endpoint DMA Address Register. Offset:900h +
+	 * (ep_num * 20h) + 14h
+	 */
+	uint32_t diepdma;
+	/*
+	 * Reserved. Offset:900h + (ep_num * 20h) + 18h - 900h +
+	 * (ep_num * 20h) + 1Ch
+	 */
+	uint32_t reserved18[2];
+};
+
+/**
+ * Device Logical OUT Endpoint-Specific Registers. Offsets:
+ * B00h-CFCh
+ *
+ * There will be one set of endpoint registers per logical endpoint
+ * implemented.
+ *
+ * These registers are visible only in Device mode and must not be
+ * accessed in Host mode, as the results are unknown.
+ */
+struct dwc_otg_dev_out_ep_regs {
+	/*
+	 * Device OUT Endpoint Control Register. Offset:B00h +
+	 * (ep_num * 20h) + 00h
+	 */
+	uint32_t doepctl;
+	/*
+	 * Device OUT Endpoint Frame number Register.  Offset:
+	 * B00h + (ep_num * 20h) + 04h
+	 */
+	uint32_t doepfn;
+	/*
+	 * Device OUT Endpoint Interrupt Register. Offset:B00h +
+	 * (ep_num * 20h) + 08h
+	 */
+	uint32_t doepint;
+	/*
+	 * Reserved. Offset:B00h + (ep_num * 20h) + 0Ch */
+	uint32_t reserved0C;
+	/*
+	 * Device OUT Endpoint Transfer Size Register. Offset:
+	 * B00h + (ep_num * 20h) + 10h
+	 */
+	uint32_t doeptsiz;
+	/*
+	 * Device OUT Endpoint DMA Address Register. Offset:B00h
+	 * + (ep_num * 20h) + 14h
+	 */
+	uint32_t doepdma;
+	/*
+	 * Reserved. Offset:B00h + (ep_num * 20h) + 18h - B00h +
+	 * (ep_num * 20h) + 1Ch
+	 */
+	uint32_t unused[2];
+};
+
+/*
+ * This union represents the bit fields in the Device EP Control
+ * Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.
+ */
+union depctl_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#define DWC_DEP0CTL_MPS_64   0
+#define DWC_DEP0CTL_MPS_32   1
+#define DWC_DEP0CTL_MPS_16   2
+#define DWC_DEP0CTL_MPS_8    3
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned mps:11;
+		unsigned epena:1;
+		unsigned epdis:1;
+		unsigned setd1pid:1;
+		unsigned setd0pid:1;
+		unsigned snak:1;
+		unsigned cnak:1;
+		unsigned txfnum:4;
+		unsigned stall:1;
+		unsigned snp:1;
+		unsigned eptype:2;
+		unsigned naksts:1;
+		unsigned dpid:1;
+		unsigned usbactep:1;
+		unsigned nextep:4;
+#else
+
+		/*
+		 * Maximum Packet Size
+		 * IN/OUT EPn
+		 * IN/OUT EP0 - 2 bits
+		 *   2'b00: 64 Bytes
+		 *   2'b01: 32
+		 *   2'b10: 16
+		 *   2'b11: 8
+		 */
+		unsigned mps:11;
+		/*
+		 * Next Endpoint
+		 * IN EPn/IN EP0
+		 * OUT EPn/OUT EP0 - reserved
+		 */
+		unsigned nextep:4;
+
+		/* USB Active Endpoint */
+		unsigned usbactep:1;
+
+		/*
+		 * Endpoint DPID (INTR/Bulk IN and OUT endpoints)
+		 * This field contains the PID of the packet going to
+		 * be received or transmitted on this endpoint. The
+		 * application should program the PID of the first
+		 * packet going to be received or transmitted on this
+		 * endpoint , after the endpoint is
+		 * activated. Application use the SetD1PID and
+		 * SetD0PID fields of this register to program either
+		 * D0 or D1 PID.
+		 *
+		 * The encoding for this field is
+		 *   - 0: D0
+		 *   - 1: D1
+		 */
+		unsigned dpid:1;
+
+		/* NAK Status */
+		unsigned naksts:1;
+
+		/*
+		 * Endpoint Type
+		 *  2'b00: Control
+		 *  2'b01: Isochronous
+		 *  2'b10: Bulk
+		 *  2'b11: Interrupt
+		 */
+		unsigned eptype:2;
+
+		/*
+		 * Snoop Mode
+		 * OUT EPn/OUT EP0
+		 * IN EPn/IN EP0 - reserved
+		 */
+		unsigned snp:1;
+
+		/* Stall Handshake */
+		unsigned stall:1;
+
+		/*
+		 * Tx Fifo Number
+		 * IN EPn/IN EP0
+		 * OUT EPn/OUT EP0 - reserved
+		 */
+		unsigned txfnum:4;
+
+		/* Clear NAK */
+		unsigned cnak:1;
+		/* Set NAK */
+		unsigned snak:1;
+		/*
+		 * Set DATA0 PID (INTR/Bulk IN and OUT endpoints)
+		 * Writing to this field sets the Endpoint DPID (DPID)
+		 * field in this register to DATA0. Set Even
+		 * (micro)frame (SetEvenFr) (ISO IN and OUT Endpoints)
+		 * Writing to this field sets the Even/Odd
+		 * (micro)frame (EO_FrNum) field to even (micro)
+		 * frame.
+		 */
+		unsigned setd0pid:1;
+		/*
+		 * Set DATA1 PID (INTR/Bulk IN and OUT endpoints)
+		 * Writing to this field sets the Endpoint DPID (DPID)
+		 * field in this register to DATA1 Set Odd
+		 * (micro)frame (SetOddFr) (ISO IN and OUT Endpoints)
+		 * Writing to this field sets the Even/Odd
+		 * (micro)frame (EO_FrNum) field to odd (micro) frame.
+		 */
+		unsigned setd1pid:1;
+
+		/* Endpoint Disable */
+		unsigned epdis:1;
+		/* Endpoint Enable */
+		unsigned epena:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device EP Transfer
+ * Size Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.
+ */
+union deptsiz_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:1;
+		unsigned mc:2;
+		unsigned pktcnt:10;
+		unsigned xfersize:19;
+#else
+
+		/* Transfer size */
+		unsigned xfersize:19;
+		/* Packet Count */
+		unsigned pktcnt:10;
+		/* Multi Count - Periodic IN endpoints */
+		unsigned mc:2;
+		unsigned reserved:1;
+#endif
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device EP 0 Transfer
+ * Size Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.
+ */
+union deptsiz0_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved31:1;
+		unsigned supcnt:2;
+		unsigned reserved20_28:9;
+		unsigned pktcnt:1;
+		unsigned reserved7_18:12;
+		unsigned xfersize:7;
+#else
+
+		/* Transfer size */
+		unsigned xfersize:7;
+		/* Reserved */
+		unsigned reserved7_18:12;
+		/* Packet Count */
+		unsigned pktcnt:1;
+		/* Reserved */
+		unsigned reserved20_28:9;
+		/* Setup Packet Count (DOEPTSIZ0 Only) */
+		unsigned supcnt:2;
+		unsigned reserved31:1;
+#endif
+	} b;
+};
+
+/** Maximum number of Periodic FIFOs */
+#define MAX_PERIO_FIFOS 15
+
+/** Maximum number of Endpoints/HostChannels */
+#define MAX_EPS_CHANNELS 16
+
+/*
+ * The dwc_otg_dev_if structure contains information needed to manage
+ * the DWC_otg controller acting in device mode. It represents the
+ * programming view of the device-specific aspects of the controller.
+ */
+struct dwc_otg_dev_if {
+	/*
+	 * Pointer to device Global registers.
+	 * Device Global Registers starting at offset 800h
+	 */
+	struct dwc_otg_dev_global_regs *dev_global_regs;
+#define DWC_DEV_GLOBAL_REG_OFFSET 0x800
+
+	/*
+	 * Device Logical IN Endpoint-Specific Registers 900h-AFCh
+	 */
+	struct dwc_otg_dev_in_ep_regs *in_ep_regs[MAX_EPS_CHANNELS];
+#define DWC_DEV_IN_EP_REG_OFFSET 0x900
+#define DWC_EP_REG_OFFSET 0x20
+
+	/* Device Logical OUT Endpoint-Specific Registers B00h-CFCh */
+	struct dwc_otg_dev_out_ep_regs *out_ep_regs[MAX_EPS_CHANNELS];
+#define DWC_DEV_OUT_EP_REG_OFFSET 0xB00
+
+	/* Device configuration information */
+	uint8_t speed;	 /* Device Speed  0: Unknown, 1: LS, 2:FS, 3: HS */
+	uint8_t num_eps;  /* Number of EPs  range: 1-16 (includes EP0) */
+	uint8_t num_perio_eps;	 /* # of Periodic EP range: 0-15 */
+
+	/* Size of periodic FIFOs (Bytes) */
+	uint16_t perio_tx_fifo_size[MAX_PERIO_FIFOS];
+
+};
+
+
+/* Host Mode Register Structures */
+
+/*
+ * The Host Global Registers structure defines the size and relative
+ * field offsets for the Host Mode Global Registers.  Host Global
+ * Registers offsets 400h-7FFh.
+ */
+struct dwc_otg_host_global_regs {
+	/* Host Configuration Register.   Offset: 400h */
+	uint32_t hcfg;
+	/* Host Frame Interval Register.   Offset: 404h */
+	uint32_t hfir;
+	/* Host Frame Number / Frame Remaining Register. Offset: 408h */
+	uint32_t hfnum;
+	/* Reserved.   Offset: 40Ch */
+	uint32_t reserved40C;
+	/* Host Periodic Transmit FIFO/ Queue Status Register. Offset: 410h */
+	uint32_t hptxsts;
+	/* Host All Channels Interrupt Register. Offset: 414h */
+	uint32_t haint;
+	/* Host All Channels Interrupt Mask Register. Offset: 418h */
+	uint32_t haintmsk;
+};
+
+/*
+ * This union represents the bit fields in the Host Configuration Register.
+ * Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcfg register.
+ */
+union hcfg_data {
+    /** raw register data */
+	uint32_t d32;
+
+    /** register bits */
+	struct {
+#define DWC_HCFG_6_MHZ     2
+#define DWC_HCFG_48_MHZ    1
+#define DWC_HCFG_30_60_MHZ 0
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:29;
+		unsigned fslssupp:1;
+		unsigned fslspclksel:2;
+#else
+
+		/* FS/LS Phy Clock Select */
+		unsigned fslspclksel:2;
+		/* FS/LS Only Support */
+		unsigned fslssupp:1;
+		unsigned reserved:29;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host Frame Remaing/Number
+ * Register.
+ */
+union hfir_data {
+	/* raw register data */
+	uint32_t d32;
+
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:16;
+		unsigned frint:16;
+#else
+		unsigned frint:16;
+		unsigned reserved:16;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host Frame Remaing/Number
+ * Register.
+ */
+union hfnum_data {
+	/* raw register data */
+	uint32_t d32;
+
+	/* register bits */
+	struct {
+#define DWC_HFNUM_MAX_FRNUM 0x3FFF
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned frrem:16;
+		unsigned frnum:16;
+#else
+		unsigned frnum:16;
+		unsigned frrem:16;
+#endif
+	} b;
+};
+
+union hptxsts_data {
+	/* raw register data */
+	uint32_t d32;
+
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned ptxqtop_odd:1;
+		unsigned ptxqtop_chnum:4;
+		unsigned ptxqtop_token:2;
+		unsigned ptxqtop_terminate:1;
+		unsigned ptxqspcavail:8;
+		unsigned ptxfspcavail:16;
+#else
+		unsigned ptxfspcavail:16;
+		unsigned ptxqspcavail:8;
+		/*
+		 * Top of the Periodic Transmit Request Queue
+		 *  - bit 24 - Terminate (last entry for the selected channel)
+		 *  - bits 26:25 - Token Type
+		 *    - 2'b00 - Zero length
+		 *    - 2'b01 - Ping
+		 *    - 2'b10 - Disable
+		 *  - bits 30:27 - Channel Number
+		 *  - bit 31 - Odd/even microframe
+		 */
+		unsigned ptxqtop_terminate:1;
+		unsigned ptxqtop_token:2;
+		unsigned ptxqtop_chnum:4;
+		unsigned ptxqtop_odd:1;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host Port Control and Status
+ * Register. Read the register into the d32 member then set/clear the
+ * bits using the bit elements. Write the d32 member to the
+ * hprt0 register.
+ */
+union hprt0_data {
+    /** raw register data */
+	uint32_t d32;
+    /** register bits */
+	struct {
+#define DWC_HPRT0_PRTSPD_LOW_SPEED  2
+#define DWC_HPRT0_PRTSPD_FULL_SPEED 1
+#define DWC_HPRT0_PRTSPD_HIGH_SPEED 0
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved19_31:13;
+		unsigned prtspd:2;
+		unsigned prttstctl:4;
+		unsigned prtpwr:1;
+		unsigned prtlnsts:2;
+		unsigned reserved9:1;
+		unsigned prtrst:1;
+		unsigned prtsusp:1;
+		unsigned prtres:1;
+		unsigned prtovrcurrchng:1;
+		unsigned prtovrcurract:1;
+		unsigned prtenchng:1;
+		unsigned prtena:1;
+		unsigned prtconndet:1;
+		unsigned prtconnsts:1;
+#else
+		unsigned prtconnsts:1;
+		unsigned prtconndet:1;
+		unsigned prtena:1;
+		unsigned prtenchng:1;
+		unsigned prtovrcurract:1;
+		unsigned prtovrcurrchng:1;
+		unsigned prtres:1;
+		unsigned prtsusp:1;
+		unsigned prtrst:1;
+		unsigned reserved9:1;
+		unsigned prtlnsts:2;
+		unsigned prtpwr:1;
+		unsigned prttstctl:4;
+		unsigned prtspd:2;
+		unsigned reserved19_31:13;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host All Interrupt
+ * Register.
+ */
+union haint_data {
+    /** raw register data */
+	uint32_t d32;
+    /** register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:16;
+		unsigned ch15:1;
+		unsigned ch14:1;
+		unsigned ch13:1;
+		unsigned ch12:1;
+		unsigned ch11:1;
+		unsigned ch10:1;
+		unsigned ch9:1;
+		unsigned ch8:1;
+		unsigned ch7:1;
+		unsigned ch6:1;
+		unsigned ch5:1;
+		unsigned ch4:1;
+		unsigned ch3:1;
+		unsigned ch2:1;
+		unsigned ch1:1;
+		unsigned ch0:1;
+#else
+		unsigned ch0:1;
+		unsigned ch1:1;
+		unsigned ch2:1;
+		unsigned ch3:1;
+		unsigned ch4:1;
+		unsigned ch5:1;
+		unsigned ch6:1;
+		unsigned ch7:1;
+		unsigned ch8:1;
+		unsigned ch9:1;
+		unsigned ch10:1;
+		unsigned ch11:1;
+		unsigned ch12:1;
+		unsigned ch13:1;
+		unsigned ch14:1;
+		unsigned ch15:1;
+		unsigned reserved:16;
+#endif
+	} b;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:16;
+		unsigned chint:16;
+#else
+		unsigned chint:16;
+		unsigned reserved:16;
+#endif
+	} b2;
+};
+
+/**
+ * This union represents the bit fields in the Host All Interrupt
+ * Register.
+ */
+union haintmsk_data {
+    /** raw register data */
+	uint32_t d32;
+    /** register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:16;
+		unsigned ch15:1;
+		unsigned ch14:1;
+		unsigned ch13:1;
+		unsigned ch12:1;
+		unsigned ch11:1;
+		unsigned ch10:1;
+		unsigned ch9:1;
+		unsigned ch8:1;
+		unsigned ch7:1;
+		unsigned ch6:1;
+		unsigned ch5:1;
+		unsigned ch4:1;
+		unsigned ch3:1;
+		unsigned ch2:1;
+		unsigned ch1:1;
+		unsigned ch0:1;
+#else
+		unsigned ch0:1;
+		unsigned ch1:1;
+		unsigned ch2:1;
+		unsigned ch3:1;
+		unsigned ch4:1;
+		unsigned ch5:1;
+		unsigned ch6:1;
+		unsigned ch7:1;
+		unsigned ch8:1;
+		unsigned ch9:1;
+		unsigned ch10:1;
+		unsigned ch11:1;
+		unsigned ch12:1;
+		unsigned ch13:1;
+		unsigned ch14:1;
+		unsigned ch15:1;
+		unsigned reserved:16;
+#endif
+	} b;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:16;
+		unsigned chint:16;
+#else
+		unsigned chint:16;
+		unsigned reserved:16;
+#endif
+	} b2;
+};
+
+/*
+ * Host Channel Specific Registers. 500h-5FCh
+ */
+struct dwc_otg_hc_regs {
+	/*
+	 * Host Channel 0 Characteristic Register.
+	 * Offset: 500h + (chan_num * 20h) + 00h
+	 */
+	uint32_t hcchar;
+	/*
+	 * Host Channel 0 Split Control Register.
+	 * Offset: 500h + (chan_num * 20h) + 04h
+	 */
+	uint32_t hcsplt;
+	/*
+	 * Host Channel 0 Interrupt Register.
+	 * Offset: 500h + (chan_num * 20h) + 08h
+	 */
+	uint32_t hcint;
+	/*
+	 * Host Channel 0 Interrupt Mask Register.
+	 * Offset: 500h + (chan_num * 20h) + 0Ch
+	 */
+	uint32_t hcintmsk;
+	/*
+	 * Host Channel 0 Transfer Size Register.
+	 * Offset: 500h + (chan_num * 20h) + 10h
+	 */
+	uint32_t hctsiz;
+	/*
+	 * Host Channel 0 DMA Address Register.
+	 * Offset: 500h + (chan_num * 20h) + 14h
+	 */
+	uint32_t hcdma;
+	/*
+	 * Reserved.
+	 * Offset: 500h + (chan_num * 20h) + 18h -
+	 *         500h + (chan_num * 20h) + 1Ch
+	 */
+	uint32_t reserved[2];
+};
+
+/**
+ * This union represents the bit fields in the Host Channel Characteristics
+ * Register. Read the register into the d32 member then set/clear the
+ * bits using the bit elements. Write the d32 member to the
+ * hcchar register.
+ */
+union hcchar_data {
+    /** raw register data */
+	uint32_t d32;
+
+    /** register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned chen:1;
+		unsigned chdis:1;
+		unsigned oddfrm:1;
+		unsigned devaddr:7;
+		unsigned multicnt:2;
+		unsigned eptype:2;
+		unsigned lspddev:1;
+		unsigned reserved:1;
+		unsigned epdir:1;
+		unsigned epnum:4;
+		unsigned mps:11;
+#else
+
+		/* Maximum packet size in bytes */
+		unsigned mps:11;
+
+		/* Endpoint number */
+		unsigned epnum:4;
+
+		/* 0: OUT, 1: IN */
+		unsigned epdir:1;
+
+		unsigned reserved:1;
+
+		/* 0: Full/high speed device, 1: Low speed device */
+		unsigned lspddev:1;
+
+		/* 0: Control, 1: Isoc, 2: Bulk, 3: Intr */
+		unsigned eptype:2;
+
+		/* Packets per frame for periodic transfers. 0 is reserved. */
+		unsigned multicnt:2;
+
+		/* Device address */
+		unsigned devaddr:7;
+
+		/*
+		 * Frame to transmit periodic transaction.
+		 * 0: even, 1: odd
+		 */
+		unsigned oddfrm:1;
+
+		/* Channel disable */
+		unsigned chdis:1;
+
+		/* Channel enable */
+		unsigned chen:1;
+#endif
+	} b;
+};
+
+union hcsplt_data {
+	/* raw register data */
+	uint32_t d32;
+
+	/* register bits */
+	struct {
+#define DWC_HCSPLIT_XACTPOS_ALL 3
+#define DWC_HCSPLIT_XACTPOS_BEGIN 2
+#define DWC_HCSPLIT_XACTPOS_END 1
+#define DWC_HCSPLIT_XACTPOS_MID 0
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned spltena:1;
+		unsigned reserved:14;
+		unsigned compsplt:1;
+		unsigned xactpos:2;
+		unsigned hubaddr:7;
+		unsigned prtaddr:7;
+#else
+
+		/* Port Address */
+		unsigned prtaddr:7;
+
+		/* Hub Address */
+		unsigned hubaddr:7;
+
+		/* Transaction Position */
+		unsigned xactpos:2;
+
+		/* Do Complete Split */
+		unsigned compsplt:1;
+
+		/* Reserved */
+		unsigned reserved:14;
+
+		/* Split Enble */
+		unsigned spltena:1;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host All Interrupt
+ * Register.
+ */
+union hcint_data {
+	/* raw register data */
+	uint32_t d32;
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:21;
+		unsigned datatglerr:1;
+		unsigned frmovrun:1;
+		unsigned bblerr:1;
+		unsigned xacterr:1;
+		unsigned nyet:1;
+		unsigned ack:1;
+		unsigned nak:1;
+		unsigned stall:1;
+		unsigned ahberr:1;
+		unsigned chhltd:1;
+		unsigned xfercomp:1;
+#else
+
+		/* Transfer Complete */
+		unsigned xfercomp:1;
+		/* Channel Halted */
+		unsigned chhltd:1;
+		/* AHB Error */
+		unsigned ahberr:1;
+		/* STALL Response Received */
+		unsigned stall:1;
+		/* NAK Response Received */
+		unsigned nak:1;
+		/* ACK Response Received */
+		unsigned ack:1;
+		/* NYET Response Received */
+		unsigned nyet:1;
+		/* Transaction Err */
+		unsigned xacterr:1;
+		/* Babble Error */
+		unsigned bblerr:1;
+		/* Frame Overrun */
+		unsigned frmovrun:1;
+		/* Data Toggle Error */
+		unsigned datatglerr:1;
+		/* Reserved */
+		unsigned reserved:21;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host Channel Transfer Size
+ * Register. Read the register into the d32 member then set/clear the
+ * bits using the bit elements. Write the d32 member to the
+ * hcchar register.
+ */
+union hctsiz_data {
+	/* raw register data */
+	uint32_t d32;
+
+	/* register bits */
+	struct {
+#define DWC_HCTSIZ_SETUP 3
+#define DWC_HCTSIZ_MDATA 3
+#define DWC_HCTSIZ_DATA2 1
+#define DWC_HCTSIZ_DATA1 2
+#define DWC_HCTSIZ_DATA0 0
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned dopng:1;
+		unsigned pid:2;
+		unsigned pktcnt:10;
+		unsigned xfersize:19;
+#else
+
+		/* Total transfer size in bytes */
+		unsigned xfersize:19;
+
+		/* Data packets to transfer */
+		unsigned pktcnt:10;
+
+		/*
+		 * Packet ID for next data packet
+		 * 0: DATA0
+		 * 1: DATA2
+		 * 2: DATA1
+		 * 3: MDATA (non-Control), SETUP (Control)
+		 */
+		unsigned pid:2;
+
+		/* Do PING protocol when 1 */
+		unsigned dopng:1;
+#endif
+	} b;
+};
+
+/**
+ * This union represents the bit fields in the Host Channel Interrupt Mask
+ * Register. Read the register into the d32 member then set/clear the
+ * bits using the bit elements. Write the d32 member to the
+ * hcintmsk register.
+ */
+union hcintmsk_data {
+    /** raw register data */
+	uint32_t d32;
+
+    /** register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:21;
+		unsigned datatglerr:1;
+		unsigned frmovrun:1;
+		unsigned bblerr:1;
+		unsigned xacterr:1;
+		unsigned nyet:1;
+		unsigned ack:1;
+		unsigned nak:1;
+		unsigned stall:1;
+		unsigned ahberr:1;
+		unsigned chhltd:1;
+		unsigned xfercompl:1;
+#else
+		unsigned xfercompl:1;
+		unsigned chhltd:1;
+		unsigned ahberr:1;
+		unsigned stall:1;
+		unsigned nak:1;
+		unsigned ack:1;
+		unsigned nyet:1;
+		unsigned xacterr:1;
+		unsigned bblerr:1;
+		unsigned frmovrun:1;
+		unsigned datatglerr:1;
+		unsigned reserved:21;
+#endif
+	} b;
+};
+
+/** OTG Host Interface Structure.
+ *
+ * The OTG Host Interface Structure structure contains information
+ * needed to manage the DWC_otg controller acting in host mode. It
+ * represents the programming view of the host-specific aspects of the
+ * controller.
+ */
+struct dwc_otg_host_if {
+	/* Host Global Registers starting at offset 400h.*/
+	struct dwc_otg_host_global_regs *host_global_regs;
+#define DWC_OTG_HOST_GLOBAL_REG_OFFSET 0x400
+
+	/* Host Port 0 Control and Status Register */
+	uint32_t *hprt0;
+#define DWC_OTG_HOST_PORT_REGS_OFFSET 0x440
+
+	/* Host Channel Specific Registers at offsets 500h-5FCh. */
+	struct dwc_otg_hc_regs *hc_regs[MAX_EPS_CHANNELS];
+#define DWC_OTG_HOST_CHAN_REGS_OFFSET 0x500
+#define DWC_OTG_CHAN_REGS_OFFSET 0x20
+
+	/* Host configuration information */
+	/* Number of Host Channels (range: 1-16) */
+	uint8_t num_host_channels;
+	/* Periodic EPs supported (0: no, 1: yes) */
+	uint8_t perio_eps_supported;
+	/* Periodic Tx FIFO Size (Only 1 host periodic Tx FIFO) */
+	uint16_t perio_tx_fifo_size;
+
+};
+
+/**
+ * This union represents the bit fields in the Power and Clock Gating Control
+ * Register. Read the register into the d32 member then set/clear the
+ * bits using the bit elements.
+ */
+union pcgcctl_data {
+	/* raw register data */
+	uint32_t d32;
+
+	/* register bits */
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		unsigned reserved:27;
+		unsigned physuspended:1;
+		unsigned rstpdwnmodule:1;
+		unsigned pwrclmp:1;
+		unsigned gatehclk:1;
+		unsigned stoppclk:1;
+#else
+
+		/* Stop Pclk */
+		unsigned stoppclk:1;
+		/* Gate Hclk */
+		unsigned gatehclk:1;
+		/* Power Clamp */
+		unsigned pwrclmp:1;
+		/* Reset Power Down Modules */
+		unsigned rstpdwnmodule:1;
+		/* PHY Suspended */
+		unsigned physuspended:1;
+
+		unsigned reserved:27;
+#endif
+	} b;
+};
+
+#endif
-- 
1.6.0.6
