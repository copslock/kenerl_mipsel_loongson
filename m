Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 22:44:59 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:59754 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991964AbcGYUofPC6-o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 22:44:35 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sjhill@bethel-hill.org>)
        id 1bRmal-0003Lo-Iz; Mon, 25 Jul 2016 15:35:11 -0500
Subject: [PATCH] MIPS: Octeon: Improve USB reset code for OCTEON II.
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <sjhill@bethel-hill.org>
Message-ID: <57967A2C.3020002@bethel-hill.org>
Date:   Mon, 25 Jul 2016 15:44:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <sjhill@bethel-hill.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@bethel-hill.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

At boot time, do a better job of resetting the USB host controller
to make the frequency "eye" diagram more compliant with the USB
standard while making the controller more reliable.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 114 +++++++++++++++++-------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 7aeafed..eeda373 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -3,33 +3,27 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2011 Cavium Networks
+ * Copyright (C) 2004-2016 Cavium Networks
  * Copyright (C) 2008 Wind River Systems
  */
 
-#include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/i2c.h>
-#include <linux/usb.h>
-#include <linux/dma-mapping.h>
+#include <linux/delay.h>
 #include <linux/etherdevice.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/slab.h>
-#include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/usb/ehci_def.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-rnm-defs.h>
-#include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
 #include <asm/octeon/cvmx-uctlx-defs.h>
 
+#define CVMX_UAHCX_EHCI_USBCMD	(CVMX_ADD_IO_SEG(0x00016F0000000010ull))
+#define CVMX_UAHCX_OHCI_USBCMD	(CVMX_ADD_IO_SEG(0x00016F0000000408ull))
+
 /* Octeon Random Number Generator.  */
 static int __init octeon_rng_device_init(void)
 {
@@ -78,12 +72,36 @@ static DEFINE_MUTEX(octeon2_usb_clocks_mutex);
 
 static int octeon2_usb_clock_start_cnt;
 
+static int __init octeon2_usb_reset(void)
+{
+	union cvmx_uctlx_clk_rst_ctl clk_rst_ctl;
+	u32 ucmd;
+
+	if (!OCTEON_IS_OCTEON2())
+		return 0;
+
+	clk_rst_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_CLK_RST_CTL(0));
+	if (clk_rst_ctl.s.hrst) {
+		ucmd = cvmx_read64_uint32(CVMX_UAHCX_EHCI_USBCMD);
+		ucmd &= ~CMD_RUN;
+		cvmx_write64_uint32(CVMX_UAHCX_EHCI_USBCMD, ucmd);
+		mdelay(2);
+		ucmd |= CMD_RESET;
+		cvmx_write64_uint32(CVMX_UAHCX_EHCI_USBCMD, ucmd);
+		ucmd = cvmx_read64_uint32(CVMX_UAHCX_OHCI_USBCMD);
+		ucmd |= CMD_RUN;
+		cvmx_write64_uint32(CVMX_UAHCX_OHCI_USBCMD, ucmd);
+	}
+
+	return 0;
+}
+arch_initcall(octeon2_usb_reset);
+
 static void octeon2_usb_clocks_start(struct device *dev)
 {
 	u64 div;
 	union cvmx_uctlx_if_ena if_ena;
 	union cvmx_uctlx_clk_rst_ctl clk_rst_ctl;
-	union cvmx_uctlx_uphy_ctl_status uphy_ctl_status;
 	union cvmx_uctlx_uphy_portx_ctl_status port_ctl_status;
 	int i;
 	unsigned long io_clk_64_to_ns;
@@ -131,6 +149,17 @@ static void octeon2_usb_clocks_start(struct device *dev)
 	if_ena.s.en = 1;
 	cvmx_write_csr(CVMX_UCTLX_IF_ENA(0), if_ena.u64);
 
+	for (i = 0; i <= 1; i++) {
+		port_ctl_status.u64 =
+			cvmx_read_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0));
+		/* Set txvreftune to 15 to obtain compliant 'eye' diagram. */
+		port_ctl_status.s.txvreftune = 15;
+		port_ctl_status.s.txrisetune = 1;
+		port_ctl_status.s.txpreemphasistune = 1;
+		cvmx_write_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0),
+			       port_ctl_status.u64);
+	}
+
 	/* Step 3: Configure the reference clock, PHY, and HCLK */
 	clk_rst_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_CLK_RST_CTL(0));
 
