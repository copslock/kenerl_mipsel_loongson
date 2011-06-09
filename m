Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 19:56:10 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59681 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491051Ab1FIR4F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 19:56:05 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: lantiq: fixes mtd registration of nor device
Date:   Thu,  9 Jun 2011 19:57:33 +0200
Message-Id: <1307642253-8770-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1307642253-8770-1-git-send-email-blogic@openwrt.org>
References: <1307642253-8770-1-git-send-email-blogic@openwrt.org>
X-archive-position: 30305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8293

The 2 functions add_mtd_partitions and del_mtd_partitions were renamed to
mtd_device_register and mtd_device_unregister.

Signed-of-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 drivers/mtd/maps/lantiq-flash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index a90cabd..7e50896 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -182,7 +182,7 @@ ltq_mtd_probe(struct platform_device *pdev)
 		parts = ltq_mtd_data->parts;
 	}
 
-	err = add_mtd_partitions(ltq_mtd->mtd, parts, nr_parts);
+	err = mtd_device_register(ltq_mtd->mtd, parts, nr_parts);
 	if (err) {
 		dev_err(&pdev->dev, "failed to add partitions\n");
 		goto err_destroy;
@@ -208,7 +208,7 @@ ltq_mtd_remove(struct platform_device *pdev)
 
 	if (ltq_mtd) {
 		if (ltq_mtd->mtd) {
-			del_mtd_partitions(ltq_mtd->mtd);
+			mtd_device_unregister(ltq_mtd->mtd);
 			map_destroy(ltq_mtd->mtd);
 		}
 		if (ltq_mtd->map->virt)
-- 
1.7.2.3
