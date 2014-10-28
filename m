Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 13:30:40 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:63585 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011577AbaJ1MajS0XVr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 13:30:39 +0100
Received: by mail-wg0-f49.google.com with SMTP id x13so711101wgg.8
        for <multiple recipients>; Tue, 28 Oct 2014 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=UWZjI5d/BEptSEJytPhYs71CUuO9qbgS4MRHwRdKCk4=;
        b=JNkS6WKmjqKtEtXTcROORseiFAIAEJHw6EOaLk11dlU+uYNIXxX4ds6XLJld17ds81
         ltjxBBVlT1nfFWg17W2MUJbWWfz9gNW1837CdCdCWw+VuPrUXRb5G/qhZCrxxTT96yyc
         PkWx83zL3x6Hsnd94nKN5OaBY5QZK20W8xE2VR3rsA+Nq7K7dIPAVlkbSWsyX8CiD9yT
         dj5n7HPnN4ufxLWlYL44O41FgVFMmh9OJU516MwhIAFB7UdZPfTlEgi6+rwLl0w0z5cu
         LF2BhHDztmYziavlM9oICGHZVbI7tWuFHPo2w6a23FRRxOeTtM5B932VzVujkBoTOIRN
         EstQ==
X-Received: by 10.180.74.237 with SMTP id x13mr4549554wiv.6.1414499434053;
        Tue, 28 Oct 2014 05:30:34 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id ht9sm15251501wib.8.2014.10.28.05.30.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 05:30:33 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx polling it
Date:   Tue, 28 Oct 2014 13:30:23 +0100
Message-Id: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43624
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

This drops ssb/bcma dependency and will allow us to make it a standalone
driver.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
This patch depends on
[PATCH V2] MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx polling it
---
 arch/mips/bcm47xx/nvram.c  | 42 ++----------------------------------------
 drivers/bcma/driver_mips.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index fecc5ae..21712fb 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -121,48 +121,10 @@ int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
 	return err;
 }
 
-#ifdef CONFIG_BCM47XX_BCMA
-static int nvram_init_bcma(void)
-{
-	struct bcma_drv_cc *cc = &bcm47xx_bus.bcma.bus.drv_cc;
-	u32 base;
-	u32 lim;
-
-#ifdef CONFIG_BCMA_NFLASH
-	if (cc->nflash.boot) {
-		base = BCMA_SOC_FLASH1;
-		lim = BCMA_SOC_FLASH1_SZ;
-	} else
-#endif
-	if (cc->pflash.present) {
-		base = cc->pflash.window;
-		lim = cc->pflash.window_size;
-#ifdef CONFIG_BCMA_SFLASH
-	} else if (cc->sflash.present) {
-		base = cc->sflash.window;
-		lim = cc->sflash.size;
-#endif
-	} else {
-		pr_err("Couldn't find supported flash memory\n");
-		return -ENXIO;
-	}
-
-	return bcm47xx_nvram_init_from_mem(base, lim);
-}
-#endif
-
 static int nvram_init(void)
 {
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		break;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		return nvram_init_bcma();
-#endif
-	}
+	/* TODO: Look for MTD "nvram" partition */
+
 	return -ENXIO;
 }
 
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 004d6aa..8a653dc 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -20,6 +20,9 @@
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/time.h>
+#ifdef CONFIG_BCM47XX
+#include <bcm47xx_nvram.h>
+#endif
 
 enum bcma_boot_dev {
 	BCMA_BOOT_DEV_UNK = 0,
@@ -323,10 +326,16 @@ static void bcma_core_mips_flash_detect(struct bcma_drv_mips *mcore)
 	switch (boot_dev) {
 	case BCMA_BOOT_DEV_PARALLEL:
 	case BCMA_BOOT_DEV_SERIAL:
-		/* TODO: Init NVRAM using BCMA_SOC_FLASH2 window */
+#ifdef CONFIG_BCM47XX
+		bcm47xx_nvram_init_from_mem(BCMA_SOC_FLASH2,
+					    BCMA_SOC_FLASH2_SZ);
+#endif
 		break;
 	case BCMA_BOOT_DEV_NAND:
-		/* TODO: Init NVRAM using BCMA_SOC_FLASH1 window */
+#ifdef CONFIG_BCM47XX
+		bcm47xx_nvram_init_from_mem(BCMA_SOC_FLASH1,
+					    BCMA_SOC_FLASH1_SZ);
+#endif
 		break;
 	default:
 		break;
-- 
1.8.4.5
