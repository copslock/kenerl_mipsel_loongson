Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62K6qRw019712
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 13:06:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62K6q9o019711
	for linux-mips-outgoing; Tue, 2 Jul 2002 13:06:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62K6RRw019639
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 13:06:28 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.2/Debian -5) with ESMTP id g62KAIXK007464
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 22:10:18 +0200
Message-ID: <3D2208AA.6040009@murphy.dk>
Date: Tue, 02 Jul 2002 22:10:18 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: LASAT board mtd support
Content-Type: multipart/mixed;
 boundary="------------050402030206010203080203"
X-Spam-Status: No, hits=-4.3 required=5.0 tests=TO_LOCALPART_EQ_REAL,PORN_10,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------050402030206010203080203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please find attached a patch to add mtd support for the Lasat
platforms. Patch applies to the 2.4 CVS branch.

/Brian

--------------050402030206010203080203
Content-Type: text/plain;
 name="mtd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mtd.diff"

--- drivers/mtd/maps/Config.in	2002/06/26 22:35:49	1.3.2.3
+++ drivers/mtd/maps/Config.in	2002/07/02 18:46:45
@@ -57,6 +57,7 @@
       int '    Bus width in octets' CONFIG_MTD_CSTM_MIPS_IXX_BUSWIDTH 2
    fi
    dep_tristate '  Momenco Ocelot boot flash device' CONFIG_MTD_OCELOT $CONFIG_MOMENCO_OCELOT
+   dep_tristate '  LASAT flash device' CONFIG_MTD_LASAT $CONFIG_MTD_CFI $CONFIG_LASAT
 fi
 
 if [ "$CONFIG_SUPERH" = "y" ]; then
--- drivers/mtd/maps/Makefile	2002/06/26 22:35:49	1.2.2.3
+++ drivers/mtd/maps/Makefile	2002/07/02 18:46:45
@@ -38,6 +38,7 @@
 obj-$(CONFIG_MTD_PCI)		+= pci.o
 obj-$(CONFIG_MTD_PB1000)        += pb1xxx-flash.o
 obj-$(CONFIG_MTD_PB1500)        += pb1xxx-flash.o
+obj-$(CONFIG_MTD_LASAT)     	+= lasat.o
 obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o
 
 include $(TOPDIR)/Rules.make

--- /dev/null	Sun Apr 14 10:11:55 2002
+++ drivers/mtd/maps/lasat.c	Wed May 29 13:20:24 2002
@@ -0,0 +1,136 @@
+/*
+ * Flash device on lasat 100 and 200 boards
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/config.h>
+#include <asm/lasat/lasat.h>
+#include <asm/lasat/lasat_mtd.h>
+
+static struct mtd_info *mymtd;
+
+static volatile unsigned int *wpreg = (void *)(LASAT_FLASHWP_REG);
+
+static __u8 sp_read8(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readb(map->map_priv_1 + ofs);
+}
+
+static __u16 sp_read16(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readw(map->map_priv_1 + ofs);
+}
+
+static __u32 sp_read32(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readl(map->map_priv_1 + ofs);
+}
+
+static void sp_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
+{
+	memcpy_fromio(to, map->map_priv_1 + from, len);
+}
+
+static void sp_write8(struct map_info *map, __u8 d, unsigned long adr)
+{
+	__raw_writeb(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void sp_write16(struct map_info *map, __u16 d, unsigned long adr)
+{
+	__raw_writew(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void sp_write32(struct map_info *map, __u32 d, unsigned long adr)
+{
+	__raw_writel(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void sp_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
+{
+	memcpy_toio(map->map_priv_1 + to, from, len);
+}
+
+static struct map_info sp_map = {
+	name: "SP flash",
+	buswidth: 4,
+	read8: sp_read8,
+	read16: sp_read16,
+	read32: sp_read32,
+	copy_from: sp_copy_from,
+	write8: sp_write8,
+	write16: sp_write16,
+	write32: sp_write32,
+	copy_to: sp_copy_to
+};
+
+/* partition_info gives details on the logical partitions that the split the 
+ * single flash device into. If the size if zero we use up to the end of the
+ * device. */
+static struct mtd_partition partition_info[LASAT_MTD_LAST];
+static char *lasat_mtd_partnames[] = {"Bootloader", "Service", "Normal", "Filesystem", "Config"};
+
+static int __init init_sp(void)
+{
+	int i;
+	/* this does not play well with the old flash code which 
+	 * protects and uprotects the flash when necessary */
+       	printk(KERN_NOTICE "Unprotecting flash\n");
+	*wpreg |= LASAT_FLASHWP_DIS;
+
+	sp_map.map_priv_1 = flash_partition_start(LASAT_MTD_BOOTLOADER);
+	sp_map.size = lasat_board_info.li_flash_size;
+
+       	printk(KERN_NOTICE "sp flash device: %lx at %lx\n", 
+			sp_map.size, sp_map.map_priv_1);
+
+	for (i=0; i < LASAT_MTD_LAST; i++)
+		partition_info[i].name = lasat_mtd_partnames[i];
+
+	mymtd = do_map_probe("cfi_probe", &sp_map);
+	if (mymtd) {
+		u32 size, offset = 0;
+
+		mymtd->module = THIS_MODULE;
+
+		for (i=0; i < LASAT_MTD_LAST; i++) {
+			size = flash_partition_size(i);
+			partition_info[i].size = size;
+			partition_info[i].offset = offset;
+			offset += size;
+		}
+
+		add_mtd_partitions( mymtd, partition_info, LASAT_MTD_LAST );
+		return 0;
+	}
+
+	return -ENXIO;
+}
+
+static void __exit cleanup_sp(void)
+{
+	if (mymtd) {
+	  del_mtd_partitions(mymtd);
+	  map_destroy(mymtd);
+	}
+	if (sp_map.map_priv_1) {
+	  sp_map.map_priv_1 = 0;
+	}
+}
+
+module_init(init_sp);
+module_exit(cleanup_sp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Brian Murphy <brian@murphy.dk>");
+MODULE_DESCRIPTION("Lasat Safepipe/Masquerade MTD map driver");

--------------050402030206010203080203--
