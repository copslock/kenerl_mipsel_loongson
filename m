Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 13:05:34 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33222 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012350AbbELLFdPzDoG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 13:05:33 +0200
Received: by wgin8 with SMTP id n8so5098841wgi.0;
        Tue, 12 May 2015 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZkfY9grvJkVTt1k3DuRjTmTHK1njZsmRn4AVft+3RR0=;
        b=0gnpwV/WWb7z0yRXzSQPCzmApNMcV8ZN2KzVs/QiERF0NQGlvUNx5ObpaT4y9bjISi
         aEM1CY1eXfi/TSwgXHH6HkLRD9643LBzwKZHB52c13DimSLCga3yMMzgqhk140FR7FUs
         UhFGbhTT/0wX30GL9mJpqnKQ67BdbUvPufvp80e2Ws8sz3xpFI0LY8vZ1iYdQuBVOcsC
         lVtnjBmlT81+S9dZXvCvSiI62z5zqQzaWnU82ciBvomrFJ2YM4ut9oj4AVKlyx3LRkQU
         wadoGAwp7/g2mFeLshxOXnX7bt2mMbF3ZQwrFiydgbaCiv3Gmdwocq2NUM7tB2sO+En+
         EozA==
X-Received: by 10.180.90.236 with SMTP id bz12mr28599056wib.33.1431428730275;
        Tue, 12 May 2015 04:05:30 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id ex5sm2333305wib.2.2015.05.12.04.05.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 04:05:29 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Read board info for all bcma buses
Date:   Tue, 12 May 2015 13:05:18 +0200
Message-Id: <1431428718-7754-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47341
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

Extra bcma buses may be totally different models, see following dump:
boardtype=0x0646
pci/1/1/boardtype=0x0545
pci/2/1/boardtype=0x62b
We need to detect them properly to allow drivers apply some board
specific hacks.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/setup.c                    |  3 --
 arch/mips/bcm47xx/sprom.c                    | 42 +++++++++++++---------------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |  4 ---
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 82ff9fd..98c075f 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -206,9 +206,6 @@ void __init bcm47xx_bus_setup(void)
 		err = bcma_host_soc_init(&bcm47xx_bus.bcma);
 		if (err)
 			panic("Failed to initialize BCMA bus (err %d)", err);
-
-		bcm47xx_fill_bcma_boardinfo(&bcm47xx_bus.bcma.bus.boardinfo,
-					    NULL);
 	}
 #endif
 
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 92a6c9d..8485143 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -640,19 +640,6 @@ void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
 }
 #endif
 
-#ifdef CONFIG_BCM47XX_BCMA
-void bcm47xx_fill_bcma_boardinfo(struct bcma_boardinfo *boardinfo,
-				 const char *prefix)
-{
-	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0,
-		       true);
-	if (!boardinfo->vendor)
-		boardinfo->vendor = SSB_BOARDVENDOR_BCM;
-
-	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0, true);
-}
-#endif
-
 #if defined(CONFIG_BCM47XX_SSB)
 static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 {
@@ -707,33 +694,44 @@ static void bcm47xx_sprom_apply_prefix_alias(char *prefix, size_t prefix_size)
 
 static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
 {
-	char prefix[10];
+	struct bcma_boardinfo *binfo = &bus->boardinfo;
 	struct bcma_device *core;
+	char buf[10];
+	char *prefix;
 
 	switch (bus->hosttype) {
 	case BCMA_HOSTTYPE_PCI:
 		memset(out, 0, sizeof(struct ssb_sprom));
-		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
+		snprintf(buf, sizeof(buf), "pci/%u/%u/",
 			 bus->host_pci->bus->number + 1,
 			 PCI_SLOT(bus->host_pci->devfn));
-		bcm47xx_sprom_apply_prefix_alias(prefix, sizeof(prefix));
-		bcm47xx_fill_sprom(out, prefix, false);
-		return 0;
+		bcm47xx_sprom_apply_prefix_alias(buf, sizeof(buf));
+		prefix = buf;
+		break;
 	case BCMA_HOSTTYPE_SOC:
 		memset(out, 0, sizeof(struct ssb_sprom));
 		core = bcma_find_core(bus, BCMA_CORE_80211);
 		if (core) {
-			snprintf(prefix, sizeof(prefix), "sb/%u/",
+			snprintf(buf, sizeof(buf), "sb/%u/",
 				 core->core_index);
-			bcm47xx_fill_sprom(out, prefix, true);
+			prefix = buf;
 		} else {
-			bcm47xx_fill_sprom(out, NULL, false);
+			prefix = NULL;
 		}
-		return 0;
+		break;
 	default:
 		pr_warn("Unable to fill SPROM for given bustype.\n");
 		return -EINVAL;
 	}
+
+	nvram_read_u16(prefix, NULL, "boardvendor", &binfo->vendor, 0, true);
+	if (!binfo->vendor)
+		binfo->vendor = SSB_BOARDVENDOR_BCM;
+	nvram_read_u16(prefix, NULL, "boardtype", &binfo->type, 0, true);
+
+	bcm47xx_fill_sprom(out, prefix, false);
+
+	return 0;
 }
 #endif
 
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 8ed77f6..1461c10 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -52,10 +52,6 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
 				const char *prefix);
 #endif
-#ifdef CONFIG_BCM47XX_BCMA
-void bcm47xx_fill_bcma_boardinfo(struct bcma_boardinfo *boardinfo,
-				 const char *prefix);
-#endif
 
 void bcm47xx_set_system_type(u16 chip_id);
 
-- 
1.8.4.5
