Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 14:34:58 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:64803 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20031072AbYGKNey (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 14:34:54 +0100
Received: by mo.po.2iij.net (mo31) id m6BDYnW2095090; Fri, 11 Jul 2008 22:34:49 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox301) id m6BDYm1k025763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 Jul 2008 22:34:48 +0900
Date:	Fri, 11 Jul 2008 22:34:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	linux-mtd <linux-mtd@lists.infradead.org>
Subject: [PATCH][MIPS] MTX-1 flash partition setup move to platform devices
 registration
Message-Id: <20080711223448.f5826678.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

MTX-1 flash partition setup move to platform devices registration.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/au1000/mtx-1/platform.c linux/arch/mips/au1000/mtx-1/platform.c
--- linux-orig/arch/mips/au1000/mtx-1/platform.c	2008-05-12 08:28:21.391041296 +0900
+++ linux/arch/mips/au1000/mtx-1/platform.c	2008-05-12 08:28:36.375895238 +0900
@@ -24,6 +24,9 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <mtd/mtd-abi.h>
 
 static struct gpio_keys_button mtx1_gpio_button[] = {
 	{
@@ -85,10 +88,56 @@ static struct platform_device mtx1_gpio_
 	}
 };
 
+static struct mtd_partition mtx1_mtd_partitions[] = {
+	{
+		.name	= "filesystem",
+		.size	= 0x01C00000,
+		.offset	= 0,
+	},
+	{
+		.name	= "yamon",
+		.size	= 0x00100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "kernel",
+		.size	= 0x002c0000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	{
+		.name	= "yamon env",
+		.size	= 0x00040000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+};
+
+static struct physmap_flash_data mtx1_flash_data = {
+	.width		= 4,
+	.nr_parts	= 4,
+	.parts		= mtx1_mtd_partitions,
+};
+
+static struct resource mtx1_mtd_resource = {
+	.start	= 0x1e000000,
+	.end	= 0x1fffffff,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device mtx1_mtd = {
+	.name		= "physmap-flash",
+	.dev		= {
+		.platform_data	= &mtx1_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &mtx1_mtd_resource,
+};
+
 static struct __initdata platform_device * mtx1_devs[] = {
 	&mtx1_gpio_leds,
 	&mtx1_wdt,
-	&mtx1_button
+	&mtx1_button,
+	&mtx1_mtd,
 };
 
 static int __init mtx1_register_devices(void)
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/mtd/maps/Kconfig linux/drivers/mtd/maps/Kconfig
--- linux-orig/drivers/mtd/maps/Kconfig	2008-05-12 08:28:24.811236201 +0900
+++ linux/drivers/mtd/maps/Kconfig	2008-05-12 08:28:36.375895238 +0900
@@ -258,13 +258,6 @@ config MTD_ALCHEMY
 	help
 	  Flash memory access on AMD Alchemy Pb/Db/RDK Reference Boards
 
-config MTD_MTX1
-	tristate "4G Systems MTX-1 Flash device"
-	depends on MIPS_MTX1 && MTD_CFI
-	help
-	  Flash memory access on 4G Systems MTX-1 Board. If you have one of
-	  these boards and would like to use the flash chips on it, say 'Y'.
-
 config MTD_DILNETPC
 	tristate "CFI Flash device mapped on DIL/Net PC"
 	depends on X86 && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/mtd/maps/Makefile linux/drivers/mtd/maps/Makefile
--- linux-orig/drivers/mtd/maps/Makefile	2008-05-12 08:28:24.811236201 +0900
+++ linux/drivers/mtd/maps/Makefile	2008-05-12 08:28:36.375895238 +0900
@@ -65,5 +65,4 @@ obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
 obj-$(CONFIG_MTD_SHARP_SL)	+= sharpsl-flash.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
-obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/mtd/maps/mtx-1_flash.c linux/drivers/mtd/maps/mtx-1_flash.c
--- linux-orig/drivers/mtd/maps/mtx-1_flash.c	2008-05-12 08:28:24.839237803 +0900
+++ linux/drivers/mtd/maps/mtx-1_flash.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,95 +0,0 @@
-/*
- * Flash memory access on 4G Systems MTX-1 boards
- *
- * $Id: mtx-1_flash.c,v 1.2 2005/11/07 11:14:27 gleixner Exp $
- *
- * (C) 2005 Bruno Randolf <bruno.randolf@4g-systems.biz>
- * (C) 2005 Joern Engel <joern@wohnheim.fh-wedel.de>
- *
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-
-static struct map_info mtx1_map = {
-	.name = "MTX-1 flash",
-	.bankwidth = 4,
-	.size = 0x2000000,
-	.phys = 0x1E000000,
-};
-
-static struct mtd_partition mtx1_partitions[] = {
-        {
-                .name = "filesystem",
-                .size = 0x01C00000,
-                .offset = 0,
-        },{
-                .name = "yamon",
-                .size = 0x00100000,
-                .offset = MTDPART_OFS_APPEND,
-                .mask_flags = MTD_WRITEABLE,
-        },{
-                .name = "kernel",
-                .size = 0x002c0000,
-                .offset = MTDPART_OFS_APPEND,
-        },{
-                .name = "yamon env",
-                .size = 0x00040000,
-                .offset = MTDPART_OFS_APPEND,
-        }
-};
-
-static struct mtd_info *mtx1_mtd;
-
-int __init mtx1_mtd_init(void)
-{
-	int ret = -ENXIO;
-
-	simple_map_init(&mtx1_map);
-
-	mtx1_map.virt = ioremap(mtx1_map.phys, mtx1_map.size);
-	if (!mtx1_map.virt)
-		return -EIO;
-
-	mtx1_mtd = do_map_probe("cfi_probe", &mtx1_map);
-	if (!mtx1_mtd)
-		goto err;
-
-	mtx1_mtd->owner = THIS_MODULE;
-
-	ret = add_mtd_partitions(mtx1_mtd, mtx1_partitions,
-			ARRAY_SIZE(mtx1_partitions));
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-       iounmap(mtx1_map.virt);
-       return ret;
-}
-
-static void __exit mtx1_mtd_cleanup(void)
-{
-	if (mtx1_mtd) {
-		del_mtd_partitions(mtx1_mtd);
-		map_destroy(mtx1_mtd);
-	}
-	if (mtx1_map.virt)
-		iounmap(mtx1_map.virt);
-}
-
-module_init(mtx1_mtd_init);
-module_exit(mtx1_mtd_cleanup);
-
-MODULE_AUTHOR("Bruno Randolf <bruno.randolf@4g-systems.biz>");
-MODULE_DESCRIPTION("MTX-1 flash map");
-MODULE_LICENSE("GPL");
