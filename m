Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 18:49:38 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:11050
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225226AbTGARtg>; Tue, 1 Jul 2003 18:49:36 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19XPFw-0000p2-00; Tue, 01 Jul 2003 19:49:28 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.5] lasat mtd device fixup
Cc: linux-mips@linux-mips.org
Message-Id: <E19XPFw-0000p2-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Tue, 01 Jul 2003 19:49:28 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this fixes (in as far as I can test at the moment)
the mtd devices for 2.5.

There seems to be a spurious log message in the mtd code here:
drivers/mtd/mtd_blkdevs.c:blktrans_notify_add 331: count 0

/Brian

Index: drivers/mtd/maps/Kconfig
===================================================================
RCS file: /cvs/linux/drivers/mtd/maps/Kconfig,v
retrieving revision 1.5
diff -u -r1.5 Kconfig
--- drivers/mtd/maps/Kconfig	22 Jun 2003 23:09:53 -0000	1.5
+++ drivers/mtd/maps/Kconfig	1 Jul 2003 17:15:44 -0000
@@ -175,12 +175,6 @@
 	help
 	  Support for the flash chip on Tsunami TIG bus.
 
-config MTD_LASAT
-	tristate "Flash chips on LASAT board"
-	depends on LASAT && MTD_CFI
-	help
-	  Support for the flash chips on the Lasat 100 and 200 boards.
-
 config MTD_NETtel
 	tristate "CFI flash device on SnapGear/SecureEdge"
 	depends on X86 && MTD_PARTITIONS && MTD_JEDECPROBE
Index: drivers/mtd/maps/lasat.c
===================================================================
RCS file: /cvs/linux/drivers/mtd/maps/lasat.c,v
retrieving revision 1.3
diff -u -r1.3 lasat.c
--- drivers/mtd/maps/lasat.c	25 Feb 2003 22:39:02 -0000	1.3
+++ drivers/mtd/maps/lasat.c	1 Jul 2003 17:44:17 -0000
@@ -12,63 +12,13 @@
 #include <linux/mtd/partitions.h>
 #include <linux/config.h>
 #include <asm/lasat/lasat.h>
+#include <linux/init.h>
 
-static struct mtd_info *mymtd;
+static struct mtd_info *lasat_mtd;
 
-static __u8 sp_read8(struct map_info *map, unsigned long ofs)
-{
-	return __raw_readb(map->map_priv_1 + ofs);
-}
-
-static __u16 sp_read16(struct map_info *map, unsigned long ofs)
-{
-	return __raw_readw(map->map_priv_1 + ofs);
-}
-
-static __u32 sp_read32(struct map_info *map, unsigned long ofs)
-{
-	return __raw_readl(map->map_priv_1 + ofs);
-}
-
-static void sp_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
-{
-	memcpy_fromio(to, map->map_priv_1 + from, len);
-}
-
-static void sp_write8(struct map_info *map, __u8 d, unsigned long adr)
-{
-	__raw_writeb(d, map->map_priv_1 + adr);
-	mb();
-}
-
-static void sp_write16(struct map_info *map, __u16 d, unsigned long adr)
-{
-	__raw_writew(d, map->map_priv_1 + adr);
-	mb();
-}
-
-static void sp_write32(struct map_info *map, __u32 d, unsigned long adr)
-{
-	__raw_writel(d, map->map_priv_1 + adr);
-	mb();
-}
-
-static void sp_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
-{
-	memcpy_toio(map->map_priv_1 + to, from, len);
-}
-
-static struct map_info sp_map = {
-	name: "SP flash",
+static struct map_info lasat_map = {
+	name: "LASAT flash",
 	buswidth: 4,
-	read8: sp_read8,
-	read16: sp_read16,
-	read32: sp_read32,
-	copy_from: sp_copy_from,
-	write8: sp_write8,
-	write16: sp_write16,
-	write32: sp_write32,
-	copy_to: sp_copy_to
 };
 
 static struct mtd_partition partition_info[LASAT_MTD_LAST];
@@ -83,20 +33,22 @@
        	printk(KERN_NOTICE "Unprotecting flash\n");
 	*lasat_misc->flash_wp_reg |= 1 << lasat_misc->flash_wp_bit;
 
-	sp_map.map_priv_1 = lasat_flash_partition_start(LASAT_MTD_BOOTLOADER);
-	sp_map.size = lasat_board_info.li_flash_size;
+	lasat_map.phys = lasat_flash_partition_start(LASAT_MTD_BOOTLOADER);
+	lasat_map.virt = (unsigned long)ioremap_nocache(
+			lasat_map.phys, lasat_board_info.li_flash_size);
+	lasat_map.size = lasat_board_info.li_flash_size;
 
        	printk(KERN_NOTICE "sp flash device: %lx at %lx\n", 
-			sp_map.size, sp_map.map_priv_1);
+			lasat_map.size, lasat_map.phys);
 
 	for (i=0; i < LASAT_MTD_LAST; i++)
 		partition_info[i].name = lasat_mtd_partnames[i];
 
