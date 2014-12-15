Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 14:29:06 +0100 (CET)
Received: from mail-bn1on0080.outbound.protection.outlook.com ([157.56.110.80]:51456
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007135AbaLON3EPniaO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 14:29:04 +0100
Received: from alberich (2.165.246.116) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.1.36.22; Mon, 15 Dec 2014 13:28:54 +0000
Date:   Mon, 15 Dec 2014 14:28:41 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <greg@kroah.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2 resend] USB: host: Remove hard-coded octeon platform
 information for ehci/ohci
Message-ID: <20141215132841.GB20109@alberich>
References: <20141215132628.GA20109@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20141215132628.GA20109@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.246.116]
X-ClientProxiedBy: AM2PR02CA0038.eurprd02.prod.outlook.com (25.160.28.176) To
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB386;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601003);SRVR:BLUPR07MB386;
X-Forefront-PRVS: 04267075BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(189002)(15975445007)(40100003)(122386002)(64706001)(20776003)(47776003)(86362001)(101416001)(46102003)(50466002)(107046002)(229853001)(106356001)(77096005)(120916001)(19580405001)(68736005)(92566001)(66066001)(99396003)(19580395003)(83506001)(105586002)(76176999)(54356999)(62966003)(42186005)(50986999)(77156002)(97736003)(33656002)(21056001)(110136001)(31966008)(4396001)(23676002)(87976001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB386;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB386;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2014 13:28:54.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR07MB386
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44669
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
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
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
index 35a9aed..5b8533f 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -349,6 +349,7 @@ static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
 	{ .compatible = "wm,prizm-ehci", },
 	{ .compatible = "generic-ehci", },
+	{ .compatible = "cavium,octeon-6335-ehci", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 9434c1d..748a1a2 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -328,6 +328,7 @@ static int ohci_platform_resume(struct device *dev)
 
 static const struct of_device_id ohci_platform_ids[] = {
 	{ .compatible = "generic-ohci", },
+	{ .compatible = "cavium,octeon-6335-ohci", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ohci_platform_ids);
-- 
1.7.9.5
