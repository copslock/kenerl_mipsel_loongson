Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:11:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4693 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822093AbaE2KKfQe6vn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 12:10:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 89666C3698256;
        Thu, 29 May 2014 11:10:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 11:10:27 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.62) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 11:10:27 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>, <linux-usb@vger.kernel.org>
Subject: [PATCH 3/3] usb host/MIPS: Remove hard-coded OCTEON platform information.
Date:   Thu, 29 May 2014 11:10:03 +0100
Message-ID: <1401358203-60225-4-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
References: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

From: David Daney <david.daney@cavium.com>

The device tree will *always* have correct ehci/ohci clock
configuration, so use it.  This allows us to remove a big chunk of
platform configuration code from octeon-platform.c.

Tested-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Cc: linux-usb@vger.kernel.org
---
 arch/mips/cavium-octeon/octeon-platform.c | 102 ------------------------------
 drivers/usb/host/ehci-octeon.c            |  17 +++--
 drivers/usb/host/octeon2-common.c         |  47 ++++++++++++--
 drivers/usb/host/ohci-octeon.c            |  17 +++--
 4 files changed, 69 insertions(+), 114 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 6df0f4d..f8cced4 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -66,108 +66,6 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
-#ifdef CONFIG_USB
-
-static int __init octeon_ehci_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-
-	struct resource usb_resources[] = {
-		{
-			.flags	= IORESOURCE_MEM,
-		}, {
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-
-	/* Only Octeon2 has ehci/ohci */
-	if (!OCTEON_IS_MODEL(OCTEON_CN63XX))
-		return 0;
-
-	if (octeon_is_simulation() || usb_disabled())
-		return 0; /* No USB in the simulator. */
-
-	pd = platform_device_alloc("octeon-ehci", 0);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	usb_resources[0].start = 0x00016F0000000000ULL;
-	usb_resources[0].end = usb_resources[0].start + 0x100;
-
-	usb_resources[1].start = OCTEON_IRQ_USB0;
-	usb_resources[1].end = OCTEON_IRQ_USB0;
-
-	ret = platform_device_add_resources(pd, usb_resources,
-					    ARRAY_SIZE(usb_resources));
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
-
-	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
-}
-device_initcall(octeon_ehci_device_init);
-
-static int __init octeon_ohci_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-
-	struct resource usb_resources[] = {
-		{
-			.flags	= IORESOURCE_MEM,
-		}, {
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-
-	/* Only Octeon2 has ehci/ohci */
-	if (!OCTEON_IS_MODEL(OCTEON_CN63XX))
-		return 0;
-
-	if (octeon_is_simulation() || usb_disabled())
-		return 0; /* No USB in the simulator. */
-
-	pd = platform_device_alloc("octeon-ohci", 0);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	usb_resources[0].start = 0x00016F0000000400ULL;
-	usb_resources[0].end = usb_resources[0].start + 0x100;
-
-	usb_resources[1].start = OCTEON_IRQ_USB0;
-	usb_resources[1].end = OCTEON_IRQ_USB0;
-
-	ret = platform_device_add_resources(pd, usb_resources,
-					    ARRAY_SIZE(usb_resources));
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
-
-	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
-}
-device_initcall(octeon_ohci_device_init);
-
-#endif /* CONFIG_USB */
-
 static struct of_device_id __initdata octeon_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "cavium,octeon-6335-uctl", },
diff --git a/drivers/usb/host/ehci-octeon.c b/drivers/usb/host/ehci-octeon.c
index 9051439..e1a264f5 100644
--- a/drivers/usb/host/ehci-octeon.c
+++ b/drivers/usb/host/ehci-octeon.c
@@ -19,14 +19,14 @@
 #define OCTEON_EHCI_HCD_NAME "octeon-ehci"
 
 /* Common clock init code.  */
-void octeon2_usb_clocks_start(void);
+void octeon2_usb_clocks_start(struct device *dev);
 void octeon2_usb_clocks_stop(void);
 
-static void ehci_octeon_start(void)
+static void ehci_octeon_start(struct device *dev)
 {
 	union cvmx_uctlx_ehci_ctl ehci_ctl;
 
-	octeon2_usb_clocks_start();
+	octeon2_usb_clocks_start(dev);
 
 	ehci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_EHCI_CTL(0));
 	/* Use 64-bit addressing. */
@@ -134,7 +134,7 @@ static int ehci_octeon_drv_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	ehci_octeon_start();
+	ehci_octeon_start(&pdev->dev);
 
 	ehci = hcd_to_ehci(hcd);
 
@@ -175,6 +175,14 @@ static int ehci_octeon_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id ehci_octeon_match[] = {
+	{
+		.compatible = "cavium,octeon-6335-ehci",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ehci_octeon_match);
+
 static struct platform_driver ehci_octeon_driver = {
 	.probe		= ehci_octeon_drv_probe,
 	.remove		= ehci_octeon_drv_remove,
@@ -182,6 +190,7 @@ static struct platform_driver ehci_octeon_driver = {
 	.driver = {
 		.name	= OCTEON_EHCI_HCD_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = ehci_octeon_match,
 	}
 };
 
diff --git a/drivers/usb/host/octeon2-common.c b/drivers/usb/host/octeon2-common.c
index d9df423..3c7c13a 100644
--- a/drivers/usb/host/octeon2-common.c
+++ b/drivers/usb/host/octeon2-common.c
@@ -6,9 +6,11 @@
  * Copyright (C) 2010, 2011 Cavium Networks
  */
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-uctlx-defs.h>
@@ -17,13 +19,15 @@ static DEFINE_MUTEX(octeon2_usb_clocks_mutex);
 
 static int octeon2_usb_clock_start_cnt;
 
-void octeon2_usb_clocks_start(void)
+void octeon2_usb_clocks_start(struct device *dev)
 {
 	u64 div;
 	union cvmx_uctlx_if_ena if_ena;
 	union cvmx_uctlx_clk_rst_ctl clk_rst_ctl;
 	union cvmx_uctlx_uphy_ctl_status uphy_ctl_status;
 	union cvmx_uctlx_uphy_portx_ctl_status port_ctl_status;
+	u32 clock_rate = 12000000;
+	bool is_crystal_clock = false;
 	int i;
 	unsigned long io_clk_64_to_ns;
 
@@ -36,6 +40,28 @@ void octeon2_usb_clocks_start(void)
 
 	io_clk_64_to_ns = 64000000000ull / octeon_get_io_clock_rate();
 
+	if (dev->of_node) {
+		struct device_node *uctl_node;
+		const char *clock_type;
+
+		uctl_node = of_get_parent(dev->of_node);
+		if (!uctl_node) {
+			dev_err(dev, "No UCTL device node\n");
+			goto exit;
+		}
+		i = of_property_read_u32(uctl_node,
+					 "refclk-frequency", &clock_rate);
+		if (i) {
+			dev_err(dev, "No UCTL \"refclk-frequency\"\n");
+			goto exit;
+		}
+		i = of_property_read_string(uctl_node,
+					    "refclk-type", &clock_type);
+
+		if (!i && strcmp("crystal", clock_type) == 0)
+			is_crystal_clock = true;
+	}
+
 	/*
 	 * Step 1: Wait for voltages stable.  That surely happened
 	 * before starting the kernel.
@@ -66,9 +92,22 @@ void octeon2_usb_clocks_start(void)
 	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
 
 	/* 3b */
-	/* 12MHz crystal. */
-	clk_rst_ctl.s.p_refclk_sel = 0;
-	clk_rst_ctl.s.p_refclk_div = 0;
+	clk_rst_ctl.s.p_refclk_sel = is_crystal_clock ? 0 : 1;
+	switch (clock_rate) {
+	default:
+		pr_err("Invalid UCTL clock rate of %u, using 12000000 instead\n",
+			clock_rate);
+		/* Fall through */
+	case 12000000:
+		clk_rst_ctl.s.p_refclk_div = 0;
+		break;
+	case 24000000:
+		clk_rst_ctl.s.p_refclk_div = 1;
+		break;
+	case 48000000:
+		clk_rst_ctl.s.p_refclk_div = 2;
+		break;
+	}
 	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
 
 	/* 3c */
diff --git a/drivers/usb/host/ohci-octeon.c b/drivers/usb/host/ohci-octeon.c
index 15af895..2127290 100644
--- a/drivers/usb/host/ohci-octeon.c
+++ b/drivers/usb/host/ohci-octeon.c
@@ -19,14 +19,14 @@
 #define OCTEON_OHCI_HCD_NAME "octeon-ohci"
 
 /* Common clock init code.  */
-void octeon2_usb_clocks_start(void);
+void octeon2_usb_clocks_start(struct device *dev);
 void octeon2_usb_clocks_stop(void);
 
-static void ohci_octeon_hw_start(void)
+static void ohci_octeon_hw_start(struct device *dev)
 {
 	union cvmx_uctlx_ohci_ctl ohci_ctl;
 
-	octeon2_usb_clocks_start();
+	octeon2_usb_clocks_start(dev);
 
 	ohci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_OHCI_CTL(0));
 	ohci_ctl.s.l2c_addr_msb = 0;
@@ -144,7 +144,7 @@ static int ohci_octeon_drv_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	ohci_octeon_hw_start();
+	ohci_octeon_hw_start(&pdev->dev);
 
 	hcd->regs = reg_base;
 
@@ -189,6 +189,14 @@ static int ohci_octeon_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id ohci_octeon_match[] = {
+	{
+		.compatible = "cavium,octeon-6335-ohci",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ohci_octeon_match);
+
 static struct platform_driver ohci_octeon_driver = {
 	.probe		= ohci_octeon_drv_probe,
 	.remove		= ohci_octeon_drv_remove,
@@ -196,6 +204,7 @@ static struct platform_driver ohci_octeon_driver = {
 	.driver = {
 		.name	= OCTEON_OHCI_HCD_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = ohci_octeon_match,
 	}
 };
 
-- 
1.9.3
