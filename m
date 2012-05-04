Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 14:51:05 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:33986 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903664Ab2EDMuO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 14:50:14 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 12/14] MTD: MIPS: lantiq: implement OF support
Date:   Fri,  4 May 2012 14:18:37 +0200
Message-Id: <1336133919-26525-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Adds bindings for OF and make use of module_platform_driver for lantiq
based socs.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mtd@lists.infradead.org
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

 drivers/mtd/maps/lantiq-flash.c |   69 ++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index b5401e3..aefa111 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -21,7 +21,6 @@
 #include <linux/mtd/physmap.h>
 
 #include <lantiq_soc.h>
-#include <lantiq_platform.h>
 
 /*
  * The NOR flash is connected to the same external bus unit (EBU) as PCI.
@@ -44,8 +43,9 @@ struct ltq_mtd {
 	struct map_info *map;
 };
 
-static char ltq_map_name[] = "ltq_nor";
-static const char *ltq_probe_types[] __devinitconst = { "cmdlinepart", NULL };
+static const char ltq_map_name[] = "ltq_nor";
+static const char *ltq_probe_types[] __devinitconst = {
+					"cmdlinepart", "ofpart", NULL };
 
 static map_word
 ltq_read16(struct map_info *map, unsigned long adr)
@@ -108,12 +108,11 @@ ltq_copy_to(struct map_info *map, unsigned long to,
 	spin_unlock_irqrestore(&ebu_lock, flags);
 }
 
-static int __init
+static int __devinit
 ltq_mtd_probe(struct platform_device *pdev)
 {
-	struct physmap_flash_data *ltq_mtd_data = dev_get_platdata(&pdev->dev);
+	struct mtd_part_parser_data ppdata;
 	struct ltq_mtd *ltq_mtd;
-	struct resource *res;
 	struct cfi_private *cfi;
 	int err;
 
@@ -122,28 +121,19 @@ ltq_mtd_probe(struct platform_device *pdev)
 
 	ltq_mtd->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!ltq_mtd->res) {
-		dev_err(&pdev->dev, "failed to get memory resource");
+		dev_err(&pdev->dev, "failed to get memory resource\n");
 		err = -ENOENT;
 		goto err_out;
 	}
 
-	res = devm_request_mem_region(&pdev->dev, ltq_mtd->res->start,
-		resource_size(ltq_mtd->res), dev_name(&pdev->dev));
-	if (!ltq_mtd->res) {
-		dev_err(&pdev->dev, "failed to request mem resource");
-		err = -EBUSY;
-		goto err_out;
-	}
-
 	ltq_mtd->map = kzalloc(sizeof(struct map_info), GFP_KERNEL);
-	ltq_mtd->map->phys = res->start;
-	ltq_mtd->map->size = resource_size(res);
-	ltq_mtd->map->virt = devm_ioremap_nocache(&pdev->dev,
-				ltq_mtd->map->phys, ltq_mtd->map->size);
+	ltq_mtd->map->phys = ltq_mtd->res->start;
+	ltq_mtd->map->size = resource_size(ltq_mtd->res);
+	ltq_mtd->map->virt = devm_request_and_ioremap(&pdev->dev, ltq_mtd->res);
 	if (!ltq_mtd->map->virt) {
-		dev_err(&pdev->dev, "failed to ioremap!\n");
-		err = -ENOMEM;
-		goto err_free;
+		dev_err(&pdev->dev, "failed to remap mem resource\n");
+		err = -EBUSY;
+		goto err_out;
 	}
 
 	ltq_mtd->map->name = ltq_map_name;
@@ -169,9 +159,9 @@ ltq_mtd_probe(struct platform_device *pdev)
 	cfi->addr_unlock1 ^= 1;
 	cfi->addr_unlock2 ^= 1;
 
-	err = mtd_device_parse_register(ltq_mtd->mtd, ltq_probe_types, NULL,
-					ltq_mtd_data->parts,
-					ltq_mtd_data->nr_parts);
+	ppdata.of_node = pdev->dev.of_node;
+	err = mtd_device_parse_register(ltq_mtd->mtd, ltq_probe_types,
+					&ppdata, NULL, 0);
 	if (err) {
 		dev_err(&pdev->dev, "failed to add partitions\n");
 		goto err_destroy;
@@ -204,32 +194,23 @@ ltq_mtd_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ltq_mtd_match[] = {
+	{ .compatible = "lantiq,nor" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltq_mtd_match);
+
 static struct platform_driver ltq_mtd_driver = {
+	.probe = ltq_mtd_probe,
 	.remove = __devexit_p(ltq_mtd_remove),
 	.driver = {
-		.name = "ltq_nor",
+		.name = "ltq-nor",
 		.owner = THIS_MODULE,
+		.of_match_table = ltq_mtd_match,
 	},
 };
 
-static int __init
-init_ltq_mtd(void)
-{
-	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
-
-	if (ret)
-		pr_err("ltq_nor: error registering platform driver");
-	return ret;
-}
-
-static void __exit
-exit_ltq_mtd(void)
-{
-	platform_driver_unregister(&ltq_mtd_driver);
-}
-
-module_init(init_ltq_mtd);
-module_exit(exit_ltq_mtd);
+module_platform_driver(ltq_mtd_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-- 
1.7.9.1
