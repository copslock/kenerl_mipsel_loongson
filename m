Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 18:22:48 +0000 (GMT)
Received: from smtp-out114.alice.it ([85.37.17.114]:21255 "EHLO
	smtp-out114.alice.it") by ftp.linux-mips.org with ESMTP
	id S20035694AbXL0SWk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Dec 2007 18:22:40 +0000
Received: from FBCMMO02.fbc.local ([192.168.68.196]) by smtp-out114.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:22:34 +0100
Received: from FBCMCL01B02.fbc.local ([192.168.69.83]) by FBCMMO02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:22:34 +0100
Received: from [192.168.0.3] ([82.55.115.235]) by FBCMCL01B02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:22:33 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][2/6]: AR7 mtd partition map
Date:	Thu, 27 Dec 2007 19:22:36 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200712271919.23577.technoboy85@gmail.com>
In-Reply-To: <200712271919.23577.technoboy85@gmail.com>
Cc:	Felix Fietkau <nbd@openwrt.org>, Eugene Konev <ejka@imfi.kspu.ru>,
	dwmw2@infradead.org, linux-mtd@lists.infradead.org,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712271922.36477.technoboy85@gmail.com>
X-OriginalArrivalTime: 27 Dec 2007 18:22:34.0317 (UTC) FILETIME=[7371AFD0:01C848B5]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 8848e8a..e421446 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -150,6 +150,12 @@ config MTD_AFS_PARTS
 	  for your particular device. It won't happen automatically. The
 	  'armflash' map driver (CONFIG_MTD_ARMFLASH) does this, for example.
 
+config MTD_AR7_PARTS
+	tristate "TI AR7 partitioning support"
+	depends on MTD_PARTITIONS
+	---help---
+	  TI AR7 partitioning support
+
 comment "User Modules And Translation Layers"
 
 config MTD_CHAR
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 7f0b04b..95d1ed2 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MTD_CONCAT)	+= mtdconcat.o
 obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
 obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
+obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
 
 # 'Users' - code which presents functionality to userspace.
 obj-$(CONFIG_MTD_CHAR)		+= mtdchar.o
diff --git a/drivers/mtd/ar7part.c b/drivers/mtd/ar7part.c
new file mode 100644
index 0000000..3d160d4
--- /dev/null
+++ b/drivers/mtd/ar7part.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2007 Eugene Konev <ejka@openwrt.org>
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
+ * TI AR7 flash partition table.
+ * Based on ar7 map by Felix Fietkau <nbd@openwrt.org>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/bootmem.h>
+#include <linux/magic.h>
+
+#define AR7_PARTS	4
+#define ROOT_OFFSET	0xe0000
+
+#define LOADER_MAGIC1	le32_to_cpu(0xfeedfa42)
+#define LOADER_MAGIC2	le32_to_cpu(0xfeed1281)
+
+struct ar7_bin_rec {
+	unsigned int checksum;
+	unsigned int length;
+	unsigned int address;
+};
+
+static struct mtd_partition ar7_parts[AR7_PARTS];
+
+static int create_mtd_partitions(struct mtd_info *master,
+				 struct mtd_partition **pparts,
+				 unsigned long origin)
+{
+	struct ar7_bin_rec header;
+	unsigned int offset, len;
+	unsigned int pre_size = master->erasesize, post_size = 0;
+	unsigned int root_offset = ROOT_OFFSET;
+
+	int retries = 10;
+
+	ar7_parts[0].name = "loader";
+	ar7_parts[0].offset = 0;
+	ar7_parts[0].size = master->erasesize;
+	ar7_parts[0].mask_flags = MTD_WRITEABLE;
+
+	ar7_parts[1].name = "config";
+	ar7_parts[1].offset = 0;
+	ar7_parts[1].size = master->erasesize;
+	ar7_parts[1].mask_flags = 0;
+
+	do { /* Try 10 blocks starting from master->erasesize */
+		offset = pre_size;
+		master->read(master, offset,
+			sizeof(header), &len, (u8 *)&header);
+		if (!strncmp((char *)&header, "TIENV0.8", 8))
+			ar7_parts[1].offset = pre_size;
+		if (header.checksum == LOADER_MAGIC1)
+			break;
+		if (header.checksum == LOADER_MAGIC2)
+			break;
+		pre_size += master->erasesize;
+	} while (retries--);
+
+	pre_size = offset;
+
+	if (!ar7_parts[1].offset) {
+		ar7_parts[1].offset = master->size - master->erasesize;
+		post_size = master->erasesize;
+	}
+
+	switch (header.checksum) {
+	case LOADER_MAGIC1:
+		while (header.length) {
+			offset += sizeof(header) + header.length;
+			master->read(master, offset, sizeof(header),
+				     &len, (u8 *)&header);
+		}
+		root_offset = offset + sizeof(header) + 4;
+		break;
+	case LOADER_MAGIC2:
+		while (header.length) {
+			offset += sizeof(header) + header.length;
+			master->read(master, offset, sizeof(header),
+				     &len, (u8 *)&header);
+		}
+		root_offset = offset + sizeof(header) + 4 + 0xff;
+		root_offset &= ~(u32)0xff;
+		break;
+	default:
+		printk(KERN_WARNING "Unknown magic: %08x\n", header.checksum);
+		break;
+	}
+
+	master->read(master, root_offset,
+		sizeof(header), &len, (u8 *)&header);
+	if (header.checksum != SQUASHFS_MAGIC) {
+		root_offset += master->erasesize - 1;
+		root_offset &= ~(master->erasesize - 1);
+	}
+
+	ar7_parts[2].name = "linux";
+	ar7_parts[2].offset = pre_size;
+	ar7_parts[2].size = master->size - pre_size - post_size;
+	ar7_parts[2].mask_flags = 0;
+
+	ar7_parts[3].name = "rootfs";
+	ar7_parts[3].offset = root_offset;
+	ar7_parts[3].size = master->size - root_offset - post_size;
+	ar7_parts[3].mask_flags = 0;
+
+	*pparts = ar7_parts;
+	return AR7_PARTS;
+}
+
+static struct mtd_part_parser ar7_parser = {
+	.owner = THIS_MODULE,
+	.parse_fn = create_mtd_partitions,
+	.name = "ar7part",
+};
+
+static int __init ar7_parser_init(void)
+{
+	return register_mtd_parser(&ar7_parser);
+}
+
+module_init(ar7_parser_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(	"Felix Fietkau <nbd@openwrt.org>, "
+		"Eugene Konev <ejka@openwrt.org>");
+MODULE_DESCRIPTION("MTD partitioning for TI AR7");
