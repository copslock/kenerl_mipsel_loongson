Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:53:34 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52655 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823707Ab2LZUwKKG0oo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:52:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B05D98E1C;
        Wed, 26 Dec 2012 21:52:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JUUELU0hGT+l; Wed, 26 Dec 2012 21:52:05 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id CDCE88F66;
        Wed, 26 Dec 2012 21:51:46 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] MIPS: BCM47XX: handle different nvram sizes
Date:   Wed, 26 Dec 2012 21:51:13 +0100
Message-Id: <1356555074-1230-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The old code just worked for nvram with a size of 0x8000 bytes. This
patch adds support for reading nvram from partitions of 0xF000 and
0x10000 bytes.

There is just 32KB space for the nvram, but most devices do not use the
full size and this code reads the first 32KB in that case and prints a
warning.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |   46 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 6cf3ef2..b4a47fc 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2005 Broadcom Corporation
  * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
- * Copyright (C) 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (C) 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -23,42 +23,74 @@
 
 static char nvram_buf[NVRAM_SPACE];
 
+static u32 find_nvram_size(u32 end)
+{
+	struct nvram_header *header;
+	u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
+		header = (struct nvram_header *)KSEG1ADDR(end - nvram_sizes[i]);
+		if (header->magic == NVRAM_HEADER)
+			return nvram_sizes[i];
+	}
+
+	return 0;
+}
+
+/* Probe for NVRAM header */
 static int nvram_find_and_copy(u32 base, u32 lim)
 {
 	struct nvram_header *header;
 	int i;
 	u32 off;
 	u32 *src, *dst;
+	u32 size;
 
 	/* TODO: when nvram is on nand flash check for bad blocks first. */
 	off = FLASH_MIN;
 	while (off <= lim) {
 		/* Windowed flash access */
-		header = (struct nvram_header *)
-			KSEG1ADDR(base + off - NVRAM_SPACE);
-		if (header->magic == NVRAM_HEADER)
+		size = find_nvram_size(base + off);
+		if (size) {
+			header = (struct nvram_header *)KSEG1ADDR(base + off -
+								  size);
 			goto found;
+		}
 		off <<= 1;
 	}
 
 	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
 	header = (struct nvram_header *) KSEG1ADDR(base + 4096);
-	if (header->magic == NVRAM_HEADER)
+	if (header->magic == NVRAM_HEADER) {
+		size = NVRAM_SPACE;
 		goto found;
+	}
 
 	header = (struct nvram_header *) KSEG1ADDR(base + 1024);
-	if (header->magic == NVRAM_HEADER)
+	if (header->magic == NVRAM_HEADER) {
+		size = NVRAM_SPACE;
 		goto found;
+	}
 
+	pr_err("no nvram found\n");
 	return -ENXIO;
 
 found:
+
+	if (header->len > size)
+		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
+	if (header->len > NVRAM_SPACE)
+		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+		       header->len, NVRAM_SPACE);
+
 	src = (u32 *) header;
 	dst = (u32 *) nvram_buf;
 	for (i = 0; i < sizeof(struct nvram_header); i += 4)
 		*dst++ = *src++;
-	for (; i < header->len && i < NVRAM_SPACE; i += 4)
+	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
 		*dst++ = le32_to_cpu(*src++);
+	memset(dst, 0x0, NVRAM_SPACE - i);
 
 	return 0;
 }
-- 
1.7.10.4
