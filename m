Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:10:23 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:61880 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab1LEPJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:06 +0100
Received: by eaac10 with SMTP id c10so5209125eaa.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KwMUBMJre1a38LIrNZA0okTyRZ+Oiyv0U1tVcOv8rxg=;
        b=lr2Qz5Pc7uh6l81Kekq1GkYnPrxj8sef6xeNs2ah1XlhSI34IFyS2CgJEpYGsNNgbm
         afzYxqWu2GSyWwZF9mphyio6N5xOm3nKuREYZtPnnk6tsTompqDgwtUfjTnuRMi6M/fc
         GjkWqdpv33SbLxBUSG5tvsSLR4ZTCPOyHymL0=
Received: by 10.216.196.155 with SMTP id r27mr2625399wen.9.1323097740643;
        Mon, 05 Dec 2011 07:09:00 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.08.59
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:09:00 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 2/7] MTD: MAPS: bcm963xx-flash: remove superfluous semicolons
Date:   Mon,  5 Dec 2011 16:08:06 +0100
Message-Id: <1323097691-16414-3-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3352

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/maps/bcm963xx-flash.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/maps/bcm963xx-flash.c b/drivers/mtd/maps/bcm963xx-flash.c
index b908d92..58cbaf2 100644
--- a/drivers/mtd/maps/bcm963xx-flash.c
+++ b/drivers/mtd/maps/bcm963xx-flash.c
@@ -93,18 +93,18 @@ static int parse_cfe_partitions(struct mtd_info *master,
 	if (rootfslen > 0) {
 		nrparts++;
 		namelen += 6;
-	};
+	}
 	if (kernellen > 0) {
 		nrparts++;
 		namelen += 6;
-	};
+	}
 
 	/* Ask kernel for more memory */
 	parts = kzalloc(sizeof(*parts) * nrparts + 10 * nrparts, GFP_KERNEL);
 	if (!parts) {
 		vfree(buf);
 		return -ENOMEM;
-	};
+	}
 
 	/* Start building partition list */
 	parts[curpart].name = "CFE";
@@ -117,7 +117,7 @@ static int parse_cfe_partitions(struct mtd_info *master,
 		parts[curpart].offset = kerneladdr;
 		parts[curpart].size = kernellen;
 		curpart++;
-	};
+	}
 
 	if (rootfslen > 0) {
 		parts[curpart].name = "rootfs";
@@ -126,7 +126,7 @@ static int parse_cfe_partitions(struct mtd_info *master,
 		if (sparelen > 0)
 			parts[curpart].size += sparelen;
 		curpart++;
-	};
+	}
 
 	parts[curpart].name = "nvram";
 	parts[curpart].offset = master->size - master->erasesize;
-- 
1.7.2.5
