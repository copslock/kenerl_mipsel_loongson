Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 10:33:49 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:34891
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdATJdljxpln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2017 10:33:41 +0100
Received: by mail-wm0-x244.google.com with SMTP id d140so5322054wmd.2
        for <linux-mips@linux-mips.org>; Fri, 20 Jan 2017 01:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cf6Wqyl+kdIu/IyuyIA2qGz7TzyBnmtCuQV0nUFww1M=;
        b=EJLiFvWuPggElFOclS9u2kTC0uZlONiBhOQ0wVPqnxDlAGxJPQjE33bvZ/9x0kr88/
         5M5EJcV+pQs8rCeNCk5e//f4T4g2xTuTVhZs43kbHoeWgQit4NDnlVPHA9VGA1cdyAca
         CKXYCy4wqa3Lg1ny+ljdMjul8PFEGgmza02SJmAFjgNVWjtYisxveJHjnTewnkE2Q1Ml
         qmJl2pYigDd3l8G5DBqqvce6dtiQS/iFM6MrWNy3pfzCad3KEh6hWNqo0MyAZ+mf4t2H
         grOpJnDTeGSRGgUOPTljUHBWesSKLHPFPJ7P1zDHLGUWDzgi0Dt+vC0V9vzdRFCUCyg7
         CVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cf6Wqyl+kdIu/IyuyIA2qGz7TzyBnmtCuQV0nUFww1M=;
        b=Gm7cVBiCHR9+KQJY7ZL1h7HVDGoSllp5SPkwLkTVgVFuEVoLXnIscWajSLDU581txf
         KGoQ9OfOKDsXSMYH1o6yDf4zGfXAN8f6k7typ3Rzb1rZyCYTcZRVki3h7j8OHxFcFM2X
         3viq3P3NMizc+yiiCbR1QsRA9TmiKBbUCLVgVsjynFqf2fbq19yl3xiDLxljYUUQaLMR
         EMlGv3GH/G51dPMgSgtEUPSIb4V0pwxgauN3EtGdnlhGSpgGXFeac5pBVK3JLyEN9YZ2
         8L9pfTNEC5XcFoZmBjUGx5ET0ILfLNoZOJ3ljE7S+3sLX9KR6bxB6Apni3BKZH6a+lzo
         shpg==
X-Gm-Message-State: AIkVDXITvHitnfe7FD6r+qwMhGoBqdbtwwy+DHJPt7JzDdtaHsplQGOozaehkbv+86AWsQ==
X-Received: by 10.223.143.45 with SMTP id p42mr10578653wrb.120.1484904816097;
        Fri, 20 Jan 2017 01:33:36 -0800 (PST)
Received: from serveurQA.phonesystems.net ([62.39.136.157])
        by smtp.gmail.com with ESMTPSA id z134sm4786325wmc.20.2017.01.20.01.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jan 2017 01:33:35 -0800 (PST)
From:   Sebastien Decourriere <sebtx452@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org,
        Sebastien Decourriere <sebtx452@gmail.com>
Subject: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap is enabled
Date:   Fri, 20 Jan 2017 10:33:54 +0100
Message-Id: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56429
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
This is the case with current bootloaders shuch as U-boot.

This applies only to vr9 (xrx200) rev 1.2 and ar10 (xrx300).

I have a router which uses a proprietary bootloader which keeps
the in SoC swapping enabled. The SoC in this router is a vrx200 v1.2.
In this SoC version, I can keep the in SoC swapping without any problem.

This patch replaces my previous broken patch.

Signed-off-by: Sebastien Decourriere <sebtx452@gmail.com>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  1 +
 drivers/mtd/maps/lantiq-flash.c                    | 29 +++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 17b41bb..0ed0896 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -87,6 +87,7 @@ extern __iomem void *ltq_cgu_membase;
 #define LTQ_EBU_PCC_ISTAT	0x00A0
 #define LTQ_EBU_BUSCON1		0x0064
 #define LTQ_EBU_ADDRSEL1	0x0024
+#define EBU_FLASH_ENDIAN_SWAP	0x40000000
 #define EBU_WRDIS		0x80000000
 
 /* WDT */
diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index c8febb3..8d628d2 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -113,6 +113,24 @@ ltq_mtd_probe(struct platform_device *pdev)
 	struct ltq_mtd *ltq_mtd;
 	struct cfi_private *cfi;
 	int err;
+	bool mtd_addr_swap = true;
+
+#ifdef CONFIG_SOC_TYPE_XWAY
+	/* If SoC is vr9 rev 1.2 or ar10 and EBU endian swap
+	 *  is enabled, we don't need to do software address swap
+	 */
+	if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & EBU_FLASH_ENDIAN_SWAP) {
+		switch (ltq_soc_type()) {
+		case SOC_TYPE_VR9_2:
+		case SOC_TYPE_AR10:
+			mtd_addr_swap = false;
+			break;
+		default:
+			mtd_addr_swap = true;
+			break;
+		}
+	}
+#endif
 
 	if (of_machine_is_compatible("lantiq,falcon") &&
 			(ltq_boot_select() != BS_FLASH)) {
@@ -150,7 +168,10 @@ ltq_mtd_probe(struct platform_device *pdev)
 	ltq_mtd->map->copy_from = ltq_copy_from;
 	ltq_mtd->map->copy_to = ltq_copy_to;
 
-	ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
+	if (mtd_addr_swap)
+		ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
+	else
+		ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
 	ltq_mtd->mtd = do_map_probe("cfi_probe", ltq_mtd->map);
 	ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
 
@@ -163,8 +184,10 @@ ltq_mtd_probe(struct platform_device *pdev)
 	mtd_set_of_node(ltq_mtd->mtd, pdev->dev.of_node);
 
 	cfi = ltq_mtd->map->fldrv_priv;
-	cfi->addr_unlock1 ^= 1;
-	cfi->addr_unlock2 ^= 1;
+	if (mtd_addr_swap) {
+		cfi->addr_unlock1 ^= 1;
+		cfi->addr_unlock2 ^= 1;
+	}
 
 	err = mtd_device_register(ltq_mtd->mtd, NULL, 0);
 	if (err) {
-- 
2.1.4
