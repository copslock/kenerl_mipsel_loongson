Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 22:38:23 +0100 (CET)
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:58376
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013643AbaKMViKXmDQ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 22:38:10 +0100
Received: from BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) by
 BN1PR07MB246.namprd07.prod.outlook.com (10.141.64.143) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:38:03 +0000
Received: from localhost.localdomain (2.165.41.20) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:38:01 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: [PATCH 2/3] USB: host: Remove hard-coded octeon platform information for ehci/ohci
Date:   Thu, 13 Nov 2014 22:36:29 +0100
Message-ID: <1415914590-31647-3-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.165.41.20]
X-ClientProxiedBy: AM2PR03CA0029.eurprd03.prod.outlook.com (25.160.207.39) To
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Forefront-PRVS: 0394259C80
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(189002)(199003)(120916001)(110136001)(15202345003)(4396001)(97736003)(76176999)(33646002)(102836001)(87286001)(50466002)(88136002)(122386002)(2171001)(87976001)(50226001)(19580395003)(89996001)(104166001)(50986999)(19580405001)(47776003)(92726001)(15188555004)(92566001)(64706001)(86362001)(93916002)(48376002)(95666004)(42186005)(40100003)(106356001)(66066001)(21056001)(101416001)(20776003)(62966003)(229853001)(15975445006)(77096003)(77156002)(36756003)(107046002)(31966008)(46102003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB389;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB246;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

Instead rely on device tree information for ehci and ohci.

This was suggested with
http://www.linux-mips.org/archives/linux-mips/2014-05/msg00307.html

  "The device tree will *always* have correct ehci/ohci clock
  configuration, so use it.  This allows us to remove a big chunk of
  platform configuration code from octeon-platform.c."

More or less I rebased that patch on Alan's work to remove ehci-octeon
and ohci-octeon drivers.

Cc: David Daney <david.daney@cavium.com>
Cc: Alex Smith <alex.smith@imgtec.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |  148 ++++++++++++-----------------
 drivers/usb/host/ehci-platform.c          |    1 +
 drivers/usb/host/ohci-platform.c          |    1 +
 3 files changed, 64 insertions(+), 86 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index b67ddf0..eea60b6 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -77,7 +77,7 @@ static DEFINE_MUTEX(octeon2_usb_clocks_mutex);
 
 static int octeon2_usb_clock_start_cnt;
 
-static void octeon2_usb_clocks_start(void)
+static void octeon2_usb_clocks_start(struct device *dev)
 {
 	u64 div;
 	union cvmx_uctlx_if_ena if_ena;
@@ -86,6 +86,8 @@ static void octeon2_usb_clocks_start(void)
 	union cvmx_uctlx_uphy_portx_ctl_status port_ctl_status;
 	int i;
 	unsigned long io_clk_64_to_ns;
+	u32 clock_rate = 12000000;
+	bool is_crystal_clock = false;
 
 
 	mutex_lock(&octeon2_usb_clocks_mutex);
@@ -96,6 +98,28 @@ static void octeon2_usb_clocks_start(void)
 
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
@@ -126,9 +150,22 @@ static void octeon2_usb_clocks_start(void)
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
@@ -259,7 +296,7 @@ static void octeon2_usb_clocks_stop(void)
 
 static int octeon_ehci_power_on(struct platform_device *pdev)
 {
-	octeon2_usb_clocks_start();
+	octeon2_usb_clocks_start(&pdev->dev);
 	return 0;
 }
 
@@ -277,11 +314,11 @@ static struct usb_ehci_pdata octeon_ehci_pdata = {
 	.power_off	= octeon_ehci_power_off,
 };
 
-static void __init octeon_ehci_hw_start(void)
+static void __init octeon_ehci_hw_start(struct device *dev)
 {
 	union cvmx_uctlx_ehci_ctl ehci_ctl;
 
-	octeon2_usb_clocks_start();
+	octeon2_usb_clocks_start(dev);
 
 	ehci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_EHCI_CTL(0));
 	/* Use 64-bit addressing. */
@@ -299,59 +336,28 @@ static u64 octeon_ehci_dma_mask = DMA_BIT_MASK(64);
 static int __init octeon_ehci_device_init(void)
 {
 	struct platform_device *pd;
+	struct device_node *ehci_node;
 	int ret = 0;
 
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
+	ehci_node = of_find_node_by_name(NULL, "ehci");
+	if (!ehci_node)
 		return 0;
 
-	if (octeon_is_simulation() || usb_disabled())
-		return 0; /* No USB in the simulator. */
-
-	pd = platform_device_alloc("ehci-platform", 0);
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
+	pd = of_find_device_by_node(ehci_node);
+	if (!pd)
+		return 0;
 
 	pd->dev.dma_mask = &octeon_ehci_dma_mask;
 	pd->dev.platform_data = &octeon_ehci_pdata;
-	octeon_ehci_hw_start();
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
+	octeon_ehci_hw_start(&pd->dev);
 
 	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
 }
 device_initcall(octeon_ehci_device_init);
 
 static int octeon_ohci_power_on(struct platform_device *pdev)
 {
-	octeon2_usb_clocks_start();
+	octeon2_usb_clocks_start(&pdev->dev);
 	return 0;
 }
 
@@ -369,11 +375,11 @@ static struct usb_ohci_pdata octeon_ohci_pdata = {
 	.power_off	= octeon_ohci_power_off,
 };
 
-static void __init octeon_ohci_hw_start(void)
+static void __init octeon_ohci_hw_start(struct device *dev)
 {
 	union cvmx_uctlx_ohci_ctl ohci_ctl;
 
-	octeon2_usb_clocks_start();
+	octeon2_usb_clocks_start(dev);
 
 	ohci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_OHCI_CTL(0));
 	ohci_ctl.s.l2c_addr_msb = 0;
@@ -387,57 +393,27 @@ static void __init octeon_ohci_hw_start(void)
 static int __init octeon_ohci_device_init(void)
 {
 	struct platform_device *pd;
+	struct device_node *ohci_node;
 	int ret = 0;
 
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
+	ohci_node = of_find_node_by_name(NULL, "ohci");
+	if (!ohci_node)
 		return 0;
 
-	if (octeon_is_simulation() || usb_disabled())
-		return 0; /* No USB in the simulator. */
-
-	pd = platform_device_alloc("ohci-platform", 0);
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
+	pd = of_find_device_by_node(ohci_node);
+	if (!pd)
+		return 0;
 
 	pd->dev.platform_data = &octeon_ohci_pdata;
-	octeon_ohci_hw_start();
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
+	octeon_ohci_hw_start(&pd->dev);
 
 	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
 }
 device_initcall(octeon_ohci_device_init);
 
 #endif /* CONFIG_USB */
 
+
 static struct of_device_id __initdata octeon_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "cavium,octeon-6335-uctl", },
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2f5b9ce..2da18ea 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -358,6 +358,7 @@ static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
 	{ .compatible = "wm,prizm-ehci", },
 	{ .compatible = "generic-ehci", },
+	{ .compatible = "cavium,octeon-6335-ehci", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 4369299..cb29865 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -343,6 +343,7 @@ static int ohci_platform_resume(struct device *dev)
 
 static const struct of_device_id ohci_platform_ids[] = {
 	{ .compatible = "generic-ohci", },
+	{ .compatible = "cavium,octeon-6335-ohci", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ohci_platform_ids);
-- 
1.7.9.5
