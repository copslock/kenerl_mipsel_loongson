Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:13:25 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:56553 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903629Ab1LEPJK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:10 +0100
Received: by bkcje16 with SMTP id je16so4360365bkc.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UsY37AympwSRa1MPQ8RD4k5c37KkdLdSE0DcJAZfVpY=;
        b=rzW6yi+jau0FIdjYcGLaRZs0n717FIAfXo2WEbeM1TR2iHtHOzhwPTnXt2S1zckwCr
         2ocQRDASb2rw+a27pkcgSj+xHPn9XKZcxwxW6FFPp+PQPAqw6on9DCqm0JGGnmu6Y4E+
         lHeOrivoJmbfdXiIUTgRild/OtTlyhl3biym4=
Received: by 10.180.80.162 with SMTP id s2mr13171295wix.27.1323097745175;
        Mon, 05 Dec 2011 07:09:05 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.09.03
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:09:04 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 5/7] MTD: MAPS: physmap: allow partition parsers for physmap_flash_data
Date:   Mon,  5 Dec 2011 16:08:09 +0100
Message-Id: <1323097691-16414-6-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3364

Arch setup code might want to use their own partition parsers, but still
use the generic physmap flash driver.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/mtd/maps/physmap.c  |    5 ++++-
 include/linux/mtd/physmap.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
index 66e8200..1f749d58 100644
--- a/drivers/mtd/maps/physmap.c
+++ b/drivers/mtd/maps/physmap.c
@@ -85,6 +85,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 	struct physmap_flash_data *physmap_data;
 	struct physmap_flash_info *info;
 	const char **probe_type;
+	const char **part_types;
 	int err = 0;
 	int i;
 	int devices_found = 0;
@@ -171,7 +172,9 @@ static int physmap_flash_probe(struct platform_device *dev)
 	if (err)
 		goto err_out;
 
-	mtd_device_parse_register(info->cmtd, part_probe_types, 0,
+	part_types = physmap_data->part_probe_types ? : part_probe_types;
+
+	mtd_device_parse_register(info->cmtd, part_types, 0,
 				  physmap_data->parts, physmap_data->nr_parts);
 	return 0;
 
diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
index 04e0181..d2887e7 100644
--- a/include/linux/mtd/physmap.h
+++ b/include/linux/mtd/physmap.h
@@ -30,6 +30,7 @@ struct physmap_flash_data {
 	unsigned int		pfow_base;
 	char                    *probe_type;
 	struct mtd_partition	*parts;
+	const char		**part_probe_types;
 };
 
 #endif /* __LINUX_MTD_PHYSMAP__ */
-- 
1.7.2.5
