Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 00:13:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18628 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903665Ab1KIXNX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 00:13:23 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ebb09630000>; Wed, 09 Nov 2011 15:14:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Nov 2011 15:13:20 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Nov 2011 15:13:20 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pA9NDJDa014226;
        Wed, 9 Nov 2011 15:13:19 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pA9NDHgr014225;
        Wed, 9 Nov 2011 15:13:17 -0800
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: Fix compile error in arch/mips/cavium-octeon/flash_setup.c
Date:   Wed,  9 Nov 2011 15:13:16 -0800
Message-Id: <1320880396-14193-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 09 Nov 2011 23:13:20.0061 (UTC) FILETIME=[2B9BB6D0:01CC9F35]
X-archive-position: 31486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8309

The parse_mtd_partitions() and mtd_device_register() functions were
combined into mtd_device_parse_register().  So call that instead.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/flash_setup.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index 975c203..0a430e0 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -17,8 +17,6 @@
 
 static struct map_info flash_map;
 static struct mtd_info *mymtd;
-static int nr_parts;
-static struct mtd_partition *parts;
 static const char *part_probe_types[] = {
 	"cmdlinepart",
 #ifdef CONFIG_MTD_REDBOOT_PARTS
@@ -61,11 +59,8 @@ static int __init flash_init(void)
 		mymtd = do_map_probe("cfi_probe", &flash_map);
 		if (mymtd) {
 			mymtd->owner = THIS_MODULE;
-
-			nr_parts = parse_mtd_partitions(mymtd,
-							part_probe_types,
-							&parts, 0);
-			mtd_device_register(mymtd, parts, nr_parts);
+			mtd_device_parse_register(mymtd, part_probe_types,
+						  0, NULL, 0);
 		} else {
 			pr_err("Failed to register MTD device for flash\n");
 		}
-- 
1.7.2.3
