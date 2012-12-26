Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 10:29:32 +0100 (CET)
Received: from mail-ee0-f42.google.com ([74.125.83.42]:35892 "EHLO
        mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900Ab2LZJ3bKBree (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 10:29:31 +0100
Received: by mail-ee0-f42.google.com with SMTP id c41so4067669eek.15
        for <multiple recipients>; Wed, 26 Dec 2012 01:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NcEIo+XaQoldoC1zBPxhYn/Mz9EIqeIlRUOAFa4/ea8=;
        b=ApUoELE1r96L/jyxpPdYKUNvWKYYDP+hB0Y+d7dvMPa9NklQjwv5X+waVH7JFEKwVS
         vB2ZdTP3/1yxkgm2Kj8P239S8AmRJTk4ZGmLp4uEfhyGAZgObc+X1wXyovSV9AJfEheJ
         BuPUfsaUkhxp4H10dwGiBdZ75yoH6aWu1W/kQqPu2YF7maEMB2wCyjODKvEgM/hKJ237
         pc4fwKMU4S9J+nneE91PypKzt7ppmjvid2mgLWUG/Cz2CN9CPMDEJJ3910mlO7j7JR2+
         +eLEHGpJzBY3e7yocMdFxtwDI8+/BuGhTyBB4n6pAtHLjXOikfrrW+dhZEb4cscCJcxh
         P1sA==
X-Received: by 10.14.225.194 with SMTP id z42mr68767624eep.22.1356514165703;
        Wed, 26 Dec 2012 01:29:25 -0800 (PST)
Received: from localhost.localdomain (egr183.neoplus.adsl.tpnet.pl. [83.21.81.183])
        by mx.google.com with ESMTPS id r1sm52022497eeo.2.2012.12.26.01.29.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Dec 2012 01:29:25 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: bcm47xx: separate functions finding flash window addr
Date:   Wed, 26 Dec 2012 10:29:17 +0100
Message-Id: <1356514157-7547-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Also check if parallel flash is present at all before accessing it and
add support for serial flash on BCMA bus.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c |   87 +++++++++++++++++++++++++++++++--------------
 1 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 48a4c70..6461367 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -23,39 +23,13 @@
 
 static char nvram_buf[NVRAM_SPACE];
 
-/* Probe for NVRAM header */
-static void early_nvram_init(void)
+static void nvram_find_and_copy(u32 base, u32 lim)
 {
-#ifdef CONFIG_BCM47XX_SSB
-	struct ssb_mipscore *mcore_ssb;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	struct bcma_drv_cc *bcma_cc;
-#endif
 	struct nvram_header *header;
 	int i;
-	u32 base = 0;
-	u32 lim = 0;
 	u32 off;
 	u32 *src, *dst;
 
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		mcore_ssb = &bcm47xx_bus.ssb.mipscore;
-		base = mcore_ssb->pflash.window;
-		lim = mcore_ssb->pflash.window_size;
-		break;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_cc = &bcm47xx_bus.bcma.bus.drv_cc;
-		base = bcma_cc->pflash.window;
-		lim = bcma_cc->pflash.window_size;
-		break;
-#endif
-	}
-
 	off = FLASH_MIN;
 	while (off <= lim) {
 		/* Windowed flash access */
@@ -86,6 +60,65 @@ found:
 		*dst++ = le32_to_cpu(*src++);
 }
 
+#ifdef CONFIG_BCM47XX_SSB
+static void nvram_init_ssb(void)
+{
+	struct ssb_mipscore *mcore = &bcm47xx_bus.ssb.mipscore;
+	u32 base;
+	u32 lim;
+
+	if (mcore->pflash.present) {
+		base = mcore->pflash.window;
+		lim = mcore->pflash.window_size;
+	} else {
+		pr_err("Couldn't find supported flash memory\n");
+		return;
+	}
+
+	nvram_find_and_copy(base, lim);
+}
+#endif
+
+#ifdef CONFIG_BCM47XX_BCMA
+static void nvram_init_bcma(void)
+{
+	struct bcma_drv_cc *cc = &bcm47xx_bus.bcma.bus.drv_cc;
+	u32 base;
+	u32 lim;
+
+	if (cc->pflash.present) {
+		base = cc->pflash.window;
+		lim = cc->pflash.window_size;
+#ifdef CONFIG_BCMA_SFLASH
+	} else if (cc->sflash.present) {
+		base = cc->sflash.window;
+		lim = cc->sflash.size;
+#endif
+	} else {
+		pr_err("Couldn't find supported flash memory\n");
+		return;
+	}
+
+	nvram_find_and_copy(base, lim);
+}
+#endif
+
+static void early_nvram_init(void)
+{
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		nvram_init_ssb();
+		break;
+#endif
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		nvram_init_bcma();
+		break;
+#endif
+	}
+}
+
 int nvram_getenv(char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
-- 
1.7.7
