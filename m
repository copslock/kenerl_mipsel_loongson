Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:54:39 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50385 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6872765Ab2JDJxto5GdR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 11:53:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 14E26A4FAB6;
        Wed,  3 Oct 2012 17:05:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BjAxmkmn8IiF; Wed,  3 Oct 2012 17:05:26 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BA3AEA4FA21;
        Wed,  3 Oct 2012 17:05:26 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <w.sang@pengutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] MIPS: Octeon: use OHCI platform driver
Date:   Wed,  3 Oct 2012 17:03:14 +0200
Message-Id: <1349276601-8371-20-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349276601-8371-1-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org>
X-archive-position: 34576
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
 arch/mips/cavium-octeon/octeon-platform.c |   37 ++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 539e1bc..07b0a3b 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -19,6 +19,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-rnm-defs.h>
@@ -260,6 +261,36 @@ out:
 }
 device_initcall(octeon_ehci_device_init);
 
+static int octeon_ohci_power_on(struct platform_device *pdev)
+{
+	union cvmx_uctlx_ohci_ctl ohci_ctl;
+
+	octeon2_usb_clocks_start();
+
+	ohci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_OHCI_CTL(0));
+	ohci_ctl.s.l2c_addr_msb = 0;
+	ohci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
+	ohci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
+	cvmx_write_csr(CVMX_UCTLX_OHCI_CTL(0), ohci_ctl.u64);
+
+	return 0;
+}
+
+static octeon_ohci_power_off(struct platform_device *pdev)
+{
+	octeon2_usb_clocks_stop();
+}
+
+static struct usb_ohci_pdata octeon_ohci_pdata = {
+#ifdef __BIG_ENDIAN
+	.big_endian_mmio = 1,
+#endif
+	.power_on	= octeon_ohci_power_on,
+	.power_off	= octeon_ohci_power_off,
+};
+
+static u32 octeon_ohci_dma_mask = DMA_BIT_MASK(32);
+
 static int __init octeon_ohci_device_init(void)
 {
 	struct platform_device *pd;
@@ -280,7 +311,7 @@ static int __init octeon_ohci_device_init(void)
 	if (octeon_is_simulation() || usb_disabled())
 		return 0; /* No USB in the simulator. */
 
-	pd = platform_device_alloc("octeon-ohci", 0);
+	pd = platform_device_alloc("ohci-platform", 0);
 	if (!pd) {
 		ret = -ENOMEM;
 		goto out;
@@ -297,6 +328,10 @@ static int __init octeon_ohci_device_init(void)
 	if (ret)
 		goto fail;
 
+	pd.dev.platform_data = &octeon_ohci_pdata;
+	pd.dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	pd.dev.dma_mask = &octeon_ohci_dma_mask;
+
 	ret = platform_device_add(pd);
 	if (ret)
 		goto fail;
-- 
1.7.9.5
