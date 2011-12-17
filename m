Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 14:01:05 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:47778 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903694Ab1LQM7C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 13:59:02 +0100
Received: by eekc13 with SMTP id c13so2862512eek.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 04:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zCvAqfob3rhHAiC79HvolQ5Pp34N6v2OKIONvxARn/0=;
        b=pDRIgXqdKcLrvOxtLVwkmWckVLppWm0Y3jcNARze0EdUW4hRsHpbD1EXg+PEp+UlhI
         AUAvvAJlfdUrvHP3nM477JA5L1p7af7Fulx6ldfp7G/1Dmafwv0aUtrbBcpnXFH2V8+Q
         cztGJoEErrxDbTmnhrGjDuZUoQjImqqotnQQs=
Received: by 10.14.52.2 with SMTP id d2mr1207426eec.60.1324126737204;
        Sat, 17 Dec 2011 04:58:57 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id s16sm14739907eef.2.2011.12.17.04.58.56
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 04:58:56 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 5/5] MTD: bcm63xxpart: check the image tag's crc32
Date:   Sat, 17 Dec 2011 13:58:18 +0100
Message-Id: <1324126698-9919-6-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14086

Only use the values from the image tag if it is valid. Always create
the CFE, NVRAM and linux partitions, to allow flashing a new image even
if the old is invalid without overwriting CFE or NVRAM.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/bcm63xxpart.c |   45 +++++++++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 3becb4d..0d5fecf 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -24,6 +24,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/crc32.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -80,8 +81,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	unsigned int cfelen, nvramlen;
 	int namelen = 0;
 	int i;
-	char *boardid;
-	char *tagversion;
+	u32 computed_crc;
 
 	if (bcm63xx_detect_cfe(master))
 		return -EINVAL;
@@ -103,20 +103,33 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 		return -EIO;
 	}
 
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
-	spareaddr = roundup(totallen, master->erasesize) + cfelen;
-	sparelen = master->size - spareaddr - nvramlen;
-	rootfslen = spareaddr - rootfsaddr;
+	computed_crc = crc32_le(IMAGETAG_CRC_START, (u8 *)buf,
+				offsetof(struct bcm_tag, header_crc));
+	if (computed_crc == buf->header_crc) {
+		char *boardid = &(buf->board_id[0]);
+		char *tagversion = &(buf->tag_version[0]);
+
+		sscanf(buf->kernel_address, "%u", &kerneladdr);
+		sscanf(buf->kernel_length, "%u", &kernellen);
+		sscanf(buf->total_length, "%u", &totallen);
+
+		pr_info("CFE boot tag found with version %s and board type %s\n",
+			tagversion, boardid);
+
+		kerneladdr = kerneladdr - BCM63XX_EXTENDED_SIZE;
+		rootfsaddr = kerneladdr + kernellen;
+		spareaddr = roundup(totallen, master->erasesize) + cfelen;
+		sparelen = master->size - spareaddr - nvramlen;
+		rootfslen = spareaddr - rootfsaddr;
+	} else {
+		pr_warn("CFE boot tag CRC invalid (expected %08x, actual %08x)\n",
+			buf->header_crc, computed_crc);
+		kernellen = 0;
+		rootfslen = 0;
+		rootfsaddr = 0;
+		spareaddr = cfelen;
+		sparelen = master->size - cfelen - nvramlen;
+	}
 
 	/* Determine number of partitions */
 	namelen = 8;
-- 
1.7.2.5
