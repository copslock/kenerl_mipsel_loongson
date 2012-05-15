Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 13:38:52 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47227 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903614Ab2EOLio (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2012 13:38:44 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 06/17] MIPS: lantiq: convert dma to platform driver
Date:   Tue, 15 May 2012 13:38:34 +0200
Message-Id: <1337081914-16388-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add code to make the dma driver load as a platform device from the devicetree.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V3
* add a missing \n

 arch/mips/lantiq/xway/dma.c |   65 ++++++++++++++++++++++++++++--------------
 1 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index b210e93..ddbec1f 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -19,7 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
-#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/clk.h>
 
 #include <lantiq_soc.h>
 #include <xway_dma.h>
@@ -55,13 +56,6 @@
 #define ltq_dma_w32_mask(x, y, z)	ltq_w32_mask(x, y, \
 						ltq_dma_membase + (z))
 
-static struct resource ltq_dma_resource = {
-	.name	= "dma",
-	.start	= LTQ_DMA_BASE_ADDR,
-	.end	= LTQ_DMA_BASE_ADDR + LTQ_DMA_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
-
 static void __iomem *ltq_dma_membase;
 
 void
@@ -215,27 +209,28 @@ ltq_dma_init_port(int p)
 }
 EXPORT_SYMBOL_GPL(ltq_dma_init_port);
 
-int __init
-ltq_dma_init(void)
+static int __devinit
+ltq_dma_init(struct platform_device *pdev)
 {
+	struct clk *clk;
+	struct resource *res;
 	int i;
 
-	/* insert and request the memory region */
-	if (insert_resource(&iomem_resource, &ltq_dma_resource) < 0)
-		panic("Failed to insert dma memory");
-
-	if (request_mem_region(ltq_dma_resource.start,
-			resource_size(&ltq_dma_resource), "dma") < 0)
-		panic("Failed to request dma memory");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		panic("Failed to get dma resource");
 
 	/* remap dma register range */
-	ltq_dma_membase = ioremap_nocache(ltq_dma_resource.start,
-				resource_size(&ltq_dma_resource));
+	ltq_dma_membase = devm_request_and_ioremap(&pdev->dev, res);
 	if (!ltq_dma_membase)
-		panic("Failed to remap dma memory");
+		panic("Failed to remap dma resource");
 
 	/* power up and reset the dma engine */
-	ltq_pmu_enable(PMU_DMA);
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		panic("Failed to get dma clock");
+
+	clk_enable(clk);
 	ltq_dma_w32_mask(0, DMA_RESET, LTQ_DMA_CTRL);
 
 	/* disable all interrupts */
@@ -248,7 +243,33 @@ ltq_dma_init(void)
 		ltq_dma_w32(DMA_POLL | DMA_CLK_DIV4, LTQ_DMA_CPOLL);
 		ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
 	}
+	dev_info(&pdev->dev, "init done\n");
 	return 0;
 }
 
-postcore_initcall(ltq_dma_init);
+static const struct of_device_id dma_match[] = {
+	{ .compatible = "lantiq,dma-xway" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dma_match);
+
+static struct platform_driver dma_driver = {
+	.probe = ltq_dma_init,
+	.driver = {
+		.name = "dma-xway",
+		.owner = THIS_MODULE,
+		.of_match_table = dma_match,
+	},
+};
+
+int __init
+dma_init(void)
+{
+	int ret = platform_driver_register(&dma_driver);
+
+	if (ret)
+		pr_info("ltq_dma : Error registering platfom driver\n");
+	return ret;
+}
+
+postcore_initcall(dma_init);
-- 
1.7.9.1
