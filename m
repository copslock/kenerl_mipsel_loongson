Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:52:36 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52639 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823128Ab2LZUwEHTdDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:52:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D6FD58E1C;
        Wed, 26 Dec 2012 21:52:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dWKWyJoI+WYK; Wed, 26 Dec 2012 21:51:59 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id B730A8F62;
        Wed, 26 Dec 2012 21:51:41 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] MIPS: BCM47XX: return error when init of nvram failed
Date:   Wed, 26 Dec 2012 21:51:10 +0100
Message-Id: <1356555074-1230-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This makes it possible to handle the case of not being able to read the
nvram ram. This could happen when the code searching for the specific
flash chip have not run jet.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index e19fc26..80e352e 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -23,7 +23,7 @@
 
 static char nvram_buf[NVRAM_SPACE];
 
-static void nvram_find_and_copy(u32 base, u32 lim)
+static int nvram_find_and_copy(u32 base, u32 lim)
 {
 	struct nvram_header *header;
 	int i;
@@ -49,7 +49,7 @@ static void nvram_find_and_copy(u32 base, u32 lim)
 	if (header->magic == NVRAM_HEADER)
 		goto found;
 
-	return;
+	return -ENXIO;
 
 found:
 	src = (u32 *) header;
@@ -58,10 +58,12 @@ found:
 		*dst++ = *src++;
 	for (; i < header->len && i < NVRAM_SPACE; i += 4)
 		*dst++ = le32_to_cpu(*src++);
+
+	return 0;
 }
 
 #ifdef CONFIG_BCM47XX_SSB
-static void nvram_init_ssb(void)
+static int nvram_init_ssb(void)
 {
 	struct ssb_mipscore *mcore = &bcm47xx_bus.ssb.mipscore;
 	u32 base;
@@ -72,15 +74,15 @@ static void nvram_init_ssb(void)
 		lim = mcore->pflash.window_size;
 	} else {
 		pr_err("Couldn't find supported flash memory\n");
-		return;
+		return -ENXIO;
 	}
 
-	nvram_find_and_copy(base, lim);
+	return nvram_find_and_copy(base, lim);
 }
 #endif
 
 #ifdef CONFIG_BCM47XX_BCMA
-static void nvram_init_bcma(void)
+static int nvram_init_bcma(void)
 {
 	struct bcma_drv_cc *cc = &bcm47xx_bus.bcma.bus.drv_cc;
 	u32 base;
@@ -96,38 +98,41 @@ static void nvram_init_bcma(void)
 #endif
 	} else {
 		pr_err("Couldn't find supported flash memory\n");
-		return;
+		return -ENXIO;
 	}
 
-	nvram_find_and_copy(base, lim);
+	return nvram_find_and_copy(base, lim);
 }
 #endif
 
-static void early_nvram_init(void)
+static int early_nvram_init(void)
 {
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		nvram_init_ssb();
-		break;
+		return nvram_init_ssb();
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
-		nvram_init_bcma();
-		break;
+		return nvram_init_bcma();
 #endif
 	}
+	return -ENXIO;
 }
 
 int nvram_getenv(char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
+	int err;
 
 	if (!name)
 		return -EINVAL;
 
-	if (!nvram_buf[0])
-		early_nvram_init();
+	if (!nvram_buf[0]) {
+		err = early_nvram_init();
+		if (err)
+			return err;
+	}
 
 	/* Look for name=value and return value */
 	var = &nvram_buf[sizeof(struct nvram_header)];
-- 
1.7.10.4
