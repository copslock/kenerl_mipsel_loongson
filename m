Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:09:57 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54807 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab1LEPJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:04 +0100
Received: by fabs1 with SMTP id s1so1350875fab.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NgvFaSOAgUlrGn4fBX2C6noWvV6wslTqLCwTQvd1ciY=;
        b=TLi4y1OZ3OCtP+2nCIjvIPtg6GsQD3de3AFm4cVE+xhfzwCNbjL2g2syetsmEBhV88
         QKtpjRVyFWSOdeC6FNnOn53rTo8DbAplUJEhx4bA7NxByc6AogOYp4ArJPnUox7iCFn6
         H80kyFBpYCi/0uqShjtNpmVOBrSj6KyGc6Eu0=
Received: by 10.216.220.208 with SMTP id o58mr2249122wep.39.1323097739303;
        Mon, 05 Dec 2011 07:08:59 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.08.58
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:08:58 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 1/7] MTD: MAPS: bcm963xx-flash: fix word order for spare partition
Date:   Mon,  5 Dec 2011 16:08:05 +0100
Message-Id: <1323097691-16414-2-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3349

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/maps/bcm963xx-flash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/bcm963xx-flash.c b/drivers/mtd/maps/bcm963xx-flash.c
index c7d3949..b908d92 100644
--- a/drivers/mtd/maps/bcm963xx-flash.c
+++ b/drivers/mtd/maps/bcm963xx-flash.c
@@ -144,7 +144,7 @@ static int parse_cfe_partitions(struct mtd_info *master,
 					(long unsigned int)(parts[i].offset),
 					(long unsigned int)(parts[i].size));
 
-	printk(KERN_INFO PFX "Spare partition is %x offset and length %x\n",
+	printk(KERN_INFO PFX "Spare partition is offset %x and length %x\n",
 							spareaddr, sparelen);
 	*pparts = parts;
 	vfree(buf);
-- 
1.7.2.5
