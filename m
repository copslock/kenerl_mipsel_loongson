Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 02:16:04 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17623 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492981AbZJHAP6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 02:15:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4acd2f380000>; Wed, 07 Oct 2009 17:15:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 17:15:30 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 17:15:30 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n980FRIq012211;
	Wed, 7 Oct 2009 17:15:27 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n980FQMm012209;
	Wed, 7 Oct 2009 17:15:26 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-usb@vger.kernel.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon: Add USB platform device.
Date:	Wed,  7 Oct 2009 17:15:25 -0700
Message-Id: <1254960926-12185-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4ACD2EBF.8020901@caviumnetworks.com>
References: <4ACD2EBF.8020901@caviumnetworks.com>
X-OriginalArrivalTime: 08 Oct 2009 00:15:30.0115 (UTC) FILETIME=[71B58930:01CA47AC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c      |  105 ++
 arch/mips/include/asm/octeon/cvmx-usbcx-defs.h | 1199 ++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-usbnx-defs.h |  760 +++++++++++++++
 3 files changed, 2064 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-usbcx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-usbnx-defs.h

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index cfdb4c2..20698a6 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -7,13 +7,19 @@
  * Copyright (C) 2008 Wind River Systems
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#include <asm/time.h>
+
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-rnm-defs.h>
+#include <asm/octeon/cvmx-usbnx-defs.h>
+#include <asm/octeon/cvmx-usbcx-defs.h>
 
 static struct octeon_cf_data octeon_cf_data;
 
@@ -247,6 +253,105 @@ out:
 }
 device_initcall(octeon_mgmt_device_init);
 
