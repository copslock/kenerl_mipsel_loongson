Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 15:46:58 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:31290 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021621AbXG3Oq4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 15:46:56 +0100
Received: by mo.po.2iij.net (mo30) id l6UEklu6083655; Mon, 30 Jul 2007 23:46:47 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox302) id l6UEkhYt004718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 23:46:43 +0900
Date:	Mon, 30 Jul 2007 23:46:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] more removal Momenco Ocelot
Message-Id: <20070730234642.68a67a12.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

more removal Momenco Ocelot

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-07-30 23:13:17.627092000 +0900
+++ mips/arch/mips/Kconfig	2007-07-30 23:13:24.579526500 +0900
@@ -811,20 +811,6 @@ config EMMA2RH
 config SERIAL_RM9000
 	bool
 
-#
-# Unfortunately not all GT64120 systems run the chip at the same clock.
-# As the user for the clock rate and try to minimize the available options.
-#
-choice
-	prompt "Galileo Chip Clock"
-	depends on MOMENCO_OCELOT
-	default SYSCLK_100 if MOMENCO_OCELOT
-
-config SYSCLK_100
-	bool "100" if MOMENCO_OCELOT
-
-endchoice
-
 config ARC32
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mtd/maps/Kconfig mips/drivers/mtd/maps/Kconfig
--- mips-orig/drivers/mtd/maps/Kconfig	2007-07-30 23:13:48.817041250 +0900
+++ mips/drivers/mtd/maps/Kconfig	2007-07-30 23:13:24.591527250 +0900
@@ -392,14 +392,6 @@ config MTD_TQM834x
 	  TQ Components TQM834x boards. If you have one of these boards
 	  and would like to use the flash chips on it, say 'Y'.
 
-config MTD_OCELOT
-	tristate "Momenco Ocelot boot flash device"
-	depends on MOMENCO_OCELOT
-	help
-	  This enables access routines for the boot flash device and for the
-	  NVRAM on the Momenco Ocelot board. If you have one of these boards
-	  and would like access to either of these, say 'Y'.
-
 config MTD_SOLUTIONENGINE
 	tristate "CFI Flash device mapped on Hitachi SolutionEngine"
 	depends on SUPERH && MTD_CFI && MTD_REDBOOT_PARTS
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mtd/maps/Makefile mips/drivers/mtd/maps/Makefile
--- mips-orig/drivers/mtd/maps/Makefile	2007-07-30 23:13:48.817041250 +0900
+++ mips/drivers/mtd/maps/Makefile	2007-07-30 23:13:24.939549000 +0900
@@ -43,7 +43,6 @@ obj-$(CONFIG_MTD_SUN_UFLASH)	+= sun_ufla
 obj-$(CONFIG_MTD_VMAX)		+= vmax301.o
 obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 obj-$(CONFIG_MTD_DBOX2)		+= dbox2-flash.o
-obj-$(CONFIG_MTD_OCELOT)	+= ocelot.o
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
 obj-$(CONFIG_MTD_PCI)		+= pci.o
 obj-$(CONFIG_MTD_ALCHEMY)       += alchemy-flash.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mtd/maps/ocelot.c mips/drivers/mtd/maps/ocelot.c
