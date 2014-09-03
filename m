Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 23:00:11 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35299 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007452AbaICVAFJCZVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 23:00:05 +0200
Received: by mail-wi0-f175.google.com with SMTP id ho1so1720743wib.14
        for <multiple recipients>; Wed, 03 Sep 2014 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UZYMpKHwj98SWReh0RHufjaoKQBPH8eIEHYxGGz5X9Q=;
        b=wUWfO/M6exRHiyqUo5OV8u5nOi8nbxcKnWXA3q93oe9nfeiDGAsgwnf5Sltf98ZshK
         54gxYUn7NFEsGszPJtkYnXSr0ipRz+H+Ldc/7+Fb6bSnvZVwQO5UHyEvomZQMZ9q7/yR
         y6kbiCoh7kfy2usOMI5aN4zPqzmzYeHemNtDGIvPNLheoOtmLiJOfWBsUxjtVTLdJKhj
         iFj4o4IVyYKLUfoEjhvw9GcR2G6ullqkCkKcynJsaZtU8m9gkkQEuaQZ1igRk+I6qBrM
         0B12x/Idc2d0MFZ5STjq7xhtnYRw1p1H0yNLZv3jbcbBlcawuwdwN2ak4bQ5ASX/JdaP
         KY4Q==
X-Received: by 10.180.212.110 with SMTP id nj14mr78546wic.51.1409777999874;
        Wed, 03 Sep 2014 13:59:59 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id w20sm6370051wie.7.2014.09.03.13.59.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2014 13:59:59 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V3] MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx polling it
Date:   Wed,  3 Sep 2014 22:59:45 +0200
Message-Id: <1409777985-2474-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1409744065-24334-1-git-send-email-zajec5@gmail.com>
References: <1409744065-24334-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42384
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

V2: Typo in commit message s/bcma/ssb/

V3: Put function declaration in
    arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
    (why did I miss that earlier?! Thanks Hauke)
---
 arch/mips/bcm47xx/nvram.c                          | 30 +++++++---------------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  1 +
 drivers/ssb/driver_mipscore.c                      | 14 +++++++++-
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index e07976b..fecc5ae 100644
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
 	int err;
@@ -114,25 +121,6 @@ static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
 	return err;
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
@@ -168,7 +156,7 @@ static int nvram_init(void)
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		return nvram_init_ssb();
+		break;
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
index 36a3fc1..676be22 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
@@ -32,6 +32,7 @@ struct nvram_header {
 #define NVRAM_MAX_VALUE_LEN 255
 #define NVRAM_MAX_PARAM_LEN 64
 
+int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
 extern int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len);
 
 static inline void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 0907706..7b986f9 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -15,6 +15,9 @@
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/time.h>
+#ifdef CONFIG_BCM47XX
+#include <bcm47xx_nvram.h>
+#endif
 
 #include "ssb_private.h"
 
@@ -210,6 +213,7 @@ static void ssb_mips_serial_init(struct ssb_mipscore *mcore)
 static void ssb_mips_flash_detect(struct ssb_mipscore *mcore)
 {
 	struct ssb_bus *bus = mcore->dev->bus;
+	struct ssb_sflash *sflash = &mcore->sflash;
 	struct ssb_pflash *pflash = &mcore->pflash;
 
 	/* When there is no chipcommon on the bus there is 4MB flash */
@@ -242,7 +246,15 @@ static void ssb_mips_flash_detect(struct ssb_mipscore *mcore)
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