+/* Octeon USB. */
+static int __init octeon_usb_device_init(void)
+{
+	int p_rtype_ref_clk = 2;
+	int number_usb_ports;
+	int usb_port;
+	int ret = 0;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+		number_usb_ports = 0;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		number_usb_ports = 2;
+		/* CN52XX encodes this field differently */
+		p_rtype_ref_clk = 1;
+	} else {
+		number_usb_ports = 1;
+	}
+
+	for (usb_port = 0; usb_port < number_usb_ports; usb_port++) {
+		int divisor;
+		union cvmx_usbnx_clk_ctl usbn_clk_ctl;
+		struct platform_device *pdev;
+		struct resource usb_resource[2];
+
+		/*
+		 * Divide the core clock down such that USB is as
+		 * close as possible to 125Mhz.
+		 */
+		divisor = DIV_ROUND_UP(mips_hpt_frequency, 125000000);
+		/* Lower than 4 doesn't seem to work properly */
+		if (divisor < 4)
+			divisor = 4;
+
+		/* Fetch the value of the Register, and de-assert POR */
+		usbn_clk_ctl.u64 = cvmx_read_csr(CVMX_USBNX_CLK_CTL(usb_port));
+		usbn_clk_ctl.s.por = 0;
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+			usbn_clk_ctl.cn31xx.p_rclk = 1;
+			usbn_clk_ctl.cn31xx.p_xenbn = 0;
+		} else {
+			if (cvmx_sysinfo_get()->board_type !=
+			    CVMX_BOARD_TYPE_BBGW_REF)
+				usbn_clk_ctl.cn56xx.p_rtype = p_rtype_ref_clk;
+			else
+				usbn_clk_ctl.cn56xx.p_rtype = 0;
+		}
+		usbn_clk_ctl.s.divide = divisor;
+		usbn_clk_ctl.s.divide2 = 0;
+		cvmx_write_csr(CVMX_USBNX_CLK_CTL(usb_port), usbn_clk_ctl.u64);
+
+		/* Wait for POR */
+		udelay(850);
+
+		usbn_clk_ctl.u64 = cvmx_read_csr(CVMX_USBNX_CLK_CTL(usb_port));
+		usbn_clk_ctl.s.por = 0;
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
+			usbn_clk_ctl.cn31xx.p_rclk = 1;
+			usbn_clk_ctl.cn31xx.p_xenbn = 0;
+		} else {
+			if (cvmx_sysinfo_get()->board_type !=
+			    CVMX_BOARD_TYPE_BBGW_REF)
+				usbn_clk_ctl.cn56xx.p_rtype = p_rtype_ref_clk;
+			else
+				usbn_clk_ctl.cn56xx.p_rtype = 0;
+		}
+		usbn_clk_ctl.s.prst = 1;
+		cvmx_write_csr(CVMX_USBNX_CLK_CTL(usb_port), usbn_clk_ctl.u64);
+
+		udelay(1);
+
+		usbn_clk_ctl.s.hrst = 1;
+		cvmx_write_csr(CVMX_USBNX_CLK_CTL(usb_port), usbn_clk_ctl.u64);
+		udelay(1);
+
+		memset(usb_resource, 0, sizeof(usb_resource));
+		usb_resource[0].start =
+			XKPHYS_TO_PHYS(CVMX_USBCX_GOTGCTL(usb_port));
+		usb_resource[0].end = usb_resource[0].start + 0x10000;
+		usb_resource[0].flags = IORESOURCE_MEM;
+
+		usb_resource[1].start = (usb_port == 0) ?
+			OCTEON_IRQ_USB0 : OCTEON_IRQ_USB1;
+		usb_resource[1].end = usb_resource[1].start;
+		usb_resource[1].flags = IORESOURCE_IRQ;
+
+		pdev = platform_device_register_simple("dwc_otg",
+						       usb_port,
+						       usb_resource, 2);
+		if (!pdev) {
+			pr_err("dwc_otg: Failed to allocate platform device "
+			       "for USB%d\n", usb_port);
+			ret = -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+device_initcall(octeon_usb_device_init);
+
 MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Platform driver for Octeon SOC");
diff --git a/arch/mips/include/asm/octeon/cvmx-usbcx-defs.h b/arch/mips/include/asm/octeon/cvmx-usbcx-defs.h
new file mode 100644
index 0000000..c1e078e
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-usbcx-defs.h
@@ -0,0 +1,1199 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_USBCX_DEFS_H__
+#define __CVMX_USBCX_DEFS_H__
+
+#define CVMX_USBCX_DAINT(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000818ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DAINTMSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001000081Cull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DCFG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000800ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DCTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000804ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DIEPCTLX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000900ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DIEPINTX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000908ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DIEPMSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000810ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DIEPTSIZX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000910ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DOEPCTLX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000B00ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DOEPINTX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000B08ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DOEPMSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000814ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DOEPTSIZX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000B10ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DPTXFSIZX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000100ull + (((offset) & 7) * 4) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DSTS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000808ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DTKNQR1(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000820ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DTKNQR2(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000824ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DTKNQR3(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000830ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_DTKNQR4(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000834ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GAHBCFG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000008ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GHWCFG1(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000044ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GHWCFG2(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000048ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GHWCFG3(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001000004Cull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GHWCFG4(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000050ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GINTMSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000018ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GINTSTS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000014ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GNPTXFSIZ(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000028ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GNPTXSTS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001000002Cull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GOTGCTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000000ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GOTGINT(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000004ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GRSTCTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000010ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GRXFSIZ(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000024ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GRXSTSPD(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010040020ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GRXSTSPH(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000020ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GRXSTSRD(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001004001Cull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GRXSTSRH(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001000001Cull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GSNPSID(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000040ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_GUSBCFG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001000000Cull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HAINT(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000414ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HAINTMSK(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000418ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HCCHARX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000500ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HCFG(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000400ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HCINTMSKX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F001000050Cull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HCINTX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000508ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HCSPLTX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000504ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HCTSIZX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000510ull + (((offset) & 7) * 32) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HFIR(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000404ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HFNUM(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000408ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HPRT(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000440ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HPTXFSIZ(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000100ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_HPTXSTS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000410ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_NPTXDFIFOX(offset, block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010001000ull + (((offset) & 7) * 4096) + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBCX_PCGCCTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0010000E00ull + (((block_id) & 1) * 0x100000000000ull))
+
+union cvmx_usbcx_daint {
+	uint32_t u32;
+	struct cvmx_usbcx_daint_s {
+		uint32_t outepint:16;
+		uint32_t inepint:16;
+	} s;
+	struct cvmx_usbcx_daint_s cn30xx;
+	struct cvmx_usbcx_daint_s cn31xx;
+	struct cvmx_usbcx_daint_s cn50xx;
+	struct cvmx_usbcx_daint_s cn52xx;
+	struct cvmx_usbcx_daint_s cn52xxp1;
+	struct cvmx_usbcx_daint_s cn56xx;
+	struct cvmx_usbcx_daint_s cn56xxp1;
+};
+
+union cvmx_usbcx_daintmsk {
+	uint32_t u32;
+	struct cvmx_usbcx_daintmsk_s {
+		uint32_t outepmsk:16;
+		uint32_t inepmsk:16;
+	} s;
+	struct cvmx_usbcx_daintmsk_s cn30xx;
+	struct cvmx_usbcx_daintmsk_s cn31xx;
+	struct cvmx_usbcx_daintmsk_s cn50xx;
+	struct cvmx_usbcx_daintmsk_s cn52xx;
+	struct cvmx_usbcx_daintmsk_s cn52xxp1;
+	struct cvmx_usbcx_daintmsk_s cn56xx;
+	struct cvmx_usbcx_daintmsk_s cn56xxp1;
+};
+
+union cvmx_usbcx_dcfg {
+	uint32_t u32;
+	struct cvmx_usbcx_dcfg_s {
+		uint32_t reserved_23_31:9;
+		uint32_t epmiscnt:5;
+		uint32_t reserved_13_17:5;
+		uint32_t perfrint:2;
+		uint32_t devaddr:7;
+		uint32_t reserved_3_3:1;
+		uint32_t nzstsouthshk:1;
+		uint32_t devspd:2;
+	} s;
+	struct cvmx_usbcx_dcfg_s cn30xx;
+	struct cvmx_usbcx_dcfg_s cn31xx;
+	struct cvmx_usbcx_dcfg_s cn50xx;
+	struct cvmx_usbcx_dcfg_s cn52xx;
+	struct cvmx_usbcx_dcfg_s cn52xxp1;
+	struct cvmx_usbcx_dcfg_s cn56xx;
+	struct cvmx_usbcx_dcfg_s cn56xxp1;
+};
+
+union cvmx_usbcx_dctl {
+	uint32_t u32;
+	struct cvmx_usbcx_dctl_s {
+		uint32_t reserved_12_31:20;
+		uint32_t pwronprgdone:1;
+		uint32_t cgoutnak:1;
+		uint32_t sgoutnak:1;
+		uint32_t cgnpinnak:1;
+		uint32_t sgnpinnak:1;
+		uint32_t tstctl:3;
+		uint32_t goutnaksts:1;
+		uint32_t gnpinnaksts:1;
+		uint32_t sftdiscon:1;
+		uint32_t rmtwkupsig:1;
+	} s;
+	struct cvmx_usbcx_dctl_s cn30xx;
+	struct cvmx_usbcx_dctl_s cn31xx;
+	struct cvmx_usbcx_dctl_s cn50xx;
+	struct cvmx_usbcx_dctl_s cn52xx;
+	struct cvmx_usbcx_dctl_s cn52xxp1;
+	struct cvmx_usbcx_dctl_s cn56xx;
+	struct cvmx_usbcx_dctl_s cn56xxp1;
+};
+
+union cvmx_usbcx_diepctlx {
+	uint32_t u32;
+	struct cvmx_usbcx_diepctlx_s {
+		uint32_t epena:1;
+		uint32_t epdis:1;
+		uint32_t setd1pid:1;
+		uint32_t setd0pid:1;
+		uint32_t snak:1;
+		uint32_t cnak:1;
+		uint32_t txfnum:4;
+		uint32_t stall:1;
+		uint32_t reserved_20_20:1;
+		uint32_t eptype:2;
+		uint32_t naksts:1;
+		uint32_t dpid:1;
+		uint32_t usbactep:1;
+		uint32_t nextep:4;
+		uint32_t mps:11;
+	} s;
+	struct cvmx_usbcx_diepctlx_s cn30xx;
+	struct cvmx_usbcx_diepctlx_s cn31xx;
+	struct cvmx_usbcx_diepctlx_s cn50xx;
+	struct cvmx_usbcx_diepctlx_s cn52xx;
+	struct cvmx_usbcx_diepctlx_s cn52xxp1;
+	struct cvmx_usbcx_diepctlx_s cn56xx;
+	struct cvmx_usbcx_diepctlx_s cn56xxp1;
+};
+
+union cvmx_usbcx_diepintx {
+	uint32_t u32;
+	struct cvmx_usbcx_diepintx_s {
+		uint32_t reserved_7_31:25;
+		uint32_t inepnakeff:1;
+		uint32_t intknepmis:1;
+		uint32_t intkntxfemp:1;
+		uint32_t timeout:1;
+		uint32_t ahberr:1;
+		uint32_t epdisbld:1;
+		uint32_t xfercompl:1;
+	} s;
+	struct cvmx_usbcx_diepintx_s cn30xx;
+	struct cvmx_usbcx_diepintx_s cn31xx;
+	struct cvmx_usbcx_diepintx_s cn50xx;
+	struct cvmx_usbcx_diepintx_s cn52xx;
+	struct cvmx_usbcx_diepintx_s cn52xxp1;
+	struct cvmx_usbcx_diepintx_s cn56xx;
+	struct cvmx_usbcx_diepintx_s cn56xxp1;
+};
+
+union cvmx_usbcx_diepmsk {
+	uint32_t u32;
+	struct cvmx_usbcx_diepmsk_s {
+		uint32_t reserved_7_31:25;
+		uint32_t inepnakeffmsk:1;
+		uint32_t intknepmismsk:1;
+		uint32_t intkntxfempmsk:1;
+		uint32_t timeoutmsk:1;
+		uint32_t ahberrmsk:1;
+		uint32_t epdisbldmsk:1;
+		uint32_t xfercomplmsk:1;
+	} s;
+	struct cvmx_usbcx_diepmsk_s cn30xx;
+	struct cvmx_usbcx_diepmsk_s cn31xx;
+	struct cvmx_usbcx_diepmsk_s cn50xx;
+	struct cvmx_usbcx_diepmsk_s cn52xx;
+	struct cvmx_usbcx_diepmsk_s cn52xxp1;
+	struct cvmx_usbcx_diepmsk_s cn56xx;
+	struct cvmx_usbcx_diepmsk_s cn56xxp1;
+};
+
+union cvmx_usbcx_dieptsizx {
+	uint32_t u32;
+	struct cvmx_usbcx_dieptsizx_s {
+		uint32_t reserved_31_31:1;
+		uint32_t mc:2;
+		uint32_t pktcnt:10;
+		uint32_t xfersize:19;
+	} s;
+	struct cvmx_usbcx_dieptsizx_s cn30xx;
+	struct cvmx_usbcx_dieptsizx_s cn31xx;
+	struct cvmx_usbcx_dieptsizx_s cn50xx;
+	struct cvmx_usbcx_dieptsizx_s cn52xx;
+	struct cvmx_usbcx_dieptsizx_s cn52xxp1;
+	struct cvmx_usbcx_dieptsizx_s cn56xx;
+	struct cvmx_usbcx_dieptsizx_s cn56xxp1;
+};
+
+union cvmx_usbcx_doepctlx {
+	uint32_t u32;
+	struct cvmx_usbcx_doepctlx_s {
+		uint32_t epena:1;
+		uint32_t epdis:1;
+		uint32_t setd1pid:1;
+		uint32_t setd0pid:1;
+		uint32_t snak:1;
+		uint32_t cnak:1;
+		uint32_t reserved_22_25:4;
+		uint32_t stall:1;
+		uint32_t snp:1;
+		uint32_t eptype:2;
+		uint32_t naksts:1;
+		uint32_t dpid:1;
+		uint32_t usbactep:1;
+		uint32_t reserved_11_14:4;
+		uint32_t mps:11;
+	} s;
+	struct cvmx_usbcx_doepctlx_s cn30xx;
+	struct cvmx_usbcx_doepctlx_s cn31xx;
+	struct cvmx_usbcx_doepctlx_s cn50xx;
+	struct cvmx_usbcx_doepctlx_s cn52xx;
+	struct cvmx_usbcx_doepctlx_s cn52xxp1;
+	struct cvmx_usbcx_doepctlx_s cn56xx;
+	struct cvmx_usbcx_doepctlx_s cn56xxp1;
+};
+
+union cvmx_usbcx_doepintx {
+	uint32_t u32;
+	struct cvmx_usbcx_doepintx_s {
+		uint32_t reserved_5_31:27;
+		uint32_t outtknepdis:1;
+		uint32_t setup:1;
+		uint32_t ahberr:1;
+		uint32_t epdisbld:1;
+		uint32_t xfercompl:1;
+	} s;
+	struct cvmx_usbcx_doepintx_s cn30xx;
+	struct cvmx_usbcx_doepintx_s cn31xx;
+	struct cvmx_usbcx_doepintx_s cn50xx;
+	struct cvmx_usbcx_doepintx_s cn52xx;
+	struct cvmx_usbcx_doepintx_s cn52xxp1;
+	struct cvmx_usbcx_doepintx_s cn56xx;
+	struct cvmx_usbcx_doepintx_s cn56xxp1;
+};
+
+union cvmx_usbcx_doepmsk {
+	uint32_t u32;
+	struct cvmx_usbcx_doepmsk_s {
+		uint32_t reserved_5_31:27;
+		uint32_t outtknepdismsk:1;
+		uint32_t setupmsk:1;
+		uint32_t ahberrmsk:1;
+		uint32_t epdisbldmsk:1;
+		uint32_t xfercomplmsk:1;
+	} s;
+	struct cvmx_usbcx_doepmsk_s cn30xx;
+	struct cvmx_usbcx_doepmsk_s cn31xx;
+	struct cvmx_usbcx_doepmsk_s cn50xx;
+	struct cvmx_usbcx_doepmsk_s cn52xx;
+	struct cvmx_usbcx_doepmsk_s cn52xxp1;
+	struct cvmx_usbcx_doepmsk_s cn56xx;
+	struct cvmx_usbcx_doepmsk_s cn56xxp1;
+};
+
+union cvmx_usbcx_doeptsizx {
+	uint32_t u32;
+	struct cvmx_usbcx_doeptsizx_s {
+		uint32_t reserved_31_31:1;
+		uint32_t mc:2;
+		uint32_t pktcnt:10;
+		uint32_t xfersize:19;
+	} s;
+	struct cvmx_usbcx_doeptsizx_s cn30xx;
+	struct cvmx_usbcx_doeptsizx_s cn31xx;
+	struct cvmx_usbcx_doeptsizx_s cn50xx;
+	struct cvmx_usbcx_doeptsizx_s cn52xx;
+	struct cvmx_usbcx_doeptsizx_s cn52xxp1;
+	struct cvmx_usbcx_doeptsizx_s cn56xx;
+	struct cvmx_usbcx_doeptsizx_s cn56xxp1;
+};
+
+union cvmx_usbcx_dptxfsizx {
+	uint32_t u32;
+	struct cvmx_usbcx_dptxfsizx_s {
+		uint32_t dptxfsize:16;
+		uint32_t dptxfstaddr:16;
+	} s;
+	struct cvmx_usbcx_dptxfsizx_s cn30xx;
+	struct cvmx_usbcx_dptxfsizx_s cn31xx;
+	struct cvmx_usbcx_dptxfsizx_s cn50xx;
+	struct cvmx_usbcx_dptxfsizx_s cn52xx;
+	struct cvmx_usbcx_dptxfsizx_s cn52xxp1;
+	struct cvmx_usbcx_dptxfsizx_s cn56xx;
+	struct cvmx_usbcx_dptxfsizx_s cn56xxp1;
+};
+
+union cvmx_usbcx_dsts {
+	uint32_t u32;
+	struct cvmx_usbcx_dsts_s {
+		uint32_t reserved_22_31:10;
+		uint32_t soffn:14;
+		uint32_t reserved_4_7:4;
+		uint32_t errticerr:1;
+		uint32_t enumspd:2;
+		uint32_t suspsts:1;
+	} s;
+	struct cvmx_usbcx_dsts_s cn30xx;
+	struct cvmx_usbcx_dsts_s cn31xx;
+	struct cvmx_usbcx_dsts_s cn50xx;
+	struct cvmx_usbcx_dsts_s cn52xx;
+	struct cvmx_usbcx_dsts_s cn52xxp1;
+	struct cvmx_usbcx_dsts_s cn56xx;
+	struct cvmx_usbcx_dsts_s cn56xxp1;
+};
+
+union cvmx_usbcx_dtknqr1 {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr1_s {
+		uint32_t eptkn:24;
+		uint32_t wrapbit:1;
+		uint32_t reserved_5_6:2;
+		uint32_t intknwptr:5;
+	} s;
+	struct cvmx_usbcx_dtknqr1_s cn30xx;
+	struct cvmx_usbcx_dtknqr1_s cn31xx;
+	struct cvmx_usbcx_dtknqr1_s cn50xx;
+	struct cvmx_usbcx_dtknqr1_s cn52xx;
+	struct cvmx_usbcx_dtknqr1_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr1_s cn56xx;
+	struct cvmx_usbcx_dtknqr1_s cn56xxp1;
+};
+
+union cvmx_usbcx_dtknqr2 {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr2_s {
+		uint32_t eptkn:32;
+	} s;
+	struct cvmx_usbcx_dtknqr2_s cn30xx;
+	struct cvmx_usbcx_dtknqr2_s cn31xx;
+	struct cvmx_usbcx_dtknqr2_s cn50xx;
+	struct cvmx_usbcx_dtknqr2_s cn52xx;
+	struct cvmx_usbcx_dtknqr2_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr2_s cn56xx;
+	struct cvmx_usbcx_dtknqr2_s cn56xxp1;
+};
+
+union cvmx_usbcx_dtknqr3 {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr3_s {
+		uint32_t eptkn:32;
+	} s;
+	struct cvmx_usbcx_dtknqr3_s cn30xx;
+	struct cvmx_usbcx_dtknqr3_s cn31xx;
+	struct cvmx_usbcx_dtknqr3_s cn50xx;
+	struct cvmx_usbcx_dtknqr3_s cn52xx;
+	struct cvmx_usbcx_dtknqr3_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr3_s cn56xx;
+	struct cvmx_usbcx_dtknqr3_s cn56xxp1;
+};
+
+union cvmx_usbcx_dtknqr4 {
+	uint32_t u32;
+	struct cvmx_usbcx_dtknqr4_s {
+		uint32_t eptkn:32;
+	} s;
+	struct cvmx_usbcx_dtknqr4_s cn30xx;
+	struct cvmx_usbcx_dtknqr4_s cn31xx;
+	struct cvmx_usbcx_dtknqr4_s cn50xx;
+	struct cvmx_usbcx_dtknqr4_s cn52xx;
+	struct cvmx_usbcx_dtknqr4_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr4_s cn56xx;
+	struct cvmx_usbcx_dtknqr4_s cn56xxp1;
+};
+
+union cvmx_usbcx_gahbcfg {
+	uint32_t u32;
+	struct cvmx_usbcx_gahbcfg_s {
+		uint32_t reserved_9_31:23;
+		uint32_t ptxfemplvl:1;
+		uint32_t nptxfemplvl:1;
+		uint32_t reserved_6_6:1;
+		uint32_t dmaen:1;
+		uint32_t hbstlen:4;
+		uint32_t glblintrmsk:1;
+	} s;
+	struct cvmx_usbcx_gahbcfg_s cn30xx;
+	struct cvmx_usbcx_gahbcfg_s cn31xx;
+	struct cvmx_usbcx_gahbcfg_s cn50xx;
+	struct cvmx_usbcx_gahbcfg_s cn52xx;
+	struct cvmx_usbcx_gahbcfg_s cn52xxp1;
+	struct cvmx_usbcx_gahbcfg_s cn56xx;
+	struct cvmx_usbcx_gahbcfg_s cn56xxp1;
+};
+
+union cvmx_usbcx_ghwcfg1 {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg1_s {
+		uint32_t epdir:32;
+	} s;
+	struct cvmx_usbcx_ghwcfg1_s cn30xx;
+	struct cvmx_usbcx_ghwcfg1_s cn31xx;
+	struct cvmx_usbcx_ghwcfg1_s cn50xx;
+	struct cvmx_usbcx_ghwcfg1_s cn52xx;
+	struct cvmx_usbcx_ghwcfg1_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg1_s cn56xx;
+	struct cvmx_usbcx_ghwcfg1_s cn56xxp1;
+};
+
+union cvmx_usbcx_ghwcfg2 {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg2_s {
+		uint32_t reserved_31_31:1;
+		uint32_t tknqdepth:5;
+		uint32_t ptxqdepth:2;
+		uint32_t nptxqdepth:2;
+		uint32_t reserved_20_21:2;
+		uint32_t dynfifosizing:1;
+		uint32_t periosupport:1;
+		uint32_t numhstchnl:4;
+		uint32_t numdeveps:4;
+		uint32_t fsphytype:2;
+		uint32_t hsphytype:2;
+		uint32_t singpnt:1;
+		uint32_t otgarch:2;
+		uint32_t otgmode:3;
+	} s;
+	struct cvmx_usbcx_ghwcfg2_s cn30xx;
+	struct cvmx_usbcx_ghwcfg2_s cn31xx;
+	struct cvmx_usbcx_ghwcfg2_s cn50xx;
+	struct cvmx_usbcx_ghwcfg2_s cn52xx;
+	struct cvmx_usbcx_ghwcfg2_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg2_s cn56xx;
+	struct cvmx_usbcx_ghwcfg2_s cn56xxp1;
+};
+
+union cvmx_usbcx_ghwcfg3 {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg3_s {
+		uint32_t dfifodepth:16;
+		uint32_t reserved_13_15:3;
+		uint32_t ahbphysync:1;
+		uint32_t rsttype:1;
+		uint32_t optfeature:1;
+		uint32_t vendor_control_interface_support:1;
+		uint32_t i2c_selection:1;
+		uint32_t otgen:1;
+		uint32_t pktsizewidth:3;
+		uint32_t xfersizewidth:4;
+	} s;
+	struct cvmx_usbcx_ghwcfg3_s cn30xx;
+	struct cvmx_usbcx_ghwcfg3_s cn31xx;
+	struct cvmx_usbcx_ghwcfg3_s cn50xx;
+	struct cvmx_usbcx_ghwcfg3_s cn52xx;
+	struct cvmx_usbcx_ghwcfg3_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg3_s cn56xx;
+	struct cvmx_usbcx_ghwcfg3_s cn56xxp1;
+};
+
+union cvmx_usbcx_ghwcfg4 {
+	uint32_t u32;
+	struct cvmx_usbcx_ghwcfg4_s {
+		uint32_t reserved_30_31:2;
+		uint32_t numdevmodinend:4;
+		uint32_t endedtrfifo:1;
+		uint32_t sessendfltr:1;
+		uint32_t bvalidfltr:1;
+		uint32_t avalidfltr:1;
+		uint32_t vbusvalidfltr:1;
+		uint32_t iddgfltr:1;
+		uint32_t numctleps:4;
+		uint32_t phydatawidth:2;
+		uint32_t reserved_6_13:8;
+		uint32_t ahbfreq:1;
+		uint32_t enablepwropt:1;
+		uint32_t numdevperioeps:4;
+	} s;
+	struct cvmx_usbcx_ghwcfg4_cn30xx {
+		uint32_t reserved_25_31:7;
+		uint32_t sessendfltr:1;
+		uint32_t bvalidfltr:1;
+		uint32_t avalidfltr:1;
+		uint32_t vbusvalidfltr:1;
+		uint32_t iddgfltr:1;
+		uint32_t numctleps:4;
+		uint32_t phydatawidth:2;
+		uint32_t reserved_6_13:8;
+		uint32_t ahbfreq:1;
+		uint32_t enablepwropt:1;
+		uint32_t numdevperioeps:4;
+	} cn30xx;
+	struct cvmx_usbcx_ghwcfg4_cn30xx cn31xx;
+	struct cvmx_usbcx_ghwcfg4_s cn50xx;
+	struct cvmx_usbcx_ghwcfg4_s cn52xx;
+	struct cvmx_usbcx_ghwcfg4_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg4_s cn56xx;
+	struct cvmx_usbcx_ghwcfg4_s cn56xxp1;
+};
+
+union cvmx_usbcx_gintmsk {
+	uint32_t u32;
+	struct cvmx_usbcx_gintmsk_s {
+		uint32_t wkupintmsk:1;
+		uint32_t sessreqintmsk:1;
+		uint32_t disconnintmsk:1;
+		uint32_t conidstschngmsk:1;
+		uint32_t reserved_27_27:1;
+		uint32_t ptxfempmsk:1;
+		uint32_t hchintmsk:1;
+		uint32_t prtintmsk:1;
+		uint32_t reserved_23_23:1;
+		uint32_t fetsuspmsk:1;
+		uint32_t incomplpmsk:1;
+		uint32_t incompisoinmsk:1;
+		uint32_t oepintmsk:1;
+		uint32_t inepintmsk:1;
+		uint32_t epmismsk:1;
+		uint32_t reserved_16_16:1;
+		uint32_t eopfmsk:1;
+		uint32_t isooutdropmsk:1;
+		uint32_t enumdonemsk:1;
+		uint32_t usbrstmsk:1;
+		uint32_t usbsuspmsk:1;
+		uint32_t erlysuspmsk:1;
+		uint32_t i2cint:1;
+		uint32_t ulpickintmsk:1;
+		uint32_t goutnakeffmsk:1;
+		uint32_t ginnakeffmsk:1;
+		uint32_t nptxfempmsk:1;
+		uint32_t rxflvlmsk:1;
+		uint32_t sofmsk:1;
+		uint32_t otgintmsk:1;
+		uint32_t modemismsk:1;
+		uint32_t reserved_0_0:1;
+	} s;
+	struct cvmx_usbcx_gintmsk_s cn30xx;
+	struct cvmx_usbcx_gintmsk_s cn31xx;
+	struct cvmx_usbcx_gintmsk_s cn50xx;
+	struct cvmx_usbcx_gintmsk_s cn52xx;
+	struct cvmx_usbcx_gintmsk_s cn52xxp1;
+	struct cvmx_usbcx_gintmsk_s cn56xx;
+	struct cvmx_usbcx_gintmsk_s cn56xxp1;
+};
+
+union cvmx_usbcx_gintsts {
+	uint32_t u32;
+	struct cvmx_usbcx_gintsts_s {
+		uint32_t wkupint:1;
+		uint32_t sessreqint:1;
+		uint32_t disconnint:1;
+		uint32_t conidstschng:1;
+		uint32_t reserved_27_27:1;
+		uint32_t ptxfemp:1;
+		uint32_t hchint:1;
+		uint32_t prtint:1;
+		uint32_t reserved_23_23:1;
+		uint32_t fetsusp:1;
+		uint32_t incomplp:1;
+		uint32_t incompisoin:1;
+		uint32_t oepint:1;
+		uint32_t iepint:1;
+		uint32_t epmis:1;
+		uint32_t reserved_16_16:1;
+		uint32_t eopf:1;
+		uint32_t isooutdrop:1;
+		uint32_t enumdone:1;
+		uint32_t usbrst:1;
+		uint32_t usbsusp:1;
+		uint32_t erlysusp:1;
+		uint32_t i2cint:1;
+		uint32_t ulpickint:1;
+		uint32_t goutnakeff:1;
+		uint32_t ginnakeff:1;
+		uint32_t nptxfemp:1;
+		uint32_t rxflvl:1;
+		uint32_t sof:1;
+		uint32_t otgint:1;
+		uint32_t modemis:1;
+		uint32_t curmod:1;
+	} s;
+	struct cvmx_usbcx_gintsts_s cn30xx;
+	struct cvmx_usbcx_gintsts_s cn31xx;
+	struct cvmx_usbcx_gintsts_s cn50xx;
+	struct cvmx_usbcx_gintsts_s cn52xx;
+	struct cvmx_usbcx_gintsts_s cn52xxp1;
+	struct cvmx_usbcx_gintsts_s cn56xx;
+	struct cvmx_usbcx_gintsts_s cn56xxp1;
+};
+
+union cvmx_usbcx_gnptxfsiz {
+	uint32_t u32;
+	struct cvmx_usbcx_gnptxfsiz_s {
+		uint32_t nptxfdep:16;
+		uint32_t nptxfstaddr:16;
+	} s;
+	struct cvmx_usbcx_gnptxfsiz_s cn30xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn31xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn50xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn52xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_gnptxfsiz_s cn56xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn56xxp1;
+};
+
+union cvmx_usbcx_gnptxsts {
+	uint32_t u32;
+	struct cvmx_usbcx_gnptxsts_s {
+		uint32_t reserved_31_31:1;
+		uint32_t nptxqtop:7;
+		uint32_t nptxqspcavail:8;
+		uint32_t nptxfspcavail:16;
+	} s;
+	struct cvmx_usbcx_gnptxsts_s cn30xx;
+	struct cvmx_usbcx_gnptxsts_s cn31xx;
+	struct cvmx_usbcx_gnptxsts_s cn50xx;
+	struct cvmx_usbcx_gnptxsts_s cn52xx;
+	struct cvmx_usbcx_gnptxsts_s cn52xxp1;
+	struct cvmx_usbcx_gnptxsts_s cn56xx;
+	struct cvmx_usbcx_gnptxsts_s cn56xxp1;
+};
+
+union cvmx_usbcx_gotgctl {
+	uint32_t u32;
+	struct cvmx_usbcx_gotgctl_s {
+		uint32_t reserved_20_31:12;
+		uint32_t bsesvld:1;
+		uint32_t asesvld:1;
+		uint32_t dbnctime:1;
+		uint32_t conidsts:1;
+		uint32_t reserved_12_15:4;
+		uint32_t devhnpen:1;
+		uint32_t hstsethnpen:1;
+		uint32_t hnpreq:1;
+		uint32_t hstnegscs:1;
+		uint32_t reserved_2_7:6;
+		uint32_t sesreq:1;
+		uint32_t sesreqscs:1;
+	} s;
+	struct cvmx_usbcx_gotgctl_s cn30xx;
+	struct cvmx_usbcx_gotgctl_s cn31xx;
+	struct cvmx_usbcx_gotgctl_s cn50xx;
+	struct cvmx_usbcx_gotgctl_s cn52xx;
+	struct cvmx_usbcx_gotgctl_s cn52xxp1;
+	struct cvmx_usbcx_gotgctl_s cn56xx;
+	struct cvmx_usbcx_gotgctl_s cn56xxp1;
+};
+
+union cvmx_usbcx_gotgint {
+	uint32_t u32;
+	struct cvmx_usbcx_gotgint_s {
+		uint32_t reserved_20_31:12;
+		uint32_t dbncedone:1;
+		uint32_t adevtoutchg:1;
+		uint32_t hstnegdet:1;
+		uint32_t reserved_10_16:7;
+		uint32_t hstnegsucstschng:1;
+		uint32_t sesreqsucstschng:1;
+		uint32_t reserved_3_7:5;
+		uint32_t sesenddet:1;
+		uint32_t reserved_0_1:2;
+	} s;
+	struct cvmx_usbcx_gotgint_s cn30xx;
+	struct cvmx_usbcx_gotgint_s cn31xx;
+	struct cvmx_usbcx_gotgint_s cn50xx;
+	struct cvmx_usbcx_gotgint_s cn52xx;
+	struct cvmx_usbcx_gotgint_s cn52xxp1;
+	struct cvmx_usbcx_gotgint_s cn56xx;
+	struct cvmx_usbcx_gotgint_s cn56xxp1;
+};
+
+union cvmx_usbcx_grstctl {
+	uint32_t u32;
+	struct cvmx_usbcx_grstctl_s {
+		uint32_t ahbidle:1;
+		uint32_t dmareq:1;
+		uint32_t reserved_11_29:19;
+		uint32_t txfnum:5;
+		uint32_t txfflsh:1;
+		uint32_t rxfflsh:1;
+		uint32_t intknqflsh:1;
+		uint32_t frmcntrrst:1;
+		uint32_t hsftrst:1;
+		uint32_t csftrst:1;
+	} s;
+	struct cvmx_usbcx_grstctl_s cn30xx;
+	struct cvmx_usbcx_grstctl_s cn31xx;
+	struct cvmx_usbcx_grstctl_s cn50xx;
+	struct cvmx_usbcx_grstctl_s cn52xx;
+	struct cvmx_usbcx_grstctl_s cn52xxp1;
+	struct cvmx_usbcx_grstctl_s cn56xx;
+	struct cvmx_usbcx_grstctl_s cn56xxp1;
+};
+
+union cvmx_usbcx_grxfsiz {
+	uint32_t u32;
+	struct cvmx_usbcx_grxfsiz_s {
+		uint32_t reserved_16_31:16;
+		uint32_t rxfdep:16;
+	} s;
+	struct cvmx_usbcx_grxfsiz_s cn30xx;
+	struct cvmx_usbcx_grxfsiz_s cn31xx;
+	struct cvmx_usbcx_grxfsiz_s cn50xx;
+	struct cvmx_usbcx_grxfsiz_s cn52xx;
+	struct cvmx_usbcx_grxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_grxfsiz_s cn56xx;
+	struct cvmx_usbcx_grxfsiz_s cn56xxp1;
+};
+
+union cvmx_usbcx_grxstspd {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstspd_s {
+		uint32_t reserved_25_31:7;
+		uint32_t fn:4;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t epnum:4;
+	} s;
+	struct cvmx_usbcx_grxstspd_s cn30xx;
+	struct cvmx_usbcx_grxstspd_s cn31xx;
+	struct cvmx_usbcx_grxstspd_s cn50xx;
+	struct cvmx_usbcx_grxstspd_s cn52xx;
+	struct cvmx_usbcx_grxstspd_s cn52xxp1;
+	struct cvmx_usbcx_grxstspd_s cn56xx;
+	struct cvmx_usbcx_grxstspd_s cn56xxp1;
+};
+
+union cvmx_usbcx_grxstsph {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsph_s {
+		uint32_t reserved_21_31:11;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t chnum:4;
+	} s;
+	struct cvmx_usbcx_grxstsph_s cn30xx;
+	struct cvmx_usbcx_grxstsph_s cn31xx;
+	struct cvmx_usbcx_grxstsph_s cn50xx;
+	struct cvmx_usbcx_grxstsph_s cn52xx;
+	struct cvmx_usbcx_grxstsph_s cn52xxp1;
+	struct cvmx_usbcx_grxstsph_s cn56xx;
+	struct cvmx_usbcx_grxstsph_s cn56xxp1;
+};
+
+union cvmx_usbcx_grxstsrd {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsrd_s {
+		uint32_t reserved_25_31:7;
+		uint32_t fn:4;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t epnum:4;
+	} s;
+	struct cvmx_usbcx_grxstsrd_s cn30xx;
+	struct cvmx_usbcx_grxstsrd_s cn31xx;
+	struct cvmx_usbcx_grxstsrd_s cn50xx;
+	struct cvmx_usbcx_grxstsrd_s cn52xx;
+	struct cvmx_usbcx_grxstsrd_s cn52xxp1;
+	struct cvmx_usbcx_grxstsrd_s cn56xx;
+	struct cvmx_usbcx_grxstsrd_s cn56xxp1;
+};
+
+union cvmx_usbcx_grxstsrh {
+	uint32_t u32;
+	struct cvmx_usbcx_grxstsrh_s {
+		uint32_t reserved_21_31:11;
+		uint32_t pktsts:4;
+		uint32_t dpid:2;
+		uint32_t bcnt:11;
+		uint32_t chnum:4;
+	} s;
+	struct cvmx_usbcx_grxstsrh_s cn30xx;
+	struct cvmx_usbcx_grxstsrh_s cn31xx;
+	struct cvmx_usbcx_grxstsrh_s cn50xx;
+	struct cvmx_usbcx_grxstsrh_s cn52xx;
+	struct cvmx_usbcx_grxstsrh_s cn52xxp1;
+	struct cvmx_usbcx_grxstsrh_s cn56xx;
+	struct cvmx_usbcx_grxstsrh_s cn56xxp1;
+};
+
+union cvmx_usbcx_gsnpsid {
+	uint32_t u32;
+	struct cvmx_usbcx_gsnpsid_s {
+		uint32_t synopsysid:32;
+	} s;
+	struct cvmx_usbcx_gsnpsid_s cn30xx;
+	struct cvmx_usbcx_gsnpsid_s cn31xx;
+	struct cvmx_usbcx_gsnpsid_s cn50xx;
+	struct cvmx_usbcx_gsnpsid_s cn52xx;
+	struct cvmx_usbcx_gsnpsid_s cn52xxp1;
+	struct cvmx_usbcx_gsnpsid_s cn56xx;
+	struct cvmx_usbcx_gsnpsid_s cn56xxp1;
+};
+
+union cvmx_usbcx_gusbcfg {
+	uint32_t u32;
+	struct cvmx_usbcx_gusbcfg_s {
+		uint32_t reserved_17_31:15;
+		uint32_t otgi2csel:1;
+		uint32_t phylpwrclksel:1;
+		uint32_t reserved_14_14:1;
+		uint32_t usbtrdtim:4;
+		uint32_t hnpcap:1;
+		uint32_t srpcap:1;
+		uint32_t ddrsel:1;
+		uint32_t physel:1;
+		uint32_t fsintf:1;
+		uint32_t ulpi_utmi_sel:1;
+		uint32_t phyif:1;
+		uint32_t toutcal:3;
+	} s;
+	struct cvmx_usbcx_gusbcfg_s cn30xx;
+	struct cvmx_usbcx_gusbcfg_s cn31xx;
+	struct cvmx_usbcx_gusbcfg_s cn50xx;
+	struct cvmx_usbcx_gusbcfg_s cn52xx;
+	struct cvmx_usbcx_gusbcfg_s cn52xxp1;
+	struct cvmx_usbcx_gusbcfg_s cn56xx;
+	struct cvmx_usbcx_gusbcfg_s cn56xxp1;
+};
+
+union cvmx_usbcx_haint {
+	uint32_t u32;
+	struct cvmx_usbcx_haint_s {
+		uint32_t reserved_16_31:16;
+		uint32_t haint:16;
+	} s;
+	struct cvmx_usbcx_haint_s cn30xx;
+	struct cvmx_usbcx_haint_s cn31xx;
+	struct cvmx_usbcx_haint_s cn50xx;
+	struct cvmx_usbcx_haint_s cn52xx;
+	struct cvmx_usbcx_haint_s cn52xxp1;
+	struct cvmx_usbcx_haint_s cn56xx;
+	struct cvmx_usbcx_haint_s cn56xxp1;
+};
+
+union cvmx_usbcx_haintmsk {
+	uint32_t u32;
+	struct cvmx_usbcx_haintmsk_s {
+		uint32_t reserved_16_31:16;
+		uint32_t haintmsk:16;
+	} s;
+	struct cvmx_usbcx_haintmsk_s cn30xx;
+	struct cvmx_usbcx_haintmsk_s cn31xx;
+	struct cvmx_usbcx_haintmsk_s cn50xx;
+	struct cvmx_usbcx_haintmsk_s cn52xx;
+	struct cvmx_usbcx_haintmsk_s cn52xxp1;
+	struct cvmx_usbcx_haintmsk_s cn56xx;
+	struct cvmx_usbcx_haintmsk_s cn56xxp1;
+};
+
+union cvmx_usbcx_hccharx {
+	uint32_t u32;
+	struct cvmx_usbcx_hccharx_s {
+		uint32_t chena:1;
+		uint32_t chdis:1;
+		uint32_t oddfrm:1;
+		uint32_t devaddr:7;
+		uint32_t ec:2;
+		uint32_t eptype:2;
+		uint32_t lspddev:1;
+		uint32_t reserved_16_16:1;
+		uint32_t epdir:1;
+		uint32_t epnum:4;
+		uint32_t mps:11;
+	} s;
+	struct cvmx_usbcx_hccharx_s cn30xx;
+	struct cvmx_usbcx_hccharx_s cn31xx;
+	struct cvmx_usbcx_hccharx_s cn50xx;
+	struct cvmx_usbcx_hccharx_s cn52xx;
+	struct cvmx_usbcx_hccharx_s cn52xxp1;
+	struct cvmx_usbcx_hccharx_s cn56xx;
+	struct cvmx_usbcx_hccharx_s cn56xxp1;
+};
+
+union cvmx_usbcx_hcfg {
+	uint32_t u32;
+	struct cvmx_usbcx_hcfg_s {
+		uint32_t reserved_3_31:29;
+		uint32_t fslssupp:1;
+		uint32_t fslspclksel:2;
+	} s;
+	struct cvmx_usbcx_hcfg_s cn30xx;
+	struct cvmx_usbcx_hcfg_s cn31xx;
+	struct cvmx_usbcx_hcfg_s cn50xx;
+	struct cvmx_usbcx_hcfg_s cn52xx;
+	struct cvmx_usbcx_hcfg_s cn52xxp1;
+	struct cvmx_usbcx_hcfg_s cn56xx;
+	struct cvmx_usbcx_hcfg_s cn56xxp1;
+};
+
+union cvmx_usbcx_hcintx {
+	uint32_t u32;
+	struct cvmx_usbcx_hcintx_s {
+		uint32_t reserved_11_31:21;
+		uint32_t datatglerr:1;
+		uint32_t frmovrun:1;
+		uint32_t bblerr:1;
+		uint32_t xacterr:1;
+		uint32_t nyet:1;
+		uint32_t ack:1;
+		uint32_t nak:1;
+		uint32_t stall:1;
+		uint32_t ahberr:1;
+		uint32_t chhltd:1;
+		uint32_t xfercompl:1;
+	} s;
+	struct cvmx_usbcx_hcintx_s cn30xx;
+	struct cvmx_usbcx_hcintx_s cn31xx;
+	struct cvmx_usbcx_hcintx_s cn50xx;
+	struct cvmx_usbcx_hcintx_s cn52xx;
+	struct cvmx_usbcx_hcintx_s cn52xxp1;
+	struct cvmx_usbcx_hcintx_s cn56xx;
+	struct cvmx_usbcx_hcintx_s cn56xxp1;
+};
+
+union cvmx_usbcx_hcintmskx {
+	uint32_t u32;
+	struct cvmx_usbcx_hcintmskx_s {
+		uint32_t reserved_11_31:21;
+		uint32_t datatglerrmsk:1;
+		uint32_t frmovrunmsk:1;
+		uint32_t bblerrmsk:1;
+		uint32_t xacterrmsk:1;
+		uint32_t nyetmsk:1;
+		uint32_t ackmsk:1;
+		uint32_t nakmsk:1;
+		uint32_t stallmsk:1;
+		uint32_t ahberrmsk:1;
+		uint32_t chhltdmsk:1;
+		uint32_t xfercomplmsk:1;
+	} s;
+	struct cvmx_usbcx_hcintmskx_s cn30xx;
+	struct cvmx_usbcx_hcintmskx_s cn31xx;
+	struct cvmx_usbcx_hcintmskx_s cn50xx;
+	struct cvmx_usbcx_hcintmskx_s cn52xx;
+	struct cvmx_usbcx_hcintmskx_s cn52xxp1;
+	struct cvmx_usbcx_hcintmskx_s cn56xx;
+	struct cvmx_usbcx_hcintmskx_s cn56xxp1;
+};
+
+union cvmx_usbcx_hcspltx {
+	uint32_t u32;
+	struct cvmx_usbcx_hcspltx_s {
+		uint32_t spltena:1;
+		uint32_t reserved_17_30:14;
+		uint32_t compsplt:1;
+		uint32_t xactpos:2;
+		uint32_t hubaddr:7;
+		uint32_t prtaddr:7;
+	} s;
+	struct cvmx_usbcx_hcspltx_s cn30xx;
+	struct cvmx_usbcx_hcspltx_s cn31xx;
+	struct cvmx_usbcx_hcspltx_s cn50xx;
+	struct cvmx_usbcx_hcspltx_s cn52xx;
+	struct cvmx_usbcx_hcspltx_s cn52xxp1;
+	struct cvmx_usbcx_hcspltx_s cn56xx;
+	struct cvmx_usbcx_hcspltx_s cn56xxp1;
+};
+
+union cvmx_usbcx_hctsizx {
+	uint32_t u32;
+	struct cvmx_usbcx_hctsizx_s {
+		uint32_t dopng:1;
+		uint32_t pid:2;
+		uint32_t pktcnt:10;
+		uint32_t xfersize:19;
+	} s;
+	struct cvmx_usbcx_hctsizx_s cn30xx;
+	struct cvmx_usbcx_hctsizx_s cn31xx;
+	struct cvmx_usbcx_hctsizx_s cn50xx;
+	struct cvmx_usbcx_hctsizx_s cn52xx;
+	struct cvmx_usbcx_hctsizx_s cn52xxp1;
+	struct cvmx_usbcx_hctsizx_s cn56xx;
+	struct cvmx_usbcx_hctsizx_s cn56xxp1;
+};
+
+union cvmx_usbcx_hfir {
+	uint32_t u32;
+	struct cvmx_usbcx_hfir_s {
+		uint32_t reserved_16_31:16;
+		uint32_t frint:16;
+	} s;
+	struct cvmx_usbcx_hfir_s cn30xx;
+	struct cvmx_usbcx_hfir_s cn31xx;
+	struct cvmx_usbcx_hfir_s cn50xx;
+	struct cvmx_usbcx_hfir_s cn52xx;
+	struct cvmx_usbcx_hfir_s cn52xxp1;
+	struct cvmx_usbcx_hfir_s cn56xx;
+	struct cvmx_usbcx_hfir_s cn56xxp1;
+};
+
+union cvmx_usbcx_hfnum {
+	uint32_t u32;
+	struct cvmx_usbcx_hfnum_s {
+		uint32_t frrem:16;
+		uint32_t frnum:16;
+	} s;
+	struct cvmx_usbcx_hfnum_s cn30xx;
+	struct cvmx_usbcx_hfnum_s cn31xx;
+	struct cvmx_usbcx_hfnum_s cn50xx;
+	struct cvmx_usbcx_hfnum_s cn52xx;
+	struct cvmx_usbcx_hfnum_s cn52xxp1;
+	struct cvmx_usbcx_hfnum_s cn56xx;
+	struct cvmx_usbcx_hfnum_s cn56xxp1;
+};
+
+union cvmx_usbcx_hprt {
+	uint32_t u32;
+	struct cvmx_usbcx_hprt_s {
+		uint32_t reserved_19_31:13;
+		uint32_t prtspd:2;
+		uint32_t prttstctl:4;
+		uint32_t prtpwr:1;
+		uint32_t prtlnsts:2;
+		uint32_t reserved_9_9:1;
+		uint32_t prtrst:1;
+		uint32_t prtsusp:1;
+		uint32_t prtres:1;
+		uint32_t prtovrcurrchng:1;
+		uint32_t prtovrcurract:1;
+		uint32_t prtenchng:1;
+		uint32_t prtena:1;
+		uint32_t prtconndet:1;
+		uint32_t prtconnsts:1;
+	} s;
+	struct cvmx_usbcx_hprt_s cn30xx;
+	struct cvmx_usbcx_hprt_s cn31xx;
+	struct cvmx_usbcx_hprt_s cn50xx;
+	struct cvmx_usbcx_hprt_s cn52xx;
+	struct cvmx_usbcx_hprt_s cn52xxp1;
+	struct cvmx_usbcx_hprt_s cn56xx;
+	struct cvmx_usbcx_hprt_s cn56xxp1;
+};
+
+union cvmx_usbcx_hptxfsiz {
+	uint32_t u32;
+	struct cvmx_usbcx_hptxfsiz_s {
+		uint32_t ptxfsize:16;
+		uint32_t ptxfstaddr:16;
+	} s;
+	struct cvmx_usbcx_hptxfsiz_s cn30xx;
+	struct cvmx_usbcx_hptxfsiz_s cn31xx;
+	struct cvmx_usbcx_hptxfsiz_s cn50xx;
+	struct cvmx_usbcx_hptxfsiz_s cn52xx;
+	struct cvmx_usbcx_hptxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_hptxfsiz_s cn56xx;
+	struct cvmx_usbcx_hptxfsiz_s cn56xxp1;
+};
+
+union cvmx_usbcx_hptxsts {
+	uint32_t u32;
+	struct cvmx_usbcx_hptxsts_s {
+		uint32_t ptxqtop:8;
+		uint32_t ptxqspcavail:8;
+		uint32_t ptxfspcavail:16;
+	} s;
+	struct cvmx_usbcx_hptxsts_s cn30xx;
+	struct cvmx_usbcx_hptxsts_s cn31xx;
+	struct cvmx_usbcx_hptxsts_s cn50xx;
+	struct cvmx_usbcx_hptxsts_s cn52xx;
+	struct cvmx_usbcx_hptxsts_s cn52xxp1;
+	struct cvmx_usbcx_hptxsts_s cn56xx;
+	struct cvmx_usbcx_hptxsts_s cn56xxp1;
+};
+
+union cvmx_usbcx_nptxdfifox {
+	uint32_t u32;
+	struct cvmx_usbcx_nptxdfifox_s {
+		uint32_t data:32;
+	} s;
+	struct cvmx_usbcx_nptxdfifox_s cn30xx;
+	struct cvmx_usbcx_nptxdfifox_s cn31xx;
+	struct cvmx_usbcx_nptxdfifox_s cn50xx;
+	struct cvmx_usbcx_nptxdfifox_s cn52xx;
+	struct cvmx_usbcx_nptxdfifox_s cn52xxp1;
+	struct cvmx_usbcx_nptxdfifox_s cn56xx;
+	struct cvmx_usbcx_nptxdfifox_s cn56xxp1;
+};
+
+union cvmx_usbcx_pcgcctl {
+	uint32_t u32;
+	struct cvmx_usbcx_pcgcctl_s {
+		uint32_t reserved_5_31:27;
+		uint32_t physuspended:1;
+		uint32_t rstpdwnmodule:1;
+		uint32_t pwrclmp:1;
+		uint32_t gatehclk:1;
+		uint32_t stoppclk:1;
+	} s;
+	struct cvmx_usbcx_pcgcctl_s cn30xx;
+	struct cvmx_usbcx_pcgcctl_s cn31xx;
+	struct cvmx_usbcx_pcgcctl_s cn50xx;
+	struct cvmx_usbcx_pcgcctl_s cn52xx;
+	struct cvmx_usbcx_pcgcctl_s cn52xxp1;
+	struct cvmx_usbcx_pcgcctl_s cn56xx;
+	struct cvmx_usbcx_pcgcctl_s cn56xxp1;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-usbnx-defs.h b/arch/mips/include/asm/octeon/cvmx-usbnx-defs.h
new file mode 100644
index 0000000..90be974
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-usbnx-defs.h
@@ -0,0 +1,760 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_USBNX_DEFS_H__
+#define __CVMX_USBNX_DEFS_H__
+
+#define CVMX_USBNX_BIST_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00011800680007F8ull + (((block_id) & 1) * 0x10000000ull))
+#define CVMX_USBNX_CLK_CTL(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180068000010ull + (((block_id) & 1) * 0x10000000ull))
+#define CVMX_USBNX_CTL_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000800ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN0(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000818ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN1(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000820ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN2(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000828ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN3(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000830ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN4(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000838ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN5(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000840ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN6(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000848ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_INB_CHN7(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000850ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN0(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000858ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN1(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000860ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN2(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000868ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN3(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000870ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN4(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000878ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN5(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000880ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN6(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000888ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA0_OUTB_CHN7(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000890ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_DMA_TEST(block_id) \
+	 CVMX_ADD_IO_SEG(0x00016F0000000808ull + (((block_id) & 1) * 0x100000000000ull))
+#define CVMX_USBNX_INT_ENB(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180068000008ull + (((block_id) & 1) * 0x10000000ull))
+#define CVMX_USBNX_INT_SUM(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180068000000ull + (((block_id) & 1) * 0x10000000ull))
+#define CVMX_USBNX_USBP_CTL_STATUS(block_id) \
+	 CVMX_ADD_IO_SEG(0x0001180068000018ull + (((block_id) & 1) * 0x10000000ull))
+
+union cvmx_usbnx_bist_status {
+	uint64_t u64;
+	struct cvmx_usbnx_bist_status_s {
+		uint64_t reserved_7_63:57;
+		uint64_t u2nc_bis:1;
+		uint64_t u2nf_bis:1;
+		uint64_t e2hc_bis:1;
+		uint64_t n2uf_bis:1;
+		uint64_t usbc_bis:1;
+		uint64_t nif_bis:1;
+		uint64_t nof_bis:1;
+	} s;
+	struct cvmx_usbnx_bist_status_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t usbc_bis:1;
+		uint64_t nif_bis:1;
+		uint64_t nof_bis:1;
+	} cn30xx;
+	struct cvmx_usbnx_bist_status_cn30xx cn31xx;
+	struct cvmx_usbnx_bist_status_s cn50xx;
+	struct cvmx_usbnx_bist_status_s cn52xx;
+	struct cvmx_usbnx_bist_status_s cn52xxp1;
+	struct cvmx_usbnx_bist_status_s cn56xx;
+	struct cvmx_usbnx_bist_status_s cn56xxp1;
+};
+
+union cvmx_usbnx_clk_ctl {
+	uint64_t u64;
+	struct cvmx_usbnx_clk_ctl_s {
+		uint64_t reserved_20_63:44;
+		uint64_t divide2:2;
+		uint64_t hclk_rst:1;
+		uint64_t p_x_on:1;
+		uint64_t reserved_14_15:2;
+		uint64_t p_com_on:1;
+		uint64_t p_c_sel:2;
+		uint64_t cdiv_byp:1;
+		uint64_t sd_mode:2;
+		uint64_t s_bist:1;
+		uint64_t por:1;
+		uint64_t enable:1;
+		uint64_t prst:1;
+		uint64_t hrst:1;
+		uint64_t divide:3;
+	} s;
+	struct cvmx_usbnx_clk_ctl_cn30xx {
+		uint64_t reserved_18_63:46;
+		uint64_t hclk_rst:1;
+		uint64_t p_x_on:1;
+		uint64_t p_rclk:1;
+		uint64_t p_xenbn:1;
+		uint64_t p_com_on:1;
+		uint64_t p_c_sel:2;
+		uint64_t cdiv_byp:1;
+		uint64_t sd_mode:2;
+		uint64_t s_bist:1;
+		uint64_t por:1;
+		uint64_t enable:1;
+		uint64_t prst:1;
+		uint64_t hrst:1;
+		uint64_t divide:3;
+	} cn30xx;
+	struct cvmx_usbnx_clk_ctl_cn30xx cn31xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t divide2:2;
+		uint64_t hclk_rst:1;
+		uint64_t reserved_16_16:1;
+		uint64_t p_rtype:2;
+		uint64_t p_com_on:1;
+		uint64_t p_c_sel:2;
+		uint64_t cdiv_byp:1;
+		uint64_t sd_mode:2;
+		uint64_t s_bist:1;
+		uint64_t por:1;
+		uint64_t enable:1;
+		uint64_t prst:1;
+		uint64_t hrst:1;
+		uint64_t divide:3;
+	} cn50xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn52xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn52xxp1;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn56xx;
+	struct cvmx_usbnx_clk_ctl_cn50xx cn56xxp1;
+};
+
+union cvmx_usbnx_ctl_status {
+	uint64_t u64;
+	struct cvmx_usbnx_ctl_status_s {
+		uint64_t reserved_6_63:58;
+		uint64_t dma_0pag:1;
+		uint64_t dma_stt:1;
+		uint64_t dma_test:1;
+		uint64_t inv_a2:1;
+		uint64_t l2c_emod:2;
+	} s;
+	struct cvmx_usbnx_ctl_status_s cn30xx;
+	struct cvmx_usbnx_ctl_status_s cn31xx;
+	struct cvmx_usbnx_ctl_status_s cn50xx;
+	struct cvmx_usbnx_ctl_status_s cn52xx;
+	struct cvmx_usbnx_ctl_status_s cn52xxp1;
+	struct cvmx_usbnx_ctl_status_s cn56xx;
+	struct cvmx_usbnx_ctl_status_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn0 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn0_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn0_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn1 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn1_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn1_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn2 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn2_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn2_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn3 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn3_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn3_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn4 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn4_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn4_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn5 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn5_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn5_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn6 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn6_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn6_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_inb_chn7 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_inb_chn7_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn30xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn31xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn50xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn52xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn52xxp1;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn56xx;
+	struct cvmx_usbnx_dma0_inb_chn7_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn0 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn0_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn0_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn1 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn1_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn1_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn2 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn2_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn2_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn3 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn3_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn3_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn4 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn4_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn4_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn5 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn5_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn5_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn6 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn6_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn6_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma0_outb_chn7 {
+	uint64_t u64;
+	struct cvmx_usbnx_dma0_outb_chn7_s {
+		uint64_t reserved_36_63:28;
+		uint64_t addr:36;
+	} s;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn30xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn31xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn50xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn52xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn52xxp1;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn56xx;
+	struct cvmx_usbnx_dma0_outb_chn7_s cn56xxp1;
+};
+
+union cvmx_usbnx_dma_test {
+	uint64_t u64;
+	struct cvmx_usbnx_dma_test_s {
+		uint64_t reserved_40_63:24;
+		uint64_t done:1;
+		uint64_t req:1;
+		uint64_t f_addr:18;
+		uint64_t count:11;
+		uint64_t channel:5;
+		uint64_t burst:4;
+	} s;
+	struct cvmx_usbnx_dma_test_s cn30xx;
+	struct cvmx_usbnx_dma_test_s cn31xx;
+	struct cvmx_usbnx_dma_test_s cn50xx;
+	struct cvmx_usbnx_dma_test_s cn52xx;
+	struct cvmx_usbnx_dma_test_s cn52xxp1;
+	struct cvmx_usbnx_dma_test_s cn56xx;
+	struct cvmx_usbnx_dma_test_s cn56xxp1;
+};
+
+union cvmx_usbnx_int_enb {
+	uint64_t u64;
+	struct cvmx_usbnx_int_enb_s {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t u2n_c_pe:1;
+		uint64_t u2n_c_pf:1;
+		uint64_t u2n_d_pf:1;
+		uint64_t u2n_d_pe:1;
+		uint64_t n2u_pe:1;
+		uint64_t n2u_pf:1;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t l2_fi_f:1;
+		uint64_t l2_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} s;
+	struct cvmx_usbnx_int_enb_s cn30xx;
+	struct cvmx_usbnx_int_enb_s cn31xx;
+	struct cvmx_usbnx_int_enb_cn50xx {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t reserved_26_31:6;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t l2_fi_f:1;
+		uint64_t l2_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} cn50xx;
+	struct cvmx_usbnx_int_enb_cn50xx cn52xx;
+	struct cvmx_usbnx_int_enb_cn50xx cn52xxp1;
+	struct cvmx_usbnx_int_enb_cn50xx cn56xx;
+	struct cvmx_usbnx_int_enb_cn50xx cn56xxp1;
+};
+
+union cvmx_usbnx_int_sum {
+	uint64_t u64;
+	struct cvmx_usbnx_int_sum_s {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t u2n_c_pe:1;
+		uint64_t u2n_c_pf:1;
+		uint64_t u2n_d_pf:1;
+		uint64_t u2n_d_pe:1;
+		uint64_t n2u_pe:1;
+		uint64_t n2u_pf:1;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t lt_fi_f:1;
+		uint64_t lt_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} s;
+	struct cvmx_usbnx_int_sum_s cn30xx;
+	struct cvmx_usbnx_int_sum_s cn31xx;
+	struct cvmx_usbnx_int_sum_cn50xx {
+		uint64_t reserved_38_63:26;
+		uint64_t nd4o_dpf:1;
+		uint64_t nd4o_dpe:1;
+		uint64_t nd4o_rpf:1;
+		uint64_t nd4o_rpe:1;
+		uint64_t ltl_f_pf:1;
+		uint64_t ltl_f_pe:1;
+		uint64_t reserved_26_31:6;
+		uint64_t uod_pf:1;
+		uint64_t uod_pe:1;
+		uint64_t rq_q3_e:1;
+		uint64_t rq_q3_f:1;
+		uint64_t rq_q2_e:1;
+		uint64_t rq_q2_f:1;
+		uint64_t rg_fi_f:1;
+		uint64_t rg_fi_e:1;
+		uint64_t lt_fi_f:1;
+		uint64_t lt_fi_e:1;
+		uint64_t l2c_a_f:1;
+		uint64_t l2c_s_e:1;
+		uint64_t dcred_f:1;
+		uint64_t dcred_e:1;
+		uint64_t lt_pu_f:1;
+		uint64_t lt_po_e:1;
+		uint64_t nt_pu_f:1;
+		uint64_t nt_po_e:1;
+		uint64_t pt_pu_f:1;
+		uint64_t pt_po_e:1;
+		uint64_t lr_pu_f:1;
+		uint64_t lr_po_e:1;
+		uint64_t nr_pu_f:1;
+		uint64_t nr_po_e:1;
+		uint64_t pr_pu_f:1;
+		uint64_t pr_po_e:1;
+	} cn50xx;
+	struct cvmx_usbnx_int_sum_cn50xx cn52xx;
+	struct cvmx_usbnx_int_sum_cn50xx cn52xxp1;
+	struct cvmx_usbnx_int_sum_cn50xx cn56xx;
+	struct cvmx_usbnx_int_sum_cn50xx cn56xxp1;
+};
+
+union cvmx_usbnx_usbp_ctl_status {
+	uint64_t u64;
+	struct cvmx_usbnx_usbp_ctl_status_s {
+		uint64_t txrisetune:1;
+		uint64_t txvreftune:4;
+		uint64_t txfslstune:4;
+		uint64_t txhsxvtune:2;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t otgtune:3;
+		uint64_t otgdisable:1;
+		uint64_t portreset:1;
+		uint64_t drvvbus:1;
+		uint64_t lsbist:1;
+		uint64_t fsbist:1;
+		uint64_t hsbist:1;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t siddq:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t tuning:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} s;
+	struct cvmx_usbnx_usbp_ctl_status_cn30xx {
+		uint64_t reserved_38_63:26;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t reserved_30_31:2;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t tuning:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} cn30xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn30xx cn31xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx {
+		uint64_t txrisetune:1;
+		uint64_t txvreftune:4;
+		uint64_t txfslstune:4;
+		uint64_t txhsxvtune:2;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t otgtune:3;
+		uint64_t otgdisable:1;
+		uint64_t portreset:1;
+		uint64_t drvvbus:1;
+		uint64_t lsbist:1;
+		uint64_t fsbist:1;
+		uint64_t hsbist:1;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t reserved_31_31:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t reserved_19_22:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} cn50xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn52xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn52xxp1;
+	struct cvmx_usbnx_usbp_ctl_status_cn56xx {
+		uint64_t txrisetune:1;
+		uint64_t txvreftune:4;
+		uint64_t txfslstune:4;
+		uint64_t txhsxvtune:2;
+		uint64_t sqrxtune:3;
+		uint64_t compdistune:3;
+		uint64_t otgtune:3;
+		uint64_t otgdisable:1;
+		uint64_t portreset:1;
+		uint64_t drvvbus:1;
+		uint64_t lsbist:1;
+		uint64_t fsbist:1;
+		uint64_t hsbist:1;
+		uint64_t bist_done:1;
+		uint64_t bist_err:1;
+		uint64_t tdata_out:4;
+		uint64_t siddq:1;
+		uint64_t txpreemphasistune:1;
+		uint64_t dma_bmode:1;
+		uint64_t usbc_end:1;
+		uint64_t usbp_bist:1;
+		uint64_t tclk:1;
+		uint64_t dp_pulld:1;
+		uint64_t dm_pulld:1;
+		uint64_t hst_mode:1;
+		uint64_t reserved_19_22:4;
+		uint64_t tx_bs_enh:1;
+		uint64_t tx_bs_en:1;
+		uint64_t loop_enb:1;
+		uint64_t vtest_enb:1;
+		uint64_t bist_enb:1;
+		uint64_t tdata_sel:1;
+		uint64_t taddr_in:4;
+		uint64_t tdata_in:8;
+		uint64_t ate_reset:1;
+	} cn56xx;
+	struct cvmx_usbnx_usbp_ctl_status_cn50xx cn56xxp1;
+};
+
+#endif
-- 
1.6.0.6
