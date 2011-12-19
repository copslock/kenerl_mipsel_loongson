Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2011 11:36:58 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:44379 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903602Ab1LSKgv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2011 11:36:51 +0100
Received: by eaak12 with SMTP id k12so4969649eaa.36
        for <linux-mips@linux-mips.org>; Mon, 19 Dec 2011 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=29OAhnzIw6HLVcB3SjCQ60EnCgSqR0nzSaGfqF8M3F0=;
        b=QsqRLcF8Xs+DVYD3M9RinyF8NPX3tIbrLakPPyJaSEtkWzhah9YjJQ/CxcUuwpC9qp
         9nbF9jNx0aWr8yDPICSl+fKjayEYAZchnfdFq03+KYU2bRxgTxVTbvWsTsDvvdQGEu/4
         GVHBei/sfZZAjiUiJHwfpRXOAYuwtIHtxWCTw=
Received: by 10.205.138.5 with SMTP id iq5mr1240523bkc.76.1324291005678;
        Mon, 19 Dec 2011 02:36:45 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id fa8sm40036609bkc.14.2011.12.19.02.36.43
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 02:36:44 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH V2 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM partitions are at least 64K
Date:   Mon, 19 Dec 2011 11:36:04 +0100
Message-Id: <1324290964-14096-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324208821.17534.0.camel@sauron.fi.intel.com>
References: <1324208821.17534.0.camel@sauron.fi.intel.com>
X-archive-position: 32140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14860

The CFE boot loader on BCM63XX platforms assumes itself and the NVRAM
partition to be 64 KiB (or erase block sized, if larger).
Ensure this assumption is also met when creating the partitions to
prevent accidential erasure of CFE or NVRAM.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

Changes V1 -> V2:
  Clarified the need for the minimum size.


Hope this one's better :)

 drivers/mtd/bcm63xxpart.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 9933b34..23f6201 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -36,6 +36,9 @@
 
 #define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
 
+#define BCM63XX_MIN_CFE_SIZE	0x10000		/* always at least 64K */
+#define BCM63XX_MIN_NVRAM_SIZE	0x10000		/* always at least 64K */
+
 #define BCM63XX_CFE_MAGIC_OFFSET 0x4e0
 
 static int bcm63xx_detect_cfe(struct mtd_info *master)
@@ -74,6 +77,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	size_t retlen;
 	unsigned int rootfsaddr, kerneladdr, spareaddr;
 	unsigned int rootfslen, kernellen, sparelen, totallen;
+	unsigned int cfelen, nvramlen;
 	int namelen = 0;
 	int i;
 	char *boardid;
@@ -82,14 +86,18 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	if (bcm63xx_detect_cfe(master))
 		return -EINVAL;
 
+	cfelen = max_t(uint32_t, master->erasesize, BCM63XX_MIN_CFE_SIZE);
+	nvramlen = max_t(uint32_t, master->erasesize, BCM63XX_MIN_NVRAM_SIZE);
+
 	/* Allocate memory for buffer */
 	buf = vmalloc(sizeof(struct bcm_tag));
 	if (!buf)
 		return -ENOMEM;
 
 	/* Get the tag */
-	ret = master->read(master, master->erasesize, sizeof(struct bcm_tag),
-							&retlen, (void *)buf);
+	ret = master->read(master, cfelen, sizeof(struct bcm_tag), &retlen,
+			   (void *)buf);
+
 	if (retlen != sizeof(struct bcm_tag)) {
 		vfree(buf);
 		return -EIO;
@@ -106,8 +114,8 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 
 	kerneladdr = kerneladdr - BCM63XX_EXTENDED_SIZE;
 	rootfsaddr = kerneladdr + kernellen;
-	spareaddr = roundup(totallen, master->erasesize) + master->erasesize;
-	sparelen = master->size - spareaddr - master->erasesize;
+	spareaddr = roundup(totallen, master->erasesize) + cfelen;
+	sparelen = master->size - spareaddr - nvramlen;
 	rootfslen = spareaddr - rootfsaddr;
 
 	/* Determine number of partitions */
@@ -131,7 +139,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	/* Start building partition list */
 	parts[curpart].name = "CFE";
 	parts[curpart].offset = 0;
-	parts[curpart].size = master->erasesize;
+	parts[curpart].size = cfelen;
 	curpart++;
 
 	if (kernellen > 0) {
@@ -151,8 +159,8 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	}
 
 	parts[curpart].name = "nvram";
-	parts[curpart].offset = master->size - master->erasesize;
-	parts[curpart].size = master->erasesize;
+	parts[curpart].offset = master->size - nvramlen;
+	parts[curpart].size = nvramlen;
 
 	/* Global partition "linux" to make easy firmware upgrade */
 	curpart++;
-- 
1.7.2.5
