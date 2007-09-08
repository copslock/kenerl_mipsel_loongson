Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2007 01:20:26 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.244]:28794 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20025760AbXIHAUR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Sep 2007 01:20:17 +0100
Received: by ag-out-0708.google.com with SMTP id 33so301933agc
        for <linux-mips@linux-mips.org>; Fri, 07 Sep 2007 17:19:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:x-spam-checker-version:x-spam-status:delivered-to:received:received:received:received-spf:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        bh=6Wdi7S7JajVcrmCI+91zh2n3Y+t+F6XmN1U1gsM3E2E=;
        b=tx/cT0CjcJW5myGZeMMUCsXfOmEEgCbb/hW429TZcr8gK/0UapSgLbaCU+fpPAkWdJaQ+J0t50PQ83UO5NuTPjyb2oyjRnELKVwLZYTlA2c79+GpTW2+bCB5/xiFUxzbA8mBqylMwZ3N1d9Crivdiiukf6yfwnzTeND1T+nzg3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:x-spam-checker-version:x-spam-status:delivered-to:received-spf:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        b=rg5k4KAtZ4g3E/+sILuzOTofR3vL9nm4V7AlHsg+PbWCg7x1P/wdYDljPhX03+29T/73eJW/nAHyvAjv5bg+RIqu6RHzAYtBGplNroqLo8rzNm8VGnFCwLxsv/9FQOwbWdGil1xmK0JmkIOu7Hj4rsRF0t1jEB8D4ZPdrGLSf2U=
Received: by 10.90.90.3 with SMTP id n3mr1863035agb.1189210797374;
        Fri, 07 Sep 2007 17:19:57 -0700 (PDT)
Received: from raver.cocorico ( [87.12.226.15])
        by mx.google.com with ESMTPS id h8sm1530535wxd.2007.09.07.17.19.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2007 17:19:56 -0700 (PDT)
Received: by 10.82.154.20 with SMTP id b20cs876037bue;
        Wed, 22 Aug 2007 01:11:04 -0700 (PDT)
Received: by 10.82.112.3 with SMTP id k3mr943124buc.1187770261340;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received: from smtp1.int-evry.fr (smtp1.int-evry.fr [157.159.10.44])
        by mx.google.com with ESMTP id j9si1357887mue.2007.08.22.01.10.56;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received-SPF: neutral (google.com: 157.159.10.44 is neither permitted nor denied by best guess record for domain of florian.fainelli@telecomint.eu) client-ip=157.159.10.44;
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 122398E84F0;
	Wed, 22 Aug 2007 10:10:48 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-16-241.fbx.proxad.net [82.240.16.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 73CFED0E336;
	Wed, 22 Aug 2007 10:10:47 +0200 (CEST)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][2/7] AR7: mtd partition map
Date:	Sat, 8 Sep 2007 02:19:52 +0200
User-Agent: KMail/1.9.7
References: <200709080143.12345.technoboy85@gmail.com>
In-Reply-To: <200709080143.12345.technoboy85@gmail.com>
MIME-Version: 1.0
Message-Id: <200709080219.52695.technoboy85@gmail.com>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Disposition: inline
Cc:	Felix Fietkau <nbd@openwrt.org>, Eugene Konev <ejka@imfi.kspu.ru>,
	dwmw2@infradead.org, linux-mtd@lists.infradead.org,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Partition map support

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index fbec8cd..c1b2508 100644
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
index 6d958a4..8451c64 100644
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
index 0000000..72dd07a
--- /dev/null
+++ b/drivers/mtd/ar7part.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2007 Felix Fietkau, Eugene Konev
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
+ * Based on ar7 map by Felix Fietkau.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/bootmem.h>
+#include <linux/squashfs_fs.h>
+
+struct ar7_bin_rec {
+	unsigned int checksum;
+	unsigned int length;
+	unsigned int address;
+};
+
+static struct mtd_partition ar7_parts[5];
+
+static int create_mtd_partitions(struct mtd_info *master,
+				 struct mtd_partition **pparts,
+				 unsigned long origin)
+{
+	struct ar7_bin_rec header;
+	unsigned int offset, len;
+	unsigned int pre_size = master->erasesize;
+	unsigned int post_size = 0, root_offset = 0xe0000;
+	int retries = 10;
+
+	printk(KERN_INFO "Parsing AR7 partition map...\n");
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
+	do {
+		offset = pre_size;
+		master->read(master, offset,
+			sizeof(header), &len, (u_char *)&header);
+		if (!strncmp((char *)&header, "TIENV0.8", 8))
+			ar7_parts[1].offset = pre_size;
+		if (header.checksum == 0xfeedfa42)
+			break;
+		if (header.checksum == 0xfeed1281)
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
+	case 0xfeedfa42:
+		while (header.length) {
+			offset += sizeof(header) + header.length;
+			master->read(master, offset, sizeof(header),
+				     &len, (u_char *)&header);
+		}
+		root_offset = offset + sizeof(header) + 4;
+		break;
+	case 0xfeed1281:
+		while (header.length) {
+			offset += sizeof(header) + header.length;
+			master->read(master, offset, sizeof(header),
+				     &len, (u_char *)&header);
+		}
+		root_offset = offset + sizeof(header) + 4 + 0xff;
+		root_offset &= ~(u32)0xff;
+		break;
+	default:
+		printk(KERN_ERR "Unknown magic: %08x\n", header.checksum);
+		break;
+	}
+
+	master->read(master, root_offset,
+		sizeof(header), &len, (u_char *)&header);
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
+	return 4;
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
+MODULE_AUTHOR("Felix Fietkau, Eugene Konev");
+MODULE_DESCRIPTION("MTD partitioning for TI AR7");
