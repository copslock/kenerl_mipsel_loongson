Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 16:10:46 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35640 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903621Ab1LEPJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 16:09:06 +0100
Received: by mail-fx0-f49.google.com with SMTP id s1so1350830fab.36
        for <multiple recipients>; Mon, 05 Dec 2011 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v6NzR+90mvqgabZ3Jol6wF7QptTTlXP8k5sVL+egcd8=;
        b=PTciu7hyRjX5Pbi+3d3Vg0UtfR9TGcRMfpuXOzf2xZa7JGVZAebn7f29lMZUstD6C9
         CrDgWKRT9QiKxz4xYjStVUcxNSr3LDyAVHSpPQ/xq6atcliVOW36HH2BJdhLyjI2FUca
         W8uiYbyQulAfAyExrwY+ayg97zPAKL1i1sUsM=
Received: by 10.227.205.130 with SMTP id fq2mr10291192wbb.17.1323097746355;
        Mon, 05 Dec 2011 07:09:06 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id dd4sm10772157wib.1.2011.12.05.07.09.05
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 07:09:05 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 6/7] MIPS: BCM63XX: use the new bcm63xxpart parser
Date:   Mon,  5 Dec 2011 16:08:10 +0100
Message-Id: <1323097691-16414-7-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3360

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 40b223b..c223854 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -834,10 +834,13 @@ static struct mtd_partition mtd_partitions[] = {
 	}
 };
 
+static const char *bcm63xx_part_types[] = { "bcm63xxpart", NULL };
+
 static struct physmap_flash_data flash_data = {
 	.width			= 2,
 	.nr_parts		= ARRAY_SIZE(mtd_partitions),
 	.parts			= mtd_partitions,
+	.part_probe_types	= bcm63xx_part_types,
 };
 
 static struct resource mtd_resources[] = {
-- 
1.7.2.5