@@ -218,29 +247,10 @@ static void octeon2_usb_clocks_start(struct device *dev)
 	clk_rst_ctl.s.p_por = 0;
 	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
 
-	/* Step 5:    Wait 1 ms for the PHY clock to start. */
-	mdelay(1);
-
-	/*
-	 * Step 6: Program the reset input from automatic test
-	 * equipment field in the UPHY CSR
-	 */
-	uphy_ctl_status.u64 = cvmx_read_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0));
-	uphy_ctl_status.s.ate_reset = 1;
-	cvmx_write_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0), uphy_ctl_status.u64);
-
-	/* Step 7: Wait for at least 10ns. */
-	ndelay(10);
-
-	/* Step 8: Clear the ATE_RESET field in the UPHY CSR. */
-	uphy_ctl_status.s.ate_reset = 0;
-	cvmx_write_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0), uphy_ctl_status.u64);
+	/* Step 5:    Wait 3 ms for the PHY clock to start. */
+	mdelay(3);
 
-	/*
-	 * Step 9: Wait for at least 20ns for UPHY to output PHY clock
-	 * signals and OHCI_CLK48
-	 */
-	ndelay(20);
+	/* Steps 6..9 for ATE only, are skipped. */
 
 	/* Step 10: Configure the OHCI_CLK48 and OHCI_CLK12 clocks. */
 	/* 10a */
@@ -261,6 +271,20 @@ static void octeon2_usb_clocks_start(struct device *dev)
 	clk_rst_ctl.s.p_prst = 1;
 	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
 
+	/* Step 11b */
+	udelay(1);
+
+	/* Step 11c */
+	clk_rst_ctl.s.p_prst = 0;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* Step 11d */
+	mdelay(1);
+
+	/* Step 11e */
+	clk_rst_ctl.s.p_prst = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
 	/* Step 12: Wait 1 uS. */
 	udelay(1);
 
@@ -269,21 +293,9 @@ static void octeon2_usb_clocks_start(struct device *dev)
 	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
 
 end_clock:
-	/* Now we can set some other registers.  */
-
-	for (i = 0; i <= 1; i++) {
-		port_ctl_status.u64 =
-			cvmx_read_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0));
-		/* Set txvreftune to 15 to obtain compliant 'eye' diagram. */
-		port_ctl_status.s.txvreftune = 15;
-		port_ctl_status.s.txrisetune = 1;
-		port_ctl_status.s.txpreemphasistune = 1;
-		cvmx_write_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0),
-			       port_ctl_status.u64);
-	}
-
 	/* Set uSOF cycle period to 60,000 bits. */
 	cvmx_write_csr(CVMX_UCTLX_EHCI_FLA(0), 0x20ull);
+
 exit:
 	mutex_unlock(&octeon2_usb_clocks_mutex);
 }
@@ -311,7 +323,11 @@ static struct usb_ehci_pdata octeon_ehci_pdata = {
 #ifdef __BIG_ENDIAN
 	.big_endian_mmio	= 1,
 #endif
-	.dma_mask_64	= 1,
+	/*
+	 * We can DMA from anywhere. But the descriptors must be in
+	 * the lower 4GB.
+	 */
+	.dma_mask_64	= 0,
 	.power_on	= octeon_ehci_power_on,
 	.power_off	= octeon_ehci_power_off,
 };
-- 
1.9.1
