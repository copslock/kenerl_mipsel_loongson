Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 14:00:16 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:49029 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903689Ab1LQM7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 13:59:00 +0100
Received: by eekc13 with SMTP id c13so2862498eek.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 04:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tqGEHstkcsFuTBQmGziO7hkY2hpB9knhCxMEPI/gQ60=;
        b=wvmLVjnCuG2kKpx2J2dEO6uzlz2k0nN4P3GnMm9Tkviwa7wXZo5/HSGII6+i55MgmF
         KAk2abaaqlpxDubV/TOAFv2ptl2fkwFu8nPiXPY4pwZ8nvVvdHTxxmnif4JGeADWERZ3
         jYXge51V9uFRCOY//RiVuTdoNNMponhJY4qyo=
Received: by 10.14.120.82 with SMTP id o58mr1137674eeh.129.1324126734861;
        Sat, 17 Dec 2011 04:58:54 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id s16sm14739907eef.2.2011.12.17.04.58.53
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 04:58:54 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 3/5] MTD: bcm63xxpart: don't assume NVRAM is always the fourth partition
Date:   Sat, 17 Dec 2011 13:58:16 +0100
Message-Id: <1324126698-9919-4-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14078

Instead of referencing the sizes of fixed partitions, use the
precomputed CFE/NVRAM lengths.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/bcm63xxpart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 23f6201..3becb4d 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -165,8 +165,8 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	/* Global partition "linux" to make easy firmware upgrade */
 	curpart++;
 	parts[curpart].name = "linux";
-	parts[curpart].offset = parts[0].size;
-	parts[curpart].size = master->size - parts[0].size - parts[3].size;
+	parts[curpart].offset = cfelen;
+	parts[curpart].size = master->size - cfelen - nvramlen;
 
 	for (i = 0; i < nrparts; i++)
 		pr_info("Partition %d is %s offset %lx and length %lx\n", i,
-- 
1.7.2.5
