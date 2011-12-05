Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:11:23 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:58578 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab1LEPJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:07 +0100
Received: by eaac10 with SMTP id c10so5209157eaa.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HH9j5+lJqJszAGboUKgVhkLh3HTQd8A5c//Nug/l3mI=;
        b=EgYIrTG3ZcWC2HBGKDeTtd8PRbh/pZ+2l5TqdH17FAhkplB21zJaMZd1JOUw9ydjHe
         54+fItnSjoAr/ybsa9kfw44HbKyMFG01iZ4dv0qgvvE00T3MYfitAAInkJykDB9jzn6H
         PhtHiAB+oP7R2Ck82Jj9uPO5PGSZ1qS+uT44Y=
Received: by 10.216.14.37 with SMTP id c37mr2195912wec.86.1323097741982;
        Mon, 05 Dec 2011 07:09:01 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.09.00
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:09:01 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 3/7] MTD: MAPS: bcm963xx-flash: clean up printk usage
Date:   Mon,  5 Dec 2011 16:08:07 +0100
Message-Id: <1323097691-16414-4-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3361

Replace raw printk's with their pr_XXX equivalent and unify broken up
strings so they become grepable.

Also replace the PFX definition with a pr_fmt().

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/maps/bcm963xx-flash.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/maps/bcm963xx-flash.c b/drivers/mtd/maps/bcm963xx-flash.c
index 58cbaf2..ce2ca2a 100644
--- a/drivers/mtd/maps/bcm963xx-flash.c
+++ b/drivers/mtd/maps/bcm963xx-flash.c
@@ -18,6 +18,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -33,8 +35,6 @@
 #define BCM63XX_BUSWIDTH	2		/* Buswidth */
 #define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
 
-#define PFX KBUILD_MODNAME ": "
-
 static struct mtd_partition *parsed_parts;
 
 static struct mtd_info *bcm963xx_mtd_info;
@@ -79,8 +79,8 @@ static int parse_cfe_partitions(struct mtd_info *master,
 	tagversion = &(buf->tag_version[0]);
 	boardid = &(buf->board_id[0]);
 
-	printk(KERN_INFO PFX "CFE boot tag found with version %s "
-				"and board type %s\n", tagversion, boardid);
+	pr_info("CFE boot tag found with version %s and board type %s\n",
+		tagversion, boardid);
 
 	kerneladdr = kerneladdr - BCM63XX_EXTENDED_SIZE;
 	rootfsaddr = kerneladdr + kernellen;
@@ -139,13 +139,13 @@ static int parse_cfe_partitions(struct mtd_info *master,
 	parts[curpart].size = master->size - parts[0].size - parts[3].size;
 
 	for (i = 0; i < nrparts; i++)
-		printk(KERN_INFO PFX "Partition %d is %s offset %lx and "
-					"length %lx\n", i, parts[i].name,
-					(long unsigned int)(parts[i].offset),
-					(long unsigned int)(parts[i].size));
+		pr_info("Partition %d is %s offset %lx and length %lx\n", i,
+			parts[i].name, (long unsigned int)(parts[i].offset),
+			(long unsigned int)(parts[i].size));
+
+	pr_info("Spare partition is offset %x and length %x\n",	spareaddr,
+		sparelen);
 
-	printk(KERN_INFO PFX "Spare partition is offset %x and length %x\n",
-							spareaddr, sparelen);
 	*pparts = parts;
 	vfree(buf);
 
-- 
1.7.2.5