--- mips-orig/drivers/mtd/maps/ocelot.c	2007-07-30 23:13:48.829042000 +0900
+++ mips/drivers/mtd/maps/ocelot.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,175 +0,0 @@
-/*
- * $Id: ocelot.c,v 1.17 2005/11/07 11:14:27 gleixner Exp $
- *
- * Flash on Momenco Ocelot
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/io.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#define OCELOT_PLD 0x2c000000
-#define FLASH_WINDOW_ADDR 0x2fc00000
-#define FLASH_WINDOW_SIZE 0x00080000
-#define FLASH_BUSWIDTH 1
-#define NVRAM_WINDOW_ADDR 0x2c800000
-#define NVRAM_WINDOW_SIZE 0x00007FF0
-#define NVRAM_BUSWIDTH 1
-
-static unsigned int cacheflush = 0;
-
-static struct mtd_info *flash_mtd;
-static struct mtd_info *nvram_mtd;
-
-static void ocelot_ram_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen, const u_char *buf)
-{
-        struct map_info *map = mtd->priv;
-	size_t done = 0;
-
-	/* If we use memcpy, it does word-wide writes. Even though we told the
-	   GT64120A that it's an 8-bit wide region, word-wide writes don't work.
-	   We end up just writing the first byte of the four to all four bytes.
-	   So we have this loop instead */
-	*retlen = len;
-	while(len) {
-		__raw_writeb(*(unsigned char *) from, map->virt + to);
-		from++;
-		to++;
-		len--;
-	}
-}
-
-static struct mtd_partition *parsed_parts;
-
-struct map_info ocelot_flash_map = {
-	.name = "Ocelot boot flash",
-	.size = FLASH_WINDOW_SIZE,
-	.bankwidth = FLASH_BUSWIDTH,
-	.phys = FLASH_WINDOW_ADDR,
-};
-
-struct map_info ocelot_nvram_map = {
-	.name = "Ocelot NVRAM",
-	.size = NVRAM_WINDOW_SIZE,
-	.bankwidth = NVRAM_BUSWIDTH,
-	.phys = NVRAM_WINDOW_ADDR,
-};
-
-static const char *probes[] = { "RedBoot", NULL };
-
-static int __init init_ocelot_maps(void)
-{
-	void *pld;
-	int nr_parts;
-	unsigned char brd_status;
-
-       	printk(KERN_INFO "Momenco Ocelot MTD mappings: Flash 0x%x at 0x%x, NVRAM 0x%x at 0x%x\n",
-	       FLASH_WINDOW_SIZE, FLASH_WINDOW_ADDR, NVRAM_WINDOW_SIZE, NVRAM_WINDOW_ADDR);
-
-	/* First check whether the flash jumper is present */
-	pld = ioremap(OCELOT_PLD, 0x10);
-	if (!pld) {
-		printk(KERN_NOTICE "Failed to ioremap Ocelot PLD\n");
-		return -EIO;
-	}
-	brd_status = readb(pld+4);
-	iounmap(pld);
-
-	/* Now ioremap the NVRAM space */
-	ocelot_nvram_map.virt = ioremap_nocache(NVRAM_WINDOW_ADDR, NVRAM_WINDOW_SIZE);
-	if (!ocelot_nvram_map.virt) {
-		printk(KERN_NOTICE "Failed to ioremap Ocelot NVRAM space\n");
-		return -EIO;
-	}
-
-	simple_map_init(&ocelot_nvram_map);
-
-	/* And do the RAM probe on it to get an MTD device */
-	nvram_mtd = do_map_probe("map_ram", &ocelot_nvram_map);
-	if (!nvram_mtd) {
-		printk("NVRAM probe failed\n");
-		goto fail_1;
-	}
-	nvram_mtd->owner = THIS_MODULE;
-	nvram_mtd->erasesize = 16;
-	/* Override the write() method */
-	nvram_mtd->write = ocelot_ram_write;
-
-	/* Now map the flash space */
-	ocelot_flash_map.virt = ioremap_nocache(FLASH_WINDOW_ADDR, FLASH_WINDOW_SIZE);
-	if (!ocelot_flash_map.virt) {
-		printk(KERN_NOTICE "Failed to ioremap Ocelot flash space\n");
-		goto fail_2;
-	}
-	/* Now the cached version */
-	ocelot_flash_map.cached = (unsigned long)__ioremap(FLASH_WINDOW_ADDR, FLASH_WINDOW_SIZE, 0);
-
-	simple_map_init(&ocelot_flash_map);
-
-	/* Only probe for flash if the write jumper is present */
-	if (brd_status & 0x40) {
-		flash_mtd = do_map_probe("jedec", &ocelot_flash_map);
-	} else {
-		printk(KERN_NOTICE "Ocelot flash write jumper not present. Treating as ROM\n");
-	}
-	/* If that failed or the jumper's absent, pretend it's ROM */
-	if (!flash_mtd) {
-		flash_mtd = do_map_probe("map_rom", &ocelot_flash_map);
-		/* If we're treating it as ROM, set the erase size */
-		if (flash_mtd)
-			flash_mtd->erasesize = 0x10000;
-	}
-	if (!flash_mtd)
-		goto fail3;
-
-	add_mtd_device(nvram_mtd);
-
-	flash_mtd->owner = THIS_MODULE;
-	nr_parts = parse_mtd_partitions(flash_mtd, probes, &parsed_parts, 0);
-
-	if (nr_parts > 0)
-		add_mtd_partitions(flash_mtd, parsed_parts, nr_parts);
-	else
-		add_mtd_device(flash_mtd);
-
-	return 0;
-
- fail3:
-	iounmap((void *)ocelot_flash_map.virt);
-	if (ocelot_flash_map.cached)
-			iounmap((void *)ocelot_flash_map.cached);
- fail_2:
-	map_destroy(nvram_mtd);
- fail_1:
-	iounmap((void *)ocelot_nvram_map.virt);
-
-	return -ENXIO;
-}
-
-static void __exit cleanup_ocelot_maps(void)
-{
-	del_mtd_device(nvram_mtd);
-	map_destroy(nvram_mtd);
-	iounmap((void *)ocelot_nvram_map.virt);
-
-	if (parsed_parts)
-		del_mtd_partitions(flash_mtd);
-	else
-		del_mtd_device(flash_mtd);
-	map_destroy(flash_mtd);
-	iounmap((void *)ocelot_flash_map.virt);
-	if (ocelot_flash_map.cached)
-		iounmap((void *)ocelot_flash_map.cached);
-}
-
-module_init(init_ocelot_maps);
-module_exit(cleanup_ocelot_maps);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Red Hat, Inc. - David Woodhouse <dwmw2@cambridge.redhat.com>");
-MODULE_DESCRIPTION("MTD map driver for Momenco Ocelot board");
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/bootinfo.h mips/include/asm-mips/bootinfo.h
--- mips-orig/include/asm-mips/bootinfo.h	2007-07-30 23:14:33.699846250 +0900
+++ mips/include/asm-mips/bootinfo.h	2007-07-30 23:13:24.947549500 +0900
@@ -99,16 +99,6 @@
 #define  MACH_COSINE_ORION	0
 
 /*
- * Valid machtype for group MOMENCO
- */
-#define MACH_GROUP_MOMENCO	12	/* Momentum Boards		*/
-#define  MACH_MOMENCO_OCELOT	0
-#define  MACH_MOMENCO_OCELOT_G	1	/* no more supported (may 2007) */
-#define  MACH_MOMENCO_OCELOT_C	2	/* no more supported (jun 2007) */
-#define  MACH_MOMENCO_JAGUAR_ATX 3	/* no more supported (may 2007) */
-#define  MACH_MOMENCO_OCELOT_3	4
-
-/*
  * Valid machtype for group PHILIPS
  */
 #define MACH_GROUP_PHILIPS     14
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-ocelot/mach-gt64120.h mips/include/asm-mips/mach-ocelot/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-ocelot/mach-gt64120.h	2007-07-30 23:14:34.419891250 +0900
+++ mips/include/asm-mips/mach-ocelot/mach-gt64120.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,30 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#ifndef _ASM_GT64120_MOMENCO_OCELOT_GT64120_DEP_H
-#define _ASM_GT64120_MOMENCO_OCELOT_GT64120_DEP_H
-
-/*
- * PCI address allocation
- */
-#define GT_PCI_MEM_BASE	(0x22000000UL)
-#define GT_PCI_MEM_SIZE	GT_DEF_PCI0_MEM0_SIZE
-#define GT_PCI_IO_BASE	(0x20000000UL)
-#define GT_PCI_IO_SIZE	GT_DEF_PCI0_IO_SIZE
-
-extern unsigned long gt64120_base;
-
-#define GT64120_BASE	(gt64120_base)
-
-/*
- * GT timer irq
- */
-#define	GT_TIMER		6
-
-#endif  /* _ASM_GT64120_MOMENCO_OCELOT_GT64120_DEP_H */
