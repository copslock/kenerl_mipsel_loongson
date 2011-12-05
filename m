Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:12:55 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:43785 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903628Ab1LEPJJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:09 +0100
Received: by bkcje16 with SMTP id je16so4360331bkc.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6W4IjZ57fVgR32oPLRimFhhe/BoFZN9f55aiHZ5rjT0=;
        b=DkVj3AYo8L2uLw+pYKKSDRhBeEt84K/JqDogDOo7K9AGtEKLletXoYoBXNO2s9Pqzy
         Z2Vn7G/TlmUQ2FmWcFQXPyCEL/jSjAyNkMBGCGEqY8QTnslregw3YgUjmErdYgavz9VA
         s/xjqpfhYOdYbCN2A/DYnrJUJcSlIg28YlPL4=
Received: by 10.180.104.35 with SMTP id gb3mr13534154wib.11.1323097743879;
        Mon, 05 Dec 2011 07:09:03 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.09.02
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:09:02 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: =?UTF-8?q?=5BPATCH=204/7=5D=20MTD=3A=20MAPS=3A=20bcm963xx-flash=3A=20make=20CFE=20partition=20parsing=20an=20mtd=20parser?=
Date:   Mon,  5 Dec 2011 16:08:08 +0100
Message-Id: <1323097691-16414-5-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3363

Recent BCM63XX devices support a variety of flash types (parallel, SPI,
NAND) and share the partition layout. To prevent code duplication make
the CFE partition parsing code a stand alone mtd parser to allow SPI or
NAND flash drivers to use it.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/Kconfig               |    8 ++
 drivers/mtd/Makefile              |    1 +
 drivers/mtd/bcm63xxpart.c         |  189 +++++++++++++++++++++++++++++++++++++
 drivers/mtd/maps/Kconfig          |    1 +
 drivers/mtd/maps/bcm963xx-flash.c |  153 +-----------------------------
 5 files changed, 202 insertions(+), 150 deletions(-)
 create mode 100644 drivers/mtd/bcm63xxpart.c

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 318a869..1be6218 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -140,6 +140,14 @@ config MTD_AR7_PARTS
 	---help---
 	  TI AR7 partitioning support
 
+config MTD_BCM63XX_PARTS
+	tristate "BCM63XX CFE partitioning support"
+	depends on BCM63XX
+	select CRC32
+	help
+	  This provides partions parsing for BCM63xx devices with CFE
+	  bootloaders.
+
 comment "User Modules And Translation Layers"
 
 config MTD_CHAR
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 9aaac3a..f901354 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
 obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
 obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
+obj-$(CONFIG_MTD_BCM63XX_PARTS)	+= bcm63xxpart.o
 
 # 'Users' - code which presents functionality to userspace.
 obj-$(CONFIG_MTD_CHAR)		+= mtdchar.o
diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
new file mode 100644
index 0000000..ac7d3c8
--- /dev/null
+++ b/drivers/mtd/bcm63xxpart.c
@@ -0,0 +1,189 @@
+/*
+ * BCM63XX CFE image tag parser
+ *
+ * Copyright © 2006-2008  Florian Fainelli <florian@openwrt.org>
+ *			  Mike Albon <malbon@openwrt.org>
+ * Copyright © 2009-2010  Daniel Dickinson <openwrt@cshore.neomailbox.net>
+ * Copyright © 2011 Jonas Gorski <jonas.gorski@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/mach-bcm63xx/bcm963xx_tag.h>
+
+#define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
+
+static int bcm63xx_detect_cfe(struct mtd_info *master)
+{
+	int idoffset = 0x4e0;
+	static char idstring[8] = "CFE1CFE1";
+	char buf[9];
+	int ret;
+	size_t retlen;
+
+	ret = master->read(master, idoffset, 8, &retlen, (void *)buf);
+	buf[retlen] = 0;
+	pr_info("Read Signature value of %s\n", buf);
+
+	return strncmp(idstring, buf, 8);
+}
+
+static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
+					struct mtd_partition **pparts,
+					struct mtd_part_parser_data *data)
+{
+	/* CFE, NVRAM and global Linux are always present */
+	int nrparts = 3, curpart = 0;
+	struct bcm_tag *buf;
+	struct mtd_partition *parts;
+	int ret;
+	size_t retlen;
+	unsigned int rootfsaddr, kerneladdr, spareaddr;
+	unsigned int rootfslen, kernellen, sparelen, totallen;
+	int namelen = 0;
+	int i;
+	char *boardid;
+	char *tagversion;
+
+	if (bcm63xx_detect_cfe(master))
+		return -EINVAL;
+
+	/* Allocate memory for buffer */
+	buf = vmalloc(sizeof(struct bcm_tag));
+	if (!buf)
+		return -ENOMEM;
+
+	/* Get the tag */
+	ret = master->read(master, master->erasesize, sizeof(struct bcm_tag),
+							&retlen, (void *)buf);
+	if (retlen != sizeof(struct bcm_tag)) {
+		vfree(buf);
+		return -EIO;
+	}
+
+	sscanf(buf->kernel_address, "%u", &kerneladdr);
+	sscanf(buf->kernel_length, "%u", &kernellen);
+	sscanf(buf->total_length, "%u", &totallen);
+	tagversion = &(buf->tag_version[0]);
+	boardid = &(buf->board_id[0]);
+
+	pr_info("CFE boot tag found with version %s and board type %s\n",
+		tagversion, boardid);
+
+	kerneladdr = kerneladdr - BCM63XX_EXTENDED_SIZE;
+	rootfsaddr = kerneladdr + kernellen;
+	spareaddr = roundup(totallen, master->erasesize) + master->erasesize;
+	sparelen = master->size - spareaddr - master->erasesize;
+	rootfslen = spareaddr - rootfsaddr;
+
+	/* Determine number of partitions */
+	namelen = 8;
+	if (rootfslen > 0) {
+		nrparts++;
+		namelen += 6;
+	}
+	if (kernellen > 0) {
+		nrparts++;
+		namelen += 6;
+	}
+
+	/* Ask kernel for more memory */
+	parts = kzalloc(sizeof(*parts) * nrparts + 10 * nrparts, GFP_KERNEL);
+	if (!parts) {
+		vfree(buf);
+		return -ENOMEM;
+	}
+
+	/* Start building partition list */
+	parts[curpart].name = "CFE";
+	parts[curpart].offset = 0;
+	parts[curpart].size = master->erasesize;
+	curpart++;
+
+	if (kernellen > 0) {
+		parts[curpart].name = "kernel";
+		parts[curpart].offset = kerneladdr;
+		parts[curpart].size = kernellen;
+		curpart++;
+	}
+
+	if (rootfslen > 0) {
+		parts[curpart].name = "rootfs";
+		parts[curpart].offset = rootfsaddr;
+		parts[curpart].size = rootfslen;
+		if (sparelen > 0)
+			parts[curpart].size += sparelen;
+		curpart++;
+	}
+
+	parts[curpart].name = "nvram";
+	parts[curpart].offset = master->size - master->erasesize;
+	parts[curpart].size = master->erasesize;
+
+	/* Global partition "linux" to make easy firmware upgrade */
+	curpart++;
+	parts[curpart].name = "linux";
+	parts[curpart].offset = parts[0].size;
+	parts[curpart].size = master->size - parts[0].size - parts[3].size;
+
+	for (i = 0; i < nrparts; i++)
+		pr_info("Partition %d is %s offset %lx and length %lx\n", i,
+			parts[i].name, (long unsigned int)(parts[i].offset),
+			(long unsigned int)(parts[i].size));
+
+	pr_info("Spare partition is offset %x and length %x\n",	spareaddr,
+		sparelen);
+
+	*pparts = parts;
+	vfree(buf);
+
+	return nrparts;
+};
+
+static struct mtd_part_parser bcm63xx_cfe_parser = {
+	.owner = THIS_MODULE,
+	.parse_fn = bcm63xx_parse_cfe_partitions,
+	.name = "bcm63xxpart",
+};
+
+static int __init bcm63xx_cfe_parser_init(void)
+{
+	return register_mtd_parser(&bcm63xx_cfe_parser);
+}
+
+static void __exit bcm63xx_cfe_parser_exit(void)
+{
+	deregister_mtd_parser(&bcm63xx_cfe_parser);
+}
+
+module_init(bcm63xx_cfe_parser_init);
+module_exit(bcm63xx_cfe_parser_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Dickinson <openwrt@cshore.neomailbox.net>");
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_AUTHOR("Mike Albon <malbon@openwrt.org>");
+MODULE_AUTHOR("Jonas Gorski <jonas.gorski@gmail.com");
+MODULE_DESCRIPTION("MTD partitioning for BCM63XX CFE bootloaders");
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 8e0c4bf..acc5e08 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -247,6 +247,7 @@ config MTD_BCM963XX
         depends on BCM63XX
 	select MTD_MAP_BANK_WIDTH_2
 	select MTD_CFI_I1
+	select MTD_BCM63XX_PARTS
         help
 	  Support for parsing CFE image tag and creating MTD partitions on
 	  Broadcom BCM63xx boards.
diff --git a/drivers/mtd/maps/bcm963xx-flash.c b/drivers/mtd/maps/bcm963xx-flash.c
index ce2ca2a..c106632 100644
--- a/drivers/mtd/maps/bcm963xx-flash.c
+++ b/drivers/mtd/maps/bcm963xx-flash.c
@@ -26,16 +26,10 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/vmalloc.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <asm/mach-bcm63xx/bcm963xx_tag.h>
-
 #define BCM63XX_BUSWIDTH	2		/* Buswidth */
-#define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
-
-static struct mtd_partition *parsed_parts;
 
 static struct mtd_info *bcm963xx_mtd_info;
 
@@ -44,134 +38,11 @@ static struct map_info bcm963xx_map = {
 	.bankwidth	= BCM63XX_BUSWIDTH,
 };
 
-static int parse_cfe_partitions(struct mtd_info *master,
-						struct mtd_partition **pparts)
-{
-	/* CFE, NVRAM and global Linux are always present */
-	int nrparts = 3, curpart = 0;
-	struct bcm_tag *buf;
-	struct mtd_partition *parts;
-	int ret;
-	size_t retlen;
-	unsigned int rootfsaddr, kerneladdr, spareaddr;
-	unsigned int rootfslen, kernellen, sparelen, totallen;
-	int namelen = 0;
-	int i;
-	char *boardid;
-	char *tagversion;
-
-	/* Allocate memory for buffer */
-	buf = vmalloc(sizeof(struct bcm_tag));
-	if (!buf)
-		return -ENOMEM;
-
-	/* Get the tag */
-	ret = master->read(master, master->erasesize, sizeof(struct bcm_tag),
-							&retlen, (void *)buf);
-	if (retlen != sizeof(struct bcm_tag)) {
-		vfree(buf);
-		return -EIO;
-	}
-
-	sscanf(buf->kernel_address, "%u", &kerneladdr);
-	sscanf(buf->kernel_length, "%u", &kernellen);
-	sscanf(buf->total_length, "%u", &totallen);
-	tagversion = &(buf->tag_version[0]);
-	boardid = &(buf->board_id[0]);
-
-	pr_info("CFE boot tag found with version %s and board type %s\n",
-		tagversion, boardid);
-
-	kerneladdr = kerneladdr - BCM63XX_EXTENDED_SIZE;
-	rootfsaddr = kerneladdr + kernellen;
-	spareaddr = roundup(totallen, master->erasesize) + master->erasesize;
-	sparelen = master->size - spareaddr - master->erasesize;
-	rootfslen = spareaddr - rootfsaddr;
-
-	/* Determine number of partitions */
-	namelen = 8;
-	if (rootfslen > 0) {
-		nrparts++;
-		namelen += 6;
-	}
-	if (kernellen > 0) {
-		nrparts++;
-		namelen += 6;
-	}
-
-	/* Ask kernel for more memory */
-	parts = kzalloc(sizeof(*parts) * nrparts + 10 * nrparts, GFP_KERNEL);
-	if (!parts) {
-		vfree(buf);
-		return -ENOMEM;
-	}
-
-	/* Start building partition list */
-	parts[curpart].name = "CFE";
-	parts[curpart].offset = 0;
-	parts[curpart].size = master->erasesize;
-	curpart++;
-
-	if (kernellen > 0) {
-		parts[curpart].name = "kernel";
-		parts[curpart].offset = kerneladdr;
-		parts[curpart].size = kernellen;
-		curpart++;
-	}
-
-	if (rootfslen > 0) {
-		parts[curpart].name = "rootfs";
-		parts[curpart].offset = rootfsaddr;
-		parts[curpart].size = rootfslen;
-		if (sparelen > 0)
-			parts[curpart].size += sparelen;
-		curpart++;
-	}
-
-	parts[curpart].name = "nvram";
-	parts[curpart].offset = master->size - master->erasesize;
-	parts[curpart].size = master->erasesize;
-
-	/* Global partition "linux" to make easy firmware upgrade */
-	curpart++;
-	parts[curpart].name = "linux";
-	parts[curpart].offset = parts[0].size;
-	parts[curpart].size = master->size - parts[0].size - parts[3].size;
-
-	for (i = 0; i < nrparts; i++)
-		pr_info("Partition %d is %s offset %lx and length %lx\n", i,
-			parts[i].name, (long unsigned int)(parts[i].offset),
-			(long unsigned int)(parts[i].size));
-
-	pr_info("Spare partition is offset %x and length %x\n",	spareaddr,
-		sparelen);
-
-	*pparts = parts;
-	vfree(buf);
-
-	return nrparts;
-};
-
-static int bcm963xx_detect_cfe(struct mtd_info *master)
-{
-	int idoffset = 0x4e0;
-	static char idstring[8] = "CFE1CFE1";
-	char buf[9];
-	int ret;
-	size_t retlen;
-
-	ret = master->read(master, idoffset, 8, &retlen, (void *)buf);
-	buf[retlen] = 0;
-	printk(KERN_INFO PFX "Read Signature value of %s\n", buf);
-
-	return strncmp(idstring, buf, 8);
-}
+static const char *part_types[] = { "bcm63xxpart", NULL };
 
 static int bcm963xx_probe(struct platform_device *pdev)
 {
 	int err = 0;
-	int parsed_nr_parts = 0;
-	char *part_type;
 	struct resource *r;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -207,26 +78,8 @@ static int bcm963xx_probe(struct platform_device *pdev)
 probe_ok:
 	bcm963xx_mtd_info->owner = THIS_MODULE;
 
-	/* This is mutually exclusive */
-	if (bcm963xx_detect_cfe(bcm963xx_mtd_info) == 0) {
-		dev_info(&pdev->dev, "CFE bootloader detected\n");
-		if (parsed_nr_parts == 0) {
-			int ret = parse_cfe_partitions(bcm963xx_mtd_info,
-							&parsed_parts);
-			if (ret > 0) {
-				part_type = "CFE";
-				parsed_nr_parts = ret;
-			}
-		}
-	} else {
-		dev_info(&pdev->dev, "unsupported bootloader\n");
-		err = -ENODEV;
-		goto err_probe;
-	}
-
-	return mtd_device_register(bcm963xx_mtd_info, parsed_parts,
-				   parsed_nr_parts);
-
+	return mtd_device_parse_register(bcm963xx_mtd_info, part_types, NULL,
+					 NULL, 0);
 err_probe:
 	iounmap(bcm963xx_map.virt);
 	return err;
-- 
1.7.2.5
