Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 13:59:29 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:56305 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903686Ab1LQM65 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 13:58:57 +0100
Received: by eaak12 with SMTP id k12so3598651eaa.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zFS97cPSBx69fWMSCM2YAQI+DA54TAyuW507siRdLsE=;
        b=WKNFHPHhL4En84yhFTG3N3AJBgAQs1uaY2JeEjHKsx7kxo7lxa5WUyxvTta58ATxzf
         oBGQjOZmjE3NGp4kVYkfCLAwg6EuCLU7gWdY41dLXsBkkm94Of3VSerztpCR1ZTQwiCD
         Z6X7ThDcgmZf9UIO1xGpdRh/XSyUyUF0/T1vI=
Received: by 10.213.8.199 with SMTP id i7mr1158373ebi.129.1324126731871;
        Sat, 17 Dec 2011 04:58:51 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id s16sm14739907eef.2.2011.12.17.04.58.50
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 04:58:51 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 1/5] MTD: bcm63xxpart: check version marker string for newer CFEs
Date:   Sat, 17 Dec 2011 13:58:14 +0100
Message-Id: <1324126698-9919-2-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14075

Recent CFEs do not contain the CFE1CFE1 magic anymore, so check for the
"cfe-v" version marker string instead. As very old CFEs do not have
this string, leave the CFE1CFE1 magic as a fallback for detection.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/bcm63xxpart.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index ac7d3c8..9933b34 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -32,22 +32,34 @@
 #include <linux/mtd/partitions.h>
 
 #include <asm/mach-bcm63xx/bcm963xx_tag.h>
+#include <asm/mach-bcm63xx/board_bcm963xx.h>
 
 #define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
 
+#define BCM63XX_CFE_MAGIC_OFFSET 0x4e0
+
 static int bcm63xx_detect_cfe(struct mtd_info *master)
 {
-	int idoffset = 0x4e0;
-	static char idstring[8] = "CFE1CFE1";
 	char buf[9];
 	int ret;
 	size_t retlen;
 
-	ret = master->read(master, idoffset, 8, &retlen, (void *)buf);
+	ret = master->read(master, BCM963XX_CFE_VERSION_OFFSET, 5, &retlen,
+			   (void *)buf);
+	buf[retlen] = 0;
+
+	if (ret)
+		return ret;
+
+	if (strncmp("cfe-v", buf, 5) == 0)
+		return 0;
+
+	/* very old CFE's do not have the cfe-v string, so check for magic */
+	ret = master->read(master, BCM63XX_CFE_MAGIC_OFFSET, 8, &retlen,
+			   (void *)buf);
 	buf[retlen] = 0;
-	pr_info("Read Signature value of %s\n", buf);
 
-	return strncmp(idstring, buf, 8);
+	return strncmp("CFE1CFE1", buf, 8);
 }
 
 static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
-- 
1.7.2.5
