Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:11:48 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54807 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903627Ab1LEPJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:07 +0100
Received: by mail-fx0-f49.google.com with SMTP id s1so1350875fab.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wKUdCQ6+s5SdlbUNxCt5PX1e3m17hLI4asgPVvgJGp8=;
        b=I56AgDbjFY6pfzdcYUpHR+MSFhFYnbFRrO/70J2jMkyYdW4iL9S7dRxBT/n932z6WU
         gwwZkKZJPNcjRs6TPcX1AT6d5LCArV6D/u0BT1KWCRvDo8dpN8fP5OMbgV0mw9v0yBui
         h2OkknBEwfDRe2j1bld1yTr+sr5npPIqmgzfU=
Received: by 10.227.204.197 with SMTP id fn5mr15951040wbb.15.1323097747571;
        Mon, 05 Dec 2011 07:09:07 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.09.06
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:09:07 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: =?UTF-8?q?=5BPATCH=207/7=5D=20MTD=3A=20MAPS=3A=20remove=20the=20now=20unused=20bcm963xx-flash?=
Date:   Mon,  5 Dec 2011 16:08:11 +0100
Message-Id: <1323097691-16414-8-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3362

bcm963xx-flash does nothing meaningful anymore.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/maps/bcm963xx-flash.c |  118 -------------------------------------
 1 files changed, 0 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/mtd/maps/bcm963xx-flash.c

diff --git a/drivers/mtd/maps/bcm963xx-flash.c b/drivers/mtd/maps/bcm963xx-flash.c
deleted file mode 100644
index c106632..0000000
--- a/drivers/mtd/maps/bcm963xx-flash.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Copyright © 2006-2008  Florian Fainelli <florian@openwrt.org>
- *			  Mike Albon <malbon@openwrt.org>
- * Copyright © 2009-2010  Daniel Dickinson <openwrt@cshore.neomailbox.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#define BCM63XX_BUSWIDTH	2		/* Buswidth */
-
-static struct mtd_info *bcm963xx_mtd_info;
-
-static struct map_info bcm963xx_map = {
-	.name		= "bcm963xx",
-	.bankwidth	= BCM63XX_BUSWIDTH,
-};
-
-static const char *part_types[] = { "bcm63xxpart", NULL };
-
-static int bcm963xx_probe(struct platform_device *pdev)
-{
-	int err = 0;
-	struct resource *r;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "no resource supplied\n");
-		return -ENODEV;
-	}
-
-	bcm963xx_map.phys = r->start;
-	bcm963xx_map.size = resource_size(r);
-	bcm963xx_map.virt = ioremap(r->start, resource_size(r));
-	if (!bcm963xx_map.virt) {
-		dev_err(&pdev->dev, "failed to ioremap\n");
-		return -EIO;
-	}
-
-	dev_info(&pdev->dev, "0x%08lx at 0x%08x\n",
-					bcm963xx_map.size, bcm963xx_map.phys);
-
-	simple_map_init(&bcm963xx_map);
-
-	bcm963xx_mtd_info = do_map_probe("cfi_probe", &bcm963xx_map);
-	if (!bcm963xx_mtd_info) {
-		dev_err(&pdev->dev, "failed to probe using CFI\n");
-		bcm963xx_mtd_info = do_map_probe("jedec_probe", &bcm963xx_map);
-		if (bcm963xx_mtd_info)
-			goto probe_ok;
-		dev_err(&pdev->dev, "failed to probe using JEDEC\n");
-		err = -EIO;
-		goto err_probe;
-	}
-
-probe_ok:
-	bcm963xx_mtd_info->owner = THIS_MODULE;
-
-	return mtd_device_parse_register(bcm963xx_mtd_info, part_types, NULL,
-					 NULL, 0);
-err_probe:
-	iounmap(bcm963xx_map.virt);
-	return err;
-}
-
-static int bcm963xx_remove(struct platform_device *pdev)
-{
-	if (bcm963xx_mtd_info) {
-		mtd_device_unregister(bcm963xx_mtd_info);
-		map_destroy(bcm963xx_mtd_info);
-	}
-
-	if (bcm963xx_map.virt) {
-		iounmap(bcm963xx_map.virt);
-		bcm963xx_map.virt = 0;
-	}
-
-	return 0;
-}
-
-static struct platform_driver bcm63xx_mtd_dev = {
-	.probe	= bcm963xx_probe,
-	.remove = bcm963xx_remove,
-	.driver = {
-		.name	= "bcm963xx-flash",
-		.owner	= THIS_MODULE,
-	},
-};
-
-module_platform_driver(bcm63xx_mtd_dev);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Broadcom BCM63xx MTD driver for CFE and RedBoot");
-MODULE_AUTHOR("Daniel Dickinson <openwrt@cshore.neomailbox.net>");
-MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
-MODULE_AUTHOR("Mike Albon <malbon@openwrt.org>");
-- 
1.7.2.5
