Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:57:00 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50389 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6872768Ab2JDJxt58doS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 11:53:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 80281A47A2E;
        Wed,  3 Oct 2012 17:05:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VnBTHzMBddHk; Wed,  3 Oct 2012 17:05:02 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 2443AA332B4;
        Wed,  3 Oct 2012 17:05:02 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <w.sang@pengutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] MIPS: Octeon: use ehci-platform driver
Date:   Wed,  3 Oct 2012 17:03:04 +0200
Message-Id: <1349276601-8371-10-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349276601-8371-1-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org>
X-archive-position: 34580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/cavium-octeon/octeon-platform.c |   43 ++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 0938df1..539e1bc 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -18,9 +18,11 @@
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/usb/ehci_pdriver.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-rnm-defs.h>
+#include <asm/octeon/cvmx-uctlx-defs.h>
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
@@ -169,6 +171,41 @@ out:
 device_initcall(octeon_rng_device_init);
 
 #ifdef CONFIG_USB
+void octeon2_usb_clocks_start(void);
+void octeon2_usb_clocks_stop(void);
+
+static int octeon_ehci_power_on(struct platform_device *pdev)
+{
+	union cvmx_uctlx_ehci_ctl ehci_ctl;
+
+	octeon2_usb_clocks_start();
+
+	ehci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_EHCI_CTL(0));
+	/* Use 64-bit addressing. */
+	ehci_ctl.s.ehci_64b_addr_en = 1;
+	ehci_ctl.s.l2c_addr_msb = 0;
+	ehci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
+	ehci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
+	cvmx_write_csr(CVMX_UCTLX_EHCI_CTL(0), ehci_ctl.u64);
+
+	return 0;
+}
+
+static void octeon_ehci_power_off(struct platform_device *pdev)
+{
+	octeon2_usb_clocks_stop();
+}
+
+static struct usb_ehci_pdata octeon_ehci_pdata = {
+#ifdef __BIG_ENDIAN
+	.big_endian_mmio = 1,
+#endif
+	.port_power_on	= 1,
+	.power_on	= octeon_ehci_power_on,
+	.power_off	= octeon_ehci_power_off,
+};
+
+static u64 octeon_ehci_dma_mask = DMA_BIT_MASK(64);
 
 static int __init octeon_ehci_device_init(void)
 {
@@ -190,7 +227,7 @@ static int __init octeon_ehci_device_init(void)
 	if (octeon_is_simulation() || usb_disabled())
 		return 0; /* No USB in the simulator. */
 
-	pd = platform_device_alloc("octeon-ehci", 0);
+	pd = platform_device_alloc("ehci-platform", 0);
 	if (!pd) {
 		ret = -ENOMEM;
 		goto out;
@@ -207,6 +244,10 @@ static int __init octeon_ehci_device_init(void)
 	if (ret)
 		goto fail;
 
+	pd.dev.platform_data = &octeon_ehci_pdata;
+	pd.dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	pd.dev.dma_mask = &octeon_ehci_dma_mask;
+
 	ret = platform_device_add(pd);
 	if (ret)
 		goto fail;
-- 
1.7.9.5
