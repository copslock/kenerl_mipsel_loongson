Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 13:32:30 +0200 (CEST)
Received: from mail-we0-f182.google.com ([74.125.82.182]:46588 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007901AbaICLcYxTpii (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 13:32:24 +0200
Received: by mail-we0-f182.google.com with SMTP id w62so8487070wes.27
        for <multiple recipients>; Wed, 03 Sep 2014 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=W6PX+HOmZLNf6SJOfXwdhW45o4SYOKIrPOOHgF+Tl/Q=;
        b=O66/F8xX/jAfNGzn+1qVBsc/k9fBgYoRQdaHw9ISqtSCtZysGdDqyTdAdeeZrz/gNE
         TSXiDVfK6aJQdeF0RXEG8QIJkRESUOQTHoTEELT3aBwV4oUT9tV8dLDsH5whR12TnaT4
         Pl0QWKjNzzZR8O89FTMj6VgUfaW77LvfJ1/U99VF30ecAnqhFa/wOzpG4ZyAeULKwQbA
         p78kPdwQRxkRi9MEkTwAJV5zBPGcWkrS7CC1Nn3dxWk6msbgxbD43Cd7yryIMKvmKHVn
         h7oaFQRydMQjNuHo/G2xCsukYsZUUM3C3rQRoUj75LnoZfrOec4+ZXHiE6LY43AuAjzU
         c5jA==
X-Received: by 10.180.219.37 with SMTP id pl5mr34745923wic.26.1409743939597;
        Wed, 03 Sep 2014 04:32:19 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id z5sm4154384wib.20.2014.09.03.04.32.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2014 04:32:18 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx polling it
Date:   Wed,  3 Sep 2014 13:32:06 +0200
Message-Id: <1409743926-23957-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42375
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

This makes NVRAM code less bcm47xx/ssb specific allowing it to become a
standalone driver in the future. A similar patch for bcma will follow
when it's ready.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
This patch depends on
[PATCH] MIPS: BCM47XX: Get rid of calls to KSEG1ADDR in nvram
---
 arch/mips/bcm47xx/nvram.c     | 30 +++++++++---------------------
 drivers/ssb/driver_mipscore.c | 18 +++++++++++++++++-
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 2f0a646..8ea2116 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -98,7 +98,14 @@ found:
 	return 0;
 }
 
-static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
+/*
+ * On bcm47xx we need access to the NVRAM very early, so we can't use mtd
+ * subsystem to access flash. We can't even use platform device / driver to
+ * store memory offset.
+ * To handle this we provide following symbol. It's supposed to be called as
+ * soon as we get info about flash device, before any NVRAM entry is needed.
+ */
+int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
 {
 	void __iomem *iobase;
 
@@ -109,25 +116,6 @@ static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
 	return nvram_find_and_copy(iobase, lim);
 }
 
-#ifdef CONFIG_BCM47XX_SSB
-static int nvram_init_ssb(void)
-{
-	struct ssb_mipscore *mcore = &bcm47xx_bus.ssb.mipscore;
-	u32 base;
-	u32 lim;
-
-	if (mcore->pflash.present) {
-		base = mcore->pflash.window;
-		lim = mcore->pflash.window_size;
-	} else {
-		pr_err("Couldn't find supported flash memory\n");
-		return -ENXIO;
-	}
-
-	return bcm47xx_nvram_init_from_mem(base, lim);
-}
-#endif
-
 #ifdef CONFIG_BCM47XX_BCMA
 static int nvram_init_bcma(void)
 {
@@ -163,7 +151,7 @@ static int nvram_init(void)
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		return nvram_init_ssb();
+		break;
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 0907706..c51802f 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -207,9 +207,17 @@ static void ssb_mips_serial_init(struct ssb_mipscore *mcore)
 		mcore->nr_serial_ports = 0;
 }
 
+/* bcm47xx_nvram isn't a separated driver yet and doesn't have its own header.
+ * Once we make it a standalone driver, remove following extern!
+ */
+#ifdef CONFIG_BCM47XX
+extern int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
+#endif
+
 static void ssb_mips_flash_detect(struct ssb_mipscore *mcore)
 {
 	struct ssb_bus *bus = mcore->dev->bus;
+	struct ssb_sflash *sflash = &mcore->sflash;
 	struct ssb_pflash *pflash = &mcore->pflash;
 
 	/* When there is no chipcommon on the bus there is 4MB flash */
@@ -242,7 +250,15 @@ static void ssb_mips_flash_detect(struct ssb_mipscore *mcore)
 	}
 
 ssb_pflash:
-	if (pflash->present) {
+	if (sflash->present) {
+#ifdef CONFIG_BCM47XX
+		bcm47xx_nvram_init_from_mem(sflash->window, sflash->size);
+#endif
+	} else if (pflash->present) {
+#ifdef CONFIG_BCM47XX
+		bcm47xx_nvram_init_from_mem(pflash->window, pflash->window_size);
+#endif
+
 		ssb_pflash_data.width = pflash->buswidth;
 		ssb_pflash_resource.start = pflash->window;
 		ssb_pflash_resource.end = pflash->window + pflash->window_size;
-- 
1.8.4.5
