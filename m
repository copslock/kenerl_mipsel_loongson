Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 13:10:53 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:34371
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdARMKmU7mfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 13:10:42 +0100
Received: by mail-wm0-x242.google.com with SMTP id c85so3648177wmi.1
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 04:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+yZK+udrb20r3JQLVEDlmnKB8CXSbjH/85IkOhXworE=;
        b=jIuK8byRNZVimYmBYZyldpFxGEXBeb1vEn9DhUauzGkf1g0RngphtOA8mfZGTMKa+4
         k6VLpkHnd1UlvHRD7zaezTxEhN4aE7JQXrHwz/SLePvxkeS0yAvCwmEWQP4FZordCjD5
         z7UM6gfdb8Wyf91U7vfWqqgNVNlWlQOpyGeRURoafkZ8ACLupub+EMrC2O0atOYtRgYN
         bts4WkkV8nhnnHc+kFwnDkZlFU4E3v8tCGscEJtHMeWCOQWWLwMdZMYXkO4R26EOHydl
         9wtO+/JOHCixaWIV1uSCDKqnToD1lBG3yqcpR1nJTnXqJxJf7K5+KqJnDTRjJaI7LJXB
         y9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+yZK+udrb20r3JQLVEDlmnKB8CXSbjH/85IkOhXworE=;
        b=HIRa2USSr7jdEgbcsX4Yq0GNHYA/7V+MirtFbBy/Wy5brKiqmHzJI3pzkLNdf2/yGV
         HVRr0rE0ZTl1HOoSjHgf35Cj1WONxPaZQzFwKGaIxqmN2Rof7G9Xuy0AoFzV2gsr6GfA
         d1lE68rtdPAAb5vnV17QfK71Zzt4+1gJVybaBPHORQx+lU95aNOIi/+dIjymPqf9vLGO
         3dQp1HiKgIf2HIdu4GWXP2ToqBTI4ek483Lpn7tusMA4OTX5LowAUiBc7+VX3QGzCDgw
         o9y3kRqupI4MIhKKmUOrcezM59TiNLyQ8LoPA8kueDxOSyI1V1reYDRnEYeO5GmMLoSB
         Ek+w==
X-Gm-Message-State: AIkVDXLaWHzm7dYLT/aY/b0fP7ZSUrA4dPPZ5UijHdAbVNWwacEuf6DxHQf5MaRPelgHTw==
X-Received: by 10.28.129.147 with SMTP id c141mr22078994wmd.12.1484741436901;
        Wed, 18 Jan 2017 04:10:36 -0800 (PST)
Received: from serveurQA.phonesystems.net ([62.39.136.157])
        by smtp.gmail.com with ESMTPSA id c81sm4402922wmf.22.2017.01.18.04.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 04:10:36 -0800 (PST)
From:   Sebastien Decourriere <sebtx452@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org,
        Sebastien Decourriere <sebtx452@gmail.com>
Subject: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap is enabled
Date:   Wed, 18 Jan 2017 13:10:52 +0100
Message-Id: <1484741452-27141-1-git-send-email-sebtx452@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebtx452@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The purpose of this patch is to enable the software address endianness
swapping only when the in SoC EBU endianness swapping is disabled.
To perform this check, I look at Bit 30 of the EBU_CON_0 register.
Actually, the driver expects that the in SoC swapping is disabled.
This is the case with current bootloaders shuch as U-boot. But,

I have a router which uses a proprietary bootloader which keeps
the in SoC swapping enabled. The SoC in this router is a vrx200 v1.2.
In this SoC version, I can keep the in SoC swapping without any problem.

Signed-off-by: Sebastien Decourriere <sebtx452@gmail.com>
---
 drivers/mtd/maps/lantiq-flash.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index c8febb3..a091efa 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -151,6 +151,11 @@ ltq_mtd_probe(struct platform_device *pdev)
 	ltq_mtd->map->copy_to = ltq_copy_to;
 
 	ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
+	/* We swap the addresses only if the EBU endianness swap is disabled */
+	if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & BIT(30))
+		ltq_mtd->map[i].map_priv_1 = LTQ_NOR_NORMAL;
+	else
+		ltq_mtd->map[i].map_priv_1 = LTQ_NOR_PROBING;
 	ltq_mtd->mtd = do_map_probe("cfi_probe", ltq_mtd->map);
 	ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
 
@@ -163,8 +168,11 @@ ltq_mtd_probe(struct platform_device *pdev)
 	mtd_set_of_node(ltq_mtd->mtd, pdev->dev.of_node);
 
 	cfi = ltq_mtd->map->fldrv_priv;
-	cfi->addr_unlock1 ^= 1;
-	cfi->addr_unlock2 ^= 1;
+	/* We swap the addresses only if the EBU endianness swap is disabled */
+	if (!(ltq_ebu_r32(LTQ_EBU_BUSCON0) & BIT(30))) {
+		cfi->addr_unlock1 ^= 1;
+		cfi->addr_unlock2 ^= 1;
+	}
 
 	err = mtd_device_register(ltq_mtd->mtd, NULL, 0);
 	if (err) {
-- 
2.1.4
