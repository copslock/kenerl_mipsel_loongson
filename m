Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 13:59:51 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:57004 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903687Ab1LQM66 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 13:58:58 +0100
Received: by eaak12 with SMTP id k12so3598663eaa.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8FXy+nAo1h6TbHmJkmlG43yl7WZc92DBtFq4EYctBik=;
        b=cJo+2C9UF/XPnqS/M5SA0bZQmw+JL8tjdxlwdOyIotI1+UoXytjsEDbYZSj6Pjtos2
         v/eswG+VmM8EUl3r5/v1mkAJ6cMnz5uAg2F8kOQly4aOiPnlgvzlF80HmnUvF7t3lHWb
         evBYHmmLGM8DH/JwNwHOUqVUeNqjIbRQxstGU=
Received: by 10.213.15.10 with SMTP id i10mr783495eba.112.1324126733440;
        Sat, 17 Dec 2011 04:58:53 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id s16sm14739907eef.2.2011.12.17.04.58.51
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 04:58:52 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM partitions are at least 64K
Date:   Sat, 17 Dec 2011 13:58:15 +0100
Message-Id: <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14076

The CFE and NVRAM are always at least 64K big, so make sure their
partitions are never smaller than this in case the flash has smaller
erase sectors.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
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