-	mymtd = do_map_probe("cfi_probe", &sp_map);
-	if (mymtd) {
+	lasat_mtd = do_map_probe("cfi_probe", &lasat_map);
+	if (lasat_mtd) {
 		u32 size, offset = 0;
 
-		mymtd->module = THIS_MODULE;
+		lasat_mtd->owner = THIS_MODULE;
 
 		for (i=0; i < LASAT_MTD_LAST; i++) {
 			size = lasat_flash_partition_size(i);
@@ -108,7 +60,7 @@
 			}
 		}
 
-		add_mtd_partitions( mymtd, partition_info, nparts );
+		add_mtd_partitions( lasat_mtd, partition_info, nparts );
 		return 0;
 	}
 
@@ -117,12 +69,9 @@
 
 static void __exit cleanup_sp(void)
 {
-	if (mymtd) {
-	  del_mtd_partitions(mymtd);
-	  map_destroy(mymtd);
-	}
-	if (sp_map.map_priv_1) {
-	  sp_map.map_priv_1 = 0;
+	if (lasat_mtd) {
+	  del_mtd_partitions(lasat_mtd);
+	  map_destroy(lasat_mtd);
 	}
 }
 
Index: arch/mips/lasat/lasat_board.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/lasat_board.c,v
retrieving revision 1.4
diff -u -r1.4 lasat_board.c
--- arch/mips/lasat/lasat_board.c	22 Jun 2003 02:19:24 -0000	1.4
+++ arch/mips/lasat/lasat_board.c	1 Jul 2003 17:39:17 -0000
@@ -71,19 +71,19 @@
 	ls[LASAT_MTD_NORMAL] = 0x100000;
 
 	if (mips_machtype == MACH_LASAT_100) {
-		lasat_board_info.li_flash_base = KSEG1ADDR(0x1e000000);
+		lasat_board_info.li_flash_base = 0x1e000000;
 		
-		lb[LASAT_MTD_BOOTLOADER] = KSEG1ADDR(0x1e400000);
+		lb[LASAT_MTD_BOOTLOADER] = 0x1e400000;
 
 		if (lasat_board_info.li_flash_size > 0x200000) {
 			ls[LASAT_MTD_CONFIG] = 0x100000;
 			ls[LASAT_MTD_FS] = 0x500000;
 		}
 	} else {
-		lasat_board_info.li_flash_base = KSEG1ADDR(0x10000000);
+		lasat_board_info.li_flash_base = 0x10000000;
 
 		if (lasat_board_info.li_flash_size < 0x1000000) {
-			lb[LASAT_MTD_BOOTLOADER] = KSEG1ADDR(0x10000000);
+			lb[LASAT_MTD_BOOTLOADER] = 0x10000000;
 			ls[LASAT_MTD_CONFIG] = 0x100000;
 			if (lasat_board_info.li_flash_size >= 0x400000) {
 				ls[LASAT_MTD_FS] = lasat_board_info.li_flash_size - 0x300000;
